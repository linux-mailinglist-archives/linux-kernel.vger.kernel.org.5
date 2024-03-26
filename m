Return-Path: <linux-kernel+bounces-118757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107088BEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B428F1C3D16B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC86BB37;
	Tue, 26 Mar 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="dgFttHht"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F55D8E1;
	Tue, 26 Mar 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447809; cv=fail; b=dw895jxV9E+0uH8w0bXjv3vsbuFCza7jIg2tV00k76C6AyC8mJlPA6zky/0SRasRPEE2FDai8WYtIvIrHJP1fd5WgvA6PtXQ1kmDPR8WZdY8R1GBu4O7EivxaGxkt2eBPI8SbwBITjnw5ujAp2My3nvyE5H2z7KRIi1vPCPR8BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447809; c=relaxed/simple;
	bh=CTWBHAhrqyv/X/uccd7/4+qxvw8EwFq1riL8qJoXX84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVghco4YL5+ap9EfnK+DQEjKnN+sDHkpwv+/CgK97UMslXoqnXyxfb73dabKIpmhZpvRJdc0iMSTH0ZEw0F6xJzOmB97glYBmjOyw9zT5UfTvCYVpQeqevbu3c08w3C4K2Fyxf6CF5qfK4/zzGo8Womg+3v7AuWrctkQJgnYi74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=dgFttHht; arc=fail smtp.client-ip=40.107.114.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPA4wPyvrLPRRNbb8oNtXCzP1xwwNZblRJK1p2iJtrj2vTLg7GRdsQNYtgH8E9uKo/I8ljPxcsspEQJkw+nPwfmfypWjKt/fJq1BR4WpTEshcYgtlZIUOAy3OvAgE/Bws0DtZxjgGb6OueVCzYmOAoszfNeucfLQ1kFYlSwzN3OkNUBGqLx9Mzy7ShMUO/lMym0YBMZRnHef0vIrPbFufBKjDLQOVVPRxhZYV7yMwfr4nUdot234GbjVkKnugwIJyMCOgode/uOnN2n370QNZYG9M8DFYFHMEOOYI/Cta+Uvl/tYGoDIanG/zN/KMG1HlAp4hjgfoARPWbUfSV4hqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTWBHAhrqyv/X/uccd7/4+qxvw8EwFq1riL8qJoXX84=;
 b=Y2hxLbtrdWjLYLu2jLa9ddb1qCAn1LtGdSYvrouQ5d6Qhl1xvfbA2rlfJcrHm595hM6EzVVcLec96jVXcaBwSbPamDqaXv3xqbnAxrLZaDpzjEagYbIuGxyhhpN0kMwAOHJj+CyCs03CH08kQKTMYpBbB0NurhqGffh2yWOCaqh8oc1DDCLd3MrjcccXU4OsGiJw1jqUo+bbx3LGcqf7AMzgLOxq1PXzOhQpszmWXc8VAHdXdypeUKNSwcv1VMcW5T6eS0UZ7ucoU5SXrxmmUAvCDqZxRYFZT+yZcxOwwQ3vu+zfrMi/aqqMnOaRNoR1YuoJM4xMGJ6MHmmobZHqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTWBHAhrqyv/X/uccd7/4+qxvw8EwFq1riL8qJoXX84=;
 b=dgFttHhtqdSOpV55SIweOSLc2VgUMfmuSCRyKI0vsp1sRKZ3ogqcWpMI5X1byZbeHqr8MQTkWxNeIfM1bqpDnfBLGiVvfxoq5/UwCG4D1tt1Y/6mDWrxjg6xznsNohS5UXsfIoIw9pspiQU0ABlI7QWLsEBWUIqaL4AQNGyB37NFafSbttBaB95FobECLSk1z8GpAhjMPjRZLbRuDHkGtUWZm0hHERjOchf+pGQNL43yKzkDf2tEWWTtft8tP4MA7AMRAX+GXrgnj3jf59kTGLdnwmA/piIDr2xNMrSa5G55Tja0/gw+qwMb4vUAx9IqQ6SFI5/phF5IIQY6CfrxoQ==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYWPR01MB8315.jpnprd01.prod.outlook.com
 (2603:1096:400:164::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 10:10:04 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:10:04 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "balbi@kernel.org" <balbi@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: f_ncm: Fix UAF ncm object at re-bind after
 usb ep transport error
Thread-Topic: [PATCH] usb: gadget: f_ncm: Fix UAF ncm object at re-bind after
 usb ep transport error
Thread-Index: AQHafphgEDyMjyT8lkm3ycYbhjiLR7FJxQQAgAAHitA=
Date: Tue, 26 Mar 2024 10:10:04 +0000
Message-ID:
 <TYVPR01MB107816428A6B1C75930F19C1790352@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240325094543.5362-1-Norihiko.Hama@alpsalpine.com>
 <2024032629-frolic-obtain-ad55@gregkh>
In-Reply-To: <2024032629-frolic-obtain-ad55@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|TYWPR01MB8315:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z170xTUru0YZeZfYHsKfki9Bl4i49wt7X9Tpr3eyhgJt8KM2cRo6FeghMRfBY3ix6dBvtso+/Jgp52PWIFDQ6bA4IiCZW8pbtu3SwK2SWxAVXyik2SUcDz+OKUG63l4EmFJQsU9DjVKrnaco4jbz1G8ABAKYKSDitktRDmzV/je8FiqJkSPb8sa9zzBnlB9E/ZmcfG2KwxkjgrzEWx85IOj+/d0xtOYWtBJIfV2bnQjVNWC9ja+c7FwiJo/XayucPNZqPKvcnNccDtLhJKeznNdnCG5IFOlgS5+3AHBSkvU6x8NJLHGBWfLDojYLmtW/JpzZhEWU/8mPT5yaHEdU/lOfjUzB3hDW0gL159ep5WuxppdZwfk2/rGrHDF8B/QoDSXXSIyJI/Xz+QvkCCQ8Ukq50xKoQzEppgfNNHT40cy4ggRHx/WLiPlV9bRRcYxORmpZB3wDaOPiBFOzysf2gNWscsvXOa19JsOhFinF/CmpRTf+YqJ1NIW8gH1V9OXcRKEdh+NZu0sU7Um+2udETX5xAxHQlMAqFTwmSb4pnq+JzcRtyYdK7D1FOv0yP4HgxxFV6y2To9cxbuwYKWdHtpcurMEVv+Za+lD7s37Dbp7T7FETF3XQ+5+rqAq9cxuktMNBQ38usSZQCP99a4BHuLWvEeXJNNIp/9K2fzwZxzs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?a1RNVFNSSXZ2c2xFY0pqR1N0RklySXMyakRLeko0Y2JEUEJsY0dXVFJYMndq?=
 =?utf-7?B?MDdBYUdXemtaZGZDRE1mNjFCa1pxYmY2T1gyUmhmKy1JOEhHKy1JSWxJSzV5?=
 =?utf-7?B?S21Bekd2SDFqZk9TYzVscEpCcDNqODBqNElBMllRcjZoOHJIS0FnYk9raFkz?=
 =?utf-7?B?OHBOVjhVeDlvVXE1YVd3UnR3SU9uS0x4THB1S2pWdTZsZEcxVGJVcU9xMUFD?=
 =?utf-7?B?TERpell3REkya3JMc3FCS3I4d2ZNN2IvanR6VDZWUnVIZldqNG5EVUxYNHNO?=
 =?utf-7?B?eTBxTGlvKy14NG5PZkZkLzRvclFSbXJ6T3NZZ01PVElHMi9kWGpDcmN0b0w2?=
 =?utf-7?B?cTJJeDFVMXh3aEs3UmhOUmdDSDRLRkJHRHNzRnM3d2JKREJmSjVxdWJXamN2?=
 =?utf-7?B?Y3Nld1AvTnNFU2g0M2VHcmFKckV6Qmd5bmdRRnNVbHQyNndtcVA2NUxkOG1m?=
 =?utf-7?B?c0oxSWQzNW9KWjBaMGZuS3Y2Z240OGFxaWhrZ0VBR3VhSXkxSU4xaWFsVkNP?=
 =?utf-7?B?YzZLREc0dHpEZlptMTUwRE5SYk14QWdZc01pcmtUR094cTNib1gzUzJPb1l6?=
 =?utf-7?B?cmJRM2YvRjFwL1dOKy1jVFpHbEdQdjBkVFBmTUdGTklraHU1QjNpaFpwdkJM?=
 =?utf-7?B?T2RRTVBpZjQrLTYrLWh1Skt1Qk5uRVo4Z0RpTzUxamg5V3lOVWdENll3WHRh?=
 =?utf-7?B?c3liSU54QWNmVGdTTVN3TmltMDBTOUhFNGROczNlU3BSTkhtYm85U2Fpengw?=
 =?utf-7?B?aTFaQXNBZlh6M3oxRnZLbWNwRSstVXpiL1JhNU5xUGxjemVwWExJTk4yMUxD?=
 =?utf-7?B?andyU0dsekF2dHlzdkZ6ajhaTGxjN1R1TmdzalNKLzRrT0grLUpSZ3FVeTRY?=
 =?utf-7?B?MGRVNG05OWNKWEFQemgyTnFFZVF4cXpJMlBQZW9jWUNhbW5HMlpmQWR1cHlm?=
 =?utf-7?B?aGM1UXdDR1BlbGtleFVNZ3dyZXFBbmMyMjAyRWtRdExxUmY4MDM2M2lNYmsx?=
 =?utf-7?B?Uzh2azZXVFMwT1g3U2lLOVZuTXJPTmVVSExwT2g2MGNic01VYktpYWpSdGtU?=
 =?utf-7?B?ZVA1T3hQU1JCOEhCS3A2Z0tMenUxeVkwb0FkNUtaZ1BuMnFFQlNreDNBVVFV?=
 =?utf-7?B?Y1ZXMistWUdvYlI2b2lZVlA4dmIrLWp6UVA5NGJuNUVmMWRvSnowSHladE5Z?=
 =?utf-7?B?b08yTWpmeWNSN1NQcmNVcFhob0FIZnZZaDRjNTlqUy9Cb0dFKy1xY3VQNVMz?=
 =?utf-7?B?QXpPeHM1QnFCa1lUWmZNSmdOc1pvM3pRd3k5VWNPWkZCbHZud1hpM08vKy1n?=
 =?utf-7?B?LzNSMmZVQ2hhTDZnUXB0VFo0WEFYc2MwR0ZiMXQ4R2Q5SWhUbistVUJvc0VW?=
 =?utf-7?B?WWZmN1ZvZnJMMERvYklHaXdmTE94cHlHUGVaUXllRjhkS3VjZ3JrbDA1a1BY?=
 =?utf-7?B?QTY1cDJhNFJWS3B1ZkMxODlUcHI5dEl2UlFKTG9XeDR4c3FvbG9MeFBzSlh0?=
 =?utf-7?B?M3hMMDFaVm1CU0t5OGlpdktKR0xmRGlsMWR2Y2NXZTMvM3dCOFVIOXFpbW9q?=
 =?utf-7?B?WHM4bUNTSVlPUTh1cW1LME5rTHZsTlplYlhkMkFyOFgvc2lTaUpxYjVFYng3?=
 =?utf-7?B?N3huR3NaUUo3cEJNZk1DWEVQQmVtR2FtOXdFbktoSE00M29LSVh5MjFEc3ZO?=
 =?utf-7?B?cDNxWXhLMU1seVBXcGhGcWVNRkl4b1RyNXR1dXc4aUpXT2IzN0RWRzg3TGs3?=
 =?utf-7?B?WFlLWDFVWlNTSklza0RRaVVsRy9VYTVNdDMveHU4eU9XOGRJQmF6QU5FKy1J?=
 =?utf-7?B?U0VOWXhNS3VvNWNFeWpnU3FwV1Q1cnpadEVZV2FUYmpXUEREc2FJalpPY1dJ?=
 =?utf-7?B?R1ZFN09SeVdQZmpxLzl0ZWJONUpuNS9WSVZabEJNMFZmMng5eFFWNVlvWnhZ?=
 =?utf-7?B?eDhUbTQ4RTJ4dFlCTUFBVGcwYm1EZUdCRmpCbEE1WkR3YTZveUZIcHpId3Fa?=
 =?utf-7?B?T0pGbDlFUWlRZkJVd2Zwd3FjVzM4Ti9NcUEyMmZmRGJ3Q0dJSGVQeVJoVGkw?=
 =?utf-7?B?cHZLODdNQTRMZE9UN1ZFVUhOL1lKYXQrLThMSEU5VXBXeG1yOXpRZzNaRW9W?=
 =?utf-7?B?MGRycjFRZ2FJVDZKclhOQWd6dTR0cXdKdFR3SWdoUnIzcElNNi8vWA==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931697bc-7969-4bde-cc72-08dc4d7ce81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:10:04.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rctZYhe6cUNWhiAwJ4LOOuk5t65BmlRAkRre6G5Rl5iAWtbzoKHrq2GJFAgTrzcRzxuoBAb2euYtg8J1XMCXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8315

+AD4- What commit id does this change fix?
I'm not sure.
I think that it's potential issue for long time.

Regards
Norihiko Hama

