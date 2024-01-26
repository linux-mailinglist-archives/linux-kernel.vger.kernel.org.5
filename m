Return-Path: <linux-kernel+bounces-39868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85983D6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29221C2D761
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AE53E33;
	Fri, 26 Jan 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m9Mo0yzA"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E701B7FC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259647; cv=fail; b=C59NW3tHpyFc7tQNNwhN1w+7GuEw5tleQ9wGyLu3qdVWcF7EyAfNScAdI8g58xkaFTP9EYqV2UTOlVC/a/k2paIHN2b7Ep30T6B3hr3tWGt+QerAM2tlMKp5pNCBJlKogvxEq1J5MwYoeuCoFL2nLn4FjRv0MB97eJ+8rrUMn8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259647; c=relaxed/simple;
	bh=zEaqi7eqI2V0OKMM1z2TeAYUGmJTBpwyMbY3iYsdPCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Da5DT7zSyDzavjKG/mLBctRKVfdug7B43P0fmful3bdh4ROiZRmb/BEGgI/1pO7Q90gsVQgzvmYLRnz6X0GeVsSdUF09Etjt4887sXOqXlHZdWyTxTS+LkNMAFeZLkx6H769u/x5feXXzSfOgVuMzCz5bg0C+3Tic+JVlqwTjUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m9Mo0yzA; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRniQjwlz7dl+6v9v3K9F/MwVVbbpO++/yWCA3wnRh5Ztxm+NWXM9fK9KPvQ8pcqZ12n+ViUFZ8AdzyY0+7WQ60rUf2cYAgL1Y4gXTa9+rIAFIDJmDA+OhquROEEVus/SpeNCunzn0OJdJ6aHPxmmEErLyQ/lUJwfaqLHEzydG6hJpeuJDw7RkucOBOIOsGwZmtiK9MxoRKP9M4/aPQsMcWnhRLy96yycG2wIQh1Bwkd0yYogz6DI0V0d24piQrk/CrfyuEy2LiJbyAdzXoDXbrpKBJidDqQZzLeQHFZIrSMFAXOnEpN5eMo+mZDSCVp3Nm1uRA6l4lF0OZj5u74mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEaqi7eqI2V0OKMM1z2TeAYUGmJTBpwyMbY3iYsdPCA=;
 b=ZB08L5GgbW5N8UHaMFL91lud8z6k66bFe+wGpze/6fiOLPpu6xYvn9N86MX1/eh9X3Nq18/H5C1ZrT0KqNVemGSQRaK8Ty2OyjbSnZLu8+GFDE/I8Bwmz6sLv6PWdfzJ+UItzrCYqqr6FyGEMIaFrJ9pMT4N0IX5stzjq+8/y32fxwDb9dlFMo74jPm9Mzn5vsUDKcTquz4RsnfPkNBYkoieczRcKhxdhBbty1HmzsxTDjNIffIrZhr1c9if+j97/uHKh/GSxwaWjGZHkykyRXZpymWHe2DiGxjuBcLcPfgQKD/dcZC7wqZI2H7fLGAMUIGaLlu4/Tf3SapiEoCRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEaqi7eqI2V0OKMM1z2TeAYUGmJTBpwyMbY3iYsdPCA=;
 b=m9Mo0yzAYylxDggQnuZupMwyfC407a46bS0craSfxtR6djAkmfBaLRev98OzrevRk4jw/bHpEeQ90OwAlDAk35AUyucsGZTqxvfA7AvwKd5At4A+MjDtX8y/r26GnwjPT92Ql4YOB0h8rzoLJRTl7QVBs6nFFzSB/4CEp+c+03c=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 09:00:39 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 09:00:39 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Saravana Kannan <saravanak@google.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>
Subject: RE: [EXT] Re: [PATCH] driver core: improve cycle detection on fwnode
 graph
Thread-Topic: [EXT] Re: [PATCH] driver core: improve cycle detection on fwnode
 graph
Thread-Index: AQHaTqDvNrxLtETMdkWiNcCVNGg5zbDp1rEAgAAIJ3CAAX0XgIAAGiaw
Date: Fri, 26 Jan 2024 09:00:39 +0000
Message-ID:
 <DU2PR04MB8822693748725F85DC0CB86C8C792@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240124084636.1415652-1-xu.yang_2@nxp.com>
 <CAGETcx9h8gA8EenyR0B0OPa23uw_8dk-Kft8c8+F3StfpyMtaw@mail.gmail.com>
 <DU2PR04MB8822047A07680596415A61358C7A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
 <CAGETcx8HeseChCoOzOkUNf_LyXbVqgyisuHy_9U=PcP74NwV4A@mail.gmail.com>
In-Reply-To:
 <CAGETcx8HeseChCoOzOkUNf_LyXbVqgyisuHy_9U=PcP74NwV4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PAWPR04MB9813:EE_
x-ms-office365-filtering-correlation-id: 4ead9fba-3691-4156-0237-08dc1e4d4497
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NMtPVIYAQ2hfXXJI/H/l+b+Ub3yezQf3kV8qSG7llEzARrl+VaLTftUKLt9yrXLEh46t6eN5XQybnaOlDml+0DjfVTfG10Npc3gDR0elo0osScQaaFbzcm6RanyxPtoGh40jPSprQTtZpBSBDpBmvYvudN729QpNHUsBiU9VFp/jTtuJz/Og8JMyQVo4zLTRLiHUjdv9k4+wpR8H3O0/m/qkP/U5SokpgloUvLpbTXU7egv91Xh0ipaHS9QytTzds4n+oV7kh3h0TBsfq/WeD8tG7NjwduntZE7elBGd1rHMk/tYVKxAeg6tqsSYyX43t+LfsS+zCmeqvR/tpkn92h4zfoYOo6ERuWg9GAJNEkMKQYXkiuQAv+tSU/WL+FgZOyjJ2CBTf/bg6KKfeyEDAVvugwp5cYnYExx/BkV0I6mWYCMtOqqAfK0UGlNkARkOeMYfEdi3dUrmmL+vD2uZhPuy3ZY+XttFcVPYBGBHIuf6Ljdk7YjPTwn1CalBbSWzrHUb7Ra7MG7+OmkXgQKjUgPGM6niU9HJCXKNcv11dWrISDiXkoLBiEq03hRrpLeCn7hWGRB6RnhRWC//lMPJQIpz0S0A1TxYF3JcuSdEyBOQklVQV5K3rAn7dh88NVSa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(26005)(55016003)(5930299018)(966005)(38070700009)(316002)(6916009)(7696005)(6506007)(478600001)(53546011)(83380400001)(71200400001)(9686003)(38100700002)(122000001)(54906003)(64756008)(5660300002)(76116006)(66476007)(66446008)(66946007)(66556008)(86362001)(33656002)(2906002)(8676002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmR2K0JRdjBSdVk3dmNuQ3NFMDlNVXpWbTd5ZURxU01BZ2FUVUNYTXJVSm8v?=
 =?utf-8?B?dlg2TWg5RUJMSnMyalBNbWQ2MHFwN3BVY1dzck16dGttcGtEbEVGbmtOQkdl?=
 =?utf-8?B?UnE2MERkNmd4SWtQTlAydFVaQ1RkWTcydDZEdUNDZlMvTGQ1eGxadVVFMnVG?=
 =?utf-8?B?KzBES2pJZnNHSEdYeDNlbEQ2OFdNOFdzSFJNTS9lYUNYeUZsRyt6aDl4aUtL?=
 =?utf-8?B?NmFFR3FjUjVwcDdrb2dzZ0N3T01aRDFOT21hS1lPcExYbGpEWkg1VzQreEZp?=
 =?utf-8?B?dFhGVS9Qdi9HcTVpSlU1QVlocVcyYzc3TDFYalBlWjdxL1Y5N255VEx4ejNE?=
 =?utf-8?B?cGV3ZlVNcWRyeGdqSVdVNkVOSUsrOFBHemV0SlRIQ2U4VnVtZ2ErY2wxNHAr?=
 =?utf-8?B?ZnlDSkVsdEhPN2RQZG1UODRrdHhDcFUrKy9RUkZ2eEJuVVZYbVVxNWxramIz?=
 =?utf-8?B?VFZuSkdBOE5YRjNOL3lOWmtiUXB4bndoMWJsMmxMQk9HK3VyK2FsRXFIZUFr?=
 =?utf-8?B?NGszbVM2QTRLMm9saW1yZjcvUFVvejNBRUNuVEtQaGEzRXhtWWdHRittQ3lv?=
 =?utf-8?B?cGpvcXhnQlU0emFmOEx1NnVDckxZQTRNL1JSTUdwM0loZXdmOHY0UURXUC9n?=
 =?utf-8?B?UUYvdGNoT0ZCelVQS1hnOFNsMG5yYnFVNW5OREt2dk1GcGNjaE1NaFZWdHRm?=
 =?utf-8?B?Z2VSTERaWGlIVDVyeE5xcFBubkVrbnNCQnRpUnNpYkZPa3Zha1NYVm1wUmJR?=
 =?utf-8?B?UDlPS01hbTBPR3lVMmFOVzV2clJjUjJ2bTAzMm9uK3NwN21rNTdDb2w0SWd5?=
 =?utf-8?B?ZU1EdSthNmlobEt2YmtXcUYzeVd2OW8vYWc2OU5idHVYMjgwZkpjNjJzcUVz?=
 =?utf-8?B?SE81S1MyckRlUndHeGZud2h3Mlo3bERDUGV4TzJwTUJsSTUzYVE0WGdxOFpI?=
 =?utf-8?B?b2UvUXUzdVFIb0NNdmlRQjAzcDlZdUdHYXp4NWFJUUhOOGdDdDFPelNhQVVm?=
 =?utf-8?B?WmwxM2l2TTRkcjg5bFdlVGM5OFQ3eE5US1RuR2duR3hpaDRmMDVFMVVIWlZW?=
 =?utf-8?B?Z2FOaEZyWURUdFpJcUVQem9GcTBGUUVrYVptTWFhVkVJK0psNitQbE9Oei9G?=
 =?utf-8?B?by94Z2dqQkxNdm5sbUtQS21qUXlEQ1pScW9sV1FRaXRmcFVnRTE1dVJqcDlo?=
 =?utf-8?B?ZXhJbDhGZTlFZW9PbERxVktzeURFMUtuY3NKck5ucjlBMThhUTlVb1ozVzhm?=
 =?utf-8?B?K1E3aWlxcnFQdzhNbDJyRmJZSkJhZEJMTzhOMElxT05Xa0U2UU5WZ0F1RlBy?=
 =?utf-8?B?aUEvRUZ5L1ludFZEbzhkbE8ybG5OcFdBTTFUWXh5Qlk0Q0lkdGt0NkY4bmNR?=
 =?utf-8?B?eGxDMEVxT053a2xyRkJ3dEViRVdEVUV1UitCSmtXYzB6ekcvbTBSdGFKUnkw?=
 =?utf-8?B?SjJTRithdDlOdkFWU0Vhc3F3OWVYS3VpaTFxSWdHejVWY1JYT21YVGdzdmhs?=
 =?utf-8?B?cEFhMHJQQzVydkVZckE1WnJBR21obU40bjFHeGJOVmphSU9UMTl3cmhvdXRh?=
 =?utf-8?B?RTRxdUR3TEg3bldwaTJqRzRvOVoyTmp2T1l4ck5UZ3RDMEx4dGkwYVFCOUhz?=
 =?utf-8?B?UnNJMGRiUG5PTTlaTXRraUdPVmExbHd3NTRCRHJPVDNOSk1PdHVjY1Q5WjFC?=
 =?utf-8?B?OWhuU1hob3pjMnVSZlJVVjRBU2VLeXFQczlpS2MxN1dWb3U2dk96WEtLOVBZ?=
 =?utf-8?B?SGk4QzcxZ2pvMGhvQVFTVlY1cFMrQXBHT1duNWxmVGk2MVJxc2dUZS9oZW4y?=
 =?utf-8?B?NWpKYmp2ZnYrV0Fja1F0V204RDZUb0NKcktKR2pudy9TZWxBTDhyTlBBUmZS?=
 =?utf-8?B?SVMzZ1AwQUh0SVh0d0xFUkpCdDVUcDcvWWp0R0U5MVoyR3JVa0l0aDJkemxO?=
 =?utf-8?B?T1ZqQlphcklJZ2FKUHZxbHd3K3pZdXhPSitmQVFvbmFla0MvQklWK1pVOUlo?=
 =?utf-8?B?WkpHZHNuSWdVdzd2Ry9kT0ZaZkJLWnFkWHp4UDgyQWVLN1lEVW5iZjdqcS9l?=
 =?utf-8?B?S2lpNjc0cEZKeWZ2MjRGa2ptNGRTZmtyazN2V3Zhb1dGNUljQlNPSkVFdkVS?=
 =?utf-8?Q?bg78=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ead9fba-3691-4156-0237-08dc1e4d4497
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 09:00:39.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8sbby6VpTtexFIxSbfv3IGJ5VmNx408pruF2UDTmzXbuWOr69zqqPpJ1lW5VYM1baSpDzK6XiOZo58LCJYR0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813

SGkgU2FyYXZhbmEsDQoNCj4gDQo+IE9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDg6MjHigK9QTSBY
dSBZYW5nIDx4dS55YW5nXzJAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gSSB0aGluayBteSBjb25m
dXNpb24gd2FzIGJlY2F1c2UgeW91IHVzZSAtLS0tPiBpbiB0aGUgb3Bwb3NpdGUgd2F5IHRvDQo+
IHdoYXQgSSBoYXZlIHVzZWQgZm9yIGFsbCBteSBmd19kZXZsaW5rIGFuZCBjeWNsZSBkZXRlY3Rp
b24gcGF0Y2hlcy4NCg0KT2theSwgSSB3aWxsIGZvbGxvdyB0aGUgdXNhZ2Ugb2YgIi0tPiIgbGF0
ZXIgYXMgeW91cnMuDQoNCj4gDQo+IFRoZSBwYXJ0IEkgd2FzIHJlZmVycmluZyB0byBpcyByZWxh
dGVkIHRvIGhvdyBkcml2ZXIvb2YvcHJvcGVydHkuYyBoYXMNCj4gbm9kZV9ub3RfZGV2IHNldCB0
byB0cnVlIGZvciBwYXNyc2VfcmVtb3RlX2VuZHBvaW50Lg0KPiANCj4gPiA+DQo+ID4gPiA0LiBI
YXMgdGhpcyBhY3R1YWxseSBjYXVzZWQgYW4gaXNzdWU/IElmIHNvLCB3aGF0IGlzIGl0PyBBbmQg
Z2l2ZSBtZQ0KPiA+ID4gYW4gZXhhbXBsZSBpbiBhbiB1cHN0cmVhbSBEVC4NCj4gPg0KPiA+IFll
cywgdGhlcmUgYXJlIHR3byBjeWNsZXMgKEIuRVAtPkEtPkMtPkIgYW5kIEIuRVAtPkEvQS5FUC0+
QikgaW4gYWJvdmUNCj4gPiBleGFtcGxlLiBCdXQgb25seSBvbmUgY3ljbGUgKEIuRVAtPkEtPkMt
PkIpIGlzIHJlY29nbml6ZWQuDQo+ID4NCj4gPiBNeSByZWFsIGNhc2UgYXMgYmVsb3c6DQo+IA0K
PiBJIHRoaW5rIHlvdSBzdGlsbCBtaXNzZWQgc29tZSBkZXRhaWxzIGJlY2F1c2UgdXNiM19waHkw
IHNlZW1zDQoNCk9uZSBsaW5lIGlzIGluZGVlZCBtaXNzaW5nIGluIHVzYjNfcGh5MC4NCg0KPiBp
cnJlbGV2YW50IGhlcmUuIENhbiB5b3UganVzdCBwb2ludCBtZSB0byB0aGUgZHRzIChub3QgZHRz
aSkgZmlsZSBmb3INCj4gdGhpcyBwbGF0Zm9ybSBpbiB0aGUga2VybmVsIHRyZWU/DQoNClRoaXMg
cGFydHMgb2YgZHRzIGlzIG5vdCBpbiB1cHN0cmVhbSBrZXJuZWwgdHJlZSBkdWUgdG8gc29tZSBy
ZWFzb25zLg0KQWxsb3cgbWUgdG8gc2hvdyB0aGUgbmVjZXNzYXJ5IHBhcnRzIGFzIGJlbG93IGFn
YWluLCB5b3UgY2FuIGFsc28NCmdldCB0aGUgZnVsbCBkdHMgZmlsZSBmcm9tIHRoZSBsaW5rIEkg
YXR0YWNoZWQgYmVsb3c6DQoNCi0tLQ0KcHRuNTExMDogdGNwY0A1MCB7DQogICAgY29tcGF0aWJs
ZSA9ICJueHAscHRuNTExMCI7DQogICAgLi4uDQoNCiAgICBwb3J0IHsNCiAgICAgICAgdHlwZWNf
ZHJfc3c6IGVuZHBvaW50IHsNCiAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmdXNiM19k
cmRfc3c+Ow0KICAgICAgICB9Ow0KICAgIH07DQp9Ow0KDQp1c2JfZHdjM18wOiB1c2JAMzgxMDAw
MDAgew0KICAgIGNvbXBhdGlibGUgPSAic25wcyxkd2MzIjsNCiAgICBwaHlzID0gPCZ1c2IzX3Bo
eTA+LCA8JnVzYjNfcGh5MD47DQogICAgLi4uDQoNCiAgICBwb3J0IHsNCiAgICAgICAgdXNiM19k
cmRfc3c6IGVuZHBvaW50IHsNCiAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmdHlwZWNf
ZHJfc3c+Ow0KICAgICAgICB9Ow0KICAgIH07DQp9Ow0KDQp1c2IzX3BoeTA6IHVzYi1waHlAMzgx
ZjAwNDAgew0KICAgIGNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC11c2ItcGh5IjsNCiAgICB2YnVz
LXBvd2VyLXN1cHBseSA9IDwmcHRuNTExMD47DQoNCiAgICAuLi4NCn07DQoNCj4gQWxzbywgY2Fu
IHlvdSBjaGFuZ2UgYWxsIHRoZSBwcl9kZWJ1ZyBhbmQgZGV2X2RiZyBpbg0KPiBkcml2ZXJzL2Jh
c2UvY29yZS5jIHRvIHRoZWlyIGluZm8gZXF1aXZhbGVudCBhbmQgYm9vdCB1cCB0aGUgc3lzdGVt
DQo+IGFuZCBnaXZlIG1lIHRoZSBsb2dzPyBUaGF0J2xsIGJlIGEgbG90IGVhc2llciBmb3IgbWUg
dG8gdW5kZXJzdGFuZA0KPiB5b3VyIGNhc2UuDQoNClRoYW5rIHlvdSBmb3Igd2lsbGluZyB0byBk
ZWJ1ZyB0aGlzIGlzc3VlLg0KVGhlIGJvb3QgbG9nIGFuZCBkdHMgZmlsZSBpcyB1bmRlcjogDQpo
dHRwczovL2RyaXZlLmdvb2dsZS5jb20vZHJpdmUvZm9sZGVycy8xaGxremcwNDJxNV9iNWw1OURD
VzJwRUNYUm1USDRWeV8/dXNwPXNoYXJpbmcNCg0KPiANCj4gU28gbGV0J3Mgc2F5IEkgc2VlIHlv
dXIgbG9ncyBhbmQgd2hhdCB5b3Ugc2F5IGlzIHRydWUsIGJ1dCB5b3Ugc3RpbGwNCj4gYXJlbid0
IHRlbGxpbmcgbWUgd2hhdCdzIHRoZSBwcm9ibGVtIHlvdSBoYXZlIGJlY2F1c2Ugb2YgdGhpcw0K
PiBpbmNvcnJlY3QgY3ljbGUgZGV0ZWN0aW9uLiBXaGF0J3MgYnJlYWtpbmc/IElzIHNvbWV0aGlu
ZyBub3QgYWxsb3dlZA0KPiB0byBwcm9iZT8gSWYgc28sIHdoaWNoIG9uZT8gV2hhdCdzIHN1cHBv
c2VkIHRvIGJlIHRoZSByaWdodCBvcmRlciBvZg0KPiBwcm9iZXM/DQo+IA0KDQpMZXQgbWUgZGVz
Y3JpYmUgdGhlIGlzc3VlIGFnYWluIGJhc2VkIG9uIGFib3ZlIGxvZyBhbmQgZHRzOg0KDQogICAg
ICAgICAgICAgICAgICAgIHVzYg0KICAgICAgICAgICAgICAgICAgKy0tLS0tKw0KICAgdGNwYyAg
ICAgICAgICAgfCAgICAgfA0KICArLS0tLS0rICAgICAgICAgfCAgKy0tfA0KICB8ICAgICB8LS0t
LS0tLS0tLS0+fEVQfA0KICB8LS0rICB8ICAgICAgICAgfCAgKy0tfA0KICB8RVB8PC0tLS0tLS0t
LS0tfCAgICAgfA0KICB8LS0rICB8ICAgICAgICAgfCAgQiAgfA0KICB8ICAgICB8ICAgICAgICAg
Ky0tLS0tKw0KICB8ICBBICB8ICAgICAgICAgICAgfA0KICArLS0tLS0rICAgICAgICAgICAgfA0K
ICAgICBeICAgICArLS0tLS0rICAgfA0KICAgICB8ICAgICB8ICAgICB8ICAgfA0KICAgICArLS0t
LS18ICBDICB8PC0tKw0KICAgICAgICAgICB8ICAgICB8DQogICAgICAgICAgICstLS0tLSsNCiAg
ICAgICAgICAgdXNiLXBoeQ0KDQpOb2RlIEEgKHRjcGMpIHdpbGwgYmUgcG9wdWxhdGVkIGFzIGRl
dmljZSAxLTAwNTAuDQpOb2RlIEIgKHVzYikgd2lsbCBiZSBwb3B1bGF0ZWQgYXMgZGV2aWNlIDM4
MTAwMDAwLnVzYi4NCk5vZGUgQyAodXNiLXBoeSkgd2lsbCBiZSBwb3B1bGF0ZWQgYXMgZGV2aWNl
IDM4MWYwMDQwLnVzYi1waHkuDQoNCjEuIE5vZGUgQyBpcyBwb3B1bGF0ZWQgYXMgZGV2aWNlIEMu
IEJ1dCBub2RlcyBBIGFuZCBCIGFyZSBzdGlsbCBub3QNCiAgIHBvcHVsYXRlZC4gV2hlbiBkbyBj
eWNsZSBkZXRlY3Rpb24gd2l0aCBkZXZpY2UgQywgbm8gY3ljbGUgaXMgZm91bmQuDQoyLiBOb2Rl
IEIgaXMgcG9wdWxhdGVkIGFzIGRldmljZSBCLiBXaGVuIGRvIGN5Y2xlIGRldGVjdGlvbiB3aXRo
IGRldmljZQ0KICAgQiwgaXQgZm91bmQgYSBmd25vZGUgbGluayBjeWNsZSBCLS0+Qy0tPkEtLT5C
LkVQLiBUaGVuLCBmd25vZGUgbGluaw0KICAgQS0tPkIuRVAsIEMtLT5BIGFuZCBCLS0+QyBhcmUg
bWFya2VkIGFzIGN5Y2xlLiBUaGUgZndub2RlIGxpbmsgQi0tPkMNCiAgIGlzIGNvbnZlcnRlZCB0
byBkZXZpY2UgbGluayB0b28uDQozLiBOb2RlIEEgaXMgcG9wdWxhdGVkIGFzIGRldmljZSBBLiBX
aGVuIGRvIGN5Y2xlIGRldGVjdGlvbiB3aXRoIGRldmljZQ0KICAgQSwgaXQgZmluZCBDLS0+QSBp
cyBtYXJrZWQgYXMgY3ljbGUgYW5kIGNvbnZlcnQgaXQgdG8gZGV2aWNlIGxpbmsuIEl0DQogICBh
bHNvIGZpbmQgQS0tPkIuRVAgaXMgbWFya2VkIGFzIGN5Y2xlIGJ1dCB3aWxsIG5vdCBjb252ZXJ0
IGl0IHRvIGRldmljZQ0KICAgbGluayBzaW5jZSBub2RlIEIuRVAgaXMgbm90IGEgZGV2aWNlLg0K
DQpGaW5hbGx5LCBmd25vZGUgbGluayBCLS0+QyBhbmQgQy0tPkEgaXMgcmVtb3ZlZCwgQS0tPkIu
RVAgaXMgb25seSBtYXJrZWQNCmFzIGN5Y2xlIGFuZCBCLS0+QS5FUCBpcyBuZWl0aGVyIGJlZW4g
bWFya2VkIGFzIGN5Y2xlIG5vciByZW1vdmVkLg0KDQpTbyB0aGVyZSBhcmUgMiBjeWNsZXMgYW5k
IG9ubHkgdGhlIGZpcnN0IGN5Y2xlIGlzIGRldGVjdGVkLg0KMS4gQi0tPkMtLT5BLS0+Qi5FUC0t
Qg0KMi4gQi0tPkEuRVAtLUEtLT5CLkVQLS1CDQoNCkluIHRoZSBlbmQsIGRldmljZSAzODEwMDAw
MC51c2IgKG5vZGUgQikgaXMgZGVmZXJlZCBwcm9iZSBkdWUgdG8gbm9kZSBCDQpzdGlsbCBoYXMg
YSBzdXBwbGllciBub2RlIEEuRVAuIA0KRGV2aWNlIDEtMDA1MCAobm9kZSBBKSBpcyBhbHNvIGRl
ZmVyZWQgcHJvYmUgZHVlIHRvIGl0IGRlcGVuZHMgb24gb25lIGRldmljZQ0Kd2hpY2ggaXMgY3Jl
YXRlZCBieSAzODEwMDAwMC51c2IuDQoNClRoZSBub3JtYWwgYmVoYXZpb3IgaXMgYWxsIG9mIHRo
ZSBkZXZpY2VzIGNhbiBiZSBzdWNjZXNzZnVsbHkgcHJvYmVkIGFmdGVyIHR3bw0KY3ljbGVzIGFy
ZSBkZXRlY3RlZC4NCg0KVGhhbmtzLA0KWHUgWWFuZw0KDQoNCg==

