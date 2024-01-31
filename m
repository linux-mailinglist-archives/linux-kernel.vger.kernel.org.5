Return-Path: <linux-kernel+bounces-46383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27774843ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFBA1F2EF51
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133F7691D;
	Wed, 31 Jan 2024 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M7qu8hcn"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361069D2E;
	Wed, 31 Jan 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701892; cv=fail; b=uK6gIHwyqZBTvIjlQKO4WbMwq2vBStb3QGkUjZ/4H1cXLU/h69kxmfd4SknvHE5uDsfKBwhCE1mKG3zo1yrgvxHdCORY8dRU+Hf2ZT5pVniYYsAAJ/mCIBuI21noZ2VRSyZBzjUaKB7NJUH3lZhk2eJsGxwh71q0ftkSNP0kjGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701892; c=relaxed/simple;
	bh=hAmicKl3kkXi37TFt2mePtIZ37RlcC9TKkcttcOnlug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sU/HTk2IFmPpsIq/Ui5Yroq34Pz5s5hQrcSshlMueHYnM01YZSp/wTNUEct3jJ/NNTT+Dhs9JboaR5YEVYEhpsQjtbKlc6qTvssaKntbbkfaaKYUvJLjbSukqv2+L6vIKtL0fE3LxFv4IiuvfYatjk2DMc06hDcSsPdBTue1HlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M7qu8hcn; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTid27bEMHkhbb2QXDH7QkR+P6IDliIZK2UHhjwhaywQiugt4JcpfKwuI5r0wmJHlkXtKoKrP0wjfs/8tgqnXyK+9pVbUbMKlVGjU2fPA0Fwoiho4UaRMYbl0/TCUoi3/PtQyVkVTUAtWQNFb2ZTU3TANsBlN07aiDyuFaTOXSIQ0f43EGycS43BSDarTL3cnScUhR738F0OTJGyD7qXLg3dtwE30q3z64nw71ayJYdBdeSkXj1MMInMir21QfZF3BSGGgYYFukJH5kMBHkxW+RDij4JLepbdKiEadHAqdWVEv92BM8qmfwWWHpA6Yjx+rLN/i+KD8puhUZWksDOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAmicKl3kkXi37TFt2mePtIZ37RlcC9TKkcttcOnlug=;
 b=YmfxaFR8YXdBplr0pdrzeZeneI4lTkAuZ+jsnSMwb4cy3hy/ndX8Tdmb5VtnlEsyfoZ9kW2IWOdCRcOHQhVLJte4JOCcTgcETo81xaTWZFIBMvFGfLYU04ILOHyR+kVGQt1w5bbZzpzO2HnRXFTftdi1ugBlFouXQggQJqvaFc0VHAy0xMXKT1qyfrIqRpzrN8ovd18kFKYwflkcfJt3kx2VzSn7PeOpMjlDBszIAIUWQHjFP1Hl7Q9V7L40Yj/6JOMMqAnpo4GkelKDbgn3SxpvWVtRtA68lJw+0MQ3Xqbm486oeSXRQhOtR9jK1xkQUCvoCpeynL96s42J+jQegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAmicKl3kkXi37TFt2mePtIZ37RlcC9TKkcttcOnlug=;
 b=M7qu8hcnY6z8lzKFTzh914cRNb/s/foGtsYjcTKkjUSeBHuW0RWnjpNAJuRIiAoCvDC/cu2gFu6wy43MfxX7VkStGXVQGOAiTt3mPOWfzR2Go2GE/0CaA0nAhpuq6LU43uFdHfJfMQblQ3kx0X0iLxA/I3JBrLf8CTISzqLw1Zn0M88+za6VZEQDKkDGYwnMyxQStI9jbT8nbuIdnmg7e8kR1QQ6Ccyn70ocMFhT6+Akqsk5FSXKcx5Eb/WrMKnv/21/9n+ZZsRs8+pIkOi2hui9Qm1WtJKVf0QbwjPhuO0LQ5bn+/GM9d5Bh4naTvC0yWLdY7DCH/euVCrROEPt2w==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 11:51:27 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 11:51:27 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "sdf@google.com" <sdf@google.com>,
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
Subject: RE: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Thread-Topic: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Thread-Index: AQHaTQ9wgRzMSsypjUOlyEfOvVgnwbDq/18AgAjcG2A=
Date: Wed, 31 Jan 2024 11:51:27 +0000
Message-ID:
 <DM6PR12MB451624E10A2614AFBFB70E73D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-2-danieller@nvidia.com>
 <9eecccb0-a875-4dbc-b88c-5b2aad838305@lunn.ch>
In-Reply-To: <9eecccb0-a875-4dbc-b88c-5b2aad838305@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MW4PR12MB7333:EE_
x-ms-office365-filtering-correlation-id: bc64a1bd-14ef-4c7f-069f-08dc2252f4fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8IHoE7FPtSaG+IB3+o2jFIH5ODdNeeGVWsMbBO0LzUaNGIloHFiS5okwCvo03gucBUAnK/JmjeP53AVcKsgrRk9rndCkEitUxmc53rmXvOn5HuSSl+zDGJYjZVKdDoLOr6G9RctfIuiW4iYY6APPn9Y+LAjk4eX9ho1dfCrRu990Tc83TgdNhTYH24I8I9PaIW8goB2ANYYLRPnfdlq1XIdJamqJOSIa3WWqnxhKpDTsxLpcfGIb0D8BEWw85iqHGmdH2Kla2EVCNc6Q5rpVZHUz4eCd7++1JGRCD8GFPzP+H+3vSP/L+Cy1aLBtnZyuENjNm5iwkXvAtDiSrFxi/yB3u4K/p76EYuSpN2qK9IchLq0LBOKXlBTvNzcE8FuVaw3AdGAdBQLj+j68P9209uxwxqqQlrWAtfVuLcY6uCnfIwad5i7IuMIHduG7IaFXOw6S/BFy0i6FeM5UlLWXwsgN9t650drVfzVSv2D6plaZfpTc5gf1iYK9m5P7fEEkB4OBSzekk1JklLgHXWYl1o4Ak4T2vC68WumubdOmw7anuik674UBOrH6WxX4k4o/bUY6tajzEzaONY5GxYLsHSriWSKHFdOwb3YfbaNJE2zh7oVpqiCRbL6HlPM3lbPP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(33656002)(41300700001)(86362001)(38100700002)(71200400001)(6506007)(7696005)(8676002)(7416002)(8936002)(6916009)(64756008)(54906003)(316002)(66446008)(66556008)(76116006)(66946007)(66476007)(478600001)(4326008)(5660300002)(26005)(83380400001)(2906002)(52536014)(9686003)(107886003)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUk0dHNsQ3kyUGJWYndQM3hCSGh0clJaSjVmSUtTZXFkYk0wVWROTzZqbldh?=
 =?utf-8?B?TitYNmRxNWdPeHBLRzlySGM5cGEraENMUGNBMmFHM1lROTllK1ltQjdyZlBZ?=
 =?utf-8?B?TkdkNmFvZVpaNWV3VHp5a2pPc3gyUnBqKzIyMUZUL0poVURkZHA3Z1BqMUxD?=
 =?utf-8?B?RVQxUDFtT0N2RmgxL1oxT0l6QlBUQ0tJSkJpM0NvYUF3dTZrV2RETGo4MUNS?=
 =?utf-8?B?VXV5WjZIZ3c4bnluTHRzeURSc3NWenRYVkxkeUY2ZVBmVzNlVVFMVk1lYWlK?=
 =?utf-8?B?MDBickNwWFNZMGQ5UlluMnVyODVxVGdZMFNnUDRVbTJOSDd6SFpZSDBFYmdD?=
 =?utf-8?B?azVXbExjbU01TFc0UEJHNUdNVDlZSTNtK3F1WW5ZdXR0K2VKMDlpUG9nK29L?=
 =?utf-8?B?ZGJMeEZId3hEWDY5OUttRkxmZ3NQUXVWNTdxZHE2T3FkZHgvbmdpV0M1Rmta?=
 =?utf-8?B?ZVg2dXVldVdiR0VFcXBMRnZrMUduc1gzeXRBZDM3UWlCTlpXMGJXQ0QrTnlV?=
 =?utf-8?B?QXExUytoSEVBNFRTa3pJUnQ0Z3k5S3VPV1MvZHMvbVI3S1F6UEVxVmlxeTZ6?=
 =?utf-8?B?Q0U1VXF0YkxMOFNuU1NrMVBMbjg5c0ZneEFJOGY4emMzWFhoQXU4RmFnc1lw?=
 =?utf-8?B?MWxGVktBRS9iODVXcDI5amJveVY5Z1VFU25UN1daUXZXbmptVHUvdEViLzJo?=
 =?utf-8?B?aHdOYVQ1YlNtSHhSSGwvN1MvaTZGNlM2cGlvMGNPRG10R0xYaTlRTXdvN01Q?=
 =?utf-8?B?MGRINEFkbHhWY2NUYUd4SkhpMjMyRzRrc3ZFWm9LSkRybjhBZG1JeStac1NQ?=
 =?utf-8?B?azE5N0lFTDkrOWdBeTVEeEpkaDVBQU4wMTEvelZrbTVrTUR0WjRudnhzSDlN?=
 =?utf-8?B?Q2lBNGVIdjBnZlBxUUxPQ3M1RFVBcWZkR09TUmtRRDZlVGNYM2ZucWMxaEZG?=
 =?utf-8?B?L01wUmgvL05RUWFzN3BwaDZRL0lIaXNkem9EUURzSEwwb1FUTDBYenlCVVBr?=
 =?utf-8?B?a1pzRFRoM1Y3Vkg3bnVPdURPK2hBck5kODBmR2xrNkFOMXkwRzkwVjkxWVdM?=
 =?utf-8?B?V0JONjBJYWY1MWp0MlBJY3UwV0NWZGxiaUt4Sit0T3JpQnUxR0dnZjlnelRB?=
 =?utf-8?B?TEpwT01MWWdNQ3lXRm9Qc3l1MXNRclptZTJZTHdvZzAyTlVmNVd4a0ZvdkJE?=
 =?utf-8?B?NVVDVDlXREw2WUZqT3prcDVRS3lzcDNLVUJXQ0dKZW1zckw1RXIvZERSMnBM?=
 =?utf-8?B?UFAxUnZwM0ZpM2s4U2N2Y1NES0YrcEk3STZKckEwc0l2Y2x2YmR3SnZDbFNz?=
 =?utf-8?B?elpqeXE3MzVKcnJUU3h5MUpuK05EempXblZ3ZGlpNzBLT3NaOEQ4Y1Z0ZDZl?=
 =?utf-8?B?TytvZDZzZUQwQ21CNXVsOHFZSWNxQXM5ZUFSdng3M0F5NjJzYk1hWjlVSGZE?=
 =?utf-8?B?M04zbFlUUFdFYmNZRFZ4VmlBQWYwYWl3UitMUkZkWi9RM29UMWFEZFRHYnM4?=
 =?utf-8?B?R08rRmpDYXBVb3hLNUxMQ3JKWm9NdlhINzVhOWQ5b2Fmdm80dThlMUh6QnZN?=
 =?utf-8?B?NUxDcnBXSWZhNjFuYnlIS3JsemZpNVluRWxGM3YxMHl1NDFaaHliRHB3V241?=
 =?utf-8?B?MjEvenlpY1pzQ2J4MUlxT0h6L2JsSTd5Q3NWdXNSblFhNWx0bkc0UTdLbXFM?=
 =?utf-8?B?MXRKMSt2cW9uM1greW01bEhkVGFtekdUZnJCc2FXaEJXcmhNNm5VSzZRSVZu?=
 =?utf-8?B?aDloUmt5Uk5aSFp3ZkhYQlFvWE9wR1AwSGFETEh4UytCZ0hnQU5QZWdVMEVo?=
 =?utf-8?B?UUh2WlRhZ3V2cnBySk1WM3ZLY29lSlhWWDZadnM3T2hrRCt5dDdBdlBIbWNV?=
 =?utf-8?B?VHo4dUk5cVU2MjlRYUkvbmRjMjNYamlrRlhWdkJzQ3UvVGhiMUhETlZDR0R0?=
 =?utf-8?B?cGpxc0tjSUhoU0drUko3K1Z3cTFRTERyYkpCZWlVMFcycW9iQ0lOd3ZBTWFv?=
 =?utf-8?B?RVY4QmFEcVhmUHRLUmUzbHpiRGsyOXVyazdVSzRCTk8wVEtBNTFydVRCRTdx?=
 =?utf-8?B?YzI2a1l1RDBTMUxNWElvTmFXaVV2MXZKYjZ6bXBvbTl5OExaTitwVitvbjdz?=
 =?utf-8?Q?4TDnOPe/0zeuc+iDhqdmHgccG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc64a1bd-14ef-4c7f-069f-08dc2252f4fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 11:51:27.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5ec3qyinhRgCm79oPy8xgo8S4LuthZd+9i0MUn5dpEqFEqp9Xq4z7KLqkNpnvAYDENWSRnaNVG6H0jiXmKjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

PiA+IEZyb206IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQo+ID4NCj4gPiBFdGh0
b29sIGNhbiBhbHJlYWR5IHJldHJpZXZlIGluZm9ybWF0aW9uIGZyb20gYSB0cmFuc2NlaXZlciBt
b2R1bGUNCj4gPiBFRVBST00gYnkgaW52b2tpbmcgdGhlIGV0aHRvb2xfb3BzOjpnZXRfbW9kdWxl
X2VlcHJvbV9ieV9wYWdlDQo+IG9wZXJhdGlvbi4NCj4gPiBBZGQgYSBjb3JyZXNwb25kaW5nIG9w
ZXJhdGlvbiB0aGF0IGFsbG93cyBldGh0b29sIHRvIHdyaXRlIHRvIGENCj4gPiB0cmFuc2NlaXZl
ciBtb2R1bGUgRUVQUk9NLg0KPiA+DQo+ID4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBvcGVyYXRpb24g
aXMgbm90IHRvIGVuYWJsZSBhcmJpdHJhcnkgcmVhZCAvIHdyaXRlDQo+ID4gYWNjZXNzLCBidXQg
dG8gYWxsb3cgdGhlIGtlcm5lbCB0byB3cml0ZSB0byBzcGVjaWZpYyBhZGRyZXNzZXMgYXMgcGFy
dA0KPiA+IG9mIHRyYW5zY2VpdmVyIG1vZHVsZSBmaXJtd2FyZSBmbGFzaGluZy4gSW4gdGhlIGZ1
dHVyZSwgbW9yZQ0KPiA+IGZ1bmN0aW9uYWxpdHkgY2FuIGJlIGltcGxlbWVudGVkIG9uIHRvcCBv
ZiB0aGVzZSByZWFkIC8gd3JpdGUNCj4gPiBvcGVyYXRpb25zLg0KPiANCj4gTXkgbWVtb3J5IGlz
IGRpbSwgYnV0IGkgdGhvdWdodCB3ZSBkZWNpZGVkIHRoYXQgc2luY2UgdGhlIGFsZ29yaXRobSB0
bw0KPiBwcm9ncmFtIHRoZXNlIG1vZHVsZXMgaXMgZGVmaW5lZCBpbiB0aGUgc3RhbmRhcmQsIGFs
bCB3ZSBuZWVkIHRvIGRvIGlzIHBhc3MNCj4gdGhlIGZpcm13YXJlIGJsb2IsIGFuZCBoYXZlIGFu
IGluIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgYWxnb3JpdGhtLg0KPiBUaGVyZSBpcyBu
byBuZWVkIHRvIGhhdmUgYW4gYXJiaXRyYXJ5IHdyaXRlIGJsb2IgdG8gbW9kdWxlLCB3aGljaCBt
aWdodCwgb3INCj4gbWlnaHQgbm90IGJlIGFidXNlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gQWxz
bywgaXMgdGhlIG1vZHVsZSBmdW5jdGlvbmFsIHdoaWxlIGl0cyBmaXJtd2FyZSBpcyBiZWluZyB1
cGdyYWRlZD8NCj4gRG8gd2UgbmVlZCB0byBlbmZvcmNlIHRoZSBsaW5rIGlzIGRvd24/DQo+IA0K
PiAgICBBbmRyZXcNCg0KVGhpcyBpcyBwYXJ0IG9mIHRoZSByZWFzb25zIHdoeSB3ZSBrZXB0IGEg
ZmxhZyBmb3IgbW9kdWxlX2Z3X2ZsYXNoX2luX3Byb2dyZXNzLiANCkkgdGhpbmsgaXQgc2hvdWxk
IGJlIGRvd24gc2luY2UgdGhlIG1vZHVsZSBpcyBkb2luZyBzb21lIHNvcnQgb2YgcmVzZXQgZHVy
aW5nIHRoZSBmbGFzaGluZyBwcm9jZXNzIChhZnRlciB0aGUgUnVuIEZpcm13YXJlIEltYWdlKS4N
ClNvIGluIG9yZGVyIHRvIGF2b2lkIHBhY2tldCBsb3NzLCB0aGlzIHNob3VsZCBiZSBjb25zaWRl
cmVkLg0KDQpJbGwgY29uc2lkZXIgdGhlIHJlbGV2YW50IHNjZW5hcmlvcyBmb3IgdmV0b2luZyBp
biB0aGUgYWN0dWFsIHZlcnNpb24uDQoNClRoYW5rcy4NCg==

