Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F067945F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbjIFWFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjIFWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:05:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C73199B;
        Wed,  6 Sep 2023 15:05:29 -0700 (PDT)
Date:   Wed, 06 Sep 2023 22:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694037928;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m7/fUUpYqFk4M/8PGlLLkdCItc/Hb8xKEbbgT9CcLlc=;
        b=omoJepwEIOPqXQs4qZ+rqM/grNNdfUOFNrpRQwOZPU6cEdXMVwwd+qwBM+7afMqyfgD2yY
        HbxLioeVKmBNFYATsFKf1qucfTuuCm4nCxKzvPS59tarfAeSDJCBQlcXksYQDNoRsdELA8
        HlY3A1G+8AOUmAf7I83pvEPQJmzx7e0pgDNVVM+4aW56FTHkIIobD9eqlUBCHJVgcFhIlM
        VCtBqbaI+tQmJlxqtoDWF9bu8gisjPmTg7ahrHCNy7vUIsYKlAUPQil18B/n3lnMA2ytK0
        L+UpJd5BoZvHywuV7YU51Po9IOtg4qqZTchoRsFRUlc7nZ9BTCF1N3eITEOY2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694037928;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m7/fUUpYqFk4M/8PGlLLkdCItc/Hb8xKEbbgT9CcLlc=;
        b=bzrWn7qLnqw+w/JgdtHnpHrsAqDgvKNbEsC4Db/zrRetNLN4PsvypNImWfxqwDaq4J6V9Z
        S/7qh6bg5wkufHAA==
From:   "tip-bot2 for Jack Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Break up long non-preemptible delays in
 sgx_vepc_release()
Cc:     Yu Zhang <yu.zhang@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169403792746.27769.2304744998713665329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3d7d72a34e05b23e21bafc8bfb861e73c86b31f3
Gitweb:        https://git.kernel.org/tip/3d7d72a34e05b23e21bafc8bfb861e73c86b31f3
Author:        Jack Wang <jinpu.wang@ionos.com>
AuthorDate:    Wed, 06 Sep 2023 15:17:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 06 Sep 2023 23:55:09 +02:00

x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()

On large enclaves we hit the softlockup warning with following call trace:

	xa_erase()
	sgx_vepc_release()
	__fput()
	task_work_run()
	do_exit()

The latency issue is similar to the one fixed in:

  8795359e35bc ("x86/sgx: Silence softlockup detection when releasing large enclaves")

The test system has 64GB of enclave memory, and all is assigned to a single VM.
Release of 'vepc' takes a longer time and causes long latencies, which triggers
the softlockup warning.

Add cond_resched() to give other tasks a chance to run and reduce
latencies, which also avoids the softlockup detector.

[ mingo: Rewrote the changelog. ]

Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
Reported-by: Yu Zhang <yu.zhang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Yu Zhang <yu.zhang@ionos.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/sgx/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index c3e37ea..7aaa365 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -204,6 +204,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			continue;
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -222,6 +223,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			list_add_tail(&epc_page->list, &secs_pages);
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -243,6 +245,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 
 		if (sgx_vepc_free_page(epc_page))
 			list_add_tail(&epc_page->list, &secs_pages);
+		cond_resched();
 	}
 
 	if (!list_empty(&secs_pages))
