Return-Path: <linux-kernel+bounces-158809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA18B252B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C124C1C21908
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD614B08C;
	Thu, 25 Apr 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzmbdrpU"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90BD1CF8A;
	Thu, 25 Apr 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059300; cv=fail; b=n33pALEyHdE1muHSK/m7gt1NrZaqgSSV5fM2dpy1G9I+qGYaUXHeschgFyZmyaDcPsD7EarI9UrgIi9RMkhRPwRvw3gk1Y82uqYQYXvxtJ3hGjimNgTU6TMkiVKC3bl1vMZe69tvrRHnrfeXvHCufXk6ANgcXdfo7Euwlgqlvd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059300; c=relaxed/simple;
	bh=ZkHRbbzmumSaGsE+/ljDDyVcXbpNuq6W6vJcwHIIZ98=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=j3eBZNg/sWLfvOsjJVqDEHg8WP5M5PWT6BV2j3Uewf10wqhXNUkKs0ZGpfwM/nNbVmDwe6L4z3Z8J6yqlFajHMiXngSb7SyidCGN+G5zkDRqdEfTT3c4+1cfW3ESlea2sZ+/hf+5M+5OEs+kwop/xFOw/6oJkFzaeAQ1WD8oqjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UzmbdrpU; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQARlcxXkzx4PR2BxIbyOeRnTbmlbuXgmUDxwAFBsCzjm7tzRa0SHlHoWSzzKksQKNvxcemmeXc3OGxC+rtaJ95kkP6BJUvjLoVvaInxi/D0gj/mFtPhemmk+nPdqRqV/QiJhT0vmfAvZ7cUuukQ3WEmLgIvisJqNdG59iUK5zNL8jr7skUpQMvNy12UePmDlV8y9JjWR2OXwxn4lAa7XHCz3h8xOKzOH2LFzN6zP8SgSUOvCJyxm/J04DePhUxGEC9/614egNo00ol9qZnvHUDxAGfdrYhZu0H9YZNIf8KTVzuZGo52z8C40VHai2fctjSG7AWQ4m870Ybk4kjaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/+Hk8PRdHtM4pvl9ueqaqoloknrvfi+d7L0BpGvuVg=;
 b=YLxich6peQyIZA1UshFkJ0XN9SoPML0mWpBP9VOw602qQhMqAa7lBB8z+bJWxt+VcgHt117nBwbEYwbE3PuXsmY/6rUd1nVXR3yC/MPvo9mBfOolOoOodzvytAA8I98jIvLsszZCJvEzH6zzSb8fjOu0frR21heIegQr6PuysbNTmJ34TniwkEnzJcudGhaaxYHQaInnkgaXbiWa+xZootYxaq6ryq/IMs/cEq+gmfQ8WNc4IEVJybrQOODh1Y3R1QEA9dPLtXVzJBrjBpwYbcuzQNUKteScKeO+7woWalV85ygYpShZHqzQB8XuTn2+biCCg84R2tTUp3C9wNgdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/+Hk8PRdHtM4pvl9ueqaqoloknrvfi+d7L0BpGvuVg=;
 b=UzmbdrpUeSQ5hcyU1shFKxZr/Fc6IMcjK3atpC/amKfR4RG4We32YhX7TMo6lfxD1GTrvJG7NYhlwisAvKHzFf50DSrS/UIVYZVcXGKwq2wkpr45HNxxSIAFKC99RfK+EQ/nRoCOKWuaZVbk1B1SOpLQbuNFsqOqPJmObbhRfmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 15:34:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 15:34:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/3] arm64: dts: imx8dxl: add audio support for imx8dxl
Date: Thu, 25 Apr 2024 11:34:40 -0400
Message-Id: <20240425-b4-dts_dxl_audio-v5-0-46397f23ce35@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABB4KmYC/33NwQrCMBAE0F+RnI1sNhvTevI/RCRpVg1oWxotF
 em/G71YoXicgTfzFIm7yElsFk/RcR9TbOoczHIhqrOrTyxjyFkgIAEBSk8y3NIhDJeDu4fYSEv
 eAYIGZ1Fk1nZ8jMNncrfP+RzTreken4devds/Y72SIAOuAxpfkINiWw/tqmqu4j3V44SrYoZj5
 kyMlqzXjspfricc59515gaUNUoddVnyL6cp1zOcMofKWPY2a2e/fBzHF+weFulrAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714059292; l=1670;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZkHRbbzmumSaGsE+/ljDDyVcXbpNuq6W6vJcwHIIZ98=;
 b=lEsNeZ8CR+sVDniTYvGaOqIpmJQbvXTUvw2RAEnnsU31EISu8iPbTNQJQ8hjua7YRNcmG3mq/
 Xax0XE+Cp9ACPMxBZC66+mkkga8FCe7lKFxRz74gOL/D5rVMj7as4Mb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f44477f-b927-4aba-3721-08dc653d423d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmFUS2JmSGtUWXFueFNsL1ZvMTFPR2N6OEhjM3lyVS9XM3hDWmtiQWNYRFk0?=
 =?utf-8?B?cUp5MlRCYnViSjZFYVMrdzRLSWNjRjNiQ29aRG9jeURhYmV1SWRJQzZGSTJ0?=
 =?utf-8?B?WmRUWk9pdmJhbWF1aFh2cEUyWk4wTkNhNVBodEZxSnREMS9MT21yTWVtQ1Fz?=
 =?utf-8?B?TWREMXBsRVV6T2xWaGJuRlowMGtkNXROMjZ0a0lxdkVXbjBodXZWendzc0Fa?=
 =?utf-8?B?MDErWmNwWlQ3eE5Cczc1VXRZRUtaSi8yV3FDaysycURDdTJ1TzFEdHJGdXF4?=
 =?utf-8?B?c0Z2VmVoOVZoMThZZ21kcERhbWZ2elp5am55eldjOTJFM290UVNqUkFnbHYv?=
 =?utf-8?B?QlA4RUxVVm5NaExROERpK05xRnVaZE5MZnBDNnlGbzdwYlVOaWxzTWNNUEhG?=
 =?utf-8?B?QWJ4OWkwNTVNZFpiUTFhUjhvSmlLSjRLdE1uckFWT2ZYUWF6SHhuUjliOGc3?=
 =?utf-8?B?YTBLRmpPWnVNMlppY3NqclpWZ1NOSmEzTXpPZnErUEFTSlc1UElUNjFYbVpY?=
 =?utf-8?B?UkNtN1U2Ym8rYnVRNmtjTnRPTW5JTmplOUJCSTZDOEhHOGVLVCtqY1JtMTFn?=
 =?utf-8?B?M3RMVGthQkhJR09rejdzMVBLSHNVZWF4c0JNYXFMLy83R1g5OFR0L2p1a2VW?=
 =?utf-8?B?RUg5ZDFHWFlwMnRmRkVVSkk2ZVVxc2FPcXdxLzk1L0treGl3UW42VXN2eFdi?=
 =?utf-8?B?aEQ5VzNleEJqREFVOXpwMGdzN0p2N2JLVm9Lb3ZRcFJyaU55QktsV1ZVajJU?=
 =?utf-8?B?TGR2dXpiL2JSeUM0N1l1Tm1CUExTNHBQZ281bmx3SHlQOWx5d3J3UzltSzQ3?=
 =?utf-8?B?TkgyK1RTalhBUld1ZGloakNycEdHYVlYd09Idzhpc2cvQzFNNmFzMUVSSlpu?=
 =?utf-8?B?bmRWeUZyanZtSkJtdVdqRkNOZXYzL1ZiWHRRdGY2UXZVTjVPSjRiK1JFMGNH?=
 =?utf-8?B?ZDkzN1doM3F5Qzl0OHc2cTJwOUtJckQxWmUxSGlVbzUvUlpDSlYrZDg5NzBB?=
 =?utf-8?B?eEJtYXRJdmZyYU5RZkt0cnovNjhGcUNlcGxCZUpxeW43ZGd4bHFGTG0zZ3lD?=
 =?utf-8?B?RTZtWHpyUFlrZE1mYzNQczRKeDJKL0xrUEh3QlF2NnllbUZlRzQyWDkxSFl6?=
 =?utf-8?B?Qk5SWlBXWlRESjNzOVRST1FmWUxtSHJYRitESEpzM3BDRkZuTUxQY1MrSHJZ?=
 =?utf-8?B?WHM0Yk5pNVI0SWJZZEVKMGhmTFpXL0hwQXBGL29pNHV6QVNGaVlQRUs4RjFB?=
 =?utf-8?B?YzAzbHdBR3JCSFV4MC9ETTA4dWU1OXB1SkhRWUdadVhLRzAwMUNHVzQ5RS90?=
 =?utf-8?B?SE5GS3BNUEU1bC9ENEh6cHo5WmdxcHZtTDNYczNocDlaMS9tQWEvdDJwYmQ2?=
 =?utf-8?B?VHQyeXJlT0lDNU9RKzJGVldhNmF4UkU4Nlp2eDZ4UFp0ZVFGaEpxS1hwb2d4?=
 =?utf-8?B?UG1Zd1NJbEFiNURVRmtGT0FyTmVLTDFqelcyekNQT1hZL2dtVm1MTGtaaXJn?=
 =?utf-8?B?V2tHNkxCbUNiNkpueDNGaXRSL3EvbU5oY3VhOU8xSkMzMXRJeXJuSnQxN0Ro?=
 =?utf-8?B?N0NraTNOMWpGRjhSZ1VGVFZjZVNPc0ZqUmEveVNvWjlvYnRFbm5CaFJFZ3Vp?=
 =?utf-8?B?bTJGWnNKOG43RzFRQm1YWDNUN2FFcElaSml4QndkU3M1NnIvRklvS3ZwWXAr?=
 =?utf-8?B?Rm9GUmZwVng0WlVNZTQ2WlF0MGxZYzF3V1VXTzBrdUZvTTFYRGdsSGVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXBzLzI4UXBhSzg5dHM0L01SWmtLRVFwVTZENVg5VW5FYys2Z01QQVM3aVlY?=
 =?utf-8?B?eVBZZ3JOdVVhTERrbWhKWVdXaHg5WmtUWWZ6Ujk1QS9VaVNhWWltOFRvYzk0?=
 =?utf-8?B?bTZVOHhwWlNXNVYyNTVnajBWQVlEb0tQRzcxaVFFUGNXOG1nYTVvZEV4Uzhy?=
 =?utf-8?B?Z1VSOS9IR1FSNExGay9JL3JtUnB0Yy9TTTFNS1NUdit3WDZrUS9zRnIwSmdr?=
 =?utf-8?B?WVhqalV1a2xEWVprVFFMOHRlYW5oUTVwRnlaRDJybWpFQ0VpQnJoRVh1aWJB?=
 =?utf-8?B?OTJGQTNzNXRPdHRTbXpWQzRFUDJyQy9PWHBSQi9nOE4wZ2JKRUZ4Qy93cDNG?=
 =?utf-8?B?ZDNoOXZaNWgwRDJIRjNNcXJwV29FRUduQi9kZ2c1RFdOM0lDZnlySllueW9G?=
 =?utf-8?B?SFRxQVJzdWI1UUtWV1Fkd240aGFQaFFSRndPRUc4Z0M1eEV0V01lVFd2UVFu?=
 =?utf-8?B?VjY3eHNBdXdVV3h4bi9ES2cwTUYwbzNMUzBNQU91clRFZUIyV0p5RVdMQU92?=
 =?utf-8?B?ZGwxTFBZZWRTNjdrUFcra3MybUNSdzhUT0EwN2xPZ29BWVhyNkdzMVlWYk9H?=
 =?utf-8?B?a3NWaTFKV3dGU1pNZWQwbFRwUmxjWS9DQmh5UXhRTTRJdmxwRE01bVRreDg2?=
 =?utf-8?B?RTRJcGlzUW8rRVR5NnRMY1hJdURobVN2bzFBdk5iaGlEOFhSeUcxM1Z4a3Z0?=
 =?utf-8?B?RFBmV1U2OUFkbklYUndVNVpSRXovRkVLSjhJOEZuaUtzcUhYbXl2dXoraHNI?=
 =?utf-8?B?dEEzcjVZTjN6Z1paTkJSMXR2bVMyK0RCT3pWNmJzM2V2bTVkR1o4b2xGMjVE?=
 =?utf-8?B?dEVzUWN6b29uZDVNczFXdGxQb0h6NzVWQkpWbERmVG5DSng0ZnlhVGpYQVFB?=
 =?utf-8?B?bld4Y3hlUTBTd0EwdUlqRy9IS0xFbnlmZVdjZFpwVVFZZkJuYnBYQ0pUeGJZ?=
 =?utf-8?B?Zks4Y3BZMzNiWURuVVFXSjczL2FzWkhFTjVNWEcrNm0vdlpYWDdVRzJGMTQ0?=
 =?utf-8?B?SHFFdDR4K1hwcllmNXA3eUVueDJEc0VnY0tEa2VtTVJ0b3hvRG5KQVJUc0N4?=
 =?utf-8?B?dXM5ZCtMR3pNN0M1cmlaL3hCd0pTS0hIVVFnTUU0S1NNWWFtTmpSSTAwRy9t?=
 =?utf-8?B?V0VRWkYyMVBkcGNFSEx2R2FUamplL0E3WGVua1ZlY2ZVWjhIay9hVWhCUWJS?=
 =?utf-8?B?N05OejFNZEVBVElsdzdnVjdKdkNUbHl5UWNVYnJqUWhFWWVjWGx0dUJGMzdt?=
 =?utf-8?B?d1lDN2FUYm5kelR3bWVhUVlIWTVQTjRZd2ZNblh4WjJ3dGxOVXhrV29nTUdm?=
 =?utf-8?B?MS9RaHJSNFRsOVgxTlNFWkYwNXVBZHNlVVJhazhNS1lkT2FWeFFvcmIvdkN0?=
 =?utf-8?B?OC9iQ3Z3NFZiYmJaeERMQU9mQmhIR0F4L1hsMDg4bHBNVjJEUUdyMXFxQ000?=
 =?utf-8?B?dG5EYlRlYkk0eG9tZ3Y5aUl6SjZGRUtnL1lSWmdVUkVuNUFvdlZvSVpaNFEr?=
 =?utf-8?B?cTRIcTIydjlZNTdTYitqeGpCbkdJa1pQN3ZSaFlRNHo4V2pqSkgwTnZqSXVm?=
 =?utf-8?B?aWF0UVIvNmJkNWV5bmlFU2pONENmV3lFaEwzc3J6eGgxQlk1WW1YU2o0ZHN6?=
 =?utf-8?B?SUp1T2tTQjg3c05XMVBsbEFxa1AxZ0dvOStIOVJhRUpRM3BleCswV01wZkU3?=
 =?utf-8?B?R0RZSG4vSENGSEtyT2xzV2lBRCtkazVSVXAwZzlJaTVHS2ZOdzF4OUJiVnlV?=
 =?utf-8?B?U0ZwTW95MGdDNW1TUkZtUDUzelJ4V0psV1dFRjA4ZldBWmgyM2xlZU0rdk9G?=
 =?utf-8?B?RjFBSCtRUmVIamt0aFEvVVl4WUx5eGN3S0lZY1ZpWngyeXpTZm5zVWZPc1dU?=
 =?utf-8?B?V0hYa05HUVVZd0dFZHpQYTBGVXRobkVjb1RWNEVzQzYvQlJpUmMwVG5vUDNs?=
 =?utf-8?B?NjU3VlRqMXltWENkcHI1TDBReC8vb3Ayb1RWTEZLNE42NHQ1SnFiR2pueGt6?=
 =?utf-8?B?anJMNER1NlYvdENsVUU3OWdlMEg0aEgxVE5nMGdiNW5uNVg1S0pjMzZtb3hm?=
 =?utf-8?B?OVA5VkE2cHBFSUt0a1FYT09WZlVMOFptcDVuY3o5aEFDNEEvWnBMV0xVYU9v?=
 =?utf-8?Q?jf+4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f44477f-b927-4aba-3721-08dc653d423d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:34:55.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KswqgY+BWDQb0uyLJMZOU4txQUIE+gRlDxBFIemanyU1amHfxE29MgI3Pcxy9hYHeK/nqIqe2Rmr4bqXYVKcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020

No new warning add
by make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- remove fsl,imx7d-evk-wm8960
- Link to v4: https://lore.kernel.org/r/20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com

Changes in v4:
- fix wm8960-2 and wm8960-3's audio-routing =
- Link to v3: https://lore.kernel.org/r/20240422-b4-dts_dxl_audio-v3-0-5017511f399e@nxp.com

Changes in v3:
- change bt_sco_codec to 'audio-codec-bt'
- 'compatible' to first
- audio-routing = "Headphone Jack", "HP_L",
		  "Headphone Jack", "HP_R",
- remove extra space in fsl,asrc-rate  = <48000>;
- align clock at assigned-clocks =
- using tab in pinctrl_sai<n>
- Link to v2: https://lore.kernel.org/r/20240418-b4-dts_dxl_audio-v2-0-e4e2747b3a49@nxp.com

Changes in v2:
- use general name: audio-codec
- move vendor property to last
- remove undocument property 'capture-only', since linux-next/master merge
txt to yaml bind doc
- Link to v1: https://lore.kernel.org/r/20240402-b4-dts_dxl_audio-v1-0-d26d25b84a08@nxp.com

---
Frank Li (3):
      arm64: dts: imx8dxl-ss-adma: delete unused node
      arm64: dts: imx8dxl-ss-adma: update audio node power domains and IRQ number
      arm64: dts: imx8dxl-evk: add audio nodes

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      | 229 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  78 +++++++
 2 files changed, 307 insertions(+)
---
base-commit: 2d13a7797c3970a4eea160844d8905c93065634f
change-id: 20240402-b4-dts_dxl_audio-74ba02030a72

Best regards,
---
Frank Li <Frank.Li@nxp.com>


