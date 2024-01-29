Return-Path: <linux-kernel+bounces-43002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38668409EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B63283377
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142D153BCD;
	Mon, 29 Jan 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ZngYdp9m"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2123.outbound.protection.outlook.com [40.107.20.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858A153BC7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542177; cv=fail; b=L4UCY9apNYeuIgbprVvTWNmxWT3v44DruuyUriFFLY8uJtpVEN00fr7F6RJQnFjREULE0VsVbshOksYcQh7VOvxMfbbx9k54L3bDaRbpyMRrb6D2IQkfmZsoNtfY3QPgK05zPj3Q7ehUrUVKEaGxlcMnqhYkuAci4hEUR4QznBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542177; c=relaxed/simple;
	bh=zWar1Xl8eD3e+tQ6B8u5GgKSFcs9MXdPRN1Fr2EpVjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SU568BHYrGIQFpSsx7nWsI92qlImuCEYqwdKtIc1WkISlAM3hm0SSQywgLzdKu3Vlu0tfmhvlM4rTRLhG2AZFVEaSPq6y4M6kWZc6YdashMl5DxSB5Xbrd2d2+PEJRaJwVvcAYcvRH3E0d+eP8v9MHZGV/J2/CMINc9LNq1a0fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ZngYdp9m; arc=fail smtp.client-ip=40.107.20.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf+9+kkXSe5O7HeHLUmxvZ4SfdGOJibGMN5TbYsTt8ZRYiJr2NGZAAqmWBMXyvPe7R0nsPyOtSeBVyfneoBMh8dvk7/4pe48n+M1dn9BFLXdxMKZSGmzuUNMNP6QSJ907Is5C9lwalHxCc1Qb2Y3RUNL+3GzV93J0hLWzgUYKPXPblzsk579Js8B+0kuPN6C5q6bO+DI3BFHFmD38+58jEM07bA3mtmtq1t9bD1OKoN7QwUotVjaHVNNR1hAOykhLpyG5xbtWa+Uy85ljVyPXpwnA3IC1Dj7LgGaTP7tcGgAmZoPtlPpdiJ6S5dK3CfGBjAvDuL1P7IDKvWryWEptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWar1Xl8eD3e+tQ6B8u5GgKSFcs9MXdPRN1Fr2EpVjY=;
 b=kRK78tl46EYriNw4/Cyq/cZTf/jt/rp6tO/aDjyZ8gJJ4XNb8ww7c5M9fLAETcBDImwIaickVwZgdk9M8E2fdZbcM7sPp8hz+dfp+CsYfTvNEBvlq9TKE/BJ2UxmABEXdzT7o2vDYNatZeJUanLsg/D/vSwQEPndn6AgGMejv0B6nRIzb56289mpurqIlJbrdpvbBo9Qav76aKy4LoFi8GXZ3gHkTuS5yfylo5PvT6RHKPzGd8SKPNp4EQ3T+Mz8+0qQXCtXjg/y/YJdKxsIg7aul5ByRdSm4E31PRYfwUtI1HeO+VrGqPSTayCcIyhD+AJoIUwOyLwMBcN94bcEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWar1Xl8eD3e+tQ6B8u5GgKSFcs9MXdPRN1Fr2EpVjY=;
 b=ZngYdp9mBtGPuQeuKcQWz0460ZIKYaQCzsDkgOJokT9iKWGvYQSW0smUUwiT9+SHhsEv/UDEkYyp5WK7PPttCnG07hWnFLgpyGpS9gxoHPRzfB9TGfvajCliyhFz5NmY4O0yKGxac1C24TOY5RUx44LYmovSwwJBhJvrszvJRtc=
Received: from VI1PR06MB4718.eurprd06.prod.outlook.com (2603:10a6:803:9d::17)
 by DB9PR06MB7532.eurprd06.prod.outlook.com (2603:10a6:10:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:29:32 +0000
Received: from VI1PR06MB4718.eurprd06.prod.outlook.com
 ([fe80::a6b:2ac7:18ea:da79]) by VI1PR06MB4718.eurprd06.prod.outlook.com
 ([fe80::a6b:2ac7:18ea:da79%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:29:32 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"michael@walle.cc" <michael@walle.cc>, "rafal@milecki.pl" <rafal@milecki.pl>,
	"robh@kernel.org" <robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "luca.ceresoli@bootlin.com"
	<luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] nvmem: core: add fixed-layout declaration
Thread-Topic: [PATCH] nvmem: core: add fixed-layout declaration
Thread-Index: AQHaRKLpuPal+PJOaUi+148Gx257JbDUwBaAgBxGjIA=
Date: Mon, 29 Jan 2024 15:29:31 +0000
Message-ID: <d568b3e2-0305-4041-9f6a-8375b5c497b2@leica-geosystems.com>
References: <20240111152849.3649549-1-catalin.popescu@leica-geosystems.com>
 <20240111164145.39255eac@xps-13>
In-Reply-To: <20240111164145.39255eac@xps-13>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR06MB4718:EE_|DB9PR06MB7532:EE_
x-ms-office365-filtering-correlation-id: fe5616e1-0718-43f1-338f-08dc20df1704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yRecUkKExrp/q2uMSu3pgLWujFV9e7eBWalJxZclnvEUei6buQ34Z6XdnnNA/6JbqFe1fUOTd0ZTLw/eRL+ocMAOFUo0aUIzEHsHtMJ+1mkjFcyf3mo3E7jCbyiulOKLY0IKzymBqu0Ec/HbNBkANezMEfd0Ncvg4ft7WUrmhnh7CHkFtKQgKBuKxa5Dkw3aNChWAn8X5auxmwqjpYZAUacxkIt10oxtexDfViS09Hv29LVHgjwLAPV3akIdlfqKa6qpK2Spxo7xEZjt7aMdl+GM5zfs2iu1a9rg3tW07H+bSGd00o9QPdDXagiKNK9G7yKtE41Vzmu//Ss2qvch2tZuGsUYJFug1BgKfbv7Bkkd+Lg1i4Dg9B/9/jt98H9ZG1Wf83hZKXFhJ6OBF8v8pSvi+cifrBmaVO1dloqdDHru76iF17yjQc7usYZV550RYJKX64AMWTbn8d/e0X7koO3pR592unvtHphDBxMFQ/a7oDEJwHWbI5lHqo431ZQCIfmsFdVRuM6eAQP19JeC/9kQaWfzaKjoZDuWUI4JsIOfd6OkRNwGjLX4n2E+nIzDt0RfP3V7xF1Yf1f1x1s2EdltbmQVS7a287DzlKLTa63oMQ2jQLl1kD0lETh36mCX2Is24zL0gZ7hIkq4e65VQVtb5qJ0MyjuIMuWYl73DPpr9J81IAw5iQ1fF9ivsotG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB4718.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(2616005)(41300700001)(66574015)(31686004)(26005)(6916009)(66446008)(966005)(316002)(38070700009)(64756008)(54906003)(36756003)(6512007)(478600001)(71200400001)(6506007)(53546011)(45080400002)(83380400001)(6486002)(38100700002)(122000001)(66476007)(66556008)(5660300002)(31696002)(91956017)(76116006)(66946007)(86362001)(2906002)(8936002)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0F5SHYyMnNHdkhudkZ1VEs5V2o4dGUvbk1IT3VtaFB5d1ZiODExTDNyUXA3?=
 =?utf-8?B?a2NRQUtnQkIyaDF6L25Sci9mNDAxeDd1UDZabnZZQjdrb2hiT3RkaDlMREhV?=
 =?utf-8?B?M2FYVzVoN05wUmRtRUNBNFYwQlNlRTRRdFdSWFZVVW5FS0lob2tzbVAwaG1Q?=
 =?utf-8?B?RUNlY0R2bXNsd2lSWU5NcDJxOHpKM0hLa0NFVmFMTm1UNVllUDFwMmx4WFZw?=
 =?utf-8?B?dkROdm1xZGNUR0NHc1FBK2s5Nk9Wak1LaTRmVkptcDQ4cS9VeXhCVUpyYlIv?=
 =?utf-8?B?S0RMU2JmZWtrQnU5aEpWSUp3MnhvcUZGU1hJcVBScmZTNEx1RnBsRUw1SXpa?=
 =?utf-8?B?Mzl2cW1FV3k3UnRNQmJvaWpEbkw2dXloOXJVcVhISUtBb29ZWlFicEpUWWZw?=
 =?utf-8?B?Rk10Nm96VkR4ZVVuQ3FXZDQ4NDBubEpFQkNqRzl3N2dxek55RzJPaDR1U0NT?=
 =?utf-8?B?WDc0UFpkQk1TNUVqY1JDNEZ0dzZnenh0TEptR2tKWmlOL1ZEdFBvNTlOQzdU?=
 =?utf-8?B?NCt5MVFjdUlSWlE1d0VSaURmSUJHRnlEUG12UDlvcFRIWmpORXNOa081SERC?=
 =?utf-8?B?c09uMnN0dFEvblo3NXNpNGhkQlczMFZ2YzRlYkY3em8yWE9WWG9PWGRFaTVm?=
 =?utf-8?B?OWtjZC9GT2J2cWhTaTZ6enYxcGo0d0ZyalBHUTFKTk85aS9ZY3c2TnhNRTRJ?=
 =?utf-8?B?cU1qMk9oczNKNmZMMVQrcUtzU2dBSnltVjdRZjYxSVBpSE1sNnp0bzZnYVlO?=
 =?utf-8?B?cnNnWC9tdEx3ck1TYXk3YXEyYlkyelRncUI5Y1Awcy9nQ0o0K1V3Y2lzclNZ?=
 =?utf-8?B?eWh0UUJTRTRtUStvSmoyUnFhVWhIK0NBTlJvYldpM3RFekpmNE9rc2dnRnFh?=
 =?utf-8?B?SUNFL1BkZWRHNnJiSjJObVZNNWtlUk82RmZUbDJiTTZ4K1pMVWhjK1lnNjYv?=
 =?utf-8?B?QjhTckxNbHVHT1ZVUDFrMHovUGlMRUw1V3ByRFdkN0NMQ2dKL3VmQXp2ZzBn?=
 =?utf-8?B?ZXF5MS9pVWZlWkVLNWdLbUtSMTBrTUdkUmlOakZlaW9kblluUzlRNjhyZ2F3?=
 =?utf-8?B?VktEMmZvYm0wMXozT3NWNXRUaG5NZG5rT1VLT1czckg2dUpzeThYeE5VWDAz?=
 =?utf-8?B?NmR6YmlIR1orbVpOOUFqWWdoMHhla3c4dm9ybVJ2YnpXRmVTZW85bGZUQThI?=
 =?utf-8?B?R1JHUGVGMDEwMElpbGJSWWhHZTlrMkY2NEl5OHp4b1J1Wm0yMHo1NFphOWV3?=
 =?utf-8?B?dzZERXBQMnFnUnlSbTFkT1RFTm16VVNTRitKcDVFam1LWVJIbHBzVXNHY0hk?=
 =?utf-8?B?cGNHY1U5NWRWSlNFSE5LUHdNQ0tteUJSQmIwUG1EKytOdzN6RjZDbEJUclBm?=
 =?utf-8?B?RjNSaFZNZ0VRTWMzRTBXMEU2ZTFmMlNRNjNSUTJMUlFVNlNtaWVSWUtCa1Ju?=
 =?utf-8?B?SjVFVDdPRk5UMmprR3BtNkpHSjJtUDNWN0U1QWJZUGNDTTRjK3Y2QS8zZjJZ?=
 =?utf-8?B?MEsvQ25mTEw1NW01LzJBRmdPaW0wSXdDNnVvd2REbnZPY0tvRmVCL0p0ejhm?=
 =?utf-8?B?bmFNc2x5bE83RVRNdkUzUlArbFNQWXQvazFxcXYwZGI4YlViZHZtV1ZGWkxv?=
 =?utf-8?B?OUlSN1VHRU12U01EN2FIK3hiOFRoU01rdHBCa2tHSmhaOW5JMVpPVDRyZmI5?=
 =?utf-8?B?SXBtMkt1bkR0alpBR2NpQm1GNzg1ZmJrYVhic1NGOU5PRW5hM1FDd0J1TXdJ?=
 =?utf-8?B?WHJGZ3d3VHRNcEpnc0RZNGdmclMvSTdXQzIrVUpNTExUMmxKdExEdU01dldR?=
 =?utf-8?B?Z1gxcFdwbWJWL0JpanpBOGxJdHdzM2k5VCtWSUQ3bjVpMzJmWm1UWjFwQVZq?=
 =?utf-8?B?WUtpaU1RSUNKZ2pwN2FhUmZhY1E5K0wrY2wxdmJhN25QSVk4bEovNFo4NFZj?=
 =?utf-8?B?SEJQVTdQNDFNdVF0VWFRZ1gxR2F5dHhOUnJGQnZ3QzNicW00a2N3bUpNMmsr?=
 =?utf-8?B?d2I1SVRIN1MwNjVUMEE1NFBmWkIybnFiSHVrNmp1RVZrRUlIUUdWdFZFRkZp?=
 =?utf-8?B?clJTOG5mVDZ3c2VmRWl5dXJPcTF1cStJN3F5bXNOYU9ycU1IZXJIbmxOT2xn?=
 =?utf-8?B?dE1CaCtYcGlSRkltem44enIyRnN1R2ovNUNXYkl2NWlsMTBXRmVuc29QbXZh?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A97DD85891B8BE49AB65DDF795A64893@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB4718.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5616e1-0718-43f1-338f-08dc20df1704
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 15:29:31.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVzUuabgW5cAby8VpKQZrR1Y/iJpMVALp8rZDd8RsHPh6nly7ABvffZvB3uzCCl398YtRd+2kwDevJuJvIN9bGSlB/qOcMqfq3KApDULmi3Iy5ZL1a//tpHTg4lJfUnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7532

SGkgTWlxdWVsLA0KDQpOb3csIHRoYXQgInNwZWNpZmljIiBsYXlvdXRzIGFyZSBjb25zaWRlcmVk
IGxpa2UgZHJpdmVycyBhbmQgcmVseSBvbiANCk5WTUVNX0xBWU9VVFMgdG8gcG9wdWxhdGUgdGhl
IG52bWVtIGNlbGxzIChsYXlvdXRzLmMpLCBJIGd1ZXNzIGl0J3Mgbm90IA0KcG9zc2libGUgYW55
bW9yZSB0byBjb25zaWRlciAiZml4ZWQtbGF5b3V0IiBhcyBhIG5vcm1hbCBsYXlvdXQgdGhhdCAN
CnNob3VsZCBiZSB0cmVhdGVkIHRoZSBzYW1lIHdheSB0aGFuIGFueSBsYXlvdXQuIFVubGVzcywg
d2UgbW92ZSANCiJmaXhlZC1sYXlvdXQiIHVuZGVyIGRyaXZlcnMvbnZtZW0vbGF5b3V0cy4gQnV0
LCB0aGlzIGFsc28gbWVhbnMgdGhhdCANCiJmaXhlZC1sYXlvdXQiIHdvbid0IGJlIHN1cHBvcnRl
ZCBhbnltb3JlIG91dC1vZi10aGUtYm94IChieSBudm1lbSBjb3JlKSANCmFuZCB3aWxsIHJlcXVp
cmUgYWRkaXRpb25hbCBrZXJuZWwgY29uZmlndXJhdGlvbiBjaGFuZ2UuIEFuZCBJIGRvbid0IA0K
a25vdyBpZiB0aGlzIGlzIGFjdHVhbGx5IGFjY2VwdGFibGUgLi4uDQoNCkJSLA0KQ2F0YWxpbg0K
DQpPbiAxMS4wMS4yNCAxNjo0MSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gW1NvbWUgcGVvcGxl
IHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbWlx
dWVsLnJheW5hbEBib290bGluLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0
dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMg
ZW1haWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNl
IGJlIGNhcmVmdWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9y
IHJlcGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+DQo+DQo+IEhpIENhdGFsaW4sDQo+DQo+IGNhdGFs
aW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbSB3cm90ZSBvbiBUaHUsIDExIEphbiAyMDI0
IDE2OjI4OjQ5DQo+ICswMTAwOg0KPg0KPj4gRGVjbGFyZSBmaXhlZC1sYXlvdXQgYXMgYSBzdXBw
b3J0ZWQgbGF5b3V0IGFuZCB1c2UgYWRkX2NlbGxzDQo+PiBjYWxsYmFjayB0byBwYXJzZSB0aGUg
Y2VsbHMuIFRoaXMgYWRkcyBjb25zaXN0ZW5jeSBvdmVyIGxheW91dHMNCj4+IHBhcnNpbmcgYXMg
Zml4ZWQtbGF5b3V0IHBhcnNpbmcgaXMgbm93IGhhbmRsZWQgaW4gdGhlIHNhbWUgd2F5DQo+PiB0
aGFuIG90aGVycyBudm1lbSBsYXlvdXRzLg0KPiBUaGFua3MgZm9yIHN1Ym1pdHRpbmcgYSBuZXcg
dmVyc2lvbiwgbmV4dCB0aW1lIHlvdSdsbCBuZWVkIHRvIGluY3JlYXNlIHRoZSB2ZXJzaW9uIG51
bWJlciBpbiB0aGUgdGl0bGUgKHVzZSBnaXQtc2VuZC1lbWFpbCAtdiA8dmVyc2lvbj4pIGFuZCBh
bHNvIHBsZWFzZSBhcHBlbmQgYSBjaGFuZ2Vsb2cgYmVsb3cgdGhlIHRocmVlIGRhc2hlcy4uLg0K
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVp
Y2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiAtLS0NCj4gLi4uaGVyZS4NCj4NCj4gQWxzbywgSSB0aGlu
ayB5b3Ugc2hvdWxkIHJlYmFzZSBvbiB0b3Agb2YgLXJjMSB3aGVuIGl0IHdpbGwgYmUgb3V0IChp
bg0KPiBsZXNzIHRoYW4gdHdvIHdlZWtzKSBiZWNhdXNlIEkgYmVsaWV2ZSB0aGUgY29kZSBzbmlw
cGVkIGJlbG93IHdpbGwgbm8NCj4gbG9uZ2VyIGFwcGx5Li4uDQo+DQo+PiAgIGRyaXZlcnMvbnZt
ZW0vY29yZS5jIHwgMjQgKysrKysrKysrKysrKysrKystLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWVtL2NvcmUuYyBiL2RyaXZlcnMvbnZtZW0vY29yZS5jDQo+PiBpbmRleCA2
MDhiMzUyYTdkOTEuLmQ3ZjM0Y2JlYTM0YiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZtZW0v
Y29yZS5jDQo+PiArKysgYi9kcml2ZXJzL252bWVtL2NvcmUuYw0KPj4gQEAgLTc0Niw3ICs3NDYs
OSBAQCBzdGF0aWMgaW50IG52bWVtX2FkZF9jZWxsc19mcm9tX2xlZ2FjeV9vZihzdHJ1Y3QgbnZt
ZW1fZGV2aWNlICpudm1lbSkNCj4+ICAgICAgICByZXR1cm4gbnZtZW1fYWRkX2NlbGxzX2Zyb21f
ZHQobnZtZW0sIG52bWVtLT5kZXYub2Zfbm9kZSk7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGljIGlu
dCBudm1lbV9hZGRfY2VsbHNfZnJvbV9maXhlZF9sYXlvdXQoc3RydWN0IG52bWVtX2RldmljZSAq
bnZtZW0pDQo+PiArc3RhdGljIGludCBudm1lbV9hZGRfY2VsbHNfZnJvbV9maXhlZF9sYXlvdXQo
c3RydWN0IGRldmljZSAqZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBudm1lbV9kZXZpY2UgKm52bWVtLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBudm1lbV9sYXlvdXQgKmxheW91dCkN
Cj4gLi4uIHRoaXMgb25lLg0KPg0KPiBPdGhlcndpc2UgTEdUTS4NCj4NCj4gVGhhbmtzLA0KPiBN
aXF1w6hsDQoNCg0K

