Return-Path: <linux-kernel+bounces-146541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD838A66C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D0B1F21A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2284FC9;
	Tue, 16 Apr 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwdcRrRk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B283CC1;
	Tue, 16 Apr 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258618; cv=fail; b=JZdDZxeJ8SQZXgMMoER6so8oQIiFnvmrosZZubBN3Bz+zGcUomhtZMKnphllfT+NzePm+5CzgvanSi7X7xIfF9UVnZ9QX//f/emhuNYt6a0+06/O0QQwvOw80C2efmwqwd3ScSxoIibxaZMFuUu1QdZ0RBDxEvPpUBLyxQgdLfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258618; c=relaxed/simple;
	bh=NAEkv7OZ/akPaFzbzhwioWbd56GwRVGz1KMtpb+4qXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXjyN4YZbzoh/xyuK/sMvntsvB6moKiK18ldlifTzl6bUNp1XGMK8hqoTGGIDqUBqh2g2F6/k09GJA8xsRSIUd8lJ7ldGBspO5fbhBs2IGepMvAtoR7QdH9Izf9vDIsyYbvSYInPfxIlaDlDPNtLYcM+Kbn4BCF3YjsgV45t+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwdcRrRk; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqXZn4lYasdGg35a4EatwIqCt/hOZSUR+kzxFawPr8rF42FeKaqtod20Etyo9srNGBeBEiOqcOjVMSozjCYKAxscW+DKg3TljLNwqC7rzB/3Aa/+aGf2L0Cu6NykR1xibI3iPQmJGvK1VPVoFEJ6H947FJiyRqEEoPwGEf0jx9EA392boN2ZoKICHhgF8K4IuTc7AZ2aIkk4+xNqEpaERNEv0C/5Lt+KzHMvU93CyLKGTqc74qje7hr9sXyQnuMhedlnr6yIoXXgCe+C1VVIwkDRHoYoZOmH3XBgSc5vqaWeMNZvvmszYMH4DuVORhcsBkKIw6NvssPgoncu3GMN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAEkv7OZ/akPaFzbzhwioWbd56GwRVGz1KMtpb+4qXo=;
 b=kFnJU1iMOqWaUo8uMPGkY0MWjJ8BCoTpQveEd7PgiS8rcbA3kXPuyhmH/huuYtwwaYwn4yQ9Kkr9fLfG6xfO0Ee0de3C8H685rW/8ZBE5srMmczFRMHw4nldT/nWzicIz5fSCNWKO1J9ieRU48dWejP70Ja3BbsHE9C2Hb7nfGS7Xxr0LgHiTOnl/B8r9TUiz+DzP+W/VVWEMCMwORU0GQKHmOTVGZHjMJ7Ne0FGCkqaVdZMQzP8s9HhM9ddyhzEN5O9co2DyxSGTR08p3MbQpsRnrT5KMGrNHE1OBMlPz8auofAkG/Q+0khn3CmWTrU4QEZtEIz5ihT0GVirm5lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAEkv7OZ/akPaFzbzhwioWbd56GwRVGz1KMtpb+4qXo=;
 b=RwdcRrRkoQJrA0NdYd6hiCxF5jmaQckQh1ce4zX5XDI1PredG6MKYWVSMxX80BfAjeKbKT1DQZrfb8W1GbT77RtrVGwbdfzHwr/0ZRZouIkFCH8wSwXeKJlqPdlb87Frxe9ka3lmAG7MZc8FP8CAEDH6KV2Zbp1/xDIpi4AVOqj3aezjdEx3jak/jdhSHgIQCo7ocixebraGuAsWLvIHoN8ZYRTr+um8BxuA66fpm2yT6rTn4qdtSGpNpcQQiilB2d+gz/jxv46RohKpu9IZeHPnjT3FQrnaui7vDnmq60eihVWWXgAzaOOsPXPL/3lSB3kH4yxvhSoOGini2C6T7Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:10:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 09:10:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>, Saranya Muruganandam <saranyamohan@google.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block: Fix BLKRRPART regression
Thread-Topic: [PATCH] block: Fix BLKRRPART regression
Thread-Index:
 AQHahvqtaO+xwAwpcEuktHLiDvG457FZPf2AgAFu5YCABk45gIABN5wAgAIQ7ICABmosgA==
Date: Tue, 16 Apr 2024 09:10:10 +0000
Message-ID: <cbcf7378-e889-489a-92d2-1feb112cff58@nvidia.com>
References: <tnqg4la2bhbhfbty3aa74uorkfhz76v5sntd3md44lfctjhjb7@7qbx5z2o7hzm>
 <20240410233932.256871-1-saranyamohan@google.com>
 <zvmwp3n3yx55ogzb5gtfe2xdmsg53y3umgnezcwd4weq5vloru@w6qi7lfvezls>
In-Reply-To: <zvmwp3n3yx55ogzb5gtfe2xdmsg53y3umgnezcwd4weq5vloru@w6qi7lfvezls>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8467:EE_
x-ms-office365-filtering-correlation-id: 038919eb-b33b-449a-de7d-08dc5df5048f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FjVJWD1G+Zlx4uWRLcdJjdOT66sfLiKel92mgeRdquxdQm2OmLabIGhnCsux4oGaCtglyy5XMYX0wMsA7bHOfYqbXHqkza5bLd5a901XOpwqdiwtXlq8r1haFVQ8zNsdQ7zg6a1NJlnLisQ4fau84Y2pJlqHr5/rVziXJyMLTipvmAofnkChaKL+VJS2OqM9awS0aZdc1x/AKZ7RbtaaMkOC5TvCkRB9hH0wKO3QuPJTG9stSGEoHwCbgABSkKgPerD2cJ2YTCn/YRc6HhVLy1oxREuSdvdgmy15+7UCndv0pTOGc3yBJ3NyJ5isdLKjklTdjO5u42fkQ0ceODbh7M82V1E4vf7omteaPvOsfFkJjSNEbfUjLi3zrju/bKsUq4PJJioJdmpjSWFtmVnJyHMW/iI6awAkwl7bkH6rf5eng/Hr1suNU4KvSMYzkZa9pabcmEeBGZkph+yeQvf+ayXMT67OiLcddPnawZFxDHA51fKpulekaSFyJSR3FJVSwRf93CgQBZnziKBlgSwjZTaTahS1+Zh7dQ7oa6jxNCZsjkdAzTEVLsR9wcV6XCj3pPR7BDuh+C+97OpxnUVtEC5ysiAjQxmfPNXz6vkg6Jc6weFkZQKiP4FBNt/+uDqLCreezz1Ixff1V8/y/kGPIxGPEtwNxC4hNK/qhs0rsnjOrQyl+cLEvz6lYnRnCLlbQwjkjlFg7BQIwFenD3QdOqoR1+VZLsntBEjB4ZGJsO4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGtrWjB3aU91RGlab1VtYW5jSkVkUXVDTFFzRVVacXZqcS9KNTZkdmwydFFB?=
 =?utf-8?B?WG1qcFZ4U2FYR3FtT3pENTlHMHNQWG0xdHlvMnJmeDkwZmRQM0NPVTB5cDZJ?=
 =?utf-8?B?VkNSczBnVEdoMXpGNk5ZMmMwcWVRMmF5cFpVZ2FBTk83ZDFtZHZycTBZdXFD?=
 =?utf-8?B?NlMxVktScHd0c3JLa2xJeDV4S3gxVjV4TE13SFZDRnVoQ3ZMUXFoV2dlTzdD?=
 =?utf-8?B?bTlIU0t4VVlGWHMvUnlWSDBhTGJBN1U5ZlVHOTA3S3k4MGFSSkEybjU1MFVK?=
 =?utf-8?B?UHJsQWdJbmQrVUtUSUtNbHBrWlp3ZTd5TDhORmNHZWd2OEVJOTZGUFVxOElj?=
 =?utf-8?B?TTNtQ25oeUt3UldKVW9wTkM5eHVqNkQzTnE0MjRhcXAvUXZJMFV0L0VhdWxS?=
 =?utf-8?B?RmliZWd1WExzRlR5Z24xUEUvZ2V4bjdpcnVWNVhDeEdRa0JEZXlPQ1dCMFlL?=
 =?utf-8?B?ZTFhWXh0Q3dnNjFEc2lnNy9mMERNU2dqOGJEcmZseGxWZXRkOHMwVURrVDBF?=
 =?utf-8?B?QmhGUmZmVG9VUXlxR2thd3JmTm5OVDhuckhwQWZIUGIyTTlvV2hucEEwUTNK?=
 =?utf-8?B?Z3R0Y2YxWHhoaUdJU1Nrd21sdHhET04zZ2NvWGl4WWxmQ2kyMHozN1VOYk1K?=
 =?utf-8?B?cGhaQUwyOGpLMm5hQTNuQXMzMURCSW5JdnIzNHdTK24yYit5bmVZMVBvaUxH?=
 =?utf-8?B?NHRrZUEvZTQ0SkoySGdYaGlaQW1oTUNNajBiRGZsQkFkYUp1Rkx0Zk8wbHVJ?=
 =?utf-8?B?Ym9maVdwWndCY0VqS2dFUkFvV2NrWjE3am55VUJHbnAxaE5FYUFTZ0E0Sm0w?=
 =?utf-8?B?dlJlRHdSTnl5MU5wOEdhZEc4aW1kbjI3MFRhNkpJSmJDV1gwcmRjUlR3cjVi?=
 =?utf-8?B?Uk80dGE0b0dHMGYvYVVYc3Y5Y1UxUzhENzFud2VmRXVabUVXaXNqSDVRTjAw?=
 =?utf-8?B?RDJiZ2VpM2Z2TVlVUjlUSjBkZ2Zwa1JKd2dQWUkwWktnUjA3dlB2LzVkeUV0?=
 =?utf-8?B?aXlWRDBiMmxCVkl6TE8xSVdDaC9maFlpamlRenZ5ai82ZTI1OS9iU1lsd1FR?=
 =?utf-8?B?ckNtcWdBM0pXU2VxNjNQaEpyREV0bTRIbnVwZWROQ3hOWklWNXVGandvY1dv?=
 =?utf-8?B?ZGNjNWU1SlM5bHRPQ2lBS2JscGtxdi93cUhmS1QvSWZCYXBpMFNxYnBYSEFZ?=
 =?utf-8?B?Q2tCbThEakc0RVoycE85UTljeTdJc216VTlPclBPazBQSVQ2ODZyOEdzMmVp?=
 =?utf-8?B?Rm5YeFBUR2MvRzQ0cjZiVXhERTNKN1ZMTkZpQzFKV2V2UHdsUlVnZXpaUi9l?=
 =?utf-8?B?SlM5bUtJeXdwcXRNZTNYbEZmVHR1VzRPTnE0ZUJwWC95aEhnSW85dndOVkJn?=
 =?utf-8?B?ZW53azlTa29kR1FpL09rTnNqS1J5UFBmaWg0SkVSWHpwaVFpYTNzTG9zZS9B?=
 =?utf-8?B?cXF2dklxRlpPWUhNN1dMUVQvNlkwVHBjRWJweVo4aVpZWWk2OVlKMlI5R2RP?=
 =?utf-8?B?UjFJcWpaeHJOS2tCZ2ROWXFNOUlpcG1FN1YvUnpBWHJOMlhLazUwVktzZjJQ?=
 =?utf-8?B?K3EzbTFKWFBnSkN2SGxEbzlBZEpJQmJzL1o0dFdpOHh1cytZMnQ1WFBxbUtM?=
 =?utf-8?B?UUhZTDc0NmVlVmpYQmRtWUZjMFlTV01ETGlSQnVNZmZRWXRaQjUweTB2eSsy?=
 =?utf-8?B?bjFmL1I1UkVEa2dFRlZsemtybllvSnlrWGNWR1k3VUI5V1FwbXZOYkI1KzFO?=
 =?utf-8?B?MlVWM0xnZXFJSkxkN0JqU0pVMlQ3VitPUiszMkE1bWpQbStvVThlc1h1ek5n?=
 =?utf-8?B?YU5tcU5ScXZHc29oMjdsUUFZdUdYb3QzcTlSN0s0Yk1DSkJXRTNmWWVocTZj?=
 =?utf-8?B?QTdyVEU2TFpBQk1xNGxFV2pOcWVsbDRkTnJ0ZkV4Q3BlVlJLbi9vZHl4dzlQ?=
 =?utf-8?B?N3BOVTB6V2VmUkI2Um1PRDg2bS9NODVPSlBGOWRpNU91NFc3WkJYTGl1cUZV?=
 =?utf-8?B?VGM1RGZ5QmlnamJ2T0k0LzM1Y1RVQjBqVzZYWXR2MitIdHVXYjEzTllBYU9N?=
 =?utf-8?B?c3pLR0p5Y3hSTFA5VXluSFlaa2lxb0lxU0JUdG01Wjk4czU4YS9mdHoxbjFM?=
 =?utf-8?B?bU81eS8wbXRuZGlob2ZnYjg3dkxoVlA1cndWVnBwMnN3NWpmN3RUbjl4WWI2?=
 =?utf-8?Q?Xs8byIrcgZ31fo/kc03J4N30sS5c7oOjKBqfXD+WHL7q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A993CFE5F05DA42B2930D4D12B29E2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038919eb-b33b-449a-de7d-08dc5df5048f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 09:10:10.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzkKbcNXA11ab4npD3z2NcLiwT09fxqenWPg7yYU4qFjSM2QPO0uaNKyUOO5Fa2HUzM1JlVrkVhFtKvVlyg82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

T24gNC8xMi8yMDI0IDEyOjEyIEFNLCBTaGluaWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBPbiBB
cHIgMTAsIDIwMjQgLyAyMzozOSwgU2FyYW55YSBNdXJ1Z2FuYW5kYW0gd3JvdGU6DQo+PiBUaGUg
QkxLUlJQQVJUIGlvY3RsIHVzZWQgdG8gcmVwb3J0IGVycm9ycyBzdWNoIGFzIEVJTyBiZWZvcmUg
d2UgY2hhbmdlZA0KPj4gdGhlIGJsa2Rldl9yZXJlYWRfcGFydCgpIGxvZ2ljLg0KPj4NCj4+IEFk
ZCBhIGZsYWcgYW5kIGNhcHR1cmUgdGhlIGVycm9ycyByZXR1cm5lZCBieSBiZGV2X2Rpc2tfY2hh
bmdlZCgpDQo+PiB3aGVuIHRoZSBmbGFnIGlzIHNldC4gU2V0IHRoaXMgZmxhZyBmb3IgdGhlIEJM
S1JSUEFSVCBwYXRoIHdoZW4gd2UNCj4+IHdhbnQgdGhlIGVycm9ycyB0byBiZSByZXBvcnRlZCB3
aGVuIHJlcmVhZGluZyBwYXJ0aXRpb25zIG9uIHRoZSBkaXNrLg0KPj4NCj4+IExpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMyMDAxNTEzNC5HQTE0MjY3QGxzdC5kZS8NCj4+
IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+PiBUZXN0ZWQ6
IFRlc3RlZCBieSBzaW11bGF0aW5nIGZhaWx1cmUgdG8gdGhlIGJsb2NrIGRldmljZSBhbmQgd2ls
bA0KPj4gcHJvcG9zZSBhIG5ldyB0ZXN0IHRvIGJsa3Rlc3RzLg0KPj4gRml4ZXM6IDQ2MDFiNGIx
MzBkZSAoImJsb2NrOiByZW9wZW4gdGhlIGRldmljZSBpbiBibGtkZXZfcmVyZWFkX3BhcnQiKQ0K
Pj4gUmVwb3J0ZWQtYnk6IFNhcmFueWEgTXVydWdhbmFuZGFtIDxzYXJhbnlhbW9oYW5AZ29vZ2xl
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFNhcmFueWEgTXVydWdhbmFuZGFtIDxzYXJhbnlhbW9o
YW5AZ29vZ2xlLmNvbT4NCj4gDQo+IFRoZSBjaGFuZ2UgbG9va3MgZ29vZCB0byBtZS4gSSBhbHNv
IGNvbmZpcm1lZCB0aGUgZml4IHdpdGggdGhlIG5ldywNCj4gY29ycmVzcG9uZGluZyBibGt0ZXN0
cyB0ZXN0IGNhc2UuDQo+IA0KPiBSZXZpZXdlZC1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNo
aW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gVGVzdGVkLWJ5OiBTaGluJ2ljaGlybyBLYXdh
c2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KDQp3aGljaCBwYXRjaCBpcyB0aGUg
ZmluYWwgb25lID8gSXMgaXQgdGhpcyBvbmUgb3IgdGhlIG9uZSBwb3N0ZWQgd2l0aA0KdGl0bGUg
Oi0NCg0KImJsb2NrOiBwcm9wYWdhdGUgcGFydGl0aW9uIHNjYW5uaW5nIGVycm9ycyB0byB0aGUg
QkxLUlJQQVJUIGlvY3Rs4oCLIiA/DQoNClBsZWFzZSBjbGFyaWZ5IHNvIEkgY2FuIG1ha2Ugc3Vy
ZSB0byBydW4gc29tZSB0ZXN0cyBhdCBteSBlbmQuDQoNCi1jaw0KDQoNCg==

