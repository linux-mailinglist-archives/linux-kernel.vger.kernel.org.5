Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3F7935D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbjIFHC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjIFHCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:02:25 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B9E52
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:02:20 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RgYGJ4r1Jz9srY;
        Wed,  6 Sep 2023 09:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1693983736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+k6V4wqFBDUDmAoXXrgivFUiDnLDqDPZixBVs4Okvc0=;
        b=axjflxjjQczY8egvFtzzgesPxnSG7/OdfTxt1w+gRuqEQlDkl2JT7E87FOvC2NkU1HDkRI
        VJiseGMcOZmgF9C8fTugmODhsAkGgU6eCc/5AjVtN78+CUdvPe/gx1+oncm8wGZOpeGXZD
        lsS6mfWiF939YuO2xzXdlPVEBDH3LczRl4/WwMwjP7H4zYkwwcbtvRnhx8gPCoM7nnUsCR
        95m+Jsx0OxMQoQepURR0MN/yh8USZIFqDZ8jN5nWRyghaM4XmjJsI7vW/BZUZGFJFxzufF
        f/ERqSQiNWigESMW2Edt86WEzBCPW0pXzAcVRS+ftvl7ukrLlu5mwKeNtCh08Q==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Wed, 06 Sep 2023 17:02:06 +1000
Subject: [PATCH] memfd: drop warning for missing exec-related flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-memfd-reduce-spam-v1-1-1f0d35facd95@cyphar.com>
X-B4-Tracking: v=1; b=H4sIAO0j+GQC/x3MQQ5AMBBG4avIrE1SBOUqYkH7l1kUaUMk4u4ay
 2/x3kMRQRCpzx4KuCTKviUUeUZmnbYFLDaZSlVWqlMNe3hnOcCeBhyPybNutXZGzV1dgFJ3BDi
 5/+cwvu8HzWgnpmMAAAA=
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Damian Tometzki <dtometzki@fedoraproject.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=/VYfd7Di0058KXgnpDZddvw9amq+11iEgviQ8j3mDio=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaT8UP7ke1mce8aJR8pOrj82Kj9gsVOZ3FrsYyo7xbvcK
 9J92+57HaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiSzczMlx6xZdaVcfxxsbF
 J+V2SWl6ncbK7Q5fTRb4H8qbplyZpMfwP37uhNqcH2ZJyVtl/SpCZNPDZF18m5iEcufHc0letl7
 HDAA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4RgYGJ4r1Jz9srY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 434ed3350f57 ("memfd: improve userspace warnings for missing
exec-related flags") attempted to make these warnings more useful (so
they would work as an incentive to get users to switch to specifying
these flags -- as intended by the original MFD_NOEXEC_SEAL patchset).
Unfortunately, it turns out that even INFO-level logging is too extreme
to enable by default and alternative solutions to the spam issue (such
as doing more extreme rate-limiting per-task) are either too ugly or
overkill for something as simple as emitting a log as a developer aid.

Given that the flags are new and there is no harm to not specifying them
(after all, we maintain backwards compatibility) we can just drop the
warnings for now until some time in the future when most programs have
migrated and distributions start using vm.memfd_noexec=1 (where failing
to pass the flag would result in unexpected errors for programs that use
executable memfds).

Fixes: 434ed3350f57 ("memfd: improve userspace warnings for missing exec-related flags")
Reported-by: Damian Tometzki <dtometzki@fedoraproject.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 mm/memfd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 1cad1904fc26..d3a1ba4208c9 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -315,12 +315,6 @@ SYSCALL_DEFINE2(memfd_create,
 	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
 		return -EINVAL;
 
-	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_info_ratelimited(
-			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
-			current->comm, task_pid_nr(current));
-	}
-
 	error = check_sysctl_memfd_noexec(&flags);
 	if (error < 0)
 		return error;

---
base-commit: 2374b401b0e0b9ab6d91eead30f9a049f8d620cf
change-id: 20230906-memfd-reduce-spam-8788fc0b951e

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

