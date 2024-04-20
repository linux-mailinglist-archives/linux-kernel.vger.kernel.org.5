Return-Path: <linux-kernel+bounces-152248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18A8ABB5B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E31B1C20DFA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C23D978;
	Sat, 20 Apr 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FTb0cmBG"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CD383A9;
	Sat, 20 Apr 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612196; cv=fail; b=i6XMO6JFFb6oRLmUXMMrFEsmNWHP9DgXwPpk3MErRmayIfP+IwlgPfSBTZQ4sNZraT1kyGCX7VunG2ggcmBAK0z1yhSJlcqYmkEMkiFGQf4z4zlT6LeEV6WzgSfKoIpapx9H1ILoMniGif5SkipIWt4U9nl2hwBtPnB+vdO1U7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612196; c=relaxed/simple;
	bh=FOsSHF9Sb+4GwiYHI3dstzCiSYA2cpTrl0HbCkVLbWk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jlpwl6KpC8nxoL5Jc2v22rB7EIuYpP+po6xn7x+2P494KzsUPWQ+n3A9qPKAJmTZyfTnECYhy8+3b8+JK5heMBh95hDK1Xc1L7vLLPx+XE+gcf0WoMx5C2pEzpWXBkyH5LZG72pLhgEQKnT5+1bnTKtu3VAIRHgJJRqVtOpKqfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FTb0cmBG; arc=fail smtp.client-ip=40.107.20.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzEkFJMTIOk5j71MFZl5dugpZEIVmESOwVSDngLMGWzdzpGr0ihyVWVUUZi4lX4mXfIPWC4qMXfW1Xra5C0QgrxFpkmdwkfGd9vqnVA/8KWKZ0VbOtSernrVEFSgzLalfsdaplbiRcZbQ6bq5s4Yo769LHDCCUTIjI9q9wrCCQ4FZZLWQd+9CuQC8rtpZPMF2BETD+mvjcpvMKjzO4Vg72ckVKiP9o6MN0rX64R9Ph/E2qP/VvsN+sD1CgmON0LcUCLPYVemX+csrLRuXUKDW1ffhr83yxYNLak28y+J86Z/HkSY2y3OeefYhA16aB7YnLNvHuP82vkmJ0zN99OvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh0X3VbLkcxkQr3MsxBzuzXI3LwXJ76XQtAmp5TTwVU=;
 b=SK8yio28Qr5gFWCUSS1OBds12m8eb53OVWSOAJN80qN1tD5ZZGkA1t6NmzLspEC9BfJkwHMhHhm6OGHqDnl11XtFctOdb98XJvhUM4mAZi89atfGFJJg+404y6McKrwMw8V+jeQh7iHiA+Hf+phnk0JOz2t8JE1Ph9jaSreHnRMScYJLE7ASwpHvA3HanCqrLDEFHr3MpLdbEHlzsCrC4MRvEz/B3d7/uH0Shbq1Rg1YTYSg1VyPvXYrg+7XoSdmvLTTAUnk5G9BJkUY0LvwK9qyZyzQ2CVURxONHbe1RRr29Qh/gL+2qgxFAj6+cVzF3rY8md4zHyUky//E+S3oQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh0X3VbLkcxkQr3MsxBzuzXI3LwXJ76XQtAmp5TTwVU=;
 b=FTb0cmBGKloNray8dXERHR+gF9GJN4/+7wVu88e3HhlCrH56HQbLzIwrgHMdLD93Ll3dnegI9KBX6jQSVsNNX1BkEo4YxU/cZo10PagOmVjw/fiQdtc2bPTUFxVX8G/bbXMX8GkqwhxsCWfLO9lJ25Q0tXhA4WCu2z2nk/5lGJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB7588.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 11:23:09 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 11:23:09 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Apr 2024 13:23:01 +0200
Subject: [PATCH net-next v2 2/2] net: phy: adin: add support for setting
 link-status-pin polarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-adin-pin-polarity-v2-2-bf9714da7648@solid-run.com>
References: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
In-Reply-To: <20240420-adin-pin-polarity-v2-0-bf9714da7648@solid-run.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 034ee085-5dd0-43b8-c5c9-08dc612c4133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUYrQzRGRHUwVGFOK013SEhFTVNYWVEwWnlQZnpIaEJWa2NzdkU5dWROMnNq?=
 =?utf-8?B?aFdKSU9QVTYwSUwwcXFDTTlabkJ0aGV2b1VEdVh2ZUpzcmNlVWhpTmgrK0hX?=
 =?utf-8?B?dmNOMlhQa0NsNHRhV0kxV2lJOXRVQVQ3RkpQVzROcmh1VTh4SUZWek82czA3?=
 =?utf-8?B?MFJmODBkMGcyUWNXZTdjL2Vmb0dtTEw5Sk93YWZiWjVJK3hSV0lTd2Q0aTRp?=
 =?utf-8?B?bnp4cVk3MGpaakdvYkhudTQxRE9zV3ZZaDBmQWxNSWg4bkZBZFhFVWVwZFNR?=
 =?utf-8?B?Zk1KaFBzMi9YbDQ5eFhQZVduNUh5NkhtcW1vYms2TnZwRGEzNldzZVo4c21P?=
 =?utf-8?B?K040Q0F0R1FsemtINkxmd0pMMldHWWs5OHdXbitUM3lRNm12T015WHl1SGJq?=
 =?utf-8?B?c09GdENJb3JsejRZUEhXWitQeENCci9KZDI2SE5Nd1VJdFFmNlNVRFBaT1Ju?=
 =?utf-8?B?RHpKNW5Dc1BxY0puaGMwZzRNbW5tVkxGRjFyYWtJbWhiZDlNUExZT0pyUEQ0?=
 =?utf-8?B?RFZPeWxkSkFIeTJOR1hZSlFEeDNwamJGVzhEN1ZpeWxmdGZHODFwMmduVnBw?=
 =?utf-8?B?czdtWG9ONGNyOGlodVZjVzc4ZWZuNm0wWWFBRGdRNEZsL1NKOFlzUk9pdU5Z?=
 =?utf-8?B?QnJxemRoU1V5TC9rMGorcG9JNkZhb1UzUm1LMTZJY2wwdUg0S1RSRnMySE5F?=
 =?utf-8?B?WFNVUStTODM4SHV3UHZZVEltQ3AzNnl4aUEwSFhEcSsvelk5WHFtK0tlWkdQ?=
 =?utf-8?B?VDdvYlBocGNldks3ckU2blRpN3lTbGgwOTMvZElUZFZDRnRPOFZLSk1yaUc1?=
 =?utf-8?B?RWR0QzRDZGQxVmQ4ZmVvWnd2QTRpbURLdVVabEM2L2JqQjRpVW9iUkVUMUhr?=
 =?utf-8?B?c0tTM1dFWkdoWXcwSHFweFdkMlZiTlVtbnBoMlg1SW8xWU9wNk53aitaUmNG?=
 =?utf-8?B?SlkxN1JOWGdLVnVRSnljY2NoWmNsUGd2TGZMU3BlTEUvN3MzdER0eThla3dO?=
 =?utf-8?B?dmtZN2FKVkRBYS90YkZGR3dPcUpVMGV0UE5ZaExzME1kZTR1N0wzUGp4WkFL?=
 =?utf-8?B?OUlsRXFvb0QwUjd5TklYSlhzQkJ4aXJUbnhUc1FNNU04UUdQYjBFcVdodWhr?=
 =?utf-8?B?MWR3aVV3VENndjBydWEvM1ZoSkxQK1VUeXpKUWpQdThnTUorZUh3S0hZWmk1?=
 =?utf-8?B?ZVgyeTFORFhrOHZ0MHZ3MWZNQTNxMkR2MmZabnZ5THhhck0rVEJuV0tZa2ZC?=
 =?utf-8?B?MXdHcHdXc2V2NzRmcUlqT2d0ZVY4K0kzUElMbkd0d001a2VNRzRiMC9EcC9v?=
 =?utf-8?B?T2Nwc01Zd0lNNGJDZkhTZ3ltaWlxMXc3eURXdU9DMHpDcWkzd2J0RTVjWkJY?=
 =?utf-8?B?eFA3RzAzT0h5UjdEWElMKzlRVEFBaVNhL2c5cXU2cnFXZnlJQTFxSzFaOWVm?=
 =?utf-8?B?dGk3Mm1HMnJzanZzcERvcVM2eUJFeEg0RytOTmxMaFU4Z1p1bWJXU2ltT3ZH?=
 =?utf-8?B?ZlBKc0U5Z01vS2xoc21pUm5IR091azREakdjVmEwajJ1YmFEcWdZK01IdE9S?=
 =?utf-8?B?VFl1dFBDL2F5eGRXN3pITWl4Ky9QU2hwRVdhT3VBU1Qzd0JrZTBjaTRQTk9Z?=
 =?utf-8?B?anFLSGJWUXZvaExBNFdLb3NEZ2FyWTZ6Q1F3bFlYdjZTU3Z6c2ljTW9CejVx?=
 =?utf-8?B?K0NIczNjdGJoMmwyN0xTbXRpNUE2QjdCL0F3am1FS0NmbzJudGlrUzdsMXBM?=
 =?utf-8?B?OEh0citTaGtEcFRYeVR6Z2pSYTBVM05UVkw5anMyUTdLTmVsRDhiMHRuTkw2?=
 =?utf-8?B?VWFvMVdjMnp1SldKdytDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2JaV3NBbE5KdnhuRXA4MXl3SzhKZTdBSUhBNlhzd1EyNnFTdDJUckNCVlRI?=
 =?utf-8?B?Q2F4T3ExS0VuZ3ZjN0lrRnBSRUNMd04yRE5nRVFPQ1JVeWwveDIyZlhVbDJj?=
 =?utf-8?B?NXBNb0V4RHpybk9COFdGeFVicU9QMldyZHhxRHRlUDRLTjBoVGhxcHpLbkxh?=
 =?utf-8?B?Y2RSYTZ5RFpsWU5xakVwMEhwN1ZOd2lwMXNSRy9GaG1xWXl1Y0pYeUJaV0do?=
 =?utf-8?B?V0dGUlN5clZ1KzdyTFRKZ3JMUXRBcDNvSGs1K0ZtdnE5OHFXVEtBZEtWdlhK?=
 =?utf-8?B?QzhaWHhzVW1KcTVIdW9wSFloTWUzWkhoOVBqOE02YkloZHZ1TGNGR2RkMGlp?=
 =?utf-8?B?a3I5cWJKZG5FbWRaVm14SUJENm1tZmhVQUZZWlh2S2VyazB4L1ZqTVFCekoz?=
 =?utf-8?B?SWRLNEhIZVhQT0ZBcEdPWUVwenhtTnFaWjI4SVF5eXNkRHRBbGNKUmpCMGhP?=
 =?utf-8?B?eGh4S09MUWl0TUZiNmtUb21IeGJsVGp1U1p0ek4rK2xwMTI4RHdKSDZFU2w0?=
 =?utf-8?B?aldwK1JEUlhWckJ3VkNDYUk4U2swWHBrVnphN3AxQnh6RmxxTkt6VDVjRUU5?=
 =?utf-8?B?MUR5UWlnN2ZhMXFkM0ZZejFjYXVLOVBZbGtiM3BKNVVlRU1LQUhVZDhiWExr?=
 =?utf-8?B?T3Z5UnVFQWNRSUJyL3VrZGpxcHJOR2c0ZU9ncmxBZlk2YTdReFd6VU42N2lx?=
 =?utf-8?B?UFhrVmVQOUJDTStHOEpveXBkazhwdThPN1hIODlUdjJDYkxsUWM5bmJnRTRx?=
 =?utf-8?B?YXNpKzIvbTdFZy9MMXd4S2UwSitRQVAvNkp3S2pPRFZGdyt6MkpSbVRldWsz?=
 =?utf-8?B?aVljaWcyMUI0VmZ0UTNNTDhOQUx3c3Q2eFBPZHBOSU9OanZwU2ZFZnF6V2ZW?=
 =?utf-8?B?ZEtBTXZNM0xjbmd0TUhkMlBlZUFBNzgwaW83YXBjQ1VEQTc1Z0haRGliQzF5?=
 =?utf-8?B?UDRZaHB4Qk5aQlhlZEw5Q2hYV0tBVkJQVXdYcURLT2VGc1NIMllOYkk3Y0Jt?=
 =?utf-8?B?dzVoaW1UWDJGQ1BuNFFXcnAzejZXSUxEN1F6V0hoLzZKUkxVS0FFbUd4Q0NP?=
 =?utf-8?B?cWcxYmZZWW9LZUtuSDFQNFFmTTJ3eEdvdCt0YW1HamZrSUFFYytEWE1YUjJ4?=
 =?utf-8?B?am9ZL25nQUxHekZwc1RxcWxYVlNraGluTUxKZEhpMjY5SlRwNFRvK3dwNkhr?=
 =?utf-8?B?TlR6c0RRUlEwQmVtS2tZS0VuZHdFbng2V2pPQWt0UWcveTFYSFRqbzI2cWhn?=
 =?utf-8?B?MWtzSlNDaXJSWkwvTHRDUTlyc0ptM2k1c3dWSkEwZ1UxZmFPT0hPRXBJK0Fk?=
 =?utf-8?B?bzF1K1ZNNFk4QnBYWWhVV2xBL3dyZDlFcUJhbkJxd3B3YjJhaEtsL2JCNERK?=
 =?utf-8?B?L09XZ0FuMVhBSW5FOE9rd1FsRGU5RmFaMlo2dGJtRm5OVUtpTDBwOTRFYXZ6?=
 =?utf-8?B?Z2kyeFI3U3pJOTQ5bXltSm5GeFdPUHNkSzVMRWdkZzREdHVlMFRmMDlLTVBm?=
 =?utf-8?B?VEx6MCtRUDBJQjF2dFRVVlJCelFYNy83Y1RrZFVOYXN1QXFUMXcrUDZ5bldy?=
 =?utf-8?B?ZFM0a1ZtbklvMW9LQzBNVFdKK1lEUkNOYS9zU003ZjRvWnhuVWt0S1VKOU45?=
 =?utf-8?B?OVFNV1B2RkdoRm16NjdLdTRjR0FRelpGZDRwODJFMDZvS3g3bHRjNllFNlg4?=
 =?utf-8?B?RmZqeGN6YjJYeWd1ZE9Idm1FOEVaQndzZkpLNEJGU3FwbjN6RFZXMHRYeDNO?=
 =?utf-8?B?R2VKbHhQd2oyTWVHYWVCNWtreTNuQ3BLbmY1YVdzZUVYODAwOFpRdlNVSUdx?=
 =?utf-8?B?a3ptUS9FTkFjZUhtQnREdXg0Y3ZkVDdLN2JOa1A3L1NNYWR0U1l1d3Vpd1dm?=
 =?utf-8?B?dE4xZ1g4T1lmelpjUzFUU29kdTVmRkkyNExBekJsTVp1WXlQVGRDQ015UEVQ?=
 =?utf-8?B?QUhQdVZ4ejd4MEx0eDhSd0ptenl1U0ZvV3JNYmNCZ01ERWVpblRhblFXaTFk?=
 =?utf-8?B?UXdlYmxXemhwRHUyOHhBNkJlQ2huSXVVM2FSbnVSWjJvbDdTb3FQNmtqMUZS?=
 =?utf-8?B?aUJHbXdpMjFiUEZydVN3VDRzaE85V0lPeFMrbWlBRlp0ZThBRkRJQ1ZhTHVZ?=
 =?utf-8?Q?KfvPjv5q7i0Y91njJ1Bg+ZAld?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034ee085-5dd0-43b8-c5c9-08dc612c4133
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 11:23:08.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue5glX+Q2IEpZsTtLwJiwlC/TSe7mbx8wn7r0GyhiNH22NGLWoSmdSS2CTbn8DCnb/5V5YZ79A3iGDfffNYQOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7588

ADIN1300/1200 support software control over pin polarity for LINK_ST
(link-status) pin.

Configure the polarity during config_init based on device-tree property.

Polarity is only set if specified in device-tree, otherwise the phy
defaults to active-high during reset.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/adin.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
index 2e1a46e121d9..a533932afcb8 100644
--- a/drivers/net/phy/adin.c
+++ b/drivers/net/phy/adin.c
@@ -158,6 +158,9 @@
 #define ADIN1300_RMII_20_BITS			0x0004
 #define ADIN1300_RMII_24_BITS			0x0005
 
+#define ADIN1300_GE_LNK_STAT_INV_EN_REG		0xff3c
+#define   ADIN1300_GE_LNK_STAT_INV_EN		BIT(0)
+
 /**
  * struct adin_cfg_reg_map - map a config value to aregister value
  * @cfg:	value in device configuration
@@ -522,6 +525,28 @@ static int adin_config_clk_out(struct phy_device *phydev)
 			      ADIN1300_GE_CLK_CFG_MASK, sel);
 }
 
+static int adin_config_link_status_pin_polarity(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+	u32 val;
+
+	if (!device_property_present(dev, "adi,link-st-polarity"))
+		return 0;
+
+	ret = device_property_read_u32(dev, "adi,link-st-polarity", &val);
+	if (ret) {
+		return ret;
+	} else if (val > 1) {
+		phydev_err(phydev, "invalid adi,link-st-polarity\n");
+		return -EINVAL;
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+			     ADIN1300_GE_LNK_STAT_INV_EN_REG,
+			     ADIN1300_GE_LNK_STAT_INV_EN, val);
+}
+
 static int adin_config_init(struct phy_device *phydev)
 {
 	int rc;
@@ -548,6 +573,10 @@ static int adin_config_init(struct phy_device *phydev)
 	if (rc < 0)
 		return rc;
 
+	rc = adin_config_link_status_pin_polarity(phydev);
+	if (rc < 0)
+		return rc;
+
 	phydev_dbg(phydev, "PHY is using mode '%s'\n",
 		   phy_modes(phydev->interface));
 

-- 
2.35.3


