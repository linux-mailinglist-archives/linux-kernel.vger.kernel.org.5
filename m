Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A657CA473
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjJPJol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:44:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FD97;
        Mon, 16 Oct 2023 02:44:38 -0700 (PDT)
Date:   Mon, 16 Oct 2023 09:44:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697449476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZ41LTcQ/jhuvm71U7Pu2C5REKXKw1uT35nBnDHvCi0=;
        b=f8Sx9bhieAcZyI5hq4fhl7cuSmF9vLGDtZFIINgWszInLTzC/pHyCgkrMWBt3YvHYri/UQ
        Zy+ihVWq7sm8tY/lFxgL+R61QVrH4Ho0xYabvvdNUCHIxRPP+rIy8QCTLxTl5Y7gLootYn
        HNxSd5qwqtc/QxFonAK9//XEUw8oXSFtElEsQiJZ8L6M8dPNOwldqr9JPTbHGmc6GmqYEt
        uc1XwEx+o4q831QoIu/bqREiUWx6qmZBCZbBTbh78lhh1d9XfAvUMAApIIwgx6hOiM53F6
        Sz1uG8bA6sBUWd9ro6Vh8R9l9CLpKtPCUfmD8a2dbGXEn8aRthgLovnQPEvdgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697449476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZ41LTcQ/jhuvm71U7Pu2C5REKXKw1uT35nBnDHvCi0=;
        b=YOzmN1AeiqI03bRgedwEgMEnFx/eR/QGwRsv0tHSAPG0/kavTeLjFo7GnD967fJAU6Ns9z
        J21pziET1LAWDyAw==
From:   "tip-bot2 for Binbin Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/x86/lam: Zero out buffer for readlink()
Cc:     Binbin Wu <binbin.wu@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231016062446.695-1-binbin.wu@linux.intel.com>
References: <20231016062446.695-1-binbin.wu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169744947512.3135.5098809828724848406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     29060633411a02f6f2dd9d5245919385d69d81f0
Gitweb:        https://git.kernel.org/tip/29060633411a02f6f2dd9d5245919385d69d81f0
Author:        Binbin Wu <binbin.wu@linux.intel.com>
AuthorDate:    Mon, 16 Oct 2023 14:24:46 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 11:39:57 +02:00

selftests/x86/lam: Zero out buffer for readlink()

Zero out the buffer for readlink() since readlink() does not append a
terminating null byte to the buffer.  Also change the buffer length
passed to readlink() to 'PATH_MAX - 1' to ensure the resulting string
is always null terminated.

Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20231016062446.695-1-binbin.wu@linux.intel.com
---
 tools/testing/selftests/x86/lam.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index eb0e469..8f9b06d 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -573,7 +573,7 @@ int do_uring(unsigned long lam)
 	char path[PATH_MAX] = {0};
 
 	/* get current process path */
-	if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+	if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
 		return 1;
 
 	int file_fd = open(path, O_RDONLY);
@@ -680,14 +680,14 @@ static int handle_execve(struct testcases *test)
 		perror("Fork failed.");
 		ret = 1;
 	} else if (pid == 0) {
-		char path[PATH_MAX];
+		char path[PATH_MAX] = {0};
 
 		/* Set LAM mode in parent process */
 		if (set_lam(lam) != 0)
 			return 1;
 
 		/* Get current binary's path and the binary was run by execve */
-		if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
+		if (readlink("/proc/self/exe", path, PATH_MAX - 1) <= 0)
 			exit(-1);
 
 		/* run binary to get LAM mode and return to parent process */
