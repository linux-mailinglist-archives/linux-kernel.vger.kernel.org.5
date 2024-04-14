Return-Path: <linux-kernel+bounces-144041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5D8A4128
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EFE1C214EC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660F822612;
	Sun, 14 Apr 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQYqFC0+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71417565;
	Sun, 14 Apr 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713082851; cv=fail; b=lpJ8NsQ/Aw+Fcb1R7dDoKs+VEU/+xZS0vUh+7ZTNjgFpIXh/K5EuG+TYY3fpeEEDs8yVn3JySkBBl3auGHgYypHMKfwABUbDXZyd+G+qk9kJNRD5WkTnhK/J3zgWr5drudtzA+11IlmO85EXh33j+Bb3in9dYk6CPJkbGhSRUhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713082851; c=relaxed/simple;
	bh=6yKAszZT/+/W38/N9eWp4NLUo3ddi7VGm3GnbaKbZsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AtL66mKr7+rNBabmaV5JC3AutfWypEKWeFYh2Q725oL90kocQnG8s4KGOzdAlF9j/BDC9D+x5V7kfVh+7WWXBZQLkIGAJV33hu33ODAxmJ+L0nTv7JjGjTdTjOcotC16Xw7E4wFnFp/t3lkLDNkLHDbAbGM9qLzzZDk1XnAHlRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQYqFC0+; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv2y0vQyuMogDvmoX15cLTRTUfFBh/O7XzV4snktWVvCF1CP2e8QuHJc09JGa9IgORV9yLb/z+YJWB0D7xCussvmWWNBTQvjHX9L9P5pA43i8BOC/E5r+2lfO1vDWFFZj8RlDc9Pezcw4uZS1ZkD2caEY7d06Z+vSXpnYBnXWgAmGQSKzmfMb63e0YN/fANIIq75WqzZPWiaHKSHuBdf4kFkgQPNKsCobdPzBuWvofK3iSnRo150vOoq180zcFoKWb0l7Ldsx4sCPKuyhV65EqKV2jbrpWdlT+KCoya838EqZLRS1d/rE+ljgRCL53tW2WLnOC47AqaO3WNmlbfLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yKAszZT/+/W38/N9eWp4NLUo3ddi7VGm3GnbaKbZsE=;
 b=IlHxy0FRxA32Lk2zDlW9t52LJMC6l4xeyPxY7ehRVBkiEXZRIrFXswftALA5YEAdAvAat1WhUATxjWUi0lZ1NkjJaw5LaNmYOxKU6ivKSki0Vsj74VTsFN3rgWegxCJvFa14zo3Kx4hStUmq5fwWHIhyl5aGB4JdKCVZ9f5XCM0kYFnWoc9w7JZyscjPKNdbJ6JsZ53PvAZy7N2pC+oArX6JdvVa92CRqWJtFwxH4TNDeNhM0zlFqnhQC4CTXLlg6E3o2b7IUB72RRMCkimVGjYA1z5jywAjn2B+EYi9/H+59UtbYzdbtpQdrw+7971y0nMAja7jHRkhmkDIN7IFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yKAszZT/+/W38/N9eWp4NLUo3ddi7VGm3GnbaKbZsE=;
 b=KQYqFC0+i6w4rLnRu7U1PRv5elevk1diQSQU0lad5iw7C0nZwXMeKYbKIUjopFrzdg345AlhqMwSK2vawBHiAY4wCJuZy6Mk/73NzxlBUkVQeH2sxU4ah9fOrgYn1UkyiTjD3+Bjoc7t8G92qqNXnpUX8MTHKI+DBnb1R2ZSvahbbVP8KSEiNe94G5zFx03Hjn9M4KkVK2+B/SBVrML+hbQDtfonKTdk+GA/XHyVGL70YDI9EoLkRghlRLo5pPQ7dV95Vp/Q7OIrgzWvHk9q/HmQNtKNItMRz8vKAMqiS4018942t4U8+DMlXnro0fXINwItas9Cb/tAJj6n4i6oPw==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sun, 14 Apr
 2024 08:20:45 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 08:20:44 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "sdf@google.com" <sdf@google.com>,
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
Subject: RE: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHaibP8CTLNLV9gi0evdveMyJyMArFediSAgAFophCAB5SDMA==
Date: Sun, 14 Apr 2024 08:20:44 +0000
Message-ID:
 <DM6PR12MB45163B5A12A98382D359BBF6D80A2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240408125340.2084269-1-danieller@nvidia.com>
 <20240408125340.2084269-8-danieller@nvidia.com>
 <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>
 <DM6PR12MB451681D2A292399C9DDE9EDFD8072@DM6PR12MB4516.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB451681D2A292399C9DDE9EDFD8072@DM6PR12MB4516.namprd12.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|LV2PR12MB5751:EE_
x-ms-office365-filtering-correlation-id: f9bb8bdf-b6f6-4e8d-ef96-08dc5c5bc806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVFiaWh1dmpMWW1hSUJEWDd2aDBwUUtsTjNlMWVFbWExMjdhbDBGWFJhbXFX?=
 =?utf-8?B?S1cycWF3Qk5zeE83UlFzemhyeGNaMktybHZ0TjZyT3k2RWdtZ1cxb0IySkMx?=
 =?utf-8?B?RUZLemlmNTJYT1RMUVhoOXJuZW5OdXE5Z29sNFI5YlY4SmJCdi9GQzRlOW1S?=
 =?utf-8?B?bVBxdENjSjZPeFNCcnpOZEVDUDAyTkNjbVRUM3VCV2FUL0E4TWtGU0k4dEI4?=
 =?utf-8?B?a010dHhmcGxpYk9hSkR0VnFRWXlFc3pQWXZqZndYa21Yd2x3Y1lXbDNjbFZh?=
 =?utf-8?B?U2RwQURNVTQwRFN3TFNYTHg4cCtweGd6TEppOGcyMVR1MUNpUjlVM0h6Vyth?=
 =?utf-8?B?bjdlMUFLTnkyM3EzSklSMVQ2TUJXaElLeWxaSEpBcUtTeUFyREV1OEE3VnM0?=
 =?utf-8?B?MHIvR0JEditIWUxBRGwxZnNZNTVnamgwdnZ0elpFd09wMm5CMGRIZXlUcVJY?=
 =?utf-8?B?c0VUZklORjFvNlRoYi9vOCt5Yk1waGN5dW9xVWlVVHA1S0RRTmNYczljM2xC?=
 =?utf-8?B?Y1NISzR6d211Nm1vNVVFU3BsTG1UOUpyK3ZuS3ZGUUxqZW1kVGxvcUpGL3ND?=
 =?utf-8?B?N3RYMGkvTDBuY0xWWEpMWmVlcFgvcndBRm1jMXpnR0t0bXBSeC83b3FUd2lZ?=
 =?utf-8?B?bktzSmJ5N1BmeTRJVVZOUjhoNU1rNE9Cek9QQ1B1ejhkbUtZcGp1NXltODdO?=
 =?utf-8?B?TjdRMDJHKy9qc3hocjdrYzZWODlBUEJCU3BHaTRmaXMrTFJucjJQeitNbm41?=
 =?utf-8?B?cnRybUdEb2hPS3lCTnRmaXVUZm5wM09OQ0dJWjdEM1kydng0cUw5VUdpMXE5?=
 =?utf-8?B?VmtaNlh2QytIazd3T0hCZWVMMnZyMHJ4Rlk4MkdmUVU2dzlINDJYak5jamZP?=
 =?utf-8?B?WlZXbWtEdHhwZVM0WXZkRHJGTVU2Ti95YnpjY2pFQnQ0Q3NUSFBNdlRyU3NC?=
 =?utf-8?B?QVdhbWNDWjZyK2FPa0VQcUdaeXFyS0Y2QWRpTFpCNDB6YkZjRjVxZDdvRk5j?=
 =?utf-8?B?cEl2bnI4c251L3plcnhqVWtKdmtadDJ5R1o5WUloWUVvNmN2L01BaWV6VTc4?=
 =?utf-8?B?c2hFN09GVE9heVFHUnd0UlpVYWtBNjRDTzNyVHNrRDIyeE9ZenlNNE9pV2I0?=
 =?utf-8?B?K0p2VXVHa0czREg4bUV2eTB1aW1qb3lHditSRzFqTzNhNWg1SE5NN1BLeUJ2?=
 =?utf-8?B?SkpPMnhGbzVDQThtNytNL291ZmptYlJwMDkxcnVCZnZpVlJ5RkVqajVWVDlx?=
 =?utf-8?B?WDJXenlSc3VxRWl6Um05YUduL0YvcTJFNlhrTkVDVU1BZHA5SmdYWjJLbTB3?=
 =?utf-8?B?RkFSb0ROMTVqYU43ZWhLQ2hiZkpaV2pZdzJTNHJHMXh3OUFQK0J6OFgyenU4?=
 =?utf-8?B?ZDArUG1DcCtqdVFWbUp0blJnOHdyOVB6bFd3cjRIV3BveHVYWEZZaTU5RnNm?=
 =?utf-8?B?NTNMY2pZd3BXR2IyRkY4MVlyVUFWSmY5Tm9wZzl2YlFBbFkxNHVQc2FnT0tL?=
 =?utf-8?B?cEdUcWdhTEVtL1hvdTliUm9BUi85ZmR2TnZ6MVFud0RXTUxHUHRoaW8rVTVC?=
 =?utf-8?B?RGRSdVQrSkthMzZkcFVaWFJNeHFBMEZvd0hrSjRhT0NsalMwTXI0SzZKeklK?=
 =?utf-8?B?S3E5UjlOZWU3UU8vUWY3bDJwQndZd1lTdit1MjRkMXo1UFlRVDVRSW90ZVRy?=
 =?utf-8?B?anpWRVhLd2s1Sy9wSmZsbkhkczNUcUFlbUE1d0U3cmZDM1Y3c3ZicVZ4WTd0?=
 =?utf-8?B?WU5ldWhoSHBBWnFvYUdFYkZreFFmZGExTVF5QjJCVlpQZThML1RXVHYzcW4z?=
 =?utf-8?B?aWdQYVIvakIvazNlVXNiQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QysvM0FtWEhxTklJSzRORHdiNnJIQU1LVGc0QlpmRk9nNTBlbm81QmtUc0d4?=
 =?utf-8?B?eE80cUF1ckthMzVIdE42RDdFTEtrVGorVWJ1VFFjRkhWZjB1WEU1Z1YyWmFE?=
 =?utf-8?B?eTRNTUVvTC9nZnZiRXNRem5RamcxM3VYT1RFUHpFNGVVRjQvclk2YytTRjlP?=
 =?utf-8?B?WVFWMUFOZjBMbG5BVlluZHBtd0Z3TDZJaG9GdnJOM3FWRWEveDRTVlVYZ3M3?=
 =?utf-8?B?d1JLN2pSanUzRXZzUFN1ODNBZmtET3JOc0pWekx4UFpqVjFlL3lMWng5bEJt?=
 =?utf-8?B?K0hzWDlxa09PTUdQaGlGWUIyZm9IZzQydkx2SnVrOFpBM3BFbExKYW44Nitt?=
 =?utf-8?B?b3pmNTJyeGJkQVE0WngweGZHWDEvMi9UdVZ4ek1WdlN6UGpncVBtVWlZZTZS?=
 =?utf-8?B?YmhHK2paWC9ZQVVoeHNCTUMvNW5oQ043LzhvZ2J5SU9FVDFOenRrVy9OaUo5?=
 =?utf-8?B?RDBxeUZ0bmJkS0lMTE05d2FOZGIrNTQ3Vi9YY1ovVFo1UlVkbzdiZi91QU9X?=
 =?utf-8?B?ckVtT29OVzVxbUZBaEVxYlV3ekp1TjN3SEE1NWJrS0pSN3p6SmJKYWlhSGNt?=
 =?utf-8?B?TnhDcWRDZi9UZjRpcFZ4NzRCOEU2M3QxR0xUbE9tWkh2T2d2clJLdFI5TWVY?=
 =?utf-8?B?Ums1bVJDbGJLalJlNzZuSlE2eWdyQnRpTW9XYTZLMERvS3FMejAwZTB5UzVI?=
 =?utf-8?B?bnlkZUVRcXZDSWFmZ0J5TWZubGpOdlBCcUNsdi9LcUw2RXVGR0pVWC9Qb3FX?=
 =?utf-8?B?Szk2WUZxTC9lNlRMM2oxTzZsdXYwUjFuYXArZ0NIWTBpd2txWHpFWHVhTEdn?=
 =?utf-8?B?YjY2WTlRTlAvWW9XaGpXY2dZbzFRUWw4KzBpam9jclJtaFUxWThwNmRxajcy?=
 =?utf-8?B?WHBwZGpXZktONDNob0ZwYnNhTXpiaUF1TCtydElrek1RNjJsTEx1TmlSbmt4?=
 =?utf-8?B?bVlPYmxmZTVBbWRaa20yNG9nZ3NNay9OSy9HTy96dnUyRHl6SGlyTWovRTJH?=
 =?utf-8?B?N3pZWDhhbUZIUit5SENLYndKeDBBMW8xdVBpK09EZ2VsU0VMd1B6a25KMncx?=
 =?utf-8?B?TEhLVHRpdDdJTldnMVhnZndkWHc2bU1VeFY5cDFQWW1SaDlIczMwd0JKVTU0?=
 =?utf-8?B?OWtjZFVPL3B3eUF1MVdvYVlJbzEwU0RyT2pWUG5RRk1xeDlDcjdlaXJDUUlI?=
 =?utf-8?B?dHZmZnpXVnVJT2c3aENZRFgycEdVRE9XOEJUUG84ciswVjBOWnVtR3BtR0JI?=
 =?utf-8?B?cldaQUVxdS9zOFg5amVyb2hQV2Q1bXhJZWo2bVNyRktoQ2FrU3FDZFNKMmNw?=
 =?utf-8?B?a0JzdVlxa3huRTFqdTR4eFNaL05Fb3BRc2MxTmllL1JSQTV3RXpDTHF5WkJt?=
 =?utf-8?B?ZzYvdmNzNWF0aVpIM2FRb1Zmd01HUE03M2NzSk5oNW5Fckh4RlNPR3BhNEx5?=
 =?utf-8?B?MGVoTCs4VXNyUVVvUUN6azE0blpZZU5UQkl6a3BkTFlOMGduUTNiQkZjczFu?=
 =?utf-8?B?YjhjWHpDNlU5S2NMNDlGSjRLY25wUGxsNUkrQ0VRRXM2RW4yUDVoK3M0UTNw?=
 =?utf-8?B?R0JOeEJURmhhR0xSS29wQytjdVM3WEp4T3FqVlJUWm8zcUFsM0p3MWhaVno0?=
 =?utf-8?B?WlFyeThQZnR5L28rWlJ6OFNoZXVsUUhpL1p6cXFYSVg5K1RKZXhmU3N0UUJj?=
 =?utf-8?B?YXpvSjRFa3JNY0pyR0RqcCtNRnZ6bkVhVmE3SkpWeWgvdGw5YnRPTTdiMTVP?=
 =?utf-8?B?VlBVMm5hVFVNc25WK3p6V1d2OUxoOEwwVVRuaDh3SmZxenVINjI0VHYyWVpB?=
 =?utf-8?B?KzBYcmxtMnVqaUxDUzZZNE8yTXFGamxDOEJ4cUk2cEJtVy9odWFCQ2JLbjlJ?=
 =?utf-8?B?V3BWSjN2c1hOQ2gxWXlvMDdGazQ4RUt6VFJ3dnltRVpLZ29iNVk0WlNrZ2M3?=
 =?utf-8?B?K3JOay9GMXlDaXdLcXlXenU1eTA5aWFyVTZ2Yll6cEY3SHlmd3M1bzRueHVB?=
 =?utf-8?B?bDF3Y1FDMVdwdHArSk9GT0d3Z2RZTStObzk2Z0plb1pmajhaNEFmb2gwbFp6?=
 =?utf-8?B?YVdVN2dmNUdXVjYwWHIxSW5UZEpnbzNZWG5acEFxeFM4Nlp2L0JxdEdtcWtR?=
 =?utf-8?Q?yby+x8Dp58NLQW82AA6Ow1G0R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bb8bdf-b6f6-4e8d-ef96-08dc5c5bc806
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 08:20:44.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQnHheue1DhY/flWThF00HfVd6dDDYYtCE38UxnK2bGmE8xg3A/awNQmaNdhcRlkk7JPUoemsQv67d0tYkDabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWxsZSBSYXRzb24gPGRh
bmllbGxlckBudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCA5IEFwcmlsIDIwMjQgMTY6MzQN
Cj4gVG86IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPg0KPiBDYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNv
bTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgY29yYmV0QGx3bi5uZXQ7
IHNkZkBnb29nbGUuY29tOw0KPiBrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29tOyBtYXhpbWUuY2hl
dmFsbGllckBib290bGluLmNvbTsNCj4gdmxhZGltaXIub2x0ZWFuQG54cC5jb207IHByemVteXNs
YXcua2l0c3plbEBpbnRlbC5jb207DQo+IGFobWVkLnpha2lAaW50ZWwuY29tOyByaWNoYXJkY29j
aHJhbkBnbWFpbC5jb207IHNoYXlhZ3JAYW1hem9uLmNvbTsNCj4gcGF1bC5ncmVlbndhbHRAaW50
ZWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBQ
ZXRyIE1hY2hhdGENCj4gPHBldHJtQG52aWRpYS5jb20+OyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBu
dmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIG5ldC1uZXh0IDA3LzEwXSBldGh0b29s
OiBjbWlzX2NkYjogQWRkIGEgbGF5ZXIgZm9yDQo+IHN1cHBvcnRpbmcgQ0RCIGNvbW1hbmRzDQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUnVzc2VsbCBLaW5n
IDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+ID4gU2VudDogTW9uZGF5LCA4IEFwcmlsIDIwMjQg
MTc6NTUNCj4gPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4g
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsNCj4gPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29t
OyBjb3JiZXRAbHduLm5ldDsgc2RmQGdvb2dsZS5jb207DQo+ID4ga29yeS5tYWluY2VudEBib290
bGluLmNvbTsgbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb207DQo+ID4gdmxhZGltaXIub2x0
ZWFuQG54cC5jb207IHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb207DQo+ID4gYWhtZWQuemFr
aUBpbnRlbC5jb207IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgc2hheWFnckBhbWF6b24uY29t
Ow0KPiA+IHBhdWwuZ3JlZW53YWx0QGludGVsLmNvbTsgamlyaUByZXNudWxsaS51czsgbGludXgt
ZG9jQHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC0ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBQZXRyIE1hY2hhdGENCj4gPiA8cGV0cm1AbnZpZGlh
LmNvbT47IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+DQo+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCBuZXQtbmV4dCAwNy8xMF0gZXRodG9vbDogY21pc19jZGI6IEFkZCBhIGxheWVyIGZv
cg0KPiA+IHN1cHBvcnRpbmcgQ0RCIGNvbW1hbmRzDQo+ID4NCj4gPiBPbiBNb24sIEFwciAwOCwg
MjAyNCBhdCAwMzo1MzozN1BNICswMzAwLCBEYW5pZWxsZSBSYXRzb24gd3JvdGU6DQo+ID4gPiAr
LyoqDQo+ID4gPiArICogc3RydWN0IGV0aHRvb2xfY21pc19jZGJfcmVxdWVzdCAtIENEQiBjb21t
YW5kcyByZXF1ZXN0IGZpZWxkcyBhcw0KPiA+IGRlY3JpYmVkIGluDQo+ID4gPiArICoJCQkJdGhl
IENNSVMgc3RhbmRhcmQNCj4gPiA+ICsgKiBAaWQ6IENvbW1hbmQgSUQuDQo+ID4gPiArICogQGVw
bF9sZW46IEVQTCBtZW1vcnkgbGVuZ3RoLg0KPiA+ID4gKyAqIEBscGxfbGVuOiBMUEwgbWVtb3J5
IGxlbmd0aC4NCj4gPiA+ICsgKiBAY2hrX2NvZGU6IENoZWNrIGNvZGUgZm9yIHRoZSBwcmV2aW91
cyBmaWVsZCBhbmQgdGhlIHBheWxvYWQuDQo+ID4gPiArICogQHJlc3YxOiBBZGRlZCB0byBtYXRj
aCB0aGUgQ01JUyBzdGFuZGFyZCByZXF1ZXN0IGNvbnRpbnVpdHkuDQo+ID4gPiArICogQHJlc3Yy
OiBBZGRlZCB0byBtYXRjaCB0aGUgQ01JUyBzdGFuZGFyZCByZXF1ZXN0IGNvbnRpbnVpdHkuDQo+
ID4gPiArICogQHBheWxvYWQ6IFBheWxvYWQgZm9yIHRoZSBDREIgY29tbWFuZHMuDQo+ID4gPiAr
ICovDQo+ID4gPiArc3RydWN0IGV0aHRvb2xfY21pc19jZGJfcmVxdWVzdCB7DQo+ID4gPiArCV9f
YmUxNiBpZDsNCj4gPiA+ICsJc3RydWN0X2dyb3VwKGJvZHksDQo+ID4gPiArCQl1MTYgZXBsX2xl
bjsNCj4gPg0KPiA+IHUxNiB3aXRoIGEgc3RydWN0IHRoYXQgYWxzbyB1c2VzIF9fYmUxNiBsb29r
cyBzdXNwaWNpb3VzLg0KPiA+DQo+ID4gPiArCQl1OCBscGxfbGVuOw0KPiA+ID4gKwkJdTggY2hr
X2NvZGU7DQo+ID4gPiArCQl1OCByZXN2MTsNCj4gPiA+ICsJCXU4IHJlc3YyOw0KPiA+ID4gKwkJ
dTggcGF5bG9hZFtFVEhUT09MX0NNSVNfQ0RCX0xQTF9NQVhfUExfTEVOR1RIXTsNCj4gPiA+ICsJ
KTsNCj4gPg0KPiA+IERvZXMgaXQgbWF0dGVyIGlmIHRoZSBjb21waWxlciBpbnNlcnRzIHNvbWUg
cGFkZGluZyBiZWZvcmUgdGhpcyBzdHJ1Y3QgZ3JvdXA/DQo+IA0KPiBZZXMgaXQgc2hvdWxkIG1h
dHRlciBzaW5jZSBJIGNvcHkgdGhpcyBzdHJ1Y3QgaW50byBhIHBheWxvYWQgYW5kIGl0IHNob3Vs
ZCBiZQ0KPiB0cmFuc2ZlcnJlZCBsaWtlIHRoYXQgdG8gbWF0Y2ggdGhlIENNSVMgc3BlY2lmaWNh
dGlvbiwgYnV0IGlmIEkgdXNlIF9fYmUxNiBmb3INCj4gYm90aCBpZCBhbmQgZXBsX2xlbiBpdCBt
aWdodCByZXNvbHZlIHRoZSBpc3N1ZSBpc27igJl0IGl0Pw0KPiANCj4gPg0KPiA+ID4gKy8qKg0K
PiA+ID4gKyAqIHN0cnVjdCBldGh0b29sX2NtaXNfY2RiX3JwbF9oZHIgLSBDREIgY29tbWFuZHMg
cmVwbHkgaGVhZGVyDQo+ID4gPiArYXJndW1lbnRzDQo+ID4gPiArICogQHJwbF9sZW46IFJlcGx5
IGxlbmd0aC4NCj4gPiA+ICsgKiBAcnBsX2Noa19jb2RlOiBSZXBseSBjaGVjayBjb2RlLg0KPiA+
ID4gKyAqLw0KPiA+ID4gK3N0cnVjdCBldGh0b29sX2NtaXNfY2RiX3JwbF9oZHIgew0KPiA+ID4g
Kwl1OCBycGxfbGVuOw0KPiA+ID4gKwl1OCBycGxfY2hrX2NvZGU7DQo+ID4NCj4gPiBEb2VzIGl0
IG1hdHRlciBpZiB0aGUgY29tcGlsZXIgYWRkcyBzb21lIHBhZGRpbmcgaGVyZT8NCj4gDQo+IEtp
bmQgb2YgdGhlIHNhbWUgaWRlYSwgaXQgaXMgbWF0dGVyIGlmIHRoZSBjb21waWxlciBhZGRzIHBh
ZGRpbmcgc2luY2UgdGhlIHJlcGx5DQo+IGlzIHJlYWQgYW5kIGV4dHJhY3RlZCBpbnRvIHRoaXMg
c3RydWN0IGxpa2UgaXQgaXMgd3JpdHRlbiBpbiB0aGUgQ01JUyBzcGVjaWZpY2F0aW9uLg0KPiA+
DQo+ID4gLS0NCj4gPiBSTUsncyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9y
Zy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj4gPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEw
TWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0KDQpIaSBSdXNzZWxsLCANCg0K
UGxlYXNlIHNlZSBiZWxvdyBwYWhvbGUncyBvdXRwdXQgYWZ0ZXIgY2hhbmdpbmcgZXRodG9vbF9j
bWlzX2NkYl9yZXF1ZXN0IDo6ZXBsX2xlbiBmcm9tIHUxNiB0byBfX2JlMTYuDQoNCiQgcGFob2xl
IC1DICdldGh0b29sX2NtaXNfY2RiX3JlcXVlc3QnIC4vdm1saW51eA0Kc3RydWN0IGV0aHRvb2xf
Y21pc19jZGJfcmVxdWVzdCB7DQogICAgICAgIF9fYmUxNiAgICAgICAgICAgICAgICAgICAgIGlk
OyAgICAgICAgICAgICAgICAgICAvKiAgICAgMCAgICAgMiAqLw0KICAgICAgICB1bmlvbiB7DQog
ICAgICAgICAgICAgICAgc3RydWN0IHsNCiAgICAgICAgICAgICAgICAgICAgICAgIF9fYmUxNiAg
ICAgZXBsX2xlbjsgICAgICAgICAgICAgIC8qICAgICAyICAgICAyICovDQogICAgICAgICAgICAg
ICAgICAgICAgICB1OCAgICAgICAgIGxwbF9sZW47ICAgICAgICAgICAgICAvKiAgICAgNCAgICAg
MSAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgdTggICAgICAgICBjaGtfY29kZTsgICAgICAg
ICAgICAgLyogICAgIDUgICAgIDEgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgIHU4ICAgICAg
ICAgcmVzdjE7ICAgICAgICAgICAgICAgIC8qICAgICA2ICAgICAxICovDQogICAgICAgICAgICAg
ICAgICAgICAgICB1OCAgICAgICAgIHJlc3YyOyAgICAgICAgICAgICAgICAvKiAgICAgNyAgICAg
MSAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgdTggICAgICAgICBwYXlsb2FkWzEyMF07ICAg
ICAgICAgLyogICAgIDggICAxMjAgKi8NCiAgICAgICAgICAgICAgICB9OyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qICAgICAyICAgMTI2ICovDQogICAgICAgICAgICAg
ICAgc3RydWN0IHsNCiAgICAgICAgICAgICAgICAgICAgICAgIF9fYmUxNiAgICAgZXBsX2xlbjsg
ICAgICAgICAgICAgIC8qICAgICAyICAgICAyICovDQogICAgICAgICAgICAgICAgICAgICAgICB1
OCAgICAgICAgIGxwbF9sZW47ICAgICAgICAgICAgICAvKiAgICAgNCAgICAgMSAqLw0KICAgICAg
ICAgICAgICAgICAgICAgICAgdTggICAgICAgICBjaGtfY29kZTsgICAgICAgICAgICAgLyogICAg
IDUgICAgIDEgKi8NCiAgICAgICAgICAgICAgICAgICAgICAgIHU4ICAgICAgICAgcmVzdjE7ICAg
ICAgICAgICAgICAgIC8qICAgICA2ICAgICAxICovDQogICAgICAgICAgICAgICAgICAgICAgICB1
OCAgICAgICAgIHJlc3YyOyAgICAgICAgICAgICAgICAvKiAgICAgNyAgICAgMSAqLw0KICAgICAg
ICAgICAgICAgICAgICAgICAgdTggICAgICAgICBwYXlsb2FkWzEyMF07ICAgICAgICAgLyogICAg
IDggICAxMjAgKi8NCiAgICAgICAgICAgICAgICB9IGJvZHk7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC8qICAgICAyICAgMTI2ICovDQogICAgICAgIH07ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiAgICAgMiAgIDEyNiAqLw0KDQogICAg
ICAgIC8qIHNpemU6IDEyOCwgY2FjaGVsaW5lczogMiwgbWVtYmVyczogMiAqLw0KfTsNCg0KW2Rh
bmllbGxlckBkZXYtci12cnQtMTU1IGxpbnV4X21seHN3XSQgcGFob2xlIC1DICdldGh0b29sX2Nt
aXNfY2RiX3JwbCcgLi92bWxpbnV4DQpzdHJ1Y3QgZXRodG9vbF9jbWlzX2NkYl9ycGwgew0KICAg
ICAgICBzdHJ1Y3QgZXRodG9vbF9jbWlzX2NkYl9ycGxfaGRyIGhkcjsgICAgICAgICAgICAgLyog
ICAgIDAgICAgIDIgKi8NCiAgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgICAgcGF5bG9h
ZFsxMjBdOyAgICAgICAgIC8qICAgICAyICAgMTIwICovDQoNCiAgICAgICAgLyogc2l6ZTogMTIy
LCBjYWNoZWxpbmVzOiAyLCBtZW1iZXJzOiAyICovDQogICAgICAgIC8qIGxhc3QgY2FjaGVsaW5l
OiA1OCBieXRlcyAqLw0KfTsNCg0KW2RhbmllbGxlckBkZXYtci12cnQtMTU1IGxpbnV4X21seHN3
XSQgcGFob2xlIC1DICdldGh0b29sX2NtaXNfY2RiX3JwbF9oZHInIC4vdm1saW51eA0Kc3RydWN0
IGV0aHRvb2xfY21pc19jZGJfcnBsX2hkciB7DQogICAgICAgIHU4ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJwbF9sZW47ICAgICAgICAgICAgICAvKiAgICAgMCAgICAgMSAqLw0KICAgICAgICB1
OCAgICAgICAgICAgICAgICAgICAgICAgICBycGxfY2hrX2NvZGU7ICAgICAgICAgLyogICAgIDEg
ICAgIDEgKi8NCg0KICAgICAgICAvKiBzaXplOiAyLCBjYWNoZWxpbmVzOiAxLCBtZW1iZXJzOiAy
ICovDQogICAgICAgIC8qIGxhc3QgY2FjaGVsaW5lOiAyIGJ5dGVzICovDQp9Ow0KDQpJZiBhIGZ1
cnRoZXIgZml4IGlzIG5lZWRlZCwgeW91IGFyZSB3ZWxjb21lIHRvIGxldCBtZSBrbm93Lg0KDQpU
aGFua3MsDQpEYW5pZWxsZQ0K

