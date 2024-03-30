Return-Path: <linux-kernel+bounces-125777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D17892BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E25E1F21D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A303BBC7;
	Sat, 30 Mar 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gXBsHxHn"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2099.outbound.protection.outlook.com [40.92.73.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4C3A1C2;
	Sat, 30 Mar 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815510; cv=fail; b=XC1Fjb9u+dwnaxyJEJljuOFmns+vF3JL3tRNyjApJMHrWTTFXJJzCL1PnV511pSgg6RWGvoxy84JLXK22hzmDuh07yer6UJBkRiqIPQgSvndbieYKwvthNStZ8B6XSbi5mx8ekZ2dvU28jKoBstNRv5ELEJzEdmrHmSusKP09h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815510; c=relaxed/simple;
	bh=BrwvvaqUhQoYod2amy4sMfKCE3MWXfb1c95SCBYMQQg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XtPBlfctWwplPrVwF117gFqrz+YKJeH8W49SJLSRzcERhMoWqO2T4j7JvIW15XUdnzYRa4AcuGijI+mDmvY/ZNnBKcQUmPtfrHMw//fAbVQQyMBYsxVMtAIZPsOct2B8p0e1UkJaL26kvoTAEimRpla3QNm5PI0oE6d9ZuX9418=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gXBsHxHn; arc=fail smtp.client-ip=40.92.73.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EelJ8kWwGsNqbW/1khq/bHIcVYeNumQYIKYBPESfDDBPHcCzPvwZVFWjqri6OmOoE8LNYzF3Onz6T2aoyW6WtdRHE3A8T4oarhF761f2LCpjo3AC9mclnyxmflgyGDNPp/LxZRz3DhLJZrPl0eE1CpnPkE6YvWDEcjoLy5Cjye0ARpDoTXAAOrUNkZrGLkXqbu/dS+J15K5V6l9rhHD0QLP15J4Cs2WGih2GQxg7MJAGZy2mZApuQXNM+qD77NvCkZ7OzuSeQh9/w3Db5MSuFn4Fb/lJszJuLAGt0KttBwwr421FuTFxfs3Me3+oFmo0gFKqX4KmopnCuUj+5GcPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj5VHautEvJPR79SefN7908PN5XyalBexEOF+G39SOA=;
 b=TAy3UgyVLDHIuEpgr/SkPd5SJhbGCw36+qE06DRSCbmP0CSTg4qPNMsnrVC92tDFO6qQ3kyJz5GT2TdNNU6cC9AWXJY5RyQODzbvAf361rwhY4fq3Y0zFrcILT4pITyYjppl+NDtmqplGPHX3n5XZZALOv7Md/oxupPKgOqVY1/gaJQ/UPgJoyS+C7d6drjxRRYMqD0AY+x5Q0AFAYIDfSLfa8Pnm0CVYmU1cw0O1TQrTs42nWvtED0WeAFlUmdicnY81mnbbI5p41CB2ah5iugjrw/aTpupSfm63j50pEZUf8meKDddQQXV0I7amhrIW2ygj7SaZtdZBfRDBnaDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj5VHautEvJPR79SefN7908PN5XyalBexEOF+G39SOA=;
 b=gXBsHxHnKtltzFWCp/sMnkdCnf/BzYPPe46dXlbLICE9RNP6MRFa22A4Eko51NodCq9mdDD9mx2Dle8fbjmtvoufV3+e4hMialwACXs0aRLGUEy2fMN4iQqkP6NL04nWlbp58Q3i0fJA9ZQvBZdvASEIqvXUvv0Rks+ZU14bJKE5a66NelHLX4eCnvQTTsPH2d068loIBl+xu1ZiKcA3zZ+roh9sk00zPWN9CP/UVt/2IdOu9YzBH0ICK2li3VFiWV+xgm75SvxpcEuAT8RP9E2mnUhe30L7uf/CcQrNqBsK2wDmwgs86FGE0vvOlbQeHsDlMdwhTztNvXLni7j6Mw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB9388.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Sat, 30 Mar
 2024 16:18:25 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sat, 30 Mar 2024
 16:18:25 +0000
From: Erick Archer <erick.archer@outlook.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
Date: Sat, 30 Mar 2024 17:17:53 +0100
Message-ID:
 <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [WkGdBAgg2j+eOVC9WsD27Qpi9XrT0oGV]
X-ClientProxiedBy: MA2P292CA0021.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::13)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240330161753.8684-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f910549-649a-4726-0886-08dc50d506f3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	38WQunt9qLzjo3S2vOV/DdNnJUnxCT9xgvKV5fygIh8KIEqZp00KwVNASyaZpUWsRkq5xrAkOUJX9JS6b+fzzHf3wWzrWTCjqgxu6s0y3UgrQdXgWRW6rgQ5ul2gVzgt3qOb1nJYFCEcPW7bZq6a1XHj90UELEmq5OrUaiuSjZ1/y80FLCdjsFdNFmGT/VeMDJYr/skmpujiQhEQcHD2mdDnRo9z1n8NIy2/llXE63PEPkvXwP8MF7aTe5jNCBZJ6CaALb7Shw1xhIXlqmcv092WvsOsDqD7vP46bEG48QGGY46pc1hCc8jyQWNxdkgy3BObf6r43k6hYO8k9JSGDTvD6Hw52JmpePmWW1v2xfStXaZ4Hh9JAkv+E73+KzQJWXz/llTwaMOAazIP9hRZppDnE1aaTK3BjuPq6Nuw97DNiSoTL57rZzGWFKZCXrrxMguspLZtuly4hQRpQXwjkXeV8hW20fTePVQWnh4UuLiJi+bfcTnpynzUvMWvIIVH+Wqly8x/GI9tO00/Tn3DlFcjqyE+fRBBM3naehqS6YXq26iHwSHmrPt4pKiGa8gbl1EmVQaSRRoM4IQr/W+RiRgld2dCi0HBGqhzSo2b4tstNsbLNGeFqwagVUk6/LAsAAMKojyF1/EmCIfyieHNJHTTj4mW8KVwsLBu/dFcpbonSK0+O/H7zwgcmCpNklSV3YP/PMHV+OMwpiFYvMW86A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpjNrmbZIZA7uJo6VMARrTr4tk+ud6+CAhQwo9AtpPDl9n2cZW/XUs8le7fA?=
 =?us-ascii?Q?hJjRG6HScshHqX2UkbsiCWxOiKbCtdJNhEV0LS9ahoup2MfJ6sp/gCh6dUZJ?=
 =?us-ascii?Q?mFwrCaLqB2Te3cnjJuB8GqmKGzsUvuZIzSs52qMvlDKw+vxqLMhqyZzpTFl/?=
 =?us-ascii?Q?CKPx5c1JO4l4940DPlgsJPemVDplUPv+LoJLaO07oITDOjdtj/MMlSIxT98W?=
 =?us-ascii?Q?Gru/0X7EawLAkTje+Eua0iJgZlaL3SdGOy/cQ0cTLb7ATGVonc0cLyWh9Sbz?=
 =?us-ascii?Q?remt3ROqDE2LdPgU41M/BuSH8g/vTjmN4csl89BtAY3C6LP8MZ/4Fj7M1ABr?=
 =?us-ascii?Q?zQxSAd5ydfBzHJ4GnPR3SnCrM2+oIB5Q54xNvPD/6gqmf8qfXDtmihnIEUUD?=
 =?us-ascii?Q?4IOIC/bG+FsehFwL54WGRG0QA6Vgg/27SF9yTOSwF+UcRyT0K9FRI22VpsNk?=
 =?us-ascii?Q?+pfivLd8EmmP2jUqSW/7v/QyDMCb26g9If7hguTObCSwKuXsTCJkL2tB0179?=
 =?us-ascii?Q?lrv+sj8IryrYEKzOOYFWmFEXTXyet3LCP7UfsfTi8NpzBZx/2II3LD368AOn?=
 =?us-ascii?Q?HbtL8ZuwfalpTrORHn9XZEUL3vk8yeYXnUwJ9UsugXZfrxLG0THEEhfILy2o?=
 =?us-ascii?Q?0Lena/NTNqnmNu2bbRns3SukKO5mS3tH5aD4GyHIyHZm5rI5OVec8Yl5roVp?=
 =?us-ascii?Q?C2hXaCWOWLWDiRqULKMvKbQl4tXsZnB1dnwZrfkXxQqkWhKENNMoAy5nETS9?=
 =?us-ascii?Q?X3ILKiaQKbmo0tYxFLl+5d8oBOSbvPODGT1R94Xab5IdT4U8/cqLAXBEyB1r?=
 =?us-ascii?Q?7hcTSE5PGGJ9WXAOnbUeo++ctloj7tYOi9r04ImH3zNMxBMsL/YJLr1qRQMC?=
 =?us-ascii?Q?GlAFhBqZ5di9/UJDSlHMSCUAnzWNUg6DDvI5apKC3T2YgT8pXj25p7SLxwfH?=
 =?us-ascii?Q?SykOjy8kW8RPVvqWp2V2EfOQgVt/OQV/tNCpdBcKzGFtTSj4saidhbk1s/YD?=
 =?us-ascii?Q?zFBOF+B9l8DaQ/oyYiC9U/cHYvwQMIlpY0PV3NyHz9gyBQ7JLuS8f6uv3a4Q?=
 =?us-ascii?Q?9hkc6oaR70ihTmvQyf8TgkBebI1i9xzCKWVSe+mPXNmLuGGTk263eixiD7im?=
 =?us-ascii?Q?ykdPYKQtW7XAnVHDOyjRG/jW4PFb3TjarIWQLHMsA6oiL2fT0dhL+IZANIVy?=
 =?us-ascii?Q?LvNEvHhtOqWOK09OaUk+KuXPC/NslbDM2WMf6lofBgP3KAzd0XPyaEZva54h?=
 =?us-ascii?Q?bGdEoUluYDxJjVBFoMcd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f910549-649a-4726-0886-08dc50d506f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 16:18:25.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9388

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Also, it is preferred to use sizeof(*pointer) instead of
sizeof(type) due to the type of the variable can change and
one needs not change the former (unlike the latter).

Link: https://github.com/KSPP/linux/issues/162
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Update the changelog text describing the sizeof()
  changes (Gustavo A. R. Silva)

Changes in v3:
- Add the "Reviewed-by:" tag.
- Rebase against linux-next.

Version 1:
Link: https://lore.kernel.org/linux-hardening/20240112182603.11048-1-erick.archer@gmx.com/

Version 2:
Link: https://lore.kernel.org/linux-hardening/20240114102400.3816-1-erick.archer@gmx.com/

Hi everyone,

This patch seems to be lost. Gustavo reviewed it on January 15, 2024
but the patch has not been applied since.

Thanks,
Erick
---
 drivers/scsi/csiostor/csio_init.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index d649b7a2a879..d72892e44fd1 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -698,8 +698,7 @@ csio_lnodes_block_request(struct csio_hw *hw)
 	struct csio_lnode **lnode_list;
 	int cur_cnt = 0, ii;
 
-	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -737,8 +736,7 @@ csio_lnodes_unblock_request(struct csio_hw *hw)
 	struct csio_lnode **lnode_list;
 	int cur_cnt = 0, ii;
 
-	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -775,8 +773,7 @@ csio_lnodes_block_by_port(struct csio_hw *hw, uint8_t portid)
 	struct csio_lnode **lnode_list;
 	int cur_cnt = 0, ii;
 
-	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -816,8 +813,7 @@ csio_lnodes_unblock_by_port(struct csio_hw *hw, uint8_t portid)
 	struct csio_lnode **lnode_list;
 	int cur_cnt = 0, ii;
 
-	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -855,8 +851,7 @@ csio_lnodes_exit(struct csio_hw *hw, bool npiv)
 	struct csio_lnode **lnode_list;
 	int cur_cnt = 0, ii;
 
-	lnode_list = kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list = kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "lnodes_exit: Failed to allocate lnodes_list.\n");
 		return;
-- 
2.25.1


