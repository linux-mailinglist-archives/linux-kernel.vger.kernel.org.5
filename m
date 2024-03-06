Return-Path: <linux-kernel+bounces-93471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5D873045
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECA61F21A93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52DB5CDE8;
	Wed,  6 Mar 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEHPVflq"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F55CDD2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712611; cv=fail; b=WoaaFCsTs3L+rNgUvg1nubS/7160zKmaW5+R4LJ0UlmIZOH0IUKz8mPfi+nnfPJB7hYjsyqrTYjnkfVo4IKje/IoLVcempHXNcN/Ub8b431nfAvZQd/rhJBIAvbJDJyHYqCgQdkdzVT7VKEr64m+HmyXnzwezpJZkWzmvCZx9qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712611; c=relaxed/simple;
	bh=EN/KSs7Tg/BNq2G+0Nk2oelvDv2oNVKLc9dRNNug1eI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLw4yxBNFz4uq3TU+9lb/fV+EtDO8hh1mH+yswZbUrBwFeX/6+/OdkwzzxaVzVgmVunhRgAZRFBLAA08jOdcCJYK7C+cBGwHgn3eXuQ4bCBxKlueDBLttw1N7HicMn71quzIKYodR7ZrMVut62iejCEvX8RLMMBgQq++17zqiXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEHPVflq; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw/6JC3zxgwdWY9TnI1bbKYHvZW+PoHFMhlxBEnP6QgWT42lUwMgF0Pz+S2vfjuQySSRvfae7Q8OvY/oCkKg+v0Y3tWOhnkLcadPPwKOes/ZrGDvaYGrS55rae/ecU0Ju4h1vNdXSlFasOM9SI1hjjh009tNlzDxGqTFApdD/QJgAa8Vecw4XNM6byB1RTlDyO99y2gHUeCgBf8BV2fCj+ywG+x0jUe31fZO0/7mt7QhsZTAtt14bjXERUZYdx5QWsQR9OCXsx1d9V4qUs4jj+xZAuNyYfEw3uB26kGOGDfuf/rbydimxX+y4QSm2D2wwmebVZ52usOWSkyRyYUn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN/KSs7Tg/BNq2G+0Nk2oelvDv2oNVKLc9dRNNug1eI=;
 b=BS8NIPBv7X5YdVyKDO6Wk/TqPe0H/ylyPTl2DVb08t4SutGdTNE06hj+7v2CRGTRdbSmCXBvJ0xD0H9mWPwcCSMe+sHgltIxKfWFRGWZNtRtf+fnTzMZCI/b3lFgPGBt3G3oqhKJ4gkRmyA+HoF/K6yBWDrNI7e95pkHukpwXYTl+1HU22wIokFYC/Rbz2vR7dIMbQKFJUoo6rYZk58K640vc1zxkOBymtdLivtKNRuwc+gLZ5P2RuI83DlSq1KmIrDvACrClh3S7aDwRoAPY9hHEtI0RM5Rotrp+t9U1kj9MeAG8FboYvR1BJfnocZbiMjA1rARs6yLBzOp+qv0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN/KSs7Tg/BNq2G+0Nk2oelvDv2oNVKLc9dRNNug1eI=;
 b=JEHPVflqudwz2juIHchxJRz8VzNrcs6H5CZ795N7SRic8lNl8/bU1SK2zSuinmBjurU8STxFavWaBFBhgfz+15DWFQeFV5qo7QUsRnjCIhtKAJEk4iY+HymVTIWOmfBA9BTbOcU5e0YU7XFI9WyKRIqPf7/hM8PXrWw7DQBX+fHHvyyn0WvjjTYts+AHZzieLKn7zPVPOVyjPNlr2m50/W67a0JZ0sWm3MB0Mm4PLNUSOcKppw+J0bHwBZQbMWLP6te+JdyxsQtu4phWoVLupz17pIMJzA3o4ot6XwZ80VlkD+w3gJMnpEpQcsEsAbYw8L6B0l1xWvLUAemqZpKfTg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 08:10:07 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 08:10:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] nvme-tcp: short-circuit reconnect retries
Thread-Topic: [PATCH v3 1/2] nvme-tcp: short-circuit reconnect retries
Thread-Index: AQHabtM9CNalLiPrU0qnFsd9vthlArEqXb4A
Date: Wed, 6 Mar 2024 08:10:06 +0000
Message-ID: <6ad59e60-0c0e-4164-8960-a0e8dbd60152@nvidia.com>
References: <20240305080005.3638-1-dwagner@suse.de>
 <20240305080005.3638-2-dwagner@suse.de>
In-Reply-To: <20240305080005.3638-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7128:EE_
x-ms-office365-filtering-correlation-id: 0fd540fa-569c-4794-9a62-08dc3db4d5c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KGxiug5RzPAD/paxWsnh8hWVnayN8n0q8VBr5npVVJ7Ex0GAOH4/9FwXYqHnoXWI3SUgLLqOA9NlgBvHbZG9i7ZeVDo5ob4iSzzXIpMXO7ZfsFMlfV3MaCvGmrWi9aI6auhnx1N5dfKS71EQl/qcC6jMZdZZZ0VW+5e0UMg9GcK/QMWK5zS9lPSd5B59ZgI1aGb2fHoxS+TggYPlVARuJAmXdHVfMIr2nIjoEQJvoN4LI0r3eWdW0As62EJ2GSlrjhbnpa2bykJBNVH/deR7OWJNTdEzTMM0AgWvbf+6ZGJAbeBlLiIdGoCK5+3en/RcK7L4EFM9EaiZUKVFx/2DGfnpSk66DteqSoQ75wqiyq1CowBsgo72cDL4+T7ImdtVl3qOHpAnia8kQ3tIph9+H5fBTbOGsTrYSuJiwUynGy9zCCVwACS+Oi7zDVtvcHq4XYuYJ5jHFTxnqhwZwedH3d2iniS+bYe84dpcRsBJDpyUmnPqMozdiZNslobeSO2lybtQwir7+5VE97dnOwA7pQPumE2wHxZsiDHl2N+h4Tapi3vIcZ04KIPHExf+oj0Q55nbBcxd09Lj370eXyUlsh/E6qwp6Twmujxmdq7NUwOiclvzBb4LWJI8VwPRrzFbU5XOlJjwbyTp7Nz38mGqjMsFK5pM89pRg3vpV6E72fTksCXQm8KrO9frFmnCGXtlr1j9xD2I4mOEyaOmr1bZ9g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1FxbzN1WVkvVEE4eUk4TzlxaGlqN08wWnpzOVMvSm94U1B5TElhN1hvbVZp?=
 =?utf-8?B?eWtubEZMWmgrcHViYjBRd0JiU1VQQ1JVbWZ6OGsxc2J0WFoxTzEvMkJ4cUEx?=
 =?utf-8?B?M2xIS3V3WVkwYnpjR1pTT0ZDQ05uUTY4aFJWaFpxbEt4MDBTQ3FPT0R1SzZV?=
 =?utf-8?B?V2d1bU1rQVp4WVNacE4vc0p2anVNVHRrbWlORE13MmhGZFpkY2lkNnZCWHR2?=
 =?utf-8?B?WUVyVG1ZTWFrZEtlOGM2UThIVWNrM2xvZlUzcm5Xa3NYRzVUUVhaNmtyMnoz?=
 =?utf-8?B?cmRyUHVuOE9JTWxEVVhmUVIrRy8wV0t4bjV6L2NuNXZRbDZMd0o5MEZQV3dx?=
 =?utf-8?B?MUhwR3IwSzR0NkFCMmcvSU8rSGdPbEQ4Ykhwc2ljOGh1YTNPeldmY0JWNFBG?=
 =?utf-8?B?aThpUDdreTV2Z0tsNGtyZGo3MUVpK1orcXd6UkpKK1J0UWVVTENmb3hEU1p0?=
 =?utf-8?B?N3hUZ0M0NDk2S1FXSkh0NUpPT2NpcE52eWpUWU5GcjZvMjR4UmJvQTlIVkYr?=
 =?utf-8?B?bW56a2lDQkNOUHFDeGRPcGlVNlhpRzRkdUZONDFXOTRuUHFpTnplME14MmE4?=
 =?utf-8?B?TUZndE9uNlZBdHU5WU5Ic0J1WEk4Y3lURXhZQW9XeGh5OFJUOVVka0dyb3Qz?=
 =?utf-8?B?cktrZmJiRWlCb3NySnhMQzZ1UUFjalBIbDZCdGt4WENCdmVZZFIxWW00bVp4?=
 =?utf-8?B?cTlQMW8rSFA5MFVxRi85VnNMeU5wTDZZRlBBVzRqQ2l0Y2RTcWYwbk1Yemhw?=
 =?utf-8?B?TjQ4bis5VGdCaHdjV2VuYTUvVVhBcCtkOGp5anNjRHpBRnhNMVZjSjlDaG9k?=
 =?utf-8?B?RE5jUmhpb2xZdFR5TTYzdUNxRHdDejNGZUtqOVhrMGJwaXlMOGp3ZDJoS2xK?=
 =?utf-8?B?K2ZXSVBDTXZ1dGlJSXdvK3dBN2g4TitETnRiQ3NwVDBEbUZsWXUyTFRSQnBm?=
 =?utf-8?B?bHE4b0VnU0l3Nkd0c3FiRnNhVE83Q3ZiUytoS3pFWHBJYVJVbXVnVDB1WVhq?=
 =?utf-8?B?L3lZWnBhbzVrRnRGYjJvT0xCeTd3VnBoQStxUy9xOE1FQVQ1dWFiT0pSVW9Q?=
 =?utf-8?B?Rmh2ZXE5WnpwMmJ2dW94Y2tJQ2pnYjZ5N3lmU2N5RnoyaHZKbXl2WTdycHRP?=
 =?utf-8?B?NzYyZ0tNUWRnQXBtWWlFMGhOVzE0Y0NXbUpvKzQxM2NUZFhydHcrd29xM0xE?=
 =?utf-8?B?YS9LWW9YamtaY3FWNGhGdTJ2WUJ4cE5xL1NIbWFtYnNNdkhsSUplQXVDbFp3?=
 =?utf-8?B?bEkvR2svbGpOMEpUZE14NFVhYlhTMjJHbWt4Z1lTL0F1d1BKc3k4bGJPN2wv?=
 =?utf-8?B?OTkrb3FGc09XT2NJVkpBVkV0cXgyekRWZTFVZDR1UWhRa0pWWjZSeG5mc0pP?=
 =?utf-8?B?clhuUEJVZnBkaG84bHBWcGNMbjlVWXdkR29wQk1iQkw1K3lLdENRLzZKaHo1?=
 =?utf-8?B?R0Z2Tmc4SXJtNTgrMTJSY1l3SW9DbXZDRmMrdHVNR0NPV2x3dnhhclR1czB3?=
 =?utf-8?B?RGJESE4wbHpUT0UrcFoxaWZ5cVNTOVJUbUxuUFBlVnV4Rit0M3BYN2JUMUJ0?=
 =?utf-8?B?WTg4ZTNWOEJpczdwN0VZVDdHWGhJLzhPSHVDWGtkeEtkSk5FM0xEc0E3eDBp?=
 =?utf-8?B?QTdVZ01oV3Qwd3puSG1LVEF6SXpIS3R5RUFBdDh6OE0ya1RDM3JLTkRWeUdZ?=
 =?utf-8?B?NWFMek1RSk5LblRJU0U4M2lJVFkxcFJsaXVPK3ZyWE5OQlNVRFQrSGRQdnJC?=
 =?utf-8?B?TWxYSXVqeTJFZGlZMUVubUlHcG9WSFB1N0dvUFZmeFlXQUZleTIyNlFrT0VI?=
 =?utf-8?B?TWcrTDlPbnVOR1pDbkJUS3MvSTlYWGpBOU5Ceit2dDlkRy9QVW1IaUU4dDBF?=
 =?utf-8?B?OUkvUjVOTFJkakFKaVpYdndRUkFmZzgzK0VhekkrTDlVWFNWR012UkZEd3hr?=
 =?utf-8?B?N0NjUy8xdVRSeWg5a2daYTB2NUI5bHB0NHZ3a3RjZE1RamtqNEJLcllzem96?=
 =?utf-8?B?cTQ4SFIzYmNIb3YwQzFSSjM0SjNONFlBTUZHSEZweWZtZDJQV0Q2SitmOGJa?=
 =?utf-8?B?b3g1OVFzbVppS0lKZFlGR2h2OEhVZ3R4Vmw4RUpDL0RFY2F6eXI2SEYxSFh0?=
 =?utf-8?B?RlVwT0FFNDRZcnEzWm4xWlVOTEdoaXZIcU4wSUErbmZucVRZdUQyVms0Sko3?=
 =?utf-8?Q?c6ilVrQRHuaFzBStqsFDDy36MVJGGXv44gFT6QzcmUEO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4819BDC875FBD045B295CF5BD2D01A05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd540fa-569c-4794-9a62-08dc3db4d5c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:10:06.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fAYKHik9GYVqSsUD/SolhZD3z5kahc2Ov5eOfcWhN726qk1BkPjATEMTkuRRVvXiTTYe2Kbb78wnRye9tkQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

T24gMy81LzI0IDAwOjAwLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBGcm9tOiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gUmV0dXJuaW5nIGFuIG52bWUgc3RhdHVzIGZyb20g
bnZtZV90Y3Bfc2V0dXBfY3RybCgpIGluZGljYXRlcw0KPiB0aGF0IHRoZSBhc3NvY2lhdGlvbiB3
YXMgZXN0YWJsaXNoZWQgYW5kIHdlIGhhdmUgcmVjZWl2ZWQgYSBzdGF0dXMNCj4gZnJvbSB0aGUg
Y29udHJvbGxlcjsgY29uc2VxdWVudGx5IHdlIHNob3VsZCBob25vdXIgdGhlIEROUiBiaXQuDQo+
IElmIG5vdCBhbnkgZnV0dXJlIHJlY29ubmVjdCBhdHRlbXB0cyB3aWxsIGp1c3QgcmV0dXJuIHRo
ZSBzYW1lIGVycm9yLCBzbw0KPiB3ZSBjYW4gc2hvcnQtY2lyY3VpdCB0aGUgcmVjb25uZWN0IGF0
dGVtcHRzIGFuZCBmYWlsIHRoZSBjb25uZWN0aW9uDQo+IGRpcmVjdGx5Lg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUv
aG9zdC90Y3AuYyB8IDIzICsrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+IGluZGV4
IDNiMjBjNWVkMDMzZi4uZjlhZDU5MDRlZDYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYw0KPiBAQCAtMjE0OSw5
ICsyMTQ5LDExIEBAIHN0YXRpYyB2b2lkIG52bWVfdGNwX3RlYXJkb3duX2lvX3F1ZXVlcyhzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsLA0KPiAgIAludm1lX3RjcF9kZXN0cm95X2lvX3F1ZXVlcyhjdHJs
LCByZW1vdmUpOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyB2b2lkIG52bWVfdGNwX3JlY29ubmVj
dF9vcl9yZW1vdmUoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gK3N0YXRpYyB2b2lkIG52bWVf
dGNwX3JlY29ubmVjdF9vcl9yZW1vdmUoc3RydWN0IG52bWVfY3RybCAqY3RybCwNCj4gKwkJaW50
IHN0YXR1cykNCj4gICB7DQo+ICAgCWVudW0gbnZtZV9jdHJsX3N0YXRlIHN0YXRlID0gbnZtZV9j
dHJsX3N0YXRlKGN0cmwpOw0KPiArCWJvb2wgcmVjb24gPSBzdGF0dXMgPiAwICYmIChzdGF0dXMg
JiBOVk1FX1NDX0ROUikgPyBmYWxzZSA6IHRydWU7DQo+ICAgDQoNCmhtbW0gYnVuY2ggb2YgbnZt
ZSBjb21tYW5kIGNhbGxzIG1heSBoYXZlIEROUiBzZXQgLi4uDQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

