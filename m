Return-Path: <linux-kernel+bounces-103293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E687BD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E06F1F21DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3506EB79;
	Thu, 14 Mar 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BPpRTPWP"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC625BAFC;
	Thu, 14 Mar 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422839; cv=fail; b=njd/fopPLHhZEUHfS1sItF8Uk8KcS5gNbGDRn9BLrfFhHn7afOCFUc/aIBJDJfo3RJytWuiTJTsN6BxN5+Rq75vSjofYIHHkcyjItG9KTMeP+dp1w9Az25KWRonfZy+AeJor5tzAozs/g7Nb6IdEj7Z1aPC2s03qeAdkASkREMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422839; c=relaxed/simple;
	bh=t5HLy5gFexuRUd/gcXkLur0tNUBqrWNFLScENOV0ZWY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qHQDi4hL+NQboxpjplNIQ3U3B3sBQ9SpWmuny07FusLSVEbzqf2CfsTLNaXccnB0Ieys9WwH+Lzp6GoAo8gq5RxBrnlKdrzpkfLSiTvhMyX4bD4S915ZndkEZ94r616leH0Of/LcZbIy2BTg/LlkQt9C5JXb+Z2t+wkGN3E40IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BPpRTPWP; arc=fail smtp.client-ip=40.107.8.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/I18MYCOba+ITMNpKFXky5/qV1a/5cbB9O0Q1eJJhH2tXbJbFmaVu3/9XOCGjytr4v93cCfDFr9JLC8pFY+1DCnHSGpEFjDQIHyMUuuw9KrPgh0rigTB+jLfhvFf8gzGQBwmegHKIPnAyDsFZyZhfwKVUHiiW/705H+fvfQK0RWirsy0uMwPBy7cyY90pDRcEOE7apETlaiE+oLeLZUcvrB10jgF/MZwxCifZErxD8Nl+ycUX1cOm5GgnxF9CowpYXLcSAvMndRnbT7rkxhMYq3ePBL4f9DQNxfdOcY2+Jnr9QmisZ/MC2ithD+p8GkKnf+o42xaqJQw9S+zcISkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=Wzi8I1PEgs6w++cy2ImwhcNzoOrUHl6fUrpaY4EVn1+hcZ0kK90EnxCrNBRPHcwsTmgN0IQXiMmkvLdfmMt8BKf0VYLewN9ndq5MO31skyxAlGZVSPld1t8dqbCgShMvuKU33BgJF17zc7L+jrQGaXoUzkG8l4TFoMCLcGPqNRAXYqZ7S9j9OPCJh/PE96/ydb2DT/pKSILwGPkOZHgJREEy84x3gNPy7VK41FCJQQjF9rlmEp4/uHcZNCzC0D+Hp2Evdvq+2bkq0oZaFEQ5QHTLvCU9fSy+gZshGFquJ0lIzBYAxE20FvsY0vSO41HR08FOLuwhDStIfJ2+TCChRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkhFzy347CReKh8Y/3De5x5m9e7u839I/9k6SdaIf8U=;
 b=BPpRTPWPL293Tza8Ny6nUgjHlAD7lk4LyGTqYuRvHDQ555lng1PrSibREfpS+TLQQjgy+NIRSEmNlchrLXyjPI+0s+TNOm+3FA1LH1V04niQCZXqhdo94G26SFqyK6PR6UBuQrUnup0Iy352JKGc4I6+Zr0Ab/lriU1zLLQ3RWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:27:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:27:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:35:18 +0800
Subject: [PATCH v5 1/4] firmware: arm_scmi: introduce helper
 get_max_msg_size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pinctrl-scmi-v5-1-b19576e557f2@nxp.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
In-Reply-To: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710423327; l=2653;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dKDsMHnM+cuvfvX6K6tAU3ADCasBJe+OHaz6qBQ1Tuc=;
 b=4xzM3YkXuTqYU0tEDo6x/HN4gsRKw3cpJZgM2pUwWmhzTcBuCmBTTPCH+IZBUrrpdGdNWuVQ8
 6MyD12S/yYnCjWetyg8RKWlUcjin4Jf8siW5hQolqJ7mOHzFtszNtL0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2640a9d6-c38f-404d-f731-08dc442a75fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N5VTujBtBoO/i+cA10llx2BsBHIOkUQ/kQV2Ev0E/7x4JXhCSmSux6L+r1sdil4gduW6DPMgs812ypiNg+on03kzFubcJfOEq5cvUOJSaiR6psLiTLZeZeoXy8HW7cpwoj8hZVjXUtBECCw068mWu4t542197KD/yP5G9knFCkb0wmbLya44B3wY649nFvnqSi2sGsjQ+e044BV4yjKYmOXQ43weY6xdY3TSQ3j3sD/thbBvLrLN/GqgejwKpwYrLivn0m8IWXzCSiM3dl99bLrVIze1t0cXkMuRifWGmU2UlV93QetIJZ0IYNHsTnmUHXiTDrLCx8sigOLWor0lk+hCm+W4FGo5IoPb0CJmD6bqMou17cRbjEvhGDeCUfKBGLbHGZXn5aJ3UD/R7lT6Wvm4DWjW3a5j8qYxFLxmCgvFykpfUfrk0PpD91hfYXQn0diTddVew5vVGuu4J7yYLrqH/oz6Xp18k3JzwG8w+2MyiKgjIKo9m7vdy0Sd4g97+lgDvwF77oJ27T+kFji1yc67flBXf9mw1ZD2heJdK9MdFSJg8y6CUnFgsGhsHvo/rh/YRHttVJpyl/c4HeL0UXTGz11NoyzjMNB0Qf9Pf0RoYlFJYvDKpPDuxS8kYvmf6TTBkw59l5pOj34CFtMinLPRDWjSyuuIpVQnSjwKS5p6VHrSMUoOVGmsD7MUelvEFjYwDkFv1TyTlo8umn7JuRETT5gans/ENyBxeFcjjW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0YrMEtFd29PdlF4cGRIYi9aeENpWFdIaHBWcmVPcG5PQjBrWXJTV1c1ZGNF?=
 =?utf-8?B?STlvZmZ3Y1RIdWZXSVRMWCtFYVpWQ0R2UDhqY3BHQ1FtVzRRcG9iUUo5czV1?=
 =?utf-8?B?bVlZcjdzWVMzNGVwQTh3dHdVRmk5REt4SXRHQWY0TmEwVUJJNWFBVzNyYk1h?=
 =?utf-8?B?SVc5N0tWN2h2L0x1eGFlVjEzL0R3dXc1OEdXODhIaTNxNiswaElWZEVGQWhX?=
 =?utf-8?B?cWd0VEpQVXhtNXZPRlY0aWRyS2xKQXA3K1FjY29GYlNrampyVjNDNTBJNjR2?=
 =?utf-8?B?Tms2T0owdkU5d2w3aWRGM3hmVVVCOHVzelpJZlRwYjVDTGJnQlZJeklySEhQ?=
 =?utf-8?B?TXUxNjFJcWx0b2tLSzBVZFAyYjlFU2hKd3UyTFYyR2J4eVJHanoxNFZHZFFi?=
 =?utf-8?B?NmNEZExiSFRka2JhODNIM21STmVhWGxwek5sdkFmUGpCbk9CT2NjRlB3ZU5L?=
 =?utf-8?B?NDMxMWQvQnVzSDg0MmdZOUZtVmZiSG5PNWtQTGRkaFhDTE43ZGVCQUx1TEhD?=
 =?utf-8?B?U053UmNneDFmUmJQU0tSSHFTSHdEeHdqTzc0cmFuYnhyMXlsdHlUNWxrLzRk?=
 =?utf-8?B?YnJWSjQ3a0xBZnVHblBneVlRVWxzalAzeGZGTEVxb29ManVvT29ZY2FLaFhw?=
 =?utf-8?B?Mi9YbGs0cTlHdEd3QWp1dWk2YU9McXdlVjdZVWJqVlhHdXVwL3hXOE9BSXV5?=
 =?utf-8?B?L2FWNGVZOUFLSjZNTHlCR0pnMTBOZlgzeFZsQWU4K2NvL1IwcTl1cm5wOXpv?=
 =?utf-8?B?ZGo0T2RJYWpkT3BzVk1hb0thYXZLTytXb3pXRG52UW9ITU9XeVlQQmJhNVlO?=
 =?utf-8?B?K1RLVXFRalNtZjNIUFBMTFR3NXI1R21MRGwxV3g4MllRWWszd0dsUEc4dkN1?=
 =?utf-8?B?VDNiOEY3Z3RVVGR5YzVEYlhWK0VmZU9QZVVFeVYrQjUzREh5OUFwVGRzeGJI?=
 =?utf-8?B?akozbkphcFg5Rk9RdWFLSHRaNmhSeTd2aXJ2VG0xbVVTR2c5QXhMSGdUQ0tv?=
 =?utf-8?B?TmhWaWNGVmlNZmRJRUNNZldCcnN0NEo5dHhLS0xoeEJ2cHlvMVc4b3VGVFhj?=
 =?utf-8?B?L2xoUkdXZGRaY1luL09JbXJCLzlVSmxUemo4NDRhaEdwNHRwdHFEQUpya0Nq?=
 =?utf-8?B?azZvRW1BVUxmQzdUM2g4RjNUK01Ta3QxZ3ZleWl1a0hpR08wVWVKZ1FnOUtP?=
 =?utf-8?B?T2FOQlFVWHErbzBuaHFQVzNEWnBtMmltNC9tOVZLaVFWazZEVlptU2pMd0Fp?=
 =?utf-8?B?cXhJcXp3bUhTNFc0VEo1OFdYcExUb2w2OFBZZmVhZDJGeVJnckt6blR1em5E?=
 =?utf-8?B?Z3NqOEs4SDUyUzNGb1IwOUo5VEFZbFVoK093bHRQb2x1UWMwc1EvVkVjRGhy?=
 =?utf-8?B?V0J5cWtUV3hoVllHeWdoelZLVHdVbUxDOGlUeVhoYXRPRlNQVGl3Yi9TdzJu?=
 =?utf-8?B?QVRDMFJUejU4eGZ0K3VRd1lOdlBEN0o0aGV2SHNZVXZFZ1c5cFRicmxTL0Ri?=
 =?utf-8?B?U1RvcDhSZHk2Q3RScjVTSko3L1haMFZOWDM5RWZSRVVMM2ZkSmN6a21xUW1U?=
 =?utf-8?B?R2Q5YmJSU3lZbm9SbTBFSFd5K3V3bldTNXd0akZwQ2hJTTFicUUzWjhENHdY?=
 =?utf-8?B?Uks1R0xrNmpjNVZkbU9uQUJraVhNUExIcFBtK0c2R0J1SkJaVk9XZVhRYXRH?=
 =?utf-8?B?Q2MyeWtmc1dDNXJSZkhQQUduUVRlNEExbVJjbUU1RlJTVUxzeW4vdVY4WitK?=
 =?utf-8?B?N3k4SHg0MFF3ZDlkeFN0SWFOaEkva1ErVlNFMjRrODIrZThjSldZYXltVkND?=
 =?utf-8?B?ZmVuSUN1dDlub2V0ZUh2OHBaOGZFME1WNGtYMzhmN1NSUDdQRFRpT3JJZmJm?=
 =?utf-8?B?YzVZc1Q2a2Y3cEEwMWZYdUpnZDcvakVmQzlPY1ZZdThwWitXTWtQQ28vdmdm?=
 =?utf-8?B?a0M3aGROQ3VUQmpQVGUybitnaTdzY0JpejNBbGYxMllmeFU5Zld2NzNGaWRU?=
 =?utf-8?B?VlZpa3FQdTJKRy84T0RzdTFKRHoxL3Y5Z0hmMkFLQWx4eHFRazF3VFRBbVY3?=
 =?utf-8?B?NTdBMTBISXBURVlGQlBRTCtVakJpRithcDh6VE8xd2h2eXFURSt4Yzc5b1Q2?=
 =?utf-8?Q?X822JF602bLCF5vna69l4sLWb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2640a9d6-c38f-404d-f731-08dc442a75fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:27:14.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWnfXaZZPbqlvaphSEnMaLnzFdlKpr4wJg30PWA4kiHrjt1WPCVIZNpC1WJddCu8kfJnaPqMkakWrb7e3lZucQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

From: Peng Fan <peng.fan@nxp.com>

When Agent sending data to SCMI server, the Agent driver could check
the size to avoid protocol buffer overflow. So introduce the helper
get_max_msg_size.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c    | 15 +++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2709598f3008..415e6f510057 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1488,6 +1488,20 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+/**
+ * scmi_common_get_max_msg_size  - Get maximum message size
+ * @ph: A protocol handle reference.
+ *
+ * Return: Maximum message size for the current protocol.
+ */
+static int scmi_common_get_max_msg_size(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
+
+	return info->desc->max_msg_size;
+}
+
 /**
  * struct scmi_iterator  - Iterator descriptor
  * @msg: A reference to the message TX buffer; filled by @prepare_message with
@@ -1799,6 +1813,7 @@ static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
 
 static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
+	.get_max_msg_size = scmi_common_get_max_msg_size,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
 	.protocol_msg_check = scmi_protocol_msg_check,
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 317d3fb32676..3e91536a77a3 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -258,6 +258,7 @@ struct scmi_fc_info {
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
+ * @get_max_msg_size: A common helper to get the maximum message size.
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
@@ -277,6 +278,7 @@ struct scmi_proto_helpers_ops {
 				 struct scmi_fc_db_info **p_db,
 				 u32 *rate_limit);
 	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
+	int (*get_max_msg_size)(const struct scmi_protocol_handle *ph);
 };
 
 /**

-- 
2.37.1


