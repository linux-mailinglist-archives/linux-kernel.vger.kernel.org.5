Return-Path: <linux-kernel+bounces-3561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD40816DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8077C281899
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935734CB20;
	Mon, 18 Dec 2023 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ApuFB82S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF894BAB0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5i215aaRkXuIM/vtcgwqv7U+QLkJZjZFk8okWDNVGLCDT5ayZa+g4jcwpQjni8vxHyIcjoGbNSiY4E1WZ25UxTpgojrpbEYpV//EGCBGtChAvBA5XEwWvyU/ygehIA1d2BEcCAZU07PNg+6i1iHa7tgsi6szTKYmG14lHgftS3vRGvz3wUHl95PgRoZtKpt1zz8WmvaMtwMPa1an6wKbvhlbvB7R/vA5jojFqTgfyV0XurvrDsFx+kVY6HgaXkTZc3fEnd/AfL+M3Ss0BT/WvI6YtJ5ete3XKGWVafLljSFsEE1F33SCKRZgPiPpctSQuHmVNDe+qkpP714NB+biQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y2bdokQW1KyKGtFmZnHByHMGsKwFPOBn8uZA6ft8Qk=;
 b=B7kjTdRJAtZa20XEtv0sXsE8fAJJ3LZw1vWd3jZvHi3oCyDWiZLo40Y96k31vOOMyWAGjkkTtjw9OzfRbtXJQCdSv2X8frLEea59x8BItKubIPE1+AcpOQPjnuJLeu+LGxfxAHzdxRkOun+GuvEGg1EvuFzWTYDr32xJMveBtd/u9idQvOiqAHFDHgbDxLNrRlydx7DlzWJMEemZ303Co5kax6dAQFYXNlCSASuU5sgrBEs/ByWYhblUJEKO864aDRQAJKr7eQoPU7KgFSo7FNKJesOb3nXmpykOJRcoVmbDcC7LQGuasOF4/ZY/3b7LwcEpZvkVwHHzzQHWsGD0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y2bdokQW1KyKGtFmZnHByHMGsKwFPOBn8uZA6ft8Qk=;
 b=ApuFB82SGhQ3qJs0z3/xqCminol2odasf74It+6sBmvsCksmcwJD/TOsYXc7R9vBgXNuFjgv4utMvr0F0UnLtGJqfkxBIwBxZ9mSQcqAlcxB4mwtApTpeo9uzdVDP5YrqIB2ETHG/v8b+YJXEl/PxGLddP/fN3870ZcgNqq322c=
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 12:21:45 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:21:45 +0000
From: "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
	"broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>
CC: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Hiregoudar, Basavaraj"
	<Basavaraj.Hiregoudar@amd.com>, "Dommati, Sunil-kumar"
	<Sunil-kumar.Dommati@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Gong, Richard" <Richard.Gong@amd.com>,
	"posteuca@mutex.one" <posteuca@mutex.one>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, open
 list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform
Thread-Topic: [PATCH V2 2/2] ASoC: amd: acp: add pm ops support for renoir
 platform
Thread-Index: AQHaFi25zl1Prjuux0WT1b9NUOGoC7CqY04AgATJbYA=
Date: Mon, 18 Dec 2023 12:21:45 +0000
Message-ID:
 <MN2PR12MB3661BA672C138AC6A0E002C8FC90A@MN2PR12MB3661.namprd12.prod.outlook.com>
References: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
 <20231113123345.2196504-2-Syed.SabaKareem@amd.com>
 <b8a905a7-8fae-4482-9a6d-d9ed2f5dafbc@leemhuis.info>
In-Reply-To: <b8a905a7-8fae-4482-9a6d-d9ed2f5dafbc@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=04b0f258-7532-4607-a062-3ca336c2b61e;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-18T12:20:10Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3661:EE_|SN7PR12MB8004:EE_
x-ms-office365-filtering-correlation-id: e2cb4341-b8a7-4dcc-20dc-08dbffc3e6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SjgSTT3XzEPxnxntA0O9dHptIsxTqKRwuGE1kRCoNGdOykBf910Og1STGCLSSKTOS4BI0auWY2opTOgkuAwSKmWEYZjIBbJ6KxEKaPSFtUaqJnOL8pQ5vQN8vIDb4GsVhAlURieXmOpSJ5Vg1QXeCbmkgsJH4nmf5VC4qDj2mCwqbE/cJTuOvK4SU1x3sbAzO9ZksWtMxHMzpH+hvplZyvz4QdCB+MCw9AUxmNf+trZT/OhG18ZIIUkMdO05/iApgxell1EhQNCiir6DiYen0XJ7XucplPEEzYImJRKuFuE8SqF4YmhiUXtpl0ayar+18WamaLhNq1+Z20XQRhXkxxmiom6qFyWGpOLq0rBuWtB54bze0ROOICfMT0XEXvs7mUux2Re0p+SNm82tELUZQxqdazj+KwwdqkN3B1cXOoZWnxGnyHfTxoVW9pqYk06vTv+g7XXESDHP3BvJzJbOKUqpG8dEq9bpJGs3+GYyMaFswlgoR9b3jOXPQbIs25REShZ8aWRlXvRLjpz5xVaehucvOUdF4UAzlrIku9GE2DHJP+MvsUclmx4XxC4T4s70c53N7tSPlOKKapfj+9X0WwsXnqdsV/q9oZUG8AqKNF4T1K0FcIaPRsMyv39/6cs0eD6pH71pfQ8KzNqzWxUL/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(66574015)(26005)(71200400001)(38100700002)(122000001)(33656002)(86362001)(38070700009)(83380400001)(52536014)(5660300002)(9686003)(53546011)(6506007)(7696005)(4326008)(8936002)(8676002)(66946007)(66556008)(76116006)(316002)(66446008)(110136005)(64756008)(66476007)(7416002)(2906002)(966005)(54906003)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlpwdmpLbmtZczJicS9vQ3hiTjhSbGNFM0FZVFZOdUFUa3h4NFcvNXQ1UjFa?=
 =?utf-8?B?Z2xZeldTRUZlNmFYR1NaSVBPcGY3TE9LZlJrTFNqc1dOaXpTcTRWdmx3UjdB?=
 =?utf-8?B?WSs0dlJYUUd0cjhXUElpSzg2UERoRHhlQ3dTT3ZoUENZMmNBUUIzS0ZVZWN2?=
 =?utf-8?B?WUFGK0pJQkhERzlaTHlhTyt1ZTloamZibEFBQlRnWW5kcVBpTlJ5L1NUL3Bj?=
 =?utf-8?B?dERuQ1lwME8yWFVwZHFiTTY3RVE1dDY4MHF3bit6R0tMQ3hhQmRzaGdSSVJ0?=
 =?utf-8?B?YWk2ZnNJOWtWWnpaYUU3MXZwVXlLOWZFcjVTY2ptd3diRUJkdW9sREpCZXRJ?=
 =?utf-8?B?aWVieVdacW1nVUJLNkptVGVrSjcwcGpoMTF3ODhVdThwUC9mWGJvSkcvZGVT?=
 =?utf-8?B?TlhJSTZ0WGgrZTZFS1p3aUFNR0JiSzUxMWNCVDNCNTFnUDF1Y2RyODBIbFJi?=
 =?utf-8?B?QllWT3pYZHYzZ3cvazFhY05Yczg1OUtvbDNwdXZsTEc2WC9CVGhKR2xETnJX?=
 =?utf-8?B?aHdLaTJieEJNb05QTFZ1djcrNFY2aTRVbENybjBWTUxFaDE3SXhXNVJEYm5q?=
 =?utf-8?B?QmxZN2pBRHBTM0l0cURJU0RCOFd1d2ZZRkdjZ245OEVtVVFBSVVqc1U2MlBP?=
 =?utf-8?B?eGpDY0gvYXZIQVJNRzhQeVkwbHh3S3Z4ekl0ZDh2TVpkck5XMTZzWGhyMHJJ?=
 =?utf-8?B?WHFJeVBVb21UbDJ0NmNGMVhyYlhXcC92RWNRWWFNSHFJbzNRYVFvQ25BTnRk?=
 =?utf-8?B?MXQrUlFDUWo2V1QxaEVuZ0dqQXk3dEVVQm13akU1YVZzakdYZnhrM0F2SHFT?=
 =?utf-8?B?cm14aHc4K3JqUDZ1bkJpQm1kUnpha0VZdHZFV1dxMmlFRGZTbTJVdVpLU2kx?=
 =?utf-8?B?UWw3VzRuRkJjWE1weHUxVHJZT3lHNENsWFR4N3E4eStBMlVpUVBoZTFHQlcr?=
 =?utf-8?B?QkZTZzZOZ0Q3YWdWN0MwUlNBRnFWK0E0L2NVTFo2UXlUZ1d3Z0I3NGgwbzNu?=
 =?utf-8?B?dGhFa3l2QkdpUERuY0tzMFE1VVJkVHk1Y3V3Nld0QnROSnR6TU51bzQrMFo0?=
 =?utf-8?B?UlFMOVN2a3lzK3RXREhNSGxWL0YyRURZaXR3T25zL2pRWlB0RUZMUXhZcWd3?=
 =?utf-8?B?aWxOOEdWK0pkY2o4Z2xSNEV5NDRVRHk5ZkRyWks1R3YrR0NyK1djYjk5bVBw?=
 =?utf-8?B?MXlsTERKQmJJOHQwRXpXVDhMSGJ4K08rRHNZOCtaMkdZU0RJSDg1N3RwaGhU?=
 =?utf-8?B?aUlzQS9iMzRCM2F0djFNSG1BL2xlMnZRSVhLbzIvdXhwbzh5OENYUGJ1MG5H?=
 =?utf-8?B?aHhDSWJ6ejNGd2ZlZUhKUEVOdWlBUFRQU2x1ejVSeHpscmV3cUxJcElXQXNK?=
 =?utf-8?B?TkVkbzkzZGdXUFlEYm1VYlQyQy90dlI5a2JoelRCeW5jUjc4N0pvcEFTTFdM?=
 =?utf-8?B?bXc3MEJJK21VK3VDNnNLU1FLdGZHZVN4QjYvdDZUaThGUFdPaGQyYndzSDQw?=
 =?utf-8?B?S2kvcGM2ZWcyWkRLWEpncTlDMXhTMTBMcVBhRFFBRkUrSGtSZjRXd1UvTisx?=
 =?utf-8?B?RFVsRkoxZUVGd1RaWmdRUzk2enpNbUF2NVhSTVpObzRTTi9XODQyVTkrKzVv?=
 =?utf-8?B?cndEczJQdHpmb0k4azZlVkVtT2VuM1RINXFMVmVaV2MzR3o3MEI3ZThTVGN3?=
 =?utf-8?B?RGpWRmZDYnlUamc3ek1aVjZIMHowQWVUdGlBRmJLQXpWQ2xNU0dpODNZRmNn?=
 =?utf-8?B?Sm5oU01Vb1FTU0ZOUGRRd2M4NEk5bWZmQjUvTFBxYkozUTdIcnFEaUE4akha?=
 =?utf-8?B?Qm5VN2tDZHhiditkdVAxS2grbGhjS3hjMWpVRExsTHVzYXRhSTdxRnA2YzBa?=
 =?utf-8?B?TVZsVGxEN2hEZE9SVmRUaEY1WkRwNXdib29xYk5mOVhVakRlNjcvelQ2ZWNF?=
 =?utf-8?B?djFDSXVBQlR6ejNrd0k3R0hyd1pJa2w1Q0N6dWJUakhvNUFnZFpZbWF2VlZS?=
 =?utf-8?B?R2Y4KzdpckMxcTIvbExGeG52dnRnU2JydWlQOGJyUmFoTW5PM1VUSTVsQXgz?=
 =?utf-8?B?RmY3S2lOOElicXpsS0VEZXRsZWl0cXR1NjlSM1JreGpzOFdRTGhlRDZ2SzdZ?=
 =?utf-8?Q?rHpI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cb4341-b8a7-4dcc-20dc-08dbffc3e6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 12:21:45.7360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROUdt9Ndsc8mpT2IJG/NTKAorKE2hPUJwlYeTXS/5EAEO/ml/iJt79QeWHLim4G/ifbPOfQ97Vka/JA6B9xVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFRob3JzdGVuLA0KVGhlIHBh
dGNoIGdvdCBtZXJnZWQgdG8gYnJvb25pZSBnaXQuDQpQbGVhc2UgZmluZCB0aGUgYmVsb3cgbGlu
ayBmb3IgdGhlIGRldGFpbHMuDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9icm9vbmllL3NvdW5kLmdpdC9jb21taXQvc291bmQvc29jL2FtZC9hY3A/aWQ9
Yzk1YTJhMGJlMGIxYmJhMmUwNTFmYWExMDVjMmUwNDAxZmMyZGUzMw0KDQpUaGFua3MsDQpTeWVk
IFNhYmEgS2FyZWVtLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGludXgg
cmVncmVzc2lvbiB0cmFja2luZyAoVGhvcnN0ZW4gTGVlbWh1aXMpIDxyZWdyZXNzaW9uc0BsZWVt
aHVpcy5pbmZvPg0KU2VudDogRnJpZGF5LCBEZWNlbWJlciAxNSwgMjAyMyA0OjQ0IFBNDQpUbzog
U2FiYSBLYXJlZW0sIFN5ZWQgPFN5ZWQuU2FiYUthcmVlbUBhbWQuY29tPjsgYnJvb25pZUBrZXJu
ZWwub3JnOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcNCkNjOiBNdWt1bmRhLCBWaWplbmRh
ciA8VmlqZW5kYXIuTXVrdW5kYUBhbWQuY29tPjsgSGlyZWdvdWRhciwgQmFzYXZhcmFqIDxCYXNh
dmFyYWouSGlyZWdvdWRhckBhbWQuY29tPjsgRG9tbWF0aSwgU3VuaWwta3VtYXIgPFN1bmlsLWt1
bWFyLkRvbW1hdGlAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IEdvbmcsIFJpY2hhcmQgPFJpY2hhcmQuR29uZ0BhbWQuY29tPjsgcG9zdGV1
Y2FAbXV0ZXgub25lOyBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgSmFyb3Ns
YXYgS3lzZWxhIDxwZXJleEBwZXJleC5jej47IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5jb20+
OyBLdW5pbm9yaSBNb3JpbW90byA8a3VuaW5vcmkubW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+OyBO
aWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+OyBVd2UgS2xlaW5lLUvD
tm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPjsgb3BlbiBsaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXgga2VybmVsIHJlZ3Jlc3Npb25zIGxpc3QgPHJl
Z3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSBB
U29DOiBhbWQ6IGFjcDogYWRkIHBtIG9wcyBzdXBwb3J0IGZvciByZW5vaXIgcGxhdGZvcm0NCg0K
SGksIFRob3JzdGVuIGhlcmUsIHRoZSBMaW51eCBrZXJuZWwncyByZWdyZXNzaW9uIHRyYWNrZXIu
IFRvcC1wb3N0aW5nIGZvciBvbmNlLCB0byBtYWtlIHRoaXMgZWFzaWx5IGFjY2Vzc2libGUgdG8g
ZXZlcnlvbmUuDQoNCkRvZXMgYW55b25lIGtub3cgd2hhdCBoYXBwZW5lZCB0byBiZWxvdyBwYXRj
aD8gSXQgYWZhaWNzIHdhcyBtZWFudCB0byBmaXggYSByZWdyZXNzaW9uIHRoYXQgbWFkZSBpdCBp
bnRvIDYuNi4gRm9yIGRldGFpbHMgc2VlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
Lzg3YTV2OHN6aGMuZnNmQG11dGV4Lm9uZS8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
YWM5ZDRmN2ItYzdhZi00ZDIxLWIwYjgtZDBmMTg4Yjk0YjBmQGFtZC5jb20vDQoNCkNpYW8sIFRo
b3JzdGVuICh3ZWFyaW5nIGhpcyAndGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tl
cicgaGF0KQ0KLS0NCkV2ZXJ5dGhpbmcgeW91IHdhbm5hIGtub3cgYWJvdXQgTGludXgga2VybmVs
IHJlZ3Jlc3Npb24gdHJhY2tpbmc6DQpodHRwczovL2xpbnV4LXJlZ3RyYWNraW5nLmxlZW1odWlz
LmluZm8vYWJvdXQvI3RsZHINCklmIEkgZGlkIHNvbWV0aGluZyBzdHVwaWQsIHBsZWFzZSB0ZWxs
IG1lLCBhcyBleHBsYWluZWQgb24gdGhhdCBwYWdlLg0KDQpPbiAxMy4xMS4yMyAxMzozMywgU3ll
ZCBTYWJhIEthcmVlbSB3cm90ZToNCj4gQWRkIHBtIG9wcyBmb3IgcmVub2lyIHBsYXRmb3JtLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTeWVkIFNhYmEgS2FyZWVtIDxTeWVkLlNhYmFLYXJlZW1AYW1k
LmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2MvYW1kL2FjcC9hY3AtcmVub2lyLmMgfCAzOA0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2FtZC9hY3AvYWNwLXJlbm9pci5jDQo+IGIvc291bmQvc29jL2FtZC9hY3AvYWNwLXJlbm9pci5j
IGluZGV4IGE1OTE0ODJhMDcyNi4uODUzOWZiYWNkZjRjDQo+IDEwMDY0NA0KPiAtLS0gYS9zb3Vu
ZC9zb2MvYW1kL2FjcC9hY3AtcmVub2lyLmMNCj4gKysrIGIvc291bmQvc29jL2FtZC9hY3AvYWNw
LXJlbm9pci5jDQo+IEBAIC0yMCw2ICsyMCw3IEBADQo+ICAjaW5jbHVkZSA8c291bmQvc29jLmg+
DQo+ICAjaW5jbHVkZSA8c291bmQvc29jLWRhaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1t
YXBwaW5nLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPg0KPiAgI2luY2x1
ZGUgImFtZC5oIg0KPiAgI2luY2x1ZGUgImFjcC1tYWNoLmgiDQo+IEBAIC0xOTUsNyArMTk2LDEx
IEBAIHN0YXRpYyBpbnQgcmVub2lyX2F1ZGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAgICAgIGRldl9zZXRfZHJ2ZGF0YShkZXYsIGFkYXRhKTsNCj4gICAgICAgYWNw
X2VuYWJsZV9pbnRlcnJ1cHRzKGFkYXRhKTsNCj4gICAgICAgYWNwX3BsYXRmb3JtX3JlZ2lzdGVy
KGRldik7DQo+IC0NCj4gKyAgICAgcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoJnBk
ZXYtPmRldiwgQUNQX1NVU1BFTkRfREVMQVlfTVMpOw0KPiArICAgICBwbV9ydW50aW1lX3VzZV9h
dXRvc3VzcGVuZCgmcGRldi0+ZGV2KTsNCj4gKyAgICAgcG1fcnVudGltZV9tYXJrX2xhc3RfYnVz
eSgmcGRldi0+ZGV2KTsNCj4gKyAgICAgcG1fcnVudGltZV9zZXRfYWN0aXZlKCZwZGV2LT5kZXYp
Ow0KPiArICAgICBwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCj4gICAgICAgcmV0dXJu
IDA7DQo+ICB9DQo+DQo+IEBAIC0yMDgsMTEgKzIxMyw0MiBAQCBzdGF0aWMgdm9pZCByZW5vaXJf
YXVkaW9fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgIGFjcF9w
bGF0Zm9ybV91bnJlZ2lzdGVyKGRldik7DQo+ICB9DQo+DQo+ICtzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIHJuX3BjbV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ICsgICAgIHN0cnVj
dCBhY3BfZGV2X2RhdGEgKmFkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsgICAgIHN0
cnVjdCBhY3Bfc3RyZWFtICpzdHJlYW07DQo+ICsgICAgIHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVh
bSAqc3Vic3RyZWFtOw0KPiArICAgICBzbmRfcGNtX3VmcmFtZXNfdCBidWZfaW5fZnJhbWVzOw0K
PiArICAgICB1NjQgYnVmX3NpemU7DQo+ICsNCj4gKyAgICAgc3Bpbl9sb2NrKCZhZGF0YS0+YWNw
X2xvY2spOw0KPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHN0cmVhbSwgJmFkYXRhLT5zdHJl
YW1fbGlzdCwgbGlzdCkgew0KPiArICAgICAgICAgICAgIHN1YnN0cmVhbSA9IHN0cmVhbS0+c3Vi
c3RyZWFtOw0KPiArICAgICAgICAgICAgIGlmIChzdWJzdHJlYW0gJiYgc3Vic3RyZWFtLT5ydW50
aW1lKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICBidWZfaW5fZnJhbWVzID0gKHN1YnN0cmVh
bS0+cnVudGltZS0+YnVmZmVyX3NpemUpOw0KPiArICAgICAgICAgICAgICAgICAgICAgYnVmX3Np
emUgPSBmcmFtZXNfdG9fYnl0ZXMoc3Vic3RyZWFtLT5ydW50aW1lLCBidWZfaW5fZnJhbWVzKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbmZpZ19wdGVfZm9yX3N0cmVhbShhZGF0YSwgc3Ry
ZWFtKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbmZpZ19hY3BfZG1hKGFkYXRhLCBzdHJl
YW0sIGJ1Zl9zaXplKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChzdHJlYW0tPmRhaV9p
ZCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzdG9yZV9hY3BfaTJzX3BhcmFt
cyhzdWJzdHJlYW0sIGFkYXRhLCBzdHJlYW0pOw0KPiArICAgICAgICAgICAgICAgICAgICAgZWxz
ZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXN0b3JlX2FjcF9wZG1fcGFyYW1z
KHN1YnN0cmVhbSwgYWRhdGEpOw0KPiArICAgICAgICAgICAgIH0NCj4gKyAgICAgfQ0KPiArICAg
ICBzcGluX3VubG9jaygmYWRhdGEtPmFjcF9sb2NrKTsNCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBybl9kbWFfcG1fb3BzID0g
ew0KPiArICAgICBTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhOVUxMLCBybl9wY21fcmVzdW1lKSB9
Ow0KPiArDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciByZW5vaXJfZHJpdmVyID0g
ew0KPiAgICAgICAucHJvYmUgPSByZW5vaXJfYXVkaW9fcHJvYmUsDQo+ICAgICAgIC5yZW1vdmVf
bmV3ID0gcmVub2lyX2F1ZGlvX3JlbW92ZSwNCj4gICAgICAgLmRyaXZlciA9IHsNCj4gICAgICAg
ICAgICAgICAubmFtZSA9ICJhY3BfYXNvY19yZW5vaXIiLA0KPiArICAgICAgICAgICAgIC5wbSA9
ICZybl9kbWFfcG1fb3BzLA0KPiAgICAgICB9LA0KPiAgfTsNCj4NCg==

