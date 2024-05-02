Return-Path: <linux-kernel+bounces-166454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E28B9AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C8A282FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065F3E49D;
	Thu,  2 May 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="fg5L18hR"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4682498;
	Thu,  2 May 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653144; cv=fail; b=WtDkCOV/rywK312rp7ShG5dIwGBTnFiWx7tzG7O3TyuXvOBmMEfOSwtCvsiRJ2bvabIlUaw7cyUv/dlTZMpEjWKXgU7ySCGbdbNaxW2L24EXuotJxoD0FLBhxoCbbVyqUFzk7R+zKQBtqVr/NuHMkE+dQNA2TqEVRSmcFZQ8yo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653144; c=relaxed/simple;
	bh=I8c5Dmd/REgDEwT4s3aisaE/9M8JScc8cTBTcH1aYW0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=alO0IU4tNtRRN+mNasxd7uIep/Ao2oyMSw/HPESndKbDFNE5pVVp/04gvzsrXoqftlBKruJlPKTxvnyOhMoUKyXYRzK6+Ephz1NfWWFtj4Qo6RoFUZu+dUKmZmA72FZw/iv2/PCZu3PfiSkLWvqeyjhsmS8uFOlp6oCakmfn9Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=fg5L18hR; arc=fail smtp.client-ip=40.107.20.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az0OZf500ZThMGLhiof6ehBy8+Nk/KYXKH4IEV1qs8L3JwVB6gEi4p6EU0CEfI7p+tGaHNWCfZ7f+NCr9d0ezbogrEGggXZ7o0SQV+C/uCi4sVcSgZLCm7eciwkXRWCmhG5lU5Q6aP6PUxAt7KvsFtTdFXn906SgZB1qVVoIIqzgHk2tUYnCcacxA1PEkcMtlfubdkkNPA2uPakQWAsU15yJSm9tLG0kFumvwCUwiuLhtVQGDB5CeTivOwcCUZilfXRMe41moGS6Y/m0AsCmjmIY/QB8pP6IvIMqDA/QmtVMjdRbN9JZ8XlYhkQEfcCn8pmzhx0pKcKHZswoTJm5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=jLph0+mSTUsOoUMP8udwo4wu+74/W6bOPJbbnSPlyV5vVejYKbTqj75IDt6r0NZOnNsAuiJSUi+6SV9Ck2GYJJc8E644aWwrmxZODUO1q/n4ZfzOLFVCh+6jjl2AyeFXLOmXGqgFmfIGf+Coy/JNcFr3doVY4IxIzP/4jsCGr1jhHUikL6WMhUosVDlk6vC4P4YAwQuOeBVpo/3R9CWIExCNiXTx3e72gOPBnQ3jLUZVjEMbphs7Jxp++GTmcT5C/IOQdPrb8ZSN8YWu5TZApQPp7FZbKIpaK9+ZYUIgqkvqLMQbU3wkPLX2n02DfGvISZ9PsHhER0boCvHD3laTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHuDlE4bz3Ri64XL5zF4+GOIm5j56U6XO6oNEWy+k7s=;
 b=fg5L18hRqKc3Yt/kkPCpJLYmRSG+2hzau8dFVth6Ht7g5KRfRPnC3cplGwzcNypanGj9ItcqmZsconJnPon+yqzNhfEvLxQCJBPmNIbOE4xQzK4/y0NEWhVVqPng+y26AhQt6iBV8m3KuMx7g5WNFAWIxJW/l5R11lXwuyWuLC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 12:32:17 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:32:17 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 02 May 2024 14:32:15 +0200
Subject: [PATCH v4 1/4] dt-bindings: arm64: marvell: add solidrun cn9130
 som based boards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cn9130-som-v4-1-0a2e2f1c70d8@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92aba2fe-ca02-457e-288d-08dc6aa3e776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2Vnendtd2dPUjVLeHFNOWpUVVp1c1E0QXM0ZE1TNjdTdEhSeklFRUFaTmp5?=
 =?utf-8?B?dm5zNnhUR0ZaMWJHZkprTnNWV1JMcVFCVEUxTEQwMU9QZFRsUWRId2tYN3NL?=
 =?utf-8?B?SDMzVmZyWnhuQlNQZlpUWlRhNXh3cVN5V3NsU2tqU1FHQnZZOGNpTEg0NWlN?=
 =?utf-8?B?RjJZTmdPdkRPV0RYdVBzaXhnOE1iZFlKeGZKMExpcmk4Y0c4VlF2dTV3N2Fm?=
 =?utf-8?B?L0xKRVptd1poTWNhNzh3Sm5HRHN4aml2ZUhTZjVqc3lWcFR6UDdnNm9wRmlz?=
 =?utf-8?B?VTlGejlOR0UyUGhSMmoxV2Y4UWVvZGZ3QjE4dTdEUHc2MDFZRmcwcFVsWEc2?=
 =?utf-8?B?UWdrUE9EQ1RuWWZGeUtCSnlTVStadld1dXo0ZXFFRnFMRkR3U1pCazdjQlJn?=
 =?utf-8?B?dUl1RXZzbWluVnJHQ2l4andrdHBpZ29kUFV1ZnBxSkFUY0NGS2dYb0hGU0dF?=
 =?utf-8?B?a0ovKzFBbXQ0WEhFNUJ6SHFZcnNaVUZoUitBbjNsWVhoRktHZXd2ZlVFdWtZ?=
 =?utf-8?B?amY5RWgxZUFLY2IyRktEU2dCNWZtcFF3WmR6eDZwT1JyTUh2Sk1ITkFXYUlX?=
 =?utf-8?B?TGhITDJkYVB5cmFWMUN1aDdlU2tmVVA0TzArYlVpaFZuTWo4MDJPbDk4M05C?=
 =?utf-8?B?aytvbzlIb1lOcjd5a3prWmJXSUNvMFFIQU1DbXlVdlhOclJUR0tSMGFzbG1L?=
 =?utf-8?B?cGtkd09GR25YRWlxb0ZFYVRidTRORzZhRDBwTXB1YVMxelE1MURZeUkzZ3NK?=
 =?utf-8?B?TVdKUXk1MTZVR1BYcWlOV3ZaTkJvQlNhcVp6RXRwd2grbXVnemp2TTNlSVRB?=
 =?utf-8?B?ZjVybjJjaUtKUHpYanFHTlNPMFlTQ3FBejBOME43NGpVOGJrQXpjT25YSEJn?=
 =?utf-8?B?YmtTMzlUeG4xRE1xa0QvdEx2am55NXQ3eHU4R1JYbjRKRzNJVXhRMmdCamJG?=
 =?utf-8?B?OWE2anRlNVltMk15QVVDYThQeFlsQWVVZUszQU5WMmQ3dUdkRE44RkZnMWFX?=
 =?utf-8?B?cjRDM09iNjQvMWg3UDlRRFR3OSs3bGxSejhlSndJTHRCejByamd5TWJqTkpm?=
 =?utf-8?B?RHBEcnkvWXNiZldUbEplWHNQWWZBeHdlWlhZZ0ZNZlZaOGdaV1J0OWl1TWtj?=
 =?utf-8?B?OGNpaFZ5ay9nSmlLVWZlckdNWnFpekg1ZW1CSGxXVnZHQkwyUnljNmY4SER1?=
 =?utf-8?B?aGRsd3V3ZUtPZkNYNUxvTDZUTlZoZmN2TG9hZVFnVEpqWDJSTUhCZGlWODF0?=
 =?utf-8?B?cUVGdzNUd3pRbnM1WXFiU2tLM2U2dU81V2pSaVFmQWhXOENxdW9vZ2Myelk5?=
 =?utf-8?B?eFc0RXJld3ZFbER3cXE3Qnp3VGhEZGRNZCtTWHJ4V0dFL1pDbkV0RkdTYVBP?=
 =?utf-8?B?WXp0Vy9qQXJhNmlJMkhqRmFoOS9aR1pwMS9SMW9MVGp2UFNYdUEzTXJSd1ov?=
 =?utf-8?B?VzVlNmFrT3ZuWlYwOUZTT2pFOUUwd2VnYmV5cGhOcVlUWmxiajR4RmpxeWNu?=
 =?utf-8?B?ZkRSNUVFb1QyNTZNWTJ6SnB1YWdRTUd4SWI3bksrWThFRUJWbk4zdnNadUll?=
 =?utf-8?B?Tzhjb091K0ROSDF5a3ZVUDB6V0dHVjd2bHpSclpVa3Faa3I4YWhweWVMaHlV?=
 =?utf-8?B?UEsrckdyM0loMHJKZys0blFzUW80OEY3Y1RkN2M5dldwZXU4RlBiRWJuRFRm?=
 =?utf-8?B?b3R4Q3dLQVhHM2VBU3pBMTkvWXFjWEpPSkdpSlNRclpqZ1lBOUMxemNlR3VV?=
 =?utf-8?B?NkUxMmkxN0hEeGRsYlVOdkVjcFdHTHJBS3BISmY2RUNvbkhOU3k2SGZXdUpy?=
 =?utf-8?B?T21McEV6dUVZaG9CbUVrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3hvWEdycXJBdEFUYllkdzlMWEhuSERJNi9tT3prYUc2NlpZN3lUSHhoTWR6?=
 =?utf-8?B?YXdyeVRIZERUVk9reEV0bE1XYVdjVnVKaTdrbXpMYWhZTTVWUVRkQ1JhTDhm?=
 =?utf-8?B?OGoxa2IrbklVWUtBNWkxYU5nYllGUHlla1RteU0xWjdHT3l6UVZHMEdzN0Mw?=
 =?utf-8?B?cU5TdFdpcCsyS05IMDBWYUdJMXVxa1lDenBJMWVVMGt3RVEyTU54cWxlYktD?=
 =?utf-8?B?NFBQWmNhQmd0Vi9zYTQ2emZNU3lrUUYyT2N4TWNWYnBKTENxZWtiSlEzVTVC?=
 =?utf-8?B?MjNObWVENktrcVJlQWR0MG5GY3Q4QzJJeGQ5dHo3Rms0THJFQ2crT1JZMll5?=
 =?utf-8?B?NlNQMmNPdENlOVVIUmw5OStGSTRXZmEwUDRpMmpaR05mRENPTlMxT29ndkVu?=
 =?utf-8?B?VnZyTDFxOFQyeXdTNmt2byt3eFNQdlRzWjZqTHRsRW5aTTA4UXd5dDRldWxK?=
 =?utf-8?B?ekZqa2RxaGdFSFBzNTV3djFCQzRxN0JtSEpya0xGUklWQ1R6ZG5xNHRnN0xN?=
 =?utf-8?B?SE85L3J1MXMxeG5VcUVQdit2UW9TbHQyYy9YN3RFNnZiNUlMMDh2Q0VNZ3A4?=
 =?utf-8?B?dkhBeURPcTlIdVNoS2FmTE5JbThsODZ6SjNyVTFVczUzcllvNTNtU2xMbE1V?=
 =?utf-8?B?TkFBTmFkVGtqQkpyVmc1RUpHQTFyMXNKWnllREZYa3J3Y0twVTdDK1RVTkVr?=
 =?utf-8?B?NDhjaEVPclovS2NmLzF1SjhMT3J5R0hzZWE0dDFBcUxaM1VVb0NObWVZdEpa?=
 =?utf-8?B?YkhpQ1FBVk5RdGhyd2I3UDNOZlNTbHl6OW01VXlRTUdOYmRoOWlqclFyN3V0?=
 =?utf-8?B?L2hpSE9sanI3YzdabllNSGxjYjYyWUY0M0QxQUZuaU53akdZSk02bitOQlQ3?=
 =?utf-8?B?ZzVIWGRCMTNVQWswZWgyNE5wQmRtUkJKZVhxOXhvYjFJa2NTaVBZeGNUcmZn?=
 =?utf-8?B?bEtaS0phZ0RPaFJaRDl4TUttU0JOUURoZlFOZFNPNEltaGl0VUEvVitpREFE?=
 =?utf-8?B?TU55blNaMjlVbXcydHR6bkk0cEdYZVE5UjdNL1FNK0FTSUVkRG5xMnF4aDNE?=
 =?utf-8?B?bkNEQnlhUWRhL2Q2T2EwbUVGTjJ5M0tnWUVTV0pPbitIQVlSTXlaV0Z5M0ZV?=
 =?utf-8?B?VkdlVUVCWW9pbFUybUlVdGFnZnVKbmQ1TFJkc0ZhWElHS2YrOFk5SUpMQ05Q?=
 =?utf-8?B?bzJzeHRQU0JNM3pEUENiNzRzdGVUb3Q5ZFFyRFJWRVQzOENKb2FLYlFTbmxN?=
 =?utf-8?B?c0UyeHVIZCtQeDhPWFQ0cTRZOTY3YmcrcmI4WlJvSDFWRlRFWEt1ME1OcVNX?=
 =?utf-8?B?cktsUFR6cXN5bGhzSCtjOXFVL3J0NnY2L21NNTR2dzZhR25pZDZHNmx0Wm1L?=
 =?utf-8?B?bmpScThSdURrV3dad3lRMnUxbGlWUlpRa2N1S2EwemxWdHYwVUVudTNJSDRW?=
 =?utf-8?B?OHhoai91Rk9tZmNLUVh6UUxIYWJrYTl3UnEvMityUFkwUDAvdWZpR2JCTjU2?=
 =?utf-8?B?QmMzK3BENExhcDBPRndBamcyMjFaQTA2TXpFMW0ySUR3T1BUVVEveE9uOTlz?=
 =?utf-8?B?ZURISDZ1bnVhQkJ2TSswbUZLUEw1a3RZQzhTaStwYTBxZzAwQjkvbjlZd2k0?=
 =?utf-8?B?aWNNOHgxREZTQVNHZ3cySy83N3Qwa2pYc3UyQlNWdVVFK2I3RU5xUWpQZkNX?=
 =?utf-8?B?RzcyOEFaVWM5MEpWOHNQVzlNVXRzMXpTRWFHbGJKcWpVb1RBbmdkbktkRGZj?=
 =?utf-8?B?UXptV0xZYnlOajBhSUFucDBOOE9ROFBjeVk4d0g1SCsvUDk5Q256aWRFY29k?=
 =?utf-8?B?QWQzTVJpRXFZcnBiV09Ja2h4ZjRQVkRvZkJxYmNKNWdzQ1E0NGkrTWJxT0Fw?=
 =?utf-8?B?MEdIbGFQT2tiK2xyUmFrSjJ4NW5lV2lwK2tpa3VReUdRMjAzajI1czMrZDFj?=
 =?utf-8?B?SUlJb1owVjZtcVNOVGdMaGZNdEtUMWdzVWUvNVpieS92NVdUaVJwOGVWRmxB?=
 =?utf-8?B?OW9FS2pRZG0xbzNTN1p0V2ZBemRJTk96ajJvcVdzWGMyK093SWx2Mk9jei9F?=
 =?utf-8?B?Z2NPNFBacHBmeGFlWW5iQk1HMXZwRit5endGR2dFZXpmalJIMUZVNUlJUWJO?=
 =?utf-8?Q?wKm1KGTePfyPpXxlJ8JPi5EQd?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92aba2fe-ca02-457e-288d-08dc6aa3e776
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:32:17.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+szoffbAKLD62NYzM6xUDFWIqefoUPbQgZeda2lG2ym8iIUBOSp1M87pj57B4GqHA4zzBBinqo57Uj2WsufoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900

Add bindings for SolidRun boards based on CN9130 SoM.

Three boards are added in total:
- Clearfog Base
- Clearfog Pro
- SolidWAN
The Clearfog boards are identical to the older Armada 388 based boards,
upgraded with a new SoM and SoC.
However the feature set and performance characteristics are different,
therefore compatible strings from armada 388 versions are not included.

SolidWAN uses the same SoM adding a southbridge on the carrier.

Since 2019 there are bindings in-tree for two boards based on cn9130 and
9131. These are extremely verbose by listing cn9132, cn9131, cn9130,
ap807-quad, ap807 for the SoC alone.
CN9130 SoC combines an application processor (ap807) and a
communication processor (cp115) in a single package.

The communication processor (short CP) is also available separately as a
southbridge. It only functions in combination with the CN9130 SoC.
Complete systems adding one or two southbridges are by convention called
CN9131 and CN9132 respectively.
Despite different naming all systems are built around the same SoC.
Therefore marvell,cn9131 and marvell,cn9132 can be omitted. The number
of CPs is part of a board's BoM and can be reflected in the board
compatible string instead.

Existing bindings also describe cn9130 as a specialisation of
ap807-quad. Usually board-level compatibles stop at the SoC without
going into silicon versions or individual dies.
There is no programming model at this layer, and in particular not for
parts of an SoC. Therefore the ap compatibles can also be omitted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 16d2e132d3d1..74d935ea279c 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -82,4 +82,14 @@ properties:
           - const: marvell,armada-ap807-quad
           - const: marvell,armada-ap807
 
+      - description:
+          SolidRun CN9130 SoM based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9130-clearfog-base
+              - solidrun,cn9130-clearfog-pro
+              - solidrun,cn9131-solidwan
+          - const: solidrun,cn9130-sr-som
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


