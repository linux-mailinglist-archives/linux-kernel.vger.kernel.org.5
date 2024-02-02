Return-Path: <linux-kernel+bounces-50042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE5847392
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCB11F2913A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFF1474D6;
	Fri,  2 Feb 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j8gFWkl0"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAA14690D;
	Fri,  2 Feb 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888564; cv=fail; b=hFqsaNCnxX/DNtJCIvbianvILq2aOnZ/knE7MKwzLyzo8El00GOwvpjJExySd6cIOo6p+xh8Z+jDSauIggmy0F9mXkirc8fSOf386uw+ccz64b7y2JglAi7l/ip/2fBszYHgA8knBZRqYxVEAMMCEEvmNN1tE41dZT1VnL2HHTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888564; c=relaxed/simple;
	bh=ZVkt3JRVj4oqGl9FqwohEjcseYFWK4/w54reTUQix8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMsBIPpQs8cRRci7hUOS4Z9mEKyTFuDN2+bmeGY6UE7clWDHRKgYbanBKNcRBOsqe621iwp3JYlIdz+o2FLbMJn4sdcccjbhj0K+i5dfLyVx/Hto6StF4HF1DJW00WynGrma9Ha+wGFleYACjEz6Bp4qva5wfWOkm2FnXGsS5l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j8gFWkl0; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV4ExnH5JT6viiN1EltDIeUReJvE5F55T5N9tev5A2qBGTSiNWV1jOiMCJQS4QpcDP/ZTovvRDR5IPE1djYD28bZSjadiYL7T6MrNGvQdJDtBxYFqmiZCB+PnrIsX1ZvYNkQLGIHWpNfS94zx4dGhRol7G7zlKxVsjbiz6qMQj73vjF/4bXmRuoIcFRvuvLasKqnO1lG24xbAYcQcKcXnciQ1ju7syATasfHEfsavGBQXHPnF6/E2205uXjWCi/wBvLdqnMbRN7QnZmdJGMUsXD0YH2ry9jefxlbdF1CwGpDG8bY6nJ26UXq2Lxcd3LzI0YESoeiDofhPURfH1J0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpcePnpOAqcw4rGrDwPN0NuwX62GVRdoRYtmCz6eTv8=;
 b=dCodJoVQaQ4akmsv+BGctxrSuOYxmvKAdCsQh0Ol3BDeXhShCoql2fOPc+2kgxoWrP9RVx3mAOwHiRdwXLqZN5ieHFfoOW+t5eLp8b6sweK8hf0PEkorG26dfPX32TmW83c531r6U9Yfnk68q8J22jhyM9nyBHTf4xkEfaoOXnwO644CvSdgNpoq2H3XUiPEGvGeNxhgo43iEvyuAfKS7ORypaShf6CKxqKz6GTBROLQxAtYc69lP5MN7IKqF5D/+L+YKA5JF2T8fNqGW/Nk3eg4yPPjmW2eA68tSV/XSqNk+e6ooXF1Lc/rG7zjonZ7fMyJL2LHeb1IOehHTyji/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpcePnpOAqcw4rGrDwPN0NuwX62GVRdoRYtmCz6eTv8=;
 b=j8gFWkl0MbBmq08bAycdP1PJC8sVD5iMShbCF7wzy5xzDnigJIi5iYv9lpwborvT+E98EB+A1vp/ty6SQoEhsQqrxHw8Fm+6DGcgK64U1SZt6fwLOWjFNOd6sFZ+oozOY9IMnFLqy5G/pHayYm72+FeJYn9RDDeHQkBsIuW17DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB10008.eurprd04.prod.outlook.com (2603:10a6:102:38b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 15:42:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:42:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: rogerq@kernel.org
Cc: Frank.Li@nxp.com,
	felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org
Subject: [PATCH v2 2/2] usb: cdns3: fix memory double free when handle zero packet
Date: Fri,  2 Feb 2024 10:42:17 -0500
Message-Id: <20240202154217.661867-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202154217.661867-1-Frank.Li@nxp.com>
References: <20240202154217.661867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB10008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7883ed-0d09-4b4f-47dc-08dc2405966b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hOgIqxs28aHMDjiIfT4WoNFOSsfSAFbCUuefcc4yLvCI+wRPh/ddKBA8XJ988dvMnAANWwiMEFPSolpm5+uP3R7wF5S5i9xQutj9NpCcSt60MM9cbKdY55OhRkxZN2/YYpY9zUJeNuDYuqooa3xE1DqG9Y6+18ueuI8xNrskJutvPjyrTEPaU44L0ZIPINEwP1J8+2mMl/ZzihJmfpsUVVJvDVDNjQLZ9rQFDWqqaEJcB+hxPel2TQ0kWFETaamDW8+zfMtQUIutuVayVZ5hPtamoXi9xaFReoVtmoJOsy/gbgmKHYZU/RRT0JnW/08DqDXPWfiv9GPO6wbabWWre9BYzrne9TFm0sDJ0s/CqE6u4aq+vng7yiCK2xtj3yAlZtBLm62UXx2anSRqgLI1TKsulvhKpY7V+NzefIKN1bpvjEL/+hZrrlz4UbTGEimrqp1XcNZWw0lqIFGcJejh/uIj4gikAKzj70qxmnlm/FCCVmboLZL003K7eJNxpaOOREwNVOmp2VB3/S/nI1n6eLt9/D1squW/M877c3oCHaIgJs5GrlUl0R8afKsuLd98MnjJ2MwWBVwtvKfu9ZJbfm5Hhxm2R7+ZayezAYPjsWYj627Y3QpOcKOfxHX6ciq8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(316002)(86362001)(66476007)(66556008)(52116002)(66946007)(38100700002)(4326008)(8676002)(8936002)(5660300002)(478600001)(2616005)(26005)(6506007)(6486002)(83380400001)(6666004)(1076003)(6512007)(2906002)(36756003)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbDhKyZsA3x2v+704X/Fe/prhi4ygmLNZgCQ1rcCrTmg0txA6KvFLTvmpJ6m?=
 =?us-ascii?Q?+xOnCC7EGcqiHXH5MJV8UgDrG2RBXhHM158YAsP8b3G0rsKMDm6W1J89jOto?=
 =?us-ascii?Q?iZh0K8D47YB6d3FizlMbqwEyM1OHTXHC/lJR8SkCpSxPCsYN/LDhL9S0dxFP?=
 =?us-ascii?Q?aOaD651rw8AkwOZgmAUGYot1b271xEUcu0gbCUy2OPvfOtkVkif6dpBPoCpg?=
 =?us-ascii?Q?K36Xw3nONIk3IbvGccdLLCTV0hb6z9A0ETBJQI4IJHgvXyH4F2GPgCW/FC64?=
 =?us-ascii?Q?XscVj3iJvc8nwJmFhy/moMa8KgCjPmIKMUeG/8ZLEv0U6NEHzRi87i/H2504?=
 =?us-ascii?Q?fCrk6P/YcOLodjy+6jQOeX+OYdpt2NGk+4Mru4Zk2sepnCNCtIa14fUp8Nsh?=
 =?us-ascii?Q?7bkncnu968YbQAwU6FfJEJmdxbOLFsFuQj42hUyGUW0nTAejab3C+YKFq3K9?=
 =?us-ascii?Q?/E5Dyztq37IADnvO72mpwOcA9f/4VMZBDojZvypUvyuJoksGMiLs2e2aasXF?=
 =?us-ascii?Q?640eSHaI0x3nVBu+DxO7m+DZoM1q5mvLkLW2hSae8GHEcKawgM9DYa4/6Mhr?=
 =?us-ascii?Q?D0BGXP4k+KdfVscaGacysFYpSxUKOwGw31BjRPehbuxYwa/bVh3erFTZx+o6?=
 =?us-ascii?Q?TbXtHu1p8j/CR2TLxOf3Xmne+jvYa8wVpjbkxuWZy8EXEv1lZncVoNzxhxU3?=
 =?us-ascii?Q?JTJlLDJfh7gQDoDdDthxhDx61QxVAS3LrcT2VS63MOxxArbp67M1RVtTiPO8?=
 =?us-ascii?Q?Lj3iRgsIWB8unMC3i7tiu1k/iRKdEFrlJf7U747ouK85Hqr4iIz6zAOCCv+o?=
 =?us-ascii?Q?gVBzYfsAFtZzJZWxMov31n1o08TMlBNobwnt46OXseTg0SvmC9lJoN4B5wlK?=
 =?us-ascii?Q?ibJtNtK57AGbDfUJ1cXl+qNNN04pUW27FyDviCkz9LaTIo+brzgYPdbmshdo?=
 =?us-ascii?Q?DkMfvMtzBDegZyTahhy7UrLyHLIeLgXVG1DA3J3+3fb6TfqhMdUKJ//IFkq8?=
 =?us-ascii?Q?W3UBmawCzEOO3TBaROMoBEUCKTRLf3VItD3CKY9Gvh/JdW1O+XmUqEuCxln/?=
 =?us-ascii?Q?XEAnj1zSdlICXMiPkPdWmL7QwCeywcHS/ZyXOu7VkGJXgI4et1lDpyG1Kz2y?=
 =?us-ascii?Q?DK/abB8u1Ezjyn1uOsmyWyYuUAVpacGr2qzQN5ha8sFuAcbwt1stSOgSWoM9?=
 =?us-ascii?Q?cv01Ubp58lOapArsVgqP3xo2aS8dEoA9A98dm4DL9muEu4BHNTAhjt0VrHNB?=
 =?us-ascii?Q?XZ2ouAQmAp+tu1vWmYQGmcK7emnQd+ayNV1FZ4ojOQWzmQ2vXq4GYgetEBaq?=
 =?us-ascii?Q?uFXrFUl+LsvZh9DHv9KptcOY9fXLkA0je2y5BVXbkR/aw9Udhot/3fkfmUlG?=
 =?us-ascii?Q?y2wes22O0M9CVYDIDXzYApua4eIyNaNhNBskDhPgkSNWjscqEMDj1cw34ulT?=
 =?us-ascii?Q?F8+XMfsXlvL0wZ2IdrofHYqEAvQSglngZzTjrwsFPsO0mxnun/ZyQN+nY35+?=
 =?us-ascii?Q?qpmPWDyFyIyyGaJM8PoZmcUs8byYBioiXs900CdoSnRgzEHMvhZoRpqasR8x?=
 =?us-ascii?Q?jM2cNN0t9FjN1CcuSbAGnx+mtw2S2Qxz4Vhz+CsM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7883ed-0d09-4b4f-47dc-08dc2405966b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:42:39.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YfhmrYk6sWVYlSD4ynAPBocYsHQIddiKFlq0VFFPMT/keTlvlXGIjSA25CMM1GHsVf3CvgSyDWFFFzFCKbyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10008

829  if (request->complete) {
830          spin_unlock(&priv_dev->lock);
831          usb_gadget_giveback_request(&priv_ep->endpoint,
832                                    request);
833          spin_lock(&priv_dev->lock);
834  }
835
836  if (request->buf == priv_dev->zlp_buf)
837      cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);

Driver append an additional zero packet request when queue a packet, which
length mod max packet size is 0. When transfer complete, run to line 831,
usb_gadget_giveback_request() will free this requestion. 836 condition is
true, so cdns3_gadget_ep_free_request() free this request again.

Log:

[ 1920.140696][  T150] BUG: KFENCE: use-after-free read in cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
[ 1920.140696][  T150]
[ 1920.151837][  T150] Use-after-free read at 0x000000003d1cd10b (in kfence-#36):
[ 1920.159082][  T150]  cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
[ 1920.164988][  T150]  cdns3_transfer_completed+0x438/0x5f8 [cdns3]

Add check at line 829, skip call usb_gadget_giveback_request() if it is
additional zero length packet request. Needn't call
usb_gadget_giveback_request() because it is allocated in this driver.

Cc: <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index d6723d31fc6e2..fd1beb10bba72 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -828,7 +828,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 			return;
 	}
 
-	if (request->complete) {
+	/*
+	 * zlp request is appended by driver, needn't call usb_gadget_giveback_request() to notify
+	 * gadget composite driver.
+	 */
+	if (request->complete && request->buf != priv_dev->zlp_buf) {
 		spin_unlock(&priv_dev->lock);
 		usb_gadget_giveback_request(&priv_ep->endpoint,
 					    request);
-- 
2.34.1


