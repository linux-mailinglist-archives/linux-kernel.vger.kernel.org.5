Return-Path: <linux-kernel+bounces-136710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9789D76A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9398B23B81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B585C6C;
	Tue,  9 Apr 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJ0O0D3/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2097.outbound.protection.outlook.com [40.107.236.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4C83A08;
	Tue,  9 Apr 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660292; cv=fail; b=GZt6rUnjOT/i6jURw+yYh5BM+vzE3Zix8A+jhuY6lZtsJiEx40thHaw7XDm3Tu71tLE2CnpenGqZKjoT2eARmSoxCrjj8SjecvTJki39ck58ADuLhiCy7LZjLj6xNbyawvbzE5AVhMcDgLCB7zCRuCBCrNuPL1KuQwFg16qfZkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660292; c=relaxed/simple;
	bh=ZHcViww8vZEVFejLwzLRoYT6NQ1TBnmgQneqjMfc040=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FaeBYVT9Ct5UrcHs0LAYev+yetYsOAbHfdbnKkIhVJkZYDVQg6XBdpDQY8bSCjgcw2aVxTHJWOnFQR7nfJwDjbd9B495feHrYaWVYhjOFy1/vyD2xgybCLD8QignT+10S2JBqvIec6A1Fb4qsRCyql+q/9fi+vGkftuEZscQsVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJ0O0D3/; arc=fail smtp.client-ip=40.107.236.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMNVpP5lISLrVOqf7Sg3zrNr8H0DvWyQVV7kCF9aC064lraRfRAsoxgDaBKuTcTHnhaErfWzFoTVLqTiyrm/N+uZxzG5s/O4S+/GvdCXMxd14CVgIh/OUuEuwhPRF/QjJx2lFiVe7RKRXua1RCRbiI+z0KvBhDQKlNsyFw6GDRn1tbC6urFEhJEJp8sgpmekDbCxOStnvXUm7uUll2z44G6ngONgR32iT24PWa3c2+ri4WgLmqax4Iw/yGcUaYemxEFyVknZqoSqnh2P6qEDjChdZz1D9IEsnr7SUe3C1c5n4y9S1UFWBgLBiWhPsBimpde3JJm/MW8E0GKzqU73gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHcViww8vZEVFejLwzLRoYT6NQ1TBnmgQneqjMfc040=;
 b=ltoT3X0Gd5x19MF3vusPbeOeCgJsZtCzfniAiov9mLp+hm//EYZf8AK+x/aRDEUOoWxq3Py1SCcBnz/Kb3oe2s+RA/GeQDkc+kns1voWgXJAw6P9FR3hh8O63wvr8aCiXp7AUz+jaZ5zDwtDDaRmdCKn69TeBi9qRRXSQFMNJmMTJ/SVOClap1zwVXz/MZgp+pLLFDiIAyZJ/ZkVfB8l3WKcDxKiEnpUvpPbdDi5u3ocJj+m531c+LPr48hdLBJZDz+17BiTwWPBvB8RULpXqjBRkgpkulESGymXVcha72mHyhOGcPaWWFzm1EYYxJmJPSSjBU6wPXVPoDKCS86teg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHcViww8vZEVFejLwzLRoYT6NQ1TBnmgQneqjMfc040=;
 b=VJ0O0D3/wAacxUvNkeKL7kCgPQAnuoR1E1A7LIktsFjy8i/L87VzSVEzowDj+TNHUUSLZ0KliAP1VaCct/Jwh/jEIUWGYSv26gz7cFi34ITW+No9WRJx9WSR/v1QfUgWwIM9WwjCfSqazbPkPLJfSnww9MbaMLyYLIKGlCu5Od+rKX6b9blQqB3cXjRyqQwV7GSqPiJi3Enf/N6VtBk/7rldpme1RsATO66leSZa+oj/qIvtcdAeO3KmWgEMDP/5AIDu/+cFraM1W4RXP0kU/2zEQ9UVVfnE1YDhTCgFnFSYXsQ/ywBl/8+4v/pdXIXyRsigQZM8v4nwZla1LyUN4w==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 10:58:06 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 10:58:06 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
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
Subject: RE: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaibP8CTLNLV9gi0evdveMyJyMArFediSAgAAU5oCAATqgEA==
Date: Tue, 9 Apr 2024 10:58:06 +0000
Message-ID:
 <DM6PR12MB45163D7B0DB9B1A334652425D8072@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240408125340.2084269-1-danieller@nvidia.com>
 <20240408125340.2084269-8-danieller@nvidia.com>
 <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>
 <ZhQW3wxgv_lJF8Ep@casper.infradead.org>
In-Reply-To: <ZhQW3wxgv_lJF8Ep@casper.infradead.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA1PR12MB8467:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vMvJWg1cGp+n5PiRVbs5RmaCOWnKHeX7rZmuWsmVD3kkxcr7HfgEz5131fDEMtuManTL3pTyFDZ0s9pRtLFhvlvNiUh6x6xKCF1okyaAcrIxmCNiim+x7AWP106O9D/8vhOvWOTQExXpgwsDrqhbPe54cNbp5ht/ajxENx4yPePydzx5KI1kT9zaIzH4LtCsG4RNnSOsc1gq/oFMGhQa6PU1hfk/odx93LHDyNSi/g9FJpj9mL0NIvDX9+hQADLby5JlFFBCHVZQKCGfDhNtdlQ9SneZZYBeV2Ed84sQc8Q0jZ4JNU24aCETNXQg+0giKMMm72uNQl13PgRLJUg+wGhYxY3bIEHWu1ROfAeRRhN/GpXEEaDrb9SnmHH/wvGlXUgI9k5E3VszD29++0nDL9zBA4i1wO5QB1ax7pDMZ5ONz+M+kDSVhs64yKH3N8yqrTGNeHDdtK2asIZKyc+S7/AAorSn2ijxa/0hqEF1smQQa7QkybeF9rN/bAhLk4KJtINNA0FR2t87p8j4X/DuU2jkbVO1zA445OKJVTmsOmMIWiV0vFjK+K/dzmI1KwdASO7Izj1VSdq4F+LmUcfxpHse0EN1y/1cK59BCaILTpnT9cY30IH0ZIf0EDHtFHCuffWVdic28cBvWnWikq3ldEUNP5e97aVaxnXYmdJPMak=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3BvN1RTMFp4MFFiUzZiY2ROTlZWYnFDbXJoalhpcW84WVIxRXU5MkxsbjlT?=
 =?utf-8?B?a0k2UkwrQlVTRFBuODlHSEcxNDlXTldjUE9XdDM5VHRhYUttTVpBNWRzMU1l?=
 =?utf-8?B?UlRWeFZwR1ExblIyanc3Q25TWldxekYzVW85LytwV3VEeDFjOVB3Q0NsNStG?=
 =?utf-8?B?MnRFVjR0eEtmQlNSNCtNZ3E2eTJCd2FCOHhvcW03aHlLREtENnhuYkhaZFlC?=
 =?utf-8?B?TDF3N0I4cUlPbEZ1bkJBanVYcHF6VkM4VXYwdk9ia3BydzZUdmpaZ0hjY3l5?=
 =?utf-8?B?OWZYQkNyWGxDc1c1RU5yK0Q5WnZLN04vcXl4YTd6UkZpRGJqNzJNZVBPRWFV?=
 =?utf-8?B?TXZVOUNnYmY4QzVKYzFHR3NJaHdWZ0JXNmdndFZXYzU3SmRzM00xRDhCdnNa?=
 =?utf-8?B?Z2NrSjJCZ0ZyK3VVSEF6MllnRWR5clZqbTVMOFdGRnB6WjYxR3lxSDAvaDRa?=
 =?utf-8?B?R2FqVVdHdWxtUFRsZS8yRWJ1ME1TQjl6QXFMeHNXZ1VmaTE4d2N0SmEvNWlu?=
 =?utf-8?B?dWtLbXhMbWNRUFVGeVVWQkE2Y1A1elpGNWNpYkNuMzlkSkYwL0UrRk1UM3JC?=
 =?utf-8?B?R2k5SjJHMGJHZmZTNHo5L0FhNnZiZCthc0VtRVVtbE9VaUh4TTlXZkcrZHVQ?=
 =?utf-8?B?QWxkNUpDZkYxditqN2dxSDNjcDI0VDB4ZURpaGFzaS9QTHpqMFJTUnVNU1Ev?=
 =?utf-8?B?WjNnU0M5RHRKei9Xc0xrMC9hRXE2QjBHWnRSRWY1TTdFWXJmdncxVzE0Mlcz?=
 =?utf-8?B?aDVCYUhjVWdlUUhScWtCdG5XT2xpVFFmYWFnOXgwbDZkOTZjdXNmVVhyeGJU?=
 =?utf-8?B?SEg0REVPZ3Vhb3BJY2NibDgwbmlGMHpDZTBIaTFQRWJiQW9NV2RENStvU2U1?=
 =?utf-8?B?Q2tLeVdqRnFSN3pTbTJ6Y3cveWFZbklobkJsWU45b3lFYStlOVhlcWRBNmxo?=
 =?utf-8?B?YjVpV3ErZHI4aVFacmZpWWFXZGtpTXozdDlkZWw4eE5ONDRYcFhqOEZ5bGZn?=
 =?utf-8?B?SFZPajdEMmk2OTB4dlBuV2V2dzVjTjNyL2ZPbytzeWEyN3dpYXpzRzNBaUZn?=
 =?utf-8?B?M3hweFdESEcwNXdIZnRJS1lHdVRnN1BQL1VDR2g5aFVIREpub2ZqTGhiK3JL?=
 =?utf-8?B?bHFlcEVGMVZGcEVpaTJtSmZXQ2NiL2VuOTVBVnpQamQrTzZMdDB1dUd6RDJm?=
 =?utf-8?B?ejlhbUhPT2FzWXhVYk9JUWtBTVY1aFRhNjh3Q3hiNzR5eUM2c3RicUxYSkZQ?=
 =?utf-8?B?S2luT3hPbEsxcEFnNmJUUnRVcWlyWWdQa3RmR2Mrb1ZsRmJ6cDg1WGhmYWtI?=
 =?utf-8?B?SEw2QXZvQTJKeDFaMVRwZUNFTjJzQ3RTK3B2NnU5MUg1MkQ5Y3UvYjFDakQy?=
 =?utf-8?B?Q253MDlRdm5ORCtWZ0REY0pIS21nK0xmR2pqNVY2OXpyWFluK2x6enN0bmdi?=
 =?utf-8?B?L0hZRDRtQjM1ekREaFo4dkF0NzZBQWs3OEhNR2V4OXZBbTlBUmkwYUZScXly?=
 =?utf-8?B?UzhMS2FQcDI2cjhnd3VqMSt0T3ZhSmluU3lDVDB0bjl5bGdYS00yWGpYZU44?=
 =?utf-8?B?dmtqQjVzT0gyb281SGlKVGVzQXFnY2Y2dEk0VStsN0lKN3FWZjVZdEhWaTNM?=
 =?utf-8?B?ajB0cm1ZUWZtVXIrZmt6K0EyZkY2VkxZSnZ6Z1IzYzNKN3JpeEdtMlZSYXRL?=
 =?utf-8?B?YlUra0hDZHlzd1E1TzhFTmlzRW1tdkpScmk3QmVTUGxwZXgyZ0MxdmFPaGdF?=
 =?utf-8?B?Z09sSENKQXpvT1AyNDdpc240QTRDRStmWHdSZDMwSUhKRlFraThFc1NJT0ow?=
 =?utf-8?B?dXA0MTAzYkh3aFY1blZVMHZtQWdsU3h6M0FRNlFwQ3VtQ0RuRytxU094U3FQ?=
 =?utf-8?B?Q0s3SnZMVkk3YnBBV0tYQWlhdTFrUmxrc2dIWnZTU05xQmRSdDRiaHEyS004?=
 =?utf-8?B?Z2wySy9VMzFoNzlBbDlpdWhGVUdPeG9UeHJRazJ3cFBCbHgvOE9YbUk2VDQw?=
 =?utf-8?B?RDNVNWxoZ0FuQUpIeXYzNlJRbnRRWFRtM1BGbHNmd0pSRzVQaCtQMm1VSzlD?=
 =?utf-8?B?cmRWMG1PL0NqM3BsRWZXdTR0eGdxRTNkOUlqdXdlVitsK2N2cnFyQ29nT2xZ?=
 =?utf-8?Q?9vq8yddaLLB4misaWbHefyMSo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 623316d6-f3df-44c6-8521-08dc5883ef91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 10:58:06.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydFQ3T6CLz8G6JclrEDZ/+4XIFlyKWlw3MRaRd30r0Qu67oomwHBGHGEMBeAILPejEGNibqktgcJmuHxTCOLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXR0aGV3IFdpbGNveCA8d2ls
bHlAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogTW9uZGF5LCA4IEFwcmlsIDIwMjQgMTk6MTANCj4g
VG86IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8bGludXhAYXJtbGludXgub3JnLnVrPg0KPiBDYzog
RGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFA
a2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGNvcmJldEBsd24ubmV0OyBzZGZAZ29v
Z2xlLmNvbTsNCj4ga29yeS5tYWluY2VudEBib290bGluLmNvbTsgbWF4aW1lLmNoZXZhbGxpZXJA
Ym9vdGxpbi5jb207DQo+IHZsYWRpbWlyLm9sdGVhbkBueHAuY29tOyBwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tOw0KPiBhaG1lZC56YWtpQGludGVsLmNvbTsgcmljaGFyZGNvY2hyYW5AZ21h
aWwuY29tOyBzaGF5YWdyQGFtYXpvbi5jb207DQo+IHBhdWwuZ3JlZW53YWx0QGludGVsLmNvbTsg
amlyaUByZXNudWxsaS51czsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1seHN3IDxtbHhzd0BudmlkaWEuY29tPjsgUGV0ciBNYWNo
YXRhDQo+IDxwZXRybUBudmlkaWEuY29tPjsgSWRvIFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAwNy8xMF0gZXRodG9vbDogY21pc19j
ZGI6IEFkZCBhIGxheWVyIGZvcg0KPiBzdXBwb3J0aW5nIENEQiBjb21tYW5kcw0KPiANCj4gT24g
TW9uLCBBcHIgMDgsIDIwMjQgYXQgMDM6NTU6MTlQTSArMDEwMCwgUnVzc2VsbCBLaW5nIChPcmFj
bGUpIHdyb3RlOg0KPiA+IE9uIE1vbiwgQXByIDA4LCAyMDI0IGF0IDAzOjUzOjM3UE0gKzAzMDAs
IERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4gPiA+ICsvKioNCj4gPiA+ICsgKiBzdHJ1Y3QgZXRo
dG9vbF9jbWlzX2NkYl9yZXF1ZXN0IC0gQ0RCIGNvbW1hbmRzIHJlcXVlc3QgZmllbGRzIGFzDQo+
IGRlY3JpYmVkIGluDQo+ID4gPiArICoJCQkJdGhlIENNSVMgc3RhbmRhcmQNCj4gPiA+ICsgKiBA
aWQ6IENvbW1hbmQgSUQuDQo+ID4gPiArICogQGVwbF9sZW46IEVQTCBtZW1vcnkgbGVuZ3RoLg0K
PiA+ID4gKyAqIEBscGxfbGVuOiBMUEwgbWVtb3J5IGxlbmd0aC4NCj4gPiA+ICsgKiBAY2hrX2Nv
ZGU6IENoZWNrIGNvZGUgZm9yIHRoZSBwcmV2aW91cyBmaWVsZCBhbmQgdGhlIHBheWxvYWQuDQo+
ID4gPiArICogQHJlc3YxOiBBZGRlZCB0byBtYXRjaCB0aGUgQ01JUyBzdGFuZGFyZCByZXF1ZXN0
IGNvbnRpbnVpdHkuDQo+ID4gPiArICogQHJlc3YyOiBBZGRlZCB0byBtYXRjaCB0aGUgQ01JUyBz
dGFuZGFyZCByZXF1ZXN0IGNvbnRpbnVpdHkuDQo+ID4gPiArICogQHBheWxvYWQ6IFBheWxvYWQg
Zm9yIHRoZSBDREIgY29tbWFuZHMuDQo+ID4gPiArICovDQo+ID4gPiArc3RydWN0IGV0aHRvb2xf
Y21pc19jZGJfcmVxdWVzdCB7DQo+ID4gPiArCV9fYmUxNiBpZDsNCj4gPiA+ICsJc3RydWN0X2dy
b3VwKGJvZHksDQo+ID4gPiArCQl1MTYgZXBsX2xlbjsNCj4gPg0KPiA+IHUxNiB3aXRoIGEgc3Ry
dWN0IHRoYXQgYWxzbyB1c2VzIF9fYmUxNiBsb29rcyBzdXNwaWNpb3VzLg0KPiANCj4gSSdkIHVu
ZGVyc3RhbmQgaWYgaXQgd2VyZSB0aGUgb3RoZXIgd2F5IGFyb3VuZC4gIFRoZSBjb21tYW5kIElE
IGlzbid0IGENCj4gX251bWJlcl8sIGl0J3MgYW4gSUQuICBZb3UgY2FuJ3QgYWRkIDEgdG8gaXQg
YW5kIGdldCBhIG1lYW5pbmdmdWwgcmVxdWlsdDsgYWxsIHlvdQ0KPiBjYW4gZG8gaXMgY2hlY2sg
aXQgZm9yIGVxdWFsaXR5LCBzbyBhIHUxNiBtYWtlcyBzZW5zZSBmb3IgYW4gSUQuDQo+IFRoYXQn
cyB3aGF0IEkgZGlkIGluIE5WTWU7IGNvbW1hbmRfaWQgaXMgdHlwZWQgYXMgYSBfX3UxNi4NCj4g
DQo+IEJ1dCBhICdsZW5ndGgnIGZpZWxkIGlzIG9idmlvdXNseSBhIG51bWJlci4gIFlvdSBjYW4g
bWVhbmluZ2Z1bGx5IGFkZCBhbmQNCj4gc3VidHJhY3QgbnVtYmVycyB0byBpdC4gIElmIHRoZXJl
J3MgYW4gZW5kaWFuIGNvbnNpZGVyYXRpb24sIHRoYXQncyB3aGVyZSB5b3UnZA0KPiBleHBlY3Qg
dG8gc2VlIGl0Lg0KPiANCj4gU28gSSBjb25jdXIsIHRoaXMgaXMgc3VwaWNpb3VzLg0KPiANCj4g
KE9oLCB5b3UgbWlnaHQgd29uZGVyIHdoeSBuYW1lc3BhY2UgSUQgKG5zaWQpIGluIHRoZSBOVk1l
IGNvbW1hbmQgaXMgYW4NCj4gbGUzMiByYXRoZXIgdGhhbiBhIHUzMiwgc2luY2UgaXQgaXMgYWxz
byBhbiBJRC4gIEFuZCB0aGF0J3MgYmVjYXVzZSBpdCdzIGFuIElEDQo+IHdoaWNoIGlzIGV4cG9z
ZWQgdG8gdXNlcnNwYWNlLiAgWW91IHdvdWxkbid0IHdhbnQgdG8gaGF2ZSBiaWcgZW5kaWFuIHN5
c3RlbXMNCj4gY2FsbCB0aGUgbmFtZXNwYWNlIDE2Nzc3MjE2IGFuZCBsaXR0bGUgZW5kaWFuIHN5
c3RlbXMgY2FsbCBpdCAxKQ0KDQpIaSwNCg0KVGhhbmsgeW91IHR3byBmb3IgdGhlIGNvbW1lbnQu
DQpZZXMsIHlvdSBhcmUgcmlnaHQuIERvZXMgaXQgbWFrZSBzZW5zZSB0byB5b3UgdG8gZGVmaW5l
IGJvdGggYXMgX19iZTE2PyANCg0KVGhhbmtzLA0KRGFuaWVsbGUgDQoNCg==

