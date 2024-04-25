Return-Path: <linux-kernel+bounces-159126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB28B29BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFBA1F23F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347A155A53;
	Thu, 25 Apr 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nKrOc+jj"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEE153BFF;
	Thu, 25 Apr 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076706; cv=fail; b=FRmFKMLVYwxoGHT/YluBueKSEa3WidAi3/0x/c2441T56nVHWaMx7EG1BCyXFslGVnkJdyxvGWGobpPgeXi6CCKe1O01W5JIaxuEVFmPHoQ/F0NtKFsVBAG1UcNlaE0ydce9KEBmvtryD/R250ueB2ALCgPy7UiLNHoQ7jYtaU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076706; c=relaxed/simple;
	bh=9fmIJkFw0KfxOK2DM4bhQ75RCjeHF50mZasUegU6tNU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uvJ6hOQBoCup8HIcmJjT1R8CuRtj3C0jpBp1tpTIjjt+9Mjgq7J2lEF8qsR4v17EeC6A4Vtf13Hz0nBZlrdYPpzlZ2ntJwaEuCiZqf9q/ZzoJGqmSofhJHzYkKu1plF0X4EvZ4gLGDE4VZVDOGC7Sd+bW5p/kadj77Rbg6HYoXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nKrOc+jj; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs6tnYnliLtiWndE/mPc85dhMU21hYnnfcr+O91+SOEmJU0cGI+3G2YSwmRyg4zNRmDpwqe7V5mt+Vx/YTd9HrMtkEAlddakPMDFfHfEBcx3Gxb/2ppgGmb/hY/tpbyoBkuOJeEmPfKx62banoJfOHS6o2dLNKcIKc0Tl924+TF74NH06vqy3fAUDROPZ5wdGkjxMSLiv2cuF3UlAJ0tjvG/9s1uAVNDMNuWJLeaO5Rm/aDqxCrYtoAmKkmFEkksFMyP675gI9Us2QVPkvsebky+4aQY2O03ymRl0htH92XkwkdSnXKfJGpX7CtIk+FFHKlo5ZoVlpl/KMzREieBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCmlxCGGOsWaHIEylor02Ed86ZbePw2LfOO0jMhY+z4=;
 b=k2YPPWrbyomt2OGq7c3FMwYhuMnzelCnc6yylh9fyUSMSRKFXWAai95Je79iix3GsqAzqGdYEK9ngFM/+AgfUYtQ4rikrIr0H3IKXB+oBkbsr/Bt5SasxMyQptusSbSDbnADbP8UQWvpg9E5konQsvK9sR0pVxjUCImQqGCAISNVk/THA4d6R9Y5OFd5qibeW+8Rd6Z5pnD2W24KtPuN2g0CnYd/t4waMHM93qq4g0n7yZCLdyYykYwUQeTPwPKMu+ZSzIOGoHeqNIP8DJ1vxBQBwUZo2hpivXvYb+R1adRsd0/2ra985FKxX8Bh9XUEhVRfyzuCtCNQnSXlPJCsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCmlxCGGOsWaHIEylor02Ed86ZbePw2LfOO0jMhY+z4=;
 b=nKrOc+jjgAtGLo6EknZxTnV+1UoUCAjLwhMi3ttPf0KeEo8PZ3GxmhBynkCYkIsemduQDaK+F2eEQSPaQIT/EWO16tJbJMIQ9LN8/LjzV1yYk0v54ZzkWoCXE7LwjyXphoHYPVqMJgXzz3S+j26rJFWT0anKHNZJpQwW6nluyXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:25:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:25:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:40 -0400
Subject: [PATCH v4 04/10] arm64: dts: imx8x: add cm41 subsystem dtsi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-4-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=3140;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9fmIJkFw0KfxOK2DM4bhQ75RCjeHF50mZasUegU6tNU=;
 b=a/yLUJqNNeXsnS1259tsnWxvqbXJrUFOqpGP1+iakAFeg0ZVgcHzltqRtwQf5L5pvksnNvd4v
 hrUK4eFOLEaCIm0O1gzPpU7/IyTD5ONAqZAhOmN2F4HtLvpwenKOz7c
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
X-MS-Office365-Filtering-Correlation-Id: ba09da5e-5d4b-45ba-7c06-08dc6565c967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWV5cTJ3dmowM09iV3REWEp2Wm4wdy9iWlQyOWZKQkUrTnQ3OG5oNXdReUFF?=
 =?utf-8?B?d21lejhONjQ1SXpuMWlubHgvS2c0ZWMwVWw2MmQwN1I1eVBUSGhZY3ZScU9U?=
 =?utf-8?B?aWFZU040ZU1iK0RHYWo0QzhyUkxUSHgvZDY3RDU0RUd6UXpQTXZGMHBBWEpv?=
 =?utf-8?B?R0JSUzdoNWtibFgwaVVYMHh5NXEwTjM5cmplRjdWVERFVlE0RWd6aHYwb3Vh?=
 =?utf-8?B?WWJqVHJxNWhDS0p1ZXNBeGFUK2FEdGlEMGZNU3l0dUNsTEVRSkRkUXpjelRU?=
 =?utf-8?B?SkdxQ1ozRmZ0a2w4bFZXOWdicS9HeVo2NVJZYU8yenBHa2ppL0h4OGhaMGN3?=
 =?utf-8?B?QzMxTURQeXRYNjlQZDZjdjN2Q1M2TE1XNXhSYTdNU3d6RVZhZG1PV0JzMktj?=
 =?utf-8?B?MmcvTDRZN0FxRk1ad3RIWWlNNDlMR1FrSjdXZWtDN2RKRkJRYXNyVEhJVlZ6?=
 =?utf-8?B?anIydGFPV21ncmZLQTZ3bFVLVnNlRHo2SzRoYUVSTnk0ZERTM2lPRElUMElN?=
 =?utf-8?B?c0pzS2pPN1Zkc3RJbTVBTzlsWkZlMTVOYTExWHpaTDZkNHZaekhxb0Jid1Ar?=
 =?utf-8?B?ejE1N28vbE5kQ2kvT0xnbERVb29NWE1pZVRWTkxWdHV4U2VnSnRXdXhWODFQ?=
 =?utf-8?B?RTQ5bU1OSzRoL2xvU0lXYjVjY0NZVmxWTFJ3V0N2bGcrSFUwOHdaL1cvcnVH?=
 =?utf-8?B?a2VLOWFSTmk2QloxNHRKSEdvSVR4THh5U0xmR1lFL21OT0lKa2JLWDFGazVR?=
 =?utf-8?B?dWVtMkw0N0xiM3A0Ty9iL2RWL0pqTDZXN0dadEpSbzFVMnlMckNUWVR0ZjRz?=
 =?utf-8?B?NXJna0ZLeXFTS2M5aVphTzBMak1zQVFJeTh0WWtOdVlOVFFvNURUWFdhSFVV?=
 =?utf-8?B?ZGNzeUFLQmlhb2tENDdmQXBzQXFaQlZ0VGZHUjZDUEpyMjczcWFQaVY0R3RL?=
 =?utf-8?B?V2xORlA0b1ZBOGsrZ1FIdjZ6cjNXRjgyZXFsNjhtM0RpaUNyT0ZNQzlnTFNi?=
 =?utf-8?B?K2RZYUUzc3JxMGJyYlh2b0FYZHNYYnZlM2FmMWVQcmwxUDdBWXJWNVVEZjl6?=
 =?utf-8?B?UWxISDdqd3VQblFuYWsxNktLcW5oVzRvd2ZJSzJUcjdrblpqY0V4RlZETURG?=
 =?utf-8?B?M0lXTUxEajdNR01VZThBeGJUQm15ZE5SMjlva25lNXl6ZktyTmlUUUh3ZTNJ?=
 =?utf-8?B?Zk9qK1hreGVZWG50Zlp0elJvRGY4NmRIOWl2VVVPWmNRKyt6RXNLeGZyOXFQ?=
 =?utf-8?B?U1JZRXkrb21qTUVRN1NGUDFZekQvOFhRMHJDYzE4eGo2M2hENkROa1crdnQx?=
 =?utf-8?B?QWwzWnkyQTNMUHpydld3YWlKU1VQNVY4WS84VkxwaFdVT3g3c2txRlZJZWwy?=
 =?utf-8?B?M0JXME9WV0paZkVaSTB3VDNjOVBJVnNxMmI1V0Nqdk4zMlFmS1lzNkFlNjM1?=
 =?utf-8?B?WjRrcEJLZis4aTBGWXQvcFNrQUtBOERyYWZXbVRIdTJ5TlB2M1hIZ1ZkbXls?=
 =?utf-8?B?NWczRTBHUDFseHBYcXB6a3FIRUxzQnQ4S0ZoOGc4NG9UMVBoK2k1VUdUdmRY?=
 =?utf-8?B?WkxTdEpENFBVVm1GWUNEbEZQQVYrUXZ1bVBxTkdid2FWODZndmFmb1owaTBW?=
 =?utf-8?B?U01nQlE2dUJGVXcxNkJBRDBvbWRlS0F4eHI5ZUlST1BReXJwbk1DSW9TTTZx?=
 =?utf-8?B?NSttd05ld01wTDcwMzl4T1l0N1YydEdMUU05MUVneUhPaFc2SDN3VHRGalRj?=
 =?utf-8?B?SDhrQWlvTDVyY3Y1U0R3SFpCMHJUTy85dnpkcE45M05IM25oOHFBbzlDQ2RV?=
 =?utf-8?B?MDBiUHBzUlZURDlSaCtZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVo2aWNUcVM3R09zbStzemJVQU1SeE9lZUFQNkd0eDlDaENnZ0JFdGh4QytT?=
 =?utf-8?B?SytFRWgyY2p6T05xZkZyMEdOWGdHdFg1ZWxyU3B0bXhPNUdPL1JoRHc5NkZF?=
 =?utf-8?B?UFowMXpQVUJFaTdXVHFucDN3ZUlNS2s0cHdYYy8rWmlpTmxhN2pxTjFnSHRP?=
 =?utf-8?B?Mmg0WjlWNCtsaTlEbW93bVk3aW14S0RsdVRSTmExNG5sRTJwODVqSWpack9E?=
 =?utf-8?B?Qm5IZzFmKzQ0M1BhcW9hNW5GNjhReDVYUHI4cGpTSkR6aGJybGczZUx1QnJx?=
 =?utf-8?B?a2lQOUpxYVZFYWh3TERBU21HbkJMU0JKeDViS0YyYnc1R1ljSlRNUk0zWWVK?=
 =?utf-8?B?ME56R0ZrSHhrbVYzdmFvRUZ2OHpGWmx3ZWFQNDZYTmlXcThZbzNUdjB2RHR4?=
 =?utf-8?B?YVBkY0N1ZGtXaGpBZlhHMkdyN0tML1VhS1kxRWNMcmE0ZU5JUDdsVjRRVVZl?=
 =?utf-8?B?SlVOSUM1Vk1YQ0RuU0tteDRHU2pkSE1rUlhrL1ZUcCsrRUJxeW9CVVRwQTlW?=
 =?utf-8?B?NWcrZHF2bTZiUXR4aDBMenkzcjVUVjc3MWtOTk5pWkhqTjYzZGhuUUYwUFgz?=
 =?utf-8?B?eUxFQi91eEpXQXY4TXZzNHRaTEk0SGZRRkFVZDVtZDNBMnM1MTJHdWpNLzFs?=
 =?utf-8?B?ek1HMDk1NGZCR2Jyc29aSnh2bXYxdVVaMWZ4Nm1nRE1DbEZCaE9mWVpzSU1N?=
 =?utf-8?B?SEsrc0JJME4xQU8velEvaldtTmpwenppMkxWaTZsVUxMVVloWkpXZVY1UFJF?=
 =?utf-8?B?ZEdYNVdZaXhJUmZQWnZ1eVpKSDhBUURmV2RJc1NEZUxvZVcvQ2NLWGJvNXEx?=
 =?utf-8?B?d2pXQUFmeHBGVjF3MDFXNElYUXFucmsvbGdxNzZKYXIvd0lqdEtROFUwdS9h?=
 =?utf-8?B?djJIZHh0bnA5TU9JS082RDl3K2hUVTdiSG45VE5GY2RLRXR6cnFwUHVTMldT?=
 =?utf-8?B?QllEaTIvSzJLRW5UVWVhUmxhemk0ZFdJWXAvNTRrUEJrazBBMWJkb1VSb3pk?=
 =?utf-8?B?SFU3LzVqK0VNOFNVR1FxZTE1d0haQUFtQjlPbGZDTGhORDhISDk3cUxnN2o4?=
 =?utf-8?B?TWtsZmNydEFJQWErSkhqQkd2dTlycUtWNGNXUzVGVHo5S2xiRHpPU3hpQ3pD?=
 =?utf-8?B?dnl2M1RrbkQvSHZWT1FqKzVXbUZxQURzMmlhM3loN1R2UmhzRWI1VWFqMzYv?=
 =?utf-8?B?RWR0Zng3dVVLK084M1ppUlZsZFphYURlUWgyMzNXRTRESlZPdzBHeCsrdkdq?=
 =?utf-8?B?T3FsaUlTNC9HbVIyZWtaN0ZKSDcxaitrUVlENnl4dW80RFFqSnRYRHBvQW04?=
 =?utf-8?B?d2tkKzFlLzM5emdydkp0YmVkbTJOWCs0ZlpRMk5sdXVDSFlrWnNqSU5XTnUx?=
 =?utf-8?B?K0pjdDA3YVBaMVc4cE80S0d1a2g0dXdWYWZDcDEyeGdvRlRtcFp5SDMvT05R?=
 =?utf-8?B?Qlc4WHpkc3F5eVVBNExzUjhZU1cyMGtjakRiV2tweFRybE1kQ002eEdvcnBr?=
 =?utf-8?B?STRMQ3VyNmZWUXFKYTZ1OHRTZEtoYVVEOTdmRXBVZ0F6eHNYVlBVQlE2YlVo?=
 =?utf-8?B?cG9TZ0VwNEV4U012VEJPaFBhSFYrWHZQRHErQkJndTRxYUFVeXJhK1YwYTlm?=
 =?utf-8?B?TjZ0ajVyNGNYRkJEQkg5NkdaZFJLTHJqcEhRb3BsbjFQT1p6SGUxdFQ2cW9D?=
 =?utf-8?B?NEluWjYxSm9tNG5FVE1iMDR5VFhpSmh5cm9GT2ZzNnNaQUVrOUN1Q21sc1hD?=
 =?utf-8?B?VEhFWERROHFyYTNNVVdIN0d3ME8xcjBlcUJ5WUNBL0lzenhUSnNHb25qeTlv?=
 =?utf-8?B?R1dRQTNZcHh6d2JPNUZNdjJ2MkJNUE15em56MmdsaEhlMVhka0hNTGhUS2Ri?=
 =?utf-8?B?QWVUTjJaY0Y4N0VzVWZhczZoS1FLdVhxTzFJWi9xOUVFTkNINHFJM25sWEJh?=
 =?utf-8?B?a2xQbFVSUlBab1pXMXZqY3F6a3R2TWFYYmNxVk91bGxzczlFOWEwTDI5Qktl?=
 =?utf-8?B?MytWUGZXOGZ3cXR1ajZTbUNFVUJrbkxXZ2dxdFRNNWxpZndOV1RDOGIvSWJW?=
 =?utf-8?B?K3ZwZjg2TUNraWFjVHBWK2RQNkFEVnZ0Unh2SzhQTHMvekNDd1BhZUtqNjM1?=
 =?utf-8?Q?mSNZljvJlq8N7aJ+BHZaZo2ol?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba09da5e-5d4b-45ba-7c06-08dc6565c967
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:25:02.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFZfG/YXDJ6HjFtoxH/B6tsiOsmjzyjC+Svm4IQcwdSfjQUuAonhhG3q4ZN86yltuKLLoE/5+jcQIgJvPyrjgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add cm41 subsystem dtsi for iMX8X chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi | 68 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi       |  1 +
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
new file mode 100644
index 0000000000000..d715f2a6b0378
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <dt-bindings/clock/imx8-lpcg.h>
+
+cm41_ipg_clk: clock-cm41-ipg {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <132000000>;
+	clock-output-names = "cm41_ipg_clk";
+};
+
+cm41_subsys: bus@38000000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x38000000 0x0 0x38000000 0x4000000>;
+	interrupt-parent = <&cm41_intmux>;
+
+	cm41_i2c: i2c@3b230000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x3b230000 0x1000>;
+		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm41_i2c_lpcg IMX_LPCG_CLK_0>,
+			 <&cm41_i2c_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_M4_1_I2C IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_1_I2C>;
+		status = "disabled";
+	};
+
+	cm41_intmux: intmux@3b400000 {
+		compatible = "fsl,imx-intmux";
+		reg = <0x3b400000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&cm41_ipg_clk>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_M4_1_INTMUX>;
+		status = "disabled";
+	};
+
+	cm41_i2c_lpcg: clock-controller@3b630000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x3b630000 0x1000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_M4_1_I2C IMX_SC_PM_CLK_PER>,
+			 <&cm41_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "cm41_lpcg_i2c_clk",
+				     "cm41_lpcg_i2c_ipg_clk";
+		power-domains = <&pd IMX_SC_R_M4_1_I2C>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 6092d70b10b97..8e94ffe1acb57 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -546,6 +546,7 @@ clk_spdif1_rx: clock-spdif1-rx {
 	};
 
 	/* sorted in register address */
+	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"

-- 
2.34.1


