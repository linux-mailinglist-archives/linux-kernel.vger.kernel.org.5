Return-Path: <linux-kernel+bounces-28532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571B82FFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B111C23B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1787493;
	Wed, 17 Jan 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GLntNgEJ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBA1C0F;
	Wed, 17 Jan 2024 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705468742; cv=fail; b=io2Vkam5jPI4rc1xhF3uz6Cpe4Xqqrf36K8Hk7JVtENN02ASyMq4Sb7a0I7Zf0xi64Ha4u47kPUvXpCOD5tjh/4QHrR/j6RO8hThiFYTX3t+cwCfuU9s57rp747XmfIiz42Zs/Fb9O/llOyBAd/K5XMTZH5vm02kMyd6QaY08ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705468742; c=relaxed/simple;
	bh=UPjTKOJuqh3JLjbxfw0oOWHPra89b4wUZICp45T4nno=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=JTJZ5i2TpLBFIcTS5f/n0KLi3oxfql0h2yS1dQAw+imsrkx2rFk8lgCco1XJAS/14FdAaxQfhdsFJivWky+ugggzHNxuDiRzRg5V7LhepHmlkemz4nifkoDAY4mWX3RW8vSnauvEc+u7xZuUBNLgfZKihLIPomgRqdelx6W5xMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GLntNgEJ; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAN0nubeHPezmhZQXO0TRa+3tNOSg01PakrJeB5j9bjU96Cktz8Mr+Q7JEWeeBjEW25Us0jH75K7Zy+68Wuqaq2PuzkxsFUgqWNefU+vG2CJR5/0daXnGvPQRk0ZcPIv99HJjZCbfSzg/Iy9i16yppj6mppA2p98ejKZPU0l8joPqz6FW2gfB9ZCbX3xKUyrwYA/Ke2Kka29ziBhrHH7pGkyPNwdssjY2D3U8UBJaUdg//P3/9f/1cAIseruPkvJ1s1OsE6WDe7YwB2d18xVxdeIVZs3FXXnhUmuUNfMjVOcnxdKVIyAx0PkoQQSbQgj6hl2mM6mTXRpZNVffqnhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPjTKOJuqh3JLjbxfw0oOWHPra89b4wUZICp45T4nno=;
 b=SmmWFfn+LuGEev5tYVU1IUpVyNJ3gdr9xc9C4BdEeH+ATUhhigmGWnwq1KcVEyFf9g4okkS0u0i4QiFyATtDPFfBXS8ZQLDj2jTdrJZ/Zb5bogRlwXARj1Cpo80XZRqOfvgZFXrI0PEq7T8gsNuqemu2XuQZaElyHiMTve5M/INMYl1JJ8Jb0dILG78CB2erOagazlAQbPJZ+5QLJW/w94pcQTFUfxDBjYazez99/t5Ox/cTTwvbPCnzU9G7hJt/y6sgvDj15mGDGJIODh5lbI8ffJYobVNm1gUQZuilQKZnnzZop7mU7siFrh4LJqTIA4gc0fodzSQuFl9MbTtuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPjTKOJuqh3JLjbxfw0oOWHPra89b4wUZICp45T4nno=;
 b=GLntNgEJdBwWjRFIakvprOUZEXKuUVOkmmG04r1wxrIY4MIkLkJJpau7jY5oIHIZpjAiyRrHOGhdPIPRQByTfr83PCBwdDNsZG+GyI/6JBr805pZtPriqJBHhWK/El7DAvKDJeqhExmwh4mNv1ltYw8hKLVEoA59kAuS0JPgbQk=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAWPR04MB9839.eurprd04.prod.outlook.com (2603:10a6:102:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 05:18:56 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::748a:98f4:59fa:f206%7]) with mapi id 15.20.7181.022; Wed, 17 Jan 2024
 05:18:56 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, Sherry Sun
	<sherry.sun@nxp.com>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Index: AQHaSQSrL12jmL1qaUSqNqyXbbSObA==
Date: Wed, 17 Jan 2024 05:18:56 +0000
Message-ID:
 <AS4PR04MB96927EB465ABC9EA1A94DC51E7722@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
	 <20231018145540.34014-3-marcel@ziswiler.com>
	 <AM9PR04MB860351E818A6DD715A7F88FDE7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
 <dca8bc7fec5f527cac2e280cd8ed4edae1f473ea.camel@toradex.com>
In-Reply-To: <dca8bc7fec5f527cac2e280cd8ed4edae1f473ea.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PAWPR04MB9839:EE_
x-ms-office365-filtering-correlation-id: f0e26811-5ff0-40de-f25d-08dc171bcdfc
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lB50d2bpWDn2SG3gC23gVBgmvlOUN5gdCLoaebG2LcEivK8j6Qr5U93MJtl8L7+q2Ri9IUxzwcTObnCJDOGpJym1fKcpULP+x6+Xzjr9zhbox71zXrpads65vyfewwYvr3xsJs0q7KYElSynSMMMiQxQDYW5Fdl208J3TzBQGXJuUFyF2N+y5OpZoT5vhs3GusxFE1Q4RUEq1Nsu1goqtUBbrSGE2dlRyJZKH26syHwQSAzA3CeS6QHZpJynvIFpXoh1v/yGtWJVW5aKLA/PNlrZMHkYCGTFJsg6ToBJLNo5s5CjjAk10icamc4Kva+Qd/kh5U5dY/UiiohX/+RVhkM2LP6d2w7g41RodQnkBjpdJCoMKCpHwFGVBZxdoN8PAlB4pYeaIG6htvlortUx17wVwod0gIrcOAe08buqBQIFYfVUaXuehsuQhlBhucqxmOa6RFc2ruz3mp/Is2rM0hGX9q6n0+UAOixMan2k/qmndn1FPo6uRa4s/JtDCGitUtdaZ8lXIrCm/25RYxhDQ5TFZH5DqsyI7+F8phtXEVe96M0pDG6g1BpeG/Xbs4ipJ1G3VslfRRNqQpvksAkGwD5R8jiyf2NeEwQWw6L421un4IaUi0Zck0vYCnffxikI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(71200400001)(6506007)(7696005)(86362001)(76116006)(4326008)(66946007)(64756008)(66476007)(54906003)(66556008)(316002)(66446008)(8676002)(8936002)(110136005)(52536014)(55016003)(38070700009)(4001150100001)(41300700001)(38100700002)(122000001)(9686003)(26005)(2906002)(5660300002)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUtZZDNpSTBuZys0UGJvZ3RVMVAyK3dETGcwRkd1bjhDVmNzVGpnSmdrZ2M2?=
 =?utf-8?B?aE92VC9hQnNMa29RbktlYzBtQ0lWczVKejlaVzMwTG9RdVlnQTVRYkt4d1Vt?=
 =?utf-8?B?d1haRURRTkYwWXdtL2pWUGthNFg2Y3BFcGZmWXBzQTNPbHIxbkFCNUY4WE1n?=
 =?utf-8?B?ZGJ5aEJkcy9tNU5UOVZqYTk0RnlLOUM3d2J1V2gxWE5UbUNLZzI3djIxRllm?=
 =?utf-8?B?M0xXN1dwaVJ1MzlKRHdPblVHWHFmUGRDK2g4V0xaOUh0NDBNTk1rdHlzbVI0?=
 =?utf-8?B?RFgvK2p3M2RIbk9vS1g5MGR3b09vaWZiREY5U1VTOHJJYkVZclBBcWdsSGZ0?=
 =?utf-8?B?SWU5bVMzaitsSlJQMnBLeTdHZ0NScSt0WWxoMFd5aVlKOHBoVkFKdWlhM0xV?=
 =?utf-8?B?bWFxOGoxS3pBZjJWV2ZidFdKWlNES0VFdmVCWm9WOFpzdEM4SHoycm9mNksx?=
 =?utf-8?B?WVovYlZUNk0yU3Z4cWJmU2d1NmRaQSszWEdYaGxCUzR6YldVRGdRSjZBUUly?=
 =?utf-8?B?eHp5c3JseWJKYjdIQkxtUVdjQXhQUlZsazZKbmZyZVlrOSt3MFpMdDRLKzlh?=
 =?utf-8?B?Z1NUMDI5Y3AvdDJrRzJhRzBBL2hmVW05R3JMUzg1aXFySmY3OFFGTzcwcnEz?=
 =?utf-8?B?Q25xUFBFaHZ0WnZMdjNIeTAwRVhBTlR2SFExQ04rYXNZN09uYTZTQndqUjAx?=
 =?utf-8?B?R3FlNlhTdVlQc2I1QzlGMVNCQS9xQllQL3pyY0lpRnkxcFpZNVNJa3dYUHhO?=
 =?utf-8?B?RTlJbm1mM3MrMkhVMWpFTU10dzZOMnNHSC9wU1Y4Vnp0MHk2YzRTM0IvWVUw?=
 =?utf-8?B?bEhNMWFrMS9pN2FvZGt1SXRmcUhxRlR2RmVXYXIzTlR0a1BmTHlkM0NPTUpB?=
 =?utf-8?B?QVpzSHBkc0ZkeUJMYzRUZExsMXBnWFJsQVJmUDJoTEsrZ1lNdzR4dEJaeUlZ?=
 =?utf-8?B?cVMwZHdYUGZ6cFdMOGwvUXdyaUN3R2NsdWhaOU9KYmRVYitFYnRmT0NWcXZ6?=
 =?utf-8?B?STAwS2tzYll5V01TaENhRnBlcUU1MFZhSUF0UWhEQVBWRDRzeEh2MkpiN001?=
 =?utf-8?B?OHhGaENlRThxYXlocjA5T3JaUDNPSVVsb0ZDMFloOHVPN09DYitJUmV1RVV6?=
 =?utf-8?B?aEY0WmNmbS83SDRmWkY0dXh4SGJSWGYzVndBRnNhd2o5UXFod05vK0pxd1Nv?=
 =?utf-8?B?Yy9IbEJyOHpNM3gzMkNkb1BXZk5GRFRWNVRKNGlZaHNmU2JaOEZMZm5sRmxE?=
 =?utf-8?B?N2tGU1FDK1NOTUNGYmFFdkhwUHdRUmQ4czhEaXlYT2QvdUozTmVQUi9VaVdV?=
 =?utf-8?B?QVJjV0lENkJJQWJrYlF0WTRUQ1V5Qmt4Y2Fnd3hPbUZIdVp1L2orSnJFUVND?=
 =?utf-8?B?MUJ5SHphc3d3MGpBYW1EalY5K1RlWTVNM2twV0Z5VHgwd2NUZjJaMDRRME1W?=
 =?utf-8?B?WlZGMDg5NU54dzA2UWI4VlV3bTY5bFR1eXVxK3QzMHhKL3BZU3hYVDY4WVIv?=
 =?utf-8?B?dUlUOHBlR2p0RDJhTlk4QW9tMGV3N0VTa0Irbkp5aUJkaFpjN01RSFhLak1K?=
 =?utf-8?B?c0QxYTlDWkZENmoxd0sycWdZUWh5QXljRFo5NFdRajA1cU1hVXRubDJJOWdZ?=
 =?utf-8?B?WmZ4UUhTbmM3b1dIUVR3alNNOEFjaE1iZ1ZvTzBPU3VmQ2J4dkVMdFBwM0cz?=
 =?utf-8?B?QkVmbjNIWVdkOWpnREQ2OXhKdGFsZXc4eE5ZSnZLUUZXZjBOdUZDb1lleE9T?=
 =?utf-8?B?MjdFZlBSM3FVeVdndlhLWkVsdTNBaEgrMzBENk0rdTZDOUMvT2dXVGRMVkNH?=
 =?utf-8?B?MXYwR2c2cDIva2FXbWRNMU9hZVNSNjJpc29IQThMODFjSk1wMEJBSlAxWFdZ?=
 =?utf-8?B?dlBLcG1ON1BmSDQ4dGFteEJmYzIwc0JkYTgwMGZaMnViaTBsSjZZeVhuVzUv?=
 =?utf-8?B?azUwWG13WkJRWFF3Sm1lc3REM0gzUlN4c1RRaS9nZHVmejlPbkdhc0tEcXlL?=
 =?utf-8?B?ZmozVTM2NXV2QnJTd2tYWFVxRDBMREo1WWZUeEJxSlpxSk5GMnE2UXNvWndG?=
 =?utf-8?B?RG5neSs0Q1pGMzRmTHcwQTBub3lnMlBCelprQjFNSmJTWWlYbGlXR0E5WUEv?=
 =?utf-8?Q?syOlJffG9Dm/wWs2SDmDuDLex?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e26811-5ff0-40de-f25d-08dc171bcdfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 05:18:56.6865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye8Wk+fo5tPpDsPkoxAutXulLZN4x6CAfEQhIDzwks2NYycder1HVp+oSrX/Zki0xerkm8QWG1W5OS4abfutjjgNVs08MCOlWwjt6Ki58Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9839

SGkgTWFyY2VsLA0KDQo+IEhpIE5lZXJhag0KPiANCj4gT24gV2VkLCAyMDIzLTEwLTE4IGF0IDE1
OjI4ICswMDAwLCBOZWVyYWogc2FuamF5IGthbGUgd3JvdGU6DQo+ID4gSGkgTWFyY2VsLA0KPiA+
DQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUaGlzIGNoYW5nZSBsb29rcyBnb29kIHRv
IG1lLg0KPiA+DQo+ID4gSSB0aGluayB0aGUgc2NlbmFyaW8geW91IGFyZSB0ZXN0aW5nL3Jlc29s
dmluZyBpczoNCj4gPiAxKSBMb2FkIGJ0bnhwdWFydC5rbyBmaXJzdCAod2hpY2ggIm1heSIgbG9h
ZCBCVC1vbmx5IEZXIGlmIGNoaXAgaXMNCj4gPiBwb3dlcmVkIG9uKQ0KPiA+IDIpIFBvd2VyIGN5
Y2xlIG9yIHBvd2VyIG9uIGNoaXANCj4gPiAzKSBMb2FkIFdMQU4gZHJpdmVyIHdpdGggY29tYm8g
RlcNCj4gPiBSaWdodD8NCj4gDQo+IFllcywga2luZGEsIGJ1dCB0aGVyZSBhcmUgcmVhbGx5IGEg
c2xldyBvZiBpc3N1ZXMgd2l0aCB0aGlzIGRyaXZlciBvciB0aGUNCj4gY29tYmluYXRpb24gb2Yg
aXQgd2l0aCBtd2lmaWV4X3NkaW86DQo+IA0KPiAxLiBTaGFyZWQgcG93ZXItZG93biBwaW4gKFBE
IykgYmV0d2VlbiBCbHVldG9vdGggYW5kIFdpLUZpDQo+IElzc3VlOiBUaGVyZSBpcyBjdXJyZW50
bHkgbm8gY29uY2VwdCBpbiB0aGUgTGludXgga2VybmVsIHRvIGFjaGlldmUgdGhpcy4gTGFzdA0K
PiBmYWlsZWQgYXR0ZW1wdCBbMV0uDQo+IFdvcmthcm91bmQ6IEluc3RlYWQgb2YgdXNpbmcgbW1j
LXB3cnNlcSB0aWVkIHRvIHRoZSBXaS1GaSBkcml2ZXINCj4gKG13aWZpZXhfc2RpbykgdGhpcyBj
b3VsZCBiZSBob2dnZWQgYXQgYm9vdC4NCj4gSG93ZXZlciwgdGhlbiBpdCBtYXkgbm8gbG9uZ2Vy
IGVhc2lseSBiZSBjb250cm9sbGVkIGUuZy4gZm9yIGEgKG1hbnVhbCkNCj4gcG93ZXItY3ljbGUu
DQo+IEEgbm92ZWwgYXBwcm9hY2ggbWlnaHQgYmUgdXNpbmcgYSByZWd1bGF0b3Igd2hpY2ggY291
bGQgYmUgc2hhcmVkLCBob3dldmVyLA0KPiB0aGlzIHdvdWxkIHJlcXVpcmUgdXMgaW1wbGVtZW50
aW5nIHJlZ3VsYXRvciBzdXBwb3J0IGluIGJ0bnhwdWFydC4gTm90IHN1cmUNCj4gd2hldGhlciB5
b3Ugd291bGQgYWN0dWFsbHkgYXBwcm92ZSB1cyBkb2luZyBzby4NCj4gDQo+IDIuIEJsdWV0b290
aCBkcml2ZXIgKGJ0bnhwdWFydCkgdnMuIFdpLUZpIGRyaXZlciAobXdpZmlleCkgbG9hZCBvcmRl
cg0KPiBJc3N1ZTogQnkgZGVmYXVsdCwgdGhlIEJsdWV0b290aCBkcml2ZXIgKGJ0bnhwdWFydCkg
bG9hZHMgYmVmb3JlIHRoZSBXaS1GaQ0KPiBkcml2ZXIgKG13aWZpZXgpIGFuZCB1c2luZyByZWd1
bGFyIG1tYy1wd3JzZXEgZm9yIG13aWZpZXhfc2RpbyB3aWxsIG9ubHkNCj4gcG93ZXItb24gdGhl
IG1vZHVsZSBsYXRlLg0KPiBXb3JrYXJvdW5kOiBUaGUgaW5zdGFsbCBkaXJlY3RpdmUgaW4gbW9k
cHJvYmUuY29uZiBjb3VsZCBiZSAoYWItKXVzZWQgdG8NCj4gZW5mb3JjZSBtd2lmaWV4L213aWZp
ZXhfc2RpbyB0byBiZSBsb2FkZWQgZmlyc3QuIEhvd2V2ZXIsIGRvaW5nIHNvIGFkZHMgYW4NCj4g
dW5uZWNlc3NhcnkgZGVwZW5kZW5jeSB3aXRoIHVzZXIgc3BhY2UgYW5kIGlzIGluIGdlbmVyYWwg
ZGlzY291cmFnZWQuDQo+IA0KPiAzLiBEaXN0aW5ndWlzaCBwb3dlcmVkLW9uIHZzLiBwb3dlcmVk
LW9mZiBzdGF0ZQ0KPiBJc3N1ZTogV2l0aG91dCB0aGF0IGtub3dsZWRnZSB0aGUgZHJpdmVyIGhh
cyBhIGhhcmQgdGltZSBmaWd1cmluZyBvdXQNCj4gd2hldGhlciBvciBub3QgaXQgbmVlZHMgdG8g
bG9hZCB0aGUgZmlybXdhcmUgYXMgb25seSBpZiBpdCBpcyBwb3dlcmVkLW9uDQo+IChhbmQvb3Ig
d2l0aG91dCBmaXJtd2FyZSkgd2lsbCB0aGUgQmx1ZXRvb3RoIHBhcnQgb2YgdGhlIG1vZHVsZSBz
ZW5kIGl0cw0KPiBib290IHNpZ25hdHVyZS4gU28gdGhlIGFic2VuY2Ugb2Ygc3VjaCBib290IHNp
Z25hdHVyZSBtYXkgbWVhbiBlaXRoZXINCj4gZmlybXdhcmUgaXMgYWxyZWFkeSBsb2FkZWQgb3Ig
bW9kdWxlIHBvd2VyZWQtb2ZmLg0KPiBXb3JrYXJvdW5kOiBUaGUgQmx1ZXRvb3RoIFVBUlQgUlRT
IHBpbiBzZWVtcyB0byBhY3RpdmF0ZSBhbiBpbnRlcm5hbCBwdWxsLQ0KPiB1cCB1cG9uIHRoZSBt
b2R1bGUgYmVpbmcgcG93ZXJlZCBvbi4NCj4gSG93ZXZlciwgcHJvZ3JhbW1hdGljYWxseSBpdCBp
cyByYXRoZXIgaGFyZCB0byBkZXRlcm1pbmUgdGhpcyBhcyB0aGUgcmVndWxhcg0KPiBVQVJUIGRy
aXZlciAobm93IGRyaXZpbmcgUlRTKSB1c3VhbGx5IGdldHMgbG9hZGVkLg0KPiANCj4gNC4gRGV0
ZXJtaW5lIHdoZXRoZXIgb3Igbm90IHRvIGxvYWQgdGhlIGZpcm13YXJlDQo+IElzc3VlOiBJZiBp
dCBpcyB3aXRob3V0IGZpcm13YXJlIChhbmQgcG93ZXJlZC1vbikgdGhlIGJvb3QgbG9hZGVyIHdp
bGwgc2VuZCBpdHMNCj4gYm9vdCBzaWduYXR1cmUuIElmIHRoZXJlIGlzIG5vIGJvb3Qgc2lnbmF0
dXJlIGl0IGNvdWxkIGFzIHdlbGwgYWxzbyBzdGlsbCBiZQ0KPiBwb3dlcmVkLW9mZi4NCj4gV29y
a2Fyb3VuZDogQWxzbyBjaGVjayBDVFMgYXMgaXQgZ29lcyB1cCBpZiB0aGUgZmlybXdhcmUgaXMg
bG9hZGVkLg0KPiBVbmZvcnR1bmF0ZWx5LCBpbnRlZ3JhdGluZyB0aGlzIGluIGJ0bnhwdWFydCBp
cyBub3Qgc28gdHJpdmlhbCBhcyBzZXJkZXYNCj4gaW50cm9kdWNlcyBpdHMgb3duIGFzeW5jaHJv
bm91cyBjb25jdXJyZW5jeSB3aGljaCBpcyBhbHJlYWR5IHVzZWQgaW4NCj4gZXhpc3RpbmcgY2hl
Y2tzLg0KPiANCj4gNS4gRGVwbG95IHNlcGFyYXRlIGZpcm13YXJlDQo+IElzc3VlOiBEb2VzIG5v
dCByZWFsbHkgc29sdmUgYW55dGhpbmcgcmVzcC4gYXMgdGhlIHBvd2VyLWRvd24gcGluIGlzIHNo
YXJlZA0KPiB0aGlzIHNlZW1zIGtpbmRhIHBvaW50bGVzcy4NCj4gDQo+IFlvdXIgaW5wdXQgb24g
YW55IG9mIHRob3NlIHRvcGljcyBpcyBtdWNoIGFwcHJlY2lhdGVkLg0KDQpJIGhhdmUgc2VudCBh
IG5ldyBwYXRjaCB3aXRoIHN1YmplY3Q6ICJbUkZDIFBBVENIXSBCbHVldG9vdGg6IGJ0bnhwdWFy
dDogRml4IG54cF9zZXR1cCBpbiBjYXNlIGNoaXAgaXMgcG93ZXJlZCBvbiBsYXRlIg0KDQpJIHdv
dWxkIHZlcnkgbXVjaCBhcHByZWNpYXRlIGlmIHlvdSBjb3VsZCBoYXZlIGEgbG9vayBhdCB0aGUg
cGF0Y2ggYW5kIGxldCBtZSBrbm93IGlmIGl0IHNvbHZlcyB0aGUgYWJvdmUgaXNzdWVzIHlvdSBt
ZW50aW9uZWQgaW4gYSBuZWF0IHdheS4NCg0KQXMgcGVyIHRoZSBuZXcgY2hhbmdlLCBpZiBubyBi
b290bG9hZGVyIHNpZ25hdHVyZXMgYXJlIHJlYWQsIGFuZCBDVFMgaXMgaGlnaCwgdGhlIHNldHVw
IGZ1bmN0aW9uIHJldHVybnMgYW4gZXJyb3IsIHByZXZlbnRpbmcgSENJIGludGlhbGl6YXRpb25z
Lg0KQWZ0ZXIgZXZlcnkgNSBzZWNvbmRzLCB3ZSBhdHRlbXB0IGEgcG93ZXItb24sIHdoaWNoIHJl
c3VsdHMgaW4gY2FsbGluZyB0aGUgc2V0dXAgZnVuY3Rpb24gYWdhaW4gdG8gY2hlY2sgZm9yIGJv
b3Rsb2FkZXIgc2lnbmF0dXJlcyBhbmQgQ1RTIGxpbmUuDQpUaGlzICJwb2xsaW5nIiBzZXF1ZW5j
ZSB3aWxsIGNvbnRpbnVlIGFzIGxvbmcgYXMgdGhlIG1vZHVsZSBzdGF5cyBpbnNlcnRlZCwgb3Ig
dW50aWwgdGhlIGJ0bnhwdWFydCBkcml2ZXIgZG93bmxvYWRzIEJULW9ubHkgRlcgb3IgdGhlIG13
aWZpZXggZG93bmxvYWRzIHRoZSBjb21ibyBGVyAob3IgYm90aCBtb2R1bGVzIGRvd25sb2FkIEJU
LW9ubHkvV2ktRmkgb25seSByZXNwZWN0aXZlIEZXcykuDQoNClRoaXMgaGFuZGxpbmcgaXMgc3Vw
cG9zZWQgdG8gY29tZSBpbnRvIHBpY3R1cmUgb25seSB3aGVuIG13aWZpZXggcHdyc2VxIGNvbnRy
b2xzIHRoZSBzaGFyZWQgUERuIHBpbiBvZiB0aGUgY2hpcCwgd2hpbGUgdGhlIG5vcm1hbCBzZXR1
cCBzZXF1ZW5jZSBzaG91bGQgd29yayBhcyBpdCBkaWQgZWFybGllciBmb3Igb3RoZXJzLg0KDQpU
aGFua3MsDQpOZWVyYWoNCg==

