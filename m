Return-Path: <linux-kernel+bounces-103495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275087C040
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72F81F20DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2570CCB;
	Thu, 14 Mar 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Wo1jDVgZ"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022018.outbound.protection.outlook.com [52.101.167.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63471B48;
	Thu, 14 Mar 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430280; cv=fail; b=owkd2hQlylOl8d3IybpZc88CFQkKwAK5Tp9ASRoew4oGgX4Xzp/zFbAj9/mH6jyruBG4BumNCZqaEzrq0hxyngoXq8lcA+6vb2wIL35QlIs7BykJV8hIJ4/NSI2JpGQIqfqddPKKX/gCg3UssaqVlDtjmIcNGyZIBBT7I7vugRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430280; c=relaxed/simple;
	bh=vVyU9ypwnLuWfCd+QI97GdhFwJ9WrzUvYxanKjTi9NA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twP+TzUtd6gnFQ6lJUFPoDa9k8a2YEvcK5U1ogGIVou2fSGSWmjXNS3JeSItM0sIRrenNL591x+wt7tMvNbWjUwBmEvZtJCf2+Gk4w1Fb+NyaprdUStUfDRSXcjRX+lNotU66dDH5zsa6QuxHftNXNBmuoS8otEbQ/4N457BEAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Wo1jDVgZ; arc=fail smtp.client-ip=52.101.167.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3TX8LCnjSugpWTsYUugaOo0FVTo2ZcM2tsfkdxQHhgrY/DO8Q3ZY8jTWa7ha7lFQ42TPMLw4Ym64DT30VK2wzY8zNAyqqgMIu6ae3iUzFCG482Q3iBIQObGCwcEPooIFaTc5Oikv5kMn/e2yUDgN4Aj/ScKXP3HBU9gwD1bGIHa2hvqGHnr0BGXrCjl144z9pdoB161r0/1wL8B9vWKaTpMajGXGrekV2Z2ng5tTxunxQeIpKaSk98VmTiV7/6mHogcI4Uop/Su1OJi495tzAtcMv3dBXH9eU4Znzytr9Ls5ET0YWmbAWL4VSDN2THXl5Tuu7Y0yBSCmoZcvxaxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVyU9ypwnLuWfCd+QI97GdhFwJ9WrzUvYxanKjTi9NA=;
 b=lcYfmOpGAl/Yz5zFvak011fAr2Ty4LJuPnNJwenAu9X2eLk854y8+MdpPw8ppf+HEIe0bX+6Aqp/V0K1EH/rHHjOEMbI33v4eOdPZIdiRG7yv8USTrD9UyDnigBVK/tkD0m0bqWVJTBhi0vaGCX6KnmG8tMkmoeE5aYX+6ZYfRQQdpTOKyBK0p//VblD/Hzp7W061NsKkb5EESej4XSMnrWf9Umoiw+yk19ptUW5nIdX7VIXTyUO3NIP7vwWLb6m66MXPUoqT5qEIsFmf3Ks8KiewC9HpFhasz5okAs8erRvDGFQW1wuPsH4HtpfZkPFerVNGAad7KPHmkcgmPMvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVyU9ypwnLuWfCd+QI97GdhFwJ9WrzUvYxanKjTi9NA=;
 b=Wo1jDVgZSDHkxGVZ3Hb9baHpvKeqYgK7/Z9/uTuK4ayZoft0wBQPQtxFNC38fe2KtFTe4rwIZei7e8DjHBqpTxak6bG+AxrXOUUCEkJWWJwePVFxp0iKWzSrKUKBOUoLH19f7v6Ckq4YSyD0fjCD3bjOYbkZdm10Fq2ZkmRsBj1Xu2dBHkWgKOr1brVtmPObbhmjQaNVg1xkIJmYAK9QCqc1CR7w3YcFNrQ7nsT/8k7JoakMTs/OQ2LimlwwLx3jlj4Zjv6YBl8f2hHMlyTdjSG5Ilo2muuV0UFsm+Luv/ErWZf1p5sGGTAthJ84b8TKo+fLzhEgZuAVKcu7AWOweQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3328.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 15:31:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 15:31:16 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Guenter Roeck <linux@roeck-us.net>, Herve Codina
	<herve.codina@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao
	<qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang
	<shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam
	<festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap
	<rdunlap@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, Simon Horman <horms@kernel.org>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 07/27] net: wan: Add support for QMC HDLC
Thread-Topic: [PATCH v9 07/27] net: wan: Add support for QMC HDLC
Thread-Index: AQHaF9GuM2a/sXV5FE2Knw6nmRUMD7E4FucAgAACw4A=
Date: Thu, 14 Mar 2024 15:31:15 +0000
Message-ID: <42504939-e423-4128-bb86-a40e7b7ae845@csgroup.eu>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
 <20231115144007.478111-8-herve.codina@bootlin.com>
 <bd7b7714-1e73-444a-a175-675039d4f6e4@roeck-us.net>
In-Reply-To: <bd7b7714-1e73-444a-a175-675039d4f6e4@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3328:EE_
x-ms-office365-filtering-correlation-id: d03d5c1b-9593-4bdc-1382-08dc443bc9dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BHuuaoWHOKSimp/b/DwUlg+8V1wsnZDPzu9ajW+pK/fS+DhILothvym+0oQ7r9wzlvqzp0civf2Rr+Ok24pQ87KUVO5+Y9HAW+CdnXNzdER236LAdGASCtS1Q/5R2EKS1c2zzlFyOUfZL+wHBzEErNf1vUXHC1L0hZ3y4SA2s5wrw1IqLRCM8yDsuvgYWrCB6Uvs7blf29wFVTGLEgtRcqkxI4FdivG9CW0v7kLN7Ntz1swLBcN03tvwTMIOymMX2A41GyyW9LfBfcHS5oyyBBfeA5Bscll1EeFxaiOF7Yl9LGt/dMHv+TCTTN99aJjdEU04Mu/gHrhIg3lrKm+aX2cJ7rSPRjyPo58bU26VQ45grRrCz86xlmz38Te14OuuWd+HRe64qfOuvb0mEZfvHEGfXBwUk9C1PBEdwU8U2jS2xe4XLW3LEAh4TVMkERSMQogs+jCHp3mtWzARIAueVlJagQQlpMU1bZB/AlO1xi6puzpliepiO1EyLnd0DMVTYQz3V/zYnD0UYVxecN2esFZJs9LkUax2zfvpl2fJUKHvr6aJUjrVpLCkYNnQArZCydMtrKPKyay3XD76yOewkc+nndqHNS0T1wB9qLtAfSUSEtvWxAqYAAZaxwotqGHj7Vmp5bNMQzcB5sl6nFcEDRQr7Sjx3fNwMNt5JpT8sGo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1NhZEh6ODVoK3dtVWx6MEVFRFFtbW1Pb2dFZDBWK0ZJZGlnWWg5clM4aWRM?=
 =?utf-8?B?bTAvbmpmU3lMbmQxSk9JVjNORUxCSEowWjRLZXJDSi9xdkZXMEh6WGxET0dP?=
 =?utf-8?B?cENLcDBDcE5PdUhCdWdFZzVjUzd2Z2ZWUjY2RWlPVjJYNWdlei9xUWdMYUtN?=
 =?utf-8?B?bmVmZEVBYy81SEJIaDRHOXFoRG92VUJucW01RllYcm1ZdmFCREk4SzNNTDkw?=
 =?utf-8?B?YzJlemEydzlzVHgxa1FOcTM4SDV5N25sTC9ha1BvNS85bkd1R3M2WG9uZ1dT?=
 =?utf-8?B?MTJsd2k5QzNUZFR3UnlaZ1NMakhCUzJuaUR5ek0rbXhUQVgyS0ZqU3BCcytz?=
 =?utf-8?B?dStBVzBadVZiQWNKT0lTQkVGSDNoWHFqSTBSV2hOR0VxU0tuVmZTMlpyb2U4?=
 =?utf-8?B?cHo4ZzkvTTlxMUJ1bk02Nit4SkxRdmllK2sxanVrczVsWWRVbWtoMC9STW9P?=
 =?utf-8?B?VnMyWWQvT1dTNVphcTR0dW42S2xNTzA2QUo4dGZLUnhjcVhhTlZ4ZDFHNTVQ?=
 =?utf-8?B?RExFdDIwYm1paUxXbkhjemh4aUt2ODI2NmN4L3NBRVFkaGh2ck1Yb2N2M0h4?=
 =?utf-8?B?WkpSdExwZmpnZUNreng0VDYxUy9NbzdxOE1waVlPdEpjYmZMa2FDTHlOelg3?=
 =?utf-8?B?RXZjd3pteXl2YUN3eTh1N3dBTnNnUkVpWFdIZ0JleWVxdmhNbGEvTnVpdzVW?=
 =?utf-8?B?bHFRajkyckdUd0VHS2JXK01WZ1JxSDBIKzNkdGpkOG0wTGRGb2h4eElpVzhZ?=
 =?utf-8?B?bU9Ub3lnTWVIazRkMW9EcVV5RkJnZUlIQ3l6MmgvR0VGRnpldWx1MytOR0JK?=
 =?utf-8?B?T3Jsd1lxa0tldzJ3bHpiYmFpNVdNenJKdDVsQjNvU1hVV1YwNDlieXlObTVF?=
 =?utf-8?B?NGsrOHB6d0ZJYkQ0Qk1xS2FKbDRmcGgxR2xudVI2UURnWjZMZjlxWUZqMXVN?=
 =?utf-8?B?OGtsTzM2UG1QWXNjdGk1Ris5bjVUTXo5Q3hYQ1R3S0FYbm5RelhacWhYSnVa?=
 =?utf-8?B?ckFoelBIT1NZMDF0NXJJdGg4dm5HejZoQnYxUWdSblRpUld6d1pMVW5kYXFZ?=
 =?utf-8?B?L29LMGwxS1hPWEhIcHdkQ1FtL1B2ZUdCbWdaTVNLcUlwb29XRHAwR0NvdjVU?=
 =?utf-8?B?aTMzVTJzRkpUQmFMUGxUaVFKekFBR2VBVWxpWVlnMHBMWVNPRGRjZlhxdHJk?=
 =?utf-8?B?ODJhWHlJTHBnWi9DNSs3T0xRR0RBemJIUjJzVnh1cDNPTEhoeFVUZVZZNzlY?=
 =?utf-8?B?ZzNNUEtBOHFkb0JTcXl2MUkvMCt0cUhrdFAzei9ySERNUHBtRGt4NlBBRmFn?=
 =?utf-8?B?WTJaTVhvWTZsdC9FcHNVb2QxSEZPb3lYRVRGc2RTOEpIQUhiY3BtOWtYMTlM?=
 =?utf-8?B?Uk8ycHdGaCtEUkpBam5oV2NXWVJNY0xXQTZ4QzJCNFlHZzZjTldjMkdkckZG?=
 =?utf-8?B?bFJDN1J6MTYxai8zQWFoZHcwRno2djZ4ZkxBUVlLM1hzbEdTTDQzNy9VQzBu?=
 =?utf-8?B?RVR5eXdLM3cyc1lsTHNxMkF0M0w1K2tRV1V3MjJiRGpaZUFwN3JNTWJHNDlB?=
 =?utf-8?B?eVF6VlB4YVZtN3hQa2p1S1dVQzMxS1owMFR4SU9ta25lSVNWWE9rMlZ1UVpw?=
 =?utf-8?B?NWhNR3Q4T0V4R01DM2hQVkowT09KWXR3biswZC8wRHR2Rm9YODA3ZmtzWnYy?=
 =?utf-8?B?S2ZXeTAxY2FrbnFNUVpML0dWRlJJZWlPQjNLUWgvUmhKTENzSGQ1VmZWdWdy?=
 =?utf-8?B?NXJabFRONkdvaHVxV0w2YitYbXFNN1VxVDFNc0pRTG1CT294M0pIYmlwMUsv?=
 =?utf-8?B?YkFMUHZpOThrdURwTnVmeXlSaGxGVTVjbWsyUkJpa0xCUHVFd0l1UWxmSTZz?=
 =?utf-8?B?ZkJ3Z2loV0xWTlViN2hSNVRpamZoeDJ0cHhPUks3K0U2alIxU2h2QzNCRmhM?=
 =?utf-8?B?cURyWlM2ZG5va3ZSZ1VmZWZTUUtvMGtFdmVBKzloOWNZaTJ0VGtXaGtuZTMv?=
 =?utf-8?B?SzZpTnR4aU5vKzVRdDFtTTVnTUtwQ25FcEVCcHpqckt2anJkdmt1YVFLZzIr?=
 =?utf-8?B?NEpjZHBjM0ZaMUR1RWNwRzZFWkFmSGhMZUU0VWdjU1ZPQTgyVmdPOUR6SXhn?=
 =?utf-8?B?cndqZHRla1JzNmwrTnQ0c1lTR0dGZkJqZnZVYWFFbGUwcDVldHNtSHBPMTRP?=
 =?utf-8?B?TXJKemVPZWE0L1gwbXhOUDJtdFBGVk9kOWZGQmhrMnZZa2VTRDhOWkFhVkh2?=
 =?utf-8?B?Mm82c05pK3NOZ05JUUN5TitWNUNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <927317E2CD1B4D4BBF381492F589C6F7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d03d5c1b-9593-4bdc-1382-08dc443bc9dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 15:31:15.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUyj8UvMhh1O0EjyC1DrZwXQU+RswDM1VeMD/bKgXgtXwDi853LCYYTjG+Lwf24A6XpZ6hgPk/seDmi3hzRUM676wzTrR7deR/m86KJJiKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3328

DQoNCkxlIDE0LzAzLzIwMjQgw6AgMTY6MjEsIEd1ZW50ZXIgUm9lY2sgYSDDqWNyaXTCoDoNCj4g
T24gV2VkLCBOb3YgMTUsIDIwMjMgYXQgMDM6Mzk6NDNQTSArMDEwMCwgSGVydmUgQ29kaW5hIHdy
b3RlOg0KPj4gVGhlIFFNQyBIRExDIGRyaXZlciBwcm92aWRlcyBzdXBwb3J0IGZvciBIRExDIHVz
aW5nIHRoZSBRTUMgKFFVSUNDDQo+PiBNdWx0aWNoYW5uZWwgQ29udHJvbGxlcikgdG8gdHJhbnNm
ZXIgdGhlIEhETEMgZGF0YS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIZXJ2ZSBDb2RpbmEgPGhl
cnZlLmNvZGluYUBib290bGluLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95
IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+PiBBY2tlZC1ieTogSmFrdWIgS2ljaW5z
a2kgPGt1YmFAa2VybmVsLm9yZz4NCj4+IC0tLQ0KPiBbIC4uLiBdDQo+IA0KPj4gKw0KPj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHFtY19oZGxjX2lkX3RhYmxlW10gPSB7DQo+
PiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLHFtYy1oZGxjIiB9LA0KPj4gKwl7fSAvKiBzZW50aW5l
bCAqLw0KPj4gK307DQo+PiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgcW1jX2hkbGNfZHJpdmVy
KTsNCj4gDQo+IEkgYW0gYSBiaXQgcHV6emxlZC4gSG93IGRvZXMgdGhpcyBldmVuIGNvbXBpbGUg
Pw0KDQpCZWNhdXNlDQoNCiNlbHNlICAvKiAhTU9EVUxFICovDQojZGVmaW5lIE1PRFVMRV9ERVZJ
Q0VfVEFCTEUodHlwZSwgbmFtZSkNCiNlbmRpZg0KDQoNCldlIHNob3VsZCBwcm9iYWJseSB0cnkg
dG8gY2F0Y2ggdGhvc2UgZXJyb3JzIHdoZW4gQ09ORklHX01PRFVMRSBpcyBub3Qgc2V0Lg0KDQpC
eSB0aGUgd2F5LCBhIGZpeCBpcyBhdmFpbGFibGUgYXQgDQpodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L3BhdGNoLzIwMjQwMzE0MTIzMzQ2LjQ2MTM1MC0x
LWhlcnZlLmNvZGluYUBib290bGluLmNvbS8NCg0KQ2hyaXN0b3BoZQ0K

