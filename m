Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9967579B586
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjIKUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbjIKPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:17:43 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A1120
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:17:38 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Rkr1R6YYfz9sc8;
        Mon, 11 Sep 2023 17:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1694445451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gY1nJx3RoS2vF3Fjoh906DwAWSZVPbGDZF1f+ci7yuU=;
        b=STZMS4oF8i173H/rhhw6vbnQpSH8bsbHV+rUfblRBQ++BF5/jsY0XoSPWjed4KDW/2GqGo
        NteyTTl/MvlahVTfYgdIY3MO+7uCq4eBy1rU+Ff9Ez1+K9ObvuqrBHm1a3ZtJ5AJMTG6HI
        8WVEbVhDl5lnMckLuA8u2PyWIv7LwQkItLr0sCoPRSm5RiiLNVyE24RM/NsmruwPTwfVaP
        W2mwXueTX/2iffaaEtBomYHBOIo45mpX20MCx+5EIr+HQ5aNeHwusJlCI76kHbtyK8SNsn
        1xI9C0fPqcb7aubN/WHNMX9cGo0TrFzCvy6Cf7LPQpA6jWr9FOqIXG3RPiNkiQ==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Tue, 12 Sep 2023 01:17:20 +1000
Subject: [PATCH v2] memfd: drop warning for missing exec-related flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-memfd-reduce-spam-v2-1-7d92a4964b6a@cyphar.com>
X-B4-Tracking: v=1; b=H4sIAH8v/2QC/32NQQ7CIBREr9L8tRhKg4Kr3sN0gfARFhQCSmwa7
 i72AGZWb5J5s0PB7LHAbdghY/XFx7UDOw2gnVqfSLzpDIyyiUp6IQGDNSSjeWskJalAxFUIq+l
 D8hGh71JG6z+H8750dr68Yt6Oizr+2n+2OpIeS83ErdJG8llvyal81jHA0lr7AkWNKjuzAAAA
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Damian Tometzki <dtometzki@fedoraproject.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=JMf8ODyrCEKqTx+r6DrssdOGDQzj1OoZpTMr8v6gUPg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaT812/NzvC+oX0z6/9M/u2/D9zunjHJ5VNhs1rEfMF42
 7ZzmzgOd5SyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJnFvI8Id3znQWUalHR5ba
 no8SL2xY61H5J8BxcfvBoKoP5bseOuUwMkw9KytlmxX5U5VNLCF43STZJcq/7zos89OU4Umsjng
 QyAMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4Rkr1R6YYfz9sc8
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
Fixes: 2562d67b1bdf ("revert "memfd: improve userspace warnings for missing exec-related flags".")
Reported-by: Damian Tometzki <dtometzki@fedoraproject.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- rebase on top mm-stable (in particular, commit 2562d67b1bdf)
- v1: <https://lore.kernel.org/r/20230906-memfd-reduce-spam-v1-1-1f0d35facd95@cyphar.com>
---
 mm/memfd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 2dba2cb6f0d0..d3a1ba4208c9 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -315,12 +315,6 @@ SYSCALL_DEFINE2(memfd_create,
 	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
 		return -EINVAL;
 
-	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_warn_once(
-			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
-			current->comm, task_pid_nr(current));
-	}
-
 	error = check_sysctl_memfd_noexec(&flags);
 	if (error < 0)
 		return error;

---
base-commit: 6bc660278f11970e7c0c349f66c693e5dc5d85b6
change-id: 20230906-memfd-reduce-spam-8788fc0b951e

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

