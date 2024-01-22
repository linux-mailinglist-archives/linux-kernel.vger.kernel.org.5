Return-Path: <linux-kernel+bounces-32982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2E8362C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A461C24AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660A3B18D;
	Mon, 22 Jan 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YpKJBsQF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E073A8E3;
	Mon, 22 Jan 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925117; cv=fail; b=C7ZA0wqq4GdRyXAkaNe8nwwEcSSRRaMvNmfrsOmGZKD0G1To/gH4FUzyL7ao2PYH9KUdz86i6+egQC1saHf5u03i6bxPD9/SQEQ/NSNUsUQYdNkTvhrWPvC1yvgfXz68E8LY/XR66b2ddVvyGSubUuHzaT0Ou8mEem1AKGEgEjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925117; c=relaxed/simple;
	bh=1SvJKvuFCZjN4bki6D9XG90C1349yhfeV5lrafYGMUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WNZVy96nf0nkDrQLeFh/Pd8VccnFet+Sg/VM9mgYPq2dufRSV8r+u5c7pKHsFue6y6DKq93iktdtLQQ2LMi/FdwjF4NUfBKgAumdK1nEdGGwFtNZKq+LG+r5dfaHjfwlunhXy5W6hpQ72DOWHCfD28K2KytOhAfTnSUnje8ev3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YpKJBsQF; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTkyu+JgRrLf/nF18ylvR/YqnSgpFMg/u1adZp3BAxbUtGVXpuV1DxEBI0WkIOo9SZBTlZx+tQP7zPKdcnk+eORRhfNXFyXPinDtWqBIT8nDToTQUnUq8l0KkGGf1uYeJ++FzTaGksBL3CDxxkE7xoKhSiKh6ipVDE587Ut76BAEsXCYmdwfpD7ovzjp9UIBubRI8sQSiV63tNPiJBrT0vWG6+06BEdJX0zDvQLl9wSr/CYIh9ChdF+24/nCVCpWBAkKaVu5n0yYVZjPcHk1xTlQlW5kgNtr6qdRz2F3kqxxtuZpMvqqNPUouSmqHdTmx8JtA8/RvOunhpl99vYtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SvJKvuFCZjN4bki6D9XG90C1349yhfeV5lrafYGMUw=;
 b=R/ilNWZ4/rXbxQJHj25cjOYsjZYxjrpik4cWM6AvSRRCQQv+xZEb2sMBFyAaO+tp9JnDAMMbwbIt6LtLMnq1phqqbFRY74bJA8+4liaSLGna2afC4gH5HkVFqqKzaJ6eRWdAG8MVhoS95i9gybuObEf97FXdVVTMQvj+So6W34nEDtksYX0/ARgmKOMyZdwKNfSdjXRl6ypLRLqE0ze95wcZYIu4zsBzcaq13H6EdFgb57Kr8YNCrz5amxbuedNNdUhyi+diPBhZWUrpqM4zJ8YlFoXvyz1MeAlyjuvITo3+L18wVbq60uXvfCccyXWNFT0A6j/BRyT7gztwESaiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SvJKvuFCZjN4bki6D9XG90C1349yhfeV5lrafYGMUw=;
 b=YpKJBsQFGrjfNiEi1Ib6oyt8PqPa+yyMfBUtqkpjXNVfU8ejslIQJSa7NBxgogtKT0wAdTgjK/0hsmHMF5SBj1SnZE0z2Yb3TdYdbro1VqiKG9+hICgkekLcmXtdbQaOxy6LNy8NaDLUcdP9oUAWvxHvGY+iZGw4fUVpyDJxT9A=
Received: from PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 12:05:13 +0000
Received: from PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::cd3:fb61:5d48:fb08]) by PH7PR12MB7284.namprd12.prod.outlook.com
 ([fe80::cd3:fb61:5d48:fb08%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:05:13 +0000
From: "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Topic: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Thread-Index: AQHaPhVjvmRGRPQ6SUKSkOvyusaGNLDI1osAgB0C/QA=
Date: Mon, 22 Jan 2024 12:05:13 +0000
Message-ID:
 <PH7PR12MB72843442C2A3DA1152AE074E8A752@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
 <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
In-Reply-To: <55fd522918aa41f386e01432248933da.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: sboyd@kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7284:EE_|DS0PR12MB7746:EE_
x-ms-office365-filtering-correlation-id: 7df817e3-4fea-4e52-6a66-08dc1b426376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fyifP5rzGtiFpgzr774kwF80WqILeVWV+qiq5QzUFpluMVGHwp5ygZfEzSRXrfbV+l/32PtPINaHOq9rdnFbk3TQDgFFv3sIyZZkem6bNgdZm4tEysLGK2mB6hFF2E6AdYskPpu/QLwyIMXcCoExdX/5HQjUDKHqmmfWvwWEGu28zWWvH4wdIz5SyRuHp/628cpHqQ/XTPY8ySlAy1Xp/33d6ClaYBVhRMsYN8+S6YslGXYAg1+jO8ozxm21Jsxqj0kaMaIM8NsX3HBXsN2oBCu09OzwFyhxmxP/Qui3VDLCNxNtwZRc412eRmIokLOXA+u17WzFJKvSqGftzaRh4e3bJjguGszkDuWrotv59G3nVXaP4IzDWLcDbsG5an0GGWmwG8hRVVtmi1r4I4wIGYbUtg9o8JwFq5YEeyAcYhz2C45YhkZB6JW3Bjrr8VD6re8bqmgqCa1VrbamUMqFPMCrThZrJ8+jdVjPTMmd7Bqlq2HKCNItUDiSlbYlL7viylDE4wquC06LBIean2dQHi+OrYg8cPJYIw0OqGE1Frv5y7jM/1JmFjVLAwG89IoVr6rTaiKdJnK5CIqqGRXI63f6icQD+K3wFEJMvLSixBn8G3JL9lEFvI67NUfrbjQNLkxjEupJjBwnZWG97EITBHviGcBPtM1wSLD3e+wWHhM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(33656002)(41300700001)(86362001)(38100700002)(83380400001)(8676002)(478600001)(7696005)(71200400001)(8936002)(4326008)(9686003)(316002)(6506007)(66446008)(66556008)(76116006)(54906003)(6916009)(64756008)(66946007)(5660300002)(66476007)(26005)(2906002)(52536014)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elQxUzZ3VDlpYWR4V3Q5QTlIb01yaEtTN1l3ZnhqRmpGWmQ2cExwZllGcXZC?=
 =?utf-8?B?MFZ1RkRrTHp2VjBWTGVHSytFWUJaTEhYRUhldUlWdmxNYk8zcXpHWEtLUmx6?=
 =?utf-8?B?L1NJZE16MTZlWS9Sc3d5WTFkR2xwUzkwOXhoRmx5NWxaUFRacDYrZjUvdStt?=
 =?utf-8?B?RVJQb29uOHREQjY2Zi9WQXFXdC9EanptbkRTK2Y4UzhabFRwTCtPMVBwWU4z?=
 =?utf-8?B?WVEvZ0xvUVBXSDExTnlMSDZXTUY1OUhBRmxFRUltZDBKYmFCUkNyTWJuQmJx?=
 =?utf-8?B?YUtLNDVNVjZNcDRMOGNMTnowYndpNi9HbG1tR3laelNhRkU2a1ZldG5PaUlL?=
 =?utf-8?B?c1MrVEcrSnZ3UXFCTEpITEtrV01WOXIrdjJ4R0lGYzdxeHMveEpGY0N6bFJo?=
 =?utf-8?B?MTRHYi9FVFZRRG4ydnJGSXNMUEh1dFlxT0dMbmdGNzNSZ29OcWZYRE9RVmRs?=
 =?utf-8?B?SzVWOTRKWEt0OHp5UDVMS3E0YTUxRkR2clYvc1N3eG14cGE1eU1wSmVQREdQ?=
 =?utf-8?B?bEptUEJpNGJFY3NrMUZnVk8zV2ZzNUhIWTdHZFUvT055NEpBZmZZQzkzMEIy?=
 =?utf-8?B?TWpvWkM1YkJJNVJEcjRVTVY4VEJkaDlaeXBZMWtMbWxibEFWZ3Roc1pRVy9L?=
 =?utf-8?B?SVMyTFBZNEtmZHd1WDV0Z0M1RU1McHZLOHFqQnNGelo2NDI0b3lqcjlCbERr?=
 =?utf-8?B?dUNjeWpWQXhPbWp1MjJJd2ptU25FemNjMklNQjhWOFU4UzliclZKVHV0NSs1?=
 =?utf-8?B?M1pIakU1UnZoWE8xNHUrczZnYzdHcmN2elBvK0ViZGhXWHc0NDFsL1dYWTBs?=
 =?utf-8?B?SHVWRmt0RmlzK0lNMmJoK2NtRG5TTmtXK2oyQUNYZGl3K29CWmo0ckphVEQv?=
 =?utf-8?B?R1piMklSWGY2NTNob3FPOGF0Qndady9PVmFLWVhkYTBWcUU2LzdNNExZRjh0?=
 =?utf-8?B?L21oeElkMFdHVFppV0pvRXJtK1FkdzBCZXZLdGUyY2xqM3RPQXE0KzRnMUhr?=
 =?utf-8?B?bVRlaXdTU3k4YkFCdFpoS0FFMlQzcjZrK2Y2cENqOWQ3QWR3TE9vTG5YeEQv?=
 =?utf-8?B?MTdqNUIwNTJSZzN4T0RRMHRpeUZ5U3pBekhpajhxUzNWUTVkR243cFNXZXVN?=
 =?utf-8?B?dERIOHZTdDBwK3psdTNBSk8ycGsyRTRmaG11N04wMTRQR3YrUVhyUFcwbm1L?=
 =?utf-8?B?ZlVXZFVFUXcwY1pyaUp0bzBBa0xFTkxtdEJaYnZZREFydStTR2JpRGZmODN1?=
 =?utf-8?B?RFdGOUppWERJT3Jta0FBUUVFRSttWXlMOWdoREVPOWl6SkxNZ0p3ZW11Z0dR?=
 =?utf-8?B?anNGR0lDOFFSelZOM0hsSWlYbFVQN3UwQjJyOTNnckRmOXBBQnJhYW9ZaWtP?=
 =?utf-8?B?ZzZ2T1pKSWl1MWYybjFydXowck5VZEFiVXpkQnEvZVZmeWRzN2V4WTM0Y2c1?=
 =?utf-8?B?WENhTVB1L1l2amhUUW81OHRxYW94OUpKWDRPSHB0b1hudm9BQjA0d0I4WDRD?=
 =?utf-8?B?SytGUWpwMWdYUVJIRXplSXNtT3JYU2ZWZWt5dXJBYXZyRnlhVEpDclVjMjg2?=
 =?utf-8?B?R3lUOTdnUkNWMXl1d3IyUTZhME1GQmRsckp5d1dDbzhwMzM4YzYyVDN1Vnlk?=
 =?utf-8?B?T0hGakRxMEEyZ09YcVRZZERHeVI4aGo2bWdwdjJQK2Z4ZWRZQlZGTTVUQzF0?=
 =?utf-8?B?ckNLN0NaVjlrZHNJRVpmWllTRjJMd29PMFVYTEVSelpOV29FNnhpeVp4SlFp?=
 =?utf-8?B?a3p0VzgxNVZjMDNOSlVaTVNwSS80SW9wUkt2dVVCN0xhSStkZWljdjRrek5L?=
 =?utf-8?B?by9ac3RCaGZWWTArWUR0YmpXVDhkUUlvUVJBTGZ2T1BTd3IzMDJsSTlQa3ph?=
 =?utf-8?B?NGZ0bVdQZHVnODlCWVA5WGs1V25UcWZwM1ZuMUMyc01Dd2JjaDRFV05FU0Vt?=
 =?utf-8?B?MEVRK1Z0UlRvRFZTTExTVXd3Q0JCVlRXUWlzS01DY09oS2FVVFJyTUNTS0xF?=
 =?utf-8?B?bHRxTkdDU2VmTmk0VWlxaGVFNThnOEdxSjRUWDBwYkxEMDk3VXMyblZLQmpR?=
 =?utf-8?B?UHhiZFBTNWdid2Fpd01mV2huOXdEdVdRUk9sTmd3ZEh2Mm53RStmOW4wNDY5?=
 =?utf-8?Q?ZqrU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df817e3-4fea-4e52-6a66-08dc1b426376
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 12:05:13.0142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAVZFkZbS+F/QKNWtr/Pws/6XSmwmXuLlg91UjHMU5kn6zxHF/LG1jHzJmc4Ohcn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

SGkgQFN0ZXBoZW4gQm95ZA0KDQpBIGdlbnRsZSByZW1pbmRlci4gUGxlYXNlIGhlbHAgbWUgdG8g
dW5kZXJzdGFuZCB0aGUgcXVlcnkgSSBoYXZlIGFza2VkIGJlbG93Lg0KDQpUaGFua3MsDQpOYW1h
bg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBTdGVwaGVuIEJveWQgPHNi
b3lkQGtlcm5lbC5vcmc+DQo+U2VudDogVGh1cnNkYXksIEphbnVhcnkgNCwgMjAyNCA2OjMwIEFN
DQo+VG86IFRyaXZlZGkgTWFub2piaGFpLCBOYW1hbiA8TmFtYW4uVHJpdmVkaU1hbm9qYmhhaUBh
bWQuY29tPjsNCj5hYmVsLnZlc2FAbGluYXJvLm9yZzsgYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bjb2xsYWJvcmEuY29tOw0KPmtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZzsgU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPm10dXJxdWV0dGVAYmF5bGlicmUuY29t
OyByb2JoQGtlcm5lbC5vcmcNCj5DYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBUcml2ZWRpIE1hbm9qYmhhaSwgTmFtYW4NCj48TmFtYW4uVHJpdmVkaU1hbm9qYmhh
aUBhbWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcnM6IGNsazogenlucW1wOiBy
ZW1vdmUgY2xvY2sgbmFtZSBkZXBlbmRlbmN5DQo+DQo+Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9y
aWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPndo
ZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+
DQo+DQo+UXVvdGluZyBOYW1hbiBUcml2ZWRpIE1hbm9qYmhhaSAoMjAyNC0wMS0wMiAyMzoyMDox
NykNCj4+IEN1cnJlbnRseSwgZnJvbSB6eW5xbXBfZ2V0X3BhcmVudF9saXN0KCkgZnVuY3Rpb24g
dGhlIGNsb2NrIGRyaXZlcg0KPj4gcmVmZXJlbmNlcyB0aGUgY2xvY2sgYnkgbmFtZSBpbnN0ZWFk
IG9mIGl0cyByZWZlcmVuY2UgZnJvbSBkZXZpY2UgdHJlZS4NCj4+IFRoaXMgY2F1c2VzIHByb2Js
ZW0gd2hlbiB0aGUgY2xvY2sgbmFtZSBpbiB0aGUgZGV2aWNlIHRyZWUgaXMgY2hhbmdlZC4NCj4+
DQo+PiBSZW1vdmUgaGFyZCBkZXBlbmRlbmN5IG9mIGNsb2NrIG5hbWUgYW5kIHVwZGF0ZSB0aGUg
bG9naWMgdG8gdXNlIGNsb2NrDQo+PiByZWZlcmVuY2UgZnJvbSBkZXZpY2UgdHJlZSBpbnN0ZWFk
IG9mIGNsb2NrIG5hbWUuDQo+DQo+UGxlYXNlIHVzZSBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIGlu
c3RlYWQuDQo=

