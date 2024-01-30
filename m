Return-Path: <linux-kernel+bounces-44078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A0841D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B01282315
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771854730;
	Tue, 30 Jan 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IlKtP2mF"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551257864;
	Tue, 30 Jan 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601337; cv=fail; b=Yicevcw4YuHC+9DON9ooOUuQuqWvf8OXBKkmpuIeXwc7R4T1+yRMg4ZRYdJssCwKgapYsMuBn7UdWOOYfWk0GDDQxzFBWxNodR8ybNHdtTf7iYewtPVG4Ml1lhR+zSlDdwCvF3qqc07Si3vTTzQz9xablTpRsntD2DeHO4eFyaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601337; c=relaxed/simple;
	bh=WCn1o7/GtRev90Ap9y+DJ1X6rS8oWsTAWcKNDET2FoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDAwXQ641BaP159ioSENqxuCVcdXXASaMPxv9DIOOKN9rF9yKO11jMsAHlyvddRDJM91aS93vLOb/HewvnmzcG/n1xKDT08sBxr7DuU8lvjVDlkt+Al7rf86Kql3o3Rpiph4pteod3sIEGYzMEL8GLuqdvMr0VHpEFMhOFEMirY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IlKtP2mF; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViDIJHvbkhQ1DEZURmTN5tX89KPP+GTkwpjEBtYm+VBVQjpP/yWaK0RrdLA8jFqYJe4X3hbBeVh+eFVC5H+/IRjHAg9PVwMVVxtvLnSvOUtG1iZuSwtTXHQ9RxLg9DGKcdcARNtUDQUPVMuwjfI40SXlmUFIA30yBCn/5tgQnYlJJ4ugde9kr3NbMcTmWIsRQmrBI8opLj3D34iH+OBgDAHdIGoVwhFo47lovLSFitWEuavhMTxGmpjx2oUlPI95VdAIcrAJ0p/02lK73Gw9GkqsFoVIJ4iBbopLddMFsf41ZTQf7GfhzSmrUjDjsYMhPwHNYN/U/pgb2BgAXSoREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCn1o7/GtRev90Ap9y+DJ1X6rS8oWsTAWcKNDET2FoY=;
 b=BzaspMeM6pwcibX1bhHRvhGYsqWj4XG282Frp7ppyOEItxdHGF4G0m97RyMteK3qQxjdJCDXDNadoD8A9TUxKWjjTLgq3nQTSNBR78nYgaTXU3Vgyi5TF2hY8LWzzOsilNlwWTMeB4g81+MsMDaFKEK8ez3i0DTClE7+e2WVIAuksFuOJlU6y9UWAyjwp9N7SANDOjuDxzSxOOKUGQuVQst3NtGyLteMJXboTDDKKf36AEfl1OQy4Hq0oc8EJHwP6VcNg68pjfIpZ34qCigKq3ld0/hJZrlhLoLhbBRgijP1R83Jx9SfLljFf+Qf2XC6di4/lBUHgj5I4O916ht76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCn1o7/GtRev90Ap9y+DJ1X6rS8oWsTAWcKNDET2FoY=;
 b=IlKtP2mFgIeURKLc9bEMv19uXrOe193U72p7UFgtiHBmNMAP4D9V8vIhESQMBde6AkgzMQhlGtfDKQLMwqUmOqVV1oLZh8nWFIwpt4j5JjaXHsr29MOT1yIA1aSG7iz+5VLkANES18c4QhPI70IIm6wNXStRKJxAgqrSAP2AyggY7RnDc8k/ozFIFNb3IAbWRQPTSEQ6KTvcj3OM9uck/iN+u+YKitTI8NG/90GkGCgAUMGNuAfuvMeh1zTjd4FwvFrBPyKgWzKHLXyC5BT/62HnCYiZqNFWblr+NT86FqEP3IBjcR65WPae/v0w6RcOgJwifCS7lfMgShyrskNhFw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 07:55:32 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:55:32 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [RFC PATCH net-next 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [RFC PATCH net-next 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaTQ+ILxuaMfgJf0Ou8iXfyvUHrbDnpgsAgApjCbA=
Date: Tue, 30 Jan 2024 07:55:32 +0000
Message-ID:
 <DM6PR12MB451643692E69D94D6A7484D8D87D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-8-danieller@nvidia.com>
 <Za/0um6oUo3CQaR2@shell.armlinux.org.uk>
In-Reply-To: <Za/0um6oUo3CQaR2@shell.armlinux.org.uk>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DS0PR12MB8501:EE_
x-ms-office365-filtering-correlation-id: d3b07391-e10f-47ff-4393-08dc2168d5e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UNPsZ5pn+aHglsD8Z9X/wpZF++KRkZ6TlirV3/Y/GHoEA8R+0cgOzwOUinFUW5td8H+pWtrHkDCMlXRaZVfHpKNscZGIH2d12Ar8z1yJtxPAKyBAaywAgfoCOYJOFK0hoPP8RUsoI1SuZzQnVKmSuVvW2UI2Cu69DhosWLpHrOZ1K03bkYjbrcFh8WtSe8Fvl9JwuzUG3jCy7SaD2HMeq/ksz9R1j0Cg2My1D9/8Lfp7LlxpRpdIPtOf7tdP7594ChTX5UNULY/kW/tpUxwtOO0OXpZIpkxNuA4dOJhx3bhF7RCrCItw+KiPrYpSnzrtpe5nxIcQTAzOp7piNnecVd9pqV0spaIDjDXgOnqhw0WicmCbImPvYVoYMZNonE/0rx60LX86l5NiQIgRfsuR4njyx5W1j3TPyfGcYlMF3bLlPNJw8DHJLy/1jn9DnIrFuAKsDZYB9IZmzfNYE4DRayLvgVRbyVOLOSWZDsfYlUdPZ1RE7wi0WaNQbLs0rShEDiTQ28NblyQ1rKLlvUrWSiUZbcntIeclRJDLGQUL2RkD2u6mBvDOBgFPbXeCMEdtAVIH9j7pqbLQ0wXYyv1THDuczSfjW/g+LuOc8G27WM+GWPR91hyAS06DCsQnkdlUpcxxZTVwVnCDPOh5FS4vN9nF6IlIs3pD9vg4jlbJLrk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(966005)(52536014)(8676002)(8936002)(7416002)(4326008)(5660300002)(86362001)(33656002)(2906002)(76116006)(64756008)(316002)(54906003)(66946007)(66556008)(66476007)(66446008)(6916009)(38070700009)(38100700002)(122000001)(7696005)(6506007)(71200400001)(478600001)(9686003)(83380400001)(107886003)(41300700001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFFBK1c1K1c5dUl3b0Y0b2VaQTZmaDZWNGlJLzdaOWVmOTFSQk9lTzV0NnBN?=
 =?utf-8?B?djl6Z1ZTWGpydnMzY3dPQmIyVWk3UzJSSHp3c0xwT0pvWExlYmtFenBmZk9T?=
 =?utf-8?B?TzlsTHUzZzVNNWpzMm5kdnZLT2IyZXVHT2N6OTNFb0cxZGVXbk5veFppZVdt?=
 =?utf-8?B?SWhXdHRBWHFiWTVaeTlGTWJSK0FoQnVuOE0vcXdYM2xKaVNrc2dBNUhCQUUw?=
 =?utf-8?B?WjRFMXd2YXg0eXhLbEUzdDNRN3k4NWRVSWdOSDdseXlZL0JUSmlyWC9vL29R?=
 =?utf-8?B?TWtoM1orbkpOV3Jla1IydkFYSDQwM1pUSzh0UWQ4UU5IaU1kbVQ2VlVMZUVW?=
 =?utf-8?B?VHpsNWlWc0FzMTdrSlcwN3NENWM3Q3lXZmJUVjhORTU3NkZRdE9OMWt1Ynps?=
 =?utf-8?B?Sms0ZTNmajMwVitBdWVMN3NDODN4bitiQ1ltY2NDV1JTM2sxcmU3bXJKd3Y4?=
 =?utf-8?B?S2p2VXlPMzgrekxDbitKOHNlbTNPSnpXTXp6NjZ0TXNUMjROS2FlVy9mLysr?=
 =?utf-8?B?aEJKb1Y2R2NJMDdMTGJaNDY3YzdHbWpXTjJPcU45bHlORGRiMzRKWkFpZVZ4?=
 =?utf-8?B?TnljV2lKOHZ3WGR1U3FlblFWa0VsQ2FGei9IaHdRWHE3V0t0WkV1UTM3bEFw?=
 =?utf-8?B?UWg0bjZ6dlRzbGNuMVNJS3A1aFVxS2xmb1NYUnRwY3JNV2F4Mjh3bTNLNkRN?=
 =?utf-8?B?dEhSVkpGbm5ZbDdqei9LM1ZRMHhlbW1ZRGdxcTBtU0lxL2ZFaWFzcFNHYml0?=
 =?utf-8?B?QmQ2VFZvREEzUTFNY2RXTXZuRnFvVnRxYjhEYVp5YUduRFRHaldOYnVGbG9t?=
 =?utf-8?B?N1FJbzB5blRMeFordHE5SDBNMWd3azJUblBTMVBDR1N3UnBIMG4wMFhNSklj?=
 =?utf-8?B?Y1lIb1BaYmxFWjVyQXQ5NHZNclVlMnBWR3BiOTZhV1pJd1kxdVlNekpHTFRL?=
 =?utf-8?B?NW0wbEFTdW5EMG4vOVpZMUc3WDcvdXA3ZHFvYmhTcXhDUFZON0o4ZDJqb21h?=
 =?utf-8?B?Wnl6WjBycGZ0V1lYYks4UnhTUmtVT3JHcDczdVJFZmp0ejVxcDVDTFVZczBL?=
 =?utf-8?B?ZXg0eGVqamd2ZG50bHlsMXpxYk5rdk1qUFNVV0xHZzYwWWN5QVF1cm1OY0cv?=
 =?utf-8?B?L3FzV2Flb0lVeGVTL3pqZWh0YzhIbkt4UVJtN29Hc2N6OHdHdUhOYlZWb05F?=
 =?utf-8?B?VTZza2FsNE9CL0ZZd1JzV3dtZjh0c0JmRHZpR3c2bUcxTTBwMUFvUGQrai9O?=
 =?utf-8?B?YzJoRElGRkFVbWwzNllSdE1jQUF2T0lTZGtReFZJaFZLTnlRdzZhaUkrYlFs?=
 =?utf-8?B?VzgvTzBUUitQSW1hM3NzYU1sOVMwZGFkS2liYTRiL0VSQlpzTlRkV3QvNkdw?=
 =?utf-8?B?Mm5RNU8rQUo2THhDTEJmdWxwZEx4RGlZY1Ntc3ErTEdGSUFseGI0TGtidnJ6?=
 =?utf-8?B?WXR5eUpRNTJvR1JBcTliUnJXS3VnVUdpMkhoRTJnWDkzSU9JY1dsRzNvbDRk?=
 =?utf-8?B?NlIzQ0RrQ3RablIwWDFod0srOHBlYmliWXd3c0pMZVhmMU9oK0VBL0tsVGpQ?=
 =?utf-8?B?S0dkdFJhR2g2TmZFb1VaTFFSNW1yUDVQZkpOMXNaV2lnM3VBUi9ldkQ5bm1N?=
 =?utf-8?B?OXJteGMzczVBTWZTK1pKb3JXSFlHakV6Q1RSVWJKaUlVUFFnRUJSejJURTM5?=
 =?utf-8?B?aGdiOElOeGJncWQrVGhSTUNUak1LalJ1UXhZNTdIZVY4RGlOVlN6QnVDVGcw?=
 =?utf-8?B?cStkbFZSTnF1N0tOUVJzWlltUjV6L1FITVNINHhubFlRSlUyY3NSZlY4ZTlw?=
 =?utf-8?B?cXNmUU9oMUxvUTNyU2hIQm8xRjhUdEswNkx4N1U4bW96allGcndEbEwvT1hX?=
 =?utf-8?B?UEJ5ZGJ0NjlpcHRYK0lVYUdFTGJsSWdaRjBGYUFhblpnOEpYYk4vK2MzSjNm?=
 =?utf-8?B?ZmpRQmlrN0srak5pNVQxSjkxZGJ4Q3RraTVtTXZlQWN2ajArenEwcHhxK3B6?=
 =?utf-8?B?bWdVRVhMWFFhN3pWbjNWMXQ2ZmZYL0NPYzFrOFQxMnAwS2hGZkhlK3JiRXJF?=
 =?utf-8?B?RldEeEMvVWRGOXJqK2M1OGhVQlI2Ym1xSG01UUpkbHg3c2Y4UzBFRXp6Qm5w?=
 =?utf-8?Q?Q1kykPad7mr6qiMyxoZMmiBVN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b07391-e10f-47ff-4393-08dc2168d5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 07:55:32.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29MGzevNwSXbjhmAQ+7VoSbUdJo/uWL933Yp1cPL57pquuIfOhkSfSJgCpeNSJPTuyJV/pKXcqETDawJODEOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501

PiA+ICtpbnQgZXRodG9vbF9jbWlzX3BhZ2VfaW5pdChzdHJ1Y3QgZXRodG9vbF9tb2R1bGVfZWVw
cm9tICpwYWdlX2RhdGEsDQo+ID4gKwkJCSAgIHU4IHBhZ2UsIHUzMiBvZmZzZXQsIHUzMiBsZW5n
dGgpIHsNCj4gPiArCXBhZ2VfZGF0YS0+cGFnZSA9IHBhZ2U7DQo+ID4gKwlwYWdlX2RhdGEtPm9m
ZnNldCA9IG9mZnNldDsNCj4gPiArCXBhZ2VfZGF0YS0+bGVuZ3RoID0gbGVuZ3RoOw0KPiA+ICsJ
cGFnZV9kYXRhLT5pMmNfYWRkcmVzcyA9IEVUSFRPT0xfQ01JU19DREJfUEFHRV9JMkNfQUREUjsN
Cj4gPiArCXBhZ2VfZGF0YS0+ZGF0YSA9IGttYWxsb2MocGFnZV9kYXRhLT5sZW5ndGgsIEdGUF9L
RVJORUwpOw0KPiA+ICsJaWYgKCFwYWdlX2RhdGEtPmRhdGEpDQo+ID4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+IA0KPiBIbW0sIHNvIGV2ZXJ5IHVzZSBpcyBmb3JjZWQgdG8gdXNlIGttYWxsb2MoKSBl
dmVuIHdoZW4gaXQncyBqdXN0IG9uZSBieXRlPw0KPiBUaGF0IHNlZW1zIHJhdGhlciB3YXN0ZWZ1
bC4NCj4gDQo+ID4gKy8qIFNlZSBzZWN0aW9uIDkuNC4xICJDTUQgMDA0MGg6IE1vZHVsZSBGZWF0
dXJlcyIgaW4gQ01JUyBzdGFuZGFyZA0KPiByZXZpc2lvbiA1LjIuDQo+ID4gKyAqIHN0cnVjdCBj
bWlzX2NkYl9tb2R1bGVfZmVhdHVyZXNfcnBsIGlzIHN0cnVjdHVyZWQgbGF5b3V0IG9mIHRoZQ0K
PiA+ICtmbGF0DQo+ID4gKyAqIGFycmF5LCBldGh0b29sX2NtaXNfY2RiX3JwbDo6cGF5bG9hZC4N
Cj4gPiArICovDQo+ID4gK3N0cnVjdCBjbWlzX2NkYl9tb2R1bGVfZmVhdHVyZXNfcnBsIHsNCj4g
PiArCXU4CXJlc3YxW0NNSVNfQ0RCX01PRFVMRV9GRUFUVVJFU19SRVNWX0RBVEFdOw0KPiA+ICsJ
X19iZTE2CW1heF9jb21wbGV0aW9uX3RpbWU7DQo+ID4gK307DQo+IA0KPiBEb2VzIHRoaXMgc3Ry
dWN0dXJlIG5lZWQgdG8gYmUgcGFja2VkPyBJIHdvdWxkIHN1Z2dlc3QgaXQgZG9lcyB0byBlbnN1
cmUgdGhhdA0KPiB0aGUgX19iZTE2IGlzIGNvcnJlY3RseSBwbGFjZWQgYWZ0ZXIgdGhlIDM0IGJ5
dGVzIG9mIHU4Lg0KPiANCj4gT3ZlcmFsbCwgSSB0aGluayB0aGUgaWRlYSBvZiBhbHdheXMga21h
bGxvYygpaW5nIHRoZSBkYXRhIGlzIGEgYmFkIGlkZWEgYXQgdGhlDQo+IG1vbWVudC4gV2UgaGF2
ZSBubyBpbXBsZW1lbnRhdGlvbnMgdGhhdCBETUEgdG8vZnJvbSB0aGlzIGJ1ZmZlciwgYW5kIGl0
DQo+IG1lYW5zIGV4dHJhIGN5Y2xlcyBzcGVudCwgYW5kIGFuIGV4dHJhIGZhaWx1cmUgcG9pbnQg
ZWFjaCB0aW1lIHdlIHdhbnQgdG8gZG8gYQ0KPiBDTUlTIGNvbW1hbmQuDQo+IA0KPiBJdCBhbHNv
IGludHJvZHVjZXMgZXh0cmEgY29tcGxleGl0eSwgd2hlcmUgd2UgY291bGQganVzdCBiZSBwYXNz
aW5nIGEgcG9pbnRlcg0KPiB0byBhIGZ1bmN0aW9uIGxvY2FsIHZhcmlhYmxlIG9yIGZ1bmN0aW9u
IGxvY2FsIHN0cnVjdHVyZS4NCj4gDQo+IFVubGVzcyB3ZSBkZWNpZGUgdGhhdCB0aGUgZGF0YSBw
b2ludGVyIHNob3VsZCBiZSBETUEtYWJsZSBmcm9tIChpbiB3aGljaA0KPiBjYXNlLCB0aGF0IG5l
ZWRzIGRvY3VtZW50aW5nIGFzIHN1Y2gpIHRoZW4gSSB3b3VsZCBzdWdnZXN0IGdldHRpbmcgcmlk
IG9mIHRoZQ0KPiBleHRyYSBrbWFsbG9jKCkuLi5rZnJlZSgpIGJpdHMuDQo+IA0KPiBUaGFua3Mu
DQo+IA0KDQpXaWxsIGZpeCwgdGhhbmtzIQ0KDQo+IC0tDQo+IFJNSydzIFBhdGNoIHN5c3RlbTog
aHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBGVFRQIGlz
IGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0
IQ0KDQo=

