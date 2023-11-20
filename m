Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136697F109E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjKTKmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjKTKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:10:48 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D78BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:10:43 -0800 (PST)
X-UUID: 984443e7e52e4e7ea55d7af04e6cf775-20231120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:10eff87f-4dd0-4b25-bfed-ddd5d1487e70,IP:10,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:10eff87f-4dd0-4b25-bfed-ddd5d1487e70,IP:10,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:41e4da72-1bd3-4f48-b671-ada88705968c,B
        ulkID:231120181031BR35XHST,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 984443e7e52e4e7ea55d7af04e6cf775-20231120
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1484711159; Mon, 20 Nov 2023 18:10:29 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     kunwu.chan@hotmail.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] iommu/vt-d: Set variable intel_dirty_ops to static
Date:   Mon, 20 Nov 2023 18:10:25 +0800
Message-Id: <20231120101025.1103404-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the followng warning:
drivers/iommu/intel/iommu.c:302:30: warning: symbol
 'intel_dirty_ops' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3531b956556c..68e4d4006300 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -299,7 +299,7 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_AZALIA		4
 
 const struct iommu_ops intel_iommu_ops;
-const struct iommu_dirty_ops intel_dirty_ops;
+static const struct iommu_dirty_ops intel_dirty_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
@@ -4925,7 +4925,7 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	return 0;
 }
 
-const struct iommu_dirty_ops intel_dirty_ops = {
+static const struct iommu_dirty_ops intel_dirty_ops = {
 	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
 	.read_and_clear_dirty = intel_iommu_read_and_clear_dirty,
 };
-- 
2.34.1

