Return-Path: <linux-kernel+bounces-33585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED7836BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4506D1F2337C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF55B5C1;
	Mon, 22 Jan 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/q0pRSa"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E4D3D967;
	Mon, 22 Jan 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937136; cv=fail; b=irsOzoGImn2VmMqjYlC3IgKbSddaVcZXfcCD0dZhJ7TflgCepQkeuKwzhPkrc2/QKMKr2MQplWKVikInLuSByO/y57cZVRB0Sar0LKm2fvrtlmCXQPhNwlSbebUzV3tB1E2YmE7vLRlOSi5QbY9Rx2lgRPZofYhi//IZlzg3rVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937136; c=relaxed/simple;
	bh=J3OtY/6VI3Br9skGH8Qoe5Uf6wjwrxJxWzrkiaydm5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nN5pyxWt832nXvtgnKwXOcBIc6GfwOkxV++0+HtruZJbxCu3LnKOCYbDdRIUqL7bz7b9fTDYUnO8RD1wJJgKUi0H7JF6vO3ONfjxp+UI5B1NgeissGHkM8fx26+YNewbfXmSxd/PkhRq086C9yEZqrej9jIPK8bW2ALYIk6B39I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j/q0pRSa; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1wqhgg78fhmwr7gcYDYNAch8eI3w0jvCQ/up5oeGrZnB48xGkwvixlZsKzJLILJoroPOJo5FEtpGVA0MtUGGSejIlH8H30bDVFHZKB0NrTqjxLGzTYTEq2BVCm/pv94cfjQ122LQjO24F/4zG2vuMOWztbCkvVLJz2SMiX/W0XO9vKGzQQrq2pqytoa0723VEvpqCV06306TJaKOfc/3lIZ+olfhi/Ah1IVMBP91LOSp/swxJo70pxb4pzpgLid/smxZ9u1WKy+lwQDcSLXGRUnRqmWhnnsvvnZ3IL52yca7Mv2V+WltYZGmr3G4fY03kmeG5A9iSQZwBH5k38GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3OtY/6VI3Br9skGH8Qoe5Uf6wjwrxJxWzrkiaydm5M=;
 b=byX0KHVUCZBWjylg0nIzCPoODe2vjKXpENTjquvS2SVK8Qvdu5Ge05YTaeBd4U2xb8OXSQWtCwCtzQW/DOD2P+8kr7gJc7GgQhdnIC0C2ZtS9yeZziSMXO4uQGtk1s3N9Wcm3Yn+7il70PsE8+WHUC7phVFZGnf6LWjDJWWZlEGU3w0wtCDWwZAQLu45qKHDQaxxo8krBCEG5629lNsCpZ6x+bv6XdY9VQJvU7/LCAqKYZhu1YE9dSK+7ZWESvLZd7D2k7SFk/fxK0QivxzbW4JUhjFRfq3yhuP6lN7if8ypgZ98klg4rHeAI2Nj5oSqqwQkKf4DgOyRU2ZrAsNqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3OtY/6VI3Br9skGH8Qoe5Uf6wjwrxJxWzrkiaydm5M=;
 b=j/q0pRSaUSIrzc3wTixg1Qa1piSb2ZGq1e9AVN42Au08HsdMTHnyk6JaXR04ro6PS82SkvQ8fRSvsk7R/vNiC9A+bwTnhCxNt+q/e1jcK1Y7wR5DcLlACV3AE6zc0N0W7U3VDbflHt5gJR/IlezAvCDDT04vfGi/ZtKjv9GmLJV1/Lrnk76q5NKfJzthEgSaTr5NOH5ZjQiKUtJ4ri/IxGyisMtNtMIqLMU2nRk9tdvYRg3qw3k5qMPqjW/asR9ebjvQVF+hUtuE+4sth1br1o9qyBbKYqKIX/nQ8XQF9Fuv+3+IhZV2898dCbt7AlJR9nRJ3nu2cee1G0HA8vLiiw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 15:25:29 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 15:25:29 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Simon Horman <horms@kernel.org>
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
Subject: RE: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Topic: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7DlpAOAgABPogA=
Date: Mon, 22 Jan 2024 15:25:28 +0000
Message-ID:
 <DM6PR12MB451653752A72BF1BC23A4334D8752@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <20240122103759.GB126470@kernel.org>
In-Reply-To: <20240122103759.GB126470@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB6465:EE_
x-ms-office365-filtering-correlation-id: c3385e07-d3ee-4a00-f934-08dc1b5e5d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OubxnaCeYP80FCtY9ixp50ecNBR1NPxAdvCAm6QO46n7NEXFh1YwEn/jru/UsTwrga+Ps3avr4p0j2Z7tV5Bvg99we8zZjA2anKDwuMV+0FWQV9u3/hm4rtBGe1/RC5AJoE6h/IN+7v7PS8MBkbVDSGuYGt7LschWTCoFWMid3+0zP13l806mWQmmkB9XtkQdudJPBTvzSbm6hVU1Mk3rCOy18kekKSegb3c4NyGPyxIzQHzrUIm73OQvvyKWvN46sUoxMy2sDIwMT0zp+m1d9TruFdpipVLF1Yyfl5rH38mQwVw6AM66q4dms9HEvfrHJvZwM6yIeh+vURuyKCJ+sHdCdTCZ9920sIC252K/ngfKsRyqV69o+CPL8qReVqP+mhZ1gEYWvEKpZEmg/gswRj1V1t7BxNZ6fpw15f7yHm0KK3fcczMYYXDa4cM/Av+4D4XWk2Z+E9ZvFyZPWaXXKPsx7CwjYu0ffxx+roJll2wxUtm9fMax8t1PK2QvXspyifQ3/bIUuQfyo9mpRhQ1zYxEUFekiT7PrcNGlXDNlYTDwDoDojtC2zrFI9Sw2EWDw3gotlSzJDTdvv4hEGW1BoNhaYXViJNeieqG4IBwNKRHU1pQt/JJRlCusoXIL//
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(6506007)(7696005)(71200400001)(53546011)(9686003)(26005)(107886003)(122000001)(38100700002)(86362001)(33656002)(38070700009)(52536014)(41300700001)(83380400001)(5660300002)(7416002)(2906002)(66476007)(64756008)(8676002)(4326008)(8936002)(66556008)(66446008)(478600001)(76116006)(66946007)(316002)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmhCanJiUkxIWGdKYlZVdk4yZFMzc2Nhek5YT0RxNmtTSFRhUHZQcVhmMEpm?=
 =?utf-8?B?NjUyamN5MGxnYkl1bVJUejk3a1hiR0lwNVhuVlQydE53NjdCTEpJVjU5UmY0?=
 =?utf-8?B?ZStyYWZuT1pwYkVLQjZBVUhhT0t1UldTbzV3ZVVDR2VvZ1FvTkVTQ2Z6Z3F4?=
 =?utf-8?B?TWR5U1pOUWZIMytXR3ljemIwN2RTa0lXMEQ4ekRPSnZXYlZsR05YcWtJTUpz?=
 =?utf-8?B?aDc0SGROTkJ2SHZiVG53OTZWeWZMdTlaWllJN0c4Y2VYQlZLeVhHVkd3VUFs?=
 =?utf-8?B?YnpHY3VZRVRHeTFWL1JDdDROVUw2d2tTYWovTlJxellGbjhtR1VsbDVUcFFD?=
 =?utf-8?B?SGpHK2NOU2pROGtLN0U4c2JZejdBMnpPZDBEbDNsQ210MldkcWxFRnFiUmpT?=
 =?utf-8?B?UVRCMkw1S0hCbGF3dmVMM2tRY1RzY0pvbFA5b2RlbmV1UE5oL3hTM3E4d0M0?=
 =?utf-8?B?US9OOWI5QnE0cDdzMG93d3dnYk5nQUV4dVRjY0QxbDFGQnpJeUdIbUlVbzQ4?=
 =?utf-8?B?VUJxbTFWbVF1T1dUOXJtUjhPMXZrQ1gzWkdGeEp4TlRDOVNIcWtLek9RNU00?=
 =?utf-8?B?c0dDTkhKWWUrcjdaajF1S0NJL2pxS0ZNNUppTUJ3TGpXTnZYNHZOd1ZJOUVw?=
 =?utf-8?B?TEdRdnBnd3FoYWVoRDZsTEp3RlVxVTdrdE82UE5ZdDRYZEkwcFlpN2JGVDlq?=
 =?utf-8?B?SWVkUnJJN2ttUFV3OG52dTQwdUZjMUlNSGUzaUI0ZWxYODFXVm1qTUhBMStF?=
 =?utf-8?B?bkY0S3RCNytGT3RxWUpwY0pkTXJDUXpzTFJwQjV1dWk3eFM5WFFVcHQrSzZZ?=
 =?utf-8?B?c2VqekVFK0cvQWV3N2xBOE8rWlR5dEZCZlBURW9XS0tOTTkvV3B3b1JESkE2?=
 =?utf-8?B?OWtoTHJzdDMwdlNiOFhRYmdVbFU4aDRjcDE1V2V4cTRadktWVnlDbkJwNEdp?=
 =?utf-8?B?U0kyZlcxdHNaSzg5Qml1cTR5Ui9MNGF2bFNkZnVFSHd2WkxJcHZWT2RUeVNX?=
 =?utf-8?B?eTlRWEVCSkVWaDBpSHBQb2lFSmRQL0E3aVF1amZvS0czQkV0M3R5bGwydkJO?=
 =?utf-8?B?OWoycDhDQ1pUS28vRUFuRUdza3ZQWmxqUjFyRWh0NW9TcHhsYnU3cCtxd3FF?=
 =?utf-8?B?Y2hXdmxtcHhRMWVhaUVUa0Jsb3pJT2NET20zckNPQ1UzTW5BMTlOV095bnVi?=
 =?utf-8?B?dERhdzdKN251dURZRTYvMHJUdDBlLy9VNnFud0tZNWdWaEZ6d0FocFY0bVBQ?=
 =?utf-8?B?azQ3cVQvd0NyMGRiVlAyeDBvb3hMemcyTmR5SE1FUDVITnNSQXJQckw2NmNz?=
 =?utf-8?B?QkFLOFdwcUkrSUY5QTBpenh5bVZHdWFEZk9JeGZHUVMwSTY4N2pmb3RyNnRh?=
 =?utf-8?B?NDVjUnNyUFhkZ3c0ZTV4dzI0UmQwbWtzQnZZTFNvMEFEK0pENnptazdQeWxj?=
 =?utf-8?B?Y2h2V0YxNkduTEhaS1ZEd1Z0MWNzUjRqZUE1b0hpRDZ0eVcrbEgwMHgwYWdt?=
 =?utf-8?B?anJQVk9IMHhUOTI4QW4xenFBQ01kU0RzRHQwRndXMlBuSEc0L3UyZmtLOHFT?=
 =?utf-8?B?RkFONEdtS3ZucklENTBFT29XSXkxMjM5dnFzVzV1NmNOT1dEYlNuUUU4Q2R5?=
 =?utf-8?B?a3puc2l0cXJzczlTaXF6MkZ1Y0xtRVEwMTh6T3NKU1V5UXFWZHhNYVFOZXhJ?=
 =?utf-8?B?Q2RiaXE5cE4xcHZvMmo2U3JCWmo1KzJNazdDREJqSE5lZEUrclpHVFcrbTVQ?=
 =?utf-8?B?WlhLNHh3elZaS0syTkNtVzhFSHlvS1NOV0xxQmthdmt6cG05U0o2WTJkeHNs?=
 =?utf-8?B?MVdlQ2RRUXhMdUswSlJMQlFxbldyZVlqdUJzZ0RzV1YybmtsbzBYVll2OWNl?=
 =?utf-8?B?YXdjWm8yQkpJc1g2T2FrczRtTGdLQnZPVjF2QzRWaEZkR0RhTWl5c2tiT1Rh?=
 =?utf-8?B?TVV1R0RmM09RQ0cwdzN3K1VKNUVPWkQxSTZiWGduUnE3aTZSRS9TOTAxOVJo?=
 =?utf-8?B?alVOV0ozMENMWE4rbGtvWThqRVNISFd3bEg4eHBhRjF3SzlveVBVcTc3dndv?=
 =?utf-8?B?Y0o3R1MzU1Njclk3Z0pLa3MwQVpCTnZ5ZTYyUmcrR3FqMGNzRDN1enZZMjFZ?=
 =?utf-8?Q?L1Qg/Qn2FV3IGz0uDotlfERwy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3385e07-d3ee-4a00-f934-08dc1b5e5d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 15:25:28.9525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvZRvLRpD4gWm076ItM05axN98ujpa5gMzvVYTC139FEl4F5dxZIYu8BssV1Tdo8MCBHN+VYD/uyebOQ7K2LqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMjIgSmFudWFyeSAyMDI0IDEyOjM4DQo+IFRv
OiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsN
Cj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgY29yYmV0QGx3bi5uZXQ7DQo+
IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc2RmQGdvb2dsZS5jb207IGtvcnkubWFpbmNlbnRAYm9v
dGxpbi5jb207DQo+IG1heGltZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tOyB2bGFkaW1pci5vbHRl
YW5AbnhwLmNvbTsNCj4gcHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbTsgYWhtZWQuemFraUBp
bnRlbC5jb207DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgc2hheWFnckBhbWF6b24uY29t
Ow0KPiBwYXVsLmdyZWVud2FsdEBpbnRlbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtbHhz
dyA8bWx4c3dAbnZpZGlhLmNvbT47IFBldHIgTWFjaGF0YQ0KPiA8cGV0cm1AbnZpZGlhLmNvbT47
IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBB
VENIIG5ldC1uZXh0IDkvOV0gZXRodG9vbDogQWRkIGFiaWxpdHkgdG8gZmxhc2ggdHJhbnNjZWl2
ZXINCj4gbW9kdWxlcycgZmlybXdhcmUNCj4gDQo+IE9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDEw
OjQ1OjMwQU0gKzAyMDAsIERhbmllbGxlIFJhdHNvbiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4g
PiArc3RhdGljIGludCBtb2R1bGVfZmxhc2hfZncoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3Ry
dWN0IG5sYXR0ciAqKnRiLA0KPiA+ICsJCQkgICBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRh
Y2spIHsNCj4gPiArCXN0cnVjdCBldGh0b29sX21vZHVsZV9md19mbGFzaF9wYXJhbXMgcGFyYW1z
ID0ge307DQo+ID4gKwlzdHJ1Y3QgbmxhdHRyICphdHRyOw0KPiA+ICsNCj4gPiArCWlmICghdGJb
RVRIVE9PTF9BX01PRFVMRV9GV19GTEFTSF9GSUxFX05BTUVdKSB7DQo+ID4gKwkJTkxfU0VUX0VS
Ul9NU0dfQVRUUihleHRhY2ssDQo+ID4gKw0KPiB0YltFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNI
X0ZJTEVfTkFNRV0sDQo+ID4gKwkJCQkgICAgIkZpbGUgbmFtZSBhdHRyaWJ1dGUgaXMgbWlzc2lu
ZyIpOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBhcmFt
cy5maWxlX25hbWUgPQ0KPiA+ICsJCW5sYV9kYXRhKHRiW0VUSFRPT0xfQV9NT0RVTEVfRldfRkxB
U0hfRklMRV9OQU1FXSk7DQo+ID4gKw0KPiA+ICsJYXR0ciA9IHRiW0VUSFRPT0xfQV9NT0RVTEVf
RldfRkxBU0hfUEFTU1dPUkRdOw0KPiA+ICsJaWYgKGF0dHIpIHsNCj4gPiArCQlwYXJhbXMucGFz
c3dvcmQgPSBjcHVfdG9fYmUzMihubGFfZ2V0X3UzMihhdHRyKSk7DQo+IA0KPiBIaSBEYW5pZWxs
ZSwNCj4gDQo+IFRoZSB0eXBlIG9mIHBhc3N3b3JkIGlzIHUzMiwgc28gcGVyaGFwcyBjcHVfdG9f
YmUzMigpIGlzbid0IG5lZWRlZCBoZXJlPw0KPiANCj4gRmxhZ2dlZCBieSBTcGFyc2UuDQoNCkhp
IFNpbW9uLA0KDQpUaGUgY3B1X3RvX2JlMzIoKSBpcyBhY3R1YWxseSBuZWVkZWQgaGVyZSwgd2l0
aG91dCBpdCB0aGUgcGFzc3dvcmQgcGFyYW1ldGVyIGZyb20gdXNlciBzcGFjZSBpcyBwYXNzZWQg
d2l0aCB3cm9uZyBlbmRpYW5uZXNzLg0KDQpUaGFua3MsDQpEYW5pZWxsZQ0KDQo+IA0KPiA+ICsJ
CXBhcmFtcy5wYXNzd29yZF92YWxpZCA9IHRydWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0
dXJuIG1vZHVsZV9mbGFzaF9md19zY2hlZHVsZShkZXYsICZwYXJhbXMsIGV4dGFjayk7IH0NCj4g
DQo+IC4uLg0K

