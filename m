Return-Path: <linux-kernel+bounces-18911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E5826508
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA763281EF2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E513AE4;
	Sun,  7 Jan 2024 16:18:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2081.outbound.protection.outlook.com [40.92.59.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5B13AD5;
	Sun,  7 Jan 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOEhPQ/ydo4e8hH2WDVH0Xdd+i6jpY2ywattcUF6HFr0LXvC7aXrt8mvf2mnDTWdHgfprLY2dvI16bSzhbw3r6bJDWe+uE6lWlJ7k3beUS6vCJEFiR/3AExorHj+KnumEhZVZC9w9bn+vSCLPC2SAgyZ4unZzcRWVq4sPlgkPDfbuuva8y7/DqIw76NfCLzPgSKnORqMXNlwE1WpPKapL2rgp1iPCkTjtx3RdgMq0OeU0cMMxS41MNe8jqIm9Wg1IQjLCHVknQ6tKYKujJw98st64nwAKQIrZ5trW6qVTNqwv/6aFuvQQJ5Emi2Qp25NvlNFUuP8Gojk9o2zHOs9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfJ608z6DqTQSEo42Js4e2+l3qdmHBzThX0Rd/+1r94=;
 b=QJCxfyfWheJYmA8JzvaXp2sbYoEFerPFTJoS1awSTv0c1iEXh/8QcTfZKdDg+kOkdESxn1TjeMfVVDBnOUqlsBHY/TFMzhFNGbC17I8wX/fQILErd6y+LSA28Ii6/ObddCRIcoDCJYfS+XIqRlpGxqtzeVJASlwSQSe3meV6StjDrrll+2+j6nEthZnqrvHWTVXf3TBPpJjGpo3dXrteHRjblKjiOC0evFhn6AqeSFGCQL+h7abNlnh4u/luDvl+0K8ZNSIdNcM5W61SDADufVR2vHpZ15feftpqhngsElwgXWD5KAU7yycFzXE1tb/5jYszYy1WgOspCdn0LCCvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by DBBPR03MB6729.eurprd03.prod.outlook.com (2603:10a6:10:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 16:18:13 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 16:18:13 +0000
From: Sergio Palumbo <palumbo.ser@outlook.it>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH]     net: sfp: add quirk for DFP-34X-2C2 GPON ONU SFP
Date: Sun,  7 Jan 2024 17:17:57 +0100
Message-ID:
 <AS1PR03MB8189FE82C632EBA97644D70082642@AS1PR03MB8189.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [6MiRUswoYghdJmNK6n6kZf8jqOU5B0gM]
X-ClientProxiedBy: MR2P264CA0095.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::35) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <20240107161757.6179-1-palumbo.ser@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|DBBPR03MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 305ee087-f50c-4bd2-9969-08dc0f9c3f15
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iaO8KmwYBuAhETc1WyH128PY/5FE2Dtej7qCjBIjJ1aIIYOFIMBWLv6DbmxcDZ4j/0QNpijii3d9mQo7m8JmdIENDAA6EqGfHRROTAXVmyoZYNROaCq8F0SUJYGcZoooNsvYUZIN4snJqE1+ZgFZZX/ePNEl+mztBa3/A6cuk14V6GLrCfOIYab4EIM4bZrE9mBqc4WjMJhNHhN7LIh3Q87LFWIRitCxSDcYaEt7D0GPOVnHY77M/oCwpE2qrgXbCVu3VHeRLtKKJ2BI/VwH0VgZm8J3pUPmsJhD7AmVk/saKxB2jqD0JrhORdfSwXu3fnFhhjoZQJPDXGEXrJCsMgvIK+BYe0ZiFJkQU9/DRfwhh1JAate/JzAZsSReTOffuVaZ/iIP130EDQk41vLick1jOgkuZxaroty3NpC8esKS1Qcgi0Fl4wIDnIOLz/dSxX+Gcp2+sHxmokfpx3tfgPu8Nca1D4U2ewBCmeESHwZpG+eyu75Z9DzzlnnH/hw0T7DWTRYrw1EUy/eyF6GuJusE245iclYir/u2K6ZtXgW5jjHdVBz14BVmm4Z5a/Be
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Rpdm1CRk5qVW9zODRsd0V5OUVvTU56RDV6NHVMVDJFNFQ0VmhPWjRLazVv?=
 =?utf-8?B?OGpwR2VHQVNUSzVoOTliTnl2RUlCZWVGS2ozWms2R0x2NkVEK3dPZktVMVVB?=
 =?utf-8?B?ZXA2bzFHSU91NmlvQWdMVHQrd1N6SndRdmhNTlRRTUV3ZmtIM2lSQlVGUk5C?=
 =?utf-8?B?cEd4b1VhQ3VFQklhd2pmcnE1a3lYdkNTOEtUTUlVM1NuN2JzQUZoQzZuUWp1?=
 =?utf-8?B?U016c0duZVBvWm5GbGZKS0xjWmVJRFFTbFArV2YyeGdld1lqT1RTbjZjei9v?=
 =?utf-8?B?OWloOFJYZEN1RHh0ZVRMYjV2bzRBS1NwZnhvRkRmMzdUZGx2K3FpZndFSS8v?=
 =?utf-8?B?bC9xeFREcHJWbXIxSTM0VFdZL2lvd2d1RllMb0srZWh1RjFYYzVYeHpDSU1J?=
 =?utf-8?B?YnN1ZDJDNk5TLzZBSHc5d25JazJnSzRQcGd6aGdhN0o2NFYxcmJYSTV4TXBE?=
 =?utf-8?B?bDNMd3VCcExKYkpVRjMrN2JDMlFUT0VsVUVQektCZXpIc00vUnNQZUkvaEF4?=
 =?utf-8?B?NnpvRnUvSjlwY0lqSytXczBacjR4SS9vR1J6S0FMK25RTGJGd1h6Z3c0MEJq?=
 =?utf-8?B?WlZ2NDdlRHBKcGVnOUZCNW1WY1krL1JRekkwSnpCY3d6SWE2KzgzWnlGMXFV?=
 =?utf-8?B?Vk9KRzFMNFUvTkpsSFZBR0RLaGJJWXRiSjFLaHcxNlN1aHJIS0NzQ1JKZkpn?=
 =?utf-8?B?bjRtRGpTYTN1M3ROSXZuZXJVTWlBTkNZbmxMd3Bqd0xabXJOUCtKNWVYYy9m?=
 =?utf-8?B?Uk5ydC9vOTJhdG54UHUyOE04M3MveVFmTjNtU296QU9Ic3RzZ0FjUUN4Szl5?=
 =?utf-8?B?MjFNcXBEbHU4WDEyYmxqc00xaHl3MWh0MEdIaTJXUS9DSHQxZG5uVzJlSDlx?=
 =?utf-8?B?UXVSYVh0Wk14SXl0RWlka0Z2OStseGQxdWRPd0lwRnZnVnZ6VlhHM1FjY1dW?=
 =?utf-8?B?SVQrcVhkUHdKSG1ZekdJN1lhYW1jRDFZYkM0ZzVhdHpOaU5xUzJwV3UvRThn?=
 =?utf-8?B?ZmVSWHRtdmkzSjN5NlV1aWJaaHVTeTEvdnpaYkEzSTI3dkR6aXJHS3N6ZnVG?=
 =?utf-8?B?a3RVRVNBTm9NNHU2dyt1MzVqeDg1bmlpT3dMQm5IUTVKSjBuQ3ZONHk1dUVu?=
 =?utf-8?B?TDF1andsaG53bjBsZnJrZWpQeFBJS0pwZEFUZFd0VkszZXlIVS9OdFFPZ0k2?=
 =?utf-8?B?ZVVnY0dNWmVxUytLb0xlWnlzdG42dXhOd2lURUVRSk96YklaSDhiODRIVWN2?=
 =?utf-8?B?blJNdVJXM2lWZGN4YjU4R1NNeFdDeGFPUDRWY1VNTmRidHJKakJ5dmZiN29y?=
 =?utf-8?B?bDNIcElyRG5ObytpMEpBZDVubHZhOEZTWTRnZ0U3MzFBOHFzak5abk9ZNkwv?=
 =?utf-8?B?U09mdGtLVzJFdDhkQW5SVEFXRjNseHlkVklnOW5RdVRPMW5CbGJML3paelFY?=
 =?utf-8?B?ZGNKVnJucWpZUGVYNkdGS2l6WllxN0hnU2F3ZnJsKzl5aGcxN2lRWllJbktV?=
 =?utf-8?B?My9LaDNBVldhSWszU0lYbzNZZ1dUNUdwSFVtcFhyODZXUVVDdFcwSy9MY3JD?=
 =?utf-8?B?cjQzQXQ1WDlJZm5JNzNQaTVoTWZJSUhkaU1mSWtwR0NWY3JYSHBlSEt3TGty?=
 =?utf-8?Q?iZcZGE/poN0rFij291OvO+vllKqeRGVlAdeRrU4LwKHs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ee087-f50c-4bd2-9969-08dc0f9c3f15
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 16:18:13.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6729

    Add a quirk for a GPON SFP that identifies itself as "OEM"
    "DFP-34X-2C2". This module's PHY is accessible at 1000base-X,
    but can also run at 2500base-X as per specs of the module.
    After application of the quirk the module is enebled to run both
    at 1000base-X as well as at 2500base-X interface mode.

Signed-off-by: Sergio Palumbo <palumbo.ser@outlook.it>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..1a447e3567c8 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -506,6 +506,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+	// DFP-34X-2C2 GPON ONU supports 2500base-X
+	SFP_QUIRK_M("OEM", "DFP-34X-2C2", sfp_quirk_2500basex),
+
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 };
-- 
2.34.1


