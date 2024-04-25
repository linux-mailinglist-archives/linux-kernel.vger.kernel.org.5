Return-Path: <linux-kernel+bounces-159123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F138B29B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEAFCB237EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CE15381A;
	Thu, 25 Apr 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JitZMDyS"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED02153811;
	Thu, 25 Apr 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076700; cv=fail; b=Blo9VI7/qaHCsfec0RXjuqtLpeLW4DSSsTs5H3JnEkMTysagJnIF7sj2rQ+u++gOtxBjFjO2JfbPcd+UbK9mILbq/W6u6RA1lthfIlon1ZyqehOE2fjzttWeMpvp5ZrdoEWee1pMtq/2ZFdyYLlRAN3CPe1V29VBpPzkU9W3oL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076700; c=relaxed/simple;
	bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lW6oipGDBq0ZdOKIX94KtAxxWqP4P8HaOPsWzF0e+cInxSRM0gDTZtp/lGRRwmXhdeAJERs4e8L1HfO/9Dnq9tTuKCdXfqIM2VXM9esA/gO+NeddCsigqy7wwHWmGMlbYEhRlUQrX/BX3y+PaevaKECqHLYLXzOrb2BpfziaISQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JitZMDyS; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1A3fCsDyWDGsuXcP+FzXBRYVQIOSSj/CAutT8e1YYOh81tOz86HduheJnkA5toYwFMW0e3vSRKXrSwwxdIACMzHWZMyFn1BDUvGNerC+aPrcpU5PHEf5bYfVj5NP824P2hcCPyKpgADFTaA7uHwZDbF5aD7bgIQ8rrRmi1kwf9a3uonZC3H+ZLaMZZYRHWPlHIqYwBiiHCQNLGlPcNtn7QwC9Ycyt3t7tqbE6xrk9b5YtwuT2Es6rbAf3RpWAME3fwoSXL+4p68sMBzCfzMIj/tPAdaeW7/uNc9fOiDGfdcKTyjZFJgDN5dzkIKmLb9Qn69IKSqxKOEfM5+sk45RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=CBlFm0d9yAmitgVs00mP4ca7Njgr8PkuXeYpmeihI2vydneNBfgt4nRcrATfa5piGuFXy4qUu6txMGDFmWNhBrxTDwDn8C9Nb19RuKKUXwJtnAJAWZZZ9tmWn10UIsC4tzFStl3DdhBTrlAVJp++PrHblP9XkRDiFOfZpg9jjQ+QgswFJ4RUsP41BpcKlbOZjqg9ALGqN6LnkTN8f8eZP3OgPnqOyQLM9kfAZSECYLQhsgmtJhAtyxBM9ALH8+9khRkZ/yUO9Od7vLREh8ZZHjRpJWVblGzdD5+dLAiXsTEC4AD1/rquoryiZG0HJoQ2FOB7s1o7n0ZIQnCyou/PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=JitZMDySmYEnS5EK+wA7kXZqSSp5Y/kAHENz2SbCjyBU0GooPif4Kw4pW0VWNg/cOe1DT/wmGpqM87R+hRgC3PKLeb5MaY7lT00eS3MbsVJgxn9uyCFUPIuaTUM3oLMQTZNtfPWh+0lvrtrM+ne5fpg+6Yu+bTUVzP7/KiCjM7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:24:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:24:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:37 -0400
Subject: [PATCH v4 01/10] arm64: dts: imx8-ss-audio: remove memory-region =
 <&dsp_reserved>;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-1-7fa6ab2fd64e@nxp.com>
References: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
In-Reply-To: <20240425-dts_8qm_audio-v4-0-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=757;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
 b=B7rmJHu0sRnlXMbZXq+tHhCnD93ZBT3WO53pv4IAZ7Ry+Ajs1RrA4/DJfS1EIvdEncj2qUTWQ
 5vumWeiiQ4MCO6hmlRTSGMARKcQ9JJKObjSjNhRNkhGHTkXly3J9Tg+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f179d4-8eaa-4ae3-28d9-08dc6565c3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0JoWW5hSDUvVHZXdE5pQ09VTVlWNW02dndSRkJ6c1NBdEhWVm5mRllubGFY?=
 =?utf-8?B?cExOamxla1FpSWl5ak5EZEhSaGwwY0Z3ait0YjVuV2NFOG8wZmRndUZkL2tx?=
 =?utf-8?B?VkFXM05RTkxscHZ0Z1JmcnQ0bXI4cVB4MDZuNVVMdkRjTGo1akNOdkQycTdj?=
 =?utf-8?B?WGh2NWErUkRwbDRQRmNYR0FTUUR5OHowc2pjUHBVd2VmOGkyR2owWllValpu?=
 =?utf-8?B?TWVTdUo4WkFWYU5yaDVrdDh5eVVzTVVrYm5qbFpMWmNjUDFVQTlOUndOOEtx?=
 =?utf-8?B?TGxFR1hWV2VhbFR6UUxEeG5ha1ptbkN5Z3NCZDYxY24vazlEZmZ6RTdjR0FG?=
 =?utf-8?B?dWNiL3VnZm1UWGlscm5LYklZcWl6cVpETUpiQ0FnZk55K0hhYXVPVE9kZjNE?=
 =?utf-8?B?M2FMSVBZTlpPc25idzMwamlWbCtqSGkwMnlUSzVFeFNVWUZEYUVETUZIUU43?=
 =?utf-8?B?ZFVYMWtTM2hMVWRIVklyUjNGSU1nVGd0eCtrUXNTY0g5V0JQWjBpQ0tQT2tx?=
 =?utf-8?B?eWkwT25RSEdZa2IvaGhmdDU5YlFBdk9UUExXdHJKZEZ5THNDZGdDVnQ4TWRG?=
 =?utf-8?B?Sk5tTnowSG1Tc2l4SDJWL0wxZ29rTDdxTE4vOUs3MVphTXBIRU85VWpPTGo4?=
 =?utf-8?B?R3Y4R2h0amFoSFNXQmllSG5PZ0dMMTBScHRGRzErUG5SYWx6b0xJNksxUG16?=
 =?utf-8?B?NU4zRy9qQjFnc2Nuc05aWjJKYzVhRVh4Ym9wMWxCMU85M3pDdlFtS1ZXUDM3?=
 =?utf-8?B?dEcydUh4THRrZ040NDQ1azZlYmdlVGZ0cklDQ2hLN1RVc0F3T2o4aitNT0xI?=
 =?utf-8?B?YkJ4bXlNQlpoOHdIUnRHTm5Bcm9jOXJrTkZtR3oySkNLYmtQRVFLMk5tR3RF?=
 =?utf-8?B?N0gwT3R0SU9sS0g4TG1zTi91RlVLM1IxQ3FHN3NvUzk4czgxUE95aWh6VVRl?=
 =?utf-8?B?eFRIT01iTUwzTHQxV2x5LzhnblNaZ0lLak1rN0NmSGdaT0o0RUpvNGl1ME9q?=
 =?utf-8?B?U21HMVpCOGpQMkpQR1B0Q2cxNjU0bEJKRUJMTkl0M25BTDNFSHl4SXpjRXY3?=
 =?utf-8?B?UXFHM0N2cHdhZjNWNk1CSXZVR3h1c1BZOXM0aWQySW1xVWNaSTNZZzVlZ2JO?=
 =?utf-8?B?TFlPdGs4Z2Q0TGgvM3MyUEYrVnk2Vy9obitQbkVodnEyaUFqN1VXVFdCY2hU?=
 =?utf-8?B?ekpFOU9DdmxzWDBva01IU2F2WFBpdGtZV2gwbE1nWVJsNjg4U0tmUFFHV1hZ?=
 =?utf-8?B?Q0RTMnkrSHIxVlByVW9BOVFVNTg0REk2MStZbFdEVnNITEJSTjU3NlgzRXZK?=
 =?utf-8?B?bldUTVI3UkFjd3dvMERKTkxkbjkrbDhHNHFCeWtoS1k4YXd0T0RhVktabUtG?=
 =?utf-8?B?RmNtc1FQLzI2emhJY1N0UzA0cmlsYnMyNDJlV29BSXVvWGd1NDVKdzVtOVBO?=
 =?utf-8?B?U3hHa2l4MHNBSFdGMGw2b0pteE80bEdUalNFMDVkTVUzMWJjYnl4VTQrSzFz?=
 =?utf-8?B?Qmk4aTZqQ1Mza1NrdnhLT2QxWC9hQjdsZFZJL1NRd1EwQ3ArRGduNGdqVWZN?=
 =?utf-8?B?QlMzT0VFZy9xNEdBcTN2WDFSVG5jUGlzMkRrUjJsRWtudjBGNUNIWkIrMWll?=
 =?utf-8?B?M2l2RUdlZC81ZStIOWhCNDRkZnJBcS9vZUM4MUJ3VDEyNjRObXBGTjFzMndt?=
 =?utf-8?B?dTBDVVpuQ3lIcEF5dXdhVXYvQ2pBelI4TElFbzk5c2wwa2d2ZE9sNVhoZmFE?=
 =?utf-8?B?aFNBUURLcEIrNFdqMGpTOWdJaGUrS28rVzYzdlNMaE8vbzZ1WU94WmNLRWxm?=
 =?utf-8?B?UHlIb1ZEekVCMkZNc1FZUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmVPOVhobHM0dGEzYXZuY1V5M1NIVkdrb293Tm5uWHpzR2ZabnE0ZWlPZWw2?=
 =?utf-8?B?WXpSb2dCay9pS1hFMExTaXZKcUdMb201cDVzczBrTjVBTk5WL2JJcEtEYTBw?=
 =?utf-8?B?dis5UjJwSkgvb3hFckRoUi9oVU5keUl6OHBvenN6WUV4K1c0UDFiNUs2dEtY?=
 =?utf-8?B?RGt0cEZ0MFJzSjRzbWhjWHdsTDVuWWhFeEFsUjh0Qzk3blJkTDBmNk13UjlZ?=
 =?utf-8?B?SXJPaDV6UnVlODhaRW1ZaDJwUTVQNUxFeDl3a2VMaUYxUHgrTXFHOXpEYnNm?=
 =?utf-8?B?ZHdxOGkxWDZPdHNFSUFMUDZLdTZIVlhsWTNncTJnYVdqWDNVczJDN1Q4VGRu?=
 =?utf-8?B?N1YzWmRocmhybVFRbjZpMUFGT01lakZJa0UwN0ZJTk5KUzlibEVQZTI5aC9P?=
 =?utf-8?B?VmlMR2tkZkJtVHdyV3Q4U0I4ZUNIdjFpT1htVEJ4bXRRWDA4VUZhTEN1Z3F0?=
 =?utf-8?B?QmdkZ2szRVZHT0pqdjc0R05xZHoycGEyYUV0SFczYVRrb2NWQ2thYXhCbzRL?=
 =?utf-8?B?V1oxSGYrZmVvdTdhYm44Z29jdWorYTdoOGZZSVk4MmVSTHRTVEprUytrTWpj?=
 =?utf-8?B?OEdFbVJ0cytFUVBXR25VbXBrLzVvdjMwRS9JQUJtcWlxRnlvVnl6dTV2SlZy?=
 =?utf-8?B?UnJEakpPS0NsL3ZheC9jc29KbW1lbGpBOHZ0WWQ2WXdDY0RDTzVPYmp0QUcr?=
 =?utf-8?B?aExlMm1EZmFMT0ZrNlNZdmNWeU5nU040d3BqbUZFNDlHblpoMkNESEgrdVRX?=
 =?utf-8?B?TjRacS9IbWxVTzlKQndQNE5Ua1gzSVNCeWpWbnVIZW95Tkw2VGlJazRINXZ3?=
 =?utf-8?B?Y3NpSFpWdE1RVE9xbjN1L09aUXRHR2ZLRjg3VG1zRDBiT3pHa3JjemFqU1Ez?=
 =?utf-8?B?L3R6L3NkRVg3ZDJCaUdJT09IK1BsRi81VHhFQjJGSG1JbFlmNm5sM212c3JD?=
 =?utf-8?B?ZXRBWDFnYVRYVUlvODZiT2ZnRUdoK1psdlpvR2xpYlM0N3ozQjFwMjd1ZU5a?=
 =?utf-8?B?N2RzNkY0TnE4cDVzcHVLR0xOUHBrTm55Nm9VVTRHZ29tMTcvTXBWOHozM1dE?=
 =?utf-8?B?T0xOQkJmcCtJMDJEWi9jME9CYVdaWHpleENOM3pZQ29ackZWQzFrT3c2SmxC?=
 =?utf-8?B?UE1ydFI3SHh2UjhzeU83V0pjcWkrd3lhcytWUFArL3hwR1V6UlpBcW9veHVC?=
 =?utf-8?B?S25UMzhCditBSlFnNlJtZ1hmVnE5VkxBOUZTVSthT0RGWVBOVFVZS1g0SFda?=
 =?utf-8?B?T0p1UlhZZ2xJZHpxdkRMN1Q1bGlIa0QvVEdScnd0Um5NV3hmSnZOYXJEYUQz?=
 =?utf-8?B?T2gwUjlVZzB1ZUJPeFdXcUZXMGFsYnAwOEJWcmFDTlVLaWtyeld0SDc2OHhQ?=
 =?utf-8?B?SWc3RjZDQ2RCUE9JdWttaVUxU1p6V1laMWIxaERZbzdXYTYyQjcxSmowbnhW?=
 =?utf-8?B?QUcxQ2lwYURFWkt5MExrZ0MrWG05eXBXVWFJY0puZFRncmZrL1BVdGk4NU9h?=
 =?utf-8?B?Sk13bjhTSkFxUzh0S1VpY2ZFdmIxSmlxbllodUN4UGFTaS9mSkJJWmxFOUE5?=
 =?utf-8?B?TngyRjVxdjhZYW5BOGlQcVpuSDNCRFk2Y2JLYTZIWXM3am5JWWZMZHEwdmVV?=
 =?utf-8?B?OTA0eEtGUXBuTGxsWS9mcEVZQ0FjYTJlanVSVFV6a2dsbjYzZkxTWkdwOUR1?=
 =?utf-8?B?czl1S1RmekVHN0xjV0NuOFh3ZnJndTBpSGN1bjVnTDRjRzJwelV5SUhSUzl6?=
 =?utf-8?B?NFhLL1ZOWUtQY3VqTmZRUENGeTJ1d0I2T0JTc3F0SGNsZmp2ZndDc2lNTEJy?=
 =?utf-8?B?LzBPQ3g1dUpUelNGejlaL1l5Tjg3OVhYUWp4OGV0NHVKYnRNREdBbWx0aU5r?=
 =?utf-8?B?MUt6eFNEakVwRTFPUE9naW14VVVrbUFXYjd6WjhPVTNhUnFHRkRDRVg0eXYx?=
 =?utf-8?B?QW1ZMEQ1a0VXaHJyVGE4enFFUm0yT1E4MVlEU0JldWRhL1BDVHNJdzdSUm5L?=
 =?utf-8?B?L3QvemRDUDN1eTBOV21mUTNiYmxHMVlRYkRBZXV6K1h5UkJjN2pLS1E4ZWg5?=
 =?utf-8?B?cm1QL3pKTlZ0cWk3d0gzb1lyVS91Vjk2eXh3am00U3I1WE9Ka1J3clBzMEh3?=
 =?utf-8?Q?40l7DYy5l6HG2p+xZWX8zTPeB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f179d4-8eaa-4ae3-28d9-08dc6565c3c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:24:53.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eu/KwXqHCTrSeKXa5u/WFRN75Q8s3MREj2bvygQjGT27dq5ixHP27J2uGauHoie/cV+STocUFHQ/fXNm9ep8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Different boards have different DDR memory sizes and layouts for reserved
memory. This change reduces future dependencies to add 'imx8qm-ss-audio'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 897cbb7b67422..ff5df0fed9e96 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -447,7 +447,6 @@ dsp: dsp@596e8000 {
 			<&lsio_mu13 2 1>,
 			<&lsio_mu13 3 0>,
 			<&lsio_mu13 3 1>;
-		memory-region = <&dsp_reserved>;
 		status = "disabled";
 	};
 

-- 
2.34.1


