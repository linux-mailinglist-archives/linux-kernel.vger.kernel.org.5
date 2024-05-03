Return-Path: <linux-kernel+bounces-167742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8D8BAE6D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867E21C212F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA598154BE9;
	Fri,  3 May 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="YKWapt7L"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2049.outbound.protection.outlook.com [40.107.114.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9203154441;
	Fri,  3 May 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745107; cv=fail; b=Vp9vG1b1lvqdCQ4KUa2lILYpzitjIYZsernEJk+K684J+OLIRCGMx6D3OV3e+f6tHxxPoDsJAAdDZIG/KWMy+ba8vNOHjr0Xz0cLRxi70aLHIuohN9qFxfN9wDpf9rwztxNtXVjsCi1lcK2sIylXOJdtZ2wFLC0LhtP+P5XT0Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745107; c=relaxed/simple;
	bh=fedJ7PoHQIcpql1yWOmZeriq0U+j55OSumqmFT0z1Ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAmr7hT71/HDrGkOudRFAfvG0wB9XadcgoH3Aylgn8jD/FbseF8GAHATY3jQM2s+mJuCZeMcwXRcBSFhIrPyYXxiCQAZ2dpaM96yV8eSwoLHEkmC0y18nyewt1vC4OpbvwT0C85GhQEPq6XXvN0H8hGM1m+PzAz8G83LtWMBeyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YKWapt7L; arc=fail smtp.client-ip=40.107.114.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4CeAMFgfPJapOF6R3wtN+kJcz+OjPM4slO06svfetJ0nDnKNLvnKuEjMbGrvkZL9HKBVim3Vj8/NWxZlryL2nWMtJ6iAnNJNLubLUJfFthkJ81g9eV5utBVS9xeOnjvG+rzrtftE8gXrQEuM2i2J1657Xmnx/Dopd17kLj0JCpeNGWjXNz2fPu84j38ZTxQyP81qkZ5di1Refes2gavTi7YOo+iH9spkdgLb/NUaDoEf2DnD2KRZ6rCemLyJe1XuwO6wMw5KSb0JsNxIvPBP1cwqhlI2qaNjvSd1qBjdARUuanxG9bIREEsc5/YlRa0fjiFx4zexWWezLjdYVAp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fedJ7PoHQIcpql1yWOmZeriq0U+j55OSumqmFT0z1Ls=;
 b=RiRcgFDl7lWdekhaRBQl55wQySmEqKOLYg59gsiijDicTbMtK2Qo1MoVAf6l4SLvDYOGvVfrSvzZok5SKMoDbx19AvnO0KtMCgyb2BY9kr8VCI0SW6o/EXsgnJ2+spgFwKCcGExT4TUlMQzrpMR3nr+TcIj22Yc/6PlrxVePsxkX5SEg1uEd/kVBViefAjteNHhljiY0TA9kRyHn520tdb46eTGJy92pgWMjsEpL9sSw0PngHV65vDxdzGUTNXjL08dLry4tjRag+Y8nZaC8Wjm+IpFAJ+a/icz4P8gFyqXN84j/ir4E3ABDKrlfPRdXINmmVPKiz51pqEj9bwfZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fedJ7PoHQIcpql1yWOmZeriq0U+j55OSumqmFT0z1Ls=;
 b=YKWapt7L1JV0U1RAlp5w+Kq1C7PfXcNLz998pCzOeJKsdNUyIsFMbuT3/rAAXWi4+TDVTX8iOto9R/YH+aa8caSst7R4PyoudsAe8WKCfQauSqlN5Dm66Hzanr5Z+pxbNeBTcHaKPk/kZlf1miJHdxE3S+V7k8HxQyHBJ70DVeU=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB7398.jpnprd01.prod.outlook.com (2603:1096:604:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 14:05:01 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::68a6:2f99:8ab8:5c64]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::68a6:2f99:8ab8:5c64%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 14:04:51 +0000
From: Min Li <min.li.xe@renesas.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, Min Li <lnimi@hotmail.com>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>, "lee@kernel.org"
	<lee@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output
 delay is 20 FOD cycles + 8ns
Thread-Topic: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output
 delay is 20 FOD cycles + 8ns
Thread-Index: AQHam+EqyUtERyeP2kCIQ39721AzALGDghQAgAILFYA=
Date: Fri, 3 May 2024 14:04:51 +0000
Message-ID:
 <OS3PR01MB6593F03D7D184848625300B9BA1F2@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
 <LV3P220MB12024CB984967E4AC05A1E13A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
 <20240502064946.yc6v7xadwkfldbsw@DEN-DL-M31836.microchip.com>
In-Reply-To: <20240502064946.yc6v7xadwkfldbsw@DEN-DL-M31836.microchip.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OSAPR01MB7398:EE_
x-ms-office365-filtering-correlation-id: 948cf67b-c917-4302-e60a-08dc6b7a006c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFFhUjRaajZXUlZHYTUyNGJKR0dmTktPUCtHQ2pzSGR3WUxqb3k0ZzU3Q0pF?=
 =?utf-8?B?dDNTaGNwbjdPWHFTSE8zN2djTUpMTUh0N3dsR3ZzYStuSFZseXZLV29RQ2p2?=
 =?utf-8?B?MzJJc1RqSjZYMDN6TmcyVzZNKzlMZmEwZnRQSXV2d0lTZ0pTeFdGL0RJZGhp?=
 =?utf-8?B?allMZ2hrMVdpRlZyVFR1SlFTQy8yQURxV0huWnAxa2VGandRY1F3V0lmMXMz?=
 =?utf-8?B?UVhjejlZL1F4MzBJRFNIUkxKaWl2aEdsVXJ4dVJEZVRLcm1qM3ZHQi8vTEVo?=
 =?utf-8?B?UGFZRjRTbzZoUlRjajVxWVpLVGtYNHQ0cXBVczNqTTBXekx3VndvdVY1c1V3?=
 =?utf-8?B?OEp0Mmo1eGdjQUgwSXhGNWVlMlh4U2FIREVKYUVYV3BEMHBjZnNUSUZSbDY3?=
 =?utf-8?B?a3c0TjZGRDNYVk40QW0zU3N0Yk45cGVCZ25sdGtEMWFhVU5tNFpPWTlGeTZ0?=
 =?utf-8?B?ejJ0RURraTZtOFVNaUg1MkFMOWswQml2Nlg3Lzk2bC8reE4rNGFPVFQyYVlx?=
 =?utf-8?B?L29ZUzBsaXc5ZG0wbFhWMUU3TjFQZStsSWZ5WHA5TllrbmUrSTM1SVRWT3hH?=
 =?utf-8?B?dUFlcStSOENRclllaUdOOGllUWh4OEVObWZyZEJGRXVLTXQxcUlYbGxoeVVU?=
 =?utf-8?B?QWxhd3N2LzBtd3lzN01RNHhlRkR1Zjl3VCtlMnBTT21VQ05xdWtybjBvVGIz?=
 =?utf-8?B?K1d3QWNCQzg3clluNGZLRkZscEdTUjltREYzRzliWHREMENDdmhKM3d3dmpZ?=
 =?utf-8?B?Qi9rNnVpNmpuRHU5dWltU0lOT3U3UGtiV29xVSsybUszaDUzK0wwTllCRE5K?=
 =?utf-8?B?RldOVndpQnMyRWdhNDRQdGdEZ2E5ZjF5M0NHY2JmU00rcjJHSE10RXZoZ0tx?=
 =?utf-8?B?Nm1yWXhWYi9tY2xMenVKZlNvWkFGbHNJdUJXSFQ3c0J1clVKYzZXc0x1eUJh?=
 =?utf-8?B?L3JaMGZQUndYNnV4eEFTOVRXZmFIYVYxSHE0WENLbGtOTkFmU3lYQTJpWnRC?=
 =?utf-8?B?OHd0dFlLVEtVMEM3eTZWbXJHajFzMys3R1dXY2d1QXE1Nzc0STRYTVlQcFVy?=
 =?utf-8?B?MEN2dDZxWThFaFluRUlZbmJOZ1ZGdmNKK0NGTXR3anFnTkl2Y1VqMzdwcU5N?=
 =?utf-8?B?QW9ROVZubGxYZFdmdm1SZUprQzdjdm1vL3Bma25PeDA4ajdEOXZZdk1qeXh3?=
 =?utf-8?B?SG02L1BDK29wTHhlWjMwNzExRi9qTFBhUHYwRWE3N2ViWUk3VmpsdXJlczEz?=
 =?utf-8?B?V1hkd3YwbWdrVVY0MjhlRmoxL2diZ3RRUXJIR2NBc0JsS0hrOFVwOTNpSUUx?=
 =?utf-8?B?UWVBZWRkYjE0NkhPUzgycWJOS0RBZ2ZvNVVxN2w5WGdsV2I4UFd2RFpZVTA4?=
 =?utf-8?B?WUJ5YWNyUDlBUTd2OVg5V1BWZTBKRGljSmZWWGVLUkwwQUxqNlpCcFMwUHJj?=
 =?utf-8?B?UG1ybXFaU2tFZkMzeGVCdzNLZ3Q4Q0FwdEJOZ1lrRW9xY1FPNUR6d1l6YTlP?=
 =?utf-8?B?ZFF2R1p0bVNYMTIvbUZuZkxuOHcwcjB2Rjk5Qk1EaFNQR0RwdGZZQ0tTRy9t?=
 =?utf-8?B?OGxBOW5uMWZGcjNlalkwdFZmQ2ZBcER2djVBc0RYK29hN05EaiswRWptSmhp?=
 =?utf-8?B?TCtXRTZBR2JOUmV0Y09TV2tTVGI0a2tYVW5md25VSzJodkNZMHFtYko3bGxy?=
 =?utf-8?B?UlVyRjBwZyt6b2hSam9Ya3BmSnhMQlRtSllZdVlHSy8rQVBFc1JuQjZNS0N5?=
 =?utf-8?B?dExDRS94UGQ3bjg1N1U2aGcraFc4WHBzb0RTMEY0RitmRnI5SDluNWUvdXVQ?=
 =?utf-8?B?U1ptWUR6bnNnL0JOeHI0dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2NaVW5EeVcrWEU3U043MGg1M3FCdWlmRVRoT1RLMmRIZzd5WWROV2NYRklR?=
 =?utf-8?B?WlA2aWF3QjZWeGFGUDF3cWZabkVCOVRSM2FwS3JrS3ZsVnR3bWVHdGpGV0Qw?=
 =?utf-8?B?TWcxVERkc2RHSExUYm1UTnlVVDRNM05WQ2Fuc01QRUtnb2F1SUcxYkRDeSt1?=
 =?utf-8?B?c25QZnowWndEZVp0RXhDbTBEQVhiNFQ5cEpqWnY2MC9FbjVmaEtoR2xZVXJp?=
 =?utf-8?B?c2ZNWFdPN0tXNjRTK1Y4UlIvaFB5MDVEVGFsK2ZFL0RucFFoN1REZk9UU3RY?=
 =?utf-8?B?RnQvSzZLMVl5RTJZbE9uaS9KczdGU0hBWVI3aHJ3UEd5MllkVGlmbmlhUHZy?=
 =?utf-8?B?VVlxWklHUDlKY1NqSnd1RjM2ZHBDQTJGejhXcERsSFFyWW1Fb0FDeWt3NTg1?=
 =?utf-8?B?Y0RVS29mVGFyN1dacVBwc1lSTDVFaVBOMFBUTE01dy9RQkJZSWhHQk9ySE8w?=
 =?utf-8?B?VnZsRzlyRURPbGp2T3RJZHpFTFJFdVcrZ3pFQlkrWkRSL2JlVU93Ym9lUU55?=
 =?utf-8?B?UHp6bTZDUzRPZWpDVi9mLytrREZnK01ieTA3TkFHcUhqdWlnNFlPdUhOYjZ1?=
 =?utf-8?B?UHR2ZzhKbWh3YXZ1b2ZwckJOa1dSODVyNUs2WHdxbmpLaXJERTZxMzFlbncy?=
 =?utf-8?B?NVRtZVpHNDgrSVNZbGh1UjlucVpJb2ZqMW1zeVRoTkZTRjlXWXc0NCtaVGJP?=
 =?utf-8?B?NWRMdEZTbXJXMWp3bHZia0NJaVo1ckRCdTVhbFF4K3o5dXN1RGlxd3FaNFQ5?=
 =?utf-8?B?NVRTdk55QUZxcDdEcXpNeVI0elpaZTdiNlJ1TzBpZGNtRUhTSkhuM3EyOGhz?=
 =?utf-8?B?U3pWTWJnMXp6ZE5JUGlRKzFQOTludW50WDZlSjQ5V1VVZGdHN0o3Z1ZEZUJG?=
 =?utf-8?B?N0V1dTFMZjF3dkN5RDJDQ20rK0RIWm1HR3lwUktXclZtWm1DZjM5T0UzcjVx?=
 =?utf-8?B?dUR5NE5pM2ZXV000WG5hcXZQa1I2ZytwbkdaTysvSUF3VEp0enRBS2JNazgy?=
 =?utf-8?B?RkkreEdzUCtIZEpKeXRjOFcrTjRFZmZVbjJjU2d0L2JhZnZva0NTdnlwYWh5?=
 =?utf-8?B?UW9lakUweWNodVpyVVhZV3EyOEJRL0VEa2crSHgrOWRnYTgxTXZrbDdjdjFX?=
 =?utf-8?B?dkFac25SUmVJbS91cUcxWTNoQVlwTlR3RURlRTRMMUVkNlRLODZWQTVsSG5z?=
 =?utf-8?B?bkdZWUFad2d0ajJWY0hCUm1IWmRsUTljV2loeUl6WityemVScDgxYk5Jejl3?=
 =?utf-8?B?OG9vR2JjZXd0M1BGWVRGcjdPSjJ0Y3BrN004TU9sdEJlWEhyaDRhNnBOYUdM?=
 =?utf-8?B?MTFSTWtSYi9JaW4wQ0VuVFVhMEYvNnVSVVhVMksxVHVwWVdQQk5qdHk0NXBv?=
 =?utf-8?B?clJYdkNzei8zR1dLZ3A2N0dURVV5WkJERVBJRlI4Vkgyb1J4R3ZwM1h3VEJY?=
 =?utf-8?B?VExPV3hnamdOMGJ4V3d1dmVWU0UrditYZjRDRDFqNmtyVWFSR2lFNDhZUi9o?=
 =?utf-8?B?OG04RkdzUk0vYTBwbnVPNHRnSHY5cDE2MG1pNHNXd3hKL3cwUHRLbGdsbGl1?=
 =?utf-8?B?dDBFZUllK3d0UDNOcCtHMzcxNjMxMm1ic1RVcGVsZ3Vwd2NldVpNcFRxN3FC?=
 =?utf-8?B?bkRWQTJDU0hYVWxXUERxS01pZ3JjT1EvYXBHTml6cERlOXlGSFVWb1gxSGJi?=
 =?utf-8?B?d2hSbytHSHlvL3B0TjhNQU5KVkY4bWdrT28vekZPek1JR0JQdi85Rk0wVjlh?=
 =?utf-8?B?VGhZVXM5OTd0cG0xTWlwSUZ6anpVZWFDN0lPbENsRlNhbXI1UW1BZzdrcnBn?=
 =?utf-8?B?eHczM2ZNNitzVTZTMnZMRG1vNSsxRXRyelEzQ2o0aUxocC9HeXBtanVxdGw4?=
 =?utf-8?B?NTlxdDA0cmNUUEMxQXdEVnZHOVRmb2xLdlFMdEFBVVVudGVqNEF5NkozUURW?=
 =?utf-8?B?WDVOUUdQRnU0MnJya1BKS0t0bHJOZTF4aWNkUnJZbjVLQnA1STgvdExqUldX?=
 =?utf-8?B?K01MTjIxQ1BQSlFJWXMvRUtyYWgwYU1lMFg0eWhPWW9LWHBPSkphMnRBTzlz?=
 =?utf-8?B?cUpUVzJsQU4xZkVxajk1QmRxMENCYXB5NGZXNkpRSUEvZ2JLakFTUE5zZHk3?=
 =?utf-8?Q?vYR6yYnF0faxHx+zTLHD7q+4T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948cf67b-c917-4302-e60a-08dc6b7a006c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 14:04:51.6538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X399xgIACUENu/q4Wdl2Eg63MSny3Qrld3oQ+bqnxOKc8uXbliYZICHikHiXFRJ6mpSa3jj1EG+8yEg/X2uSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7398

PiANCj4gQ2FuIHlvdSBleHBsYWluIHdoeSB5b3UgYXJlIGRvaW5nIHRoaXMgY2hhbmdlIGluIHRo
ZSBjb21taXQgbWVzc2FnZT8NCj4gSXMgdGhpcyBhIGZpeCBvciBqdXN0IGltcHJvdmVtZW50Pw0K
PiANCg0KVGhpcyBpcyBhIGZpeCBidXQgdGhlIGZpcnN0IHBhdGNoIG9mIHRoZSBzZXJpZXMgaXMg
YW4gaW1wcm92ZW1lbnQuIEJ1dCB0aGV5IGhhdmUNCmNvZGUgZGVwZW5kZW5jeSBzbyBJIGFtIHN1
Ym1pdHRpbmcgdGhlbSB0b2dldGhlciB0byBhdm9pZCB0aGUgaGFzc2xlDQoNCk1pbg0K

