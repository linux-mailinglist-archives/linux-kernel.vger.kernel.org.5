Return-Path: <linux-kernel+bounces-12419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1185981F47D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BBDB214A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FB1872;
	Thu, 28 Dec 2023 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V98/TIGp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8215A8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1703735622; x=1735271622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qrUmE4+eq6IikHbU5B1QMnRfahN1DrCztyK8q02oqeQ=;
  b=V98/TIGpdci4HoZVjiAXsY3fvqhl7HnedMWaHSnhc5YMijrEBcX4X1FO
   i+CYsbCU2Nl86FHgu9IfHcRnSF3ufaNXJzMuvecvutIGJ4AIJu3L9lv+J
   K1CumWZ0KXcxSQ4s3YEpzAaJv4o2eYPFNQ6RXvCcq3URfJARqjPS8w2wb
   hEpnkYbN3/YrEMi2A/DK2mjDXbbLqJoJjaUeTv1oOc8YDaZZq7XnBfST2
   aBHgngmNVeYSzfArUkN/YI11BMNZTQv44U3F+r3y8cU5o8k5/EALts304
   bmYJc+hiI41GBloe6j5np6eOFqmkrRqvfxsxUQxlIegCcY/zGXdCJyKJk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="110710307"
X-IronPort-AV: E=Sophos;i="6.04,310,1695654000"; 
   d="scan'208";a="110710307"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 12:52:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrJIMyMptbvv/p/59hiI+V7Qa6x2DxFOsbOOuPUCYHurATlHd/4BhwrfaVVwZ9C13MxFkGNs9+yO46Ed/ALrlmrBEBmbvWsiT0ZH9cAadK4vzC3EeAXdjplCMka2fbBTw/qVVgrABvW+CcMEjRqbI8dez4490YmZX71lnJDI4AxTwErNaysCiaKX4WbsPZQMlN9fHqk/MoDfaXfhxPy7fd5xm06hUch/9eJmmGQeQiT8zLgkLjZU8Rb6szMYiilQhH0kKPG/JBu1PhWiEb06TMxktuVgqz8+Kb9A9GzygcKHaIO8+OODyqsqRE+Wfu0vZuT3T+xgPWbp8waixydlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrUmE4+eq6IikHbU5B1QMnRfahN1DrCztyK8q02oqeQ=;
 b=XdNrgSptoBqLZ9IwMRAoV9/R+jPOaO3UQ+RlDR1fJAruuxqHILHkgC9Jq/72ATUO7uJXTKe+kvXzr2cGcVEt3xNw4WOLVQlCAEHb/87zUxJHaz2zA0Z8hcM2NOc8TM6iYl8w7MqdqaqRb10B+9NOeon3npKYH+BR+aQ4VJ2pHyLJcbxlKUEyAR+Xw/nNZX3S/EkHH2BTre0TvcqZ4P4gChFQb72VBXy9HIjtw3j6wU2YZ01EyKASXwrwm7ZPl29nREaXBlPjj8Fhb/4CwsSNP/Xt+lm4H5s0CMTx+1/C5TncDM3ctyscyo3F1GUawBBVQDdpW93qpsBMT1Sd/4s/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYVPR01MB11364.jpnprd01.prod.outlook.com (2603:1096:400:36b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7; Thu, 28 Dec
 2023 03:52:25 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7159.006; Thu, 28 Dec 2023
 03:52:25 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "ying.huang@intel.com" <ying.huang@intel.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/vmstat: Move pgdemote_* to per-node stats
Thread-Topic: [PATCH v2] mm/vmstat: Move pgdemote_* to per-node stats
Thread-Index: AQHaDgPwJ0YA7nAgOEO3M1tQJmYEarC+Zn+A
Date: Thu, 28 Dec 2023 03:52:25 +0000
Message-ID: <7cab217a-8543-4ede-aa67-4cc6900f5fb2@fujitsu.com>
References: <20231103031450.1456523-1-lizhijian@fujitsu.com>
In-Reply-To: <20231103031450.1456523-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYVPR01MB11364:EE_
x-ms-office365-filtering-correlation-id: 2d7ed81c-9363-4404-c728-08dc07586742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kptiLvPiSnB0WHrrmGHcRWts/NfKpIhxCEQbhOEjBihTFxWv1hPjg5zbW9nou66zckmaKz4H4DgVl9SDcoVwa1mrzliSgb5zWsbU925EAr1u9QxjRiOkbULtnYVRukPFxGW2mtKbbPDBAt+T8YM3Oo9xrj72676XR/WmVLAdv9ssxbnHl9RFlI5pVmHOsqt9Ci+6twHddS6WX/Dm9a6fNTJrB+BdrMDLJlXFNBTwxAJ2IN0BZOmSj25ZcxB8FmWwzDijqv3c4EjXcy4kJuW0fgFZ2EMsPhoa9xjhfMTnu1gH5WeabDYThaa7p9DvSfGhimmXpKBCkr+zI0HElJluhtyML8og+0wCcynmKExizOyg+uheDpb83ysjNtE4cx3hU85DoUcvWcVVOOL64bzcqtdZqnoVjr8m6kDnwhaVEt7gO8zmdjh2UYpKSfaOmdzrZOw01WGgn4iDIVifapekUuCMgOnGDisv8eAb+89+E+TG86dT4kVUDIi7vMmP7uGq0yAuT/zMhepcFQbMF5PlQehFOLB+yjgIpWBdOPLtfZPIzebENHeTl20rHyU1BoF8kv91E2l3HMNxuqWuja8bh0sJOh28iDJQUKjhTqTICBYplF5XkbcC8mNxGHChQDfoziWicnTqGg4rg+/wfbOLxYa3Rl8lBnKI+KH0GGNoVrfzabpu3ey0NMcAmsejO3uu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(1590799021)(186009)(1580799018)(66556008)(31696002)(86362001)(6512007)(478600001)(6506007)(53546011)(2906002)(966005)(71200400001)(26005)(2616005)(66446008)(64756008)(110136005)(66476007)(66946007)(76116006)(91956017)(8676002)(8936002)(54906003)(316002)(4326008)(5660300002)(6486002)(122000001)(41300700001)(82960400001)(38100700002)(83380400001)(36756003)(31686004)(85182001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlpHeFBZMkZsV20xOExjQlNTdFdtTWRRS0c1aGhoM2F1ZnBOYlFPa2VlNFJL?=
 =?utf-8?B?SGFMaUo5Y1dVSEZEUytRcG5mVW8vaiszYkJDdUVhRWJlOU5iUDhLMXAwK0ty?=
 =?utf-8?B?a1Y1dTc5U1k2M0pzWE1heER1TFVmcXZsZjI3Q2dRbXh4czlxRXZFeURtbFAy?=
 =?utf-8?B?bWJOU3kvR2htZUpsODQ1R09XcU5zaU5KRGw4YjVhSHpUbkQraFlMZGNFSjJJ?=
 =?utf-8?B?elNvbjNYM3kwRWppVENtOGp1TC9sbUR3MTV5Zk9iY2tpeFNYbUlybTNmRWhu?=
 =?utf-8?B?TjdRNGhnZ2ZBTEYrLy85OVhEbnJpd1dUMUM1bEJJTXpXN25uM0JTSE54M2xG?=
 =?utf-8?B?cU1kN2dwcURLdWJUQzdjN0ZrQTFvaHVrRjhtcVcyVVN2akFyQ1BSM0FqMlZa?=
 =?utf-8?B?dEE0K3J5YStLQWNrR0tsMHVnVVdRVU9rOWlPNytiWHFEejhhRTFibGZtMVRW?=
 =?utf-8?B?NmN3cXQrN2NTUko3ZVRtVDhmRkVJZ3h0U3YrWS9uUnlSSnIrMFVJNHRkVit0?=
 =?utf-8?B?bXhzOSttUy8vbGJrOU9tRGU3cDNtaWwwOXJuUFMxR00rSzBwd05LK21seTJ1?=
 =?utf-8?B?QTJTeTF2Y3NJUXZDZDQ2alhKaXNQY0JIdFdkZTdkenEydm5DMjFGUTdFU0gr?=
 =?utf-8?B?VWZ6a2J4a1B6azNpNzdWblBwNGorYks0bUZTME44U3c5b3IvNjBmVVBKRUZO?=
 =?utf-8?B?M2lCVUJWTi9XbmRwOC9PeFlZNFd6enNTVHpIOWYwZDdNQ1hnUDI5ZXlOb3Ir?=
 =?utf-8?B?MGlPRlhTdEVmc3pqZXVRZWlkWkZaL0l4cmNOUWp5VlFyWnBRei84NmcvTmdj?=
 =?utf-8?B?cTF4M1hYWVVTOG9DNzlOUUpYUnZQNk91OFIyWFYxRGZFOTN0Y0xhWm5Zc2xr?=
 =?utf-8?B?empaUUpKYjRicUhFaHJEbjlKSkNGMjFiQnFKQWNXd1pIRWdpN0p6NTFGRUJk?=
 =?utf-8?B?bHNQZVdhWjBXM1hrU1JYbDFNOFNoZnhpeC9OSHNRdGY1Z1MrNU0wNUo1Ulp1?=
 =?utf-8?B?THhwc3hQbVdnbnpMbkhicTUySU1wY0pnb3h6eTZHeHdRaStOM2gybUtjekRM?=
 =?utf-8?B?ZklHUzZaYlpMRnVJWVdKRVh3cmIxOHNRZ0gwcHN6NGhra0JIem52czZESXRP?=
 =?utf-8?B?SlNqZDh0QmV4ZGI0ZmJGVS9tRDhQQkkydDFZM0hqeXViV2NjMktxZ3dDVFo0?=
 =?utf-8?B?TklHNnV6WGVUUDBCNTFiQ21EVVF3bnNnZUdoNGxnZjFMUGo0cWRXN1hsTXp4?=
 =?utf-8?B?RzFTZ09YYWhja1JzY0czUCtqSm9DSTlCUmlkTWRoSXJYY1grZk52NGVOeURa?=
 =?utf-8?B?cHZCNHF5dUc0WHBjRmJtLy8xZzNoVytMdUV4Qk5PRURLQ2doUFBDLzE0SjRF?=
 =?utf-8?B?UkdkSHAza0dQRE5XOHhuOUg2YkpnTTBmaXdFSG90UStSU1ZjMjYyQTBwcSs4?=
 =?utf-8?B?Mythc0UyUlV1SDRMN1RlUnpNNWQ4WWoyQ0pOOTJhc2tGSDZnUmx2WXVWVit5?=
 =?utf-8?B?RkN2bjVicnc4Zk1BbkMwRWhDbnFOaTlpeXpMeTBzZFgyeGFXRVBlQUk5YVZM?=
 =?utf-8?B?SXRoZmJwT21tQnUwd2U4QmxPbGVSUzh5OGUxRysyS2JKdEhvWE9MZ202bUp5?=
 =?utf-8?B?OVVXN1hxRXNYSWFHVEVlRFUrQ0EyQ0o2ZkErSWtLL0ttVEJFbktCUTBkbWdu?=
 =?utf-8?B?U3l1L1g3UWVIUjNDVG1rWjVxdHhReTNla05zZTN5ZEZ1V2VlUWhEYmQ2TkFR?=
 =?utf-8?B?eTJxSFpLdGFUc1B3cXJITEY0THpOUXFhaDVFL3dwa1c4M05YTFc5RU00VHp4?=
 =?utf-8?B?SGJPL3hZd1YyUUVEeEp2MnM5Q2RYSXp0WkYraXY2bkJlSVVPckRwVmdjUWpT?=
 =?utf-8?B?NHM0YVUwSllsU2diWW1qSUZ6MGQrU2VpS0JnZDRteDYrN0tqaHBlaUFKQlNZ?=
 =?utf-8?B?SkloN3BwZkNZUGFySURkRmlWU3dvbmNGa2xHTlJnMGp5V0Q3ZWFBV3Q0WHJ1?=
 =?utf-8?B?MVlDYXhaSHlhRk9SRE1CcGhyRTNYNzlpYllnSWF1L2oxdjFmdHVMUkxQbnU5?=
 =?utf-8?B?MWRvTEZBcWg1ZXJhYzZ2bG42b3ZPQit1ajBiNjFhMGRGWUtMdGwzMERnWCsy?=
 =?utf-8?B?UkZOQ1FKZldLODlaYXBYbFpDZkRDZmN0dzFjVjFHWkxITjROYkJZaS9RSWho?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8445F5BB74C9684DABE68BE6B69CD84E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	viDjO4YG/lmaKNnXGyUd4O6Xum3rkoZ/9NT/OA9duMXerjyfp9a34IkY/Y/SQM2tgsKCjBC3Ba4F1D264a1z/GqPb4pXEtFvz2uz/wB/7pgNWhTHNYXodySuSvZzsLiqsJIQ7EFQM9x/yUzNMI39xNlkYqeg3rTOhLTPzEZ1oDQXHYtKH1MYcLrQxflA3nr2OKhtHpSfk8df+XxcKtGwMfzYNUgkdQbInmbfquuwVws+82hUle6VaAUfD4YXKcsd35KiWdfkzKcRGJmPZlydLnm/BNv/a5q/j3JEw1SEeP31+lPkqKoH1v/qJhlrgjM2PFK79aKgY/gKxlvwwmsuVJaN8oRbgtNvnvkSS4uTyVnthRmFFLImEOufsAMQ98uTvNHIuGY73ae0b36YSk3vyuQz3AAoxIEy3GpF4F1Y8Wck9WGJfw2Qpv0K3O5252np4xvnK1crh/fCoL/+qDLGjZs7iw4NEBEeYLP547r1cSUXg7ZEWy3GiMUWxMt1RXC0SWFbdCL1s8bfbN1U1RSF1VWBk/nAr+lIoYhO5isJJLpTcYUfpOS6yELKz4VyNvLOGpdaBUf4cCKYxBSQP0klpyvJDXGZu4okkYSpKh8+++FC0bFq8H7G6RZcBfoK65Vl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7ed81c-9363-4404-c728-08dc07586742
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 03:52:25.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHZ7DaEwaZSNvSPBMF/ZRu1TZzmivlhqqzBBBYy3XQqvuiunKKjjjrw6/oeeHkOXLAJnBeVGcBZAm5NYZakjXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11364

QW5kcmV3LA0KDQoNCg0KT24gMDMvMTEvMjAyMyAxMToxNCwgTGkgWmhpamlhbiB3cm90ZToNCj4g
RGVtb3Rpb24gd2lsbCBtaWdyYXRlIHBhZ2VzIGFjcm9zcyBub2Rlcy4gUHJldmlvdXNseSwgb25s
eSB0aGUgZ2xvYmFsDQo+IGRlbW90aW9uIHN0YXRpc3RpY3Mgd2VyZSBhY2NvdW50ZWQgZm9yLiBD
aGFuZ2VkIHRoZW0gdG8gcGVyLW5vZGUNCj4gc3RhdGlzdGljcywgbWFraW5nIGl0IGVhc2llciB0
byBvYnNlcnZlIHdoZXJlIGRlbW90aW9uIG9jY3VycyBvbiBlYWNoDQo+IG5vZGUuDQo+IA0KPiBU
aGlzIHdpbGwgaGVscCB0byBpZGVudGlmeSB3aGljaCBub2RlcyBhcmUgdW5kZXIgcHJlc3N1cmUu
DQo+IA0KPiBUaGlzIHBhdGNoIGFsc28gbWFrZSBwZ2RlbW90ZV8qIGJlaGluZCBDT05GSUdfTlVN
QV9CQUxBTkNJTkcsIHNpbmNlDQo+IGRlbW90aW9uIGlzIG5vdCBhdmFpbGFibGUgZm9yICFDT05G
SUdfTlVNQV9CQUxBTkNJTkcNCg0KSSBqdXN0IHJlYWxpemVkIHRoYXQgbW92aW5nIHBnZGVtb3Rl
XyogYmVoaW5kIENPTkZJR19OVU1BX0JBTEFOQ0lORyB3YXMgd3JvbmcuDQpEZW1vdGlvbiB3b3Jr
cyB3ZWxsIHdpdGhvdXQgQ09ORklHX05VTUFfQkFMQU5DSU5HLg0KDQpTaW5jZSB0aGlzIHBhdGNo
IHdhcyBhbHJlYWR5IGluIHRoZSBtbS1zdGFibGUgYnJhbmNoLCBpcyBpdCBwb3NzaWJsZSB0bw0K
cmVwbGFjZSB0aGlzIHBhdGNoIGZyb20gbW0tc3RhYmxlIG9yIHBvc3QgYSBmaXh1cCBmb3IgdGhp
cw0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4gDQo+IFdpdGggdGhpcyBwYXRjaCwgaGVyZSBp
cyBhIHNhbXBsZSB3aGVyZSBub2RlMCBub2RlMSBhcmUgRFJBTSwNCj4gbm9kZTMgaXMgUE1FTToN
Cj4gR2xvYmFsIHN0YXRzOg0KPiAkIGdyZXAgZGVtb3RlIC9wcm9jL3Ztc3RhdA0KPiBwZ2RlbW90
ZV9rc3dhcGQgMjU0Mjg4DQo+IHBnZGVtb3RlX2RpcmVjdCAxMTM0OTcNCj4gcGdkZW1vdGVfa2h1
Z2VwYWdlZCAwDQo+IA0KPiBQZXItbm9kZSBzdGF0czoNCj4gJCBncmVwIGRlbW90ZSAvc3lzL2Rl
dmljZXMvc3lzdGVtL25vZGUvbm9kZTAvdm1zdGF0ICMgZGVtb3Rpb24gc291cmNlDQo+IHBnZGVt
b3RlX2tzd2FwZCA2ODQ1NA0KPiBwZ2RlbW90ZV9kaXJlY3QgODM0MzENCj4gcGdkZW1vdGVfa2h1
Z2VwYWdlZCAwDQo+ICQgZ3JlcCBkZW1vdGUgL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUx
L3Ztc3RhdCAjIGRlbW90aW9uIHNvdXJjZQ0KPiBwZ2RlbW90ZV9rc3dhcGQgMTg1ODM0DQo+IHBn
ZGVtb3RlX2RpcmVjdCAzMDA2Ng0KPiBwZ2RlbW90ZV9raHVnZXBhZ2VkIDANCj4gJCBncmVwIGRl
bW90ZSAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTMvdm1zdGF0ICMgZGVtb3Rpb24gdGFy
Z2V0DQo+IHBnZGVtb3RlX2tzd2FwZCAwDQo+IHBnZGVtb3RlX2RpcmVjdCAwDQo+IHBnZGVtb3Rl
X2todWdlcGFnZWQgMA0KPiANCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPiAjIGNvbXBsaW5nIGVycm9ycw0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzExMDMwMTM3LlZ1MmtpNnptLWxrcEBpbnRlbC5jb20v
DQo+IEFja2VkLWJ5OiAiSHVhbmcsIFlpbmciIDx5aW5nLmh1YW5nQGludGVsLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiANCj4gLS0t
DQo+IFYyOiBzcGxpdCBpdCBhcyBhIHNlcGFyYXRlIHBhdGNoIGZyb20gcHJldmlvdXMgcGF0Y2gg
c2V0Lg0KPiAgICAgIGFjY291bnQgdGhlbSB0byB0aGUgc291cmNlIG5vZGUgaW5zdGVhZCBkZXN0
aW5hdGlvbiBhbmQgYWRkIEFja2VkLWJ5ICMgSHVhbmcsIFlpbmcNCj4gLS0tDQo+ICAgaW5jbHVk
ZS9saW51eC9tbXpvbmUuaCAgICAgICAgfCAgNCArKysrDQo+ICAgaW5jbHVkZS9saW51eC92bV9l
dmVudF9pdGVtLmggfCAgMyAtLS0NCj4gICBtbS92bXNjYW4uYyAgICAgICAgICAgICAgICAgICB8
IDEyICsrKysrKysrLS0tLQ0KPiAgIG1tL3Ztc3RhdC5jICAgICAgICAgICAgICAgICAgIHwgIDYg
KysrLS0tDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tem9uZS5oIGIvaW5jbHVk
ZS9saW51eC9tbXpvbmUuaA0KPiBpbmRleCA0MTA2ZmJjNWI0YjMuLmFkMDMwOWVlYTg1MCAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tbXpvbmUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4
L21tem9uZS5oDQo+IEBAIC0yMDYsNiArMjA2LDEwIEBAIGVudW0gbm9kZV9zdGF0X2l0ZW0gew0K
PiAgICNpZmRlZiBDT05GSUdfTlVNQV9CQUxBTkNJTkcNCj4gICAJUEdQUk9NT1RFX1NVQ0NFU1Ms
CS8qIHByb21vdGUgc3VjY2Vzc2Z1bGx5ICovDQo+ICAgCVBHUFJPTU9URV9DQU5ESURBVEUsCS8q
IGNhbmRpZGF0ZSBwYWdlcyB0byBwcm9tb3RlICovDQo+ICsJLyogUEdERU1PVEVfKjogcGFnZXMg
ZGVtb3RlZCAqLw0KPiArCVBHREVNT1RFX0tTV0FQRCwNCj4gKwlQR0RFTU9URV9ESVJFQ1QsDQo+
ICsJUEdERU1PVEVfS0hVR0VQQUdFRCwNCj4gICAjZW5kaWYNCj4gICAJTlJfVk1fTk9ERV9TVEFU
X0lURU1TDQo+ICAgfTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRl
bS5oIGIvaW5jbHVkZS9saW51eC92bV9ldmVudF9pdGVtLmgNCj4gaW5kZXggOGFiZmExMjQwMDQw
Li5kMWI4NDc1MDJmMDkgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRl
bS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRlbS5oDQo+IEBAIC00MSw5ICs0
MSw2IEBAIGVudW0gdm1fZXZlbnRfaXRlbSB7IFBHUEdJTiwgUEdQR09VVCwgUFNXUElOLCBQU1dQ
T1VULA0KPiAgIAkJUEdTVEVBTF9LU1dBUEQsDQo+ICAgCQlQR1NURUFMX0RJUkVDVCwNCj4gICAJ
CVBHU1RFQUxfS0hVR0VQQUdFRCwNCj4gLQkJUEdERU1PVEVfS1NXQVBELA0KPiAtCQlQR0RFTU9U
RV9ESVJFQ1QsDQo+IC0JCVBHREVNT1RFX0tIVUdFUEFHRUQsDQo+ICAgCQlQR1NDQU5fS1NXQVBE
LA0KPiAgIAkJUEdTQ0FOX0RJUkVDVCwNCj4gICAJCVBHU0NBTl9LSFVHRVBBR0VELA0KPiBkaWZm
IC0tZ2l0IGEvbW0vdm1zY2FuLmMgYi9tbS92bXNjYW4uYw0KPiBpbmRleCA2ZjEzMzk0YjExMmUu
LmNjNzBkY2VmYzYwYSAxMDA2NDQNCj4gLS0tIGEvbW0vdm1zY2FuLmMNCj4gKysrIGIvbW0vdm1z
Y2FuLmMNCj4gQEAgLTExMTAsMTIgKzExMTAsMTQgQEAgdm9pZCBkcm9wX3NsYWIodm9pZCkNCj4g
ICANCj4gICBzdGF0aWMgaW50IHJlY2xhaW1lcl9vZmZzZXQodm9pZCkNCj4gICB7DQo+ICsjaWZk
ZWYgQ09ORklHX05VTUFfQkFMQU5DSU5HDQo+ICAgCUJVSUxEX0JVR19PTihQR1NURUFMX0RJUkVD
VCAtIFBHU1RFQUxfS1NXQVBEICE9DQo+ICAgCQkJUEdERU1PVEVfRElSRUNUIC0gUEdERU1PVEVf
S1NXQVBEKTsNCj4gLQlCVUlMRF9CVUdfT04oUEdTVEVBTF9ESVJFQ1QgLSBQR1NURUFMX0tTV0FQ
RCAhPQ0KPiAtCQkJUEdTQ0FOX0RJUkVDVCAtIFBHU0NBTl9LU1dBUEQpOw0KPiAgIAlCVUlMRF9C
VUdfT04oUEdTVEVBTF9LSFVHRVBBR0VEIC0gUEdTVEVBTF9LU1dBUEQgIT0NCj4gICAJCQlQR0RF
TU9URV9LSFVHRVBBR0VEIC0gUEdERU1PVEVfS1NXQVBEKTsNCj4gKyNlbmRpZg0KPiArCUJVSUxE
X0JVR19PTihQR1NURUFMX0RJUkVDVCAtIFBHU1RFQUxfS1NXQVBEICE9DQo+ICsJCQlQR1NDQU5f
RElSRUNUIC0gUEdTQ0FOX0tTV0FQRCk7DQo+ICAgCUJVSUxEX0JVR19PTihQR1NURUFMX0tIVUdF
UEFHRUQgLSBQR1NURUFMX0tTV0FQRCAhPQ0KPiAgIAkJCVBHU0NBTl9LSFVHRVBBR0VEIC0gUEdT
Q0FOX0tTV0FQRCk7DQo+ICAgDQo+IEBAIC0xNjc3LDggKzE2NzksMTAgQEAgc3RhdGljIHVuc2ln
bmVkIGludCBkZW1vdGVfZm9saW9fbGlzdChzdHJ1Y3QgbGlzdF9oZWFkICpkZW1vdGVfZm9saW9z
LA0KPiAgIAltaWdyYXRlX3BhZ2VzKGRlbW90ZV9mb2xpb3MsIGFsbG9jX2RlbW90ZV9mb2xpbywg
TlVMTCwNCj4gICAJCSAgICAgICh1bnNpZ25lZCBsb25nKSZtdGMsIE1JR1JBVEVfQVNZTkMsIE1S
X0RFTU9USU9OLA0KPiAgIAkJICAgICAgJm5yX3N1Y2NlZWRlZCk7DQo+IC0NCj4gLQlfX2NvdW50
X3ZtX2V2ZW50cyhQR0RFTU9URV9LU1dBUEQgKyByZWNsYWltZXJfb2Zmc2V0KCksIG5yX3N1Y2Nl
ZWRlZCk7DQo+ICsjaWZkZWYgQ09ORklHX05VTUFfQkFMQU5DSU5HDQo+ICsJbW9kX25vZGVfcGFn
ZV9zdGF0ZShwZ2RhdCwgUEdERU1PVEVfS1NXQVBEICsgcmVjbGFpbWVyX29mZnNldCgpLA0KPiAr
CQkJICAgIG5yX3N1Y2NlZWRlZCk7DQo+ICsjZW5kaWYNCj4gICANCj4gICAJcmV0dXJuIG5yX3N1
Y2NlZWRlZDsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9tbS92bXN0YXQuYyBiL21tL3Ztc3RhdC5j
DQo+IGluZGV4IDAwZTgxZTk5YzZlZS4uZjE0MWM0OGMzOWU0IDEwMDY0NA0KPiAtLS0gYS9tbS92
bXN0YXQuYw0KPiArKysgYi9tbS92bXN0YXQuYw0KPiBAQCAtMTI0NCw2ICsxMjQ0LDkgQEAgY29u
c3QgY2hhciAqIGNvbnN0IHZtc3RhdF90ZXh0W10gPSB7DQo+ICAgI2lmZGVmIENPTkZJR19OVU1B
X0JBTEFOQ0lORw0KPiAgIAkicGdwcm9tb3RlX3N1Y2Nlc3MiLA0KPiAgIAkicGdwcm9tb3RlX2Nh
bmRpZGF0ZSIsDQo+ICsJInBnZGVtb3RlX2tzd2FwZCIsDQo+ICsJInBnZGVtb3RlX2RpcmVjdCIs
DQo+ICsJInBnZGVtb3RlX2todWdlcGFnZWQiLA0KPiAgICNlbmRpZg0KPiAgIA0KPiAgIAkvKiBl
bnVtIHdyaXRlYmFja19zdGF0X2l0ZW0gY291bnRlcnMgKi8NCj4gQEAgLTEyNzUsOSArMTI3OCw2
IEBAIGNvbnN0IGNoYXIgKiBjb25zdCB2bXN0YXRfdGV4dFtdID0gew0KPiAgIAkicGdzdGVhbF9r
c3dhcGQiLA0KPiAgIAkicGdzdGVhbF9kaXJlY3QiLA0KPiAgIAkicGdzdGVhbF9raHVnZXBhZ2Vk
IiwNCj4gLQkicGdkZW1vdGVfa3N3YXBkIiwNCj4gLQkicGdkZW1vdGVfZGlyZWN0IiwNCj4gLQki
cGdkZW1vdGVfa2h1Z2VwYWdlZCIsDQo+ICAgCSJwZ3NjYW5fa3N3YXBkIiwNCj4gICAJInBnc2Nh
bl9kaXJlY3QiLA0KPiAgIAkicGdzY2FuX2todWdlcGFnZWQiLA==

