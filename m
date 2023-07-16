Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0843E754D5F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 06:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGPEzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 00:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGPEzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 00:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559471729;
        Sat, 15 Jul 2023 21:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E423C60BEC;
        Sun, 16 Jul 2023 04:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851DBC433C9;
        Sun, 16 Jul 2023 04:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689483314;
        bh=CWreJj6196A69WyJRrKOoOx4omYd+vJKVHjI+WSeFoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omul4q+XHnqo5WmJYpu//KpZAybkqoWrhQrvNFC9LNh6Al1Rtltg/77na567wg6uf
         mF1yq2VgvVFEngkm8Gzn2anA5Z6b3e03ftLTNL6WWOLgUSPm5/8NH6pTQaDzBcwBcX
         ZlLjFbpz8O/kSxfMCRLgU6Sw6/dT2xA4vU44UJMzmn/MIq5oDbs4EPufboYUYjHEG4
         f3JDowOhmVrSBvbjAFxIL1xKFyF/IqVaKB0P+OCeSaxOQD2Z6ru2M9PONDEuTMla+Y
         c7I3RNrz94/6XoUU2TAyFdKFkx/cMJW/hDYvHQfpbCaD9Mmso8P8g7ojkWJ7RbY8xp
         B7znk97OhBx6A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] kconfig: menuconfig: remove jump_key::index
Date:   Sun, 16 Jul 2023 13:55:08 +0900
Message-Id: <20230716045508.402399-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230716045508.402399-1-masahiroy@kernel.org>
References: <20230716045508.402399-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to remember the index of each jump key because you can
count it up after a key is pressed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Jesse Taube <Mr.Bossman075@gmail.com>
---

(no changes since v1)

 scripts/kconfig/expr.h  | 1 -
 scripts/kconfig/mconf.c | 7 ++++---
 scripts/kconfig/menu.c  | 8 --------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 9c9caca5bd5f..4a9a23b1b7e1 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -275,7 +275,6 @@ struct jump_key {
 	struct list_head entries;
 	size_t offset;
 	struct menu *target;
-	int index;
 };
 
 extern struct file *file_list;
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 15b88921fe6a..eccc87a441e7 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -22,8 +22,6 @@
 #include "lkc.h"
 #include "lxdialog/dialog.h"
 
-#define JUMP_NB			9
-
 static const char mconf_readme[] =
 "Overview\n"
 "--------\n"
@@ -402,18 +400,21 @@ static int handle_search_keys(int key, size_t start, size_t end, void *_data)
 {
 	struct search_data *data = _data;
 	struct jump_key *pos;
+	int index = 0;
 
 	if (key < '1' || key > '9')
 		return 0;
 
 	list_for_each_entry(pos, data->head, entries) {
+		index = next_jump_key(index);
+
 		if (pos->offset < start)
 			continue;
 
 		if (pos->offset >= end)
 			break;
 
-		if (key == '1' + (pos->index % JUMP_NB)) {
+		if (key == index) {
 			data->target = pos->target;
 			return 1;
 		}
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index d2f0a8efabb5..61c442d84aef 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -735,15 +735,7 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 	}
 	if (head && location) {
 		jump = xmalloc(sizeof(struct jump_key));
-
 		jump->target = location;
-
-		if (list_empty(head))
-			jump->index = 0;
-		else
-			jump->index = list_entry(head->prev, struct jump_key,
-						 entries)->index + 1;
-
 		list_add_tail(&jump->entries, head);
 	}
 
-- 
2.39.2

