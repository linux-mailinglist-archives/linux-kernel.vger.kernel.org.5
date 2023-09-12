Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F404879CFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjILLX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjILLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:23:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F710D3;
        Tue, 12 Sep 2023 04:23:48 -0700 (PDT)
Date:   Tue, 12 Sep 2023 11:23:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694517827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6PiqN2K3v8IIK3V3vNQ8NFt+Swhjx2M2ymJcTSULjBY=;
        b=Dypx/JwZIdE3523pACeviKC1MqW1nlFEgkm0PRjQqnXnSRWLGFCPj8amkxNxYBgVfXh8KY
        I2Vvctatycctdr/oCnLS5Gg5hBhUhjV+4ZVnMu6enn9DsD4K3tS75ACCunMayN4C9LBsdB
        HrXSW+d2NwFM2g7TpH4R/XHsswYrT00I3Jq/51QuGzs2hEgHG5rlwhXd11b+Ybhic6tdoZ
        Kao8BJTzSVIjur8OItUwjmcLOySOPFd8NpenJNvyct/4KaV6MBOdR0SUL49gXMZjqN4/SA
        lK2KIMJ8cq7LnIepWVoFkOheRikDolS9PAKBpJwlgI2aLb8RkzPuBONZhg9cXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694517827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6PiqN2K3v8IIK3V3vNQ8NFt+Swhjx2M2ymJcTSULjBY=;
        b=IndVRyFTsIIy75wKHv4medtJK/HasXfPg+csEBbRsUiIGC4CcvmTpeifNPOYP5nV+k9cA3
        KaiG1OMSI4fI+PBQ==
From:   "tip-bot2 for Shuai Xue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Bail out early if the request AUX area is
 out of bound
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451782647.27769.8900757532660376606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4ce2c8701989c4995c6d54b99630c005c74f0280
Gitweb:        https://git.kernel.org/tip/4ce2c8701989c4995c6d54b99630c005c74f0280
Author:        Shuai Xue <xueshuai@linux.alibaba.com>
AuthorDate:    Thu, 07 Sep 2023 08:43:07 +08:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Tue, 12 Sep 2023 12:40:57 +02:00

perf/core: Bail out early if the request AUX area is out of bound

When perf-record with a large AUX area, e.g 4GB, it fails with:

    #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
    failed to mmap with 12 (Cannot allocate memory)

and it reveals a WARNING with __alloc_pages():

[   66.595604] ------------[ cut here ]------------
[   66.600206] WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
[   66.608375] Modules linked in: ip6table_filter(E) ip6_tables(E) iptable_filter(E) ebtable_nat(E) ebtables(E) aes_ce_blk(E) vfat(E) fat(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sm4_ce_cipher(E) sm4(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) acpi_ipmi(E) sbsa_gwdt(E) sg(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ip_tables(E) sd_mod(E) ast(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme(E) sysimgblt(E) i2c_algo_bit(E) nvme_core(E) drm_shmem_helper(E) ahci(E) t10_pi(E) libahci(E) drm(E) crc64_rocksoft(E) i40e(E) crc64(E) libata(E) i2c_core(E)
[   66.657719] CPU: 44 PID: 17573 Comm: perf Kdump: loaded Tainted: G            E      6.3.0-rc4+ #58
[   66.666749] Hardware name: Default Default/Default, BIOS 1.2.M1.AL.P.139.00 03/22/2023
[   66.674650] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   66.681597] pc : __alloc_pages+0x1ec/0x248
[   66.685680] lr : __kmalloc_large_node+0xc0/0x1f8
[   66.690285] sp : ffff800020523980
[   66.693585] pmr_save: 000000e0
[   66.696624] x29: ffff800020523980 x28: ffff000832975800 x27: 0000000000000000
[   66.703746] x26: 0000000000100000 x25: 0000000000100000 x24: ffff8000083615d0
[   66.710866] x23: 0000000000040dc0 x22: ffff000823d6d140 x21: 000000000000000b
[   66.717987] x20: 000000000000000b x19: 0000000000000000 x18: 0000000000000030
[   66.725108] x17: 0000000000000000 x16: ffff800008f05be8 x15: ffff000823d6d6d0
[   66.732229] x14: 0000000000000000 x13: 343373656761705f x12: 726e202c30206574
[   66.739350] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff8000083af570
[   66.746471] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
[   66.753592] x5 : 0000000000000000 x4 : ffff000823d6d8d8 x3 : 0000000000000000
[   66.760713] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
[   66.767834] Call trace:
[   66.770267]  __alloc_pages+0x1ec/0x248
[   66.774003]  __kmalloc_large_node+0xc0/0x1f8
[   66.778259]  __kmalloc_node+0x134/0x1e8
[   66.782081]  rb_alloc_aux+0xe0/0x298
[   66.785643]  perf_mmap+0x440/0x660
[   66.789031]  mmap_region+0x308/0x8a8
[   66.792593]  do_mmap+0x3c0/0x528
[   66.795807]  vm_mmap_pgoff+0xf4/0x1b8
[   66.799456]  ksys_mmap_pgoff+0x18c/0x218
[   66.803365]  __arm64_sys_mmap+0x38/0x58
[   66.807187]  invoke_syscall+0x50/0x128
[   66.810922]  el0_svc_common.constprop.0+0x58/0x188
[   66.815698]  do_el0_svc+0x34/0x50
[   66.818999]  el0_svc+0x34/0x108
[   66.822127]  el0t_64_sync_handler+0xb8/0xc0
[   66.826296]  el0t_64_sync+0x1a4/0x1a8
[   66.829946] ---[ end trace 0000000000000000 ]---

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
