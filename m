Return-Path: <linux-kernel+bounces-165530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4188B8DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519A828362F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413BF130A64;
	Wed,  1 May 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="chTyIh3d"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2071.outbound.protection.outlook.com [40.92.45.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97B130484;
	Wed,  1 May 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579436; cv=fail; b=f6oMCoKuNykRFJ/LfgO3yW5OG+pqGVwXL1tUTh6mRZe9MN5HizDvb3oqZGSGnkk3Ps0mSR2ITZK2fLV5yNYGvW9pQ23iH2YLPHU+xRK9oScWayjPgU8NLPI1MrBBdx15ddIPncXdAwaqRsgzpYG3PZBzMFrEERQjVJMIJkIP0ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579436; c=relaxed/simple;
	bh=KGpu6XTESecw4acs1KGy93NGZNiEm/cWrqr/MsHfZl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhLbcD0O2NGkvwkkmIttQOsEluHhyC0NnUY//+/InkRLVqSTisGTDFsQ4FIAKonDP40EfgPzFriR7H8W7HLM7XS6xHn0BNSZ/D6RbTetVYvrsOsOKwQtUoPFyXmLyJOV/wHaAZQeWkhhKigdlRjiPOwX/qblJe4rJ3UpN5IpCRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=chTyIh3d; arc=fail smtp.client-ip=40.92.45.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAqhq0jD2WdnX6Nd9IBxoJMqPCVTTdevbN56DAuhau31mAjhlydA8OOfH62+F7yC5s35Nu0/rPsKJdDDfUx7WlBCx0dBwdiSQoXlYN9cGXU+BTB6XOEte0cQFwopx4w42OyeEB/2EuE3payOrraby1rSzMZ4QGvOl7ZjS37r/FD0iAYZVqOONsQ6mEPBhRRtClrxd9CsioKmqA+VG5lPkAWL0kNcBRRoyUCJ/bmbeCAT1ss+x5LsqfCfVL8eksTd6GIuTy47iDqQch0X20jlVWpK0SWkt97hVzCYZtRv4jFmUL9bevhA7b9aAkeloHU2Alcud26I/ei4IezrOlpwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=Bdr8EjQ5fmqVP8Pqvo0WM5GuyADEVIkDnNHZkqJYqCQjVjGLond7EnqcGqiX9ReF7xl2xpObepmnnVoeObCtZk5sN1tMosl+d6qJvo1nQ6ckBr4aHa8eQozur7Gop9oUUy6c+qjnrIlOGaDD2jxxkXIVu8ahPGZVX0kZYTreSeyT65W4UvMW6gxPM7MxqG2DfPM2NbGZR/sAVOoP/1uC7zOgcg/8FHhDAIjlrDlYzkJjpLSL4ZdVPagtrosmj/0aSRxWYSed0y2lcgfBiSr1dIi4RX7THGytA0OMxWbMXPVmu1FqkyJ2zgERdOSMXZHA02DVnMkTn44o3empf00pHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=chTyIh3dFKV7BWjkJrWSvWacTofmFZuKG0UO1s+Z7TArmNY/aNJwYRCcqkQgcXm1qqZXWmj+HJceIp0yA/5zGSk2C7H9pTdfEc9q0zWAZ2+eXq6Xwe4175+lic10gdWpSdeFCVAwpaTAQalTPz6wFbfKvDX+hdjw4kCzI2jhxKGe/QN/cd5nkc2C9kmzEHtk3u7m40ZnnMB0iUkhe1D9orNB4AL/YitH9WegQTFqmCUMyDwbRIPrFKXR6laT2AaTMZ7gRfywm+KrJ53f9iLeWNNDmdMFFio3cu5dYQt+Hxv9pygyXVIo2Z7e4FBGHr/IQUziabqZ5JLnu895bLmnqQ==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:03:49 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:03:49 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 2/5] ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
Date: Wed,  1 May 2024 12:03:21 -0400
Message-ID:
 <LV3P220MB1202A510FE5EE4548DB06F2BA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501160324.27514-1-lnimi@hotmail.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [s8DxCGAQNMLbDw9DM+3qodYaozPpWVtu]
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160324.27514-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b13769-f676-4591-5506-08dc69f84914
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	qt22vGvJT3fF8OVfjTgG4JpGFmbcey0rr8sPumDbCFeeU2t+/Y0qXp5Vw6J8I3EW+rAEgcfLyw0lLWkPE6ll9IM7dUrbm91U3j7XMGhddsltU9END+fdmWLGr+86UIY8F8TVzVY8o+0soxMIms0BFeIggLz+PI2sKENFmaqrtUcUZzpqmzxnU/OdE49flO3YTI3NxJV9UZI2KGoTPkPJQir6PCTbgnbsQHyxCM6DVeVFba/yKSQAGH2IDAY0DQXKU5ywzv5ybEUQTbOsUoO+1HsGBm6QqOT2U4EQFkCDIbZdQEgPtQjMc4Q00Px/qhkY0PtFPen2b7CRvnlc1JYpw+CPey+rdLapirijO2Xiix1G9Cdxm0uIDMRfmt0oVEDKC02qHWtv2xOkJIokTH6rC+ocYauYi1YGF3cn+7aWg9a0i3n/PpmyCyJ3pkDRrbHmpof+W4nb1aarVv83RZGISbhvCPuVQ5Vg9L0KwtXPtvjK/ujqgxEZCuZgtXLhhfhkQ16PHlLSq8/lwPACvvpLNVMhPdQ0nXvAOyRlvck2pxbaFkn8pXmu2cAMgdan0k9v
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jCCmjQGv/wDQ2i8YtiWMpvNJZ2ihF1IwyeIdPCzqRO8t+uplESUda21EYncP?=
 =?us-ascii?Q?am/frarhCd9CypxQMtlYrrpBlHFUjatPvTearo9747fvzF+o1gmnz87AXs/m?=
 =?us-ascii?Q?j294lWGWqBRDTpFBPmQFSEgdmBBl5EZHpkunqMIHKPBxRXOM39LbTKnEYu4I?=
 =?us-ascii?Q?/g+CsCNY9ISuJt0BJcTN9e9Q5queW9WfMalzTXi73k2dOKsWHuZGVrbWJhmd?=
 =?us-ascii?Q?F/6P9YmUTb7Pb+kZQLFwnD2grc9ut/Ymcwg34wD+2d63ssDlKBDynzyPu4Z7?=
 =?us-ascii?Q?VOVCLWuMluPYp6m0vJQa/Kgwy4U4KV3KwVAJ6QCgh6lNTZBLFD0swPLSk6yp?=
 =?us-ascii?Q?1GDIiKa7mf6gVa+cpUPXO7yFWB8sAUF+iOoxTTY3VCjpbf/Lt1zrQ4zcyc9C?=
 =?us-ascii?Q?xc7uBDQJAEwfKsvvUU6xOlbQJwh1nJ90I6w9mbZyvgUFC7vDxKgcmOCHxaQE?=
 =?us-ascii?Q?MWbxtT6g/htGY5YNeVH4lttwxzveDgpJaCZEXWLYPqSfIZj6NWgLqIfhJiX6?=
 =?us-ascii?Q?7AfgDFhnGo0BXN+st/4JdURkI0o1C55K/8zhZ73/CuK8bKten26zRTD5li96?=
 =?us-ascii?Q?ACJUo5nHXHFXdp5CPzCFjHwxbDwI6EkxjbZxR+O+mYNkFeUlSWtg5VufIBgY?=
 =?us-ascii?Q?pxLdL0XMxnbwAWLHFLaT7M9yMSkkWTxfr16yWfHs455DcxWMjbe6iz4AvBOP?=
 =?us-ascii?Q?oOGx8kcUrL4epg6jkEOfQfQ6YXG9r+Pn/iLy2k34N72MgmbxX0WMHIuS9Gw+?=
 =?us-ascii?Q?wdjT3SZI5b59uC76NYNaz/QzwmwmPA1i7YTmHmOZOO2cSf7t49Af3Yzed+N3?=
 =?us-ascii?Q?iItlnoGPnHX3EEzUV3scDwZWNeP480TRmdinBlhChg1hY4EW4OThbw0bFdc4?=
 =?us-ascii?Q?XKq4sscN99+U2fgb5QmXtWxXZYbBcD3V6pZauaL6U1a0HYeTPiW6SB8hWXR8?=
 =?us-ascii?Q?BTHmx4Z+rB5UtxIaoejsCDB529Vk9cFrTbpTqv9N4ZR27BGd8kMAs/n5uDaM?=
 =?us-ascii?Q?Ov8bE6rnDSE0niMjMT9zW5+QI9UgQeOBUKoGQH7u2/IXUwPDvSipTnL0XTSE?=
 =?us-ascii?Q?kzraFeJti8p6dI5i4POujltblyFvN4nBKB2iiMAXAMl+5iRs3B0Tq96PP7Sn?=
 =?us-ascii?Q?qkJGfDpCpWkEqMBy6MGcLQeE6Z275j3qCz4CQ3t6rlMRQle7hOwnJa12RCbi?=
 =?us-ascii?Q?uNSSvJLQyoMfEMLjYmKTSU+sZPhJqN4+3FjnELbRIzm/VbySUiniQRzKsMI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b13769-f676-4591-5506-08dc69f84914
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:03:48.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

From: Min Li <min.li.xe@renesas.com>

In order for phase pull-in to work, write phase timer shall be 0
when not in write phase mode. Also Fix u8 -> u16, DPLL_WF_TIMER
and DPLL_WP_TIMER are 2-byte registers

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f8556627befa..d069b6e451ef 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1396,6 +1396,20 @@ static int idtcm_set_pll_mode(struct idtcm_channel *channel,
 	struct idtcm *idtcm = channel->idtcm;
 	int err;
 	u8 dpll_mode;
+	u8 buf[2] = {0};
+
+	/* Setup WF/WP timer for phase pull-in to work correctly */
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
+
+	if (mode == PLL_MODE_WRITE_PHASE)
+		buf[0] = 160;
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
 
 	err = idtcm_read(idtcm, channel->dpll_n,
 			 IDTCM_FW_REG(idtcm->fw_ver, V520, DPLL_MODE),
-- 
2.39.2


