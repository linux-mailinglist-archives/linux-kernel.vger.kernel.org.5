Return-Path: <linux-kernel+bounces-159125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1968B29B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1681F23DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD9155740;
	Thu, 25 Apr 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LTyWz1Ys"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BC155738;
	Thu, 25 Apr 2024 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076704; cv=fail; b=dzc3oLDyKRoTPmyLSD8Nd7VZ+mzc2MmbttZ7Mr1TsE4lmZo3oq5wKZZgA3D+uqE7NT3XBamrSsvAtKUeLUYcHSv/HnPr0MslQ21MjTqxWEDxakVw1fBhqYkQFRJkcXL+Y4r/mh6pLTxeOYpEohjJxEH6Ft35ZKoWMF7pPzZabno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076704; c=relaxed/simple;
	bh=BksCUPkX5pso8erTfLwxSdrIzwnxLVEK9TqKxi9mY/I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uH6RgnAkFRmAEuWYTwC7RqiIadXCgWY7HPayf4Gu+OD022a6glQ0QXahQJerBy8pPo59+ZwsnbeB5UJyjLKxTUaTvRm+UwQzgZ4PB07a1K32MA8smTxBGifclgEpRsA/4icvdu2jhV8GRKHvZyhwbsROwvlbxcmYhiymLspCu84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LTyWz1Ys; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqbTboNa2Ok9VhiTX0nO0BeSFmLOgpA6fP9D2RS7pyjbBSsyn3ITEEwig90JnWMOndEl3C8oAvfjQzSUsAUCVQsXdifi0xIrtYlw6Be0PzJA6POCLAHyEZQMcxEAZgFY/5Qtv9MQwZkJD8GD3mZPrTj6Td/TPhXBh+gziJVXzCdS4dzV8hMP7m/2O0+6/w/kFxoc4gvlNWwHxUZ1f0qCmCJNEGxANrj5j5HiseC9K5OQpmm23/WPDv6X5+P9T45kG6cFee5TGhplPUaW+okwMgAdrlceRsXxyg/jeze+aoa5B27X5F2wMNveoDdkSH8HApr4lPXMbWXGSlhY0Q8Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4hYBLAxRg/AcBx/aHMpSjAI/I+nLfEkT9ATv5cvK+c=;
 b=AtfxTwuXRChjhxfAkfOu2SoDLsTLHDmnouAlONw52cxrdtBGjQptr1Anf+NYeaQSXalK/klvUHA245hmVuYGOECpHXwvy364aAiQdOJ5smQFBj05RM1AhgGjICuc29RgJhiuxbtMsOHESQqy4bQd5mKLzrQDtcDScGGOlH7hhd7bfVtFGdZQVXTiqqgXIYP5AWgy1WWEI1Z7pKo4NJmBjuArOzDoFbnhpnawwllzodFIq3VrXVl/fR36XoJqDePlDv7mszl7mastzWR7vD2k8aMTJqVpEIaNBbf4kyg7Pi7gtLMfA4w4LDZUvxtXs5mczCvhvnh8H6b3CoygodVyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4hYBLAxRg/AcBx/aHMpSjAI/I+nLfEkT9ATv5cvK+c=;
 b=LTyWz1Ysh46BWZXQo1djc/BhPw8RJpej+LOv0C8Pkn556aGzbTA7uUJY492Sns+qw7zCVURLKlxjazCsbUqeFLG/DnM5OY9gvumPsFMksm0FD9w+f0/9lqpOsv3Bf5Bip0PkBqMRDW1oWt0S72HGSBh5tQYAl6IXrF6WS1H6xxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 20:24:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 20:24:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Apr 2024 16:24:39 -0400
Subject: [PATCH v4 03/10] arm64: dts: imx8qm-mek: add sai and wm8960
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-dts_8qm_audio-v4-3-7fa6ab2fd64e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714076687; l=5451;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BksCUPkX5pso8erTfLwxSdrIzwnxLVEK9TqKxi9mY/I=;
 b=AWHZGHX9AreLTx7L54NOCWjvSi2rJgbtgAwnF54W3XshbRoiuQTkbZMMI1mQG/WRBiFrUmUTd
 sp1mxSGl/STAUM6DSnvxdtGGYH5w3kANCAqqJNyNsfx/yv2vPaGkjRf
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
X-MS-Office365-Filtering-Correlation-Id: 7f33fca5-8ca4-4ca4-c290-08dc6565c794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkhCUUV6U2VvREdIZzZqWUN6enIzNzQ4YVpyRlZhNzE3UXZKYkQvcXhiRWpZ?=
 =?utf-8?B?TW5Ccy9pSFlCRWlpRXFaN3ZMYVI4cUxXNTVsSWJON0NIQzBhQXc3dEJSa0xR?=
 =?utf-8?B?VFU4bDV4cFBFbFdwNWVhTlpuZWRGR2NGTUVRUWtOSHZJNzhwdjV4WmJPZmk5?=
 =?utf-8?B?LzhJWDltOHR5bHJidlIyUExscmRNZEhRRFlUMXBPcXN3a3c1OFNqQy9yY2dP?=
 =?utf-8?B?YzlVVjEzNElEZERGMi9Gb2FrNFh1bVJnZHpmZUFJQVFQZVNGUGVDTXhvK1BX?=
 =?utf-8?B?ZUFPMGJYcjBxSW9uc1lEdUhLUWMxMEgrR3VwdGdXYk4xMWYyNnQvQVBBMHIr?=
 =?utf-8?B?alFKSUZxd0FHaUdjdHZYVHpwMmZQOG5CNkZsbHlrb3E3MkJKRUREcGRoWVZi?=
 =?utf-8?B?ejV6ajFEbjB4KzRreXN3dHpyZGl3RjZJbENUVWpzZEhrSHBiNEN5azE2eEt1?=
 =?utf-8?B?UzNXRW9zQUw3em9PalAyTUdxNTk4eHdjc3p1R1JSQ1RidVdZWStrNDlmcHN6?=
 =?utf-8?B?RkRRQ1hWSHVveGR3Vlk3RUxZTURZSDlRaURGMkVhRTZKaU5pWmlrcHU5OFkr?=
 =?utf-8?B?YVNtckcyaUdIQzBrWnlsZkFjcDcwMFBKZUYxc1JIdDVMYWYwTDg2aVNmM2xq?=
 =?utf-8?B?MmQ4ZHhhMHlKaDV5MjNsZk1uUUZabnNCOStHeGpZbHVxaGpSbmJRczVKYWdx?=
 =?utf-8?B?M0VTY25MRWxjZGhSajcxZHJiS2poSGRZNk4yNlFxaTVxNHczN2lGam9wWE13?=
 =?utf-8?B?SUpQR2p5ZlcxWXdGdER1SWRZRGFydzRwcEZnTHBVdURWcUZHbFZ2a0xlODFz?=
 =?utf-8?B?VkplbmhSblFoL3AwNzJsNmY2MGJzTE1kTTRNUG80TmUzZjZqYVhKazhxZXYw?=
 =?utf-8?B?cXAwYUE0SmNueEMvd0pHbzc2NGtwVGMza01sc255aWptTGNjUmRPNWt5RXhu?=
 =?utf-8?B?OTRFTVRmdjRGWjBBSVZSTWlwTG5IQlJmelQxYjRUS1FTR1VZa1ovOVZicEVj?=
 =?utf-8?B?dmtubWZVaDJkcFowd0o3Z3NVaXdpK3NLMGQwdzR1bDk5R1A4RUJVQnZDLzFm?=
 =?utf-8?B?bFhYZFpyYUIzS0dFcWpTME40L05ZV05LWkY0QUxFZjE4bXU1RDNoaXI5WE5Y?=
 =?utf-8?B?SXFxaE9nV0ZEYXBteXdna3E1aWp2K2F4cFBmYkVKSmhpYVUrTHlpdVB0RWlz?=
 =?utf-8?B?L2FYYld2K1U4alk1RDhJSXBSdFkxSHl5RWVtWFQyQnlhK3dkRGROdE1lNklZ?=
 =?utf-8?B?b3grdXRsUFFnRDNTWXU3K1lXVXlrRkFjZVZLZzdiL3liU3lBOGZ0eXIrT1Az?=
 =?utf-8?B?WGVvV01QTmZ1b1VFYzR6RGpOdElOUWJSN3MxTnhQaTNaRkx6b3JzSWNKdDlK?=
 =?utf-8?B?emppTHVrUk4weVpYSzNsTHJiS2I3T3k1ODYwMU01bVZJNFI5Z3BNQVk5QkhX?=
 =?utf-8?B?NVZGNS84Z2x2M2l4Sk9sMkRpTHNOQVdwSE5xTmx2L0gxc0gvOWVmdVVCQTZv?=
 =?utf-8?B?Y0wrQVhXK256aytnVWNCQWNuOURMWDFUVUNHeHZ4aUFpU1U3TVpIZ2cwU1pD?=
 =?utf-8?B?Y3ZuWit1OERoV1JLdjZDdHc4c0J3WEx4UXg3SkJCYnZYUnRMWEpCeEppcGR5?=
 =?utf-8?B?M2xQSmRua1NHUzFpcTZibE5YN1pyOHRzZ1hZTzF2cit5UGo2TUsyTkVrUVh1?=
 =?utf-8?B?anh2b1paYlB0aTdnenRBNUp1RmhKdURMNVp5VmhDeWcvdk9pNGZXcGRmeFZE?=
 =?utf-8?B?VG05dXNoTTIrRDk1KzJCUjJzQThoZFEraDRob0hsRVpXTUdpL0NNR0Y3a1pv?=
 =?utf-8?B?MElLZ0FwdTZkeG84QmcwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFNUL0luTFB5bG81U2lhT2VkS2RTOGFFWUlZKzB3RFdNdGJqbFZ6SzYvYk9P?=
 =?utf-8?B?SUVhdzJyTC9rRjZCWSttSGZBZWpuSEVJd0tQTE5JSEwzVUJIKzlqYVEwdVpF?=
 =?utf-8?B?N0x5VG9SVHlaY2FDVVhtYWJ6aVY3QVBtenV1dE14bk9LWHNrdjQrRmdRSG1t?=
 =?utf-8?B?NG1ZL09kQ21LT3RWbmp0YzdXNVg5UE5GZ3JJR25NMC9lQVFuaDExQjBoSStr?=
 =?utf-8?B?QTg3b09odmdSTUdvQW9vWlc0ODNobEpzTGZVUExsL2F3QnNxNDEvUGVFOGl1?=
 =?utf-8?B?NWxUcXZZM2paRlFTMFUyUE0xblVxWmlyS2grVkpRWFkwZEp6UVl5ZERCSXRx?=
 =?utf-8?B?NHhrWFM2bkVQVVVtNEphU0pJMUhNR3RHTm9UYSttai9KaUdGd3hueG5vNWJv?=
 =?utf-8?B?aEJzL3cyV2VaSTlJR255QUYyc0tDQnFPS3hpcVlLaGxiRGppVDg3L3FDa1Ni?=
 =?utf-8?B?WStCTEkvU2tRdXp0V1J4bkZGL016WGoyVUlPMEtYb1VwOWF3RXhXVDhJYlE0?=
 =?utf-8?B?bU5YYkIwcHRXajhzNm1DS1FzTmpFRHF2WnJkRWdPVllTSkpqcGI0aE5rK3lz?=
 =?utf-8?B?bVBwU3hmNDI5V1JaY0Z2aStyeFNwb2ZZaWZUckIrd2RQMjZPdklLZS9wekx6?=
 =?utf-8?B?U05DSGxvUDlZRjBFN0dVVWxyNjlFQk9tNUJ3eXhkeHF0WDE4clRQRG9aQ2U0?=
 =?utf-8?B?VDFWOHhHcTlpV1FMWllwUjFNdzMxVzVrOEY3RDhsSnFDSXl0cHM0K1Y3NC9O?=
 =?utf-8?B?dmxiM0greWV0RXYya0lQRzVZM21jTlFnTSsyQ0ViRkt4bW44ZUs1a0FJTHZr?=
 =?utf-8?B?SWhiZWJSZFlWcUN3b2JtWDJPMWt3eUhyQ0tkQmdxVUh2a3lvWkhtWXVlWGVw?=
 =?utf-8?B?TEdTMFlrTHpEMUpIcXRqZzRWSmRZek9jd0FGSW56ci8vU0tRZU5qY1NvMkRY?=
 =?utf-8?B?QThDOWxScmdNMytVNEY0a0ZCTjNHUGl2Y3o3SEh4Y3FaZGZmbmE1ei9LNlFB?=
 =?utf-8?B?Uk0vUm92RzVtWEI1SnZUcW9JKzFiQTV0WUllUnAyZTVmU1ljdU1jc0dRY3Bp?=
 =?utf-8?B?cURBV2VxVVlpdlhpeVdCQlhHdzdpK0Nsekk2YmEzNlhZV3h3bEhjeldtaHcx?=
 =?utf-8?B?ZDNUQ1VXYnFBeFFCemdZcldtOXY3dXZxdTF5ZGpsd1krZjlOSDlmS3hJcnAv?=
 =?utf-8?B?aDJxT1JvQzQ2THdjemhXYXcybVlvL3RPMjE5SGN4Rzl4OWNpdVhmNVc5N3ZC?=
 =?utf-8?B?RlhVNzdMaWNxaUZrMGtjdjVYaTkvcXpjbXJ1ZWNzazFDUGtoQnNEdTdkdTR2?=
 =?utf-8?B?UFdsaDJ6dXk2UmxNSW9lK3JYYWQyV3gzMGZFVjhPVENmRC9sUWpMT1l1UFVH?=
 =?utf-8?B?bW4zeHY2akZVZEN1N1phY01qVVBuUkY2RXJrZ3EyMFgyMVRMSmlhb2ZuVEdK?=
 =?utf-8?B?d0o3K3p5TmhobHJlM2orRGczVGwxVEQwN2I4NENmeGFzVXUrVGJCMHcvcG9y?=
 =?utf-8?B?U3J2NC95TGtOUWhvK3l2bTh5TVo1QWRrUFZLTUdJTFEzdU14Z1pjVzkrWXlX?=
 =?utf-8?B?aXEwSE94UVVzSHJNbkdZdWEwUUpIb1RNYnowTEpjcm52dHVXT1ViYnNFb1NY?=
 =?utf-8?B?VTBMdE0wMWw2VDlKYmJMOHRpMGZwZC9SMGFWNGlPRSsrNVdnbFhZMXVnMnhU?=
 =?utf-8?B?Yi9qQmJrQXFLWWVuU2t4ZDRRMlBUSk00OEd6TUFVTlpUNjliTlEyY2xxcWgw?=
 =?utf-8?B?SHJhak9MOE5sUmF0VXJIM0owQ1BEMENvTHQwdkdPYmQ3bzdQNEd5WHM4eTBY?=
 =?utf-8?B?VTR4TzdJM2szdVpmTzF4a0pFaTRKUnZYclc3NXlZZVUyQjYxc3IzeW93MU9E?=
 =?utf-8?B?bFpsRnp2Tk94UktIV3k5cFA5bGhPMHlEQUhFMjVMZmswbW1YWmhsbTBsT25q?=
 =?utf-8?B?RjM3czYvVWxkZjVydlQyNVZ2VTNMRTlTMG5ZeTc5NG14NkRhUk9wR0JaVVB5?=
 =?utf-8?B?b2owSXpYMEFkd2toMGhjUDZpVEcvZ1dVQTloZ3lNWXdESDZlblIzS1VwL2pk?=
 =?utf-8?B?dDZnM0VBeXJQTlllRjZiUHRNRExyNTFJT0lrNWdTWlFYbGN0eEY3ak9jVjJu?=
 =?utf-8?Q?gbPisG7o8klfKGvyy9/li9MsB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f33fca5-8ca4-4ca4-c290-08dc6565c794
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:24:59.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyyeij3LBk4S7Trm6ZdxAd2MslL6Lf8wwSu/mkglN8xrUVoqz+iPVFI4/fPLR8WIPFOCojQ66ND1OYDChyp7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

Add sai[0,1,6,7], wm8960 and asrc0 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 139 +++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5c6b39c6933fc..6bdda248179f9 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -46,6 +46,46 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	bt_sco_codec: audio-codec-bt {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		hp-det-gpio = <&lsio_gpio0 31 GPIO_ACTIVE_HIGH>;
+		audio-routing =	"Headphone Jack", "HP_L",
+				"Headphone Jack", "HP_R",
+				"Ext Spk", "SPK_LP",
+				"Ext Spk", "SPK_LN",
+				"Ext Spk", "SPK_RP",
+				"Ext Spk", "SPK_RN",
+				"LINPUT1", "Mic Jack",
+				"Mic Jack", "MICB";
+	};
 };
 
 &adc0 {
@@ -55,6 +95,15 @@ &adc0 {
 	status = "okay";
 };
 
+&amix {
+	status = "okay";
+};
+
+&asrc0 {
+	fsl,asrc-rate = <48000>;
+	status = "okay";
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -65,6 +114,21 @@ &i2c1 {
 	scl-gpios = <&lsio_gpio0 14 GPIO_ACTIVE_HIGH>;
 	sda-gpios = <&lsio_gpio0 15 GPIO_ACTIVE_HIGH>;
 	status = "okay";
+
+	wm8960: audio-codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				  <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+	};
 };
 
 &lpuart0 {
@@ -160,7 +224,64 @@ &usdhc2 {
 	status = "okay";
 };
 
+&sai0 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai0_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai1_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai6 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI6_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai6_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai7 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI7_MCLK_SEL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			  <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			  <&sai7_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8QM_MCLK_OUT0_AUD_ACM_MCLK_OUT0			0x0600004c
+			IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31			0x0600004c
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c
@@ -256,6 +377,24 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c
+			IMX8QM_SPI2_CS1_AUD_SAI0_TXFS				0x0600004c
+			IMX8QM_SAI1_RXFS_AUD_SAI0_RXD				0x0600004c
+			IMX8QM_SAI1_RXC_AUD_SAI0_TXD				0x0600006c
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8QM_SAI1_RXD_AUD_SAI1_RXD				0x06000040
+			IMX8QM_SAI1_TXFS_AUD_SAI1_TXFS				0x06000040
+			IMX8QM_SAI1_TXD_AUD_SAI1_TXD				0x06000060
+			IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


