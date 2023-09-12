Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071479D560
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjILPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjILPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:54:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2B10DE;
        Tue, 12 Sep 2023 08:54:22 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694534061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gdctCp4SB36RtTArjia2PAFFd/hzfAhFlWhKyRt4ni0=;
        b=4ak7XDCQveLQNiye5/EFV0t4h1EVQr4JGhhjZwLqmwQjOmGDzioY987orEK8dVlckgWKy2
        bxrXOUyopU+ToDpeSCzT1ldnHL5XjKelkxmgpwmr1jBvzrfY+UYPrgGHKYdepy/r4Dx7aW
        w2VkkZumKdYDa57hJW8i80c12kWa6PsaRoMFRhrg8AnPWQPR5NEfj72w6Q5R1t8T4/fX9M
        xanp2dcPfo67kkuIoomNgjs/ynczMJ7UUt8yTEcqqGzOo/uxJ5HAYpSQHfmZ5l29SjlF8a
        Pss4uXtpQw57tt9IAGakhmD1HfFyclLfeWTLo+XZE9e/DWbn+jSBwoYp/VSbCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694534061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gdctCp4SB36RtTArjia2PAFFd/hzfAhFlWhKyRt4ni0=;
        b=83DKNWiHCE6ZB+nNAqskUSnsI+zKRXn4+vZClhWKdv1UGxuCp3BQT8y0ScRCj0cRmoJQoA
        /AH2fDV60fVl2hCA==
From:   "tip-bot2 for Shuai Xue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Bail out early if the request AUX area is
 out of bound
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453406074.27769.6203574670118288482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     54aee5f15b83437f23b2b2469bcf21bdd9823916
Gitweb:        https://git.kernel.org/tip/54aee5f15b83437f23b2b2469bcf21bdd9823916
Author:        Shuai Xue <xueshuai@linux.alibaba.com>
AuthorDate:    Thu, 07 Sep 2023 08:43:07 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Sep 2023 17:46:31 +02:00

perf/core: Bail out early if the request AUX area is out of bound

When perf-record with a large AUX area, e.g 4GB, it fails with:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

and it reveals a WARNING with __alloc_pages():

	------------[ cut here ]------------
	WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
	Call trace:
	 __alloc_pages+0x1ec/0x248
	 __kmalloc_large_node+0xc0/0x1f8
	 __kmalloc_node+0x134/0x1e8
	 rb_alloc_aux+0xe0/0x298
	 perf_mmap+0x440/0x660
	 mmap_region+0x308/0x8a8
	 do_mmap+0x3c0/0x528
	 vm_mmap_pgoff+0xf4/0x1b8
	 ksys_mmap_pgoff+0x18c/0x218
	 __arm64_sys_mmap+0x38/0x58
	 invoke_syscall+0x50/0x128
	 el0_svc_common.constprop.0+0x58/0x188
	 do_el0_svc+0x34/0x50
	 el0_svc+0x34/0x108
	 el0t_64_sync_handler+0xb8/0xc0
	 el0t_64_sync+0x1a4/0x1a8

'rb->aux_pages' allocated by kcalloc() is a pointer array which is used to
maintains AUX trace pages. The allocated page for this array is physically
contiguous (and virtually contiguous) with an order of 0..MAX_ORDER. If the
size of pointer array crosses the limitation set by MAX_ORDER, it reveals a
WARNING.

So bail out early with -ENOMEM if the request AUX area is out of bound,
e.g.:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index fb1e180..e8d82c2 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -700,6 +700,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		watermark = 0;
 	}
 
+	/*
+	 * kcalloc_node() is unable to allocate buffer if the size is larger
+	 * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
+	 */
+	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
+		return -ENOMEM;
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
 				     node);
 	if (!rb->aux_pages)
