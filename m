Return-Path: <linux-kernel+bounces-160585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0878B3FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D462853BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBABE6F;
	Fri, 26 Apr 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="X1w39yGn"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2122.outbound.protection.outlook.com [40.107.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68BB64C;
	Fri, 26 Apr 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157468; cv=fail; b=YeThpjKIpZzipAprj46NVCxxb8RmGg7VfkVZDoSm+XEHQr/H7BfLqo9uCEggJnxUREvFNRA/UIA36qL/+owlPyfHZezzQ2xzDJ4zWEKVnk6yB5ebHaKWOHZCXv5XldKBz64XEfd5lOvsxYQZDi5P7LPzinha+M/q7nNukqKTj1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157468; c=relaxed/simple;
	bh=GFhHrBmRzaWjIhqjSk0773g7VKCSytRN+FAlhLgUw3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hp7sTg9NwIMPfEir9v3htpkMDtGiaWP/mDkws/3OX0qwPvjmOkU4xwktQpjp2nKMqBmrinuy5HahZOiplB54AkoIRgsTOLC7shKqvoNV4bSsGAMB2bEqAp4hWgl8PZuEIuK9Ugto2u3ghiQsuavnfaTs9BCW3j4VP536CkzlrPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=X1w39yGn; arc=fail smtp.client-ip=40.107.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QczOMpz65CCa5pxai/Cse+RbbWjfO8INiKYEh24ijldWChBw/owgeG4A7rpm6lrLHUhpebs20k21gWoDL5GMZ45yQryybtHIR0VL+awhrCjneDeysk3C/Qw4G+oJtz3DNgo2wAlTN29pvSNBlPvDkCBbNFMTowZNHtK6LFd/+sqQXZmUWDDbUh85c1KOUjqgDQwMJPEo8B0gBZTfrOXa14ssXBQOlxrA9JjJOVqLypx/yXEwThU36OfU5Y7ICznOy+N1UwqVq2AP1haBMLmlhSEujPUo65VU3Dze+qncwJOC5gvisqlaAfhkmYyFMZKdNn/DQMMSE1nwAE6cFWPUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFhHrBmRzaWjIhqjSk0773g7VKCSytRN+FAlhLgUw3o=;
 b=JUBKXp3mDdug3PZKLO7MGa/GSQDBXuuskXqWi0OyiHWCrkzakm018cnfcLgC63pbMljYl6cXzesi2csxyey7j/AWHnW6DNAvdzGvFPqrifHCXGMEmNMlGawBKOEAwf1rOWAdE9EUMDqIafjk76dKvnble35a78dWUzg4YTfeQPpWN+ycSxdlYj4/ZOrJ9efHOsdEQcVrUhCKxAVSf865BUlWV7vom7c7bU2WZu/g6G5yekUzegNe/690jvSD9Yt6GQvEga6S7ldnrzDPkxnSpcFm2A8lisGPCqsmN95EZXRlRgfhCEFPtV3M0z0ZsNDNKMiRsKqyNyZFW80qWcY/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFhHrBmRzaWjIhqjSk0773g7VKCSytRN+FAlhLgUw3o=;
 b=X1w39yGnKHR59VbQYWCQDxuvzBP27fa625EK8i/0BSKNNzEVyFXSxwri5tXEpQpWXKbjWYqSPxH7AIBkGmbDhYmoRv7BkxLIkvBzLyOgc43URoEEfF+qx8TF4NT95UkldrAe1URWyoBRKhRK6JNqmRoJ80R34rgEgApOcBpVXkc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 18:51:02 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 18:51:02 +0000
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
Thread-Index: AQHajmt4w4zwT8gI9EGUFXDjzCdkprFnv8QAgAyX9QCAAAKKgIAGlQ2AgAAJNwA=
Date: Fri, 26 Apr 2024 18:51:02 +0000
Message-ID: <32ec3ef4-0ecc-4ae2-bf76-c7b10f54a583@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
 <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>
 <fd466583-3221-4b94-b66b-18840615fb71@lunn.ch>
 <15b79794-41f4-43e0-888e-286ca1fc4321@solid-run.com>
 <d0426bb3-1f40-48ed-9032-6ffdce455cd4@lunn.ch>
In-Reply-To: <d0426bb3-1f40-48ed-9032-6ffdce455cd4@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB8538:EE_
x-ms-office365-filtering-correlation-id: baf4c3d0-225b-4897-931c-08dc6621d215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y25YdlZqVGRKcUQxb3F5aW1DOEt1a05YWDJDaGE1OEk2N0V3bk5XY1dhckZP?=
 =?utf-8?B?Z0p3dXZnQVYzTEp1T0NkeGFNS3RWOElVVHNpSWl6ZFFBL1VmOWFUWHpzenFI?=
 =?utf-8?B?dGhzWHg4b1d4TkVDb2p4SGRHRWxka2d0WjhoYTRoalczVUlnYVhPVHM5Tnpy?=
 =?utf-8?B?NThQT2JYZGgyenZTSFkwQ3UrbEpjRkk1OURoazUvTXBKZWlEUDdpd25OZTZV?=
 =?utf-8?B?aEpsczQxOUZYSjcyV1NnZTNYMDBmS3lEZUYrWllHbUdpUU9sRk5CSjgwUEdq?=
 =?utf-8?B?cjVraWFuSzFHK09OSmY3OTNEOU15Kzl0N2pPS25MMzZHZUxOS2lURWNqc1dz?=
 =?utf-8?B?aHNaSC9OOVlxck1XK2FlRjJ4ejllMlh0ZGJEWjJkTGRvWlpOcHdTS1ZDYity?=
 =?utf-8?B?OEJWV0ZFcWJhbUhEREdZRXk3OGlXcDVzK2F1Q3BpS01XSVUrRGxrS3hqWUQ4?=
 =?utf-8?B?WEd4eUpGb3pINVFHQmQ4VFFSSWJJYXdYWk1PYlUyek9ucGt0V1d3ZUxibEln?=
 =?utf-8?B?SDVjTUxOMzR1Kyt4VXVaUVRzS0FrYmNWNGxNMVppZjZ3bHZUUlZnaG1VYWZH?=
 =?utf-8?B?ZXZ3bDVKNzVoS1pHM1hhYTZUK05Oc0QvY1AwT1AyN0hXdHZYUWM0d2NvR2pR?=
 =?utf-8?B?Q0NDaTlGeWg5ckZBT1d1TWFUQXlaRjV4L1FNby9jMytvdS8yZjBuVCtmd3J5?=
 =?utf-8?B?aE0weHlHUjY4eWVZcmR3ZnVWZE5UcGlmQlVESG9lZXR4K3F0VUpMalNhd1JY?=
 =?utf-8?B?ZkcwZ05sOGQ2YmFqcDdFVkx1QmlTTjdqeUppdUxJOWoxbzdaZHBFOWRSd0Mr?=
 =?utf-8?B?RUo5V0ZJdm1Bc2sxc29RVTRkMFZ2K2RPVGF3clgzcU1BbElOTVJSdS9xNUVn?=
 =?utf-8?B?c3FqaFRzVyswdmpyUitPeWlKSUZHWkVhRlZZTzduOVU5SE91cncrNlkxM2di?=
 =?utf-8?B?bExYR1E0RlB6ZjViUTY3cHV3eW5hUHluT29zNndSUWVadEg1UFNjeFp5Znha?=
 =?utf-8?B?Y2ZqM0d3MzI2aHN0cVFHajJ4TFhyOWwzcjlFWUt5VEJoZWp0b0pNY2M0NHpm?=
 =?utf-8?B?QmEvWVczMzQyRWNpMjVtTU9OQ3B1bGM4clVtRjJZbDRYS2RrcC9zMjJYQU5h?=
 =?utf-8?B?bjYvRGR4d0JhWitaM0Z2bzB0UkpWbXJnSWhQcFFReTJtVEVVMUs4NXlqZjgw?=
 =?utf-8?B?anR4Y21JaWhNQlVIaktiWUc0cVlLd0o5Vm9wL2piUlVuYWRDak9aaTh1RWQy?=
 =?utf-8?B?eWduWUxxaHpDYlZIRGs2NUVkcGFoRzhlS3pJY1UwNmhadXJrNW1qNTRjMVd2?=
 =?utf-8?B?RU5CS2V6a1FjME9sdjZBb25qeEY5b25aMTVadDdJbU9HY1BnaTdEY0JmWEND?=
 =?utf-8?B?Mk9mSnBlbnhjbEpISHNBZzVtTzdVdFFwc2Z4TFRNWEp6SmkzcXNsZVdBVi8y?=
 =?utf-8?B?T2lodTV3eFpTSVJYY3ZEUTVIZVRIVytTcHA3YjFZdk9HRncrdmdMbmRSd0dy?=
 =?utf-8?B?M0g2dWUvYm0wTVhFREFreUVCUkFYWVdDSFVVVUh0ZXN4emgxMzV5ZGxIQXQ5?=
 =?utf-8?B?MmFJN25ZTm5XMHhldjBYVFRvNlBXR3M3WlZjWXdXZE9nSERuRzcwMlhSM2hI?=
 =?utf-8?B?OU0xUkpGd084eDVBNzNpN3dyT083KzJOUWp5V2RCQklOaXVROW14emh6b0JF?=
 =?utf-8?B?Sm9MQkx6VXlPTEdGcXpXWWYzM3AxSGpIelBJVitpOEdrSTdXRXZYYkRnV3Nj?=
 =?utf-8?B?dndaRVB4amVjZytza2RhYm1BbEhXOXl6bmJLbnN0SFhTemdLQ2pyTWlwaGs2?=
 =?utf-8?B?OWJ3TE56bTgvVm9mRG1WQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3hhNEJBME51dzZsMlk5UnhJZW9ZUnRKR3kyNTF5bnQvQW5TQ25GM0ZzNUZa?=
 =?utf-8?B?M2hsWEZpcEl1LzlMR1RpczlmRS9jcUxrSlRzZjgzOVQrSlIxWVFkTDVjemRa?=
 =?utf-8?B?U1d2Q2llOTNyL1JsREYyNHlOdlVSQ0ZOeHA1RXk0Vk9EYzJUTVBqeVFnZXF5?=
 =?utf-8?B?TDdxN21oUXFKMEViNCtSTThpbkhIS05oZitqYWNWMzNSVmZhN3dZamlHQ21l?=
 =?utf-8?B?MGNMSDJWR2R1RC8xREJXdWVRamwzRzFmMkJTUzV3cTlrdDlrMEFOMkk3SmVB?=
 =?utf-8?B?cTcvcmgvYnEzWXBIdWUyZTR6TUJ2cnRsbEdGS0ZncVlYd0lCNU5WOCtreXN2?=
 =?utf-8?B?dlJjSmJsVUsyenhNTGZKTEJEWFowRkhWWHVXSmRBaEszM0xmWnFaRVY0NFg2?=
 =?utf-8?B?bmw3QldkQ01xYW1lWEFYWk0wNHkzWkpkRWk1dGRNc25hM0lKaFpINlk1ZHFD?=
 =?utf-8?B?K3JOc3V6NEJRZWRWcm5LdXpQb3cySk9pbVEzRGVkVnZ0UDlCb2toMmZlVkh5?=
 =?utf-8?B?aTRhd0ZnbjRwUk5jYlJiL0tjYWJOVU5qQ3JwOVVldTRoV01tdnZoaGkrNGxw?=
 =?utf-8?B?N0kwNy9ySTQ5WkZYSDBPak50dWFhWXFINm11NTNuOWpYS3ZuaUF2aUxDOTBF?=
 =?utf-8?B?d0ZaeXc2amJuOFZVOWVHTnJBbWU3cFlEdWFkMStzaEhKY1o3T0dtVFJDMXdu?=
 =?utf-8?B?UWszSVdMbEVxQVdxdFp1aHBsSDgvZnNhaEpXRjZpUUt4dHRhemFFWTFMMnJT?=
 =?utf-8?B?UFFPemhKdUxqYmZVRlNWZWdwY3RlQzVUYUY4RVRkZ0RqWlQ4KzNTNDNMWkJ0?=
 =?utf-8?B?azQ1RHpWa1VySDMySXN0MlUxU0dWV2Q5U09vcDZLKzl5c1l6NkFNcVoxVzhM?=
 =?utf-8?B?bmJOcDJ0T1ZjanU1d2F3bytvZVpoUW1mUEMzV1Q0Y2dqeWgzZGRtMndnOXI0?=
 =?utf-8?B?NlpJazIvNGtOYytZWU9tNHBUSlZsbG9aS2ZURDU2TEZRWDlDOFhwb2RVWm1u?=
 =?utf-8?B?bFgyaisvNUFqTThZVEFEeUdLVCt5OFY5cGdrNmY2L2lpQ1J5bFVTcTk5L2d2?=
 =?utf-8?B?TnZuWFBOd3l0aU0yYVE2dTZCWWNPaFc2VjRVUW9sNXZDWnRJSzI3YTNkZmxM?=
 =?utf-8?B?M29yTUNhdXpMYllUNGo3eExSbUs0UjZjaVQrUllib1NkNEl2UG10a2JKMGVt?=
 =?utf-8?B?NXlVSnJnV0lCRzNnKzBGckZVWGRES2x1N2txbCt5QkprdXpJVXV6dllnNDZE?=
 =?utf-8?B?elhyWWJUZnpBbENyM2FobTJxOHV5Z3BzWUxpZjRRSGZEMjE3VWFyTzZtdnps?=
 =?utf-8?B?WDlIZ05IaXVpS1R1b0xNbE9iZ1RrNDkycjhOK3l1c2tOOWdKMG04dTZBVkFv?=
 =?utf-8?B?dDNWaUFIRlN6U1E1ekF2SWRobitRZjRJckwrb3ZjUC9lejJCK1dyQlRyVlVC?=
 =?utf-8?B?RmpzWEVxc29sR2M4TWFxbEZWNGptRTY2VVM4MUV2Y1A2QktTTVJzeWRnU1FB?=
 =?utf-8?B?KzR4aVpoY0NiWHhvWWNMbkJGbHc2UG4rdDl1UDlYazYrZzV5Slo1SEdnNU90?=
 =?utf-8?B?REdROU15U3NmRi9rTzlkY2t1ZXhBbitZbzFVUk9xRk9qMmwrSUZYU2Y5RVdq?=
 =?utf-8?B?Mm1YNUlMVUJibFFGNXNudDBDY2RKSEVLZWE1TllDcDREWlNMUm5GalNXVUxw?=
 =?utf-8?B?bW4vNDZkQmx0SEx0NVF6dml3eFlLMDJSbStCOUNBRE9pcE5LWm1HcTUyZVZ5?=
 =?utf-8?B?NFdmNlQ0Nko4RWpjSTZ6eXdDODR2ZDRWNFFZSENlVUxKc2VEd1I2QjBHRWRx?=
 =?utf-8?B?bzIxcnRHU0k0Y2RMZk0zU1FtZ3RVdkdIZ3V2QUozc25leXppRXBtbGJmNkRB?=
 =?utf-8?B?ckhyVkorOEsrMTZVSUhka3ppQUJlQUNRbXVPZThKMzRnUHBzOVlSOHRKK2Rr?=
 =?utf-8?B?SE5ITWhKL28wSTFMZS91RHpuL2VUbTZQc1hrUDZzMzNZV1BKUFZFcHNzbzg0?=
 =?utf-8?B?YTA0SXhHNDk3U1NHWFQzZ0lObVhnN3V2ZThsQXlzT3lMZUxnSkZMSm5Vd3VP?=
 =?utf-8?B?U2JDVmpBVWczWVpCN0VwUWcrSTJaZlg3Nk51bjNtSURnbXozd3JjV0tBVjB2?=
 =?utf-8?Q?8Y1Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC3EDE139381CC4D9CFCC7171BE56970@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: baf4c3d0-225b-4897-931c-08dc6621d215
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 18:51:02.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxGIbc49fbb5iV4vOrQAzOL2lF6XeNfXi85q1hb/7ThYZTRsgi5Ah7YGGQNx+jpthq6xc52D679SeH3sfQIa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538

QW0gMjYuMDQuMjQgdW0gMjA6MTggc2NocmllYiBBbmRyZXcgTHVubjoNCj4+Pj4gQ29sb3VycyBh
cmUgc2ltaWxhciB0byBSSjQ1IGNvbm5lY3RvcnMgKHllbGxvdywgZ3JlZW4pLA0KPj4+PiBhbmQg
YXJlIGludGVuZGVkIGZvciB0aGUgc2FtZSBwdXJwb3NlOiBsaW5rLCBhY3Rpdml0eS4NCj4+PiBG
b3IgdGhlIHN3aXRjaCBMRURzIHlvdSB1c2VkIGxhYmVsID0gIkxFRDEwIjsgRG9lcyB0aGUgc2ls
ayBzY3JlZW4NCj4+PiBoYXZlIHNpbWlsYXIgbnVtYmVycyBmb3IgdGhlc2UgTEVEcz8NCj4+IENv
cnJlY3QsIG9uIENOOTEzMCBDbGVhcmZvZyBQcm8gRFNBIHN3aXRjaCwgYWxsIExFRHMgYXJlIGxh
YmVsZWQNCj4+IGluZGl2aWR1YWxseSBvbiB0aGUgc2lsayBzY3JlZW4uDQo+Pg0KPj4gVGhlIFNv
bGlkV0FOIFNGUCBsZWRzIGFyZSBkdWFsLWNvbG91ciBsZWRzIHdpdGggMyB0ZXJtaW5hbHM6DQo+
PiBhbm9kZSB0byAzLjNWLCAyeCBjYXRob2RlIHRvIGdwaW8tY29udHJvbGxlZCB0cmFuc2lzdG9y
cy4NCj4+IFRoZXkgYXJlIGxhYmVsZWQgb24gdGhlIHNpbGstc2NyZWVuIGFzICJMRUQ5IiwgIkxF
RDEwIi4NCj4+DQo+PiBEdXBsaWNhdGUgbGFiZWxzIGFyZSBub3QgZ3JlYXQsIGlzIHRoZXJlIGEg
YmV0dGVyIHdheT8NCj4+IG9sZCBzdHlsZSAiTEVEOTpncmVlbiIgZS5nLiAuLi4/DQo+IFNvIHlv
dSBoYXZlIGNvcHBlciBMRURzIGFuZCBTRlAgTEVEcywgZWFjaCB3aXRoIHRoZSBzYW1lIHNpbGsg
c2NyZWVuDQo+IGxhYmVsPyBNYXliZSBwdXQgJ2NvcHBlcicgYW5kICdzZnAnIGFzIGEgcHJlZml4
IGludG8gdGhlIGxhYmVsPw0KDQpObywgbm90IHF1aXRlLg0KDQpXZSBoYXZlIDJ4IFNGUCBDb25u
ZWN0b3JzLg0KT24gdGhlIGJvdHRvbSBzaWRlIG9mIFBDQiBpbW1lZGlhdGVseSBiZWxvdyBlYWNo
IGNvbm5lY3RvciBpcw0KYSBzaW5nbGUgTEVEIChhcyBpbiBwaHlzaWNhbCBjb21wb25lbnQpLCBl
YWNoIHdpdGggYSBzaWxrLXNjcmVlbiBsYWJlbC4NCg0KIkoyOCIvIlNGUCAwIjogIkxFRDEwIg0K
Iko0MiIvIlNGUCAxIjogIkxFRDkiDQoNClRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlc2UgbGVkcyBh
cmUgZWFjaCB0d28gbGVkcyBpbiBzaW5nbGUtcGFja2FnZSwNCndoaWNoIGlzIHdoeSBJIHB1dCA0
IGxlZCBub2RlcyBpbiBkdHMsIHR3byBsYWJlbGVkICJzZnAtMCIsDQpvdGhlciB0d28gInNmcC0x
Ii4NCkJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgZHVwbGljYXRpb24gb2YgbGFiZWwgaW4gZHRzIGlz
IGEgZ29vZCBpZGVhLg0KDQo=

