Return-Path: <linux-kernel+bounces-81843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A9867ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ACA1F2A962
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38E12DD92;
	Mon, 26 Feb 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uVEiPpr+"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2083.outbound.protection.outlook.com [40.92.98.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83935129A64;
	Mon, 26 Feb 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962703; cv=fail; b=ewJg7gLtbTPAM6C1EnuILNPK0blINundXEcZz6o+zMT66G8X2FH94kkbMnE8IKMHucFtCctNYbEikBTtWttbyeUP5vCTxmQPC1kmwi+1pzh+xMtrNEGpMg+Co+b7I8BpjBYzu6ZS3k04ATg8EtidwEDuoz0DGR/NT+wf1XGHMs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962703; c=relaxed/simple;
	bh=w0FWAIoyiT5LS6u7ggg8CPjbcg+BXqRNQzSJqJ2RWuU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GiWY+qHTv2Dvbvdh+dp00dKhfUjITBvVmyJvSUKAJf5GQEt5SL1nr+neANQekJvQdvEtLmV38bzLpcSTndiwIoQmwUEHt6C1GcmBm4V9Nx3FM+EgLU63wdRNOkbhwq61QprtH4EhurGiW92lh9aoDg2cuoL0UxIJNjBWGjoq0Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uVEiPpr+; arc=fail smtp.client-ip=40.92.98.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5uOrYlu5JM26vnZz4QBaNPpXCpzzS1fkaqj0BXsIug/QIIlrPJD36dffe0ZNDNBJBP9HHOCZQ8woKoH4vFCCAQbrbQNXvKjXRHB58rE7NEYjQgtV+I5MSytI/mzOoPHQYHv/1tlyYfkfBpeiZNDbszbTHdVgv/bArw/NzFM/PFim3uVzYCag0i2SmiDtXm1huSmCZbb+H6wVd6j2Eo/VWzL4ZeGfdRzDOyEynZ317LmqtKrR1Wa7u9oRCpqSU5o4UlHz6zoZfwb/Gb6mTgFRuCqDzpuARtm1OLJ2TD52+WUVoJWAs7nXfPqdTxO4UmUuI38q2kbV5sTlXrYwGX0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0FWAIoyiT5LS6u7ggg8CPjbcg+BXqRNQzSJqJ2RWuU=;
 b=Jqm9kdSgphZiQHJyH6GT5MjQbKhI4Gsx3o29bOga3wVqb4aaLlGqtuk3GGrZqUnyy5Zjqn7c/y7kZcxzKcmCFs74zjAfUP4dyC+gFVnLJU2+bbpEut1XqxHmFp3wbwPu+jOH+wBG+e0nXHswtvLxSrktQ+z/lJ6cdCXKE5shgGrLjCPOYqxya9U6cP6gK313itZ/XGvttlf4/7TMEFnvtaku3HDI4PGmxSvnQeoT9pZlXTZPdRfIfw0xZFfgrrRRtwdGCJQ0lS1Syd3c6b+1HXJjummyFRsqe/zZYvKDDquHXjPA+RZonqtEQZ0QdIpbHOAHgDIyJCD3y0ntJdb/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0FWAIoyiT5LS6u7ggg8CPjbcg+BXqRNQzSJqJ2RWuU=;
 b=uVEiPpr+A0HECz2IyI65GFX/gZoYQzu5m13NBHZBK/zP3Y+XBcbBR56+HtWKs2jhNzZi7fir3nfAyqrGU+xvWq5Mqlx+TbVBRYW0UUn77haiT8IE57eQ6gNON7s91Gqwa5N9LQWuy7wugkA3o12UjfVwS91tckChOIGC80zBUsErA+8Yoose8syhlY1UHcODE1wJ1iHbpjJ0d2hN342W7R2ZLdJG1Qi108r9Cb2fS+WHpPLgbUDeIsXK+DdYM2sGPS63DPXKYF/QSXggajnnVexH0ry1YR1z4CewdkRmGiEpXICQcMmvAXje6Oi4nPAYwzaUg8lGCaX+X6J6mEb10Q==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY1P286MB3346.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Mon, 26 Feb
 2024 15:51:37 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:51:37 +0000
Message-ID:
 <TY3P286MB26116BCE9B5E5E34D7363F90985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Mon, 26 Feb 2024 23:51:35 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PDjzV3ZYfOp0ElcD2w0fcCgk"
X-TMN: [7l792aZigN8ThgKdcxmj/8SECfWeYIAblfOoDUoSL6wySJxrpY76/8ZGM3zBpn/7]
X-ClientProxiedBy: PUZP153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::15) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <a348a533-afbe-4c9f-9552-e5abc9769f04@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY1P286MB3346:EE_
X-MS-Office365-Filtering-Correlation-Id: a05275a4-453b-4b2a-0dd5-08dc36e2d0f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cUOrjmArErxibygvlejMcfwnWZrDU5UdBj2ezJnu7VwPtLdFqt/rI/He1sb2hIjiOWj+rgO0gEhucOIRBAjWhR1E8c9H0PX7MYuldlzTgh/lUlB/RVhpe1Pd2qBdZjZU4CgUE82tvMy9FizwJiFR7d4i95ra2nVBtcxafkvjqlcjFJIkoEfxCATgMP8AlHBz10lHvMQyYv3KUs1Tl4jgJGtlzsdby8pn7uDCYbiJfYk/76xX6vWaQT/QzFI1tgcTamtGxtV6BLNHqhb8DFR5Q0c+9jpQEnVN5ORm/7pJdU0oEprOsoIfzGoN+dsaLVWMDcYE2BHHHBGK7gN4N8bosnIIwWlkAFeDpv5YSw0zAmE4h1GZYyx36sAuwnMTcmAY/tqnCOL8TRHpKWqIti7r2tEdQYFmjAcykjmx+Bu/kQASQ4HRB929NcrN/dd4yWkEtJEmv761NL/MSpTLRWcVSYJpPKNUk08hjBHoxJuEBuxV34ycG3J+PWoewaE1JVEYycR+HbihdOsO0o6k0AW/VLRqRakFApcNi7MIGXqjpEUngDFZCJfoo//J+8JPgUR4EVFjCdyPAlB2W9UdDPQRiEGwg6rlw+grXaXQ40xp2FnaBlhK4X9Hg91g5DTfgH0jgZikdCRRZ2FZQmdD73WlHQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTZPM0Z2RGUyV2ZUcWVudkJvUkdiVHI5LzlKU3FNRU9UMEVNc0ZQUU9wb2JU?=
 =?utf-8?B?c3poUDBJWnNmZXhzVEUxUEdVbVBaVzJCYyt4NzdXUEVNMlI0S0VsL21GVmZp?=
 =?utf-8?B?SEtId1hHZjJrUis1dG5VVUtTOG10RS9yNmhyNW9pVTZ2aVNpS3RuaThjZUsz?=
 =?utf-8?B?TmkzMGc1TWdMbEM3RjE5TDFBWlFZVGRSZ2xDUDRYN1FpUmdqN3R2bjc5Mk5I?=
 =?utf-8?B?Y0IyT3lIVkxVT3dNWkVabXFEaWt2YkRmY054MnBnZFhpSG9EblNMQ2h2dUxI?=
 =?utf-8?B?UU51dlhUQTQxUTVFNTB0TTQ1MnlXWlp6TVhsWDFKYmN1eEpPZDNicW1FSVQz?=
 =?utf-8?B?WXgvL0NKeW00TXd4REZLcU8yRWJjMFFYMjNZaFYzZytIc0dYTmM4b0lDbFZU?=
 =?utf-8?B?dEtyU0JOVHZuek5KZ2UvcG91VHcwZEYyREJBZ3FkQTBoWldKQVcybFQzWFpQ?=
 =?utf-8?B?Q285UzZQSklyMU4vMHJrbE9kM3lNMGxCWHVwckRpUGtTZkNTdUJ1bzFQM2oz?=
 =?utf-8?B?VXpKYW5uWEFZQ3FNa0o3cEtMVmtrYXpHeFY3L2laUWxoaEpZVTNuZ2ovTFJI?=
 =?utf-8?B?bTJEbmk5Q21hclFPM3krcFpTcFZIMWZVUWJrYmJwa01QWE1jeGlPSWdxM0dj?=
 =?utf-8?B?ejRzdWp6cnBBMUVKM1JVa2krUytwbFJEdTRjcFhpakJncEJOWlV0OElRNk40?=
 =?utf-8?B?M0tIdGVvSjc1RWZZeUpOSVl2WEVYZnhqYkxTM0VSRHhJRTEya0pnQW4yV2o0?=
 =?utf-8?B?dk5FUVpSeXlpTXpFRmxXdHRkRENKdnNqMlpHQ2VSQmhQWTF6SlJpRk1mV3pS?=
 =?utf-8?B?dWhIQnljQlpXSSt3ak81TzdSZzBkZ0tHUEc1T1lBcjZCUW5waktaTWdMemVF?=
 =?utf-8?B?M2xxMVkweXdyOXhSeXRkQ0JRUWsxT0NLWmZLR2g0T1cvU3k2V29mYVVCMko3?=
 =?utf-8?B?OHl1OGFVdVNoZ0RGdXRDL1NEYk5MZEJrZnJZdWJPR0dBa2VrMWo5QWZVRWxL?=
 =?utf-8?B?ZDRrN0FFVitpUXdLZUY5ckQvOHBBbjd4Q3NjSHVmS0p4MldBeG9mMzdicVZr?=
 =?utf-8?B?M0d6cGFZaVlSN2dVYmRrOGhaS3ZRTmxWdlRKUkg4RFk3dzhoK2twSEhUZWVq?=
 =?utf-8?B?cWM1RjU3R0RkcmVxNUhvbjZOekhTQnpBakhaR3cxNisvNkQ2Q3djWUhhbnFR?=
 =?utf-8?B?Z2U0bkV4TFdBT0ExZHFCRUFpN1RDVzYvTWc3dFpsMnFON01ZeUZWSnZXNVl6?=
 =?utf-8?B?SFI0K2hTKzVNTWdoR2JBbHorcEZ6SUtwOFRydDFHTXdEa0lWMEJNNk1SUDA2?=
 =?utf-8?B?WGw4a0F6VHhyckkyc2lTWjJWcUFYSTcxWXVqUFNJZ2Jxdm5icW9iaU82UG1Q?=
 =?utf-8?B?aU1FL1JuRDBmNVEvdmdCM3RmNkdHSk5JR2dmMy9zbER4SHZNNHU1eEUrOGZB?=
 =?utf-8?B?eUVSWU5PYW5jQWRmY2RwS2JYMHJPSXhxQ2dybjExZUhnbzZHdGFDbFlqRCtQ?=
 =?utf-8?B?N09qVHZUdzJ6TVlOQnVISTAwVTM0QUtEbzJEalAxRlpLdi8rVTJUZWxFOUJC?=
 =?utf-8?B?N2twcURlQ1NJR29DbzA4WHo2clBBbG9GRUhiQVpZUnBNY2pXV2tZVmNXbFQ0?=
 =?utf-8?B?WHFqc0RzOUREaWM2bVgxSHhaTzZITmhvZW9YcjRITWlwbzVtZWVHV3djSW1X?=
 =?utf-8?B?a0gxYlNnbDUvT2ZaU3VpbkIxUkkxRVNZRS9tMjN1dHRJUER6WVkwMlVPNjdw?=
 =?utf-8?Q?Catmn2Bik8xP3J5orI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05275a4-453b-4b2a-0dd5-08dc36e2d0f8
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:51:37.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3346

--------------PDjzV3ZYfOp0ElcD2w0fcCgk
Content-Type: multipart/mixed; boundary="------------fJRueZ06DjoF0sXQI0wr0Yzk";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <a348a533-afbe-4c9f-9552-e5abc9769f04@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
In-Reply-To: <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>

--------------fJRueZ06DjoF0sXQI0wr0Yzk
Content-Type: multipart/mixed; boundary="------------0bzW2ey5O0NBtAbKDUJHEvmQ"

--------------0bzW2ey5O0NBtAbKDUJHEvmQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUnVzc2VsbCwNCg0KU2FkbHkgSSBkb24ndCBoYXZlIG1vcmUgaW5mb3JtYXRpb24uIEkg
dGhpbmsgd2UgY291bGQgb25seSBnZXQgdGhhdCBmcm9tDQpSZWFsdGVrIGd1eXMoVGhpcyBz
dGljayBpcyB1c2luZyBSVEw5NjAxRCkuIFdoYXQgd2UgY2FuIGdldCBub3cgaXMgYWxsDQpp
bnNpZGUgdGhhdCBnaXRodWIgcmVwby4gUmVhbHRlayBkaWRuJ3QgcmVsZWFzZSBTREsgc291
cmNlIGNvZGUgdG8NCnB1YmxpYyBmb3IgdGhpcyBjaGlwLiA6KA0KDQpCZXN0IHJlZ2FyZHMs
DQpTaGVuZ3l1DQoNCuWcqCAyMDI0LzIvMjYgMjM6NDIsIFJ1c3NlbGwgS2luZyAoT3JhY2xl
KSDlhpnpgZM6DQo+IE9uIE1vbiwgRmViIDI2LCAyMDI0IGF0IDEwOjUxOjM2UE0gKzA4MDAs
IFNoZW5neXUgUXUgd3JvdGU6DQo+PiBIaSBSdXNzZWxsLA0KPj4NCj4+IOWcqCAyMDI0LzIv
MjYgMjI6MzksIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSDlhpnpgZM6DQo+Pj4gT24gTW9uLCBG
ZWIgMjYsIDIwMjQgYXQgMTA6MTY6NDZQTSArMDgwMCwgU2hlbmd5dSBRdSB3cm90ZToNCj4+
Pj4gSGkgUnVzc2VsbCwNCj4+Pj4NCj4+Pj4+IE9uIE1vbiwgRmViIDI2LCAyMDI0IGF0IDA5
OjIzOjQ2UE0gKzA4MDAsIFNoZW5neXUgUXUgd3JvdGU6DQo+Pj4+Pj4gT0RJIERGUC0zNFgt
MkMyIGlzIGNhcGFibGUgb2YgMjUwMGJhc2UtWCwgYnV0IGluY29ycmVjdGx5IHJlcG9ydCBp
dHMNCj4+Pj4+PiBjYXBhYmlsaXRpZXMgaW4gdGhlIEVFUFJPTS4NCj4+Pj4+PiBTbyB1c2Ug
c2ZwX3F1aXJrXzI1MDBiYXNleCBmb3IgdGhpcyBtb2R1bGUgdG8gYWxsb3cgMjUwMEJhc2Ut
WCBtb2RlLg0KPj4+Pj4gVGhpcyB3YXMgcHJldmlvdXNseSBzdWJtaXR0ZWQgYnkgU2VyZ2lv
IFBhbHVtYm8sIGFuZCBjb21lcyBpbiB0d28NCj4+Pj4+IGRpZmZlcmVudCBmb3JtcyAtIGFu
IE9FTSB2ZXJzaW9uIGFuZCBub24tT0VNLiBUaGVyZSB3YXMgZXh0ZW5zaXZlDQo+Pj4+PiBk
aXNjdXNzaW9uIGFib3V0IHRoaXMsIGFuZCB0aGUgcmVzdWx0IGlzIHRoYXQgSSdtIG5vdCBh
Y2NlcHRpbmcgdGhpcw0KPj4+Pj4gcXVpcmsgZm9yIHRoaXMgbW9kdWxlLg0KPj4+Pj4NCj4+
Pj4+IFRoZSByZWFzb24gaXMgdGhhdCB0aGUgbW9kdWxlIF9kZWZhdWx0c18gdG8gMTAwMGJh
c2UtWCBhbmQgcmVxdWlyZXMNCj4+Pj4+IG1hbnVhbCByZWNvbmZpZ3VyYXRpb24gYnkgdGhl
IHVzZXIgdG8gb3BlcmF0ZSBhdCAyNTAwYmFzZS1YLg0KPj4+Pj4gVW5mb3J0dW5hdGVseSwg
dGhlcmUgaXMgbm8gd2F5IGZvciB0aGUga2VybmVsIHRvIGtub3cgd2hldGhlciB0aGF0DQo+
Pj4+PiByZWNvbmZpZ3VyYXRpb24gaGFzIG9jY3VycmVkLg0KPj4+PiBObywgSW4gdGhlIGZp
cm13YXJlIG9mIHRoaXMgc3RpY2ssIHRoZSBzcGVlZCByYXRlIGlzIGNvbmZpZ3VyZWQgdG8g
YXV0bw0KPj4+PiBuZWdvdGlhdGlvbiByYXRoZXIgdGhhbiBmaXhlZCAxMDAwYmFzZS1YLg0K
Pj4+DQo+Pj4gSG93IGRvZXMgdGhpcyAiYXV0byBuZWdvdGlhdGlvbiIgd29yaz8NCj4+Pg0K
Pj4+IEkgbWVhbiAqZXhhY3RseSogaG93IGRvZXMgaXQgd29yaz8gSG93IGRvZXMgaXQga25v
dyB3aGV0aGVyIHRoZSBob3N0IGlzDQo+Pj4gb3BlcmF0aW5nIGF0IDEwMDBiYXNlLVggb3Ig
MjUwMGJhc2UtWD8NCj4+Pg0KPj4+IFRoZXJlIGlzICpubyogaW5iYW5kIHByb3RvY29sIHRv
IGFsbG93IHRoaXMgdG8gYmUgbmVnb3RpYXRlZC4NCj4+Pg0KPj4gV2VsbCwgdGhhdCBzZWVt
cyBzb21lIGtpbmQgd2VpcmQgdHJpY2sgaW1wbGVtZW50ZWQgaW4gdGhhdCBjaGlwJ3MgU0RL
IChtYXliZQ0KPj4gaGFyZHdhcmU/KS4gSXQgd291bGQgYXV0b21hdGljYWxseSBkZXRlY3Qg
dGhlIHNwZWVkIHJhdGUgdGhhdCBob3N0IHVzZXMgYW5kDQo+PiBzd2l0Y2ggdG8gdGhhdCBy
YXRlLiBUaGUgc3lzdGVtIGxvZyBvZiB0aGUgc3RpY2sgc2hvd3MgdGhhdC4NCj4gDQo+IFRo
aXMgc291bmRzIHJhY3kgLSBiZXR3ZWVuIHRoZSBTRlAgZGV0ZWN0aW5nIHRoZSBzcGVlZCBv
ZiB0aGUgaG9zdCBhbmQNCj4gdGhlIGtlcm5lbCBjb2RlIHJlY29uZmlndXJpbmcgdGhlIGlu
dGVyZmFjZS4gTW9yZSBkZXRhaWxzIHBsZWFzZS4uLg0KPiANCg==
--------------0bzW2ey5O0NBtAbKDUJHEvmQ
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------0bzW2ey5O0NBtAbKDUJHEvmQ--

--------------fJRueZ06DjoF0sXQI0wr0Yzk--

--------------PDjzV3ZYfOp0ElcD2w0fcCgk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXcs4cFAwAAAAAACgkQX75KBAfJsRl9
JQ//WxTi84ClW7dGAsf+Bz35y0PedT0NQhbmP7LQCgjl8koY79ZbOTSun6Nht7L0VEh6qd/pM5Bn
z7X6JAnhtJTykfVROnh+d/tQAXlJVl3TbZDJENc5ON9BB2+iDKC/lFwrTmTX8EOiy8otqfHKRrWG
ByZ4eovg4JtB7OZdDIiQdLtNEgEVl8PmC9fvzJOzY4fLTH4bCkSScl/umRrFJGOYB0C/1bKiGmrT
TXtkzA3IlWtv+NNdCdsTrX2iwrIZ3/C34uABGJAdu1SjVXShRW+E/meX/KbpjIdy2U2r7iX/+Mwn
8rjCAkvq0GkJrB5/d9TvF0lOK4Yw1X5YkBmkhhmdiH0MRTd5VA+xvcD5tnLziiik2zAyJ4Ty+jr0
Y56hJm2pCFDp8yrDx+90o8UtZZtdCTc2IqVCpMcrWCZsdWUbnbZne9EKE5l/qrPf0PAKCeo1Gwqp
bNZtPRJ+w7/BsmDTNgP0pJCriWmxsmFpKtfTDwc6RF7ckxoUmhGOXjG1rgv6QbKQeUmbwLY7Nxos
8zEZD0y4QZi8IjOti6ypLT4+ncI/sWxpltFVcLzbiNCCX89mGKijPIE2X2I+I7rTs7j2m0r11qeA
ecVz9Be1S4wWAi+ID4fL/2jdYhd3kcVUCTrMc5B+BXNAgqR1sxAEA3wmhGFlFPMF89ENk6XeRdBR
Bwo=
=W2Ox
-----END PGP SIGNATURE-----

--------------PDjzV3ZYfOp0ElcD2w0fcCgk--

