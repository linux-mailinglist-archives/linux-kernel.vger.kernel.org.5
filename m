Return-Path: <linux-kernel+bounces-166453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979E8B9AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3511C210C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552F1E485;
	Thu,  2 May 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kowJRAlg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1A59148;
	Thu,  2 May 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653142; cv=fail; b=pqIvxioEYOXoDGn4CM01w/mZZd7OJ+b+CXU+oUy5Sm2WRPLlCxGjIh3biIq8HSbNnkVG1/3FoQRMjZknLIlfYerF7iZjzEEx/zD+/vM3iU3IE0RZ6TCXN+NBqgvN0yuRF5pQTvBkx+9A2IBgGEsdgrMdloorlW2PwuZVH+NRX9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653142; c=relaxed/simple;
	bh=mQWroSb7kMnehyNzCCHX6s2dTYjFnSgTfg/7QjZ2uJY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XPtVYu4kULns7Z7ZD1YCAAxsdm6No+miIRbZ0/oO+zf3Q5YzMZrqW7gL7uMpLPjzvaL5bUD4gvDGU4YUORuYWbnKxfYjwibe0kbUYsAhloU0e4sbcElj7tNYgt7oaH+Kv7VwftqSJAMt6g+FmcTMjWQOwJ+u7uTaNw9VuDp1+zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kowJRAlg; arc=fail smtp.client-ip=40.107.20.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoyQka7YpBKlOPje3/YHQHixLsTOLk48/F/Hm2fLOGZ+aL097x/Pvbqa3NOvZfSyOhlBUBBzvtfW7OS234dvC5mQaMyQmSWczJJmtspQDqb/+W3PR5lflmza9MyZiVhQM1Tx2BvRBi9JVLSiXbG3AwTAqfABceNAF0mhRyUazm+Tsi2MmHNLOmvaNRH7raEZ5f9d2tcekFrkkoN3I9kh2Tpb9f5tpYQRgkzPWPcsB8VC2Kjzv32WQ1gwfGUmnz+L4EINmawZLmk6RbDfjtOjv+BBAdE5TdQoNTtzaVmIdpegUJWjD1ejsmCtsx2H4Sx6KUxQJdPy9bqZIvlf4+N+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=D4VPr2Fi2aHeLTHG676Cl6Mqg0zP3nxnCNHIpdsY6ids1ohriZSeWdmIn0TQH2BPRGZ1QLegycsfmGEztSxrStWZVgwl1p9H7jihcODMB8UHO3d9/lDA8nZM58jnvzIr8ht4c9fQ58m6EzobrwnFEfcDxT1vA8NKvEkUoOmmtP0bYk7a4Zut1LSBuAjrBvoGVU+jClZwJF38pxZP1wm0zHfn7NNDF8jv2FXb+4jgBLM9FZB3o6Y/3MYPowqF9KxICG6at35k2DPx0y1nJmiJV2mke0kIbU2bhymX/5rGUjgFqSNrbqn3Ir9tAO+LcWt0y60L7CSUQlsqS9avoqxZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlQy4rBk6ixkdbPr4GAxyRHBN7NhXDroHp6p2aHDx64=;
 b=kowJRAlguNM7thN2ZXSXHLwieidH2/ILQxmza4prC1UfjZplh3B6v/lswf5HEu8mDzBzcZHMc+nGEUvkuNP8jLjFE+KqUA30Kw+yv06BKe+rl1y2ZfzgHN72TQjMeoxiMEHAvF3lRwthXobSborOZKb0L/z27wdauLn3YvMeItU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 12:32:18 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:32:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 02 May 2024 14:32:16 +0200
Subject: [PATCH v4 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cn9130-som-v4-2-0a2e2f1c70d8@solid-run.com>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
In-Reply-To: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 7335ac84-deae-4fe8-1f59-08dc6aa3e7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2Nsc21DWmxnRS94a2pkZW9JMHZPbVRDN0dwc2p6eVJjUFkwMm5vVitYbkpK?=
 =?utf-8?B?WERQK2Ird2R6Z1A2UG1nTi9rVXlBT3Q5S2MwU1ljR2ZhaE9YR2t3SFNjeHkv?=
 =?utf-8?B?NmdjMzA3TjVVVUIzTGFPRXBUZUdHWTgydW16YlUwb1JHYkREdlFjMEhCbzJ1?=
 =?utf-8?B?T25LRFpabWFIS1NEUDhlVmM5RlFMSDhKMThHUnZ0bnJmcG5remVRTDBobG0z?=
 =?utf-8?B?N3BxMHlySG5paXJPb2R3cldCM1VHZ08ySHE1VVlxdjNmRUthQ25Id042dWU0?=
 =?utf-8?B?eVBFcEhDeHJyUGtoeU45blZhR29GODV0TnBja3gyejBieDhseGtoWDNEVjhX?=
 =?utf-8?B?SGZEWHVGWi9PUWZ3SC9VV29lRVhsV3IwRjU3eWgybXM0S29LTi94SUlSRFI4?=
 =?utf-8?B?c010M1FObEV5b0RaMUVoZlcyR1phVFd0VEJjcVYyUE9WMXdMeFBZTXg0MnhV?=
 =?utf-8?B?bnBteEp2TmZaMytLYUdrWjlFVDRQQjNQaXR4djh2MXFOUCt5cUx6bzA0UEJU?=
 =?utf-8?B?QzMxYzh2cW92V3BzYnFCQ2J2MjJiOTEvUHdyMTFlbkpvcnV5NkFDWHpjMHpQ?=
 =?utf-8?B?Y29RemR3M01GVHhGcUg3ZUU3VVk0QjFIUkw4TFZOWHBVdkdzZ2NlVytydGhG?=
 =?utf-8?B?THpKNEtvb3hBcHF6NTlJMVNzVFFKRHh4bG5jTTR0UVlteXlYZS9IcDVFOGxL?=
 =?utf-8?B?djNqL0Z4a2V2M3liL250dFdMeGNrbVVaNHdoWXN4alJ5WFdLNGNSOGkvZUxK?=
 =?utf-8?B?KzY1R3dLVW9lUVhuNXVmSnJvVHBIWTE4U1NSUFhaa1pvcEZXdGxUcXI3bVdk?=
 =?utf-8?B?YzBWcHRCdTBrb3FRZWRDUW83OGZyRDZQTEY4RnpYazNYWSsxTDFYK2d3V2Jm?=
 =?utf-8?B?bk1aQmRHU2dhZ0xTZWVMRjkxMGtuS0YzbzJlY3NwYlJvSU9kWm1XZ1NvazBq?=
 =?utf-8?B?UlQyeStaQzlKT2libGg0d0E0SmdtbVNqZ1hQTXU4TDJDVXB2S0llblFlOHFu?=
 =?utf-8?B?S0FDTi9Vd1l5SXRDRUd0NjBobHM5WU9EMnJXOEE0Mk1kN1Q2a0p0SXVsbDhP?=
 =?utf-8?B?SDRlVUhlK0JjS2lxK0duemdwak1jZmw3Q2Y1REV5Z1NldG8vK0tIYU9IVGFG?=
 =?utf-8?B?SUJnWGplVXJqNWhkSWY0RjhCR2gxVXRKV3k4NzNMd2NRWHpXUGxNeEQ0d0lC?=
 =?utf-8?B?QUpUMnExUy9aSzRzZnh3dXA4dGIwazRncFk2OFJaOE5mOEtNM2xxaWphY3hB?=
 =?utf-8?B?VzdmZjF2MldjOE1XWDJmSXZxYkpaQkRCWEpWZ3o5aTRZNkkxOEhKbSs5WGJO?=
 =?utf-8?B?bzVSZFZTbm1EczBXUWFGM3hzK3QwM0tlZXB1WHpiZ1BLazdjUG84QXJRRElO?=
 =?utf-8?B?K1d5eVM0SlZ3eFJhcTMyWCt4Q0FvMEtJa1I2U0pZQkFmeHZ1Y0tTbDJwekdI?=
 =?utf-8?B?a2ZhVzdGZHR4M2N6QjBEY0pOeVRuWXZRMlhuRVpRUGFxTlZzNGNLTVpyY3ls?=
 =?utf-8?B?RmhtWnI4dEU1cm5aS2RiY3ZVaVdjU1U5WnZrbDdWUDhzVmFycWtuS004R0Zz?=
 =?utf-8?B?TmxxTVphWkNQQWlqVGFWMnlNV1F5YUlOd0NoNkZKTXNmZDhxQkdSVXdUM09j?=
 =?utf-8?B?cFdCQy9Ea3ZMMkZjWlZLYUJyU0VLUWE4dnJnQnpnbTJMaU9Ra1dsRGx6NWZI?=
 =?utf-8?B?Rmp3VVlXUlBIRHd0TEZabkY3V1BRSXNTZmwrcWlJUkZJaXBlRWJBRlFSaU9t?=
 =?utf-8?B?cC9pbGFWN0lneHFwUTB5dU9qdkhrUjNrKzUwWGM0cE5Db3ZDRFJEaTRIdmlN?=
 =?utf-8?B?dW14NHVQMkNQR0g2VnJNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjQ2VmRQa0dqODVEdXhEdzNuVGxrVlZxRlpETU1TYVRlUE9vRTVQRHdWOWdo?=
 =?utf-8?B?RmlBdW81Y3hROTM0eWNSOWx0Z242Z1lzUmROcC9FaHh3R3NFd0JwaXlONk9r?=
 =?utf-8?B?QVlQdS9tVjhmWXJVRzdZRjZkK2xpZWVjN00yMHZJOEFUU1M5WkRlNHRjQUwx?=
 =?utf-8?B?bWdEWHlqNzZqR3RjdW1jUGdKSkxXUEkzR091S2pyVThTMXF5a2dKKzhGQmZq?=
 =?utf-8?B?RDczTTE0cnZQeHpPellnSmZWbmc0ZWpkV3JXVzRKb1Q1WWRIK3BWN3F6Z050?=
 =?utf-8?B?TkhaRldKL1VxRjlySUs2MUJjcm9LK0g0TXhPSmFIQlNKajZjS0ZiQkhQeUhR?=
 =?utf-8?B?QkZmcTN1eDZMOG5Md1VnTUt3OXlidm9IQzdQR05oMWlvTFU4bVlSRlg3cmVu?=
 =?utf-8?B?bmp0MnFnRGZERStNUkthYTA1QVFRVkJ6SENIbFQ1MUpFK3lNMm42ak9ra2tL?=
 =?utf-8?B?VDJjeDVFMUlwdndjNVByKytNL1RiQitycmdha2FJU0NBaThmclJHdnB1L0Fo?=
 =?utf-8?B?SVpmTVk2TDFwd3FFQ1pKVnpyb2YrSXVGMm5FVkwvTzl0UUE0aitFWVdFbElS?=
 =?utf-8?B?YzVYQ0Ixdm1raVhQYVRnRno5U1pRaGhYZVFWd3N0N0FCKzFvRUhKU1ZwampF?=
 =?utf-8?B?Mk1BUE5nd1RLTmNiVE14Z29reGg3K3hobGZFc2FJMW1ZS1E3QXB6YkFxakF3?=
 =?utf-8?B?eTNBWWNUZkhWZGVtYWx3TGZDeTcydTFIU1pQZURrTHZyS2w3aXVTZnEzWlFT?=
 =?utf-8?B?cXpkV3oxa3U2QThrcTZDTnNDVGp5QjF0bkowYkRxSGVwck8vcHREL3BacVh1?=
 =?utf-8?B?anBDWmQrdGRWMCtMY0x3TTRtbEYrMEJYc1BLMUV0MS85SmE4dDhmWE1HYyt0?=
 =?utf-8?B?STdiTmUvS3UvSWtxT1FsRFlzL3JxQjZ2SlhNYjBvVUtuWURVU1RHWTg3MUpN?=
 =?utf-8?B?dTNISkNnUC9jTkJGTzl0V0EvRFd5Q1o1d0hVa1JxbjlBSWZyeWJDRHBwOFpW?=
 =?utf-8?B?c2dnTzYrZy8zaVh5NWtDNmF1V0JCcnJuenJmaFd6dC8wdGVtZEN4UEtVTVFC?=
 =?utf-8?B?VlRhSjJJQm5kU21oM1BMR2xGVk5SWERxVlVFNmpRcE41MWhtUE9lZXBQWjMy?=
 =?utf-8?B?Q2xSYmtuaG9mK2Z3RkxoOG1SZ3R3d1NEeGFNUWVlUnJuM2JXZXhleG1KM0tn?=
 =?utf-8?B?R3NxSFhMYzlGZ203T2RtY1hoN2ZnK2Y0SktJUUZCbHl4UXQ3S0FYdFYyZitw?=
 =?utf-8?B?dmZCSnpvSlFlQklHMm9WTHUybDR3bVJoY0lPa0FOOWNiQ2RDbFdTSWI2cC9K?=
 =?utf-8?B?blI3MlVnNENwaTc1clRrSzN3VUZNSjVVajRYSjRIWjJEMEgwVC9ndEh3SURh?=
 =?utf-8?B?Y20zVnFmcnI0anBHZVRIbXVsYU1Od25vci9DNkh0bm9TaUZCS1RPQVdlYXVI?=
 =?utf-8?B?Z29yQ0VDRk1FeENLN0hSR2kzNkd1cDFsb0F1U2Nobkp0Ryt2QTdCSE9CZkVn?=
 =?utf-8?B?eHlSOGhsZm5uUGYvSW5WTFJpVjhkcnkyMWlnYnNoNVE2SEFkbVNXaU56Zzly?=
 =?utf-8?B?RXN3aUhwaVpYa05tejhZTm5FdHhkcVpaOG8yTTlXc0NYWTRzNWJjZHVFM1JZ?=
 =?utf-8?B?OFF2WmlySjFMaFNleWpkYWpJWTE0YUFFS1FZK1l0T01Id3dicEs1WjQ3eTRy?=
 =?utf-8?B?VkVISk5Qb3U2QWVUenhFRXdHTzFUSXhxZitSRVUyaTJsSjR0OWxDRUlmUEpn?=
 =?utf-8?B?NmI3eWp6MG5mdk56Ykh1MmxIaVBhb1BTNWlFaVJYRENjZXN1RkdOSlluWEVp?=
 =?utf-8?B?TCtNSUZxVWlXWFozbWlCYStROHRjYWYyV3hpWGZ1cUs2OTFzZVk0YWFMdnhy?=
 =?utf-8?B?QjhUWTJ2bHpTR0NmOWJobk5Vb3FGMHdOMzQzWHB1ZTlXaEtab1g1d0J0Wm1P?=
 =?utf-8?B?M0NNM1F0ZGlYN09ic3NocXpmaTRiVXhoV3Q3Y1hZV29hTElvZTd1Qnk4d0My?=
 =?utf-8?B?dXN0b21QYXAwM0M1Q21NTXR3aXozaEJram5YSm5KTHYxN2s4R0E4VFFOSjRP?=
 =?utf-8?B?Vm1JNHlDUWhLbkxuUzNVb3pveVY3YUI1OUh2ZHdnSmZqWThNbitKbWJNWndR?=
 =?utf-8?Q?xN94rIklaWGLmtw3XZMLUZyPl?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7335ac84-deae-4fe8-1f59-08dc6aa3e7b7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:32:18.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw1S4dcEBPSbUp8YS1WDdf7dEptpLczmug8hXCehjbLC8QsNrVMnHvYW0VJcjXZ0Vz1uRJXzn6AN6Bjw39+S4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900

Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
The CEX is based on CN9130 SoC and includes two southbridges.

Because CN9132 and 9131 are just names for different designs around the
same SoC, no soc compatibles beside marvell,cn9130 are needed.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 74d935ea279c..538d91be8857 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -92,4 +92,12 @@ properties:
           - const: solidrun,cn9130-sr-som
           - const: marvell,cn9130
 
+      - description:
+          SolidRun CN9132 COM-Express Type 7 based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9132-clearfog
+          - const: solidrun,cn9132-sr-cex7
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


