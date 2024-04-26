Return-Path: <linux-kernel+bounces-159928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00888B3664
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6959A1F223BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80278144D2E;
	Fri, 26 Apr 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bmNZDAv5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bmNZDAv5"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E21448DA;
	Fri, 26 Apr 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129922; cv=fail; b=TWs42HsPly+5nUs7WUGR51ugqkNqMKaELV4k9yGQISjFnF5vbMRxjv/AosVBPXoYFGlSXprmEnaj38TeAXW8ZWKIMSZt2YC6M/qGkYMLsMIE7c+zvvFdJVUTJox7b3AWCmzGaQYO5aum+jOdvLVEo1rlJQzm0/lxbZbteCu2H9M=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129922; c=relaxed/simple;
	bh=pM9yB6hjtAbRmnQKz47Dzxlg23g/F9IQ1X//iH4Pk54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glVoQnY/c9MEb70f9Qk59DkYZyYqsHH1RO4HR/MRvjdCHNfPu9w+CXmOwlR6fdfLJh5SNbXOBfXpmA4ky7k8/v+2HcKtIzrJ6vhpnQdhBDoMkIZ854aE9kCLnGZ9Kee9/BZxA200x3kt9H+Bd23yu1ZkLPxRLGaZnRcOMw5ymiI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bmNZDAv5; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bmNZDAv5; arc=fail smtp.client-ip=40.107.13.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=luNG2mJ4y/s72mGW8+5x9Io+nJRltfOECvBSQPo4uLZFLR23Y8qhIRh9yCV/e7xa/iuDTZ4YHh9XH7BwMX0I4XAu/9BPHp1R1N/FyLY+PtsFFSQ5GM+pEH5CXpuyJuJyV+0t3mlzmxaFsRPh2zUkBneHf/8agPJ9FjRJwlL/1Oig2y6O9Rgq+rTNr0euL1p1idPED1xxQ487wyMrIzUDon74wAQnrFkO3IyvB7s6crawvP7YlBgjF6LVFkL2Kkf5nPEm/59E5bw8QAH/umLj8NgqkRVjVT3qyXOcmyuJe9Xd2L/WdgthAj0jg50eI90etx6r/wSnYlbicmNgnU79tQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM9yB6hjtAbRmnQKz47Dzxlg23g/F9IQ1X//iH4Pk54=;
 b=OgRRtNpihUJ6C43JXGwE4RMzRBSrzJLh8hJG4nGgFD1qr0eyoniG9vgiN5X/zcRs+K7bSJK7mlxla6Ff8D8x9SnAYK3mx9aOs8DnO/RzDdiSdH12+qNvEvG8rGJZO2RHEfukOw02CObUmmhP7aOlIxh4L2Tyxp38V1ib1d2VAoowT/T6eoxTM4z8tfdrlUXOZF5Tx+nW5miMVmuSB6wVjozmNXH723CAryc3imHT8qWi+enlV7TZgklHMd9/KiuteBpyGZ6vTD+hOzP5KIMMYdJKAE6i3LSez5HdsBFzoil9Rwt6+XMhxEaeKmge05qB2Hq6JXNQbF6EL1RS/YFi6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM9yB6hjtAbRmnQKz47Dzxlg23g/F9IQ1X//iH4Pk54=;
 b=bmNZDAv56TnQGYaX+N3Fj9dUuDD0qVrXp0gVm8lmtFEhOw0u8QXlUa7/HLnFAlg+QzNJmxWr/JECJqyK8MyN5UyOnXzH5zpXLVE/LuZyG6M73LV27Da9jJlEAh0MUnmXe98nsi1RtlM0lrgNu67o0VXXICu2U317933U6R8Detc=
Received: from AS8PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:20b:459::32)
 by AM0PR08MB5505.eurprd08.prod.outlook.com (2603:10a6:208:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 11:11:50 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:459:cafe::fa) by AS8PR07CA0054.outlook.office365.com
 (2603:10a6:20b:459::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.11 via Frontend
 Transport; Fri, 26 Apr 2024 11:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.19
 via Frontend Transport; Fri, 26 Apr 2024 11:11:49 +0000
Received: ("Tessian outbound ba75727f6dca:v315"); Fri, 26 Apr 2024 11:11:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 47514de33016a5a7
X-CR-MTA-TID: 64aa7808
Received: from 915da33fab9f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 15D0512F-4ABF-41E1-971E-B823D5E71343.1;
	Fri, 26 Apr 2024 11:11:39 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 915da33fab9f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Apr 2024 11:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/sLI0iWobmWDJMJol26N3IbAUSmhGr7BnR+UClMAM1yfq1xp7OGQllHGNMJ7PVPJ1o/KkTRJoGir+hETJIWidcl/nKCuNN9L+grPwTs/JibBYQIi7/RowVYXli/UKO2fijmPY+I3hhOyVU3RHR+OJJ0lOHF+Jp26dbppUfOA9tDZTfsbnuv0wmbm4vj1XaohPccWw8o5Ox7xLkWaE8LX+WwKRpDb3WE0zfzV03ckKTpGEtWavtNHRoSfNO/B3Y+H9ypvXTzkEnSez7iC2QZP5Y6HThwxSL7XYGc37OmXvpytSBPGoo3CwRY+mReyzLt9hSntRlDjHNhKdfSBpza+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM9yB6hjtAbRmnQKz47Dzxlg23g/F9IQ1X//iH4Pk54=;
 b=cqeZOWyaTEbCH2Ak4yAxYiIj9sadek1ZOWeSNKI9IupOupn6aHCwH/obLN1Wfrq7466vJ6xJilK5zCvGK1TLaQjvBl1HhNf2lcTUJGMAUPd5iaFlVstGGdajGWnAN4DF0ycWCehIVmXRhrBZwAma7ly5nhhIFJHAJjN6kphNKuLRcxeRpaclF/reM/nF7B83luXDb2tRleiLM/Hmoo/F/2zAAgGHlSf2Dp5kBeh2eUsLPF75rH09BAukKtI9XXVeRmsu2Clk4PICPey47mx5pgWHEKFupXsPXgbO5ohUtp94ECQwD7uMVJ4RXhlRBLd6vjNwzSsNwYLqYJVWSw/qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM9yB6hjtAbRmnQKz47Dzxlg23g/F9IQ1X//iH4Pk54=;
 b=bmNZDAv56TnQGYaX+N3Fj9dUuDD0qVrXp0gVm8lmtFEhOw0u8QXlUa7/HLnFAlg+QzNJmxWr/JECJqyK8MyN5UyOnXzH5zpXLVE/LuZyG6M73LV27Da9jJlEAh0MUnmXe98nsi1RtlM0lrgNu67o0VXXICu2U317933U6R8Detc=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by PAXPR08MB7490.eurprd08.prod.outlook.com (2603:10a6:102:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 11:11:36 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::9d7d:90fc:df7a:a5a6%4]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 11:11:32 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "ak@linux.intel.com" <ak@linux.intel.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, James Clark
	<James.Clark@arm.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "will@kernel.org" <will@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v2 0/4] A mechanism for efficient support for
 per-function metrics
Thread-Topic: [RFC PATCH v2 0/4] A mechanism for efficient support for
 per-function metrics
Thread-Index: AQHalKLU1TQf89YFfUas3HRNtUjHP7F2AHsAgARrPAA=
Date: Fri, 26 Apr 2024 11:11:32 +0000
Message-ID: <b0580124d8916d523afb98979a24f8108b0e700a.camel@arm.com>
References: <20240422104929.264241-1-ben.gainey@arm.com>
	 <ZifW8rZk41t4ukIV@tassilo>
In-Reply-To: <ZifW8rZk41t4ukIV@tassilo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.0 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|PAXPR08MB7490:EE_|AMS0EPF000001B7:EE_|AM0PR08MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6370cc-e7e9-4cf0-540b-08dc65e1ab6c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?LzQ1OHJGQVhieWJqTnlic3JzSXF4TVVJY245WVdDRnpsL0R2b1VFZGhJR2dG?=
 =?utf-8?B?eVF0SElxbjhZbVZIVVV4Q3EvWXduT0ZCU3NiQUFCNHg2OGp5OWRJL2kvR2RN?=
 =?utf-8?B?cU83SDhIcmtWUGJlTGlDVmlYNit3SkFDaDlBWkliTCtyY083Qnk3SkNIN3Fo?=
 =?utf-8?B?VkljMzh2bXU5TW5EWDVwcXFyMHBNMjI0c2Q2bTNPMzF1b2Z5TnkwTTZ0U0ND?=
 =?utf-8?B?TklDMWNEUzB1eWJld0M2MmtzMWs2OTVwbGRUWHFlUTdRQ3dJc0g1WkJjajAx?=
 =?utf-8?B?SXEwWnRwV3dJUmNNblR3RzFoSnY4K0NCaXk0cXNVaG5JM2Z2Ly94SC93cDJu?=
 =?utf-8?B?WTI3SGtFTEkyYnRPSndkWVZ0WC9NRnFsdE52V0RZL1lDYzJSajFpbGkwSkoz?=
 =?utf-8?B?Nk9neWhyMFQybmlHYUl3QnZkUUV3SXAzNnQ2bjdTWE0yQzZXbVJxbkpnN2pH?=
 =?utf-8?B?ZWYyVXBxTWxWdERqS1lnSWZVZGErc1lraUJYbGZLbDFQOUVaWVlMR0RQNWxM?=
 =?utf-8?B?MUY0YzJ3KzNLd1ZWL2dqNUhtU0xUa0VUMWdoMjg2VVJHVUFoVlRSU3d3R1Jm?=
 =?utf-8?B?L21UanRvZUN1dTYrTWMyUXl2Q3Jrekw4MjF5NjFvazBFaGw5SXpOLzBBWDNk?=
 =?utf-8?B?ZkZubDFiU0NBLzJWVXhqWVkvQ1NaTDJteDF5MWp1Z3dmQ0NtVmM5ZkFYam5P?=
 =?utf-8?B?OUpPdVZxZ0lEK2U4U0ZsYXB3OXI5K2hmcWpSdml1SGo5d1d3bUdSTU9pQm9h?=
 =?utf-8?B?WmFpN1BIbzlGQTNZdnBTUFJ3bGxXUTNURlhCcmtRN3ZtUVpKUnR5Tnl0cG0v?=
 =?utf-8?B?Y1FlVysrZUNWQkFtQ2tYTmd1WGpUWHJJbEwyTTJ0VUFTaCs1aGdNM2tUdThq?=
 =?utf-8?B?MGZYd09Rdnh0NHFLR2pHb05rcG9CMS9SOWFCTkw2aUVLUkhKaTdGbUFIc1Ny?=
 =?utf-8?B?V2RlWTNqNThrNmJkOWZweXZ4SkRCM3dqTkZKUDJ3OTR6ekU1UWpld1JML3BJ?=
 =?utf-8?B?OEVJb05VRUVSYWw5bEpNano1Mit3Mk5OY3BsQ0Z4K3pIZTM4bVZXek1hb0V5?=
 =?utf-8?B?QjRvVGo2N01LaEcyME5wYk1qdTIyWWtCMURjWFV5bk5qNlgwMHlubFNmYWVj?=
 =?utf-8?B?RGV1YlJqbEIyUmJ5V0dWbktFMXZXMHpIMnUzU2RIRnRmaHJ4ak4vZXJoZzhU?=
 =?utf-8?B?bUE0Y1NhTnpRZlQyRjd2dXFvRFFZZFFwTGxJRWdpby9ReDNQYjRMTTJlWDNB?=
 =?utf-8?B?K0J3dlBtcTgyYy91SlRMSGh1RnBBYzcyRnIrZk96RHA5NUpINm5MMUp3aUht?=
 =?utf-8?B?ZGZKYkI2eERaYWJ0UEVBNHVxdmhCY3lyUnIzWlYwUlJYazNlcHRuQmRyVVNk?=
 =?utf-8?B?SHJEdFRyUHNrZjJYMXRZQkZSemo2VUZLZG1yK2djbWxtaUVOZjhYdVV4RVMz?=
 =?utf-8?B?ZEVFNStraFRwZElLdncxVzlLWHBzMURLRGN6eUdkZzYyOHlDajFob3FpYTVR?=
 =?utf-8?B?Q1cyWDBsNC9TYUpLdStZcXZjajFxenFhSTE5My9pd2NQT29HOWN4akdaUnRS?=
 =?utf-8?B?S3FubFUybGFScTlEUklzSW45MHgwTHo2VmJHck5VQ25jclZNL1VtK2k3Ujc0?=
 =?utf-8?B?OUxCTmlaUTZTNFJMbUttU3YxdVJwL1lVZEY2bzhqMzhlR0paZUpzVGRCS1pF?=
 =?utf-8?B?VlVoSTA3a0FQbEtFWkIwV1lsR3lWeDFiOEg2VkJGUWt6bksrMFdsS0dFZXpQ?=
 =?utf-8?B?RmxEMDBiL3hmOE5UY1BwVVNsSVFJNlB5Vm5yTXVVY3VqU1lOLzgwSHdvZEpM?=
 =?utf-8?B?SkNGakJKaU9FR2t3ZE5Mdz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <024EF7EE505A6648B01CD558037FD8EA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7490
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a1eada8e-35c8-412e-6679-08dc65e1a155
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJHbUE2QTluUWpMS0hpUlBqVVBuY3lBWTZROEpyNHNnNGovbUNVb2VmS2Vl?=
 =?utf-8?B?d0RnY0pLZ2M2NUtjaUhocVF3dm1BeDdDQ0JRT0kyV0w1SWdGN3RWMGJMeW5D?=
 =?utf-8?B?cFZCcEl3dlBXa2NGTkJmWmlUK1lkaERwRnExMlVJNFZwUytHQmxrenVkRFlF?=
 =?utf-8?B?ZVpaT0xzMUc1Q2F1RjRHQzI1Um5hcmhqalh4UHRWY0JMcGxsSmRQRDNHd2Yr?=
 =?utf-8?B?azM4RzVGNGdTUWFIYk9iWUdlcVNCbzFOdThKTEozM3BIdG85aldnZXArRjhC?=
 =?utf-8?B?WnFzOHFQWE5PQ1dOTVBBcnJlUFU5UGM0ZUhmaytRcUI4ZnRpbzdkdU1WM3M1?=
 =?utf-8?B?c0pzMGQzaFIrT2ZSemFuRlhnNXpvNS8vQU1CYUtCaFBkZUJsNEwxV0dPbTJI?=
 =?utf-8?B?ZmNPWlhMTmhNZkkvZFhMV1hOZnlEcGxoVDljcG1UYk1zc1EyN0c3SVJlVWVk?=
 =?utf-8?B?TmZiVUdzanA2cExSQjRETlN2TXNoUXdMVVkzcnR0UXB3ZWdYdnBZSGNxKzFT?=
 =?utf-8?B?N3ZnajFLcmt0U0pBVTRzT25oV1FzTVR2MXIrTXRSdC85TW9KS2EzTnZBVzYz?=
 =?utf-8?B?NGtpMzhQOGFSRC9YUUNvMURuN3B5cHhWSytwV3hZWnlucG14eEVCZ0ZtM2Mv?=
 =?utf-8?B?b1ZzV2JVRFVJSHFjVjYxaGEvejBXVXFMc2RCcWQwa203SWM2bWFSditIS1FL?=
 =?utf-8?B?NHBvNHI4V3NRRjd2MVdtUm0wa2o3K1Ntd0dwVkJOOXIwVHljN28xTUlsWU52?=
 =?utf-8?B?cXhtQUFhWGlQRERZL2ZXOHVjdkNQWGtpbHhpbEU4Q1craWFNMitCSXc5bmxR?=
 =?utf-8?B?aXhlTVZSZWJXaWZEM2YzTkJqd3pncVk0cERTSlB6aDFuSmhkSndmMGZKU2FF?=
 =?utf-8?B?TTJXcXhmZVdGOTNlQnZNUFJVK3JXTldHem44OXloNTgyUFVhaFJncjFzMnF4?=
 =?utf-8?B?bGhubXdCSXpHQUhPcEQ0bVh4Zi9Jb1VqbmY1M0s4SjloOUtsZ0x5aEZ5QnAx?=
 =?utf-8?B?TjFhRmFtTGVBQ0lvVEhZRVdMdWdzemQzbDc2UWxJUnJmd2JWSlpQRWlwc0sr?=
 =?utf-8?B?dWFYc0VqVFNmQndKREorYWVrSm9lR2svbTlRbUxxTnZqbjM1M0E4Q0ZicWZP?=
 =?utf-8?B?U2s5S3dzbGFyWTF3NkpMZ3p3VEVNOEIveXJIN056SlVyQzM2S0NTaUNYOXFa?=
 =?utf-8?B?TzB5UmhLV2xROHl6VTFRQ1FqbElMRnAvMzhlcjNCMkZWeWI0NHNMQWJmZXNO?=
 =?utf-8?B?RFJKdUlBUGxsdGNDejlLbVA2REREb1VjUWFRR3hueVBxUzRTenVWSERISE1u?=
 =?utf-8?B?WjZQTUxsaCtSaEhMQnY0b3RoWmxNemhPVHc2WlpGa0ZsZlV2eDZxZlNOYjRY?=
 =?utf-8?B?enN4aTQ1UHVUTjNCbnJNUW9ZMktaV0tjMG1YTENpelNSazE0WGhzeCtmcGM5?=
 =?utf-8?B?V2RwV05TMGVYS3kwS1l5QWkvSTFZVHEwNEpuMk1hYmMvd0xyQk5yMFBqam9x?=
 =?utf-8?B?MktVOXQ4a2RHK2NzZXZlNFdDanVqMGV0U2laMnh4bU5qUlZReGhTaE9aM2Ry?=
 =?utf-8?B?NWJNVTdpQnoreXZ5QXkwQlphbElsenhrcHNpSXZMOUdONldUQTJxZXRncDNo?=
 =?utf-8?B?S3dUaVZuTVhCV3VRQnAxUDJPTC9ULytENERteDVPTGhsN0J6MXpSSExhOURJ?=
 =?utf-8?B?OHFWcWtVT2o3dEc4Zk9kellBUHlNdEF3U3ZaMnMyRXR6MHhUVnpqVGs3bEdE?=
 =?utf-8?B?S1RaZURDMzVScmgrbHZRS0FIaWEwU21qcTV4bHpyYmk5a2RmbVplZFBjSVZP?=
 =?utf-8?Q?/uQCbrLuHxaU9TDcypfLDbpRksdeR4tNK7bc0=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 11:11:49.6880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6370cc-e7e9-4cf0-540b-08dc65e1ab6c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5505

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDA4OjQyIC0wNzAwLCBBbmRpIEtsZWVuIHdyb3RlOg0KPiA+
IEN1cnNvcnkgdGVzdGluZyBvbiBhIFhlb24oUikgVy0yMTQ1IHdpdGggYSAzMDAgKmluc3RydWN0
aW9uKiBzYW1wbGUNCj4gPiB3aW5kb3cgKHdpdGggYW5kIHdpdGhvdXQgdGhlIHBhdGNoKSBzdWdn
ZXN0cyB0aGlzIGFwcHJvYWNoIHdvdWxkDQo+ID4gd29yaw0KPiA+IGZvciBzb21lIGNvdW50ZXJz
LiBDYWxjdWxhdGluZyBicmFuY2ggbWlzcyByYXRlcyBmb3IgZXhhbXBsZQ0KPiA+IGFwcGVhcnMg
dG8NCj4gPiBiZSBjb3JyZWN0IHdoZW4gdXNlZCB3aXRoIHRoZSBpbnN0cnVjdGlvbiBjb3VudGVy
IGFzIHRoZSBzYW1wbGluZw0KPiA+IGV2ZW50LA0KPiA+IG9yIGF0IGxlYXN0IHRoaXMgYXBwcm9h
Y2ggY29ycmVjdGx5IGlkZW50aWZpZXMgd2hpY2ggZnVuY3Rpb25zIGluDQo+ID4gdGhlDQo+ID4g
dGVzdCBiZW5jaG1hcmsgYXJlIHByb25lIHRvIHBvb3IgcHJlZGljdGFiaWxpdHkuIE9uIHRoZSBv
dGhlciBoYW5kDQo+ID4gdGhlDQo+ID4gY29tYmluYXRpb24gY3ljbGUgYW5kIGluc3RydWN0aW9u
cyBjb3VudGVyIGRvZXMgbm90IGFwcGVhciB0bw0KPiA+IHNhbXBsZQ0KPiA+IGNvcnJlY3RseSBh
cyBhIHBhaXIuIFdpdGggc29tZXRoaW5nIGxpa2UNCj4gPiANCj4gPiDCoMKgwqAgcGVyZiByZWNv
cmQgLWUgJ3tjeWNsZXMvcGVyaW9kPTk5OTcwMCxhbHQtDQo+ID4gcGVyaW9kPTMwMC8saW5zdHJ1
Y3Rpb25zfTp1UycgLi4uIGJlbmNobWFyaw0KPiA+IA0KPiA+IEkgb2Z0ZW4gc2VlIHZlcnkgbGFy
Z2UgQ1BJLCB0aGUgc2FtZSBhZmZlY3QgaXMgb2JzZXJ2ZWQgd2l0aG91dCB0aGUNCj4gPiBwYXRj
aCBlbmFibGVkLiBObyBpZGVhIHdoYXRzIGdvaW5nIG9uIHRoZXJlLCBzbyBhbnkgaW5zaWdodA0K
PiA+IHdlbGNvbWUuLi4NCj4gDQo+IE15IGd1ZXNzIHdvdWxkIGJlIHRoYXQgdGhlIFBNSSBoYW5k
bGVyIGNsZWFyZWQgTDEgYW5kIHRoZXJlIGFyZQ0KPiBzdGFsbHMNCj4gcmVsb2FkaW5nIHRoZSB3
b3JraW5nIHNldC4gWW91IGNhbiBjaGVjayBMMSBtaXNzIGV2ZW50cyB0byBjb25maXJtLg0KPiBV
bmZvcnR1bmF0ZWx5IHdpdGggdGhlIHBlcmlvZCBjaGFuZ2UgaXQgY2Fubm90IHVzZSBtdWx0aS1y
ZWNvcmQNCj4gUEVCUyB3aGljaCB3b3VsZCBhdm9pZCB0aGUgbmVlZCBmb3IgYSBQTUkuDQo+IA0K
PiAtQW5kaQ0KDQoNCkhpIEFuZGksDQoNClNwZW50IGEgYml0IG9mIHRpbWUgbG9va2luZyBhdCB0
aGlzLg0KDQpDb21wYXJpbmcgdGhlIEwxIGNvdW50ZXJzIGFnYWluc3QgdGhlIHZhbHVlcyBmcm9t
ICdwZXJmIHN0YXQnIGRvZXNuJ3QNCmFwcGVhciB0byBzaG93IHNvbWUgb2J2aW91cyBjYXVzZS4N
Cg0KSSB0aGluayB0aGlzIGlzIGp1c3QgYSBxdWlyayBzcGVjaWZpYyB0byB1c2luZyB0aGUgY3lj
bGUgY291bnRlciBhcyB0aGUNCnNhbXBsaW5nIGV2ZW50LCBhbmQgaXMgbm90IHJlbGF0ZWQgdG8g
dGhlIGFsdC1wZXJpb2QsIGFzIHRoZSBhZmZlY3QgaXMNCnByZXNlbnQgZXZlbiBvbiBhbiB1bnBh
dGNoZWQga2VybmVsLg0KDQpUaGVyZSBhcHBlYXJzIHRvIGJlIHNvbWUgbm9uLWxpbmVhciBpbmNy
ZWFzZSBpbiBDUEkgKG92ZXIgdGhlIHNhbXBsZQ0KZGF0YSBhcyBhIHdob2xlKSBmb3IgdGhlIHNt
YWxsZXN0IHZhbHVlcyBvZiBwZXJpb2QsIGUuZy4gZm9yDQpwZXJpb2Q9MTAwLCBDUEk9fjQ1MDsg
cGVyZiBzdGF0IHNheXMgaXQgc2hvdWxkIGJlIH4yLjUuIE1hbnVhbA0KaW5zcGVjdGlvbiBvZiB0
aGUgcmF3IGRhdGEgd2l0aDoNCg0KICAgIHBlcmYgc2NyaXB0IC1GIGV2ZW50LHBlcmlvZCAtaSBw
ZXJmLmRhdGEuMTAwDQoNClNob3dzIHJlcGVhdGluZyBwYXR0ZXJuIGFsb25nIHRoZSBsaW5lcyBv
ZjoNCg0KICAgIGN5Y2xlcz00NTANCiAgICBpbnN0cnVjdGlvbnM9MQ0KICAgIC4uLg0KDQpUaGUg
YWZmZWN0IHF1aWNrbHkgZGVjcmVhc2VzIGFzIHRoZSBwZXJpb2QgaW5jcmVhc2VzLCB3aXRoIHBl
cmlvZD03NTAsDQp0aGUgQ1BJIGlzIDwyeCAodnMgcGVyZiBzdGF0KS4NCg0KV2hlbiB0aGUgZXZl
bnRzIGFyZSBzd2FwcGVkIHNvIHRoYXQgdGhlIHNhbXBsaW5nIGV2ZW50IGlzDQpgaW5zdHJ1Y3Rp
b25zYCByYXRoZXIgdGhhbiBgY3ljbGVzYCwgdGhlIGFmZmVjdCBpcyB2ZXJ5IG11Y2gNCmRpbWlu
aXNoZWQvZ29uZTsgYXQgUD0xMDAgaXMgc2VlIGFib3V0IDMuNXggb3ZlcmhlYWQgKHZzIHBlcmYg
c3RhdCksDQphbmQgYXQgUD01MDAgdGhlIG92ZXJoZWFkIGlzIGFib3V0IDEuNXguDQoNCldoZW4g
YWx0LXBlcmlvZCBpcyB1c2VkIHN1Y2ggdGhhdCAicGVyaW9kPSQoKDEwMDAwMDAtJFApKSxhbHQt
DQpwZXJpb2Q9JFAiLCB0aGUgYWZmZWN0IGlzIHVuY2hhbmdlZC4gDQoNClJlZ2FyZHMNCkJlbg0K

