Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81187E7E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjKJRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjKJRl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5542C3E;
        Fri, 10 Nov 2023 09:05:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9F88B1F8BD;
        Fri, 10 Nov 2023 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699635916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N53A1y0Jr8OxUW9POOJ+wwsplLhd7v++YACla5XuUwE=;
        b=b/aFKANMsgmPrkb8UudWyFf0Y37BgEKe6iILm4m9mY9pWjN1W50NpINtfQ20FahOVXyBG/
        L+MynoEFybrOHRmN4toDBEfro+B5fsn6HKgMuAJ5I4z6k4n2WuVv+sXs6Pxubjd0iWIV6a
        jLQfUZeOaX6/1Z170mVGwcqAl6r0Pho=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 471292C4C5;
        Fri, 10 Nov 2023 17:05:16 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [POC 2/7] livepatch: Allow to handle lifetime of shadow variables using the livepatch state
Date:   Fri, 10 Nov 2023 18:04:23 +0100
Message-Id: <20231110170428.6664-3-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231110170428.6664-1-pmladek@suse.com>
References: <20231110170428.6664-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of the lifetime of the shadow variables is not easy
when the atomic replace is used. The new patch does not know
if a shadow variable has already been used by the previous livepatch.
Or if there is a shadow variable which will not longer be used.

Shadow variables are almost always used together with callbacks.
At least @post_unpatch callback is used to free not longer used shadow
variables. And sometimes @post_patch and @pre_unpatch callbacks
are used to enable or disable the use of the shadow variables.
It is needed when the shadow variable can be used only when
the entire system is able to handle them.

All this gets even more complicated because the original callbacks
are called only from the new livepatch when atomic replace is used.
Newly created livepatches might be able to handle obsolete shadow
variables so the upgrade would work. But older livepatches do not know
anything about later introduced shadow variables. They might leak
during downgrade. And they might contain outdated information when
another upgrade would start using them again.

All problems are better solved with the new callbacks associated with
a livepatch state. They are called when the state is first introduced
and when it gets obsolete. Also the callbacks are called from the patch
where the state was supported. So that even downgrade might be safe.

Let's make it official. A shadow variable might be associated with
a livepatch state by setting the new "state.is_shadow" flag and
using the same "id" in both struct klp_shadow and struct klp_state.

The shadow variable will then have the same lifetime as the livepatch
state. It allows to free obsolete shadow variables automatically
without the need to add a callback.

The generic callback will free the shadow variables using
state->callbacks.shadow_dtor callback when provided.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/livepatch.h | 15 ++++++++++-----
 kernel/livepatch/state.c  | 14 ++++++++++----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index c2a39e5f5b66..189ec7c6a89f 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -132,12 +132,18 @@ struct klp_object {
 struct klp_patch;
 struct klp_state;
 
+typedef int (*klp_shadow_ctor_t)(void *obj,
+				 void *shadow_data,
+				 void *ctor_data);
+typedef void (*klp_shadow_dtor_t)(void *obj, void *shadow_data);
+
 /**
  * struct klp_state_callbacks - callbacks manipulating the state
  * @setup:	executed before code patching when the state is added
  * @enable:	executed after code patching when the state is added
  * @disable:	executed before code unpatching when the state is removed
  * @release:	executed after code unpatching when the state is removed
+ * @shadow_dtor: destructor for the related shadow variable
  * @setup_succeeded: internal state used by a rollback on error
  *
  * All callbacks are optional.
@@ -152,6 +158,7 @@ struct klp_state_callbacks {
 	void (*enable)(struct klp_patch *patch, struct klp_state *state);
 	void (*disable)(struct klp_patch *patch, struct klp_state *state);
 	void (*release)(struct klp_patch *patch, struct klp_state *state);
+	klp_shadow_dtor_t shadow_dtor;
 	bool setup_succeeded;
 };
 
@@ -160,12 +167,15 @@ struct klp_state_callbacks {
  * @id:		system state identifier (non-zero)
  * @version:	version of the change
  * @callbacks:	optional callbacks used when introducing or removing the state
+ * @is_shadow:  the state handles lifetime of a shadow variable
+ *		with the same @id
  * @data:	custom data
  */
 struct klp_state {
 	unsigned long id;
 	unsigned int version;
 	struct klp_state_callbacks callbacks;
+	bool is_shadow;
 	void *data;
 };
 
@@ -240,11 +250,6 @@ static inline bool klp_have_reliable_stack(void)
 	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
 }
 
-typedef int (*klp_shadow_ctor_t)(void *obj,
-				 void *shadow_data,
-				 void *ctor_data);
-typedef void (*klp_shadow_dtor_t)(void *obj, void *shadow_data);
-
 void *klp_shadow_get(void *obj, unsigned long id);
 void *klp_shadow_alloc(void *obj, unsigned long id,
 		       size_t size, gfp_t gfp_flags,
diff --git a/kernel/livepatch/state.c b/kernel/livepatch/state.c
index 6693d808106b..4ec65afe3a43 100644
--- a/kernel/livepatch/state.c
+++ b/kernel/livepatch/state.c
@@ -198,11 +198,17 @@ void klp_release_states(struct klp_patch *patch)
 		if (is_state_in_other_patches(patch, state))
 			continue;
 
-		if (!state->callbacks.release)
-			continue;
-
-		if (state->callbacks.setup_succeeded)
+		if (state->callbacks.release && state->callbacks.setup_succeeded)
 			state->callbacks.release(patch, state);
+
+		if (state->is_shadow)
+			klp_shadow_free_all(state->id, state->callbacks.shadow_dtor);
+
+		/*
+		 * The @release callback is supposed to restore the original
+		 * state before the @setup callback was called.
+		 */
+		state->callbacks.setup_succeeded = 0;
 	}
 }
 
-- 
2.35.3

