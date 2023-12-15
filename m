Return-Path: <linux-kernel+bounces-826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879538146BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F86C284190
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D428250E6;
	Fri, 15 Dec 2023 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SCd44z9T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225825564;
	Fri, 15 Dec 2023 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtutqEtg8ZzX3xIBYrwJUoN9Dy401jMJfUkrhJmahk160vF5DwpRAS38IZGpdUeneL8RBK5cGN0ZCfvH+yM1Jf1ObLmekq+KlUN7+MzKBKUV/PJP4EvODoX2coZbnQpLiLEmUCx1K4/ryY+qZFqJk/ZAz5yrb9GDpAwRLhrwODudQ8XiycR76DvdFW4hud8OY3oIeIQKgPKgQBgcr5kLp4iYyfYD9s/JM0YVtP0x2ff25LTGz4iVF5z/HTr/lEo5covB/8PoRmFmVIjdPMJX4cum83xrsPyoxjELbgG/bhjFVSz2eQW2Ua6hhxRjt4nM0nFOmXI25dnBVeh0Fw0KGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94cy1d42LwDp1V3sIq4TDavurB97LUabmdMDHjRakC0=;
 b=bDcK/qiNZ3j6zhFgFeUPs3TJLoGePcDWOYNb8ySh0RVzaFHDg6cv+nHCmLufoZ+ESbFJIRX1aYLJzm+g61UhCIxfXdCW3lSIdfrPK25Wi9W1w/1pcKfEFoNumoEoPSRgaMDUKocC99T/rWeLyXdGNpzbqGxHWWrtEmOB5NzxKqbAz49Z4dftwrfmwLglL+voOEOwPXV+x2IKaOEtkKe6dEu602B1PCKUrzMPNxRczwa4Kt9BWC9W+AsY602GAt0lJKYpp0dkBX9QFsV4UnOdYBXCWY0toY/DQchq6PFAcT20V5kcKPYZ+czbiC8uTHN+aOgUb6/XrAeVHXFHj252tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94cy1d42LwDp1V3sIq4TDavurB97LUabmdMDHjRakC0=;
 b=SCd44z9T+Ro9OjEHI0m9WEtpe54Kefj+Ad6S763c9VcFaB5Lg3o28WScV5HY5AzQWXRxclPFDGqVYmwiGs1hthfCxhcfYArC+GLRHo6EPfDbd5qO/R0NGkXmAoj6z5zpWEZBtfjXSri3MCf5XOaIrhlTTjhuFvk7n5SEdsA3lLU=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 11:20:55 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 11:20:55 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael@walle.cc" <michael@walle.cc>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index:
 AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAIABtmWAgAQ4ECCAAAuVAIAAD5dQgAAYdQCAAAF/8A==
Date: Fri, 15 Dec 2023 11:20:55 +0000
Message-ID:
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
In-Reply-To: <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|PH0PR12MB8821:EE_
x-ms-office365-filtering-correlation-id: bf8119ce-9021-4ca7-b31e-08dbfd5fe79e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yQgcRgF8EaQqh3pewhNxLOTi1Rwz2Za/MMGQlOxZZZEf9Nc9lVLRbey5ch1DP+xrODro2wLQtNGjORzBdc0EItMbX8jihY/KwAFmJcGt9e2Y3FLDwgCbsWaILKiJjTJuph7hCpFWDc9IriDHTn075zq9aMxRa+ifIkaXjHseclx9LR+1MlJYVJevZGdSFBEAfSjV0Vf1QkIgpJ5cG0MJlCF2n5MsPSv9yVmFK68/AzpUia/bCexc1b/Dj7ki+mrNLXPM5fMQYZdsRjK2mmO28tV0Ty8QPPsz+VG+I3Cn9QDCFm18saVtObJor1MFmmpQSs98BH++FO8MTpjFKPArfPXjygW0lWQ25jpahJKo9TdY3bwKPo88iXA/N6XDf8Yfke8CZ9M5PzIzxgi/ztTp9D5PNqzXJ+tX3IeoBDUhnfM82N8k7wQApXhaZlo/TIVqzMv5EJ/wj9pyCpRn2EI2mKAHuGVh12f4vpgiOkLT0vx5eSTIHrMFVOqaAFoeqtGguMTShWOXtRauBJVpdR/Br4ojFKynYIidsnfKch1KC+RRm59kCN6V6fygI8HvsOcRZn05/JXDrC63cOY3vx/ivOFDBuEtPOXNTEIvhSofVdCv662lKHGZ1nawYgjV8/oP67yCfJydGDkeQMO7WKRtJA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(33656002)(4326008)(8676002)(8936002)(52536014)(86362001)(5660300002)(7416002)(38070700009)(921008)(41300700001)(53546011)(26005)(9686003)(55016003)(83380400001)(478600001)(6506007)(7696005)(71200400001)(38100700002)(122000001)(110136005)(76116006)(66446008)(54906003)(66476007)(64756008)(66946007)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW1aaklqYzlDTjZVSHFtL3l1Ym5keGg3ZS94d0d5a0paSzRoNGt0azFIR2dr?=
 =?utf-8?B?aldlVTYzdlcxc3lRbWtXWjNXUzUxaENDVVg1OE50a1ViRnhzd1pxVGpoR2Rr?=
 =?utf-8?B?QVpvQjVaM3dqWGNKS2NXMXNpTjJmQXE4NXE4eDN2Z1VSbmxMR1ZuWFBZbVBW?=
 =?utf-8?B?M2VFR0FvZ2RwTk5SL0xMaDVGL3RPVnpqWUd2V0VTUjFvS3FRamdrVGJtVFgz?=
 =?utf-8?B?cUNwMWpaWWtwNHZZSFQvVUxXZWxMQ0V1UmdBNnpMNjNDMG91dHBwR1JFMzJU?=
 =?utf-8?B?OVRBdkIxY01mYzBQa3dsV1VNNFpjUFMvdWFTNnEvU25ta1RJV3RaTUFET2t1?=
 =?utf-8?B?cFpMRUxzN0JNa1p1U0lkbTVVMEJxTTE0TWQvVU9rd04wRDF3Vjc4THR6V0RF?=
 =?utf-8?B?UlJmRUdjcFBsb1ZXNDNIMEY4Tk8wV2dFMUpsc3U5MGY1b1phcUVHeGF6Nmxt?=
 =?utf-8?B?ZS9SdXZxcm9mUWN2U1VTc3BIVUw1Y3Q1a2s4amhvZjJkUTl3ZUgwcUZMcXQ5?=
 =?utf-8?B?cUpMV2wzdkYzdEtNUWY3K3FWaStNcWM5aW1Pa3ByaWs5blZtSi9WRnIwbmtm?=
 =?utf-8?B?SXpycE1BQVhsVDdjaHlBZzRBVFVDL1Iyaml5dmNoeWtCOG1yaWJpUWx4WUFX?=
 =?utf-8?B?R2t5QWU5VjEvekZBYUdlZDNjSTQ2TFNwaU8rWGJMcEh3RUZxVnFNWm9IYzBP?=
 =?utf-8?B?TUJ5ZGN1MkI0dmlYTWZUbzdYd0FmbzNkN0hwZmlkWWYrMlVqVUx3TkhGYXBn?=
 =?utf-8?B?NFJaOTdqZ2NEQjR0WWU0VTZhMkdKcXNPVlI2NWY3bVV4VlRhVEhUMlRHenJq?=
 =?utf-8?B?SkNPaWx5aXZRRzRCREt6Rkg3c1NPUVRZWDZpYlhTeHVSQ3JVSHNGR3pIbWVw?=
 =?utf-8?B?RWt6T3BuK0U2cFBvUDlsTGQxcGUxSlZlRlVDOWhFWTFLT0hKQTR1aHY5TkVE?=
 =?utf-8?B?NFRUSis0RU1IQy9wQ3F5RHU5OVZESjh1ckE2ekZFWGl2aHZJYllaalExTytu?=
 =?utf-8?B?YWdlcXF6b24ralNiSVZTTnpNbEs0eXBGYUZVOXdKWlZDK0tZU29WUjdjSTBh?=
 =?utf-8?B?OGF0TFVlcVUvTS84MlJ3UlBCRUlReE9wOEV0Vks5UHY2UlRjRlErZ1FHbVFo?=
 =?utf-8?B?aVVvaTVvVUVzSFRsOU9oVmpXbGt2eURmY0M5ZUlmRFFOUjJxVzFLekJFSzR6?=
 =?utf-8?B?emloVG1hcUdNSjg2Vkxxb1lYbEwxb3YwMmdXK2p6elo0Yys3RVVxdkNiTDIv?=
 =?utf-8?B?Smx5bzhjR3JYR3U2aTY4UlVXaG9RNFgyd0FxNWxzdHpTS1BRdklHRFBYRmFt?=
 =?utf-8?B?TzR6dG5NQnhkaC9pbjB5eEszUVRpR2hocUphS2I1RE9jTmFQVWxLeWlFS2Jo?=
 =?utf-8?B?a0RaazNmWDArNXRtRnZEOFhiQXVXUGVvb2t1TUR6TldQOE1KYXNFVGx5MXlR?=
 =?utf-8?B?UDQxUkplZFB2OGsrczVNUk5JQjVKRUlyM2dMVE9sakE3aGltZWFxenRxd0p2?=
 =?utf-8?B?TE9PMy8wdldmOEQvU2Y3QkczaXZ0NXQ1QmhNdGVrMjJxUm13MFU4OG5Vak4w?=
 =?utf-8?B?bHhGd1NTOGxrbG1URGlydnNMejFrcTNmK2dlN0tJYThYUExVWjRNdlU5dy9u?=
 =?utf-8?B?TjVsM2cxKzZoQmdvb0lrMTdjajdDMXJ2TFR4SnNpNnJIK3BGbW5iTHluWWpq?=
 =?utf-8?B?TlB5TjRubmNKL1FNUmV0NDkxM0kvNytiY283a1hoWStCOXVsRDF2Z1doRXdR?=
 =?utf-8?B?aG9OR2h1Q3hyU2RTRG1TVkgzY1NIL2NEbEZpb1pUQXF4UU5tc2cvVFBoMXZF?=
 =?utf-8?B?RlpGN1A3U3Z6aGFYaitiSXE3d3Q5MlNWeUU4WFlWMi94K3pkVkV3SGtXekND?=
 =?utf-8?B?Mmp6UGlXZXExamVLZklFMnBTYkp5QXdySTJWWlVzblNXVUp2QlhTU3ZYek9l?=
 =?utf-8?B?d0ROMldaakhFM3QrZWJ5U0xwSGw4SDFJVFlmaVEwTmNWcUZYeEhmR3pWdkI1?=
 =?utf-8?B?MnNhb3RBOStkN1VWZERSL3FkaDRTamFya3VSZ0x5TlhGRXFVQzJlTWdrWWJn?=
 =?utf-8?B?SFBKekdZaGFNVWZRYTVXRlFWNGJHckVJYUErZC9ubVhEM2QyRUkzazErZGJz?=
 =?utf-8?Q?40N4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8119ce-9021-4ca7-b31e-08dbfd5fe79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 11:20:55.2244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rURVtZ/X12o6Q9qHuu0+GhwVXPdmN4hvT+41mKlyMj8CdR02fR5U8K4qYUGNcEdIhufUOPE+d/jFCHGMT9LBvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIERl
Y2VtYmVyIDE1LCAyMDIzIDQ6MDMgUE0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1p
dC5rdW1hci1tYWhhcGF0cmFAYW1kLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgcHJhdHl1
c2hAa2VybmVsLm9yZzsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsNCj4gcmljaGFyZEBub2Qu
YXQ7IHZpZ25lc2hyQHRpLmNvbTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiBs
ZWVAa2VybmVsLm9yZzsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsgZGF2aWQucmhvZGVzQGNp
cnJ1cy5jb207DQo+IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRp
d2FpQHN1c2UuY29tDQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBtaWNoYWVsQHdhbGxlLmNjOw0KPiBsaW51eC1tdGRAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOw0KPiBhbGV4YW5kcmUu
YmVsbG9uaUBib290bGluLmNvbTsgY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywgTWlj
aGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgYWxzYS0NCj4gZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgcGF0Y2hlc0BvcGVu
c291cmNlLmNpcnJ1cy5jb207IGxpbnV4LQ0KPiBzb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPjsNCj4gYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDA3LzEwXSBtdGQ6IHNwaS1ub3I6IEFkZCBzdGFja2Vk
IG1lbW9yaWVzIHN1cHBvcnQNCj4gaW4gc3BpLW5vcg0KPiANCj4gDQo+IA0KPiBPbiAxMi8xNS8y
MyAxMDowMiwgTWFoYXBhdHJhLCBBbWl0IEt1bWFyIHdyb3RlOg0KPiA+IEhlbGxvIFR1ZG9yLA0K
PiANCj4gSGksDQo+IA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4NCj4gPj4gU2Vu
dDogRnJpZGF5LCBEZWNlbWJlciAxNSwgMjAyMyAxOjQwIFBNDQo+ID4+IFRvOiBNYWhhcGF0cmEs
IEFtaXQgS3VtYXIgPGFtaXQua3VtYXItbWFoYXBhdHJhQGFtZC5jb20+Ow0KPiA+PiBicm9vbmll
QGtlcm5lbC5vcmc7IHByYXR5dXNoQGtlcm5lbC5vcmc7IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b207DQo+ID4+IHJpY2hhcmRAbm9kLmF0OyB2aWduZXNockB0aS5jb207IHNiaW5kaW5nQG9wZW5z
b3VyY2UuY2lycnVzLmNvbTsNCj4gPj4gbGVlQGtlcm5lbC5vcmc7IGphbWVzLnNjaHVsbWFuQGNp
cnJ1cy5jb207IGRhdmlkLnJob2Rlc0BjaXJydXMuY29tOw0KPiA+PiByZkBvcGVuc291cmNlLmNp
cnJ1cy5jb207IHBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbQ0KPiA+PiBDYzogbGludXgt
c3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4g
bWljaGFlbEB3YWxsZS5jYzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IG5p
Y29sYXMuZmVycmVAbWljcm9jaGlwLmNvbTsgYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207
DQo+ID4+IGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNp
bWVrQGFtZC5jb20+Ow0KPiA+PiBsaW51eC0gYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7DQo+ID4+IHBhdGNoZXNAb3BlbnNvdXJjZS5j
aXJydXMuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELQ0KPiA+PiBY
aWxpbngpIDxnaXRAYW1kLmNvbT47IGFtaXRya2NpYW4yMDAyQGdtYWlsLmNvbQ0KPiA+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMSAwNy8xMF0gbXRkOiBzcGktbm9yOiBBZGQgc3RhY2tlZCBtZW1v
cmllcw0KPiA+PiBzdXBwb3J0IGluIHNwaS1ub3INCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24g
MTUuMTIuMjAyMyAwOTo1NSwgTWFoYXBhdHJhLCBBbWl0IEt1bWFyIHdyb3RlOg0KPiA+Pj4+IFRo
YW5rcyEgQ2FuIHlvdSBzaGFyZSB3aXRoIHVzIHdoYXQgZmxhc2hlcyB5b3UgdXNlZCBmb3IgdGVz
dGluZyBpbg0KPiA+Pj4+IHRoZSBzdGFja2VkIGFuZCBwYXJhbGxlbCBjb25maWd1cmF0aW9ucz8N
Cj4gPj4+IEkgdXNlZCBTUEktTk9SIFFTUEkgZmxhc2hlcyBmb3IgdGVzdGluZyBzdGFja2VkIGFu
ZCBwYXJhbGxlbC4NCj4gPj4NCj4gPj4gSSBnb3QgdGhhdCwgSSB3YW50ZWQgdGhlIGZsYXNoIG5h
bWUgb3IgZGV2aWNlIElELg0KPiA+DQo+ID4gTjI1UTAwQSwgTVg2NlUyRzQ1RywgSVMyNUxQMDFH
ICYgVzI1SDAySlYgYXJlIHNvbWUgb2YgdGhlIFFTUEkNCj4gZmxhc2hlcw0KPiA+IG9uIHdoaWNo
IHdlIHRlc3RlZC4gQWRkaXRpb25hbGx5LCB3ZSBjb25kdWN0ZWQgdGVzdHMgb24gb3ZlciAzMA0K
PiA+IGRpZmZlcmVudCBRU1BJIGZsYXNoZXMgZnJvbSBmb3VyIGRpc3RpbmN0IHZlbmRvcnMgKE1p
cm9uLCBXaW5ib25kLA0KPiBNYWNyb25peCwgYW5kIElTU0kpLg0KPiA+DQo+IA0KPiBHcmVhdC4N
Cj4gDQo+ID4+IFdoYXQgSSdtIGludGVyZXN0ZWQgaXMgaWYgZWFjaCBmbGFzaCBpcyBpbiBpdHMg
b3duIHBhY2thZ2UuIEFyZSB0aGV5Pw0KPiA+DQo+ID4gSSdtIHNvcnJ5LCBidXQgSSBkb24ndCBx
dWl0ZSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4gYnkgImlmIGVhY2gNCj4gPiBmbGFzaCBpbiBp
dHMgb3duIHBhY2thZ2UuIg0KPiA+DQo+IA0KPiBUaGVyZSBhcmUgZmxhc2hlcyB0aGF0IGFyZSBz
dGFja2VkIGF0IHRoZSBwaHlzaWNhbCBsZXZlbC4gSXQncyBhIHNpbmdsZSBmbGFzaCB3aXRoDQo+
IG11bHRpcGxlIGRpZXMsIHRoYXQgYXJlIGFsbCB1bmRlciBhIHNpbmdsZSBwaHlzaWNhbCBwYWNr
YWdlLg0KDQpHb3QgaXQuIFRoZSBXMjVIMDJKViBRU1BJIGZsYXNoIEkgbWVudGlvbmVkIGVhcmxp
ZXIgaXMgYSBkZXZpY2Ugd2l0aCANCndpdGggZm91ciBkaWVzIHRoYXQgYXJlIHN0YWNrZWQgYXQg
dGhlIHBoeXNpY2FsIGxldmVsLg0KDQo+IA0KPiBBcyBJIHVuZGVyc3RhbmQsIHlvdXIgc3RhY2tl
ZCBmbGFzaCBtb2RlbCBpcyBhdCBsb2dpY2FsIGxldmVsLiBZb3UgaGF2ZQ0KPiAyIGZsYXNoZXMg
ZWFjaCBpbiBpdHMgb3duIHBhY2thZ2UuIDIgZGlmZmVyZW50IGVudGl0aWVzLiBJcyBteSB1bmRl
cnN0YW5kaW5nDQo+IGNvcnJlY3Q/DQoNClllcywgdGhhdOKAmXMgY29ycmVjdC4NCg0KSSdkIGxp
a2UgdG8gY29udHJpYnV0ZSB0byB5b3VyIGVhcmxpZXIgcG9pbnQgcmVnYXJkaW5nIHRoZSBwbGFj
ZW1lbnQgb2YgDQp0aGUgc3RhY2tlZCBsYXllci4gQXMgeW91IGNvcnJlY3RseSBoaWdobGlnaHRl
ZCwgaXQgc2hvdWxkIGJlIGluIHRoZSANCnNwaS1tZW0gZ2VuZXJpYyBsYXllci4gRm9yIGluc3Rh
bmNlLCB3aGVuIGEgcmVhZC93cml0ZSBvcGVyYXRpb24gZXh0ZW5kcyANCmFjcm9zcyBtdWx0aXBs
ZSBmbGFzaGVzICh3aGV0aGVyIFNQSS1OT1Igb3IgU1BJLU5BTkQpLCB0aGUgc3RhY2tlZCBsYXll
ciANCm11c3QgaGFuZGxlIHRoZSBmbGFzaCBjcm9zc292ZXIuIFRoaXMgcmVxdWlyZXMgc2V0dGlu
ZyB0aGUgYXBwcm9wcmlhdGUgQ1MgDQppbmRleCBpbiBtZW0tPnNwaS0+Y3NfaW5kZXhfbWFzayB0
byBzZWxlY3QgdGhlIGNvcnJlY3Qgc2xhdmUgZGV2aWNlIGFuZCANCnVwZGF0aW5nIHRoZSBkYXRh
IGJ1ZmZlciwgYWRkcmVzcyAmIGRhdGEgbGVuZ3RoIGluIHNwaV9tZW1fb3Agc3RydWN0IA0KdmFy
aWFibGUuIERvZXMgdGhpcyBhbGlnbiB3aXRoIHlvdXIgdW5kZXJzdGFuZGluZz8NCg0KUmVnYXJk
cywNCkFtaXQNCj4gDQo+IENoZWVycywNCj4gdGENCg==

