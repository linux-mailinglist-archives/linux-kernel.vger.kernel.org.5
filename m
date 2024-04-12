Return-Path: <linux-kernel+bounces-143222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3088A35E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EAD2825A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECFA14EC60;
	Fri, 12 Apr 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Kj/qs0SS"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11011009.outbound.protection.outlook.com [52.101.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0778B3FBAA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947503; cv=fail; b=KOP6B7ge2wrHiLSSbJ4dJXHjnmTHI7mliK5P5F+JMXc+MXDV8G6/5ZwygU39kPIMjRU3n3FJ51IscG+5a2mPJZsoYt9DrhhLDuYx8MOH59yvJa68tszwe/hVZK0D7m5qShYAIekgEyDCedBvd1G+eKun/quwlyBDMsvjsp0iks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947503; c=relaxed/simple;
	bh=P3eS6/3tS7ShflUbTVDnxbqtU+l9H0I9GfNnS7Io6kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DtzS+Rn4yj3ZHmU3sh32JRXa4psi4QpVZWFT3T2Ds/pta3K6br8mxT5iOTXKX+ZAdkexk8aQD01TvjDJ9bQw+uPSVzV1EcqLlKGaSId9ETyqpaw3OjZXyel8ZL+m23bullKfmrEOIO+S/72xvBib6eW8Wl9chRErJqUFpqgd3Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Kj/qs0SS; arc=fail smtp.client-ip=52.101.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmsc7qQw4W20cNNhMkHatfY557fT4RqpNZthnhgdzz5whT0PoGJkXeKdN5kuAzCki8VEeIHA+LctZQzci6wArnxX0dxn2KXLWHs/N+1XD4jWzUIo4HghDTzfRwXZCJN8q3pDN6IIcHM4VzVILipCfbT46apjcG9En2WxFppoyZtHW6cMwzZtdOgzlDus1Bh5C+/WZAhLzaqOHaOFNwTfQ8XblTo+zGNU1oNC1MeElTIdzTDZo4EtT0OOyt9Sv0PWHmwEl5ULibTO/riz9cZcPsNyXvcmiQ4rRW0Al7BCkBvOpNZ9s6WVxxDU9HqXD9zdRlTffEntsfYhtXu+TeHM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3eS6/3tS7ShflUbTVDnxbqtU+l9H0I9GfNnS7Io6kg=;
 b=mRKBUFIr4q9xgJFcuE+wBXIhFlv86QoCVz/68H/sw0NrT6LT3XCQKCxQer9FVFejNlJj+tge6awasMFFEVGIIwo3j7yjTyhXl63fvapB6CnjjTguYzlByn6WH7GJyX8Jqbsxskhw9PLKIx/ZrDgPZWig0P/NQmmhnBy7lKUvvO4of5+EOUbaNbAy6dL8yQHrlmlQi0uG/84JIngrpM5zOpHPep9nCKxmnK1j2f0E+sFqS9Y7UrT4ybU3suPVvObtym6NFoflr8nfaJsCyGxAU/uIAHFlp8nVZZyruQDNWj2HqqW2E2//g2kAii3ESxJ9URJHhlEOlOD8apZ/bgbY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3eS6/3tS7ShflUbTVDnxbqtU+l9H0I9GfNnS7Io6kg=;
 b=Kj/qs0SS5V559pDntMYPyHyOgD24CJ3ozVE4751Ma+HqCfWmuHs2VRfvVTlUFRZHzap9YRBCXwvVXO9kYdAlLhaP/G/JlzC/bk90XI9TQ22i/VgMKByZ4/sm3MJsyZrm9iOhiUMgiK9X1eSB0nMam9ZSPFS1orZtW5c81JvenHQ=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OS3PR01MB8700.jpnprd01.prod.outlook.com (2603:1096:604:155::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 18:44:56 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::68a6:2f99:8ab8:5c64]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::68a6:2f99:8ab8:5c64%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 18:44:50 +0000
From: Min Li <min.li.xe@renesas.com>
To: Lee Jones <lee@kernel.org>, Min Li <lnimi@hotmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Thread-Topic: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Thread-Index: AQHajDkVsXAHVSXc0Uur0s5K8a8Pm7FkQdcAgAC1tBA=
Date: Fri, 12 Apr 2024 18:44:50 +0000
Message-ID:
 <OS3PR01MB659315BFEC1145363E4482B4BA042@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References:
 <LV3P220MB12022B2F96505825BDDE6A2AA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
 <20240412074344.GQ2399047@google.com>
In-Reply-To: <20240412074344.GQ2399047@google.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OS3PR01MB8700:EE_
x-ms-office365-filtering-correlation-id: 5fc45747-4a4c-4483-4bd8-08dc5b20a2a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YnktbZVPlNbNIWxlFpu37JZ0rFcH88g4JXU57pSeE7BC7qeMEDE2aRsCaeRtrI3J+fdjOeyj0W/5ZQby4yZWp/TeF1EbIOuWs83LbS55DT55EZhwbQEdHnIg9g0OqrjC3NpHH9iJysGTUfVVtP0Qc/Jm0l2EyZhPJLamCjKp1XIY7UrsEzUaZtHf4rLAfWjwTBw6DMf2gcFta0nSfTDTdfHAmQfWy2EMhlCrZ7i0kPCOBlswvcVxrwHeHW+c6GwHCh4U8yZHmr5tAHEV1Op5IzFyOs4Ndxy4NQIuhybkFxkWnVWbktfhTsPZE2B8PdcTXWZ6Dk+yZoFS5P03S6V3LjMLp8W0zu29GMzoFYhVAskfjpIR55cJVCBVAQhFWXWtpK0W+F7M7ICNsyjt1iIpj3gb7L8Vo20tBdijMIygRIbWJVkf9oJx+Vb721Ftha214PDFaXU7RaOaIltB+I3Na7LkWJknTaJ05d1dMHJd48SbB/wG5/lNblaZmSzNPdAT0a+1f5PrpK6JxInrKh+suonC+jWal5/pnItk5u/dCVmv9M06ZyPiS7K2urLQ7ESpkPKpX7QdaJF0XRTLANeIu9uXlfRxOeo/V+ojAwlJQCmWL2Xhp3p7RJ90kxSPbj9g/Hp6tR7IgjA5IbmdgHBgY5S8w11JMzxqVZ6x+7OoyjVCchwttyGP/7E43JADSyDamiDoi8Ir9elTcEuAzV+2hA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGwzVDlHMFJZUUdvN0xKUmtNM1NWT2NwSEhlUkZqT0N1NUhFR1BLdFg4VGt4?=
 =?utf-8?B?dnF3RzlKdDJPTGJJZ1BERVhxSkhhM2dKNXJGekE0MDdsdzJmQ21LRzRXVFk3?=
 =?utf-8?B?N21mUmg1VHJ2bGIybW5naWIvRTFXajZxZStJbVlrWGF2aGxLN0J3QjdDY3Bq?=
 =?utf-8?B?T0crM25Ld3FjQzdOaXV1V3VFbkpzcm5iVEtZODM3d0hWemJTQ0N6bGlnOVhW?=
 =?utf-8?B?TjZRMzZlbUVZb1ZpOHFtbzM1d3VCa01oNXR6VEtnNU9HVUJwYmpQeGJUSzVl?=
 =?utf-8?B?Y3RUd3Vnb2c4NUYzcGpJS0J4dXZmWExVaXRvaFByUnNmdkFWR3E2a2ZKaEc1?=
 =?utf-8?B?czEwQ3QwKzhqTU9XVjlkL2tCdnRrUVRXNlRHdFJUQ0tQcUV0eTNLVENvZ05Z?=
 =?utf-8?B?Qkd4L2U2dWZhdXd4NDFFaklRNjNDNTFRMU4rL0dFMVI0OEh1V2xZeHhZQ0FO?=
 =?utf-8?B?bGhLeXZtMzExdlhNMitnQUpnK1V2NG91N0xCcmhrSi9SUUFKY1M2QjFHSjM5?=
 =?utf-8?B?Ry9jNDN0TXdNK3lLVDcxUUJaMTdTYzRsWlB5RlpQN2lNZmlTdThCZmd4ODl6?=
 =?utf-8?B?M1dUYXRvZjdrR2F6dmRuY2hYTVFrWmNzeTZYbHBhNlJtQ0R3b0U2aGxUc2w0?=
 =?utf-8?B?ZkMzU1IyYkVUdVZ1SjNRWEphWmFwUGV5TEZLbk9YaGVBYjRoOU5uKzBDN2I5?=
 =?utf-8?B?RFpTaXpzZU5KdFdqTmVtMlBpOGtYQVJRZkdGTG8wSnlVUkltcHU2TXVobXJh?=
 =?utf-8?B?ekR3WVMydVg5dFo4VThDYklxTm5MSzJQYytKTndCQnRaN2h4enpLN2o4eDBr?=
 =?utf-8?B?SHlWVXl1SVptYTZ0Wms5TGFTaWh2MjdVWjJ3NjVWTmtSOVBNNVZGV3pXeG9v?=
 =?utf-8?B?ZXV4RFN6U2ZmRG9sUmdyWUNSRmlJRUM2Sml1djd6eXZTTXhySWZqRGNvUE1F?=
 =?utf-8?B?TWVJeHQxdW5RTlNpQzR4S2tSVEZJYmczWTFTMC9sZ0dybXU1RUU1VkMrank3?=
 =?utf-8?B?cHNxZnJLdmJIK2JwVmxjUTJmSFN6WCtMbFNtL0pFcWZoelkvNG1XTUhWTVdN?=
 =?utf-8?B?bVN4WEttNzhoVEVXOUVUaHgrTGZlR3A1dURQd05jUitobm1IeXA4bnd5QjhG?=
 =?utf-8?B?ZXJ3blByNHplOFBvTE1QSE9ZZTZXb1ZQdG9oYXBvUkduNVFCWTdSUVRYNVcx?=
 =?utf-8?B?ZUM4RVdSNGQ5UUNtQ0x4eVNDSkJ6b3hhOExHWGdXcGNiVzMxNis1SUJHTGJS?=
 =?utf-8?B?Zk54Vk1waE4rVzlBQy9Md1ZtNlFwMldiQ3JUc29Sa1NiMGdJRlQrZlBWRWdq?=
 =?utf-8?B?Z0NRR1J0TFpuS2t2MWVMVmJrTys4Yy9HV0NhTFZBUndHa2YrQ2RMMElyVTB1?=
 =?utf-8?B?Y1JsaGVrcWFGNXpLdjU3a2krYUY5a21KVjd4WWFSbU1rM2RsaFFzcVFjVWhN?=
 =?utf-8?B?azhyaWxxV09SWmljUmlGWnlDT0FWak1RTFpUbS9GdHpXdDhFTitsNUZ1ZSsr?=
 =?utf-8?B?Vk5lVXhLUHRzcUR6VGxoQnNabGFxYnRmTVM0SGtobzk3bHB4cEZRaGhVSlE2?=
 =?utf-8?B?Nll0RTV0Qzh4cjZjTzcva3BDL05mOUdQTWljUUtwWEpiYmV5Ri9DZ092TFRl?=
 =?utf-8?B?L2h5NDNWMURrQkhnanBOcWQzbUlSY2k4Mmk4Uk00NDh1am9IRExobnl6MHY1?=
 =?utf-8?B?TDlHV0s4QnFGc2Y3bFlDcnJwV2FPUEFnNzBaejhFb1JtUFhHczVscmF1U1o1?=
 =?utf-8?B?RnVMZ3JpZk1vU3dhbGt1OU1LanhvS2hYR0FCK2VRNWxhTU04T00wZmY0a3pP?=
 =?utf-8?B?RHZURHk2dG9ueU8yYmxHRlh1SXl4czdUU2Q2bmJXbjlXU2pSMHM0cFQrbmdl?=
 =?utf-8?B?TkllREw2amx3WEc0aEdORFlsYnJPUlNDTHRNQTR3bG1VTnI2eGNsM3lsZ1dx?=
 =?utf-8?B?ZTg0T2UzZ0Noc3J1cEZwVysrS3Q1M0pyQTBjWHV1bmlUOHlETmJXQ1k2UzN5?=
 =?utf-8?B?bmswaGR4NTBwb3pkUEt5MzIyb24wSUdWOEx6NW1NYmVnSjJLeGZsSXFtNjMw?=
 =?utf-8?B?TDA0QVBmakRvK200QlhVSGg1ZmJvTGZIWXNNaHNJWTV5MldXZzZyNlNUUWJE?=
 =?utf-8?Q?2zRlBxXyIPhy2qqezAmTogvSO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc45747-4a4c-4483-4bd8-08dc5b20a2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 18:44:50.5381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zNVK0GBmi46rhvQBcXdWG2gh3hJA6YSpUFmKozMLZa3rQ+EEGRbBhydVy79nxJ0+hNAKsiJIBBPz5WS7qPw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8700

PiANCj4gVGhlc2UgYXJlIHN0aWxsIG5vdCBjb25uZWN0ZWQuDQo+IA0KDQpIaSBMZWUNCg0KSXQg
aXMgbXkgZmlyc3QgdGltZSB1c2luZyAtLXRocmVhZCBvcHRpb24uIENhbiB5b3UgbGV0IG1lIGtu
b3cgaWYgSSBhbSBkb2luZyBldmVyeXRoaW5nIHJpZ2h0Lg0KVGhhbmtzDQoNCjEpIGdpdCBmb3Jt
YXQtcGF0Y2ggLS10aHJlYWQ9ZGVlcA0KMikgZ2l0IHNlbmQtZW1haWwNCg==

