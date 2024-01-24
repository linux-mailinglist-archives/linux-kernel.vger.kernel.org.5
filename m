Return-Path: <linux-kernel+bounces-37281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F399983ADB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E61CB2A93E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B207CF05;
	Wed, 24 Jan 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T4WGr75P"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36007C08B;
	Wed, 24 Jan 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111220; cv=fail; b=tlrquDbTrAujZxJIdz2tJyg0fRtQ1mGh/bblXc7G8LnT2rzo1i1th1r3Dt3BBz5bpcjN2LILHwi3E9v1ooYtBY1htNVikjFiLMUVJshEhfQ+EHEwT/iZEpFIKU8nhBNq9SALBavHSFbJ9JC1RvuqkZvHyKSmlbqTNI824dx70fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111220; c=relaxed/simple;
	bh=/kFi5+1Tpfgr16OT8Mc9j2iZcRYUxRDMtHOPtDjlPR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMIzcJGndK9rL8QnvzFXw/x6kO1OJF4bP8qkP2MKHEWSe/YdCcLglXpxu0RkPQWUDjK7pX0z6LcDLm4muFfPju7DM+KNubaJln8ny6ttTutWL+NW9DW0Metj040h5BPv/grMOOJbAJOIHvsfIspv25fTkPsjU049vHyehu57l0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4WGr75P; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtzB+yrzBsXeLcQGWoJRRXsh180Fn2tMkeqAf8gQ6NyJwes00jTBBalmZsLhggU2iXG2oqK6q+YIEcvWUyQkPGtV3VIebGtwjGGiaVskegUZA1STXaCpvWEPilkng3aiRTWMw6wDgPKB8r2fCGo4Eu33wTTexwSSXRqQH0lIhmIVhsi8R0WOn4CoWHtO8Sps85WmRFrRfIkQKTFiuzGDzHuYjAC2OfwWGWnGHsIlr9ZmVzwkcSz9XGcIm0AdL3MMspOjZKpcm4M26tI7essXya1g+q4Bd78iQ+939B0oyOj82ZCCWjldF8dmSShTilhLYAIMhns7rVdyZrsEtufqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kFi5+1Tpfgr16OT8Mc9j2iZcRYUxRDMtHOPtDjlPR8=;
 b=Y20OAH9+26sU35zd3RgyqyH20jtG9UoohU7/p0ELGCAS29PRfdMXwsZWDTjPXJHsv9ptc0mo9FDyvbrbRYBExZ+bQ/6z9ar14PnUT2D62x6ICJ+/EYKYO+DLlEWPfmCPMAyWRywMHMn8WHV1NYyVcYnjqKT8AO7l4YRHQdveZONxSnGZF8cffzqts1psBUwFYnKJoeO2h+9b9kp5tUkwy/cZveCgw8RfxCDk5qzNro3E/5f1nuZv92avrqJvn+MAJYVCAFdHZHRMjWE++6FTCM/E7M141xp9aI4NcScyoOS9Iakw3Z8M99TdCaUJA0DB9DOU7P9ATPgaE+x0OPKX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kFi5+1Tpfgr16OT8Mc9j2iZcRYUxRDMtHOPtDjlPR8=;
 b=T4WGr75PMJ0KC0ase436af2bN7RGHXlha4mMHaf4a+Rr6VaYfk99km9YQFc2jPNeC1nFt4f5XIQDUbCnkiuNwftL9wCeHoqrZAVH+jhEvZSnEaDRRMmexmBxvWW9+zW5fFvnuyODQMlvR/5MoO0cYwzydvE2lpmKW+ZLpJxKYrHHAlA3G8Od/ZXH6Us58e0T+uqZ2oXMq9CIXQN/vDUflZABwYv7kOdXjJWV9RgmXfaMVjYcM+Y/dblkMMLnjLam+NkdoZV0iUyz3xrX34+p7T6dwOewoqBWXh/5iVhYXymPVuCuBjTBmaZme5raBdPeWvJ0SzZr4v5G+A+TwyL7Vw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Wed, 24 Jan 2024 15:46:56 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:46:56 +0000
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
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7Dm2XcAgAB26TCAAD0fgIABkOfw
Date: Wed, 24 Jan 2024 15:46:55 +0000
Message-ID:
 <DM6PR12MB45169D23F12F3680FF8E07F8D87B2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-10-danieller@nvidia.com>
	<20240122210534.5054b202@kernel.org>
	<DM6PR12MB45168E425B2C1832F6D26453D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20240123074955.72c27eb0@kernel.org>
In-Reply-To: <20240123074955.72c27eb0@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DS0PR12MB6485:EE_
x-ms-office365-filtering-correlation-id: 7fe86283-a694-482b-a918-08dc1cf3b17d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CrIfuo2AieS2cy5Ct1PvwF7mNmcJeeH3mlRGHEXnzM8YOzABeRufpbn1FgE5e8BAJP+T2Fje5H5D6cfJQL5lo05qOxt/ofRGsYQRI7tKGbE455CcmTvqj6lkLMsvwtB7Tpv3WIL5wNuVq1hgMoIp1Hp1qtlUugDopdD6nWR9hGSgU1YkMH6AuY1ZXiC7lrjAMyMEQ+nMQLb53JICuk15WbK0jK6ywL1H5332njr2+DO2OanpBJi3VHl42IsYYZjbqia7LM+pfLXf0uqOO6ui2ots2tUMibCh1S6skRcPOP/z6XadIGHYs7MxRVYPPINptLR0rFMgRwl78wI1vawrebTlAjSBqRYAp+hqDyo/sBF9A1aGOx1iiO8Uul95RpLmcThx0Q9BhinHgauaGZ1w4/pAFy5z44W21q5pkoeeWEvOac4xm98YE/zkfDLxWmTzDq3WQ9g9Bn30MyZUDKQOoNKi1v/bYIEtOG1Fk4Of4WgOBQePB9U7hVlruVpn1seyzAxNYlSn84N8ISWLupMloPz70DO0xPaR/bK+moz5O5L/CudjuPSCMpHhNDrFerKX9UqkFD0SXb3XPkiXpfoGG2i7VYzhwvE1HJwYD3yjeVK4Q3bphxLnuoMAPZBBfyZY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(107886003)(55016003)(26005)(38100700002)(38070700009)(478600001)(6506007)(7696005)(9686003)(83380400001)(71200400001)(122000001)(5660300002)(2906002)(66556008)(66476007)(66446008)(76116006)(66946007)(33656002)(316002)(54906003)(86362001)(64756008)(7416002)(8676002)(8936002)(4326008)(52536014)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWptZmpiVERyUmg5d0NhN0hwRGFtRFpFa3ZwekhTZTR3NVNlaERxbHNTSWo2?=
 =?utf-8?B?TldmMEFTZFVBd1NZWDlhSGJSWVZ0QmowZU9nVHFzNFNvbUpVSnd2dC92YmZu?=
 =?utf-8?B?NTZreUs5M2xXc3JtZW5uT2dYbVJmL3N4ZzkzZGNlS1dpK2o1RzNxY2RlWE1O?=
 =?utf-8?B?M1F5eDc2KzE0Y0dWS3pjWUxrOWRwYVJiZzAvaTkvLzNRSFpWQkdtVWFWRkNw?=
 =?utf-8?B?SGlDZXFXZjJzZ1J3N3FYS3RXcEZ3V0lWV0oxaHYrWjN0azVhM2NnU1JwM1gy?=
 =?utf-8?B?WmZXV1ZNUmY2Y0JGTlR0ZVB6aEd3aUk3M2JrWm96NkN4dmlPN0JJaU41c0Fu?=
 =?utf-8?B?WkhqODJwOHJEV3hETGtYTEhYUlNwNFRlQk1jZlRJaWQvMGx2QS85OU5QMUIw?=
 =?utf-8?B?REtmc3NWdE9Zdmo4RkdWSndXT2NvdC9hUDRoKzJIQWR4T29xalJDdG1YME9V?=
 =?utf-8?B?a2ovak9BK3k5N2l2UzBSL1dHeDVyLzdwYmdHNndDaWFLbEI4V0puaDIzZ3c2?=
 =?utf-8?B?WFpaemplWWhXSXVHeVBmK2JPQURwN24vdTdUZU9CYStVK0E4K2FRdFBVTjRT?=
 =?utf-8?B?MEdSVmtGTnVwK1RwVFhXQ3p4YmFVWVRoUzNvUUZya0o1WjJhbm5zR2tRUlJJ?=
 =?utf-8?B?b1FueXIwRUxnaG80VWZmSGVBMHVWckhwYm5sNkQ2dGRxNENuU1h3RmJnWjRi?=
 =?utf-8?B?VnoxU2JYUzlodkNsUFdoY0FSM1J2cFFaZGFicW5yOVJDREJrVjJMUFZnNytj?=
 =?utf-8?B?Q1M5VGFiUXFZb0ZvaUZnZUN2cWtPeXZIWlg0S0hKUG1zR0I0NFBzelZNOWUz?=
 =?utf-8?B?K3RiTDlBV3RjaTN3c2N5VlRKVUVRQndTYjROL3V1YkV6MjVaWHZ2ajQ0Rkpx?=
 =?utf-8?B?MkRrQTk5L2VtbXJ3ZktINjBSOElabEhrZEVDUnA1MEZ2eXJpUWlvUUwyVzl4?=
 =?utf-8?B?d0tGaXFHZEw2andsb1I1a0FMc3pRSnR3T2x0ZExtMmcrc0VidXZrdytscTMv?=
 =?utf-8?B?YTRxekR6c21CZjBTNjlFcVdDU2JXVjVtUGhNNkZJYkdvaTJ6TjRSQ2xHVlp6?=
 =?utf-8?B?bUhnREVlTlhWWjA5V2RoRmxDdldnUXRNVnlNanRZTzRpUlhqZ2JFK3ljbCt5?=
 =?utf-8?B?bXhNb3JTY1lTUkZNWWpnQWM3RW0vbU5LQy9EYm5rVWxDQ1MzR1JSckRsVjhJ?=
 =?utf-8?B?cGpQY0NQcjA2RW9wSGp2VjdWUkN5eFBKK3pNZHZYL2gwdE5qYU9jTmNaOXoy?=
 =?utf-8?B?d2FwdDhNaHllL3lYZXBvS3krMGZqcDg3ZUpzYnMrR0ZKVzkzQ3kxREZTQlpX?=
 =?utf-8?B?M3Q0S2NpcnlkWWpmcmxHYUVHNXRBZmZWSXoybGNkaW83KzZiOEpiZ29Nc2J0?=
 =?utf-8?B?bUF1ck9laTE3cC9iUE9DeFRQUUdCYnluUXR4YTkvSkpHR3J0VmdjNm9qRGJ5?=
 =?utf-8?B?dS9nNHVLRWFUcTAxMWo2blNSTVB0WlZDTEtLRVBIdEEwd1BLU3pYSW9uMVpW?=
 =?utf-8?B?bHM3akhLT2xMRUNBc0U4Yk1SYlVDNEQ5a3R5MmczT1VrbzYvYU9TTy83Q0VN?=
 =?utf-8?B?RnlDUm9RRmY4RVAwc0dFSkg4VThVZWN3K2VHQWNUd2dpM2NXQS9wT1h3UFhB?=
 =?utf-8?B?TW9wcCt3bUl1dlR3M0YvTU5OS1VhRjJmUFlyRFZIMzJSU004V0VsR0NIa21L?=
 =?utf-8?B?TCtNb1Q2aC81REV4aGR0cEE4Z1ZvOURpVTBtTUpGTXZGRk80MkJwOEF4b3Vx?=
 =?utf-8?B?Tm1hdmJpR3NCRDRXWmtCVnU2UVY0akhiRHJjRlF5N1FncFhCeC9FOHZnOHFr?=
 =?utf-8?B?M29GR2s3cWxXcE5vTnpRdUhyUTZ5SXFHK0lObHVUbUVqRmJCUTk0WU9hT3Y0?=
 =?utf-8?B?ZGVhL2p1cXVzUXFUaEZkaXNNdnlpVVNOMkRNOGRUTTdrZTNGYUlQYzZ1MXFZ?=
 =?utf-8?B?R1JzNko5RktFcFpnZFN0RWhyNEkrV0Y4VlRRK3lGNURnSEI3cnEwQ1FJVHhp?=
 =?utf-8?B?aXNzUlh4N1hSN0xTMVRyRy9zbWYyQ2NjME1DZG1xdTBpTGc1WWxpVEFlMmpP?=
 =?utf-8?B?elpSSUxCNFZUQ0twMXhIU2xNN1M3eC9UQi8rMlNsZjRYLzlMengwZWUvZTQz?=
 =?utf-8?Q?ViH/MhoKWH/2Wlw1OseEV1pY2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe86283-a694-482b-a918-08dc1cf3b17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 15:46:55.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFHhfZKqnBqOy+zEj4mTHTqsNE4wC2J33hapdzA88HM5Xo7mb3eGbcKHtH2/ThTu1EQZwOxERlWVYX4Me4MUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

PiA+ID4gR0VOTF9SRVFfQVRUUl9DSEVDSywgYW5kIHlvdSBjYW4gY2hlY2sgaXQgaW4gdGhlIGNh
bGxlciwgYmVmb3JlDQo+ID4gPiB0YWtpbmcgcnRubF9sb2NrLg0KPiA+ID4NCj4gPg0KPiA+IE9L
LCBucC4gVGhlIGlkZWEgd2FzIHRvIGhhdmUgbW9kdWxlX2ZsYXNoX2Z3KCkgdGhhdCBjaGVja3Mg
dGhlIGF0dHJzDQo+ID4gYW5kIGV4dHJhY3QgdGhlbSBpbnRvIHBhcmFtcyBhbmQgZXRobmxfYWN0
X21vZHVsZV9md19mbGFzaCgpIHNob3VsZCBiZQ0KPiA+IGZyZWUgZnJvbSB0aG9zZSBjaGVja3Mu
IEJ1dCBpZiBzbywgbWF5YmUgdGhpcyBzZXBhcmF0aW9uIGlzIHJlZHVuZGFudA0KPiA+IGFuZCBz
aG91bGQgY29tYmluZSB0aGUgdHdvPw0KPiANCj4gTm8gc3Ryb25nIHByZWZlcmVuY2UsIHdoYXRl
dmVyIGxvb2tzIGJldHRlciA6KSBUbyB1c2UNCj4gR0VOTF9SRVFfQVRUUl9DSEVDSygpIEkgdGhp
bmsgeW91J2xsIG5lZWQgdG8gcGFzcyBnZW5sX2luZm8gaGVyZS4NCj4gWW91IGNhbiBlaXRoZXIg
dG8gdGhhdCBvciBtb3ZlIHRoZSB2YWxpZGF0aW9uLg0KPiANCj4gPiA+ID4gKw0KPiA+ID4gdGJb
RVRIVE9PTF9BX01PRFVMRV9GV19GTEFTSF9GSUxFX05BTUVdLA0KPiA+ID4gPiArCQkJCSAgICAi
RmlsZSBuYW1lIGF0dHJpYnV0ZSBpcyBtaXNzaW5nIik7DQo+ID4gPiA+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCXBhcmFtcy5maWxlX25hbWUg
PQ0KPiA+ID4gPiArCQlubGFfZGF0YSh0YltFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0ZJTEVf
TkFNRV0pOw0KPiA+ID4NCj4gPiA+IEhtLiBJIHRoaW5rIHlvdSBjb3B5IHRoZSBwYXJhbSBzdHJ1
Y3QgYnkgdmFsdWUgdG8gdGhlIHdvcmsgY29udGFpbmVyLg0KPiA+ID4gbmxhX2RhdGEoKSBpcyBp
biB0aGUgc2tiIHdoaWNoIGlzIGdvaW5nIHRvIGdldCBmcmVlZCBhZnRlciBfQUNUIHJldHVybnMu
DQo+ID4gPiBTbyBpZiBhbnlvbmUgdHJpZXMgdG8gYWNjZXNzIHRoZSBuYW1lIGZyb20gdGhlIHdv
cmsgaXQncyBnb2luZyB0byBVQUY/DQo+ID4NCj4gPiBUaGUgZmlsZV9uYW1lIHBhcmFtZXRlciBp
cyBub3QgcmVhbGx5IG5lZWRlZCBpbnNpZGUgdGhlIHdvcmsuIE9uY2Ugd2UNCj4gPiBjYWxsZWQg
cmVxdWVzdF9maXJtd2FyZV9kaXJlY3QoKSwgd2UgaGF2ZSBhbGwgdGhhdCB3ZSBuZWVkIGluDQo+
ID4gbW9kdWxlX2Z3LT5mdy4gRG8gd2Ugc3RpbGwgbmVlZCB0byBhdm9pZCB0aGF0IHNpdHVhdGlv
bj8gSWYgc28sIGNhbg0KPiA+IHlvdSBwbGVhc2Ugc3VnZ2VzdCBob3c/DQo+IA0KPiBJJ2QgcGFz
cyBpdCB0byBtb2R1bGVfZmxhc2hfZndfc2NoZWR1bGUoKSBhcyBhIHNlcGFyYXRlIGFyZ3VtZW50
LCBpZiBpdCBkb2Vzbid0DQo+IGhhdmUgdG8gYmUgc2F2ZWQuDQoNCkl0IGRvZXNu4oCZdCBtYWtl
IHRoZSBtb2R1bGVfZnctPmZpbGVfbmFtZSBhdHRyaWJ1dGUgcmVkdW5kYW50Pw0K

