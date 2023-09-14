Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7879FD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjINHlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjINHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:41:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD11BF7;
        Thu, 14 Sep 2023 00:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjTF9aq6V7ITVGi+r4b8IH+uV51XgtYjXGJK8FxedF+hYEzYMFza6bRknViBgtv6/Xr+0o0872gymQbLX45wZTPa+70vL24oIvBxVm07l95xnq5SfLZCs5UAZSoGWdJjdGMXAUS+ogBJRgyMTpUUcRMiGF26oLR8Zl/Ntx6dl5a/cKZYTax3diFHm46vel7098jy7C7pzflpG4YGWFgGoNPv6S2sK0eiyiU4WrNKICLBBBiDN6Pln2hNzkn79zlDCAvHXJXGFfFZnRNir2v0ZU+iQPg9aWJhJFFmgiH/mABNqnC5Ywxmg/RIxAbknKhcDUpvvFqPp5i4hLoy7Dz2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqoEmKCwYX+pTFmaq/yoiztvbdaFKDmWIxoHlHBpgfE=;
 b=UzuhdEbvpSwrhcfJuirbIhhW1Uon8Nk4UMYgE95tZMpkzwOwvJCj0gtAnP525T+1wNiJIJf2h9jH8s968W1Ao/T5+vR/ONFwZmG5zuiGznfhmtqyM/K0kkuEwVyLbuH+s0DTwP3/zQc8Jnm9es5yKNOKI2ojWfqs9RA0tM2FXlLVe42ZnK72GAk++AmJM0qODAPKBXvcVBZ68PXaUTnaJ2CnlBNK/iKufjsY8nWbr4WFdDoMyhyxfvk6hkkDWOF2MBT38IVf+UiX04cMtmA4cZ6+uHJyrY/IbLXk77SPqgICtO8i9MWfGBFxWrsWPf5kBA9Hiimkv25WslvQt5D0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqoEmKCwYX+pTFmaq/yoiztvbdaFKDmWIxoHlHBpgfE=;
 b=szR03IsM8SxbzgCPcHI2vASpYQKjTczd0zWzUPOCyDgniwjT+lPOcsHOCva3fDQT0PS/LD8qrITXw6bXLr8SffPqCuSbwKuKnWtMvKia0AwdVFD0QruUFs5VEBpLR8CJOcfaZ/zv8hWAWZzdXwm6mTNpF41aCQaAidvWOfBBFww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM9PR04MB8454.eurprd04.prod.outlook.com (2603:10a6:20b:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:41:42 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 07:41:42 +0000
From:   Fang Hui <hui.fang@nxp.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        anle.pan@nxp.com, xuegang.liu@nxp.com
Subject: [PATCH] MA-21654 Use dma_alloc_pages in vb2_dma_sg_alloc_compacted
Date:   Thu, 14 Sep 2023 22:58:12 +0800
Message-Id: <20230914145812.12851-1-hui.fang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To DB9PR04MB9284.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9284:EE_|AM9PR04MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: a12b7282-768c-4f15-5c45-08dbb4f609e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH3n/EmcB7XGVQU/kNMHCN1nsXDg8rl8lV1wsmWWwSFx5bdlHOfOcr/hH+/T0tEWWK8kuMduXCaTm1eQiuo6bi3vrYQfWH1owTiSmUxHYuPJcjLjuSU7K/4DrSvVydoPfW08bxEdSBrbq/AHeBDt8zlD2YNwvS4EFvresUem6kCxRg/UpWABCQeUzFTTnkQjvNFAwk/iyr3jsnozco9n0PbjXxMtJ09mJdaSNDKfgSJL7UP8Jf2gaRJ1hdLdHpsgKXRC5vsv9DUcyb4ZJ+0ObmVC372cASeqxryPFPh8vDbYXgUpCxsXO3lU0I4v5I4x+aBPM1RDtLrqxIQY9XbEprHABXsly3WGyl1by1tjE52+piY7MHgiCFkJUSOZ0kUYELTSzk6mcgVLFa7ZBHSsmGjS0Yvzo6bH8QWyfGTzZs2dsjAS5JXJ+W+JbTMQJVbFgxSHY4I90Wd++CvEHFaCDx2by42VSa9I2qeNXBH7CsLH4GW2+q2kFLmyHDErXzuhYqsYMdmYufA8jGLjKpecdEIQFUbajzxBioxbqaPrVj0j4bQCgWcy0J5+h6NKvXC+plhVkO+PP+PQGmuttwVWHcWQkFsz8H6gukcVVH5VX+aZgpxrpIfPc1Bi4HnqeULA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(26005)(478600001)(2616005)(2906002)(1076003)(6512007)(52116002)(6486002)(6506007)(6666004)(5660300002)(66476007)(4326008)(66556008)(66946007)(8936002)(86362001)(316002)(8676002)(41300700001)(36756003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEXL+YfaeMxAzhA2zr1loQvwZEzKTYKrjFBhwxbVPauKzZaHKoW9ORyC4USv?=
 =?us-ascii?Q?nmsKuD2vU1r7cleRie9RdWIeptP2Aw397sBPqa43mn+7mOOgxnWBsw9v9daN?=
 =?us-ascii?Q?Y40qZ5ob9Up2XGdzDWPFQeM8kXE779oRwUvLkAaP6Dp3/AgZwfjCe4wS/52V?=
 =?us-ascii?Q?ON6XYwkM+r6f6+K//w9mh5iQP1uegc+EJqrOOuQtXcBKECc4Sk4t7FycZ9xK?=
 =?us-ascii?Q?/VEVWHLtA7vgra2k9iEvoXH7B/1/NGbbfn6/3sXHGWqnTSRBKEtBlOqkE9v3?=
 =?us-ascii?Q?HFnq6KWeGz+4n0S+P1jrVob5lJ5PMc3DJIb+cEmDPu6r3tVY7hvcRWkTIS2L?=
 =?us-ascii?Q?KVR1qlr+0OIlQxFDEpZ73163lIioly17GEW5H9MKkh3XQjzU9CGyXXo6UzKY?=
 =?us-ascii?Q?Rz54wfv+N5dcK8SY+vXDU1FMUYGxPxnxilLHw+HJGuDZLzRUOIwhcfJUViYz?=
 =?us-ascii?Q?3vJbAH+hTpIOph98bCU5X84C3Z3AFb9yC7MXnrWazUKsWdn2sXbbujUPoAPq?=
 =?us-ascii?Q?t0Dg0mE95j70ztmiBVdvmAyCO9Em2JhOKveWlYmFiJ/5hhRyBbpPcrXSI8N0?=
 =?us-ascii?Q?b62zEpZIXFAHBMi7xyUiIjW6CHRwWsM4jAE6yOhOgpjCAwn+nxPE4Ck4Epoj?=
 =?us-ascii?Q?DQ8CsILZH3EpFTjAv6GLpzkjwXhJX0/EACx+g+4a+6NkjBgMZCGveY42kKG5?=
 =?us-ascii?Q?Pds8yzn4SSxDGATFBstfcVNaIQQf9dMj3rTn2hzpgoBbJ4Fw4VZatmWvGk+q?=
 =?us-ascii?Q?Jp76RMxnBOz/ejOppmjQyKARuZn0T0u157Cfm1dbWGVursHxzOV+rJl2CU4h?=
 =?us-ascii?Q?A1H2blHgGQVSAvAEGWnrMuKGpqkMTX1YffqYHW5SV/qIMv9wP+DN+ZlN97b8?=
 =?us-ascii?Q?IsJuUeg03tZcVqqZ+fLqGB7geNHc0gmWWxJQbzOroJPoaMGfugrf0NUxGcZG?=
 =?us-ascii?Q?+ZB0JP0+qTqrFMDr2xJzKUx+9T9j5cHahJeUgpgB0Ldmvw1LauC1Lg9ThZUa?=
 =?us-ascii?Q?mOSD0zaRhLzZvRmWQVDlB9vTeQ5GAztCFEXfSY1Ug+Rq/+tl/kLsK8lbCUrX?=
 =?us-ascii?Q?SjCbVAa/O+VilmvfK0/4JRX92rGoC0aiOK3M/TQ89UG3CVj3/ePxy3XaCmAx?=
 =?us-ascii?Q?BI7/lgaEVhuHgfipoOasXRcx2M2S4Nco8CgSRF9+vomnZQeUZTMxUxMa33jI?=
 =?us-ascii?Q?VxO+8UieJ+G6nqOFcqrNxaHmA/t3L8r0Ubes7j9ATJNmH3dIxHxIpx1xVj/U?=
 =?us-ascii?Q?muYPZGzKGXVgTSsefdQ86TyckMSt5Pmi9p5yr2UaAt/t78bM3E3qo5o+RiQP?=
 =?us-ascii?Q?eNkkv7hgM6gtmhNf2VuAujpNpU9U31FOSmM5ljsf/qkQZiXTJl5dYMXJ4aUT?=
 =?us-ascii?Q?+c865zfVBGQs7HPn3uP5P6kAeoNAsFb+/dy383cr0/as6IfD83Xvno8HVV1B?=
 =?us-ascii?Q?0ZW4r6YdVAzfJ6GS16uef5yOObzCnJCSYDNOVO32aBzLLIpykfJ2T3sKzB/3?=
 =?us-ascii?Q?yaSucY3OfMQejJ8r/70hoLPyb5j70crJbCdC9SaoUfNZgq/GDQXRr3XEYYfL?=
 =?us-ascii?Q?vtokvbd+hoWZ00XbrQLWvUPHfdHGUmY1trSHgxDm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12b7282-768c-4f15-5c45-08dbb4f609e8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:41:42.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okgPG/v45Kc+MRL7dDVPF5c+CVhCjiFvwt8tBi60UBejmmeaLoneeWlcVEWpcE2SqzoldlCoL1jcCEBCI4xERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8454
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On system with "CONFIG_ZONE_DMA32=y", if the allocated physical address is
greater than 4G, swiotlb will be used. It will lead below defects.
1) Impact performance due to an extra memcpy.
2) May meet below error due to swiotlb_max_mapping_size()
   is 256K (IO_TLB_SIZE * IO_TLB_SEGSIZE).
"swiotlb buffer is full (sz: 393216 bytes), total 65536 (slots),
used 2358 (slots)"

To avoid those defects, use dma_alloc_pages() instead of alloc_pages()
in vb2_dma_sg_alloc_compacted().

Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Fang Hui <hui.fang@nxp.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 28f3fdfe23a2..b938582c68f4 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -58,7 +58,7 @@ struct vb2_dma_sg_buf {
 static void vb2_dma_sg_put(void *buf_priv);
 
 static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
-		gfp_t gfp_flags)
+		gfp_t gfp_flags, struct device *dev)
 {
 	unsigned int last_page = 0;
 	unsigned long size = buf->size;
@@ -67,6 +67,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
 		struct page *pages;
 		int order;
 		int i;
+		dma_addr_t dma_handle;
 
 		order = get_order(size);
 		/* Don't over allocate*/
@@ -75,8 +76,9 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
 
 		pages = NULL;
 		while (!pages) {
-			pages = alloc_pages(GFP_KERNEL | __GFP_ZERO |
-					__GFP_NOWARN | gfp_flags, order);
+			pages = dma_alloc_pages(dev, PAGE_SIZE << order, &dma_handle,
+				DMA_BIDIRECTIONAL,
+				GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | gfp_flags);
 			if (pages)
 				break;
 
@@ -96,6 +98,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
 	}
 
 	return 0;
+
 }
 
 static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
@@ -130,7 +133,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
 	if (!buf->pages)
 		goto fail_pages_array_alloc;
 
-	ret = vb2_dma_sg_alloc_compacted(buf, vb->vb2_queue->gfp_flags);
+	ret = vb2_dma_sg_alloc_compacted(buf, vb->vb2_queue->gfp_flags, dev);
 	if (ret)
 		goto fail_pages_alloc;
 
-- 
2.17.1

