Return-Path: <linux-kernel+bounces-93342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D3872E49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E8E1C215E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DE179B5;
	Wed,  6 Mar 2024 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mque4SI3"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82017BB9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702636; cv=fail; b=tX48kS3XT6lC5pPnZ1DbC1qNng0KT8vYzOVEoix0ntDFbBrFvzNuKjMxaaYRCyIFjB3aeE4RBjXCB9bTz2aJHRZOqw9thdYV8D3vLLuTjjA5kIRiqBtzwyqjDc0SkxeZeLVFfw79gnaDXB2wx/gW7xQE7XDqMNq3k2ry+AGdrRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702636; c=relaxed/simple;
	bh=Ymg3VCGlx2IheTTcjQIeX3s4NcDSO5IyJ0aal9z4olQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVfu1BVZRqDYg3t4T299iZvXnfqfV/K+t5cdtZ2LW3LQk21zPf79oOE2XCAYD+YEzLiQ2mQ6c/sYuDoW1DHtWxQpIegyYnTIIO1tZW7H7lI2t5JvuAOrI3tsuJAyufEfDUml3hkWBCkqeStQPNokScDkBvO+Q2NmadoDi4riEOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mque4SI3; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flcXhfXytwLOPhI9PLlLeXJUmXTONwTiG8BQmkv7ljhXQojTt43VgQJcOGqjpNfLXnELJSBhaWyUEKztS275E0Py+irAp8/jQ+BbfjkQ2zcXhGRTL0QAKeBez+svY6bPihhv75KnPwgJCuBJwC0jnpRWe2ZHXWNwrMk8PYJBjz99xCg27UqToeh8a5C8dKM7DBt/zaeeIS0W7Dqud5KXvb5VDkxJAX4VEONl6SrG/a2OP4MO7/CsQQb1Ta1sfQdX/xLeIQcCR1NbEJqdh2GaOF8Txu1GVXaTdGxdGY2QPqwBFaIXHX1CCzo+j1LF9E0g5oNUt6g/ZfF1zikxxaKEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymg3VCGlx2IheTTcjQIeX3s4NcDSO5IyJ0aal9z4olQ=;
 b=QBbLoyKYlVg2HarXRqTRIzpeM44a7RprtQyTO0DZALRjush2Hr8czQH5PrAUeLCsB/04DQXnehND5nHdrkImChI7R+jskC9vIDUcTpNDVCqDrslx1QthXd2+H5/sePeiP2pHumRk706N9rU9Yzwtp/2VUUhXqFd2TFYIBv2USxNT2CLQaDNnCYyrd9odj8XuX6x/52lkLBu0I+P4H4a3Ol2BGNpA24qOur6+hWURvN0fdV0cs3zLcKull9zTGnJ/lnuDqTq1m8WBTue35JL5q1UWhLocYFYO1siNxA96sfnkvPYcys0QnK11X1rOufCuAoNWMruWCQ44QOBKKKgxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymg3VCGlx2IheTTcjQIeX3s4NcDSO5IyJ0aal9z4olQ=;
 b=mque4SI3UZGpkIR9y2PgUeg6DAuX7y1zF8ElHPjUlZe1/9M7X7ooa8mqd7rWAnuZ0FNGpyofJy6jgvZssbkh8Od0I4ZEsX+tzIsmGruR9oQjd5X4dmdyN6hYPAWHJtlH6SABd2xo4xwAiEwPfSW+C9fwL2bl3vx06xuN1/USrAyDSfenOtQVEl+JfAJ2bvDBCVsREwnhE3oXZA175LtkAR3+kxiiZ8dRkNVsa4RXyv6itpTepE/9w70/LLKqdw7Wj6ISL670QCh+uk+26DmL0nehNMqsJNLUVXe+e1aUy9GNlIuRLLum+eQ3wMOLj8GSBnXOYw8OIsiYFWgSv3wMFA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:23:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 05:23:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] nvme: fabrics: make nvmf_class constant
Thread-Topic: [PATCH 2/3] nvme: fabrics: make nvmf_class constant
Thread-Index: AQHabv9P9IqRFam5R0+JmxJRw6TlGLEqLvIA
Date: Wed, 6 Mar 2024 05:23:51 +0000
Message-ID: <b34ebd6a-c42f-44a0-b013-447773ac9571@nvidia.com>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305-class_cleanup-nvme-v1-2-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-2-c707fc997774@marliere.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4431:EE_
x-ms-office365-filtering-correlation-id: e84f193b-ef82-46d7-d487-08dc3d9d9bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jafBS0CfmuuMdlf9fhTCE/owHdyflBbUM2VNYV1rl5V2gDcz6PXdOg6jGVl0JDrxbX+Z8ganrXQAihXNz6aFEl7dAkeidQLgVvyrpx2y/uzXssH2zSU/zx6izt/3EE/xDje/RxmPST/f25M9SkolvAwMUK7SFKhhKzLmO5ljUwQR/yfLaLiZT9G9IvqzBF41iPZr7v6gIPnhcHSFsQGaK51Kq6XimMGT2Y97XvFa4zeLE7PVoAWbCinuVhuV8CV8chNn+GA/hycoVS7dvrbyA9+qgIGQ3Sg0OnLCFaRS8HyDAGp6FPoKC2V1hARt9u9yRWKPNREd/9q5IhAk1txUswhYcw1rVouRU6qIQyPGWzqg0XGugrx/wXN4jmtriA2/cXv7gM2TAdeyChqVprQDfLiMjGMapWMGYjS1gyJAE8Ou5tNcPeivLMTJGkn76wgbQ8dmCSU9IZgaalx1u7KjrGDvMVgqimDGIxGV5Dvfkj4Hgadn9ybuAeu1icvXMs9nAuV4XVm7RcVGISTzQRVqUJieKD0kVki+P66JItLC7iVBsoboIVSnv250vS/X6s3fdL9DRzqylUP3l/KKGeqXYnGStMLOB6p5ez//s2DKZRbLljvSoGbzTNe2NUfNHGrDZHIpcDB1DpHtXFNpjKOq3uOTJ32207oeUwCKhFshA/iaRhaXK8PfuKmbkCKIChF6HHe2rA+qYTnvhenfc63WERu4Bo7Mx1URAe91g4g/FhU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTVXcHpFTUE3UDQ1N0NYVFV6eFlINDMxeTBtd29XaGlEM1U2M3hHTUh0T0ZK?=
 =?utf-8?B?Q0ZVZFQ4ZSttOXVSeTlGTGpTamxUNXpZVmxpZGdUS0RJNUZMWHdGTlpNNmtN?=
 =?utf-8?B?RG5oaDkzYU1IZ2tkMnpNVUF6ZXFYNHhiZmtuUFJMUFRENTBBS1FucENNZVhZ?=
 =?utf-8?B?M0swUEpLRCt0OXlIZ0k4N0poN2hqN2c3VVJKbHhIb211aWxZSFBkSTF5TjZs?=
 =?utf-8?B?V1Zhd2gzbC9CK2w1SUZ5VXo4WFhRVXZQL2RBM0Y4Tmx0RUNycDQ3NXN0dW5Q?=
 =?utf-8?B?ZTlDWHgyVElWOFBmVVRiTXF3T0xaY0hQdTRVVktJNnFyeGNFa0toT0EwUi9Y?=
 =?utf-8?B?bmdrSFY0aHl4c2hCeHpTUXNxVXdybXc4WWxhV1VRMjkvNnl1czBhUmkyMC82?=
 =?utf-8?B?UVNiR1ZLTjBDVDFoSDNoUldvc0s2dWhSaUlMK0RaWTJ2aFJaTDhqTjBzUGJm?=
 =?utf-8?B?STNNL1ZXUGJZTlprZVdIMXU2Z0ZSN2pIUGUwRE9nYlFvam9qQzdDdUtFekFB?=
 =?utf-8?B?SURCZ1FIMnlMdzBOV2xWMU5yT21NajJVbmFmU2tWem9DQ3Fwczh0SzNRM0RC?=
 =?utf-8?B?RHZXcTRtTjhRTUdFcHA1UVl1NklLc0xIRFJ0VmhvbStZVmJEcVh2SUJxRUFV?=
 =?utf-8?B?Q3NNWWlpajc4T1VqTEx1R0IrVnRjTVd4V1U4cURDT21jYVNxVHJvdGU5ZUQy?=
 =?utf-8?B?dUp2UmRGWnlpeXM1NStmeXRaYkNKWkxUR1Y3UVpmdVhjbXFRQmIyV1FMYTIz?=
 =?utf-8?B?eGdpSVlDR2NPS3BiRmcwWitNajgzV2tGaGZCZW9VbXE1OUFyZFFiODRqOGJn?=
 =?utf-8?B?NDJ4SjdUZTA1TlVwSHFENVFnMzZvMjJ5dnIzK2RxSEsxOEtOdTg1M2NtZXBw?=
 =?utf-8?B?SXJFL1p2My8xMUlyVXNDUGV2QUttZWw1TmZQVHFOWXlKUnZiVGx6R0NDdnQw?=
 =?utf-8?B?d0x0MTBvUHFrR3FoTlM3MGo5WncycWd5NGlLWWhjRDFYQVJFSVg1SkZiTFIx?=
 =?utf-8?B?Tm1jS1lDYXNFaFc5dFhPVE9vMFdMT0xDaVlORGhiT0V6ZlE1MFF5Z0d4NzFY?=
 =?utf-8?B?TzhCemJRNEpKRGRlZ2JEUjFWQUpnTEpESkVzOGtuWHFONUZoWVdqY0ZBZGhi?=
 =?utf-8?B?NlVlSmlXZGhtTkNaNUJVYVMrTDdWZSs1R2IyeHdGeHRBUXkrUzFpU1o2QllV?=
 =?utf-8?B?UHM0NElnVnpPa0x5cmduMk54QjJVRFIxN1VVNjdaQXhJaEZ3Wlkwb3lkRDR1?=
 =?utf-8?B?MEVyRlFidFV0dVJ1UEhPVWRNQXAzb0NCMDZOc3JxREJmM3JQcytYNzh6MUdK?=
 =?utf-8?B?SUZaaUhRa09RYm5QMnJwNHFqMDhXVzBnVTVkMGZJRm02RHpjZXpTTHN4UTR4?=
 =?utf-8?B?MEIxNnVsVTVZVDBMSEhkMnNyTCtRbktNRnZtNkppQVFJeE1DckhnVGkvTUdu?=
 =?utf-8?B?aEpLcVoreGprc2h1WXJtMlRvQXUvWVU4aEFCV09hbmxSbE5ZWVhYZDJSNEQ4?=
 =?utf-8?B?VWhoOHB2Rk0zQlUzQjRnSTYzREp3QzFVTzY2cW9nbmFkbDZLTTA3MnZHU3M0?=
 =?utf-8?B?Zk5GNTN3c0hWWWluU0RYeDlMeXQyTTdoUXdRdzAzYVl2NG91dzZpZWFaL1FT?=
 =?utf-8?B?cDlhOUdBYlRwMlRFSzJqNHVJUFNrZ0dIUGZ4WTB0QVhreHZQSDkyUWlEclNM?=
 =?utf-8?B?dnZXUFcxcUFyV21MNTFLZnkzeTJaT0QzL2xOSCsyK0RXYWwzanhJVWpSVUln?=
 =?utf-8?B?ZU1mbHo0YkhZbjNTcVVNdytkaTF1VFExMmNuaGttelJyVkM5ZVhPbnpHSmdl?=
 =?utf-8?B?MjNiYUh1VWROV0N5MTJWVmlQZCtIREw1bGJULzhQWHJPWVZxVFowSTl6S2wx?=
 =?utf-8?B?SHJBQjRQMXBaM0tQanVhMHBSVEwxVytDa2xiREgzNmN0YkRTOWdmV2hiUGdl?=
 =?utf-8?B?ZkZiU0t0cXRvYU44ZU91NUJwRGl6eUtDRUhiR2ZJZFdpemc3aDg3RHNOV3VJ?=
 =?utf-8?B?MGFwWGRjK2Rvam9FZ0dXcjJpVnMwT0FDeVlmOWpKTmVENTVtNTBxYThDdXBk?=
 =?utf-8?B?OEk5blNEZzNlSWNHZUZINVJXWUFOVnVPV0xLbVd4SkFnQ2lMQXFLUlNDYUd4?=
 =?utf-8?B?N1lGZG5HdldSY3hySFZEeEFTbXBORmIvNkVsNUZXSWNKdHdFZzQwVzdVZmVW?=
 =?utf-8?Q?VT3BX7haqnl101yioEjdcaephKCRkO2sm4JvUzmGAZWr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBC36F8373F04C479F148BC3EE206D9A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e84f193b-ef82-46d7-d487-08dc3d9d9bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 05:23:51.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUWVr3KZ5DHqAa6TeBX/qrnvFZCt2kp6LQhlpqXemAOcxAU7ew3O82LKBmofDI7VM/ej1tt8ea2Aa3dznMmBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

T24gMy81LzI0IDA1OjE1LCBSaWNhcmRvIEIuIE1hcmxpZXJlIHdyb3RlOg0KPiBTaW5jZSBjb21t
aXQgNDNhNzIwNmIwOTYzICgiZHJpdmVyIGNvcmU6IGNsYXNzOiBtYWtlIGNsYXNzX3JlZ2lzdGVy
KCkgdGFrZQ0KPiBhIGNvbnN0ICoiKSwgdGhlIGRyaXZlciBjb3JlIGFsbG93cyBmb3Igc3RydWN0
IGNsYXNzIHRvIGJlIGluIHJlYWQtb25seQ0KPiBtZW1vcnksIHNvIG1vdmUgdGhlIG52bWZfY2xh
c3Mgc3RydWN0dXJlIHRvIGJlIGRlY2xhcmVkIGF0IGJ1aWxkIHRpbWUNCj4gcGxhY2luZyBpdCBp
bnRvIHJlYWQtb25seSBtZW1vcnksIGluc3RlYWQgb2YgaGF2aW5nIHRvIGJlIGR5bmFtaWNhbGx5
DQo+IGFsbG9jYXRlZCBhdCBib290IHRpbWUuDQo+DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTdWdnZXN0ZWQtYnk6IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFJp
Y2FyZG8gQi4gTWFybGllcmUgPHJpY2FyZG9AbWFybGllcmUubmV0Pg0KPiAtLS0NCj4NCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

