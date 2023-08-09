Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04C877666F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHIR1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjHIR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:27:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143788E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:27:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230809172745euoutp02bd3f1f1d4995224f4e60c2be5943f753~5xx2_5kqY0470804708euoutp02B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:27:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230809172745euoutp02bd3f1f1d4995224f4e60c2be5943f753~5xx2_5kqY0470804708euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691602065;
        bh=r06de4D63b8frXEVcw+XDAi4mGuA65SoHz+XltAyTVg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Uz5r8N5lxNXlr89ZEVDT50eFUyu9KwrFyelf/dBHUiCJEGwue7YqvvBsADTJvVkVV
         pf9RWXB9URfQulEU7ZEsXGGKyND7wr79EiOzczeJ0YQe3jrL9U667BrMGLVCRyA6jo
         L7Ouc1A6pfsdDk97NY1zRl8MMHrKDseJgKsfOQYo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230809172744eucas1p185e8257402a48f5756571be6ffdcf30d~5xx2A0Dpp1100311003eucas1p1T;
        Wed,  9 Aug 2023 17:27:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2B.9A.37758.09CC3D46; Wed,  9
        Aug 2023 18:27:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230809172744eucas1p2ebe6dcda40499c179dcf4985eb809c69~5xx1ku8WZ2535725357eucas1p2d;
        Wed,  9 Aug 2023 17:27:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230809172744eusmtrp1e121bf93f9ab11162a8ad9e5c34de8fd~5xx1kLTZd1719717197eusmtrp1m;
        Wed,  9 Aug 2023 17:27:44 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-79-64d3cc90bfbd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.70.10549.F8CC3D46; Wed,  9
        Aug 2023 18:27:44 +0100 (BST)
Received: from AMDC4653.eu.corp.samsungelectronics.net (unknown
        [106.120.51.32]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230809172743eusmtip134542942e78838a37e440e559a135d52~5xx1IP4TL0594805948eusmtip1k;
        Wed,  9 Aug 2023 17:27:43 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Date:   Wed,  9 Aug 2023 19:27:37 +0200
Message-Id: <20230809172737.3574190-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7oTzlxOMTjQI2sxZ/0aNotNj6+x
        WlzeNYfN4tDUvYwWa4/cZbc4sn47k8XvH3PYHNg9Ll+7yOyxeYWWx6ZVnWweJ2b8ZvHYvKTe
        o2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDJ2T5/AXLBWqOJGyxOWBsa9/F2MHBwSAiYS99/Z
        djFycQgJrGCUePWggxnC+cIoceX5XyjnM6NEw5R7jF2MnGAdR/ZvYYdILGeUWHO+GaqqlUni
        952nTCBVbAKGEl1vu9hAbBEBN4kbjR1MIEXMAtcYJbbvmsQMslxYIFaiaws3SA2LgKrElcZV
        rCA2r4C9xOZbDUwQ2+Ql9h88ywwRF5Q4OfMJC4jNDBRv3jobbLGEwBYOiRfvP7JDNLhITL10
        mgXCFpZ4dXwLVFxG4vTkHhaIhnZGiQW/7zNBOBOAnnt+C+o5a4k7536xgVzHLKApsX6XPkTY
        UeLCyg1skBDjk7jxVhDiCD6JSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBC2h8SXD0/BFgkB
        vd788j7bBEaFWUhem4XktVkINyxgZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmHxO
        /zv+dQfjilcf9Q4xMnEwHmKU4GBWEuG1Db6UIsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/Zk
        spBAemJJanZqakFqEUyWiYNTqoHJnetEyIQnLZ5r51R6r1jbpfTyzcnP1h819zyakrRbr/2x
        xYrFnDtXiCj/XTc7bZKyk7LljmeNPXqVG00rso+tvjKv4tD+dfr6Wz482m5/fMPa7MfsQfML
        9sgGXL++IlXq3zK2M8HtspdOrpw2i03o9N6iRZ1R9jaZ+7f8UsjN/Jhw/YZA8gnpTVOMf/5f
        rXFt06nboq3q0txS0z7UvTrOvvDKicTwMznTd3vmSO99GWbpZHXtp7vnTMlH2byzpf0vHV2U
        J7y92M/VLN7DxoNTfrblvT8MD/rEHCatPf+IpTHr/VSrR9fmxrc936ged/G3yZ5+SWGTVZoW
        X9lE09buckmImFJlE9KUuOFzaWCGuRJLcUaioRZzUXEiADg7IeWtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xu7oTzlxOMdh3gMlizvo1bBabHl9j
        tbi8aw6bxaGpexkt1h65y25xZP12JovfP+awObB7XL52kdlj8wotj02rOtk8Tsz4zeKxeUm9
        R9+WVYwenzfJBbBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZk
        lqUW6dsl6GXsnj6BuWCtUMWNlicsDYx7+bsYOTkkBEwkjuzfwt7FyMUhJLCUUeJ3/zE2iISM
        xMlpDawQtrDEn2tdbBBFzUwSC46sYARJsAkYSnS97QJrEBHwkGj7d48ZpIhZ4BajxITt79hB
        EsIC0RIHDq5hAbFZBFQlrjSuApvKK2AvsflWAxPEBnmJ/QfPMkPEBSVOznwCVs8MFG/eOpt5
        AiPfLCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSG/bZjPzfvYJz36qPeIUYm
        DsZDjBIczEoivLbBl1KEeFMSK6tSi/Lji0pzUosPMZoC3TeRWUo0OR8YeXkl8YZmBqaGJmaW
        BqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUxG/8zc9h8o3Xj/58PcR3vvr2aYd6X3
        EYtt0f7qvoWvFeo371yssX+h5f0nnybrH/5i4+eZV83HYzV/4qtE5wMek9O2PDerqpgfmXSF
        O+7lhF/v5M/+VRN8yh93KpvJ6N2Vs9/eeU9YmrQ5Z/MpZoYA/RRT5Qx3kZ1BS1arf/fyCN9R
        fT6s4x7jlwiRY4vmn64+eeu5Q+HHVflCEUmrj669eFWl/qv50pNbvLb9ebJaxKXEsINhyye9
        3vvl59edX/mv7fY692Pvf/Cqb63zl34+p+ibfPePcJnELSpcfLPl/69aa/Rb2nnrrCcnnpmX
        H5x/xHaHmOldps82vk1bJwvvf2Visazh1drTZivW33ov0qzEUpyRaKjFXFScCADL0YX9BAMA
        AA==
X-CMS-MailID: 20230809172744eucas1p2ebe6dcda40499c179dcf4985eb809c69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230809172744eucas1p2ebe6dcda40499c179dcf4985eb809c69
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230809172744eucas1p2ebe6dcda40499c179dcf4985eb809c69
References: <CGME20230809172744eucas1p2ebe6dcda40499c179dcf4985eb809c69@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The D-cache cleaning loop should not call folio_next() beyond the
requested region and rely on its parameters. Simply stop looping if left
counter reaches zero.

This fixes the following endless loop observed by RCU stall on the ARM
32bit Exynos5422-based Odroid-XU3lite board:

--->8---
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:     0-....: (27320 ticks this GP) idle=e414/1/0x40000002 softirq=36/36 fqs=13044
rcu:     (t=27385 jiffies g=-1067 q=34 ncpus=8)
CPU: 0 PID: 93 Comm: kworker/0:1H Not tainted 6.5.0-rc5-next-20230807 #6981
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: mmc_complete mmc_blk_mq_complete_work
PC is at _set_bit+0x28/0x44
LR is at __dma_page_dev_to_cpu+0xdc/0x170
..
 _set_bit from __dma_page_dev_to_cpu+0xdc/0x170
 __dma_page_dev_to_cpu from dma_direct_unmap_sg+0x100/0x130
 dma_direct_unmap_sg from dw_mci_post_req+0x68/0x6c
 dw_mci_post_req from mmc_blk_mq_post_req+0x34/0x100
 mmc_blk_mq_post_req from mmc_blk_mq_complete_work+0x50/0x60
 mmc_blk_mq_complete_work from process_one_work+0x20c/0x4d8
 process_one_work from worker_thread+0x58/0x54c
 worker_thread from kthread+0xe0/0xfc
 kthread from ret_from_fork+0x14/0x2c
--->8---

While touching this code, move the set_bit() operation, which deals with
atomics, a bit up in the call chain. The new order helps a bit compiler
to produce code computing folio_size() only once.

Fixes: cc24e9c0895c ("arm: implement the new page table range API")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- changed the code and explaiation as suggested by Russell and Matthew

v1:
- https://lore.kernel.org/all/20230807152657.1692414-1-m.szyprowski@samsung.com/
---
 arch/arm/mm/dma-mapping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 70cb7e63a9a5..0474840224d9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -719,8 +719,10 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 		}
 
 		while (left >= (ssize_t)folio_size(folio)) {
-			set_bit(PG_dcache_clean, &folio->flags);
 			left -= folio_size(folio);
+			set_bit(PG_dcache_clean, &folio->flags);
+			if (!left)
+				break;
 			folio = folio_next(folio);
 		}
 	}
-- 
2.34.1

