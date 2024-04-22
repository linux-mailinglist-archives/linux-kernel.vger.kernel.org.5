Return-Path: <linux-kernel+bounces-153941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3B8AD52A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41722825E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00715535A;
	Mon, 22 Apr 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j11Kf55h"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E816A03F;
	Mon, 22 Apr 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815420; cv=fail; b=T9WommlzcnhDhigS28OVs8TZggldZSGmVQpetL+ZYVpWUW0ooWlWt9AL+RPZo23T/FO/LxFNdycW/OEtX1g6Sus1Adx33phwBK3YxMQnrz2ZUNsOgX0lZwran/wOypnu9e/LEYkcBCOFMKH1CLxLvVd5EEtOJuVYljr6KH7BeQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815420; c=relaxed/simple;
	bh=RRdKdexHuivNUPMAP46kzzmgvN0WCIP1D7Q3XDzPvhQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Iuo/XtkfrqIjqMYSb7BmM0wa8E+m8syTWLacLvfcfrQic1HQtWy4+QluMy310v8x4rAML5tYnLf2wcOy5JwoW1BcRQRejdBGK8F4xsL6XGnFHhu7yjP1yNG4b5HFjyrdU/Rjv6XxtceHyemPLv5MXrHeh82yWxrDc2xe4FXPGe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j11Kf55h; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrYOfXAzCo0mVQIHyyupZOOnTJt/Fe3rgjHZwYWEzepH6CS54YXv8iV1c9Gj1S4gvcYdu9LzC3PyzU+89uDQfDddvrestlgdyQbfEwi1LP5VWrnUHF1/YvutVf0Lc62I3zQYgEgalviParMu3rfzkLYECPJBIHesBwKctJ+h9O4GpgkXhabaHiHbMcGECyQBDFivP407hD5Lz4YMKIK+ti5CoRX+k8dMGDvf5DmsQLGjSW04QPLT5W8aIl9LX2jwy+2T2+3dpgTsufCk1/7GkLTtaUI9qwHDigAsbpBtCVyETCceztJTKw2MDxXfwH9lWiCiPblnmugDCRAqNnlVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM8SAHzu3mVDlC+9S1FGA7V2XH9PclLPSNYn1UTsCog=;
 b=ESV3PbqX9CNy4BnUsBifBzc2ptRMkTFqauQ7LXAmGmxNUB7pjheAh54A9oC3rVZaUhhdRZwshSgAdNpUbUH8aNTtpuNcHOoAHxtP4vOI4ezUPHIarOjGeZFqv8cnT7N4mG1ZwBY/pt7YS+nJsSZXj5luT0L/bH4IKXVIsi4qt22aj6ISTj5BGFa2vn6m9vB+ife79T9oo8kivklMEIhI1bTgppwBl1BYTYMjE02QSHj4fYXA+Lfxnh+FKDF1qp7U/yv3zKE3MDkuiU2olwuc3pFp/YSj4lH/BgMwOfkhROqkycIwcjadtIcAZgyqVnSIHRMKj3P1edXS38WqH60rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM8SAHzu3mVDlC+9S1FGA7V2XH9PclLPSNYn1UTsCog=;
 b=j11Kf55hqfNzTwkIVEaxm9FXENTuPL2ieckSmo5lRepPmIFJAXN1NkMGxOo4tK6IUc6Ft5b7GiO6KnDfUh4kvpayOnZfL+lxZi/CenjZ+pMdkE9zvpmmX/WNHSzl9oF4T3tK/cij6XPRYlOxmUcjZ88/IjkztbhQP4zJNgZHqcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 00/10] arm64: dts: imx8qm Add audio\flexcan\i2c\fec1
 nodes for imx8qm-mek board
Date: Mon, 22 Apr 2024 15:50:02 -0400
Message-Id: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGq/JmYC/13M0Q6CIBiG4VtxHEeDX0TtqPtozSH+JgeKgTGb8
 95D11bz8Pu291mIR2fQk0uyEIfBeGOHONJTQnSnhgdS08RNgIFgggFtJl8Vz75Sr8ZYihy5LHN
 d1q0ksRkdtmbevds97s74ybr3zge+vV+JZwcpcMoolLnUaaaYzuA6zONZ255sToD/tji2EFsUr
 MVc1pIp+WvXdf0AkNZjGeQAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=3032;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RRdKdexHuivNUPMAP46kzzmgvN0WCIP1D7Q3XDzPvhQ=;
 b=+muIsyQlm5PI6YwKUuZz3DkTzcsA58MD8wSubhL6khLOad/MBG2pUCd3vGtsV1nuRSAcz9xaP
 Nu+MD52w1MlDiQXkAyHjncA7EWVAX9nuS+bmarnQuJ1InF2GIjst0dN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 11871ebb-d114-4af2-1aa3-08dc63056e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEtGZi90OGpza2hJR2NsTG1NUk0yL1FzbHF5WlVXNEduN2N1d3JFNGU4VlNs?=
 =?utf-8?B?VFdkd0RYbFJJaDI4bldOSUp5TlN4T1gxbEVHWnlCU1dnYWZXc0NLYjZKTzRR?=
 =?utf-8?B?SEJNL1FKa3dhOWM5RmRGVGVvU2hpeUtmYm9IUU1BcWZhNGJYd0xtZ3RyeTcw?=
 =?utf-8?B?ZVp1SDJ6RHJZWUZGWStINlA3NVQ4b0VEajFZdElWR1JEZDVKdHJsb3Fvam9n?=
 =?utf-8?B?K2loMWY4N05EOGoxc2xjRXRDY3p0ZTNUbU8rVDl4OVlyWUozWVRxTkdYTTBQ?=
 =?utf-8?B?ODVhSVNUMC9ZdTd1aHQ2YTJFQ0xoN09UQ0RkQmtEWDlWMWpSa21BQW5zeFNq?=
 =?utf-8?B?R1Q5VGtlb2RHd2JQelMvMnlhU1VZTEFPcjBoYlZ4RDVkTHpmK3VzTFBVTGN1?=
 =?utf-8?B?cEhHRjY5TW9UVHVDZ2d2cXBSWXlMTzhtQzhSNjQvZkVJUnN6Tkc5WmpxeVhm?=
 =?utf-8?B?RkFDSHkveHVpU0ZjVEdWN2hDdFMxa1lSOWFOZGpIRk55WDNkVGtBcjQzQ3lG?=
 =?utf-8?B?U1NNamY3SG02RlZ1MUw4VnNuVjFlWGZVQlZDUDEyR1JpZmdGcEk5MlNFc1Zl?=
 =?utf-8?B?dlhRbCtRcmVNTVVmTko3a2gyVi9ZdE1HdHBBSXF3N3ZSZTVEZDNMVDJQTkla?=
 =?utf-8?B?c040b0dWbVBhbG54dmZGRUtvdDFRMlNET0FZRFNmZUx6YVlpVW53L1FhMVg0?=
 =?utf-8?B?cnMrUy9CaWZMNWpML0RMOUxKcmZTR3l1MFNoNklMZ1dXd2JQQXZyaHlTVHAw?=
 =?utf-8?B?Y29SdHZPdWdJb0ExN2JOZDNUdjVTd0J5b0FFR1FyMWRCZGxybDlFbVA1L0xP?=
 =?utf-8?B?UHNHcXIxZ1NGUEU1dnZuVlp5RjJWQkxpek1pdFVsR0lWNEdIaHZlK2hSdytX?=
 =?utf-8?B?aTJXZVk3U29iZzF6aWZ3THdiWGltTmhBRG04NDc1MjkySmJDK3I0QkptTWxa?=
 =?utf-8?B?S2JnZGdnVTdEZk02MFhYV0lyMGZOb3Znd2xvN0Z0L1hpcDFuT0NwZzNnYWxn?=
 =?utf-8?B?VVVLNlRhSlUyc1FLM0gvVUlpT3FHRHZUSHRYRVNzbUM4ams2NVlnelp5bEtM?=
 =?utf-8?B?SWJQeHp6anpYeUdLdHllUUJ5ZlhQL3NUMnpldFVCVnh2NW51QlBQYUFTeVEx?=
 =?utf-8?B?c3c0Mk1BalZ2c3crT0lzbHM2K0xNU3lMcEt5SXpZV2tzd256K2FsWm9tVy9M?=
 =?utf-8?B?eDVxb044eWRYQzZCb3A2a1ZtSG5Hd1ZpaDBiVmJ3anY2cEIzSTZEVlkxNkZk?=
 =?utf-8?B?Vmk1K1YyVGllMVFTTll2TFlSTVNxV1VQcStiM3JPYVlqQlgwa1FSQmVITEVL?=
 =?utf-8?B?ODVrVWc5VS9iUDZxOU8rTGJ2VmlKL2EvWmVBK2pPSFI2bGtNQnFEeDhRaG5m?=
 =?utf-8?B?TGxQTDVOM0xmUTNzUlJyMVkwOU1uY1Y1OU5MMzNYQk81eHlSemdsbEhzRmht?=
 =?utf-8?B?MXNYZ2tuV2Nnb1gvTlRlK0VLWGhsY1B4dFdiQ0psNjYxSU5DdDhleExxaFow?=
 =?utf-8?B?NFI3SU1UOUtYMVZEMDFsbllwYzFNU09ZNFd5MzRIZmhlVno3N3NQLzkzQTJ3?=
 =?utf-8?B?Y3htbktaNkw0K05xZVhZS3JIRFFDOXJnNzNlR0VyYWJkdkQ0NmtWQ0FmUHU3?=
 =?utf-8?B?UlJLMXBRNzYyaVE2ZnJ1S05PM0pCV2VLbi9lRWZVWFlkUDZaSktKNDBSUWUv?=
 =?utf-8?B?TVJIRTFldWVDQ1U0SU1pUmFVdm9USDBjYWRaVDZ2eEdjeG54MmwvWTlGOHF0?=
 =?utf-8?B?Sy92a3ovQ1MyVEtVWnIrUExId21WYmJzclFNM01OQ2NtZXZ2T2crV0hUejJu?=
 =?utf-8?B?aUFrR1Mya2QvRStPdm9hUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0hXZGozOVFUTGZtbEVWWWxMUk9qaW5XTmxKNTZpZzNVV2lUTFpOVDhmcXVY?=
 =?utf-8?B?d1RMTHFrd3FCS25KaUpvNmhyTjFwWkV2aWNzVE1KeEV4RDRad2VMa1BmWW5m?=
 =?utf-8?B?V1BvQWRPb1pFYlFEbTFDaTg2SGdsV3dPVGRVMmFEWWlHOVNVa3VTMmtOSmhB?=
 =?utf-8?B?bDlReUZVSTQ1c0pXZ1NoRk9CL3JCS3ZGdTBqZWZRS1FvdW9UU2hEblVVYkZk?=
 =?utf-8?B?ZXpoZWlVa1VCVkZxVkN6dGM0RVA0NFVOR3pLU0xUa1VjVHc5Zk5DYXU0L3FR?=
 =?utf-8?B?dlZJbHl4L0lsdUpLd1BhcHVjSUFESDJzWkV1eUZDZSs0Q3NLWnZYWmVQdnNV?=
 =?utf-8?B?bG01bE96eUJVN25FeWlTY2M3SHNmVTVKb3c5TFZ3Z2xwTFljL3BBWTdaMWc5?=
 =?utf-8?B?T1d6aG5VSGMyaHRMZjI2WDRWczQzbkNGTXdGVzJrYWRkeXB6LyttTStlbFRa?=
 =?utf-8?B?RWg0dFYwUGt1dk1rNS9NVWFnL2N1a1NtUWxsMEVlb2t5VW9jQW1ib2N0cFR2?=
 =?utf-8?B?Z1d6UGxtVW5uVXpJaDFTTjZpOUlUdTNEaWRCYTJnMEFBV2FDaTgxM293elMz?=
 =?utf-8?B?VlZPMEQ1RFB5U2krcWs0bkQva0oxb2xBUDMwUEw5VHJwOXlYYzN6RExWZVFW?=
 =?utf-8?B?RVFZdEhXMlNGWDBkYVMrUGxKZnFXd3RjQlpITVZDT1p2SmVSRXFIVmYrWUhi?=
 =?utf-8?B?b1poYVptQXF4dkxTWGhmK2ZIRkJCSjBOMzdrY0NVenF2QXk3VVBLdDQvZHV3?=
 =?utf-8?B?ZTg4NzlISnFweTMvUzhXRUVtVFRKQWt6RVJRRjMwc2ZFa3J1cm9lOWc1MUNV?=
 =?utf-8?B?OUtOMzkrVHZ2ZmFVSndJVUk2K1ROY1hVblQ4ZVovUWdiK04rdHdYY3hUK1da?=
 =?utf-8?B?alRQNjR1Q0pzU0dJNXpPam0rbWJobmFidGw3Q3h0VjBNajVvTU44aWltaVcw?=
 =?utf-8?B?UGsrTUlBYnpuUnc2ck8wcmRLSFJyY0pRcmdBUzBFYXZxcnk0SEg3YlFMakZU?=
 =?utf-8?B?elpOTnkranJMbDgvVDhGK25OQlRRRVBYSUczUysrNWFWeEhlOFR5RzB4UlJa?=
 =?utf-8?B?VWlraXBubjlhbXhjaDU3TnowRjc2S0pGQnp0Tnl0VWl2V3NOb2xUS2YwNFJn?=
 =?utf-8?B?dkhVTnBxYmVkQjZ4SGgzSWx2cVpPUi9FK3Jsa2pGTmVUL3Z1UjVMQ0I3QktH?=
 =?utf-8?B?SXczQnRlbUxBTVhNdCtNTUFobFBxOTNjd3pnOVJmVEZyQWwxQzdRNEhPSXVw?=
 =?utf-8?B?L3c2cmMvKzdkQnU0UFNEbFg4UDY3ekx1YzRLTGNkOEpSblhWbVc4SHcwaWhx?=
 =?utf-8?B?YjNSdStUMWQwL2FmVDJ1VG5sVFRISXVqdGhmK01BaEpLVFNwcUQxSnQ3eGFx?=
 =?utf-8?B?M1owck1QUklvaHhFLzdobUlUOUhOS2Rzb0JDcWpwell0bWhBS2JRNDJQZU5O?=
 =?utf-8?B?dlNuejdCQ0JvQzdCcU4zcGNkZGFtNll1dmhCeE5YVG1HVk50VThyYSs3cm40?=
 =?utf-8?B?cnFNZUtIRXBOd3JlSDk1RE5YU1p6RDZwbm9ENzI3blpKK2xSb2k2RnZYUmQ4?=
 =?utf-8?B?eFpCTzlnVGl1ZkpqZmVxY0N2NjQ5SHZ6UTNuNDlrUWRTZEtqZm5MbGM4d3ZH?=
 =?utf-8?B?cUk2UlJHMTFBdk1xVXRyK0RmZE5PWmtFZHNNMEQwYjB6OFc2T3Zvb1dDOVZt?=
 =?utf-8?B?Nm8xYUZSbFc2dTM5ZjFpYm55aG9rVy9QQUx0NGtrV05may9TS1BucWxVMXZE?=
 =?utf-8?B?U05PYllJK2hEcUovbnVZWHNOV1hVS2hNYllpRUNiZUN2emlOdFdNcWxaaXlP?=
 =?utf-8?B?WkZHNHR3bjQ4SXBxMlZpSC9BZnlaQlpYYmZ6OS9hcURrL3RLTStlVFQxK2pE?=
 =?utf-8?B?NE45bnZZUU9xbUNwU2FQUkV3aW1rZVhhY05XaUVsOVFtNzcxaHlZSFhBS1ZY?=
 =?utf-8?B?RkNFVEJlRVU1TlYrdjBuN2Y4MVBZNWt6cGpKSDdsN2dVaVV1RzBKaWx2RVhS?=
 =?utf-8?B?L0MrUlV0UUNUWUtwckZaU1ZsT0xUMEZ2UHBLQnYrcmZWR2VkSzhwSVNRazhE?=
 =?utf-8?B?ZE1wR0IwUVNNR0wvQ0VEdTRoRGFYb01RY2hLZ3Y2OVNsUUpQMHNrOTRyVnFq?=
 =?utf-8?Q?aFkrH48pjL44GeJiLZ4C3e9hN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11871ebb-d114-4af2-1aa3-08dc63056e37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:15.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzZSKKJ9TkPt2MF4Mzz3Bgf8Q5QRULTX3riwIRYVqMB2fZuAKK61txWouTnxkaX5/GhLgUVN8wYBbQAA1cYgiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195

No new warning added by 
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8qm-mek.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- sensor use general name
- use tab in pinctrl
- remove extra space for fsl,asrc-rate
- change to bt_sco_codec: audio-codec-bt
-	audio-routing = "Headphone Jack", "HP_L",
    ++                          "Headphone Jack", "HP_R",
    ++                          "Ext Spk", "SPK_LP",
    ++                          "Ext Spk", "SPK_LN",
    ++                          "Ext Spk", "SPK_RP",
    ++                          "Ext Spk", "SPK_RN",
    ++                          "LINPUT1", "Mic Jack",
    ++                          "Mic Jack", "MICB";

- align clock under sai
- remove unused "FIXME: .."
- Link to v2: https://lore.kernel.org/r/20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com

Changes in v2:
- move vendor property to last, just before status
- use audio-codec@1a as node name
- about dual license problem, need relicense whole included tree's dts file
which out scope this patch
- About delete-node

imx8qm-ss-audio.dtsi are not supposed to be included directly. imx8qm.dtsi
is supposed to be included by other board dts file.

in imx8qm.dtsi

 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

"imx8qm-ss-audio" will overwrite some common audio node in
"imx8-ss-audio.dtsi"

acm, and sai4/5 are defined in imx8-ss-audio.dtsi for common part for all
imx8qm\imx8qxp\imx8dxl.

- Link to v1: https://lore.kernel.org/r/20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com

---
Frank Li (10):
      arm64: dts: imx8-ss-audio: remove memory-region = <&dsp_reserved>;
      arm64: dts: imx8qm-ss-audio: add audio nodes
      arm64: dts: imx8qm-mek: add sai and wm8960 support
      arm64: dts: imx8x: add cm41 subsystem dtsi
      arm64: dts: imx8qm-mek: add i2c0 and children devices
      arm64: dts: imx8qm-mek: add cm41_i2c and children devices
      arm64: dts: imx8qm-mek: add flexcan support
      arm64: dts: imx8qm-mek: add lsio mu5 and mu6
      arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
      arm64: dts: imx8qm-mek: add fec2 support

 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   |   1 -
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi    |  68 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       | 344 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 102 +++++
 5 files changed, 987 insertions(+), 1 deletion(-)
---
base-commit: eda9714fe6d9e6e5690992ce7dd42b13a5be7803
change-id: 20240402-dts_8qm_audio-e1e1697c9bf6

Best regards,
---
Frank Li <Frank.Li@nxp.com>


