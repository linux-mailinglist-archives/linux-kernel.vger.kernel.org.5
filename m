Return-Path: <linux-kernel+bounces-153487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252C8ACEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765B51C20F75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD90150981;
	Mon, 22 Apr 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ffWJzgf7"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2133.outbound.protection.outlook.com [40.107.8.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D215028B;
	Mon, 22 Apr 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793627; cv=fail; b=B5ZCK8afaKEVtaJkdHETqYIUy16LPHDp4+ig1T+Sk3JXcYuB8QVs3WTQtxfgs1cqskV34ye9I+5Yvkp60QohH2gRBFLPf3I1CEFn4M8LsNZw1rszXmnNnxFC+V4eCooOyOIFuXFHgROmC1Wejk5NMeWrs/lp0n0uhrtYdGEW2jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793627; c=relaxed/simple;
	bh=/rPzgMUhLJxFBGL2PxT1NwJwRoh8TG9N8eEXUd1UMro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awHYn1tcZGGXwVEUT2w8jHOp8R7g6cVU3joqbVOOGSLs9t294LcXbTtM25Z/b+vWu4G6AAiGMGqtIYTakwR16eQW1KFZO7+o1rFyoN+Fk88cG8AZXhthYnGG8s7s/Y/hDvaE7gR77vO/XAYcT1bY7g+C0R19CkVYO76YkWvtoU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ffWJzgf7; arc=fail smtp.client-ip=40.107.8.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfoVCDQuH/qO3TUYpF/n/+Z3EsLR0cXmJ7Wk2bRDQ0TXsad+PRM4h4Fdv9eApZBpTIE9f8/A0hmKxy20o/Xc5Zjbcb/4nhsO1oQ8YIwf74/OiHfQV4ZXnwS1OnSumQdsYbUvXlI1tCi0FSSqjvbK4Fv1QHnNEWC6Ku2tJYPNYAV4nS+YOj8jI0LfcRj5y4/NrgegUoWAkBFgYcuZAw6aFuQbehYtZhkNcD0DqgGG1iqjGOynEL6PT3lY4Yn+QsmJwtj8e8AzILz8hldL37fmg/cvn46IJRLzfNTa1oE4H1mkfx3Cr6m8kOd3Y8uxqOGVdgwSoAFOHW/MZMSFNzNpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rPzgMUhLJxFBGL2PxT1NwJwRoh8TG9N8eEXUd1UMro=;
 b=UH/hnUqFoyxb1pbw9F3qPueKcqmKlbT0321i3P7S5oNZIdxk+lIcUPOVKvMScBt+hGZwN+LYH95il28u8lZIuch01cLqvresP0biqdZUNfCZCiDV+fZw2Crn1ZBNWZ9WDc3UO/XuxkpX4f6i6gNZQovM1KrCyuzuOMvsjZcDYSFslmI60z7wfYgAYaA/ppEOAnEnp9C8QX8d2kx8ei+60J0GFjwZWbRhHDTmlhGOjZji1M3jP5vRBlJR0la2aG7aBidwIkBfksKNK218G2/E7B856rIJqK4mYWbWlwo9Vsk0MUMmuJFzmSMTT72EoDmQtqf6zJWkDmxjocBayv7gMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rPzgMUhLJxFBGL2PxT1NwJwRoh8TG9N8eEXUd1UMro=;
 b=ffWJzgf7JI127PAgADE8AGAoWrgbwc0cW9Ujja7QRTkVEkA/mLAguKTM21dJjnSAz1/ibXSsQe3tf+eSVAZ5UEY8BPSj4m5o8yw/fB4O6EJyTkkv9t6Tm6ajkXRYEHAhJ9m73HDhtGVAFDmEMbzFulaZuz9r5yCqxYPeeKW2vhA=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:47:01 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:47:01 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Yazan Shhady
	<yazan.shhady@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Topic: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Index: AQHajmt4w4zwT8gI9EGUFXDjzCdkprFnv8QAgAyX9QCAAAKKgA==
Date: Mon, 22 Apr 2024 13:47:01 +0000
Message-ID: <15b79794-41f4-43e0-888e-286ca1fc4321@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
 <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>
 <fd466583-3221-4b94-b66b-18840615fb71@lunn.ch>
In-Reply-To: <fd466583-3221-4b94-b66b-18840615fb71@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB9PR04MB9498:EE_
x-ms-office365-filtering-correlation-id: 0d837fc9-c537-4931-e07b-08dc62d2afeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q09KaUhQMWlZVFJOZ3FEd1ZaQjJpcHpWQlI5QzlxbzFDRVJvNGVGdWRpVE51?=
 =?utf-8?B?bCtqalVWNVBCaFJ5bGZpV1hlTUg2UUZ6TG0ycUhtWlZPQ1E0ZFhTNTEwbDRC?=
 =?utf-8?B?a1UyK0N5UXNXOHJoTWJ1dDVyYm5jK3cvajB3MmpPaEh3Q2dnejNOVEphYUFL?=
 =?utf-8?B?RUlUWG94VjFLeDRRQkcxN2YveXowSE0xakNXRVB0U2UwWEd1Qm1vYmg4dEFw?=
 =?utf-8?B?c24vNUpNR3J6SHVtb01XMXQ3RlRSbTA1QS9ZaXhwVHZ3S2MwOWpVWmNSa0Za?=
 =?utf-8?B?RUxzNC8yUHA4R01PdFB4Mm9iWElhUS8xTmE4OXBkdmVCbk9JZTFGZXRMMDkz?=
 =?utf-8?B?Vk1lQWxPUXYwVFNqSjVMWGliZzQ2cWlCNzFZNElqZDFHYjdBWC82aEZsUTdv?=
 =?utf-8?B?YSthZWtOclp5ZFNvN0krYzdoZW1PY25LWnFTQS9VNlhjdGpzc1hjTm14MlBl?=
 =?utf-8?B?alp6UlFTL3ZDUnVrR3VpYVFSSmd1YnJEVDNKdm5rZmhiRld3eDVhYlNhTkhk?=
 =?utf-8?B?VjF0akwxSVdUY0pvVm9LYzdEK2RLMW1wV0ZMWk5YN3N6SHJHeGVCa1pIb3Jm?=
 =?utf-8?B?SW5sWlYzTW5xTk9Ubi9QbnpTT3NZQ2xMVzU4Uk5xNFBpUkpIZEQrb240S2xo?=
 =?utf-8?B?U2w1cG1YWGxncmxQZmpTSmdRS3V3dkw4QVJsWUJ1SCsraWV6RXYzUk90U1Ux?=
 =?utf-8?B?bGxuRlFEZ0JYUjRjSFlwMGtwLzR6dFRZZkY5UFRUcnhKTGJqNDU2blhMazBa?=
 =?utf-8?B?bHprSGh6aGdscnFsTjJlbDk4bGpvak5UNEtycTlBWkY3QnZQZFVJS1pmSnNq?=
 =?utf-8?B?ZWJiYmVHa3dKak1FSndIelJldUR1a0hPSk1mK1RYSUtkNlJLZitBZlJ5OXRN?=
 =?utf-8?B?aHJEV3dWd2JiakxtV0RlRGE0SkRyOFZ6cEVuYXc3UFRBamltUEpFN3YybFhN?=
 =?utf-8?B?V08xTHF5bTFzQnVnbkFzKy9MbnJZWFNjYUcreDUxZXNqNmFrcWVRQzVEUS9r?=
 =?utf-8?B?VExPQjlGTHVFRjBJOG5ncEpheG83Vk5ZRWhseGxDeHlQQlNpN1o0d1luSWQ4?=
 =?utf-8?B?MTVIdmYva3JnWFlqU3NidFdJamIxbmFwQ1d3S3lIeHJIK3V3Yk9TUXRXSDEy?=
 =?utf-8?B?QmtvRWVpUFFnUUdwc242OWhIT2duSEh2cjNpNmNJVzBmZzFyV2cvUXgrRllw?=
 =?utf-8?B?UkZXazlBTFhXUXh0UnNPYlNlaldkTXZueVlleWl1QTlWSGd5bVAxRXczakR1?=
 =?utf-8?B?VUhPanorNmZmZXE3c2cxZzBMMDl5QWlHVGRaSURUd0l1Vms1YklvajJkcWZz?=
 =?utf-8?B?SDdtbWgzdU1ydDhvL0Z2RUJNV3Y2NVhYWUNOMG1GaERzQ2lxcThpS205VUFC?=
 =?utf-8?B?b0JsMzRmTWx4VlZnUXlyZ3BHTHR0ZEFxdjduTXdWdEo5ME53RlAwMDAwRmJK?=
 =?utf-8?B?YmFhR3NPRlJCd3d6NGNVWTFCci9MK2VxN2NRODBybDFmLzl2a3UzK1B1ZVJp?=
 =?utf-8?B?V3Vvc0JaSXVJZXE5Mi9vdHEyeXZtYklISnoxUzQzb24xbXFxRktvcUcrejBR?=
 =?utf-8?B?b3NPQ0dLMjBRR2R4eXZtVVhUU0g3Sm81OSs3Q0RIdks1dWwvK0M1K0k4Y2cz?=
 =?utf-8?B?R3htQXE2YnpKL0swUlFCcHE3TE1DTkM0VlhBV0RCb2w1Q3MyRlZZTWlSSXNC?=
 =?utf-8?B?SndDVWUxc0JjeDk5SllXQjR5cVZDQXFLTXBHTkFtL1dpSWlwekxYY3hBajJZ?=
 =?utf-8?B?ZHRTYU5OZmJNYlg5S3RISlloZHdIZUQzVGxkaWttTXpZYkhrZGw0NG9rSDR6?=
 =?utf-8?B?a0xmejVpTnRaRXA2c1U0dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUtKZmI2SU1jK3hlMGkreU1EMkV2QmJXWkJMNzJJRlJjenBMSmQxV0phdWdl?=
 =?utf-8?B?aVovRFhQdTVManRpdm51bnY5QlNWY1pDNzMvcmJ6cERFZUtyT0xTaHlIVlVu?=
 =?utf-8?B?NWtiQjZJZ2twM3V6MXVYbW85UWRwTkN5QXp0U2VtTkVLaExBUEQ3RnNBdTh3?=
 =?utf-8?B?cmVib1FyQTdORE5yb0ZsRXJlcVBvdmttTnFqMEJrWlpveGVGdkFNVmxYR1kv?=
 =?utf-8?B?elZNeFR4TUtIY3Uyd2pkSkRzNk0wZVNDOFRLNUdaUE4zMzJmRlFjcTNZc0RG?=
 =?utf-8?B?MkZBaXIybURCMCs1dXNkUVZsNmduTVpxb3pLTFZCNlg4QkJZdnJ5M2ZEdzht?=
 =?utf-8?B?NzIvK0pkT2s5ZHFRamg0Tm8vS3VodWpoaWdWNndjT3h0WDNaZjlUckdBdi9V?=
 =?utf-8?B?MDFEVnN2TEd5akpSb0VuYVd1Q1JCSVBSVHBvckpRQno4bUJWWDRIZm45OU81?=
 =?utf-8?B?Uy9kVkYvWE5hQmJNa1VTM1h6aGlZdjZoa1MzdVhwRGdWTm5KL1I0eGdQTVBQ?=
 =?utf-8?B?SUFBUlExUGhabUxESmlIL29sTHJ3Qy8vcjBXaUhjTDBOOXN4dTQ3d1NKeXJu?=
 =?utf-8?B?bUhHMkt5Uk1Bd0ZLenVDUjMvZWxRVmRiRGliZUFadG9reTkwRmJXUWNVY2VP?=
 =?utf-8?B?Q1ZOMFhWcnhmL1dYSUhSMmJtM1lUY3JHL0hOazlsRzA4YzUrYTVzQnlHN1B2?=
 =?utf-8?B?U2Q3NUhjU2JWd1VKK0FqSkN5andUczNCRlhWNWJlVGRwTDhxbDBHUDBBajcw?=
 =?utf-8?B?aXFTcTRRMEMrempSbWZ5MFpzUDhWcDM0YjVwYXRpUTZOQVRTM2JpeVlrUjRZ?=
 =?utf-8?B?UzBMSlpNK2lXVm84OFRkRlErUUF0OXVueXV3WCs0UXlMN2o1QzdDbzB3elY2?=
 =?utf-8?B?U3VpUG1KaUMyT2ppTVp0K1JvM2Jham1NNFVtcS9heE9oQzcyRDUzZWlvUVJq?=
 =?utf-8?B?VnA5SDMxOTg5ekVZU3IrNkRibDNXRTZ2M1lQdm14VklJVjF3TDNjQm1yYXh4?=
 =?utf-8?B?YnpxVTU4QnFuQkdJTjI5YnkrZUJOWEQrajVqc24vbkNJZGdzcW9ac1ViQ0xV?=
 =?utf-8?B?aVZuY0FkTUE2dlRKRHVVc2JFSkUwT3RGSWhIVTVpMFFNWFoxL2dObzIwZEZL?=
 =?utf-8?B?dnRwajRkd0R1aStFREtCUDFhdFZTRVZuTHIyYTgyLzA2SFRIdUNzb0ZscU8r?=
 =?utf-8?B?Z3lRS0JkMHZtbUtZZk0zb1FBQUpxTnFPQWtUY0xINnQyY2ZCUFlHUEp5eWx4?=
 =?utf-8?B?TG5iVDZKcGhFbHZMNW80Qmx0YmlIeE9Sdkh0NS9TOGtVR0VsWVJYRkcyQmw1?=
 =?utf-8?B?NHBVTEJ5UTdkd3l5UWtQNkxOWnUya0pFb0Z6d3h5YXM2ZDJxdkJ1cUhsZlhK?=
 =?utf-8?B?Z1FzNHR0dU1vbzROK083ZzI5a3NWQWR5VGFiMkZRVnJFSGVsMVYrNXNSaEVn?=
 =?utf-8?B?TjRzcmdxbHBFYld6SjlydDJrcmR4eTlpK1N3WWxhc3JWTzFYMTFmWlo1cjN3?=
 =?utf-8?B?RWJmNGJNYUlyMnhBcWRMWnFFdDRBWUhmZW1QOEdsVi9PbDR0QU1NWGRmaS9Q?=
 =?utf-8?B?NnNmTFpUT1lFaEttTlZUR3VLSnhBVVk1WFdGaXNzVGp0VDNOVWhjaTNaR0N6?=
 =?utf-8?B?ejhRbGxUSWp6Z2djWENQSnB5dEdUZUdVUFltUEFsOTl0aGhiZ2JYZkp5eUdT?=
 =?utf-8?B?NmI0K2VKcENiYXB0Wm5nNm9YOUpuNDVmUnRxVE5zM1ZQSEt1L2FGSXhJL3ZU?=
 =?utf-8?B?dkEreXZoc0xMOU1wV3FwL3hRNmE4TDVPa2VYL2ZzKzIwc1FXcFBxMHBMbmJ5?=
 =?utf-8?B?TE0yVERVTnlqQ0NkSkNFQWpXdERpMDROVnBXUHZEVmcvUFN6L0VHOERLS3B5?=
 =?utf-8?B?K1JyQXJ5STl5dVQvV0ZZTkMwUER6dWxnK1FXS1krbTRQdzdYQ3Q5MGdsZEdN?=
 =?utf-8?B?Z2pvNFpmTlk1OVcyVmpCN2tpZGlTUWF0RHNaMkhianIvN2xqRHZXUFhYclN4?=
 =?utf-8?B?ZDRmOW8xY3E1Z0xBamRQWkdrcHRGZzEvbmxaTy94NWowWjVzdExsRTZIK2V0?=
 =?utf-8?B?MnczaEtFSzdiYWhvUFd3d0MySjJrV0prMEMxRzV3dWpxSGJlKzE0d0lXNktz?=
 =?utf-8?Q?xIpY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2BF5C916ECC69459B566D56EE00E418@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d837fc9-c537-4931-e07b-08dc62d2afeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 13:47:01.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGsdYfs3kej6dktYL0TgrkqRR96x+My8r6aqP7rbgzmqKF7sJAljKORAybfddohELOudrhWBsIfnU66BgMazaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

DQpBbSAyMi4wNC4yNCB1bSAxNTozNyBzY2hyaWViIEFuZHJldyBMdW5uOg0KPiBPbiBTdW4sIEFw
ciAxNCwgMjAyNCBhdCAwMToxODo1NlBNICswMDAwLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFt
IDE0LjA0LjI0IHVtIDE0OjU4IHNjaHJpZWIgSm9zdWEgTWF5ZXI6DQo+Pj4gQWRkIGRlc2NyaXB0
aW9uIGZvciB0aGUgU29saWRSdW4gQ045MTMxIFNvbGlkV0FOLCBiYXNlZCBvbiBDTjkxMzAgU29N
DQo+Pj4gd2l0aCBhbiBleHRyYSBjb21tdW5pY2F0aW9uICBwcm9jZXNzb3Igb24gdGhlIGNhcnJp
ZXIgYm9hcmQuDQo+Pj4NCj4+PiBUaGlzIGJvYXJkIGRpZmZlcmVudGlhdGVzIGl0c2VsZiBmcm9t
IENOOTEzMCBDbGVhcmZvZyBieSBwcm92aWRpbmcNCj4+PiBhZGRpdGlvbmFsIFNvQyBuYXRpdmUg
bmV0d29yayBpbnRlcmZhY2VzIGFuZCBwY2kgYnVzZXM6DQo+Pj4gMnggMTBHYnBzIFNGUCsNCj4+
PiA0eCAxR2JwcyBSSjQ1DQo+Pj4gMXggbWluaVBDSS1FDQo+Pj4gMXggbS4yIGIta2V5IHdpdGgg
c2F0YSwgdXNiLTIuMCBhbmQgdXNiLTMuMA0KPj4+IDF4IG0uMiBtLWtleSB3aXRoIHBjaWUgYW5k
IHVzYi0yLjANCj4+PiAxeCBtLjIgYi1rZXkgd2l0aCBwY2llLCB1c2ItMi4wLCB1c2ItMy4wIGFu
ZCAyeCBzaW0gc2xvdHMNCj4+PiAxeCBtcGNpZSB3aXRoIHBjaWUgb25seQ0KPj4+IDJ4IHR5cGUt
YSB1c2ItMi4wLzMuMA0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3Vh
QHNvbGlkLXJ1bi5jb20+DQo+Pj4gLS0tDQo+Pj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCj4+PiAgYXJjaC9hcm02NC9ib290L2R0
cy9tYXJ2ZWxsL2NuOTEzMS1jZi1zb2xpZHdhbi5kdHMgfCA2NTMgKysrKysrKysrKysrKysrKysr
KysrDQo+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgNjU0IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUNCj4+PiBpbmRleCAwMTlmMjI1MWQ2OTYuLjE2
ZjlkNzE1NmQ5ZiAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwv
TWFrZWZpbGUNCj4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUN
Cj4+PiBAQCAtMzAsMyArMzAsNCBAQCBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0gYWM1eC1y
ZC1jYXJyaWVyLWNuOTEzMS5kdGINCj4+PiAgZHRiLSQoQ09ORklHX0FSQ0hfTVZFQlUpICs9IGFj
NS05OGR4MzV4eC1yZC5kdGINCj4+PiAgZHRiLSQoQ09ORklHX0FSQ0hfTVZFQlUpICs9IGNuOTEz
MC1jZi1iYXNlLmR0Yg0KPj4+ICBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0gY245MTMwLWNm
LXByby5kdGINCj4+PiArZHRiLSQoQ09ORklHX0FSQ0hfTVZFQlUpICs9IGNuOTEzMS1jZi1zb2xp
ZHdhbi5kdGINCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Nu
OTEzMS1jZi1zb2xpZHdhbi5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMx
LWNmLXNvbGlkd2FuLmR0cw0KPj4gY3V0DQo+Pj4gKwlsZWRzIHsNCj4+PiArCQljb21wYXRpYmxl
ID0gImdwaW8tbGVkcyI7DQo+Pj4gKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+PiAr
CQlwaW5jdHJsLTAgPSA8JmNwMF9sZWRfcGlucyAmY3AxX2xlZF9waW5zPjsNCj4+PiArDQo+Pj4g
KwkJLyogZm9yIHNmcC0xIChKNDIpICovDQo+Pj4gKwkJbGVkLXNmcDEtYWN0aXZpdHkgew0KPj4+
ICsJCQlsYWJlbCA9ICJzZnAxIjsNCj4+PiArCQkJZ3Bpb3MgPSA8JmNwMF9ncGlvMSA3IEdQSU9f
QUNUSVZFX0hJR0g+Ow0KPj4+ICsJCQljb2xvciA9IDxMRURfQ09MT1JfSURfR1JFRU4+Ow0KPj4+
ICsJCX07DQo+Pj4gKw0KPj4+ICsJCS8qIGZvciBzZnAtMSAoSjQyKSAqLw0KPj4+ICsJCWxlZC1z
ZnAxLWxpbmsgew0KPj4+ICsJCQlsYWJlbCA9ICJzZnAxIjsNCj4+PiArCQkJZ3Bpb3MgPSA8JmNw
MF9ncGlvMSA0IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4+ICsJCQljb2xvciA9IDxMRURfQ09MT1Jf
SURfWUVMTE9XPjsNCj4+PiArCQl9Ow0KPj4+ICsNCj4+PiArCQkvKiAoSjI4KSAqLw0KPj4+ICsJ
CWxlZC1zZnAwLWFjdGl2aXR5IHsNCj4+PiArCQkJbGFiZWwgPSAic2ZwMCI7DQo+Pj4gKwkJCWdw
aW9zID0gPCZjcDFfZ3BpbzIgMjIgR1BJT19BQ1RJVkVfSElHSD47DQo+Pj4gKwkJCWNvbG9yID0g
PExFRF9DT0xPUl9JRF9HUkVFTj47DQo+Pj4gKwkJfTsNCj4+PiArDQo+Pj4gKwkJLyogKEoyOCkg
Ki8NCj4+PiArCQlsZWQtc2ZwMC1saW5rIHsNCj4+PiArCQkJbGFiZWwgPSAic2ZwMCI7DQo+Pj4g
KwkJCWdwaW9zID0gPCZjcDFfZ3BpbzIgMjMgR1BJT19BQ1RJVkVfSElHSD47DQo+Pj4gKwkJCWNv
bG9yID0gPExFRF9DT0xPUl9JRF9ZRUxMT1c+Ow0KPj4+ICsJCX07DQo+Pj4gKwl9Ow0KPj4+ICsN
Cj4+IEhlcmUgSSBhbSB1bmNlcnRhaW4gd2hhdCB0byBwdXQgaW4gdGhlIGxhYmVsLg0KPj4gRWFj
aCBTRlAgaGFzIGEgc2luZ2xlIGR1YWwtY29sb3IgKDMgdGVybWluYWxzKSBMRUQsDQo+PiB3aXRo
IG9uZSBncGlvIGNvbnRyb2xsaW5nIGVhY2ggY29sb3VyLg0KPj4NCj4+IENvbG91cnMgYXJlIHNp
bWlsYXIgdG8gUko0NSBjb25uZWN0b3JzICh5ZWxsb3csIGdyZWVuKSwNCj4+IGFuZCBhcmUgaW50
ZW5kZWQgZm9yIHRoZSBzYW1lIHB1cnBvc2U6IGxpbmssIGFjdGl2aXR5Lg0KPiBGb3IgdGhlIHN3
aXRjaCBMRURzIHlvdSB1c2VkIGxhYmVsID0gIkxFRDEwIjsgRG9lcyB0aGUgc2lsayBzY3JlZW4N
Cj4gaGF2ZSBzaW1pbGFyIG51bWJlcnMgZm9yIHRoZXNlIExFRHM/DQpDb3JyZWN0LCBvbiBDTjkx
MzAgQ2xlYXJmb2cgUHJvIERTQSBzd2l0Y2gsIGFsbCBMRURzIGFyZSBsYWJlbGVkDQppbmRpdmlk
dWFsbHkgb24gdGhlIHNpbGsgc2NyZWVuLg0KDQpUaGUgU29saWRXQU4gU0ZQIGxlZHMgYXJlIGR1
YWwtY29sb3VyIGxlZHMgd2l0aCAzIHRlcm1pbmFsczoNCmFub2RlIHRvIDMuM1YsIDJ4IGNhdGhv
ZGUgdG8gZ3Bpby1jb250cm9sbGVkIHRyYW5zaXN0b3JzLg0KVGhleSBhcmUgbGFiZWxlZCBvbiB0
aGUgc2lsay1zY3JlZW4gYXMgIkxFRDkiLCAiTEVEMTAiLg0KDQpEdXBsaWNhdGUgbGFiZWxzIGFy
ZSBub3QgZ3JlYXQsIGlzIHRoZXJlIGEgYmV0dGVyIHdheT8NCm9sZCBzdHlsZSAiTEVEOTpncmVl
biIgZS5nLiAuLi4/DQoNCg==

