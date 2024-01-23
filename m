Return-Path: <linux-kernel+bounces-35309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D33838F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5781F28C1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99855FBB0;
	Tue, 23 Jan 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVDUSQYl"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F45FB97;
	Tue, 23 Jan 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015121; cv=fail; b=CK03ILPXDr8weC/SspMwSf75pz4078aT7x1t8L7SjcR0eUm7FQi//YPLNOtAUGIzLywjaEmAvSgc+J39rlgKh2F2c/YKglfshhWZz2krMu9DtoZnFKq9dfaUAT6LV4N0edCGJqjux98Nzmh3UBAbdixMfENe1cQgWRXLxiIPfNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015121; c=relaxed/simple;
	bh=0dIlHQ9M8l2j457ZZUnsEhdU5aKKJyOOA7Bn681hO6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1D0Gp9AneGhJVcZ9HjscDdkpdIQEq6owBN7Pbyr1MT4JIma+HBhULEjV67+f1KSpveouWR2a9BJL28MdO6JtQlNlgLfGIUQyppIf5YO8AaGGD8QBFKe+we+E2A79HazqdjOMBODrVUiqR15CcYIjHCNoA3MmJr3z50aBj/DRUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVDUSQYl; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Zp6Vh5IZ9/I+LsYq5A1bzsnwn36ronBw4dj35byUYDCNQh26EUiOpxFVOr4CC5i7gC0wzYIsZ0r369K/irWJWXEPBH9wunLQDbOEN2LN9nQwyg3WIJ3gA13lgkKSXG/eL87gpBLwdqM0EJt7C1D1yQfPUSiqpSfrfIC2dBUOc0qMrU/+8+fpHXG4lGbYFLHLP/iw4n9bZH6Z8TotOg7q0MrOhZaHUG71kgdWtq+LIEDX/M4sfh50eL7ptHW0Pr9ptbFTIRLRd2kjhgIe4obftdDozkSvpMFtipe5TrOI/nEft6Sykx8Fz56/nWdfH3ktzn3sbqNH9th8O1VoTg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dIlHQ9M8l2j457ZZUnsEhdU5aKKJyOOA7Bn681hO6g=;
 b=E1dM6+3wGIwQR3bcjovyMKVlzxJb079ISTvam99m1xyRHf56V0VGM3L75U27mcxDUicxC5k1QxgH7l6BsBwOnfH0kdpFkMMuCNxYZ/CFXosJmOkRv53FwJz80vpqtiSjfQD03AWiIj3sMgjTD0bulRGoMvkzDFGdf67bxwplRs5LO3LpRmlOL0ehIFCyKzztSc0OBnaV84FiNudnnTdCofZyQhdFEA5TfioW3KEN/WifdOHrj/Ezf5YrASk6tm8nOJQcqOr7T2nftK7HSO+VIjxamU5VecSrqILGWf9K+2YLK7bu019boNcdFGDf0vWetZRmPI8YWbwgz5mVQrqlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dIlHQ9M8l2j457ZZUnsEhdU5aKKJyOOA7Bn681hO6g=;
 b=CVDUSQYlRqQNjxIxW5d4LlSot+eyv5kgyUfZiJAu1bYi62BLTfF8reFLta/azBulhuhAWwdzeUxUCCnh5TxEBdi8P1CooZUCsrFg/SgoIrUXdb2AXcOidG8N80PrAMdkkHl7hQO2SjciCJIjY0gQNN+Rpp1rgGnlB9X+FRZYtzrSePFOzT0RunTHQvH1IK3G2kjh9Q7JMCun6wOzQQmtJYEYD0hhLXAXrQ/IYT4PlIycivkFdI0QS6pIDyUY6F2PEJh+tXbhCTLkQBOq3F/OCa/AWv1Ub5DZTCqtghOlRzJckUjRKrzfS6FhCKIyRMjcHsal6iQBunzOHPrOBPsDtQ==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 13:05:16 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 13:05:16 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
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
Subject: RE: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Topic: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7Dm2XcAgAB26TA=
Date: Tue, 23 Jan 2024 13:05:16 +0000
Message-ID:
 <DM6PR12MB45168E425B2C1832F6D26453D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-10-danieller@nvidia.com>
 <20240122210534.5054b202@kernel.org>
In-Reply-To: <20240122210534.5054b202@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA0PR12MB4399:EE_
x-ms-office365-filtering-correlation-id: aed8c78d-5f87-4321-346c-08dc1c13f1dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eH3SuagBc4owZ5ZZksquJRpl9+mfLlutxGKrU3SIoE1izYa65kGjqFiM2O+PTlrUYwVNBXI0Ky5udzbGIOtowqCAjg6B0bOONPqhL2Z4ISAKa+yUtRjRBdOQnAlbMKA7GLh7uRo1IZATNI+aTZ41gKSu1frSlIGii1+y6VBT8wN5JUxvTLMtqDct/qAVnboQOtoVHFfZuJ84W/0h7fcT0uffaV/5wS42qwv5ejmoTAJvOBSZby2Ujd/dozDVnVxGBmcGT3HVCtRj4Zb61hukojLZrkstrBroU5Amje9mGDW1YT3fa/ktQXmneocgLLK24S87xfXk79xS4RxBeKQU5tl549VmUUHUuI2wXpWG8l4YYgs7m2xACDYujdIbqHGurR5v6Bkpz0gt3tN3rt1n/RSUBcpOrKQ9dP7otTkU9PdvJMYsnwR5s8nAjLq5n+9E4R4Dl0g+vfrwov6ss4VLgBhn9gHSPDcvJwChpFfV4a52aZazWp9vTzzebeFV1kvNQnN2Zd0KZVKBSImr8Fd4dKxEg+tYaYF7o5e/2Ul8w2qcOXxoTtPEOYZnKoPvZcafAl9xeJeLPRI1s+Go92YDsl+ywBFxyiybmFlzreo2i//kNxi743xRzodooqISnEl9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7416002)(2906002)(5660300002)(478600001)(86362001)(33656002)(38100700002)(38070700009)(83380400001)(41300700001)(6506007)(7696005)(107886003)(9686003)(26005)(122000001)(71200400001)(66446008)(66556008)(66476007)(64756008)(316002)(52536014)(6916009)(54906003)(4326008)(8676002)(8936002)(66946007)(55016003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkFtbmdaUVUvQWFENW9oQWY4ajNkQzhqTHIzUHp3UVV5S3IwNnpzaFNycVF0?=
 =?utf-8?B?Ylc5SmFySGlGeml1UE9QTTBmTEpYYlJPaXZDblhuaENrNVJCcVBHT2R2S2NF?=
 =?utf-8?B?WW9JRW05RDE4c3c1UzJSV0ZJWnpUSEwwL1oyaFJFQzJxbzdQUkxxT1BLcDAw?=
 =?utf-8?B?YjFiZTdvMlMrNEl0YzBxWWtud3U5di9tdHl2SEtHWUEzZk9tUkVwNjlza01H?=
 =?utf-8?B?NEc2cEZYektpWkdob3NyaUlUUkkzMlpKMys2TmpEcERkalNvSThOZE9MaUxp?=
 =?utf-8?B?V21hU0o4KzFYM3JNTHZUUU5JQktPTC91SnlrVlJVUklNSGZXZzExWG9vMnRr?=
 =?utf-8?B?QU50TUZHeDh4dlRjQUI5d2JLMjdZL0x2TkJ6WXdSd3NWZkRrMnN0V2hkbVYw?=
 =?utf-8?B?eWFHY3VZR1czejRzUTUrc0M3OE5zNlRHbVRrLzFabitoWUtUNk9HelBwUkxV?=
 =?utf-8?B?WlBwY2VKVUE5RFloSFUvSjlBQTFiRjRROVoydDhtRkZ5aldRWEM2elBUNzBr?=
 =?utf-8?B?V21MYkhtRE9PSXdGV3Z1aHFxRjlLZnpyRlRnTkFHdG5XUWRMcy9FY09od3J6?=
 =?utf-8?B?TnFaaFZldmt0ejl2UW81VzNJRjJPS2RjeHBhMCs4M1JtU3RQNTE1VFVrNWdG?=
 =?utf-8?B?cmpMM3cyTGpBTmlHYXR3YkZiMGdrcXh5VEtkaXY1VlIzSGFNUE5xSHlwV2hR?=
 =?utf-8?B?UERLV2h6UTlXZENpQkJJb2k0M2lVcXBMQmJ4dGg5Z3VWMTljLzhNTG96VkV2?=
 =?utf-8?B?TG1vT3J2Y0RJYWJPS25pMVUvczFhREpQOG1waTBJdkxFOVpYZEFSMHdpNzdY?=
 =?utf-8?B?TW83NnB5TjJiZ1RkMU9iRURYalZBWE5BekZscER2a3dXbFRvV28yMjcvSzhY?=
 =?utf-8?B?VnBndjBMZmgwajRobEY2MmRtcE05eXRaRVdaZ1JiZU9objE1bzN0SkErS3Jl?=
 =?utf-8?B?c0hjaitmc2RlQ29DaXFQU0xraGpHVXZuaDVJbm1XaEJndThjZGl1eCtQRDNr?=
 =?utf-8?B?a1h6NFlsMWY4elc3b0Eyc3JwNlR3cTE0UGo5NFZYVlJtTlEvK3J2M3pMd2Uy?=
 =?utf-8?B?OFh2cXJZSnlpOHJtRDJ0NTBtc1g2RWxPTTBBaUI3VkxpbGpYcjdFaDRGNE5m?=
 =?utf-8?B?Z3ljUENHaWd5MGVRYXhhN1hsT1k2SDluNFBqem52YlpBeDMxTGZ2QlBIWnUy?=
 =?utf-8?B?K0RockMycGNob00zQUhyeGFXSG9GN1BMSlhPbFNXc2lMSFJxaFpuclZ1Nksv?=
 =?utf-8?B?eTRIUFdRYW10SzVXc0xnVHQ0czc4K0NrU09xYmxyeVBHdXB0RC9PaEFtbHZr?=
 =?utf-8?B?MjB2ZnZxa3JLc3dqaHFvRzBCT29TcXdPZzFnZFA0Y1BvYjluajNLajNsWVRP?=
 =?utf-8?B?TXAzRmZOemR3dUozZG1FTkxNREZuUDUvMVY0cmpJRlUwa0IzUCtjYi9nY1ZF?=
 =?utf-8?B?RzVRQ3lzZVk3U3lrM1pZUUVlUzBuemVMMThjRFBRRDdwcjJ0NVV4Q2ZRQWhZ?=
 =?utf-8?B?ZEZsb3h6bHRPZXZzUGdPTExob3RpWHdrRTZRTVpZc0VTU2ZHanQ0blFkNTFB?=
 =?utf-8?B?OU4vV2M2ODVGQWRZb3B3T1pkbXNLc3dwT1JSbHhwZ2pzcUVRaXFscWVSOEhp?=
 =?utf-8?B?NXRJVWFXSVI1Y2ZIbTZoYm9qQUZ1YXQ4M0NmRTlLc29pQWRsbExTSGQxbmVX?=
 =?utf-8?B?WFZBazUwQ2dlTHY5aFhVZW9OZmQ0SU85QkxEck1WN0FESTlpazdNdUVOblBV?=
 =?utf-8?B?YWY1aUhEUS9jRE9OV2tOaDA3dDQ0cnlaUjU0aVdyZmF0OEhvbG1JL3Z4L0Y2?=
 =?utf-8?B?NnV1cTRxU1JOTjFmQjFqSDM2akxudCt1YkVkaVhMcDlOaFNGZ1BLZitaQXpC?=
 =?utf-8?B?U3RIOWNiRDZnclcwUU03Ky9wb0hrSDBCejFhMy9pSDliTG94ZitTd0dtaHEx?=
 =?utf-8?B?eXgyRTcwRzAxb0U1MzZ4TWErU3VVQS9xMzhLaVB0Y2JQUjdsTXJsUXZWV3Y4?=
 =?utf-8?B?dVYzTUkyaGVVTjVMSVNJd0lSTS9qOHU0Nnd3V3c2MTF0ZmdETnBJQTFWZVI2?=
 =?utf-8?B?R2dSeURoL0lUcks0OHQ4Z3FpOS84eTU2UWxOWlJXOW9USUhlejdhK21UQ2Yx?=
 =?utf-8?Q?piwxNowxcitzZPYE4z9UW0m0G?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aed8c78d-5f87-4321-346c-08dc1c13f1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 13:05:16.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POE7Gem/QqidF1ISxselVMmjbLbMC98wPiguJrSkj7BIJTWKVWJLVdynTjMCJDmjAChipuejHstJYVBMdJa83A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

PiA+ICAjaW5jbHVkZSA8bGludXgvZXRodG9vbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2Zw
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPg0KPiANCj4gYWxwaGFiZXRpY2Fs
IG9yZGVyLCBwbGVhc2UNCg0KT2suDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQNCj4gPiArbW9kdWxl
X2ZsYXNoX2Z3X3NjaGVkdWxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gKwkJCSBzdHJ1
Y3QgZXRodG9vbF9tb2R1bGVfZndfZmxhc2hfcGFyYW1zICpwYXJhbXMsDQo+ID4gKwkJCSBzdHJ1
Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spDQo+ID4gK3sNCj4gPiArCWNvbnN0IHN0cnVjdCBl
dGh0b29sX29wcyAqb3BzID0gZGV2LT5ldGh0b29sX29wczsNCj4gPiArCXN0cnVjdCBldGh0b29s
X21vZHVsZV9md19mbGFzaCAqbW9kdWxlX2Z3Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4g
KwlpZiAoIW9wcy0+c2V0X21vZHVsZV9lZXByb21fYnlfcGFnZSB8fA0KPiA+ICsJICAgICFvcHMt
PmdldF9tb2R1bGVfZWVwcm9tX2J5X3BhZ2UpIHsNCj4gPiArCQlOTF9TRVRfRVJSX01TRyhleHRh
Y2ssDQo+ID4gKwkJCSAgICAgICAiRmxhc2hpbmcgbW9kdWxlIGZpcm13YXJlIGlzIG5vdCBzdXBw
b3J0ZWQgYnkNCj4gdGhpcyBkZXZpY2UiKTsNCj4gPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGRldi0+bW9kdWxlX2Z3X2ZsYXNoX2luX3Byb2dyZXNz
KSB7DQo+ID4gKwkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLCAiTW9kdWxlIGZpcm13YXJlIGZsYXNo
aW5nIGFscmVhZHkNCj4gaW4gcHJvZ3Jlc3MiKTsNCj4gPiArCQlyZXR1cm4gLUVCVVNZOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCW1vZHVsZV9mdyA9IGt6YWxsb2Moc2l6ZW9mKCptb2R1bGVfZncp
LCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghbW9kdWxlX2Z3KQ0KPiA+ICsJCXJldHVybiAtRU5P
TUVNOw0KPiA+ICsNCj4gPiArCW1vZHVsZV9mdy0+cGFyYW1zID0gKnBhcmFtczsNCj4gPiArCWVy
ciA9IHJlcXVlc3RfZmlybXdhcmUoJm1vZHVsZV9mdy0+ZncsIG1vZHVsZV9mdy0NCj4gPnBhcmFt
cy5maWxlX25hbWUsDQo+IA0KPiByZXF1ZXN0X2Zpcm13YXJlX2RpcmVjdCgpID8gSSB0aGluayB1
ZGV2IHRpbWVvdXQgaXMgMzAgc2VjIGFuZCB3ZSdyZSBob2xkaW5nDQo+IHJ0bmxfbG9jay4uIEkg
ZG9uJ3QgcmVtZW1iZXIgd2h5IHdlIGRpZG4ndCB1c2UgdGhhdCBpbiBkZXZsaW5rDQoNCk9rIHdp
bGwgY2hhbmdlLg0KDQo+IA0KPiA+ICsJCQkgICAgICAgJmRldi0+ZGV2KTsNCj4gPiArCWlmIChl
cnIpIHsNCj4gPiArCQlOTF9TRVRfRVJSX01TRyhleHRhY2ssDQo+ID4gKwkJCSAgICAgICAiRmFp
bGVkIHRvIHJlcXVlc3QgbW9kdWxlIGZpcm13YXJlIGltYWdlIik7DQo+ID4gKwkJZ290byBlcnJf
cmVxdWVzdF9maXJtd2FyZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwllcnIgPSBtb2R1bGVfZmxh
c2hfZndfd29ya19pbml0KG1vZHVsZV9mdywgZGV2LCBleHRhY2spOw0KPiA+ICsJaWYgKGVyciA8
IDApIHsNCj4gPiArCQlOTF9TRVRfRVJSX01TRyhleHRhY2ssDQo+ID4gKwkJCSAgICAgICAiRmxh
c2hpbmcgbW9kdWxlIGZpcm13YXJlIGlzIG5vdCBzdXBwb3J0ZWQgYnkNCj4gdGhpcyBkZXZpY2Ui
KTsNCj4gPiArCQlnb3RvIGVycl93b3JrX2luaXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZGV2
LT5tb2R1bGVfZndfZmxhc2hfaW5fcHJvZ3Jlc3MgPSB0cnVlOw0KPiANCj4gV2hhdCBkb2VzIHRo
aXMgcHJvdGVjdCB1cyBmcm9tPw0KDQpDdXJyZW50bHksIGl0IHByb3RlY3RzIHVzIGZyb20gZmxh
c2hpbmcgYW4gaW4tcHJvZ3Jlc3MtZmxhc2hpbmctbW9kdWxlLg0KDQo+IA0KPiA+ICtzdGF0aWMg
aW50IG1vZHVsZV9mbGFzaF9mdyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgbmxhdHRy
ICoqdGIsDQo+ID4gKwkJCSAgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykgew0KPiA+
ICsJc3RydWN0IGV0aHRvb2xfbW9kdWxlX2Z3X2ZsYXNoX3BhcmFtcyBwYXJhbXMgPSB7fTsNCj4g
PiArCXN0cnVjdCBubGF0dHIgKmF0dHI7DQo+ID4gKw0KPiA+ICsJaWYgKCF0YltFVEhUT09MX0Ff
TU9EVUxFX0ZXX0ZMQVNIX0ZJTEVfTkFNRV0pIHsNCj4gPiArCQlOTF9TRVRfRVJSX01TR19BVFRS
KGV4dGFjaywNCj4gDQo+IEdFTkxfUkVRX0FUVFJfQ0hFQ0ssIGFuZCB5b3UgY2FuIGNoZWNrIGl0
IGluIHRoZSBjYWxsZXIsIGJlZm9yZSB0YWtpbmcNCj4gcnRubF9sb2NrLg0KPiANCg0KT0ssIG5w
LiBUaGUgaWRlYSB3YXMgdG8gaGF2ZSBtb2R1bGVfZmxhc2hfZncoKSB0aGF0IGNoZWNrcyB0aGUg
YXR0cnMgYW5kIGV4dHJhY3QgdGhlbSBpbnRvIHBhcmFtcyBhbmQgZXRobmxfYWN0X21vZHVsZV9m
d19mbGFzaCgpIHNob3VsZCBiZSBmcmVlIGZyb20gdGhvc2UgY2hlY2tzLg0KQnV0IGlmIHNvLCBt
YXliZSB0aGlzIHNlcGFyYXRpb24gaXMgcmVkdW5kYW50IGFuZCBzaG91bGQgY29tYmluZSB0aGUg
dHdvPw0KDQo+ID4gKw0KPiB0YltFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0ZJTEVfTkFNRV0s
DQo+ID4gKwkJCQkgICAgIkZpbGUgbmFtZSBhdHRyaWJ1dGUgaXMgbWlzc2luZyIpOw0KPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBhcmFtcy5maWxlX25hbWUg
PQ0KPiA+ICsJCW5sYV9kYXRhKHRiW0VUSFRPT0xfQV9NT0RVTEVfRldfRkxBU0hfRklMRV9OQU1F
XSk7DQo+IA0KPiBIbS4gSSB0aGluayB5b3UgY29weSB0aGUgcGFyYW0gc3RydWN0IGJ5IHZhbHVl
IHRvIHRoZSB3b3JrIGNvbnRhaW5lci4NCj4gbmxhX2RhdGEoKSBpcyBpbiB0aGUgc2tiIHdoaWNo
IGlzIGdvaW5nIHRvIGdldCBmcmVlZCBhZnRlciBfQUNUIHJldHVybnMuDQo+IFNvIGlmIGFueW9u
ZSB0cmllcyB0byBhY2Nlc3MgdGhlIG5hbWUgZnJvbSB0aGUgd29yayBpdCdzIGdvaW5nIHRvIFVB
Rj8NCg0KVGhlIGZpbGVfbmFtZSBwYXJhbWV0ZXIgaXMgbm90IHJlYWxseSBuZWVkZWQgaW5zaWRl
IHRoZSB3b3JrLiBPbmNlIHdlIGNhbGxlZCByZXF1ZXN0X2Zpcm13YXJlX2RpcmVjdCgpLCB3ZSBo
YXZlIGFsbCB0aGF0IHdlIG5lZWQgaW4gbW9kdWxlX2Z3LT5mdy4NCkRvIHdlIHN0aWxsIG5lZWQg
dG8gYXZvaWQgdGhhdCBzaXR1YXRpb24/IElmIHNvLCBjYW4geW91IHBsZWFzZSBzdWdnZXN0IGhv
dz8NCg0KPiANCj4gPiArDQo+ID4gKwlhdHRyID0gdGJbRVRIVE9PTF9BX01PRFVMRV9GV19GTEFT
SF9QQVNTV09SRF07DQo+ID4gKwlpZiAoYXR0cikgew0KPiA+ICsJCXBhcmFtcy5wYXNzd29yZCA9
IGNwdV90b19iZTMyKG5sYV9nZXRfdTMyKGF0dHIpKTsNCj4gPiArCQlwYXJhbXMucGFzc3dvcmRf
dmFsaWQgPSB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBtb2R1bGVfZmxhc2hf
Zndfc2NoZWR1bGUoZGV2LCAmcGFyYW1zLCBleHRhY2spOyB9DQo+IA0KDQo=

