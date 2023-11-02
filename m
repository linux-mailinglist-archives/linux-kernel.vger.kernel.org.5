Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE47DF323
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347429AbjKBNCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBNCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:02:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF792FB;
        Thu,  2 Nov 2023 06:02:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6AE201F8C8;
        Thu,  2 Nov 2023 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698930126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nwOAu+lvDKzMgzPr8m1BY5NSLiFclCMWdwSry0oMoMQ=;
        b=d5vhxMYvPTW6u7j/olDef3dOle+DhmrULu1M0lAstoMmV+ZsdiD8j4j03gEpbMhPRPv6Lo
        6/Uz6kqZfJDWB7+T82ab+9ARKGgx5Fqrq+6v8QwMH8aOdqRn2LSQcrBcMiu4NMcPKZ23Gh
        n0llD+JxFPkggRxYt4S3/u0EAj7v6QM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02AE813584;
        Thu,  2 Nov 2023 13:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CZivOc2dQ2XQWgAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Thu, 02 Nov 2023 13:02:05 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] docs: Remove reference to syscall trampoline in PTI
Date:   Thu,  2 Nov 2023 15:02:04 +0200
Message-Id: <20231102130204.41043-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
removed the syscall trampoline and instead opted to enable using the
default syscall64 entry point by mapping the percpu TSS. Unfortunately
the PTI documentation wasn't updated when the respective changes were
made, so let's bring the doc up to speed.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/arch/x86/pti.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/pti.rst b/Documentation/arch/x86/pti.rst
index 4b858a9bad8d..e08d35177bc0 100644
--- a/Documentation/arch/x86/pti.rst
+++ b/Documentation/arch/x86/pti.rst
@@ -81,11 +81,9 @@ Protection against side-channel attacks is important.  But,
      and exit (it can be skipped when the kernel is interrupted,
      though.)  Moves to CR3 are on the order of a hundred
      cycles, and are required at every entry and exit.
-  b. A "trampoline" must be used for SYSCALL entry.  This
-     trampoline depends on a smaller set of resources than the
-     non-PTI SYSCALL entry code, so requires mapping fewer
-     things into the userspace page tables.  The downside is
-     that stacks must be switched at entry time.
+  b. Percpu TSS is mapped into the user page tables to allow SYSCALL64 path
+     to work under PTI. This doesn't have a direct runtime cost but it can
+     be argued it opens certain timing attack scenarios.
   c. Global pages are disabled for all kernel structures not
      mapped into both kernel and userspace page tables.  This
      feature of the MMU allows different processes to share TLB
@@ -167,7 +165,7 @@ that are worth noting here.
  * Failures of the selftests/x86 code.  Usually a bug in one of the
    more obscure corners of entry_64.S
  * Crashes in early boot, especially around CPU bringup.  Bugs
-   in the trampoline code or mappings cause these.
+   in the mappings cause these.
  * Crashes at the first interrupt.  Caused by bugs in entry_64.S,
    like screwing up a page table switch.  Also caused by
    incorrectly mapping the IRQ handler entry code.
--
2.34.1

