Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772E57CDEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjJRONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjJROMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C57182;
        Wed, 18 Oct 2023 07:12:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8419C433CC;
        Wed, 18 Oct 2023 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638328;
        bh=Z4Z6qL3iUhpQY0amYZyPG4/P9y3MDWFvSaNBkmYYyQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpHAEHm8oTyM/596MeHbpHljivRJZ80m3Vp2hEIxjYUOsZDfjL9zwkkl1X7sbtRl+
         ZtD55VvaV5TRZKSwkM1zbf92XW06XT2jVPcM5xJ0LvRyd3PGWuyNlev+gZDWc6ED1w
         j/PjcnfGCIUeB/YcriwSfHJuDemtRgEfsoslLO+D7vSZam+lAiUXNqImbIkLjds/yh
         NVWBlF8lBExWykcHP4Xpa5TTgbPFnh3gG/74bdZoOuMJmggTQ0u/oeGx5CFnPbihQb
         EM+TIq/6A+D8jjcqqCI861Z52ByJYTbmT3PDLWdoI97hMuM9bFpsgXvhZjg7hym7yq
         suTUA6sWeyrgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 05/31] coresight: tmc-etr: Disable warnings for allocation failures
Date:   Wed, 18 Oct 2023 10:11:22 -0400
Message-Id: <20231018141151.1334501-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit e5028011885a85032aa3c1b7e3e493bcdacb4a0a ]

Running the following command on Juno triggers the warning:

 $ perf record -e cs_etm// -m ,128M ...

 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 412 at mm/page_alloc.c:4453 __alloc_pages+0x334/0x1420
 CPU: 1 PID: 412 Comm: perf Not tainted 6.5.0-rc3+ #181
 Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Feb  1 2019
 pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __alloc_pages+0x334/0x1420
 lr : dma_common_alloc_pages+0x108/0x138
 sp : ffffffc087fb7440
 x29: ffffffc087fb7440 x28: 0000000000000000 x27: ffffffc07e48fba0
 x26: 0000000000000001 x25: 000000000000000f x24: ffffffc081f24880
 x23: 0000000000000cc0 x22: ffffff88012b6f08 x21: 0000000008000000
 x20: ffffff8801433000 x19: 0000000000000000 x18: 0000000000000000
 x17: ffffffc080316e5c x16: ffffffc07e46406c x15: ffffffc0803af580
 x14: ffffffc08036b460 x13: ffffffc080025cbc x12: ffffffb8108c3fc4
 x11: 1ffffff8108c3fc3 x10: 1ffffff810ff6eac x9 : 00000000f204f204
 x8 : 000000000000f204 x7 : 00000000f2f2f2f2 x6 : 00000000f3f3f3f3
 x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000cc0 x1 : 0000000000000000 x0 : ffffffc085333000
 Call trace:
  __alloc_pages+0x334/0x1420
  dma_common_alloc_pages+0x108/0x138
  __dma_alloc_pages+0xf4/0x108
  dma_alloc_pages+0x18/0x30
  tmc_etr_alloc_flat_buf+0xa0/0x190 [coresight_tmc]
  tmc_alloc_etr_buf.constprop.0+0x124/0x298 [coresight_tmc]
  alloc_etr_buf.constprop.0.isra.0+0x88/0xc8 [coresight_tmc]
  tmc_alloc_etr_buffer+0x164/0x2f0 [coresight_tmc]
  etm_setup_aux+0x32c/0x520 [coresight]
  rb_alloc_aux+0x29c/0x3f8
  perf_mmap+0x59c/0xce0
  mmap_region+0x340/0x10e0
  do_mmap+0x48c/0x580
  vm_mmap_pgoff+0x160/0x248
  ksys_mmap_pgoff+0x1e8/0x278
  __arm64_sys_mmap+0x8c/0xb8

With the flat mode, we only attempt to allocate large memory if there is an IOMMU
connected to the ETR. If the allocation fails, we always have a fallback path
and return an error if nothing else worked. So, suppress the warning for flat
mode allocations.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lore.kernel.org/r/20230817161951.658534-1-suzuki.poulose@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 66dc5f97a0098..c8df8719f6a08 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -610,7 +610,8 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 
 	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
 						&flat_buf->daddr,
-						DMA_FROM_DEVICE, GFP_KERNEL);
+						DMA_FROM_DEVICE,
+						GFP_KERNEL | __GFP_NOWARN);
 	if (!flat_buf->vaddr) {
 		kfree(flat_buf);
 		return -ENOMEM;
-- 
2.40.1

