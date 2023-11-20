Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40847F15F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjKTOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKTOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:44:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FCA4;
        Mon, 20 Nov 2023 06:44:20 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:44:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700491459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnRXy1yVWCfRsNPkXtlfyjrD/wRceMj0d6uDTf+ma9g=;
        b=0BlJ6M8fsA1cn0Saynwt3eMvOQxRRBkHxrCXEd6vWQ4O3Uk9fHbtr64pdPk99rdpHCZqAQ
        aVO+1QGeIw6fvXD1rlAg6EtFbqZdPkpAf1Zh8wJL8w4atSc7BDVQz5tCDfs1CmEHdexqAx
        A08cv8RQRfL1ft+ioZZAvhMuVvHoK6AWRH+SO6WUVJCuBkbn5svhB5aeRZuOOZTTuClyQb
        OX6m56y8hiIo2Oeb+5WLWpbyVWWZzB15rJACYN4NCyKlTel1gVibTMJwj2Fjamx4G/usta
        iFhvS1/2E9PxqHqlPbtlHO3XjFx4kPPTyj1+Z29aCpSZFs5AfdNqdqPTVO5BQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700491459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnRXy1yVWCfRsNPkXtlfyjrD/wRceMj0d6uDTf+ma9g=;
        b=/mKtkhSn9YyfjlpsCgPUYDdjiJZn+YNDOZdtk/QosgHQ1NN6ZEnpdi1fl8Mgu3nYsCM6KT
        BpIOeoccBYBEIuDw==
From:   "tip-bot2 for Sam James" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix calloc call for new -Walloc-size
Cc:     Sam James <sam@gentoo.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231107205504.1470006-1-sam@gentoo.org>
References: <20231107205504.1470006-1-sam@gentoo.org>
MIME-Version: 1.0
Message-ID: <170049145878.398.18419078180350195785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e2e13630f93d942d02f3b3f98660228a3545c60e
Gitweb:        https://git.kernel.org/tip/e2e13630f93d942d02f3b3f98660228a354=
5c60e
Author:        Sam James <sam@gentoo.org>
AuthorDate:    Tue, 07 Nov 2023 20:55:00=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Nov 2023 10:54:50 +01:00

objtool: Fix calloc call for new -Walloc-size

GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
like:
```
check.c: In function =E2=80=98cfi_alloc=E2=80=99:
check.c:294:33: error: allocation of insufficient size =E2=80=981=E2=80=99 fo=
r type =E2=80=98struct cfi_state=E2=80=99 with size =E2=80=98320=E2=80=99 [-W=
error=3Dalloc-size]
  294 |         struct cfi_state *cfi =3D calloc(sizeof(struct cfi_state), 1);
      |                                 ^~~~~~
```

The calloc prototype is:
```
void *calloc(size_t nmemb, size_t size);
```

So, just swap the number of members and size arguments to match the prototype=
, as
we're initialising 1 struct of size `sizeof(struct ...)`. GCC then sees we're=
 not
doing anything wrong.

Signed-off-by: Sam James <sam@gentoo.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20231107205504.1470006-1-sam@gentoo.org
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e94756e..548ec3c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -291,7 +291,7 @@ static void init_insn_state(struct objtool_file *file, st=
ruct insn_state *state,
=20
 static struct cfi_state *cfi_alloc(void)
 {
-	struct cfi_state *cfi =3D calloc(sizeof(struct cfi_state), 1);
+	struct cfi_state *cfi =3D calloc(1, sizeof(struct cfi_state));
 	if (!cfi) {
 		WARN("calloc failed");
 		exit(1);
