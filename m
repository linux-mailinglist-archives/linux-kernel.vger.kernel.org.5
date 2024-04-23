Return-Path: <linux-kernel+bounces-155349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3508AE937
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CC71F23182
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03986139D1B;
	Tue, 23 Apr 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IfVOh8ln"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C513B28D;
	Tue, 23 Apr 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881490; cv=fail; b=U2mOIbedZYzCtG/Rkd3XD652hmkrcDVpaT/iycy9QWzVEzkHJFzQ9xnnOQYYizwh0NQHj6skdvdO03Htj9ixgu5URUFuklsvG9K5FQHcUOBrGD7GKaISQSiaWyBaBJOiMYPi6HBSfVfDnaZswwKJfiJSIm2ehW/1KUS/Q/EyDZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881490; c=relaxed/simple;
	bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bkIL7JwvFKvodmtEexDvys5Q3mNqOFDz+/QZXBB+mgGAl4U1POL6O7fHaLmID+V7I/fix1b1/OSXp7E80Bn9ZPrO2NWB9Nvb4Y/UltPQFUBR/wceU90fcqioy/+PFx/ikCt37daCvyY3vlJGaO0cBl1HxXXZo+QSBnHEr2YNa4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IfVOh8ln; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0/jqRovgIhvErEZoA2nj9kGeQD8B+LPJt74+C2p44GoaXUNRnv0yvSzFg4y3yb4SYR2Y/KpDXmj6hAJSeP3o6cXLpAQaIkmsjJn36Z6TX91kGKEge0Hgl3pVIcac0zZqKEn2JjoWxkPlVofMUSdXt7VE3u9zoydSh6oje+wSBwJ4n5Jxlfm7D1FDyZK/PufER55HfpU3qnZSQEnlKGFJzpM35lO5CIUdtbgnh7b95LX9r9iMJtuQz8HfF8sV0jHH8gvTgFA+Uk4NsiUSDDJQckiwuIp4g7ENZM+oX38UJx5/VdyxPyFWm5knXIjH08UrVVePAwC2fN9cCZa36C84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=laAZLETiR8W2MlMOc3jJQKNGZsYMzRFKlpjslLXkLtrtuH+Ok47cZnduXotDFOYPiTQjD4Kbsn8vTWaJObR7mh/Bmw/qEqdUEneUBnA3DaouSbgRh32VBPImgqHG0W7ZL5JQA2OODzsJFzZhzWa4zEjka07T9JI8nHVFce5Vm3exmqa/MZQv8HIO7vTO8T6v5MiL8Ew7MrIJYRuz/2ZXDdauZCLO6Ig516dk+2mH0j7UMtA8FAf/sbNDWINb4CkiX6nX677dq6dX0xlPTRto2DIcuZvMc2X9jrjpanhee7ibYfkL+Unhi7Kwim17L5UfkNOhc7F8l/5HLjrYdgKgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7rGWxaI5aeMHq6ZQYbO3rxp1eHNz45A7eYB681GZT0=;
 b=IfVOh8lnNAusY1gdhRt5MVkDZW5DU16AkbvJuPEgbD9oCBPCy66Wqg70SNn7HW2a2dm8BmlYsBDImsamZNnoroMYa39OE9B1cU6ANCG4O1JHWdmHXBcOB7sxXN3ZmVWvggOG9zqpa7wVsztSPIV4k8Go+9ee/vxJR3dn9Zbqu30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 14:11:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:11:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Apr 2024 10:11:13 -0400
Subject: [PATCH v4 1/3] arm64: dts: imx8dxl-ss-adma: delete unused node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-b4-dts_dxl_audio-v4-1-0c57eb7399a7@nxp.com>
References: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
In-Reply-To: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713881481; l=949;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N0RdEHUZsI1zzW6nCuPZ4hZFLMrkfmr6Old8d5fO7aM=;
 b=mJtidNLSpIUzwFjPGg3eroeXnM+k3XNjYfF+DeW2kvQLMc+7WMkA67EJHzavrnNTGjBeLAvvZ
 FdXzPTgqzOcCifPjDPEP1tzh2ASeiLu+PNovo6LRrCz0Yz9fXHXPM4j
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e26b27f-19bd-48b4-0ec0-08dc639f42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDB3WXZ3TU1DM2tHMFFkbEp6Y1hqSjNZbDhZTHp0RkJUMnZSbGlnbjBlRC9Q?=
 =?utf-8?B?aFF3S0EyWVVmQS9Yc3lFeDdhL3FlNFV6VlFYKytYeVoyTnJIUFFmOGtaVjZQ?=
 =?utf-8?B?clRKbDNvaHp0UXFKT1Bsak5RTkpiNzkzTXhhYk9za241SU5RTnErTjJwMUc3?=
 =?utf-8?B?aFRkcEwxMi9DMTNGZlJRSCtZU1ZJeWVhUUJmN0hJS09ybGFLRVY0d1BaU0o4?=
 =?utf-8?B?eEJQdnNWbURrcVp2QVhBRGFabUp1aFlibkNCZUNxNjU0cU9SUDV1aEhJWWYz?=
 =?utf-8?B?VU9RYlQvNk8yWW8vZXViamU0ZDlEUk1QdU9VazFIM1NDOHlKN3JxV056RG55?=
 =?utf-8?B?TVNMVnZIYTdhQTBjekNWcXdXVTlHOFdBckpQbGJaTGFWbEJSa2VxcUFNNE5q?=
 =?utf-8?B?MFVNY2N4Y0xmMmlhSUR4VUo2aTk1TWpibXREbDRGQUZ4OElHZzdseXhsRFRs?=
 =?utf-8?B?WG15MDkzdjk2UjcwQzdsS3YzQVRXNU51cXBGdkdVZjVtRDAxS2VLZHYzQWlL?=
 =?utf-8?B?WWpTZWZBdHpSR1h0VEJvaGdTM2o5NzFZTFFMUGt6SE5seVBOeStVQ3VQbXhY?=
 =?utf-8?B?UTVlOU45RTlWdjRIUjkwNVcrM0hNdWJ3dityUmJkOVk5dUZRTk1oNWQrZmU2?=
 =?utf-8?B?YzY1OXNhMXdmSmluYzZLc3JIZHgvVHFzeTdSM2hoZUphZkNFRXBSbTQyUGFa?=
 =?utf-8?B?US9vU0piVUNnemtuUXdodFp1TUEwWS81aks2TDcwUDFMaWxBOTl1NUFaa3pI?=
 =?utf-8?B?eCtiTXVob1J2UUZjZmdnVlJkVC8zSnprNDhTMFEyMlYyWkEySUFKZkJSZXA3?=
 =?utf-8?B?ZUhES0kxR1ZIaDNUVUkwbThleW91NDRYWEtrTThmekhVOUNzYVRIMXVvbmM2?=
 =?utf-8?B?cWU0eEd0Y3BTSUZxVWVwendMNWtaZ1ZCOXA3UmpOTlVEOXhwRzhsb1dOZEk0?=
 =?utf-8?B?QmFwd0FsZE5UcTVSQTRUcG80VXNVTTFTTTRVdkdIOHhwZnpsVFo4SWxHc1ZD?=
 =?utf-8?B?ZDkyNmVUcDdwRE8wcXlFTXVaRjR6R1Y2RkVGUFhkbG50VUFYVjFLenlPRHVs?=
 =?utf-8?B?aWc1K2oxcU1HYkNTUmRmd1diNFpLeS8yZEJwMy8yZExwajBzVkhVc01Ebmdj?=
 =?utf-8?B?Y2xLcWRkN1RmVXNQc1ZxMnVpMGdiYWJhQmJUS3FJUDJ4aC9qSTA2eVArZ1NZ?=
 =?utf-8?B?Qm5LT25tc2FDU3B2cFNQcUdBSitWNmNnSzRydkJrOEsrQnp4MjlZZ0VxdUtB?=
 =?utf-8?B?U1Y5b3RVSVpuRGVvdWhLeWFrZGxkcHN0SEhLa2ZKbG5yOW5DUHdjYzNoT3lY?=
 =?utf-8?B?QXJCTjNhTjEyR2tHQkVOR0FnYnN6VmdGalFicG1QSERMVVNKTFVCSW8zdFpn?=
 =?utf-8?B?MzhsbFZqeFhSZTUya2R0OUdMdTVuU2kyczR1aHhob1N3UERTbitTbSttaVN6?=
 =?utf-8?B?UE9heDFubFNrMzZVUHNyQnZSb0pHdTZTYTVPWWt0MDdoWS9jQ1h0YkQrU2ZL?=
 =?utf-8?B?VXpXeDVFU251Q2JoVldOcDlKTVpLMjBDUmpPaElnMnIveFg2R2h3c1FNdmly?=
 =?utf-8?B?K1NNWG4vMS9jeDg5TjYxa1JxWW9PQVJNb2duN1lFeXBGZzI5OUtvZmd4U1Qx?=
 =?utf-8?B?dzRnbU45OHcyYzhqeVpoVmVjOXR0a0dBbEpqK0dabjBhVGt3c3JYUzUwU0dP?=
 =?utf-8?B?OXkwUFA5b0JXZEtMY0J6K0MrYllLUWZGNUcwMEVZZWdIMlN0Q2ppK0VPYlNP?=
 =?utf-8?B?cldoNzl4MTYyK2UrM05OQjMxdi81RmNCSnVEaEpieWVVOU90bkUydkF5MXFS?=
 =?utf-8?B?QWdlQ2hOTVZzQUVnNU51UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUYyRVhCd3lLdHlSNmZubFlNZE9CSExHR0g1VEllUzNUNXNSVWtpWTh6RUNo?=
 =?utf-8?B?V1VPbWwwWUhiVHVVRXdXY0lDWkZjSDBRTGFkbkxqc3ZCY3JQaG9wRGhtSmdj?=
 =?utf-8?B?NHpxd2dXOGVxbGtBcmh3Tk5xL0p0bU5GV2JSUStuM3hjaUZlYS9lL3ZTZzN2?=
 =?utf-8?B?cmh1Z0FvR0RiT1ZwdjVyaVlQUlZpSEQ2SjE5M0VuQXlNdTUybVNWWU5FN2Na?=
 =?utf-8?B?SWtpbEV6dy9DbEFXS1FVWXN4eUlILytkeW9Mb0c2N1k1MGRRcG5Sbnd5SUNL?=
 =?utf-8?B?N3ZwbmlQWW1DSlZPOHYranFQUXdscURmN2lDaXg0YkpIaDNDOFBxbDlwbFpU?=
 =?utf-8?B?RERld3hjYjlMS3BDeHNUUkhWRk5ML2M5TkY2MzI4MWdQUjF1TDNKbXdnWHRv?=
 =?utf-8?B?azlLVHdSWDFnSEV5TGZZdmtLYkNXV25QMmptb1Exb3V1V3pPSEk2YVI5b2Y1?=
 =?utf-8?B?YXlYUmJLdllzaG9FbU5RRGlsSFVqUFo2UWtZcW9XbjRRV213cUErMmpoSFlU?=
 =?utf-8?B?ZUk4aFZOM1hrSUUyRy96R2VtdXdPN0plMHZFcXF3R1MrV3gwWXZ3ekgxNlN1?=
 =?utf-8?B?SGhvSGU5aG5YQ0xXUFBIZ2E0Q2JnbVUzbW9FcXA2NHljOXk1TjlHbGo5Z0lC?=
 =?utf-8?B?aEZkV3R0OWhMbHFxaDlsUVZZODk3eFhWc1Z5blo0RkxNbmtyREh0YUE3SWdF?=
 =?utf-8?B?RURNeEZZY2dYNzI5amxJVVZ0WFNXRmRWdEZtREtRR1AycTJWSy9RZGpxWnFj?=
 =?utf-8?B?VVZEZEM0SGtyQXdIZlp0aDBrNnVlNVNlNmwvNjJiQTRlMGZibjV1RlpaV0to?=
 =?utf-8?B?WThxeFIrMlRXRTNaSFQ3WlpoYldnZnZJTnFQelpjcmgrZjRSWmQvQ2ZtcGxp?=
 =?utf-8?B?ckszN0tCa0ozdzBKL1ZuWG90NzZSRXNVTGVTQ25KZGRGeFJPbkJIVFFKTnFP?=
 =?utf-8?B?MWtPY0NHSk90L1gzZ092VWpiZW5GblNjNVVjVzhjQ2pqRjAxdTdKaTlEelVH?=
 =?utf-8?B?aXlsSzcyUlZGTEN4VDZOdEdYOHVYazgzM2hNcjVNejN5SE9Wak9vaVhyajcr?=
 =?utf-8?B?OS8vRlRhRnV6MHNXcVdwVVBOTDl3TC9GM2Eyc2JISFpOQjNFQmlvbmRtUHdK?=
 =?utf-8?B?WE5ieWhtMjFoNEw2aCtBdUx6amFESytlT2hONkUxajBrTHFwNUI2UXlXZDl5?=
 =?utf-8?B?Z0tIdnRyRnB0MUJNbjdGTDRVRGlpRjhObmNFQmRpbkpnZTV2MElVNldTVDVY?=
 =?utf-8?B?WWZrSHNBVnBRNTgxMkl1eS8xVXRwSTdRU2hFR0VRdGEwdW8yN2haaytxZU83?=
 =?utf-8?B?WmFPWnlSSHVEa1pwUkNGQ3NlWWFsM3YxdzJBM1NGYlFVK3dsTVBWblA2NGVl?=
 =?utf-8?B?MUR5c3FpNHVtRnFITCtmSS9HcXd6MXluMEtCOVF1TWpYZGdnK29UNk1NVTIy?=
 =?utf-8?B?eGlsNmhHaGh1TXJ4VnJhZVJaT2gvbG1UZEE1aTR2VG0wbTBmT25jZGp0ZVNH?=
 =?utf-8?B?NWJ3Z0JqZkZLU0IramM3UndEc3JmbWJKd05KZ2FxenppanE3Qk50WHJITGZL?=
 =?utf-8?B?bE02UlVzd0Erbjhubm1KT0ZleHYxQm41N0NxTXJWZm56UEdPKzdydDR4dXBs?=
 =?utf-8?B?d09hWkE2ZFI4WW1GeVI0RmdKc3pTVkNJZko2VFd4cmZLclpBMkw1RGxCcWdx?=
 =?utf-8?B?WEt4UnNBc3pMRGNYZVNXNDREWk1teUFYTHA1WWNDSnhETndwTjE4OTMrU2JG?=
 =?utf-8?B?Z3l1M1RxaFF5YlNEMzVLY2NIMTVVWnl3N3YyNDNKZXRhaTI5ZkNmemp2M09K?=
 =?utf-8?B?MCs0SXZCQVJLS2daMjRCUUpEbGJxaVpzeW9KK1lDQ3czOTRTczM4Tlo2bDgw?=
 =?utf-8?B?eUNhYk0raE1kVWN0dndUZk53ZUVZYjNZVFhjbEIxUlBYVHdTZDN1ME84cFU1?=
 =?utf-8?B?VUc5cXhsdXJvazFJUHdUTVJRRmxFSjA1VGJCb1BmQnk1b0xQTkFwNzFlK0Iv?=
 =?utf-8?B?YktnUFluNUFMQXA3cyszY29uYUQ5Wmp1SnhXV0ZTMnBId1dIdkUyV0VMMGgz?=
 =?utf-8?B?QUcxM1BnVnY2OCtWUTJNUUp0dUMyTGVFMnk2YStnN3plcmJqWThwa3E3U01W?=
 =?utf-8?Q?EyOE50dGMVAXkyKR5MEXzDggO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e26b27f-19bd-48b4-0ec0-08dc639f42bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:11:25.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwlb2fvIt7IAv8N4TcLa4nwm6duxrdFU92/vNF0TRGNojkVwrYHimh+LHmR9k1YZ1heHJvO8Pl4yAhYI1avefA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

Delete unused node in adma subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 5d012c95222f5..f5dcdd9405928 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -3,6 +3,20 @@
  * Copyright 2019~2020, 2022 NXP
  */
 
+/delete-node/ &asrc1;
+/delete-node/ &asrc1_lpcg;
+/delete-node/ &adc1;
+/delete-node/ &adc1_lpcg;
+/delete-node/ &amix;
+/delete-node/ &amix_lpcg;
+/delete-node/ &edma1;
+/delete-node/ &esai0;
+/delete-node/ &esai0_lpcg;
+/delete-node/ &sai4;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5;
+/delete-node/ &sai5_lpcg;
+
 &audio_ipg_clk {
 	clock-frequency = <160000000>;
 };

-- 
2.34.1


