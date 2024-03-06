Return-Path: <linux-kernel+bounces-93480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAD87305B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DCA1C21D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B05D75C;
	Wed,  6 Mar 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XL2EssBj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918015D74F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712695; cv=fail; b=a36eEjYsGnW5RTovuhesqco3XPSyLPO8VfalRWV5GCaK33xKjxQf4DF9IXf/vSEHa7kbSSIwnr//IO8y5j4rFgDLGr4jEtnJXFabYfjHQqW8UZLxW+x8CdJtq38fEWHLgJTU06vRRQD2BNvZwKINZSlWIUiBW5hReznMZ031Els=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712695; c=relaxed/simple;
	bh=d75YCmmTmnn4mnmLMVynrOkz0w5TUhEFhzIgxf4Yz+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uGtAhZONUe4t02CVTUasykRj2C3rPTvAtnOKbu1Y+BP4mFmmJfjXZCHA0IgDXOEkwDUZYgLVwh/tTF5pM5YRc9CgBXqZWwwx7B1ExsD0y+h+vVBHxSGKfEmeDJAyJgNkdKkpX6I1fuNL0FhYOopJjqf0qdiHb/gw2/bMpAKnTLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XL2EssBj; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awHxlSonLJYJr8Q3J4VghpeMtsJUI/Wi+3Ksj3vkA4aBsA1Z6LZ775OohW2Yb1re1VTJZk6betZ7DxFYrWnppbP0ahXHH2svs9Vky1Jyepq88LEW3reD4RQTfK8eCRoNHTX+FfgzRQzatLllbUIyClnAOT1CG78paToO/FY74Vs1q83HgO9ZsZIvXw0j6IXiTlP0c21Pkb8qxAB8hO+kdRG9zIAO4Ll4zC5bsN6uVTsmhEiDm+n5867ZuL1eHuCP9qRetqrCcjYWxL77izsp9FoqtO9jJUnwuBwSlO5weQXjpXQum6QAL2nDl2IB0H72TU2G5j1Q10tIAklDeYWEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d75YCmmTmnn4mnmLMVynrOkz0w5TUhEFhzIgxf4Yz+w=;
 b=KKkAQhVSBVRrebfxNV4ZntUAlwg+aizbsUup4L64KvyqXUmNe1a+OoxY7YpkUVgq216SqbkhGM8BWCAEklU741eqlK92HCJ7u+sSy7FX9upS7c9+9PXZo2/dhC/uRovFYbvltJNTRThT6o01kBinqmFNwshGmk4jUf90TwB6Qe0jrKFX2sbpaQ08K3SJKSpkjzwSrZ0tCsqP8Ab/FBi2aO8IeT9FutkmEeoFbs8LYzPqKYtRHPWlldoBh4diIPTRJQMtvECl0UZ7cQaJoGt9wi6MDDbalZwPnJIr8EYEPJf0C+CwO7i2LOnbweT7SSpWYlZ9HloBiOxEgVH2KgnfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d75YCmmTmnn4mnmLMVynrOkz0w5TUhEFhzIgxf4Yz+w=;
 b=XL2EssBjvDURJJddxn9mWCWeL27s077zs9KA25/HpN0KcuAmnC3az4qsB+fQUThx0KBDH2BMMoSAgom2nhZTOVQYlBbjEN98B+tYY9w/RkkkPkXkAzFhXGJhhZN6I620I3R5ptccJY8OJNZkM+AMc2JkMFWPOJ3xSMoOj2qD6OiiQnnnVFoWr1mMgbjM0XVmY2vE488N61oTATpl70jwvjC0XOtTHBazxjWF5pPF/PPV9sOl6874mRgzVwO086+rMBT1ydwrJMgcYsU0voEbeBaT+45fDgbmyzNJTwsPS7LS1QXD1noC0QyHRqzID2GNuxBY+SUitP0A52+WeKgZsQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 08:11:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 08:11:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] nvme-rdma: short-circuit reconnect retries
Thread-Topic: [PATCH v3 2/2] nvme-rdma: short-circuit reconnect retries
Thread-Index: AQHabtM+X+xWHxukWkSqizxpZgICXLEqXiMA
Date: Wed, 6 Mar 2024 08:11:30 +0000
Message-ID: <fdac5ec0-a2e6-4485-9b1e-af0d34e85e9d@nvidia.com>
References: <20240305080005.3638-1-dwagner@suse.de>
 <20240305080005.3638-3-dwagner@suse.de>
In-Reply-To: <20240305080005.3638-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7128:EE_
x-ms-office365-filtering-correlation-id: e3610019-aed2-46f6-90b1-08dc3db507d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vOsFCdyGCV6vpFUdoHfHaUsrfbYFDUyDUyl27XVhECZBCqEwi+7OGGB0XuKDCDsjgi5LDW4HWD7U9b7n00QiIUPy2zWD6iIRf+OJpMrwaAah3fEyW+Obb03zq2CoQFCXI6t5qEuvb+O27+03PvCEPIMWVE/1A81ZtdkDKnMbmKva1rzHul8RvkO2k1gvwmBzl1VumNCciHQdqq3LTDIJ+CLF5qzgJkWlWPHGhS/9LURptvIoZeZNAJxQom8P7h2z9e26K9eELE9HUhrvGih/lRQQHMBuZ1/2QOjWRYLeVJt0sAFkzbglukKX3YhTIb82lAF9VSyZm8U2JCsrQ4iP5H92n1ZLB9jw56v2OhCTUar8dOHxQielDN1rwwv3ik01tyaVWDDLt7nxEH7mOiDoSMZejzx3yNkIbF7sVTuhbCi7E60TcuFHul9DENtMtImvH71gHOBjx4p+77OR4KwOKWUjPpr7i0FwltiuLmx5OWHzDdpGwfv7fRS41w+bR/Xp8/knssrllE3c1cKL0maM+PoPTy77Q3db5zkQGGJP1KBLupZI964UFUFmmDoJwGLuHxIqao9+zn0BLqmI99iGbX9uGsgf0s8x7LZ3dHTL+7B2gQWQPKvDoqPci+gBPL6taFN9JkmA2SD2QV1+QKdiAiiX8bpfGOtmBgbbnl34e7lehWISaOp6cepn0Y9dcNwFAWLZAencUbGhO2+R0lkiL9W3fo5usegN15/DmnwZU7M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjJKUkhiZTNhRFdtUFloSzJ2MHczYi9uOXpGb2Fvb0E0d3FhSWVsL09nVGhU?=
 =?utf-8?B?aEEzYkNhUmtZS0dwMXFaUUNJT0w3QTQ1V3VzOVZTZjJ2Y0ZQcVYyVGtZcnhQ?=
 =?utf-8?B?L2FUSkpWQjdlQk4rc0haVm9yREdnWUVlOTNreW0rMDJxcVZMVHVob2xGOWdG?=
 =?utf-8?B?VXg5c0dUc3BRd0hXVWliZHRnSXNqSnFNYTI4U2MwYVpZbEpYancxNnI4ZzhQ?=
 =?utf-8?B?d0w2VGNVdjBNcDlueVBWbFdweW5YZXQxUmRtZG9GcmVFMzBlQmVGRFluSmdq?=
 =?utf-8?B?c2huODdJb0ZvSzhTUGxUcWtIYmhwY0dKdTF6Z01SckpNZjRuT1J1OGJlYVJE?=
 =?utf-8?B?ZXNEbGtpeFJ6QXJWaTI4SzY2ZEFLYmppb0VZNEFRQWltOXBrMldIeEtDc3Bv?=
 =?utf-8?B?RWU5TjBML3ZYaHBxM2s2cE52R0lKS0NFaUYvbm52R2VwYUUxbEpVY1BJQUFO?=
 =?utf-8?B?K0k3akFRL1huOUZRSGN2TWhUWG9FTGRzeUFlU3l0bUVuUytPUG82TmpJSDZh?=
 =?utf-8?B?bDdDWGQrWm9IeHBERWxONXYxcGhHcVNpRE9Wd0pHOElLL0wzdFQvNEQ1RTE3?=
 =?utf-8?B?dDduVXFYTWRZdVYvekcwQzg2aUZqbk9uWVBUbG9GaTNuR0kvaGNYQ2tQZHVO?=
 =?utf-8?B?TDIrd3J0ZTk5cmtVWVJGNEsxMXJuR0N3WkptWEZBNGZ5UXIzaUw0d295azJy?=
 =?utf-8?B?QzdEOXg5b3VjT1hmem55VWlzTnhnYjBtOEFiQmxhUTJaZWdqTVpSL1RJTnN5?=
 =?utf-8?B?OU80OGtxdEhKbFNqa0F3T3hFMytGQmt4aDZqL2M1THhNaXdBMHJFMzlXZjdB?=
 =?utf-8?B?TndYamd3dnNFNE1sekVJdzRyYkFYU3hXVUo0dEFVSWUyMjdXangyWDViSlVt?=
 =?utf-8?B?V3VuN3NhYm5kUllRbEZCeVdNcW5kdHBtSlYrTGpkNkphYkJ1RFFGUHBmU1la?=
 =?utf-8?B?QWFBSnEvOE01SHJ3aU1jVHdIRnB5UUhjNFRrZjhXN2VNNitSOWgxWEhSV0ly?=
 =?utf-8?B?aGdGZmxHdlpvZGVJUGk5VkxKNmowTkpsWUJBdlRwVk9zemRjZG5IL2dkZVFN?=
 =?utf-8?B?WjhwdVZoQkN0QWxXTHRNU2tSRHcxYVJyVElUeDR3U2Z5UEcyYTlUWXBTenhV?=
 =?utf-8?B?a0o4SnZ1TDluZG9QTDdvVGMraVdVS0ErK0JpVCtrbDdKTHNuaG93eEhET28x?=
 =?utf-8?B?czhVOHhYdm5laklyUG0zdUxjK1YrZTNYNUVXUGJJVGluY1RxVEp0Vkw4Y0ZB?=
 =?utf-8?B?d0FXcm10TmFpVVVKbFd0Z3dJV3NNMWhodUV0YWUvZWNVNm9BUnBrbTZmOCty?=
 =?utf-8?B?eWtuZzJ5eFliOEhmRWtCalJ2OU5QY2xObS9lZ3ZkMmVmbmltRzBPcUdzaTNh?=
 =?utf-8?B?S0t5NjkyUjZEejVZQ240aFpScFFIYWxWWE9Tam9jRVp3SVN4SUU3L2xvT1Ri?=
 =?utf-8?B?MVVRNHVVb2JaSXUyYzFhU1RyWHRJdkhaUUdOSldkYTVVN0tobkltTnNjYVVx?=
 =?utf-8?B?SitEUjhMTmk5Y1N5WGdYU3VBaW95QnRhNHIyajVqZVFHVnM2T3JTazJPbll1?=
 =?utf-8?B?ZDQwY3g3c0RNRENNOS93OWR3NiszSDAyNm9tZ1pEU1VRR0J5amFWNFY0eEM1?=
 =?utf-8?B?WVpDK2xCOC9rWDMzWk9Wd28vTklOVjY4WUI0aERaYjZQKzJERHJ0aUlVaE5K?=
 =?utf-8?B?LzkrNTNMS3pGWTZ1U0FiYUlLQ0JEUUtQd0N2N1ByeUJlcytBTnNRbFF3VU8w?=
 =?utf-8?B?dFowaDhTQzNReXVlcktVdG9ONHJVeHNGd2ExTmlXTlFJR3dCdHRQQ05vNllj?=
 =?utf-8?B?Z2cxNWgzS2ZnNUxqZ2pjZ09jUk1wNXNwYUFwUm9WNnhTZ0Zjbkhhc3lHUjJK?=
 =?utf-8?B?cjd5UlZPeW5nREdONWFJQ1Q1MzZITnh0NUtyazFGWmxHcW9sb0lESHBWa0hs?=
 =?utf-8?B?dDEreXhZTUJmOTZ2ZlVVbllvNW5HdG4rQVdEVWJQWWtKZ0plTzdSWDBOSmli?=
 =?utf-8?B?WXpNaldLa2wrRWpNalRsTzUvdTdDUm1kem5hc2pvVFNRSzk2ZTBsREtBQnVa?=
 =?utf-8?B?N0llaHNoYXViN2w5d1RUU0licXcySm51YURhVTdFNFpkVGp0VFRGWkNZS2Vh?=
 =?utf-8?B?QmpoWDkwNk5wc2dRVTBlNGVlOWN6WFdVWHIvaGlGQUhNM0lwV3UzU1F2K2sy?=
 =?utf-8?Q?imrlXCNtWSCJPNBmDEr+cDRwDmHx85G6Tcrn8ruFtfaw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B25DA1E9BDF0B499B27B928176B1758@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3610019-aed2-46f6-90b1-08dc3db507d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:11:30.9248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfQGMLTS5Nu8g8r8jIhc3W5YoxB4H6Cl0ZZdg9tsiSq84H30NWsnuIbvNCzb7CM9kJvc7WJ8QHA5PPU79unuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

T24gMy81LzI0IDAwOjAwLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBGcm9tOiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4NCj4NCj4gUmV0dXJuaW5nIGFuIG52bWUgc3RhdHVzIGZyb20g
bnZtZV9yZG1hX3NldHVwX2N0cmwoKSBpbmRpY2F0ZXMNCj4gdGhhdCB0aGUgYXNzb2NpYXRpb24g
d2FzIGVzdGFibGlzaGVkIGFuZCB3ZSBoYXZlIHJlY2VpdmVkIGEgc3RhdHVzDQo+IGZyb20gdGhl
IGNvbnRyb2xsZXI7IGNvbnNlcXVlbnRseSB3ZSBzaG91bGQgaG9ub3VyIHRoZSBETlIgYml0Lg0K
PiBJZiBub3QgYW55IGZ1dHVyZSByZWNvbm5lY3QgYXR0ZW1wdHMgd2lsbCBqdXN0IHJldHVybiB0
aGUgc2FtZSBlcnJvciwgc28NCj4gd2UgY2FuIHNob3J0LWNpcmN1aXQgdGhlIHJlY29ubmVjdCBh
dHRlbXB0cyBhbmQgZmFpbCB0aGUgY29ubmVjdGlvbg0KPiBkaXJlY3RseS4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6
IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gLS0tDQo+DQoNCnNhbWUgaGVyZSwg
ZG8gd2UgbmVlZCBhIHNhbWUgZml4IGZvciBGQyBhcyB3ZWxsID8ganVzdCBjdXJpb3VzIC4uLg0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K

