Return-Path: <linux-kernel+bounces-135357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DF89BF6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8865E1F2283D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E18757FF;
	Mon,  8 Apr 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ii/pj0r7"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2110.outbound.protection.outlook.com [40.107.100.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949996F065;
	Mon,  8 Apr 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580629; cv=fail; b=ICkUxmHU2N+A5yqpIF+coQsGo34YUhfWfq8V976lfpbZsNaowWFk19MNDdFfR7t4HtxWyq4iUIK/aLUre3Ee3Ul1yiuUzvcXkVhsqphr4ywOMPwymzKbbhCUYcCC1T/llo68X9rFlJ0PphuebAsBJU7wE1qIJdD42e/5THhk5UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580629; c=relaxed/simple;
	bh=uTgRxiVO1O0vQ6sszHI19bBLTaNkcC9aW7AFfPPgH4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3aLBwMJA/oGJ1IbVqh7ECsxBr5S8gF31YJHDX8VCp3AWjxXivfCsNtdIG9UZ6Dzup9eDQIbV9PZ+iWExYsQAQvhqqLIRy+Z429mtgSFOAIWdF8oZ4GfmZaI1AK4iMJUYJkVOWXMNG1OUM9nyAhqDpPsxjJq0hefrEHtD2aduMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ii/pj0r7; arc=fail smtp.client-ip=40.107.100.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSrlsQS7EvT3qZUh14ajBV9qrhplg1FwpqPVuH3CjMnF3Zr3JU1x+7HXzhwwKpcc96CLZoF5Y0HLKMOjeP7w1S2hWPuJQyw2Ewbdohvvq/gveXJAGKEBzUP+tOyD0UYn3MRbc5NtfuFIhb/nLrWw5loiTUKvMjBWTPU0nH5RjyNpXfnbhSkrNqJnYc/yxyD8Ou0j0yIL2z8Kge4ds7m+c8Rg7tZq6D+C2FgGuivN3XXPmTGlYiVhU9gGaCmE7PhxjyLhZxTHQE3fMOsblji5k3EeLTSIvMCl7VEFk/cKf9XLLqG5HdTcVCZDlCkrAjW9f8CjwPFWNZBWxAhGJNMn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTgRxiVO1O0vQ6sszHI19bBLTaNkcC9aW7AFfPPgH4E=;
 b=DGARJaDGBLQb2lm+hj48Axhb1x7ORLCObBooYzPUBOlOodSQLLfa6aHu6I0T0rvyVkQtyNDTdULE2bHbFgy8f5nHxnKf5fmlpUNtlHOmYXjO3/K9MC9DIZCzn4t2IjsLkQN8AtcZddVq63lmyvouDnKG6fO7+GHfyZorYDAH1DmRJ2NmXGQ1G5/fUO1PQc6sjgJrvns1tqaS96bI6R5beHXvst9LNxqBLdFl2mebrnesKFdkfFpeEgW3A+mjw217MApNIAlp1ztiPU7Se/sgV+G1lVzQiEY1EGYVTUtDjIiR2914b5GDX0CY0/rcNXnpRfC2IKV+WEsLw3SWQXejpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTgRxiVO1O0vQ6sszHI19bBLTaNkcC9aW7AFfPPgH4E=;
 b=ii/pj0r7ewHjgYSzRJYXVxlZ95h/efdpiFkCAAu5xdDEvTAGFuabw8zbp1n6hB2RbJ38FkQXdfXrnUBHzRpBn8AlBn/kbGJkgswukU8I1cNmM/pi+9M/gC1CabgCUzkp0WJtg+MVCK9LmxI2xjeQeqhOPmKbEQnq0e2uZFwHaZ3AJehGWFQtOQMVecYiDYZ4oC3w8qaszjkpXx/djZrwGNwtAlgIWAym2tUIfteaS3nzYDgFZ+LeKZKlvL1sfd/vMJ8YrptiQtw0VrZiZMyPmh2wEINhc0PONni3xo8Q9qWoaH8AoButVaA8vmvgQrB31sNN9weqPE0XqIiBngHrjA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:50:23 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%6]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 12:50:23 +0000
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
Thread-Index: AQHaTQ+QQZNGrHyNcEuTxxeyuUrKM7DrCc6AgAb9nvCAAhi30IBqqhTA
Date: Mon, 8 Apr 2024 12:50:23 +0000
Message-ID:
 <DM6PR12MB45161B8BB3E13CED7EAE3311D8002@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
 <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
 <DM6PR12MB45161C82F43B67AD8EDB950BD87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516BC80DBF383A186707F19D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB4516BC80DBF383A186707F19D87C2@DM6PR12MB4516.namprd12.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB6611:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5B1u+/TOFBksl+YpSGik1axPTJWwo82fZ3v4dGdl4TYb/nFK5EWvBHPV18dRkpjRc0SYbOpcjyuTP217Fzdo89VnZyWuXS0chSamLswKP46Q2uoF8dAmO4T8m9LI3+h9ubfyJEXqnChrrNDfWPzC+txGqkojJ3y2I1oh9bbrFWVVPkpGUiBFy7m0gYLRmvtDqWgePqmDp4t0516avS4Y8cc4G+bovvwrMT3x9RbYuXHf1NaUYVuPcma5SWGRkilLk2jEJcrE4+UESHzR5j99rvbhnIjzLfibL77ZiUUgn32AfcjtNUZ5FPsoW+lP5aTPl33SjEtVcF+NJpnsd8ANXWdc+X8J502uFT770wdZ3Gm+GCqS6WoyvJMr7ufXgD1M30k0/AoNTP6sxVqzhJvMdNBQA6Ou4Rr+eTUO+OXzzoDJJDAUFohltc3lkitdVtGoHAzT2WuEBggLiL8TsuMvvAxOFlN9PxJMosq5J7p8IK/QY3wMnCnKlGWOsjxoOKnAC4zXMn1dwYbyT8YH4Qogc9VaFTM5Eem0VhG0bkwnP72Q5GL5N/Ifpez+80OKrWa++7E849CvxxtMKxWPvLBgOpjt7iLlmwt7Il8srngKvr8KONso86D6etIF7QCHY5C8/55ZWqlbf03efkF1HBaeuKGFKBjc3M4JIQRDzcsC8O0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEg2V1ZKNStGVzZvTGFuUGVxNHhPaUxraHdUeUZiejdzRjl5SVdTcGhway9S?=
 =?utf-8?B?RU1EUlZiNk1meTlvWGtyQVRuS0FHWFlHT0pHaG8wT0pFZzBnU3NNNFZ5b3Vl?=
 =?utf-8?B?UFhrOGkvVEZaZjhrWWFuRU1LSXdRWVVlMS9nb05hWkkzZ3phNWE5T2g4ckFE?=
 =?utf-8?B?ZmZVSnF4aThtWk43cVp5ZTcyU1V6SEpFM1FkcjVLTTlZckZ0UURRM1QwRFda?=
 =?utf-8?B?L0Q2VFFEMkhFMHhwc2hMSDB2YXVZV3NBVXNWbzZsSlVaUFJGMGY0TzROeGUz?=
 =?utf-8?B?RTA0TTdEQ3lQTzR6RVhIaHB1Y0Vqbk5Qc1hQTGxXeEtJaGxpOFJya1JMOVdC?=
 =?utf-8?B?MFROc1Jnbm56MldOVGs0eWVHLzVZQnozK0JkYlRuYXQvOXliVSsyVUJLUGZj?=
 =?utf-8?B?SU9EMEJGZW1IZHpEV3UxUTY2YWxYZVA3NGwwYkZqOWxtTUh1QURwMWFsYW1m?=
 =?utf-8?B?OGdZUmFlTExzNkhmZnc3NkpHbzM3MjRTaW1XaFpLTWFHUjF1bFRxTGtCc0tX?=
 =?utf-8?B?N2RqZS80cVQ2b2dwY2hLdDNBL2N5NGI1SlBFbFRNZ2dEZkd1TkpxMGRXNlYw?=
 =?utf-8?B?QTN1eTdPcEFCOThUZXVlNGJseGFHaWs4Y3Z6NnFVSnJMNlA2RTh2bG1hUHY2?=
 =?utf-8?B?RUoxV2drR0xtSHdHNDdYSGw0SHh1Mks3Y0NnQUF1VVpBRDM0Q3hzOUU5akg3?=
 =?utf-8?B?OCt4bzdGNHM2RnBmT1VmdzNoTlZtUXJ1YnJlNGg5ZC8rbmlYaTdVZUxKV2o2?=
 =?utf-8?B?bzdHZEJOTVNvWEJIcUd1UiswMnJwSTBjc3RHYlppR3BZVXBOYSt1WXNBM3ds?=
 =?utf-8?B?a3R2b1RKYlg5WlRwWkZQbW1Ta2tEcmVKekc4QjVYenBlZGlGWGZ0cENsTWsy?=
 =?utf-8?B?eGNnSzljZno1WEpaU0d6RUV3aGxnWTdnR2Q1NE9sdjlmSkNhRzZRQUQ2eng1?=
 =?utf-8?B?VUg4WjlrbHNoNGJIOWk4a1hSZ3Q1T0oxRU9ObVA1MmVtcGpMdFdoWFB5aDdw?=
 =?utf-8?B?YnVQT0kxOW1OWnNKMzZwNFFsclVqNHZnaThHR1ovRmozdVNiR2wrMmFyck5j?=
 =?utf-8?B?akxybUlDbXlQSFJuSXk1eEUxS08xSllWWXVjRjl1UTE5a0dPSW9rRXoyYUVi?=
 =?utf-8?B?bXdRWmhQdDVyWHlXM0FpcWVHZkFUK1NXQW1icVc0M1NLOFN0MldQZXFKOHEw?=
 =?utf-8?B?YjE3Qjl1QUVvejJzMndINjBTbG9GeithYzk1MUxCSXhXQ1BuTHdKaXllWHRT?=
 =?utf-8?B?WUlSNUZVWURtN3RrUzg3c0xFdlJud1ROSGsyaGxGZ0ZUQ09WOUdYLzRRZkxU?=
 =?utf-8?B?V01qREJWV0hXL2EvalNZM3RhenQvTjJEK3piUmNLTUhFSGxPaW93cUNMUHZE?=
 =?utf-8?B?bUNlR0p5MXR4d2hxbDVVRW5iMnNhVk5mZTBObTl5dUpQeGlsTndsNmN2U0Qx?=
 =?utf-8?B?aXZOV3BjbWVRNUVKRW85cmkrUzJWeElDTE82dkNMaGc1Q2ozTGJncDhqSmJV?=
 =?utf-8?B?c2NFMFFxUGNNdEVQRDVhRnFTaWc3MERQRWUxaFNkRGpoaU9KanVCTmJ5cW5C?=
 =?utf-8?B?QlR4ZXdtVFN4OW5DOGJpK2F3Y1BuUjBVT1QrdExQWkpEWHdsb2lNUDRldjB1?=
 =?utf-8?B?VGg3cHA5VE5reW5OUWI5VXZ1UWRORUl4UU1PV0VsMHgvTVlodWd2WnJsUU5z?=
 =?utf-8?B?MTR5ZUNWOUR1bW9mNDI1SmVKNlFxYnRKZElBbGVNTnF1bUxMZnpIeVVuSzlQ?=
 =?utf-8?B?NElkN1FILzVuVU0vMGU4RWNmTFY5TXZNK0t2QnlKOG5PN0ZmVVAyUU15SzVX?=
 =?utf-8?B?Y2VFTDJ4TnJVTzFzdU8ySVdTMlhUa1pua0RLYlFCbVFZbFg0RTBKdlk5ZHM1?=
 =?utf-8?B?V3ZSbEZTdFdxYnNkTzZkamI0OWpDZTJjZnkveFZyVDhJa1FnRjZ0aDUyUTRt?=
 =?utf-8?B?WUR5d1U0Q2NKcm9sU3FheTZzZGRQUXJnZnlPVlZ3SDRYMkl0NEdRa2ZEaURF?=
 =?utf-8?B?YzBjSTY1WTE4d3QwU0h0K0E4aVpsTGorcHV4QmlYQk1QMmFvY01KTVlURng2?=
 =?utf-8?B?OWdnWVhnY2pVaEVQOGgwTTNhbUJFZ0pHejhhbG5mQ0FCS1F1UVJNWHJ0RUIv?=
 =?utf-8?Q?HhZx4RP2QlUrDmGvYedymIzmd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f41e69f-d22f-42ab-5e46-08dc57ca74ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 12:50:23.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OIgbBhjLPw6F+ZTiKT4cZs64kp3sHyJWSOr2MNY4VvUeB5LT8IMhmpQOV5fKk31O4rY22UFxcXLd3NfMIzCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsbGUgUmF0c29u
DQo+IFNlbnQ6IFdlZG5lc2RheSwgMzEgSmFudWFyeSAyMDI0IDE3OjUzDQo+IFRvOiBBbmRyZXcg
THVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZl
bUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7
IHBhYmVuaUByZWRoYXQuY29tOyBjb3JiZXRAbHduLm5ldDsNCj4gbGludXhAYXJtbGludXgub3Jn
LnVrOyBzZGZAZ29vZ2xlLmNvbTsga29yeS5tYWluY2VudEBib290bGluLmNvbTsNCj4gbWF4aW1l
LmNoZXZhbGxpZXJAYm9vdGxpbi5jb207IHZsYWRpbWlyLm9sdGVhbkBueHAuY29tOw0KPiBwcnpl
bXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tOyBhaG1lZC56YWtpQGludGVsLmNvbTsNCj4gcmljaGFy
ZGNvY2hyYW5AZ21haWwuY29tOyBzaGF5YWdyQGFtYXpvbi5jb207DQo+IHBhdWwuZ3JlZW53YWx0
QGludGVsLmNvbTsgamlyaUByZXNudWxsaS51czsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1seHN3IDxtbHhzd0BudmlkaWEuY29t
PjsgUGV0ciBNYWNoYXRhDQo+IDxwZXRybUBudmlkaWEuY29tPjsgSWRvIFNjaGltbWVsIDxpZG9z
Y2hAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtSRkMgUEFUQ0ggbmV0LW5leHQgOS85XSBl
dGh0b29sOiBBZGQgYWJpbGl0eSB0byBmbGFzaCB0cmFuc2NlaXZlcg0KPiBtb2R1bGVzJyBmaXJt
d2FyZQ0KPiANCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIG5ldC1uZXh0IDkvOV0gZXRo
dG9vbDogQWRkIGFiaWxpdHkgdG8gZmxhc2gNCj4gPiA+IHRyYW5zY2VpdmVyIG1vZHVsZXMnIGZp
cm13YXJlDQo+ID4gPg0KPiA+ID4gPiArc3RhdGljIGludA0KPiA+ID4gPiArbW9kdWxlX2ZsYXNo
X2Z3X3NjaGVkdWxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gPiA+ICsJCQkgc3RydWN0
IGV0aHRvb2xfbW9kdWxlX2Z3X2ZsYXNoX3BhcmFtcyAqcGFyYW1zLA0KPiA+ID4gPiArCQkJIHN0
cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykgew0KPiA+ID4gPiArCWNvbnN0IHN0cnVjdCBl
dGh0b29sX29wcyAqb3BzID0gZGV2LT5ldGh0b29sX29wczsNCj4gPiA+ID4gKwlzdHJ1Y3QgZXRo
dG9vbF9tb2R1bGVfZndfZmxhc2ggKm1vZHVsZV9mdzsNCj4gPiA+ID4gKwlpbnQgZXJyOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJaWYgKCFvcHMtPnNldF9tb2R1bGVfZWVwcm9tX2J5X3BhZ2UgfHwN
Cj4gPiA+ID4gKwkgICAgIW9wcy0+Z2V0X21vZHVsZV9lZXByb21fYnlfcGFnZSkgew0KPiA+ID4g
PiArCQlOTF9TRVRfRVJSX01TRyhleHRhY2ssDQo+ID4gPiA+ICsJCQkgICAgICAgIkZsYXNoaW5n
IG1vZHVsZSBmaXJtd2FyZSBpcyBub3Qgc3VwcG9ydGVkIGJ5DQo+ID4gPiB0aGlzIGRldmljZSIp
Ow0KPiA+ID4gPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJaWYgKGRldi0+bW9kdWxlX2Z3X2ZsYXNoX2luX3Byb2dyZXNzKSB7DQo+ID4g
PiA+ICsJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIk1vZHVsZSBmaXJtd2FyZSBmbGFzaGluZyBh
bHJlYWR5DQo+ID4gPiBpbiBwcm9ncmVzcyIpOw0KPiA+ID4gPiArCQlyZXR1cm4gLUVCVVNZOw0K
PiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCW1vZHVsZV9mdyA9IGt6YWxsb2Moc2l6
ZW9mKCptb2R1bGVfZncpLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gKwlpZiAoIW1vZHVsZV9mdykN
Cj4gPiA+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwltb2R1bGVf
ZnctPnBhcmFtcyA9ICpwYXJhbXM7DQo+ID4gPiA+ICsJZXJyID0gcmVxdWVzdF9maXJtd2FyZSgm
bW9kdWxlX2Z3LT5mdywgbW9kdWxlX2Z3LQ0KPiA+ID4gPnBhcmFtcy5maWxlX25hbWUsDQo+ID4g
PiA+ICsJCQkgICAgICAgJmRldi0+ZGV2KTsNCj4gPiA+DQo+ID4gPiBIb3cgYmlnIGFyZSB0aGVz
ZSBmaXJtd2FyZSBibG9icz8NCj4gPiA+DQo+IA0KPiBUaGUgbGFyZ2VzdCBmaWxlIEkgY2FtZSBh
Y3Jvc3MgaXMgNDAwSy4NCj4gDQo+ID4gPiBJZGVhbGx5IHdlIHdhbnQgdG8gYmUgYWJsZSB0byB1
c2UgdGhlIHNhbWUgQVBJIHRvIHVwZ3JhZGUgdGhpbmdzDQo+ID4gPiBsaWtlIEdQT04gbW9kdWxl
cywgd2hpY2ggb2Z0ZW4gcnVuIGFuIG9wZW53cnQgaW1hZ2UsIGFuZCB0aGV5IGFyZQ0KPiA+ID4g
cGx1Z2dlZCBpbnRvIGEgY2FibGUgbW9kZW0gd2hpY2ggZG9lcyBub3QgaGF2ZSB0b28gbXVjaCBS
QU0uDQo+ID4gPg0KPiA+ID4gR2l2ZW4gdGhhdCB0aGUgaW50ZXJmYWNlIHRvIHRoZSBFRVBST00g
aXMgdXNpbmcgMTI4IGJ5dGUgMS8yIHBhZ2VzLA0KPiA+ID4gd291bGQgaXQgYmUgcG9zc2libGUg
dG8gdXNlIHJlcXVlc3RfcGFydGlhbF9maXJtd2FyZV9pbnRvX2J1ZigpIHRvDQo+ID4gPiByZWFk
IGl0IG9uIGRlbWFuZCwgcmF0aGVyIHRoYW4gYWxsIGF0IG9uY2U/DQo+ID4gPg0KPiA+ID4gICAg
ICBBbmRyZXcNCj4gPg0KPiA+IE9LLCBJbGwgaGFuZGxlIHRoYXQgaW4gdGhlIGFjdHVhbCB2ZXJz
aW9uLg0KPiA+IFRoYW5rcy4NCg0KSGkgQW5kcmV3LA0KDQpUaGFua3MgYWdhaW4gZm9yIHlvdXIg
ZmVlZGJhY2suDQpJIHRob3VnaHQgYWdhaW4gYWJvdXQgeW91IGNvbW1lbnQsIGFuZCB0aGlzIHBh
dGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgZmxhc2hpbmcgQ01JUyBjb21wbGlhbnQgbW9kdWxlcyBv
bmx5Lg0KTGF0ZXIgb24sIGlmIGl0IHdpbGwgYmUgZXhwYW5kZWQgdG8gbW9yZSBtb2R1bGVzLCBp
dCB3aWxsIGJlIG1vcmUgcmVhc29uYWJsZSB0byBhZGQgc3VwcG9ydCBsaWtlIHlvdSBoYXZlIHN1
Z2dlc3RlZCB0byBmaXQgdGhlIG5ldyBzdXBwb3J0ZWQgc3RhbmRhcmQuDQpTbywgY3VycmVudGx5
IEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIG5vdCBhZGQgaXQgdG8gdGhpcyBzcGVjaWZpYyBwYXRj
aHNldC4NCg0KVGhhbmtzLA0KRGFuaWVsbGUNCg==

