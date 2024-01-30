Return-Path: <linux-kernel+bounces-44059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C6841CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C844286D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03253E29;
	Tue, 30 Jan 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqTVZ9xY"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5853E09;
	Tue, 30 Jan 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600586; cv=fail; b=h1d8R12z2TutpZtW/lJ1Q7sFnX2/Tk78xlOLaDqpIYXeT98DZyxM8pCpvLWmSNNQQapXQ7h8d+u0EnYXBKehqlqptTpGCdCawOtZeHdnfee7rPkeEBffm7sueulrFHZz1lH0d5moeOu3SuFlFaQUkoNAlbpx7oxCAM4F8QIaeFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600586; c=relaxed/simple;
	bh=Qd/nvu3LrX5B6GzOWNGqD/HqxEwd8eKFyr69AStNJGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jdJbI6LF+bBgDcEsv1CLVQzhc7U72AVNN0xPp+W/pvPIYhW6yeO0J6Kt+4YmP4js6brijxXPx/gILgekbhvKfxwbefuvNzieZHquNW+CqASk7izA+w+gSb/fQa5zAiqBCSnw1PJkOZgTopbnpDrojhTdiZH29t6JjdTVx7Hhh3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqTVZ9xY; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Spr2JtSlFQyI0J9uqWrXS+Ahe16PUBFnRWsjV9iJk6dw+vuMknYcRS4IMIFEmh4+AyYkZvtXFRmtCoo4fb8AKMnF8H0AdzwJfw+GLEIlU7HCmowT13m+w3x7lnyjgm14kw53JLoe73c0WkWY3Z/Lo2YTmzmMSs53EczW8i5iCToL02d3KSPDQS5WSHYIN8EWSEoPnd67VxRLUvg1HHImXNECmO0F2vM6fnsi0W9SE9/NONW1AOp2njyb8THpWTaHt/kjs0D/wnAJTcaHp5n5uvBYEwdlPLjOw/gSmV5Jzu0oW4V2sVj7znFwSvHUbnfDAsHvGS4DVYsohHdDFU4/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd/nvu3LrX5B6GzOWNGqD/HqxEwd8eKFyr69AStNJGU=;
 b=RI0KHQwJnsGrF7klw+6yP+nTNvtD74CQ1xtY7y0F5wPWgShOjsASIR/UaQ6KFZU++hWK7Wya9bBjGkldkRgRAt2dktHH0xv+Sw8C5Sy9JTKrHb57s8kBH13zIPg9rhwhEo6/4Cvtf2SsdTyOsG6k2ioGWtfL7m7LDcLL7cTAxc0jJRu+I4ogXV9fKd7yPspl9MiIFOwClMg+BRxf1SP/o/GbY52JV+nhg7AkSXRgfNlIfiCjFvmj/44IUf15Vlz1Ha4wnq6ydinK/XOu68CLInigQ2w8P9ZjaT88spkPD7FZgyNB4EnONnh22+XPbzTNL1VyWp7ayuvoTkM8csrbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd/nvu3LrX5B6GzOWNGqD/HqxEwd8eKFyr69AStNJGU=;
 b=HqTVZ9xYGGiSFe2GNNwsVFy2olK9guDP68WDtHJlvkEthpsQJJxa9coGKvwo6QWLG4i6DW+xTww8OZo3oTZ5OOQl4I4Dsmgk9ZHDqLyrlld+CJWpo5ouHykjmwIHG+q28VjpavWlZ4cvFKAc6rTvussmbmdp601V9oIVW3SpYAdnUstF5/RBFxQQPYXk7OeHrQ8wsJm+eh3tIE3nnT0wHjt2ilZnzV7Fke4pajZKCqF/Yi+hcBlUfssE30dSMuferRXTzlzwIV+rrTaYDc44WvWp7poS02MKnVD//m/ZrptyR9C4GsQQNMB/WwVf48GPMbew7tPdbG49B3DMr/LllA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 07:43:02 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:43:01 +0000
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
Thread-Index: AQHaTQ9wgRzMSsypjUOlyEfOvVgnwbDq/18AgAAFZwCABwCmcA==
Date: Tue, 30 Jan 2024 07:43:01 +0000
Message-ID:
 <DM6PR12MB451687F0408B3114DCAA7DC9D87D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-2-danieller@nvidia.com>
 <9eecccb0-a875-4dbc-b88c-5b2aad838305@lunn.ch>
 <20ab7355-fc72-4dba-b3ea-db2244909bab@lunn.ch>
In-Reply-To: <20ab7355-fc72-4dba-b3ea-db2244909bab@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH2PR12MB4037:EE_
x-ms-office365-filtering-correlation-id: a7f542c2-67a4-432c-5b02-08dc21671624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YOkvrzVyGjjmoW4oZqA5eNVRq5UpvyGtPoEjC+7K5Wl+xImcYjiu+81/IX4ZlAisstqiXYX2eQhFdyFkd2dUXU65NH44dezEuQFRVU3dN0OlwN6FDJ0opKlr8zlE4jo5JEueH7weoLwhInDInfCie72hHIAizQyTdBMhL8/9hkecL+3VqpWu8Oq1H/ofrfKYxMvFuE9c5VVV8I+nNIP7g7f+Nj9zT5Xz9u8QCcc9luysKHam8G0NvAzfkB7Uj8MAUUYSM4XLb8bb4AjWOUYH9nw0Ekw/jdK2eYmzMpmn3pkGJwOP7UIDdnFBTfZpEiCnLpCeGfoePanHxfUuZOu7+3ypjNEYVWgAoSLa171SDuhMZAFBT/iOTcu+SmN0KivS9SJJcgUzUBH8SSEDo9NrfOeiZux0rCbzHsk8Uz4fGvNmmNImJzcv17pGiZmDrU5CRzWpTILPb2qoqRV4KxbORAeSz2WHT6/erX5IiusmrLC9bwlYQqxElEQd3UkiQ1JkVghzm+hNpnF4ReSbG+3pX82N9W+mmoS+uyD9e9nt4usDzWRqQd9w5N2IWeixA0VdnJybE9vVxui99+xt29T5qbHYf1BrpbvitpoxMLaDRYbXRuhr53I0OYE5kaCotcAL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52536014)(66556008)(7416002)(4326008)(8936002)(8676002)(5660300002)(2906002)(86362001)(33656002)(76116006)(6916009)(54906003)(38070700009)(316002)(9686003)(66446008)(66946007)(38100700002)(122000001)(66476007)(478600001)(6506007)(7696005)(64756008)(71200400001)(83380400001)(26005)(107886003)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW1jcUN5dUZsQktXVlJmM05ZSE1QRVpJWFZKQ0wvOEdMamFQVkdqSkdJVEcz?=
 =?utf-8?B?VHJlYnpSOHZyckFWanJJWVoxU21yV1NsN0hZNlArL1YzeHhZTzRJM2E3RTYy?=
 =?utf-8?B?ZDRTVVJURWgyS2t3VkErWVB4dW1qc1ludGs3VVJhVm5HYzluaTlyYzFCTFYw?=
 =?utf-8?B?MXBiWE5rQWRNc1ZidmVVVG5yL1E0Y3ZLYWlOOFhNNkNSSm03M3lRb05HT3U0?=
 =?utf-8?B?K1lvNkFXSllpY2R1RXdzSlJiakxjbXFtY3M0LzdmeXZLOTUyL1BST3dhZ013?=
 =?utf-8?B?Z2NBZ3dVYU14MTg3NWI1T3k1Y0txby85L0pPQUR0dWhZVTlDbU8vM0VRVkxy?=
 =?utf-8?B?ZmxmNUYrUDh3K21kYktrSFlGK3hLMjI3QUxqQ3pEVUwyNEk3M1ZQU2I4dWNW?=
 =?utf-8?B?VjlVcDFWdURtWlAzY29VbUEzVGtBNGFPTDUwRWs4My9hMk9BckIrMUJDRzVs?=
 =?utf-8?B?UU5HZ1F3SGtIeGIwc2dJZGVXSUZpUXBZd3ZQVGlramZqWTEra2lYK2l2R1gv?=
 =?utf-8?B?bTNpTHpqMHEybStSclc3VkR5MFBvTFZrQUF0Y0tnMTBRdG9VVHZhMkpacjBr?=
 =?utf-8?B?UDkrTERwSVNzallEYTNUK3QzdXppU1JKbkYwT01XdGRhb1JGVm4vZHVWTEVS?=
 =?utf-8?B?aWpjS25yT0VWRjluWVhoaHpBOTJqZjhXdkdENHVXTEkwd0RaSnVpdGl4a1BI?=
 =?utf-8?B?Um53a2xFeVNXM0I2Rk9UN3o2eVR4VzVTODUvRUtpYjQ2OVkyRkxDdlJxcW4z?=
 =?utf-8?B?cnNoZjJ6S05DMEVGbVo1UXk3TVdCVGQwQm5VRi85NUNUbVdiZkJPMy9HaFpU?=
 =?utf-8?B?a0wzYVMyYkNGdTFJYkhjYlFwVjZ2R2VuVTFKY1diTitTcGxZdDlSRmE1RmpS?=
 =?utf-8?B?bzIvRXdrY1JQZGwrL241SzM0T3AxWEpCakp0bVkzdWRHWGRENTNhejBNRkVs?=
 =?utf-8?B?QTZKTVcxVXlJZTVYUFNvdUVhVmV6bThpZ2RhRkc5K0tTYWpucHhxYTZjY3Q2?=
 =?utf-8?B?Rk1lMUFDNSsxcEFjcmJsY2gvbzJFdm9nZWVMYnpYREwrd0hlNCtTM2hDeGtv?=
 =?utf-8?B?RStTcmNGTDdrTzZYVWhwbWVKRFdqeU1UanYxbFArbytHRFIrMS9TZ3ZHdnl2?=
 =?utf-8?B?UmNtVEl4bTFtMFJQUXZjbmNhRnhBRUN2Tzh0c3RlK3ZLeEpmZ3A3dzhNb2Rs?=
 =?utf-8?B?K0w0dUxhczVsVDVubldUVmx2bFpHbW5YSmFwaEpHTDVoRzZDMjJiYUhZYnpu?=
 =?utf-8?B?REk3SldkM0RkWnNsa3pKRUpNNXJJQXlDSEdkVXcvN0h4OERkVVhUYW9nSVY4?=
 =?utf-8?B?R1FEYlR2RTM2UjN3RDFVL0tRQzlpNVY3N2RWUUtPM3N6TnYvN0FwRmJKdmtX?=
 =?utf-8?B?RVNONnNieWRYcmsxendXV0FGSHFNNWVETGdHeUlxNmVCRzBSMC9EOVZkM0JP?=
 =?utf-8?B?TzByM1NhZ2VsczdCcjVjV3pJRXA3OVQyMzhSTkdKS29Ec0szbEN1eEpMYktS?=
 =?utf-8?B?WnZrZ0lGRWp5V2FZTDdEYS9qbUtPM3psNHFxZXBIeGJla2I2Z1k2NkJkR1Ex?=
 =?utf-8?B?SStaeE1ndDdMZ001MXFpMittVmdEQXA2YW1vNFE2U3VQcTVkNmZpZ1ZZLzV3?=
 =?utf-8?B?S2FmNE5lMDZzUm1OL3hIV3BuY3hwSmc0b3JFNFZ1Kzc1aHk1R0tBaHkwNWFT?=
 =?utf-8?B?L05PQ1dDZ1l3T0RhN0ZyUjNXZWIyMzhHSTZTY21Uc2xxWU81Nks4Rm15WkVX?=
 =?utf-8?B?akdqdG9jSTM0VVlZVm5nQ00vcitzdHlzbVFIY1Q3WVN5UFgwaUlqK1A4VnNh?=
 =?utf-8?B?OW5tWTEvTmZha0VjVDB0YkMxdUJPbnI0SUFkTG5GRzVpSlAyUXVVNUQraVNw?=
 =?utf-8?B?U3hpVHJCajh1NmNTeDhQU28rVjE3VE9rU2xnWFIzWUNnUS9ySkY3dG9BTTNS?=
 =?utf-8?B?RGg4S2FiWHBxYVdJRTl0ZjJTbUpSb2dFQ1BRbW1hMlhKL2ZwbUlWRjRtcENL?=
 =?utf-8?B?eVRYaiszSktQWVhzeWhCNm11aFVndzZxS05IaU9DUTlrcWc0T0dEMjI4c2ow?=
 =?utf-8?B?QlBOQ2E1dzd2ZUF0eEQ3dDFscDZIT3pUS0w5Qjk0WDZkUkY3eFVyREp5Q0t2?=
 =?utf-8?Q?kwUvZZa90q2Aieshq2roYKnrb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f542c2-67a4-432c-5b02-08dc21671624
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 07:43:01.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zopphb2bPGPd63MxJEJXEkOzF7I1Voa3e5+GfRw2L4Ig2FGcCRxJR4Fz3hxabBCnPM3TJjf0eCVRMpJogkgabg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

PiA+IE9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDEwOjQ1OjIyQU0gKzAyMDAsIERhbmllbGxlIFJh
dHNvbiB3cm90ZToNCj4gPiA+IEZyb206IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+
DQo+ID4gPg0KPiA+ID4gRXRodG9vbCBjYW4gYWxyZWFkeSByZXRyaWV2ZSBpbmZvcm1hdGlvbiBm
cm9tIGEgdHJhbnNjZWl2ZXIgbW9kdWxlDQo+ID4gPiBFRVBST00gYnkgaW52b2tpbmcgdGhlIGV0
aHRvb2xfb3BzOjpnZXRfbW9kdWxlX2VlcHJvbV9ieV9wYWdlDQo+IG9wZXJhdGlvbi4NCj4gPiA+
IEFkZCBhIGNvcnJlc3BvbmRpbmcgb3BlcmF0aW9uIHRoYXQgYWxsb3dzIGV0aHRvb2wgdG8gd3Jp
dGUgdG8gYQ0KPiA+ID4gdHJhbnNjZWl2ZXIgbW9kdWxlIEVFUFJPTS4NCj4gPiA+DQo+ID4gPiBU
aGUgcHVycG9zZSBvZiB0aGlzIG9wZXJhdGlvbiBpcyBub3QgdG8gZW5hYmxlIGFyYml0cmFyeSBy
ZWFkIC8NCj4gPiA+IHdyaXRlIGFjY2VzcywgYnV0IHRvIGFsbG93IHRoZSBrZXJuZWwgdG8gd3Jp
dGUgdG8gc3BlY2lmaWMgYWRkcmVzc2VzDQo+ID4gPiBhcyBwYXJ0IG9mIHRyYW5zY2VpdmVyIG1v
ZHVsZSBmaXJtd2FyZSBmbGFzaGluZy4gSW4gdGhlIGZ1dHVyZSwgbW9yZQ0KPiA+ID4gZnVuY3Rp
b25hbGl0eSBjYW4gYmUgaW1wbGVtZW50ZWQgb24gdG9wIG9mIHRoZXNlIHJlYWQgLyB3cml0ZQ0K
PiA+ID4gb3BlcmF0aW9ucy4NCj4gPg0KPiA+IE15IG1lbW9yeSBpcyBkaW0sIGJ1dCBpIHRob3Vn
aHQgd2UgZGVjaWRlZCB0aGF0IHNpbmNlIHRoZSBhbGdvcml0aG0gdG8NCj4gPiBwcm9ncmFtIHRo
ZXNlIG1vZHVsZXMgaXMgZGVmaW5lZCBpbiB0aGUgc3RhbmRhcmQsIGFsbCB3ZSBuZWVkIHRvIGRv
IGlzDQo+ID4gcGFzcyB0aGUgZmlybXdhcmUgYmxvYiwgYW5kIGhhdmUgYW4gaW4ga2VybmVsIGlt
cGxlbWVudGF0aW9uIG9mIHRoZQ0KPiA+IGFsZ29yaXRobS4gVGhlcmUgaXMgbm8gbmVlZCB0byBo
YXZlIGFuIGFyYml0cmFyeSB3cml0ZSBibG9iIHRvIG1vZHVsZSwNCj4gPiB3aGljaCBtaWdodCwg
b3IgbWlnaHQgbm90IGJlIGFidXNlZCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gTy5LLCBiYWNrIGFm
dGVyIHJlYWRpbmcgbW9yZSBvZiB0aGUgcGF0Y2hlcy4NCj4gDQo+IElmIGknbSB1bmRlcnN0YW5k
aW5nIHRoZSBjb2RlIGNvcnJlY3RseSwgdGhpcyBpcyBuZXZlciBleHBvc2VkIHRvIHVzZXJzcGFj
ZT8gSXRzDQo+IHB1cmVseSBhbiBpbiBrZXJuZWwgQVBJPyBJdCB3b3VsZCBiZSBnb29kIHRvIG1h
a2UgdGhhdCBjbGVhciBpbiB0aGUgY29tbWl0DQo+IG1lc3NhZ2UsIGFuZCBkb2N1bWVudCB0aGF0
IGluIHRoZSBldGh0b29sIG9wcyBzdHJ1Y3R1cmUuDQo+IA0KPiBUaGFua3MNCj4gICAgICAgQW5k
cmV3DQoNCkhpIEFuZHJldywNCg0KWWVzLCB0aGF0IGlzIGNvcnJlY3QuDQpXaWxsIGFkZCBhIGNs
YXJpZmljYXRpb24uDQoNClRoYW5rcy4NCg==

