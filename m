Return-Path: <linux-kernel+bounces-46740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382584436C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AA11C22DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA04212AAF2;
	Wed, 31 Jan 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHALQVWu"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D312A15A;
	Wed, 31 Jan 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716357; cv=fail; b=qPEgPD7mv+qKKocwo1pTDBgTFBg2/q4ZPF9mmd0PVHHTCvKVxgo8T3af5qiHq+c6A0R1xCWw8jQGcxrIOECefcA6vRZDWzdNs7qRsA1vPXe3RWqZCVlMhOUH5Gb6bTVx0GhxC5MvUUPIz4tjApqpgV7XyfplkLgI41Lxu+8mbXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716357; c=relaxed/simple;
	bh=Icz4Cvz51d7o/PUO6p1f1BT/AYh8hbXOyJqXlluZaxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dH9Nb52uM3A5in2TVzFgioBSZzLRAkTld2WIFs8X6n2cUrjRP+SNYJSuzbsfzvTzuR6dZb6816OzOyzwg8mNZ0koa08x1Ppl9khITCRiKFLYG6rInJ9VRyEJWlREmxmZ8X7fft4DHSlKe60Cf+SRxfQZVu+QKSviwaO6xW2wYvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHALQVWu; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpKBc8kjQSnZh84FZKSKbHOwBJKXLvGqXCvJitcZl0PHnjWon1+PZZGpgQ0N33Ikz7p9DUeJmEy8OFXWHj3dl38B4yiH8YMILRh8R6DCstkfP+sDDrXMSSh+rd41LuNFVWRswDmtBtKpp72zLtOfsX4fdE5N1ryyy4HUb0PWsMkpLhgRZpIEcvcXXanXoky3QbmQzqwnWilWkBKHZqFsIKaMKg17rQdzD8DW/ghB+squDlSx4tiTiaN+zATl8D0as2B8z/updN2xYEhY7NjcqkTwyNJ3jvseUmh2bhXhDXmxeSpphi2BJFpiyJRz4EB2sUuEOzn1P6xtKyVzlnIdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icz4Cvz51d7o/PUO6p1f1BT/AYh8hbXOyJqXlluZaxo=;
 b=BqEzgoo/825oVmLvL7GP3a2NDYyP7CCbxW2hN+6/ZOjuoaV3TupdMph2FcvlseyLtzKxBsqCS5AULQQrI3P1CS++yMgTMRjkD4regAOgRavzfmtQzvzk52Sl+ChULmIn1PPHi9mYRFpj9TV7nvBwi4451D5GT8Amc70n/1X77o5qeZVBGGnkToCK7OTMLr6eozqVxdWzeF/G8Jy1A1sE8dCGtRkfYZ9MB2MKev9LetIDEK1HXTQaz8DaSRZqppHS8uQ2BK5o1sfEDfkPMZylFpGbtMFA9Yq7h/H++/cYk2u2JcLVkbcLaZU06Tw2rnwuLA7WADyH4CTC6Exb+zJ43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icz4Cvz51d7o/PUO6p1f1BT/AYh8hbXOyJqXlluZaxo=;
 b=qHALQVWu5IDTPyv5jy8mDsg51no8kho8qmbn3Ls+Aoawgx0Qc0TnA1J5w2ybA5IdBBqI628LxkjoKwX41h5R4en4mffe5vaxFANmf0aCSC5zm0ylVrsXMmVGNdZUiOrMB0BV5tlF1h3wiZq4Iw2eGb2ciyayKjvHZU7X504uih879Qp2dADoqohjDFSQsXcfc4KhjU3F6HSy1Mh5Ehi41pWwG0BxZuuHk1fVkJ+U6+yx5ryC54mloOl4o1CBkPmpSlbUGNlMVbGOAhpVU8WXIfYJlYEcvv5w089/zAYWFVwh3iDp6f+y1zbNtrgAguypeKFwfsllPAlkMdPiEgP5ng==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Wed, 31 Jan
 2024 15:52:32 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:52:32 +0000
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
Subject: RE: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Topic: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7DrCc6AgAb9nvCAAhi30A==
Date: Wed, 31 Jan 2024 15:52:32 +0000
Message-ID:
 <DM6PR12MB4516BC80DBF383A186707F19D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
 <DM6PR12MB45161C82F43B67AD8EDB950BD87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB45161C82F43B67AD8EDB950BD87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH0PR12MB5329:EE_
x-ms-office365-filtering-correlation-id: c0068db5-1542-4d2f-7706-08dc2274a30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ScWf6plQFoEiJnANHzTBLU8ywlQCbkDOyvRDaoH44X619pxu2VadTKJiDRlNBK+l3YGYw7FuD1Y53G/9H0+zgu2g7iPV/VCA9n/nmk0J4qv5mdjEvAnsWPuUtL47rbYrLHXSCtqlmq9VD8GF2CpNAK5VxnPqsxXXnto59UJW4R1MYDTcWW+t4IOMuAZlnEdPjpdzy1S4Y+A85YjQzSxj3DTwhlGU3OQXIQLAp2ksOQGP/RtCbIWBQ/lA+Z5jCjJ/VMV2C+kKHTxB4TB+5ltYqORQUQKKqKjK4HdzEzvdYn/aAjjE1DtOTG6/CgPezDsc5+mU1rFiycmX2Kc3fTbgdZY7wKHwsrF6Vy+o6+0aFMW4ouReTVu8ULI8eARnwbqgdE6nElzMqTDA4i9B/L8vL4MO0IqwGXxbP5SG1PEr73kSRzyMZBq509VZOxmnOHiUk0p7O69ticS6P1WKn3LC+fV0SmDBhyKUmREoMOemPTptlCo/FNt3oWIBTINrVusV/u89nxye2vb3L2HR9j8oOwVehTw2JDbVp2TCyObSER/VzUa//nXo6TU7+gNHpbG+AjhJ4EOeZnyQj53ESntBtShD+5bN2pwGyO2SFCFjOCnXG1YzA2OVhosxsk2iaFYU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(66899024)(41300700001)(83380400001)(86362001)(33656002)(38070700009)(2940100002)(122000001)(52536014)(107886003)(38100700002)(26005)(9686003)(8676002)(76116006)(7696005)(6506007)(2906002)(478600001)(6916009)(316002)(71200400001)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(8936002)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGhlb2Y4S3kzYU14cm10RWVFbmJraFBvWlp6VlNBSWZjRlJaRHN4NkxNOXdh?=
 =?utf-8?B?bHVodXBSbllkQWJRTGJRTWZDQXQyeHJDSmpYY2JBK1l6NVlFU0pJY2ZONlBp?=
 =?utf-8?B?eWRDNm8yc1ZlV0lEcXdGNTJXbng2OGpYOFo1T0p2aTVyVzZxZCtXQWtqVktE?=
 =?utf-8?B?d2dLWVlLYXFiVEd2UGo4UmN4L0x6YlJ6b2c2UDBUVTQxallkQjVZRkljQllJ?=
 =?utf-8?B?SXN5QkNSUldLd0FWZkxKaE92YnMxdWFqV1RWa1BBMGlGMTgxbDNPVmRhQWNI?=
 =?utf-8?B?eC9iSzJFRG45eHQ3aVpCMTZCMFIyakdHT0kzNHp2bzFoVVZqK2l4dDdoRnla?=
 =?utf-8?B?VGFuRFYveTNmTnJIUXlHVThWY3dnVHRWSjR2K2tnZlY1Y2ZwTVpqNEttNkVl?=
 =?utf-8?B?SlVkQnpDVFhjdEN4Smd0cmlrVzgwNVEyaldieVl0dVcwQXVHOUJBOUhaQ0xn?=
 =?utf-8?B?RFRuV0NrMEJQMXNncjRnM0VJZFBlZ0g3RkNEZUN0bmdBQThFZGlYeGwvYkhU?=
 =?utf-8?B?alkzRWs5NjNZaDJ4OGVWNEpITmVDUERacVBCSXN6ejFaL0p1dkkxSXJZb0dD?=
 =?utf-8?B?RHhrRXhmWWpVb2dwN0tDcUtLUEZOa0dXNEhGdko2dTRXeHZTSGZISGVrQ1Fo?=
 =?utf-8?B?YnFBWHlpRVA1YUdQY1FaeHVZYzFqWER2R2wyK3diemt6RCtYZXFUb0JpczhU?=
 =?utf-8?B?RzA4YlBsUVFMbU9Ia1YxTStMNU5xd0FlRkhTV3NvTFVQMHRmaDJMaFdyV0R2?=
 =?utf-8?B?QlZnRTI0bW45MmF5UWJmQXRyZFJabTFrSDdoQ1FwUzBCeDJiUlVMa3dQN0c3?=
 =?utf-8?B?MXlYc0NObE42ZWxLQjczMmhIdURVWUJaN0lNalNyd2VsN1dpeWJiWCtOMXZn?=
 =?utf-8?B?eFpPRWRFRGlDbFUrdzNwWWQ5SHdmRlJvN0VENnhRd0NvVGNpV2RyMUY0Q21j?=
 =?utf-8?B?bnErSkpEUnRYOHVEVzhiSS9lZFk1OGFhUzR1WkxFZ2xTMkxzdkhVS1h1cWhN?=
 =?utf-8?B?Y2tMUXUyVU1yMkI3T0NvREhMMHMyV25TQmZHUzk0Szc3bFRDNVlCWU1WdENu?=
 =?utf-8?B?Ry9JaXZ2ZTdVWXg2aHROMWg4QzFVcG0xNXhPVzg3WEJmbWpiMEZZWFl0UVYw?=
 =?utf-8?B?TjU5bkhIMXJsVzZmREprb3YzOStqTVB0RVJZMjVhVlJzRlRjZGovekVMWjdr?=
 =?utf-8?B?ek1oNmpjV3o3WmMwemtZRFg5NDNPYmk0N3RpOTh0b2JhM2V2Z1dBcFV5MFFm?=
 =?utf-8?B?VFBtSFk0M2dmZUZtb2t5NnB5aXJHYkNCemtFQ0FZOU1SQ3RHSCtYajQwUFpN?=
 =?utf-8?B?N2dieXhlbmZvd0MzQW4rdVc1M1RBWmhyRFNLMFNnU2oySy9ieEhIcXNJVWgy?=
 =?utf-8?B?T29RSnBCalpvRFdoeGM5bHB1dUVudlFCenhCR1RDZzBDR0RoU3JUSHBIZ2dj?=
 =?utf-8?B?YmpnZzRRVGp0K21xbU1yN1RhUk10QVJRTGtWOGkyc1NTdFNnaGxwTjRmZW1j?=
 =?utf-8?B?MUFOUzBiZEgwazZESWhhSldoMks3SC80d0hnY2RoclN2V0Y4UmszTFl1ZlE0?=
 =?utf-8?B?b1pXZ1FDMmgrSmk5SDdEaVpLNUFyTVVDckhxeGVrK0RZWm01Wm0zU25CbW5v?=
 =?utf-8?B?Y082RXBLRFRNeklac3ZFams2NW1aeUZ5Z2loNkdmVDRSVkw0VFVoZHJmUlhi?=
 =?utf-8?B?UVA4VGhnTzZPTWVwTm1YU3hRNUxCOWdEakpRMVp1OXdkNmtOa2VrbUIrVUhi?=
 =?utf-8?B?MlhPaFFNZTZmeEVkbktoUnNFY0xSaXpmYy9CV2IvelVPdkdvcG5GZEM0U2pr?=
 =?utf-8?B?VW9rQlZzV0kxU2dpdzh3TTFPaFVrK1BVT3BPVmJ3bmxhYVdWYTFxSFVxZmRJ?=
 =?utf-8?B?aHhibG51SGxRSHVhcjN1UWUydnE2ZnJFMGwxWlBvczF5K2RxWWNUUWpTb1JN?=
 =?utf-8?B?QUdLNGw1L09MaFpTYndVVlhZSlJrdm5GS2wwN2JnVkh4N0c5Sm8ra1pMZGtI?=
 =?utf-8?B?MVl1bVlwNDhPcVpyU29YUTBuSkdZNmdtdUg5ZFdBRk03QU1sa0J0OFpkcGJZ?=
 =?utf-8?B?RkZ6M2cxQWhscTdkbTh1ZDJqZFh5Z1VtMHBNZ1JObnU1dmFndVdWUGJLTXRo?=
 =?utf-8?Q?4QGkdiszdt5f3CLx9z2Xweyr7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0068db5-1542-4d2f-7706-08dc2274a30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 15:52:32.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V84S5bYrk+GMGr2B0p4QGd+ZvwrnONtdFqx4Pqp2SWOB9XMvQb2VyaRVGbAD9cIQukpcNV8oUtnYHQqJfK8oQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329

PiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIG5ldC1uZXh0IDkvOV0gZXRodG9vbDogQWRkIGFi
aWxpdHkgdG8gZmxhc2gNCj4gPiB0cmFuc2NlaXZlciBtb2R1bGVzJyBmaXJtd2FyZQ0KPiA+DQo+
ID4gPiArc3RhdGljIGludA0KPiA+ID4gK21vZHVsZV9mbGFzaF9md19zY2hlZHVsZShzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LA0KPiA+ID4gKwkJCSBzdHJ1Y3QgZXRodG9vbF9tb2R1bGVfZndfZmxh
c2hfcGFyYW1zICpwYXJhbXMsDQo+ID4gPiArCQkJIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4
dGFjaykgew0KPiA+ID4gKwljb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgKm9wcyA9IGRldi0+ZXRo
dG9vbF9vcHM7DQo+ID4gPiArCXN0cnVjdCBldGh0b29sX21vZHVsZV9md19mbGFzaCAqbW9kdWxl
X2Z3Ow0KPiA+ID4gKwlpbnQgZXJyOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIW9wcy0+c2V0X21v
ZHVsZV9lZXByb21fYnlfcGFnZSB8fA0KPiA+ID4gKwkgICAgIW9wcy0+Z2V0X21vZHVsZV9lZXBy
b21fYnlfcGFnZSkgew0KPiA+ID4gKwkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLA0KPiA+ID4gKwkJ
CSAgICAgICAiRmxhc2hpbmcgbW9kdWxlIGZpcm13YXJlIGlzIG5vdCBzdXBwb3J0ZWQgYnkNCj4g
PiB0aGlzIGRldmljZSIpOw0KPiA+ID4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ID4gKwl9
DQo+ID4gPiArDQo+ID4gPiArCWlmIChkZXYtPm1vZHVsZV9md19mbGFzaF9pbl9wcm9ncmVzcykg
ew0KPiA+ID4gKwkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLCAiTW9kdWxlIGZpcm13YXJlIGZsYXNo
aW5nIGFscmVhZHkNCj4gPiBpbiBwcm9ncmVzcyIpOw0KPiA+ID4gKwkJcmV0dXJuIC1FQlVTWTsN
Cj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwltb2R1bGVfZncgPSBremFsbG9jKHNpemVvZigq
bW9kdWxlX2Z3KSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiArCWlmICghbW9kdWxlX2Z3KQ0KPiA+ID4g
KwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiArDQo+ID4gPiArCW1vZHVsZV9mdy0+cGFyYW1zID0g
KnBhcmFtczsNCj4gPiA+ICsJZXJyID0gcmVxdWVzdF9maXJtd2FyZSgmbW9kdWxlX2Z3LT5mdywg
bW9kdWxlX2Z3LQ0KPiA+ID5wYXJhbXMuZmlsZV9uYW1lLA0KPiA+ID4gKwkJCSAgICAgICAmZGV2
LT5kZXYpOw0KPiA+DQo+ID4gSG93IGJpZyBhcmUgdGhlc2UgZmlybXdhcmUgYmxvYnM/DQo+ID4N
Cg0KVGhlIGxhcmdlc3QgZmlsZSBJIGNhbWUgYWNyb3NzIGlzIDQwMEsuDQoNCj4gPiBJZGVhbGx5
IHdlIHdhbnQgdG8gYmUgYWJsZSB0byB1c2UgdGhlIHNhbWUgQVBJIHRvIHVwZ3JhZGUgdGhpbmdz
IGxpa2UNCj4gPiBHUE9OIG1vZHVsZXMsIHdoaWNoIG9mdGVuIHJ1biBhbiBvcGVud3J0IGltYWdl
LCBhbmQgdGhleSBhcmUgcGx1Z2dlZA0KPiA+IGludG8gYSBjYWJsZSBtb2RlbSB3aGljaCBkb2Vz
IG5vdCBoYXZlIHRvbyBtdWNoIFJBTS4NCj4gPg0KPiA+IEdpdmVuIHRoYXQgdGhlIGludGVyZmFj
ZSB0byB0aGUgRUVQUk9NIGlzIHVzaW5nIDEyOCBieXRlIDEvMiBwYWdlcywNCj4gPiB3b3VsZCBp
dCBiZSBwb3NzaWJsZSB0byB1c2UgcmVxdWVzdF9wYXJ0aWFsX2Zpcm13YXJlX2ludG9fYnVmKCkg
dG8NCj4gPiByZWFkIGl0IG9uIGRlbWFuZCwgcmF0aGVyIHRoYW4gYWxsIGF0IG9uY2U/DQo+ID4N
Cj4gPiAgICAgIEFuZHJldw0KPiANCj4gT0ssIElsbCBoYW5kbGUgdGhhdCBpbiB0aGUgYWN0dWFs
IHZlcnNpb24uDQo+IFRoYW5rcy4NCg==

