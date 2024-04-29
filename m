Return-Path: <linux-kernel+bounces-162826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B8E8B6111
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DF21F2239E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDEC128829;
	Mon, 29 Apr 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="BIbhJJWv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE558614C;
	Mon, 29 Apr 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415089; cv=fail; b=G8fuQzbdJmcIph8pcP7r2DQ9DmgGgU5F8vxKDwZJEh/9MXnCCbPbNUwrp/STv/npWmwzbkqGZvsyyGrkvO1Cl42785A5SoS+r5mpn8FfKQMrPgtRzUDhjHJDky23IDfU5nRXGv53zu+sdR4lTi7F0to3Cs8qrYckcAxkFvKVqHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415089; c=relaxed/simple;
	bh=8zAMFxYjpHqhVFSTwMEl1YvtcBnr8Y3UaogfJtjqXHo=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=LuiVoYUSZt0TvoizDIGaoor9cXJ7+8egPaGXpz/7+OfB83tZDuc7F6mpPq4KefkMrD5qs4QqSYChFgFm8fpIgXrTOhlqA7q4xFoLp9EREKA7Xzxmp1e1UEDTWEkuTihgEK/Pd1J8K1DVKLQc6pylT/9y9H0CFDH+6nIM2mnAtvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=BIbhJJWv; arc=fail smtp.client-ip=40.107.20.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es5g+vIlD42prc/6xOL8spRz9gGYCzhFJwrdwAJ3IlM1yFc1tniqhRbW+y1jUnuayCEZpYt0lLBBuYmF6TlKearFWRVP8ZteuIw0sFPE/J+Od3QYQAM2jxMcr4qoHpRBbVLnUE6payl3TITY52hE78yDg4RlkHbZAXKfCkbtu8NhfdBOXymgigYIL4TdFJAxQBH3GZJm8gMhy5CiARH+thOp5YZK61DaujdjcC8aGA7wybpbz/pcgv1YnfY2CgBuOKeaFbIGTU7TaVZGHO9aJf6UjDvPhV5sOBSLXBfp74dm/Po6dyQ9vqrKVThR1vZm37A1GiPQKRlVm6/ei3UBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJgcFlSGyUWFWrvSeQtNhinMsApd7OgFapRDA0uR0sE=;
 b=Zz7RZl5dd8lrnGV1iHBgCrdHF8WwGeDTVAiK+k4unaC/ezINH/nc+roig8/xcyU07OtOM+s9gQmk+w83sYyT6AjHTMxKNU5RWDP+7ZoYkJR3pFyWUMT6ZGhtBU02CliRC8sQ/1Z20DagVw1+swqGgqX9G8ZsEgMIxv3nVs4IxYPYgwF5d+ErTxEF+WFQ9r1NcVf2CxK+FCgeG7tyyXr1Inl4GSz/5oFhPlFmIq7uKnkxEBfYAr6H7Kli+Iip8f9DAKtSetpf5hxI9NMdM7T30wTLiRG5YaaXqqmmyUBS5fzZrQYShqQaQPG2tF1IjpG9fpX151t0lNj/bT9sy1zGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJgcFlSGyUWFWrvSeQtNhinMsApd7OgFapRDA0uR0sE=;
 b=BIbhJJWvHMm4fjmNi0WsaSKSfMf3U/HpM878AMgHRbH1pF4X3rpdWrcDmAKi9Nf0Fo8IZ2TsXBQGyXY3gPqGyy3xl6/456koasp1lrTHxjbjB//eVqkVs0Gk79jZl1oWQPTEM4IX83DDY0fJotFmASFaCkqT3uuEpYBY3CbDqYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7782.eurprd04.prod.outlook.com (2603:10a6:20b:28a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 18:24:43 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 18:24:43 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 29 Apr 2024 20:24:36 +0200
Subject: [PATCH RFC v2] arm64: dts: lx2160a: extend 32-bit, and add 64-bit
 pci regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-lx2160-pci-v2-1-1b94576d6263@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAOPlL2YC/02NwQ6CMBBEf4Xs2TXdFgt6MjHxA7waDgKLbIKUt
 EowhH+36cnjm8m8WSGwFw5wylbwPEsQN0bQuwya/jE+GaWNDFrpXBGVOCyarMKpEczrtqaj5UP
 ZGYiDyXMnS5Ld4Xa9QBXDXsLb+W86mClVyWU0/btmQkJjC1Oosiu4tufgBmnRf8Z9415Qbdv2A
 xTzIsqtAAAA
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 975be4b2-135e-4d88-06d1-08dc6879a424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGN4dDhYYTNrMm1OSzFDL0d1RkhDeDVLSVVzeHc3cUJTWEpTcE43MGtBcEtC?=
 =?utf-8?B?T3dMMXhET2Q2bFVSK1VKK2hIUlRnYUhqaUpZMGRWd0JyM0lFQ1Btd1lGZ3dl?=
 =?utf-8?B?dXhLa3VwNUx4WHdWR2JEWXQvcHdGK0krTFZYWU5rOE9Ec2w5Vzh3K0xLOUhS?=
 =?utf-8?B?VE8vc3BuQUhudDVBUUlOQmJ2ZzdySnFkZFRqcEVDTXRMYUVhbHRwbHBLeFlH?=
 =?utf-8?B?cGhvU3RaMTNLSVNsdEVqcVJ0MUNyV2d0c08zbS8vNFRIYW1YTCt6NFp0Vkpt?=
 =?utf-8?B?QXpJQXNnNG5DSlNaUHBLMkRKK3lMSFRHblY1NlFXV2M2L1FXcDQzVUY3dHhR?=
 =?utf-8?B?bERWcVlGQ294OWczR3ZJR09sVzlKZWZVa0NqNG4yUUVxNTJhaGExbDNCTTFV?=
 =?utf-8?B?L3BjNDZubUR3aENtT3Z5S01QSnMvRWZ1QWh6bytNaUVmUVB6ekROemMzaE5t?=
 =?utf-8?B?LzJzVUtRYkFPSXFTdWV3bU10ck9GSFFoSWxSR21HcGNEeENHZFVoNTFPcmh0?=
 =?utf-8?B?S2pBTHRybFNkdnQxV2Fta2JNQ2E4MThDaXhhUkNqeUZ1S2c5YlJRalhjLzdM?=
 =?utf-8?B?UTJUc3NvK2FsT21zbHFNMnc2Nitxank5UHcrcHZzNHZDSkIvMU1ERVNCamxH?=
 =?utf-8?B?SWxXZXA4R2VFQkZJejlKdDBPQWxpNUNUZlU0YlpBcS9kTkdoNndkbnI0TWZK?=
 =?utf-8?B?OE43MnhsUDBoRHRPM0svL1NKeDZWYjNOcm5UaVByY2ZsNkpqYkVTb2hLRnRY?=
 =?utf-8?B?RlJEcVgvS2JoRjNVbklscVlYb2RBQnhLTjNJdlVoSGZLdFpTM2o1amppK2Mr?=
 =?utf-8?B?dlBlS3FoOXgrT2N3T0FTVDZwTUVKMTRLMWhINDdGZXRtcWo5WU9OT2RFbDkx?=
 =?utf-8?B?UmRQVzd5Nm1GRmdyVGZRQmxId1cycW9XY3ovaXdOM3Z0Qm15Vms5N3Y0bjNG?=
 =?utf-8?B?ZUQ0bTlOY3hSRFcyTkpBNGIvSThDclVSWXpML2NhUDdaYTFrbElYTFU3U1Vk?=
 =?utf-8?B?c0NIV0N3VE9rNkxzTlVXdTFobllxZzdwZVI4WmpXcEZZeU1KN015UzhrQlBR?=
 =?utf-8?B?eEtwRk00T0l4SW9zK0I4UDBQWGRuVkFzTEFRc2poY292K1QxUWlSREtjeGZ2?=
 =?utf-8?B?N0ZONDFBVXM4czZuR3FEZ1d6dVZPYWl0b2J4TkZNSmdrQ2hDUkxZL1JObHg3?=
 =?utf-8?B?TndlbVFtUWRaWThPWFlsUHlJdCsvbkxEUGFsRUQ2QWJUVVNDSlFpWE90cEhM?=
 =?utf-8?B?ZDNCNCtIN0gxK2VsV1o1amtPZUxid2RkbTNEMUNJUHIva1JpWkh6cGpQTVBs?=
 =?utf-8?B?U0JmdTMxVG9kMDZKSkFBcVQvYkVJek5DU2YvSndFRi8wK1BIYXlCTXlDVTVH?=
 =?utf-8?B?WSsyUEliQ1BKY1pwdFN2UUgzMmJnZ2sxL0c1cnBwcVl5STRsTE5ZQk9UemUw?=
 =?utf-8?B?bWRSTVh0cUxQMWpiK3BPNE5Uei9Tckc4ODVvOFdhTmErNUw1eWp3WFUzRVRP?=
 =?utf-8?B?M2JCR3ltcjRYaDV2cTNjZjhQeGxISFNLMjRzcHFzdTFkdUlGUVMvKzMrcUtB?=
 =?utf-8?B?dXlkRFhQY2kwYzA0RnY1VEpESStnem9qOE0ydVUrei9WbW5hdVRQNFRaWXdy?=
 =?utf-8?B?ZE5lRk1zN2VFTkZJV3FXbHdjVW1pUVdnTUwwMW04VEVsUGE2R21lNnowbU9I?=
 =?utf-8?B?Wi95a1BMQk0xbUhjdVZUQlpYQUxJRWtIQjdwa3JRYjc3UzhJS3BGOWFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmZzOXhPdGZZM1lNWkROMWRiSW55Q1d4diszNXFhTjVYY3FjY0dNZklYNFlD?=
 =?utf-8?B?ZzZmM1pESnZBRU1jY2FWRVRlVkNxYmVLM2RHb2Q3MzRtSTk3YXl1Y25lWUN4?=
 =?utf-8?B?Lyt5VGVGZitVVUI3dXBVcWJFQVYveVpyaHQwbS9jQ3NGU1F3ZlgrT2ZSRHpH?=
 =?utf-8?B?N0JDVWdYWXFJdXNDckF4OWRaeDNjYnpNaXQ2SnN2Z05tVWo4UUJJSTFsWkNk?=
 =?utf-8?B?aEg4NXJqMHNSczhZZnd0aW9aVFdHNHZQV1hKbGcxeUtiVnR3Nmk5RnJOanZV?=
 =?utf-8?B?VFFHT3dMTjFEZEF5V1RUUjlVai9yWHNsTkVXejFqZGYvRVlqWklVa1JVVVd1?=
 =?utf-8?B?MkxFT2ZZa2luK0xqQXZvRFdLZmw2bytSSmlzMTAyaHZ4N1ZPNGNhSXlYaDhO?=
 =?utf-8?B?aTdNTmsyOVdpTzJmVU9JRk02YUpNaVBZdVVXOWFRbENibUpkbVpMSXkrTXJi?=
 =?utf-8?B?UUdIdjl1ODNkRDBrR3NJSGpzRitaSWJSZ21rWEdmOVF1VzIxcHNZZjlqV3lp?=
 =?utf-8?B?ZlBhMVNyOC9ZLzhuaEJ2cy9sU0M4VjVGYmdEbE05ZUZjSnZxZDdmRUU1YlZO?=
 =?utf-8?B?WGE1ampabWE3K0RwU2pwSWZjbkt3ajc5Q3Q0dlVFalcxUGt4Q0k4SjJtTzho?=
 =?utf-8?B?WUlFWEhoWjgveGk5V2h6U25XRVd2VVFudkVGelRvKzRlMXY0RHpFb3FKdzFu?=
 =?utf-8?B?ZWJ4azdJVmxGTDFQYmNsczVGSjlpamlKZnhRZUo1OXZsTG5lNTh2elFtNU9T?=
 =?utf-8?B?Wkp5dFNLdzhPZUpEQ2VoL3orendRRWZQTkx3Z2F1d0tkRHAwNEhFR2pXbG5Y?=
 =?utf-8?B?K0FQaFZvL09wM1RaYU1MVjRUVUZkQkFrMkJlTi9saG5rUmtaT29nMFRwRTRm?=
 =?utf-8?B?Q0grMzVzU2VPVTJqY3Uyb2ZCenpRTGU5UXhIWmZwT0hlOHBTT0pmZUtkSXM4?=
 =?utf-8?B?RDMrU0RWUlN4dE5HeXlIcU9YVzJwUzZxclZaakM2b3lhK3NOVFB6OTNXYWtH?=
 =?utf-8?B?RGZET2lMbWRlb2k1L25oMElzOHFvdWt4bG9aT1hSc3BGNEVnVkt2ZFNENTFk?=
 =?utf-8?B?RXIrekpLdi9XeVQ3RnNnRXlWQW5aNU5PdVZyR2pLQ05KSFRsaVJESXlzNXhi?=
 =?utf-8?B?ZHluU2pZQ1gyb09LQTJYOExYMmpHV1d3R2o0YkJFVUJOTFEzVW1xUkpnTUtw?=
 =?utf-8?B?Y25BOXNkNmdhbWptNGhzZ212M0g5eHRKWnRaN1ZWS09paHVsdFN2dFNIQzJC?=
 =?utf-8?B?M3NMYXFhZmJnT1V0bE1PZnFNazA5aGhJWHkwaXlzY2dYQkNTbThYd2M2N0VJ?=
 =?utf-8?B?TU5aTVNZemJmbGNYckxHenRqVmgxdTk2cnB5N0dKSzZaVW1VR3dhU3YxZEtt?=
 =?utf-8?B?anNlZytuZWR2UVhLeUhFSUZDVU9UcmZaY3R5VW5mMWtGL3dTcnVVZnhURk5p?=
 =?utf-8?B?Q1BDL3BKMit2SE85QWdiWmpTM3U5cVhtd0NmSFZQdm83Sm5ZMTRYSHQ2THBY?=
 =?utf-8?B?aXQ4Y0hJL0lqYTQ2ZVRFbGYzU1RHaTNxeWs0VUkxOXZYZ3FmakZjelI1NDR1?=
 =?utf-8?B?TjBPOVhCMFBudWhtTU5FRTVPRmNVbUFSa2hKRXdvbFhlc3paUGIxRlZzNjVR?=
 =?utf-8?B?UHJoU1VnRVk1dy9IZi92WXNGRlZlV3ZSMk1uZitGQTZTaHRiNlYxRnBqcS9B?=
 =?utf-8?B?WEM0SFlWSGdOYU5vUTc2aENPdGgvbHB3YXU4bjB2UjZwMXFlY3RDUHl1TmMw?=
 =?utf-8?B?NzQzaHlnZzB5OGpoT1ByT2MvNHI3RUJNK2hpNllXOHhqaHJ2dkxvWHI4NWhY?=
 =?utf-8?B?OUYzOGlQbTA0ZGx0THRsdnVHRkl6TEZ5SVRzWEZ4Z09EamVlbTJxdmkzcVJ0?=
 =?utf-8?B?WmYxYmJvUDV4cElLWDJuckE3T1NwV0FBbmJUbm5teWhKR3ZVRHhzSzYvQ1dw?=
 =?utf-8?B?UXc1VWs0L0E1b3F3WDAwSTlha0dhcFBvWUxCVVNYdlFJNE1sR3NlejZXeGg2?=
 =?utf-8?B?QTJNRUlodjExbnhDR2FJQ2R6QVQycFQzOHloQkM5Y2p5TnlJR0VNdDRYZ1Q4?=
 =?utf-8?B?N2ZleWVqODM0bUZSQ2pIcXB2YVVtWFRSMDRETDBQSFRURFRhT2NkU21PNng3?=
 =?utf-8?Q?9zjgIg1ECBLlfYwEDFcHh3adw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975be4b2-135e-4d88-06d1-08dc6879a424
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 18:24:43.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZjEmky46SOgGFSqUMVLApkm4wsKB3Wf9U2LPelc+LJBL8Li75vdqN8n+i3WG+Uf1mJ6UBVQ5e3ekL6rGe+fPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7782

LX2160 SoC pci-e controller supports 64-bit memory regions up to 16GB,
32-bit regions up to 3GB and 16-bit regions up to 64k.

For each pci-e controller:
- extend the existing 32-bit regions to 3GB size
- add 16-bit region
- add 64-bit region

Same memory allocation with similar flags were been tested with UEFI
and ACPI on pcie3 and pcie5.
This specific device-tree configuration was tested with nxp lsdk-21.08
based u-boot:
- pcie5 with a Radeon Pro WX2100 with Gnome Desktop
- pcie3 with an ADATA NVME

Fixes allocation of large, and 64-bit BARs as requested by many pci
cards, especially graphics processors or AI accelerators, e.g.:
[    2.941187] pci 0000:01:00.0: BAR 0: no space for [mem size 0x200000000 64bit pref]
[    2.948834] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x200000000 64bit pref]

This version is still marked RFC because as it carries a workaround for
a limitation of the designware pcie controller driver.
The ATU has a maximum allocation size of 4GB. Larger allocations should
be implemented as multiple allocations of 4GB in the driver,
similar to how UEFI implemented it for ACPI.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- adjusted flags to fix several errors during probe and bar allocation
- explicitly tested with 2 pci cards on Debian (Linux 6.1)
- still rfc because a limitation in designware pci driver
- Link to v1: https://lore.kernel.org/r/20240321-lx2160-pci-v1-1-3673708f7eb6@solid-run.com
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 55 +++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6640b49670ae..ec4e6252f83b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 //
 // Device Tree Include file for Layerscape-LX2160A family SoC.
@@ -1134,7 +1135,14 @@ pcie1: pcie@3400000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			// ranges = <0x02102000 0x84 0x00000000 0x84 0x00000000 0x04 0x00000000>, /* 64-Bit - prefetchable */
+			/* split 64-bit area into 4GB chunks as workaround for ATU max allocation size */
+			ranges = <0x02102000 0x87 0x00000000 0x87 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x86 0x00000000 0x86 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x85 0x00000000 0x85 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x84 0x00000000 0x84 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x80 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x80 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1162,7 +1170,14 @@ pcie2: pcie@3500000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			// ranges = <0x02102000 0x8c 0x00000000 0x8c 0x00000000 0x04 0x00000000>, /* 64-Bit - prefetchable */
+			/* split 64-bit area into 4GB chunks as workaround for ATU max allocation size */
+			ranges = <0x02102000 0x8f 0x00000000 0x8f 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x8e 0x00000000 0x8e 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x8d 0x00000000 0x8d 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x8c 0x00000000 0x8c 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x88 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x88 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1190,7 +1205,14 @@ pcie3: pcie@3600000 {
 			apio-wins = <256>;
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			// ranges = <0x02102000 0x94 0x00000000 0x94 0x00000000 0x04 0x00000000>, /* 64-Bit - prefetchable */
+			/* split 64-bit area into 4GB chunks as workaround for ATU max allocation size */
+			ranges = <0x02102000 0x97 0x00000000 0x97 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x96 0x00000000 0x96 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x95 0x00000000 0x95 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x94 0x00000000 0x94 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x90 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x90 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1218,7 +1240,14 @@ pcie4: pcie@3700000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			// ranges = <0x02102000 0x9c 0x00000000 0x9c 0x00000000 0x04 0x00000000>, /* 64-Bit - prefetchable */
+			/* split 64-bit area into 4GB chunks as workaround for ATU max allocation size */
+			ranges = <0x02102000 0x9f 0x00000000 0x9f 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x9e 0x00000000 0x9e 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x9d 0x00000000 0x9d 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0x9c 0x00000000 0x9c 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0x98 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0x98 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1246,7 +1275,14 @@ pcie5: pcie@3800000 {
 			apio-wins = <256>;
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			// ranges = <0x02102000 0xa4 0x00000000 0xa4 0x00000000 0x04 0x00000000>, /* 64-Bit - prefetchable */
+			/* split 64-bit area into 4GB chunks as workaround for ATU max allocation size */
+			ranges = <0x02102000 0xa7 0x00000000 0xa7 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0xa6 0x00000000 0xa6 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0xa5 0x00000000 0xa5 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0xa4 0x00000000 0xa4 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0xa0 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0xa0 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
@@ -1274,7 +1310,14 @@ pcie6: pcie@3900000 {
 			apio-wins = <8>;
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			// ranges = <0x02102000 0xac 0x00000000 0xac 0x00000000 0x04 0x00000000>, /* 64-Bit - prefetchable */
+			/* split 64-bit area into 4GB chunks as workaround for ATU max allocation size */
+			ranges = <0x02102000 0xaf 0x00000000 0xaf 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0xae 0x00000000 0xae 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0xad 0x00000000 0xad 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02102000 0xac 0x00000000 0xac 0x00000000 0x01 0x00000000>, /* 64-Bit - prefetchable - 4GB chunk */
+				 <0x02000200 0x00 0x40000000 0xa8 0x40000000 0x00 0xc0000000>, /* 32-Bit - non-prefetchable */
+				 <0x01200100 0x00 0x00000000 0xa8 0x10000000 0x00 0x00010000>; /* 16-Bit IO Window */
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240118-lx2160-pci-4bdb196e58f3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


