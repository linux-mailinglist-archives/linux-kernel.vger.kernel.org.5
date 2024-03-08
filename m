Return-Path: <linux-kernel+bounces-96388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E45875B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE2B22B1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE01E88D;
	Fri,  8 Mar 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWOz0KtZ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949211DDEA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857194; cv=fail; b=Yi+C83ROODlcQsV41ywdonQJ2zOcp0BlxAbflLsEsao9q52XvmgrvY3qB+O5Ha+4HP6VPPETweaAKiqvGhUxArkrkwrLVo/BBwaRy7S0Mk5/lFKpDT5gIbH5EVYHtiKFYDNqog0MweuWUVWleVW1hNe8X+ONOb2aQeiLmzuPrF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857194; c=relaxed/simple;
	bh=T6MjpMLRM6MwWRFav9K4L2sThYh3H9DFSK9oFQ3Ki1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UUbz7BKh6jCDRczUo/4YDHRy2RT+n/BQMlS1O/jTZGFQ4MWVmEqi8bXeJluhUh2HYHyH7rSf3B+BOSoah/6IsiDIdVDvxiHi9LQLxTefbU4/g/Xqbn6Y9Ik/YrOtgaqA1hDUQbuAlf64ZO6iY32f7T2chmR0y+HThW3ciK4oU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWOz0KtZ; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nee/saftt8o94OLqKSQgE1HLty6vEkRUdKzjmuW5ux3GdDvbDxscQTnZ2i/7fnBL0+bqhxngUCY4/AQwvpp+gZ8EW5gBOPrdjJa/oVXjgCOcTs2YuzIvaGdhAQqCa5ohoWmoKnNqvQo6wHWuJu6bSSPz5hqLDJcvp0WgTS0OHOauihlVot5gRpGewH5NjGx31lnlZdIb+vz7jrDX21SiaMDnVZjrL2YU6fk46lriIZI6JPaFdYfUXsYAo90VfwPj3BddC/34d5TkwvMrxxer16BK1dMTVlJRs8zzqmAzUyyCZTMmj/7/uCNjBqvxL4/97udKGH+cKa1mLFaf3gXVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6MjpMLRM6MwWRFav9K4L2sThYh3H9DFSK9oFQ3Ki1Q=;
 b=J17e6G00k3NReZJj9+30gqSeU89TfaLhmzBVWZ9WlJZic/6wgXq53zTXdQUQTX0jfu1GkV8aGw3qmn8oWMItMGCUXaGVQSxmekqPzmbE3zczx7PXvjV60Ecu7uiJNMii5wj5fsZBXhEJkDEA87EqLj0CQMJUGeqXpN6QDuDDwJHkCgm8omUHiCaomuVfox5xplvs8Ufi96sNNjPz0I0D9xpCXLlE1gvHOW7Z6QjyXU+Xg+WxYGZOqCO75u4UFidhwTg9ZruPh6ThF40T8e4Lmgq7GszgCvZNpceKsodsB4yciDFC1C80/7XXw1YKkrSEYSq9B6PbuArSA4ZmL/XTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6MjpMLRM6MwWRFav9K4L2sThYh3H9DFSK9oFQ3Ki1Q=;
 b=KWOz0KtZEVZwixt8qPTgqCYhtrqu/5oJ14hVUSjoW/7yayFSuzodJh2LJW+OFYlRlr7Nc5sSwcODkVV99o6Jxo0GXJyjAvzgVwd8FvhnhCu51U/q6Jx7x0DyAKjCEvFwRzuakZEsesRJ2/1DDMoOz9ZvJ01xff4tlppwVq6wDs9rI/nG+i+bO8IwxVae3AQn8p7l0V5DsH8NEa6exfL1DSlEvzzjEGFTD/OdVCJwEvUOtx7rPXCwuiBCajG1ZHqsHxUKkayv1heRLYLbBrZof3kVGycAh4XJqm6N9cgd4YghpKwI3v/z7035uu/DJ/AXcCV5UB81Xq3pG4JAx5vlZA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 00:19:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 00:19:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: brookxu.cn <brookxu.cn@gmail.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: fix reconnection fail due to reserved tag
 allocation
Thread-Topic: [PATCH v2] nvme: fix reconnection fail due to reserved tag
 allocation
Thread-Index: AQHacH+m6pRhTd4pC0OJQhd+KkMjTLEs+6iA
Date: Fri, 8 Mar 2024 00:19:47 +0000
Message-ID: <800a2a54-9156-482f-9bc7-e99eea7dad5a@nvidia.com>
References: <20240307110657.252120-1-brookxu.cn@gmail.com>
In-Reply-To: <20240307110657.252120-1-brookxu.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8971:EE_
x-ms-office365-filtering-correlation-id: 745eaf0b-a970-4ffd-dd38-08dc3f05766f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fGPfvSPu6ngfwQOBqz0dDAHqgEZwyicxrVYIfAdhZ0Q1ypo+VWELZ6W4B2QOfsOvdqo4N7i21L3GgrLs2nBee4Z+8lFSTW7sNvm7bK8Xtf77BQU7QgtHvrygXkzQfSWlW5745bYSvtVXHEDQ+Aq+1VCN3GeJ+Sk7BtuWnXdXYbZGQp+mBJg3o8PBbPaOxOFf3x8yLkVwyDMD7c7nQIxITOkFp4zAgW9xYIMbP3beUUF/CQHFWEjPbQVBVhdfO0ckvHsJMVjQLn+wPdGv789Xc4d/Vmn1mMwDOYsymo9nlUSWmZleRo7aOT4Xima3IKtrR+rCJcviXnOP+oexmXKjm3oenHN3+6txysY5pVAshUb2dPufi9CXIYH+KnKtEhb5BwEyxp3nPY1EMS5MX0wjaT7XmLe50Ve9eDfr2slLuQ4Z9MW/TSgYhN/MoDjjEnP0P3UhYTUuy0I+UdDDhtTVxC8I2N352ryNH64XsbV5G8+P3QsyAi6Axuzhm713wdNIgGlLv+qHrxjD+qziPs8eOlyQuhU+ZgJOPnixpq+4kv3UI7ZHSzzA47t97qiPupBAlU1Orsnxr6AcMMnh49aDRAZoLqrAFRukEzI5Z/KCuFwoGyUUTYgghHb/g32SCbTxtf9IHBOpkMtUjD5KCyYo8JIHfZ7F8PlNKT/d4l+DfjyanAQcUQCggkdwFwnRB/1Mjg+194Tv7YsLsHBPqS0naDv6yrvonYtu3Wm2w7WtyJo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTZ2WnNXRmJMWVhFa0x5OUpINTNhemlGQ2JaSDViQW5RNW1PV293c01weUY0?=
 =?utf-8?B?WkZtNXplWlFRcWpUbmtrbmhRL2RKanZUKy9tRHExZllndEQ2WDVQUmVQU2ly?=
 =?utf-8?B?UFVocjF6MytDUGZPM0ovQ0JYRDFpSFhYOFRKQWZyRFlqVUFubXp3aWthRVpJ?=
 =?utf-8?B?Zk1iOTdMNXZBUnpnR1JiMWdNVjh2cG04VjhGWFdGVTFZWGR5OUgvOW9aMHRS?=
 =?utf-8?B?dVpIVnJ3cEFWRElVLzB1TXkzcXVIWHlXMzNxaUJVNHpZMkVhL1lZTHZCb0th?=
 =?utf-8?B?SmJVRTdSdSsxMDRndjEzc1V3ak5TQVZnblY1S3RjeW9tdFFzbTRLNmVxQWFr?=
 =?utf-8?B?blErb1B1RW51c0FQZExQbGdlaC9EYlRHaERsdTN5TnF3andVSEJXV2dOZldq?=
 =?utf-8?B?WStqN2haYnQyd2dzVzh6eVAvakdFZE1qRHpaNzJjaWluV0ZWL2YxZFB2RG9Z?=
 =?utf-8?B?ZnNqeXJxZ09XK09BM0VpQ2F2YVU5VVpwVERnb1p3UWU2bXl2OG12cy8wLzIx?=
 =?utf-8?B?R3V3TGtTUnBkV3FXK0tsa3hkQ0pYN0RIQ29MZlNzNDhuUmVKUW1jTzhTL0Vz?=
 =?utf-8?B?M1N1YStXTzNiakxwWnVnd29LMG9pczIyL3phcUptZVo2aDE0U0pOdGZ1cTRi?=
 =?utf-8?B?ZjhpZVVIdG1ZUkhyV3NnQjhKc0R2dG1INVF6UXYrTDN5ZFV2OWdPQWtjbEpj?=
 =?utf-8?B?c0NaN2FrdUNZOGlkYSt4RHovMVFidWJONDlXTmRkQkZxUkJlMjBlSWovMHhy?=
 =?utf-8?B?a3FhK1ppS0RNaXAvVmpsQy82QXd0ODFGc1VZb0R0aVhGN1NldUlSQnhzT2dV?=
 =?utf-8?B?a1NLVDJjcy8zRFFJTDRwODB1Y29EOXNEV0ZkZ1FwaEtVVXhIR2E3YWt0Mmdx?=
 =?utf-8?B?dWVCZGJ1azN5Qkd4L3BCbU4xMXJqQjRrKzc1aHhhQUx0TCtvNDZ4WndxYTBj?=
 =?utf-8?B?N2MrMWdZUkM3d0hyV3ZYc2ppam9RUDlSeUZCcHcrbnEzTTFUcnBQdnhVdUx0?=
 =?utf-8?B?YW1GYkRNT2VoNWpuMjdTZlRjdUx2ZmpibDAyblQ3UkJMWjY1UVF5K2JBTmt1?=
 =?utf-8?B?MzYxOXhHdE8xVmRqTW5XN0RiVEpuVzJxVnBMRWZCelFFWjVuWC9XSUVpMjc4?=
 =?utf-8?B?R3JtRFpBSEU2ZHF3RDE1bmJhalJlWk42dy85K0tzbHRzOHd6WEplL3N6aFpy?=
 =?utf-8?B?L0oyWU1XdUZjay9SMUFkbU1DV2ZQQjVRaTN1M0h6alBWd1J4cDZuMHdCTXg0?=
 =?utf-8?B?VjRYTmVoWm9WNjlWdk5oSk9QZk9vNXVWYmxDUVlvUFBXWWlQZUFzNXZYUnk5?=
 =?utf-8?B?eVFyNVFTQWNuZkI1UDNBYis3cGkzanl1dGhoQnNFRStRN2JSSTFXbjBXV1dJ?=
 =?utf-8?B?VHpmbHJ0aHhyQ0lwdzBuS2dveXUwNUNyUUpnV1hiTTc3Y3ZkSkhEdEZ5b0dW?=
 =?utf-8?B?TCttMk81RE05N2t3WUV1QlNUME5tT2V1K1RjSkRvYTZRbnIrY1lJYys0RTZO?=
 =?utf-8?B?Q280OWcwdWJqaGdvVW1BMjFKcGo5RmI3a1hqb3R3U1BBZFBta3pKUm9vaklH?=
 =?utf-8?B?UEwzWTRWUnp0WmZ6dXZxV3Rhb2FPSkl1ZnlVWDhMSDN3UHpHcWVhaWVqZEt3?=
 =?utf-8?B?am1Oa2pBbmp0UkRSdVRxR2hzZGNERUtSU1NRSDdER0tZMnVUbW1FMEszZXVL?=
 =?utf-8?B?UDNZelBrQWRReE1sQmpmQ201d2d3SWo3dFlxek8zaysvMlZtaWU2U2xBeURF?=
 =?utf-8?B?eGhENHJxQUpjWituS2YzZTViSm5SNlFwRklwSVhNZXovN2c2NVJaYkNhelln?=
 =?utf-8?B?RGlsa0lWVklDcWIvVnlkRVBkTjhZUHA1WmtHWFVoMGRKbUM4RFFFcTJRR21U?=
 =?utf-8?B?aDNrbEZkY3RQVmVSaWRRb3NhNWhjRW1JS2hhSzUxT3VnbVdCKzZncDNXRDJ2?=
 =?utf-8?B?NHFzcEprdmMvTnVsNFdaSzdtMHNyRlJaTEY5L0VsN3E2ZG16L0MxWFBjTE5k?=
 =?utf-8?B?RlVhSXFUYVJ5cDJrVk16Qzg5OSs1UUVCVkNZd0E4SWdhNWp3N3F3ZUtkU3ZC?=
 =?utf-8?B?eVBTUzZ5TVVnSWhYWVl4eUdkZmljT1pUMVRZcXhyL1hXemVBWWVpYUJxcUpy?=
 =?utf-8?Q?ySC5h63gjxzVQMufG9AHudzl1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C94C2EB9990A141A91646793E481719@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 745eaf0b-a970-4ffd-dd38-08dc3f05766f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 00:19:47.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdyuovpRVJ8ehf3g6X5fgc2HL3uzrzFqX4Ulwd5GqS712hUlmkvDmPGBkf+01fEKaMT6fEYtx0/dSBPnL/Ec0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971

T24gMy83LzI0IDAzOjA2LCBicm9va3h1LmNuIHdyb3RlOg0KPiBGcm9tOiBDaHVuZ3VhbmcgWHUg
PGNodW5ndWFuZy54dUBzaG9wZWUuY29tPg0KPg0KPiBXZSBmb3VuZCBhIGlzc3VlIG9uIHByb2R1
Y3Rpb24gZW52aXJvbm1lbnQgd2hpbGUgdXNpbmcgTlZNZQ0KPiBvdmVyIFJETUEsIGFkbWluX3Eg
cmVjb25uZWN0IGZhaWxlZCBmb3JldmVyIHdoaWxlIHJlbW90ZQ0KPiB0YXJnZXQgYW5kIG5ldHdv
cmsgaXMgb2suIEFmdGVyIGRpZyBpbnRvIGl0LCB3ZSBmb3VuZCBpdA0KPiBtYXkgY2F1c2VkIGJ5
IGEgQUJCQSBkZWFkbG9jayBkdWUgdG8gdGFnIGFsbG9jYXRpb24uIEluIG15DQo+IGNhc2UsIHRo
ZSB0YWcgd2FzIGhvbGQgYnkgYSBrZWVwIGFsaXZlIHJlcXVlc3Qgd2FpdGluZw0KPiBpbnNpZGUg
YWRtaW5fcSwgYXMgd2UgcXVpZXNjZWQgYWRtaW5fcSB3aGlsZSByZXNldCBjdHJsLA0KPiBzbyB0
aGUgcmVxdWVzdCBtYWtlZCBhcyBpZGxlIGFuZCB3aWxsIG5vdCBwcm9jZXNzIGJlZm9yZQ0KPiBy
ZXNldCBzdWNjZXNzLiBBcyBmYWJyaWNfcSBzaGFyZXMgdGFnc2V0IHdpdGggYWRtaW5fcSwNCj4g
d2hpbGUgcmVjb25uZWN0IHJlbW90ZSB0YXJnZXQsIHdlIG5lZWQgYSB0YWcgZm9yIGNvbm5lY3QN
Cj4gY29tbWFuZCwgYnV0IHRoZSBvbmx5IG9uZSByZXNlcnZlZCB0YWcgd2FzIGhlbGQgYnkga2Vl
cA0KPiBhbGl2ZSBjb21tYW5kIHdoaWNoIHdhaXRpbmcgaW5zaWRlIGFkbWluX3EuIEFzIGEgcmVz
dWx0LA0KPiB3ZSBmYWlsZWQgdG8gcmVjb25uZWN0IGFkbWluX3EgZm9yZXZlci4gSW4gb3JkZXIg
dG8gZml4DQo+IHRoaXMgaXNzdWUsIEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgdHdvIHJlc2VydmVk
IHRhZ3MgZm9yDQo+IGFkbWluIHF1ZXVlLg0KDQpwbHogY29uc2lkZXIgcmVhcnJhbmdlZCBsaW5l
IGxlbmd0aCwgbm8gY2hhbmdlIGluIHdvcmRpbmcgdG8gdXNlIHRoZQ0KZnVsbCBsZW5ndGggOi0N
Cg0KV2UgZm91bmQgYSBpc3N1ZSBvbiBwcm9kdWN0aW9uIGVudmlyb25tZW50IHdoaWxlIHVzaW5n
IE5WTWUgb3ZlciBSRE1BLA0KYWRtaW5fcSByZWNvbm5lY3QgZmFpbGVkIGZvcmV2ZXIgd2hpbGUg
cmVtb3RlIHRhcmdldCBhbmQgbmV0d29yayBpcyBvay4NCkFmdGVyIGRpZyBpbnRvIGl0LCB3ZSBm
b3VuZCBpdCBtYXkgY2F1c2VkIGJ5IGEgQUJCQSBkZWFkbG9jayBkdWUgdG8gdGFnDQphbGxvY2F0
aW9uLiBJbiBteSBjYXNlLCB0aGUgdGFnIHdhcyBob2xkIGJ5IGEga2VlcCBhbGl2ZSByZXF1ZXN0
DQp3YWl0aW5nIGluc2lkZSBhZG1pbl9xLCBhcyB3ZSBxdWllc2NlZCBhZG1pbl9xIHdoaWxlIHJl
c2V0IGN0cmwsIHNvIHRoZQ0KcmVxdWVzdCBtYWtlZCBhcyBpZGxlIGFuZCB3aWxsIG5vdCBwcm9j
ZXNzIGJlZm9yZSByZXNldCBzdWNjZXNzLiBBcw0KZmFicmljX3Egc2hhcmVzIHRhZ3NldCB3aXRo
IGFkbWluX3EsIHdoaWxlIHJlY29ubmVjdCByZW1vdGUgdGFyZ2V0LCB3ZQ0KbmVlZCBhIHRhZyBm
b3IgY29ubmVjdCBjb21tYW5kLCBidXQgdGhlIG9ubHkgb25lIHJlc2VydmVkIHRhZyB3YXMgaGVs
ZA0KYnkga2VlcCBhbGl2ZSBjb21tYW5kIHdoaWNoIHdhaXRpbmcgaW5zaWRlIGFkbWluX3EuIEFz
IGEgcmVzdWx0LCB3ZQ0KZmFpbGVkIHRvIHJlY29ubmVjdCBhZG1pbl9xIGZvcmV2ZXIuIEluIG9y
ZGVyIHRvIGZpeCB0aGlzIGlzc3VlLCBJIHRoaW5rDQp3ZSBzaG91bGQga2VlcCB0d28gcmVzZXJ2
ZWQgdGFncyBmb3IgYWRtaW4gcXVldWUuDQoNClJlc3Qgb2YgdGhlIHBhdGNoIGxvb2tzIGdvb2Qg
YW5kIGZvbGxvd3MgdGhlIGRpc2N1c3Npb24gb24gVjEuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

