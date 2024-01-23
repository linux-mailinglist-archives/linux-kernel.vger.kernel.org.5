Return-Path: <linux-kernel+bounces-35229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FC838E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CFFB21F34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D05DF0E;
	Tue, 23 Jan 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b88dfteY"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAB14A96;
	Tue, 23 Jan 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011723; cv=fail; b=uB7Aec2ADq7+NCAmXZXvzJO9fO4L6rbVTQ3h5h0MY5B7aE4Rn2CR6tXQIsjWog/TtnIwPtl7tQ6y0Vb/Rqwhr077Pzx5YLK56TEx4ypqASu86ZaFS7ekLwXMbkMjG8HdR84to1dRPAfcs1bMfqFg7ofi67NZ+rIoz/f22TLoTLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011723; c=relaxed/simple;
	bh=wrbC6et2U52n8l5E9onDFYPfd7efqVlBviIxkAk1lFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RFme1RfPDTR7/ZAofZiS6lbbT7PW25d8kAKH9XNTk7rruldtx5i7skyk1BK+l/9TKfDl3ENHkMuwcmwGKUpFLnlDO5QGKjzQQZqxRz6ZxJXLG3QkE4b6X26St8Zy2fbyAxGFIdtpZbna9zq8ptiA71cqy01XJmu6pZ0t9VZA5y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b88dfteY; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkOGfGI6Y784G67WB/ZjOKU/F57m24lh4jdaDA4x2JXRNEBPn6gVAoMTDmmNgk3xyhw62wkgCPjeXYscIusI27GSk13JW2E6AXhHgbnpkJAShEAeu/8tTrDbfPcq5D8y1W9i1iasNj/rD4oW89cGz9gyUXVVlyIFlR29ma6Yd/rKF0ygDZ2YGkfDi5q82C5jShAn5qE+RBYSdz82w4P2PnQ3hdyBomh/i3RJyg6FXYBKStYuzVQrHHVNtJNnF+UX0lQ7wqxgdTjugv28gDRNeifbZP1UZvsw/5sXkcR3hISGg71HLF/Vo3n4TA3/OD9nDgCRNBfr2bAjIOsFHMEDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrbC6et2U52n8l5E9onDFYPfd7efqVlBviIxkAk1lFs=;
 b=Dm5abzNZ18FakzfjvdMWTumFsDK9NMgLsTNPu424fWvSw5X0T/sPQp0dW8K1F8rWZoXF28EbePhhG+uWX1Vb9E/VtFvCGPirG0zrTQxNrgnbozjQEDmhGsrCIbSUDA96UHsmCoWr3L/Dj4b6re7MPRV/3l8j1SKAVdj9FwFl1sih1MrgEDz/JbPDEfyUEisnqsJ5CODFiIkRZyl5X+IlkZP4WnfdvhG1Az6IgnosrizXLd4ZMcgCcMy/MDxquE8Hu7ynb8uOW9kjbki68UemoxKBnifJFKOK8sv/wayLWrCspyxmCy8VHOxq7V1uHgLnbMzHCXYQavznTSU5DXgiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrbC6et2U52n8l5E9onDFYPfd7efqVlBviIxkAk1lFs=;
 b=b88dfteY8WebwyiVuUERwbUDSpj4NONlQ1EedF5PbT3hr/hE+WXGGIe22vcCTmFiSdct/ip9IP69rmH22J1rKQultdAT6v1bdCYnZ1hr5lTxcj/Kyl74yEHWD8xwZAYu8axGYtJAyMz1OIqIuMn4py4QYScsI6HaA0dij74HngqMS9KG77sYwFEoXolifZK+zZhocGRo82pNmXZx4XtUzYy3TLdR/B3XsUMRS/vW9dJ7KZtv/SZEPiAa0KV25NHT44ObKWbq787FljTMb9q6fMA2kRcrf7Ami7nQutrbIVRl13EYjQHb3kSgfkVQZzV17Ac87eeAESYlyKWm6gMqng==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 12:08:37 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::fa7e:d2b7:5f80:2dd4%5]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 12:08:37 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
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
Subject: RE: [RFC PATCH net-next 8/9] ethtool: cmis_fw_update: add a layer for
 supporting firmware update using CDB
Thread-Topic: [RFC PATCH net-next 8/9] ethtool: cmis_fw_update: add a layer
 for supporting firmware update using CDB
Thread-Index: AQHaTQ+JuBaUr5zIUk25fyEO1jnyhLDm05uAgAB74VA=
Date: Tue, 23 Jan 2024 12:08:37 +0000
Message-ID:
 <DM6PR12MB45169D3312CEF3324B95B1CBD8742@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-9-danieller@nvidia.com>
 <20240122204435.5a72b485@kernel.org>
In-Reply-To: <20240122204435.5a72b485@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SN7PR12MB7855:EE_
x-ms-office365-filtering-correlation-id: a232e561-74e5-4551-a12b-08dc1c0c07f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q875LooBo98/oBKTf3Qn8LJdQbN88fTJy7sJwkrV0V+L1a7PdA0/KDwk4y99mvvt/dlIGV8ZLTGUOPjrG/tS6nx9CzqSYwBJ9jwmt2XPyar5EX8veJiPX+ivbpV2vYgAdIqeDfLwUQ9yup/w1WN5mCZyriI2pMbtzyvLKtJFhIVLyQNAHzqvaC4Naekz/B0fqjmY7qs+IxBthAfU9czW9P1TBEWVSqRmVADn3orO0kDviecvRQeRfiiS3vIUqSThedXYnqCJX+NwiRLZYMgORAdq0rDjyz+8bP7PiI2UaRjMgCRuW9736LMYVxd9gNxPLuPuIuYOsMb3aD2ehtCSl19m+0P87neLBXdhpepbH8teb8qO9v9BYlnYPPVFjO5/sXXthLP9dyoTEEVMdBHrXwYt3DUtgm7XLlEQWvQUfMED/sMfGHEltReAjc4O7CYm2dcqZoR8j7G06SKLWHFCtTSW/Sna+QC0/rPqRL8cIrUugagXRpKVgvV7un6dZbZOn4R1gZhct7KQy/NnsVr2BEbCBoYbePUR7q4mrdgJDJ0Vm+Vuul9ZgSDSgX8+kJe2aY4sXpOwPNyaGScc2y/Qu8D4I/FQ2rqeNbic9aetiQnwVWEJQSSCnP2u3Z03NYJx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(83380400001)(76116006)(33656002)(41300700001)(38070700009)(86362001)(38100700002)(122000001)(26005)(107886003)(9686003)(7696005)(6916009)(5660300002)(478600001)(66446008)(2906002)(66946007)(66476007)(64756008)(316002)(54906003)(66556008)(6506007)(71200400001)(8676002)(8936002)(4744005)(4326008)(7416002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnUwbmlWam1RcTR0RUdPSkx2dkw3UGhYRlIzV2xKY3NLQmdlQVU0MzZXYVdz?=
 =?utf-8?B?Z25iTVRMYVp0OTM4TzBPVUtIMk9QS2hQRWN1K1ZMMXhFVzV5blY0TGwxVyto?=
 =?utf-8?B?dXh1L2JOUFF3a2JYNi9nYlZ6YTN1RUZrWGh5ZDBGK0VTb3BVYmJuREx6cE5Z?=
 =?utf-8?B?akp1NUhxUkZFREJ5Y0txc0svTXNrR3lQWmVMSExnU2dISVJqaUZOUVM3aVBE?=
 =?utf-8?B?SXI3dlBvbzFlTmwxeUVVbGY3ZEhNMHRTVUVwSmJXTW9ITnNZT1RaeWYwMjNa?=
 =?utf-8?B?dEYwYUJPZVF1Nk9ST0RQU1hDSk9XS2tGbU1JNWdON2dua3lhTnhFRkh1RHBL?=
 =?utf-8?B?b0pYdU1MZWlPR1NXWWR4OWlKRENnODd6c3Jxa0E0SDZCNDRodkpERWgwQUFI?=
 =?utf-8?B?dkIxOVdaSlhDTjVJOG9yR1J4TzhqT21BM1ZIV3NWUW1JVm1PcmpZdXdWQ3Ur?=
 =?utf-8?B?dVRtSlUwRmplSWVvb3lSL2doQVBOUFoyS08zVVR4MUpwM1V4M2ZjZXNIcThy?=
 =?utf-8?B?L2s2azdQT1djZWoxVFhBZFBJVWlnc2kzNmk3aWFGdUFJdUJXajlyRk1NVWZZ?=
 =?utf-8?B?NjJmZ1BHMDlFdzZxcHRNak40NDhVN0J4UDU1enBNUzBSNWg4NlJGNjExMHg0?=
 =?utf-8?B?SEtSd2JVeldFNXZXTEVTMUJpUlVLeFVvTWdkdUpVU1ptZ3JNQTB4T3NqM0hY?=
 =?utf-8?B?MHRjZHpXT0JHbklBaUtxb1V4MWphTnJ4bVFRVkliU1p4RW0ybHZSNzdiR2F3?=
 =?utf-8?B?Wi9RbGs5NFNGMnVVeGpYTFZhblduM3hNUkR2a1phZWNQRnNjYmF1Z01ISkc4?=
 =?utf-8?B?bkpLRjdOWjZjbytnZmxDRVpTejVSWXVEQ0hOUGRaNFEyYUVyMXVOMmJMNFNK?=
 =?utf-8?B?RlgybUtad2htRkZtUmlBbVVCU1Y3RmNrOU5DZWNVNDhXL3V4Qk1GcGxSbkp6?=
 =?utf-8?B?TUd2RlczRU95Y3Z0ZGE2bmRBQUc0a2R0K0FGOEQ2WnBzeE51VjJSWkJZb21E?=
 =?utf-8?B?eEZXRGJOdkFZZ3N6VkNjOFdFemtDZzFWOXpKcG8rZXhtZitaSTJ5UkJza24x?=
 =?utf-8?B?MGtkT0tEK1pPMEFtRUJUVkJ2ZkpYdVF2UUVFaGo1QkJqVU00WEsvS0x2aWJn?=
 =?utf-8?B?Q1kvUHJiQjN6MWlsaXpKeEhUbUp1OURvY3pYVE8rNmlUNi9yN1JTMndaQVho?=
 =?utf-8?B?N0xsTWVZNjBUaGErSGFIWTd4NGhXTC9BSE5pL0djOEUvSWtDakI0VGZwb3gw?=
 =?utf-8?B?Q1ZoeXFWNW1kRGM4MVo1b1RZVHA4YWFwMURndExUWGVXUVBpK2l6YWdMNGVs?=
 =?utf-8?B?cDBMTUppTUxOSk1ZaFdtUG9pWW9uTURHYmVjZWRkOWpWa29YTVJQQWdZR1FE?=
 =?utf-8?B?NEVWUVdxUWtYLytlN1NDd1VmMHhmNk4rd2ZZM0NmVzRhNkhWcjQ2ek0yNkpn?=
 =?utf-8?B?M2VtSGI3NlRGRTRpbnNLTkUxaWE5Tjc2eEpENk56OEFiSDZWZ2lSS0dzRmJh?=
 =?utf-8?B?dXhLUVF6MkxoRU1sVjRqdWJUbXB2WjRUd281K3hXdXBRdzgzWDF0bUJsNTR0?=
 =?utf-8?B?Si80VUxFSmxhUEljcTEzM3JZK0tYZHNTT2o2eGJUcjJUbWFPVjFwT1JsTnE0?=
 =?utf-8?B?TFZ5MFpoYVVjRVBYeERROGhodWs5U3V3NG95WmxQT2E4N1RMU050RVdCMjV6?=
 =?utf-8?B?ZnZuM3V2ZzVZQ0hkRnhtZEhvdURYQlNWODBGTHZyTjMyK3hUblAxWFpncEhB?=
 =?utf-8?B?RzExUEJzenhJYjQ0aDQxaHlGTzVSRTdXTzM1TitSdWRlVnMwNGsyM3BXTWRQ?=
 =?utf-8?B?aENuQzNMUGk1SXFoWFVzWXUweDlNM3RpNXBiVTQyMS9sMmpJYW55UFhGN0FN?=
 =?utf-8?B?cWVwTlMzYTN5amRaUkM3NCt4VlRSeVNpMTRxb2xqTEtTUWt1KzNOQ2VLWXYx?=
 =?utf-8?B?Vm1XVmF2WS9mMVJWS1V6bzVOZWxhRFFtZkRPdVVkZlhXV3Q2anpFaTZUU3BK?=
 =?utf-8?B?eFp2ek9VZ3lLZTRLeHNNcElkS3ZNeGs3dGRzT0dXN3Erc1hodkxQQU1JM2Rw?=
 =?utf-8?B?bUxXeUZlTElJMHZ1MENiQXhoRHl0ZVpoNG9JRjNZTlFFRFlCaDZ2Z1NJZ3I2?=
 =?utf-8?Q?KFZvygoQfhCWJ3geh4S9nClFd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a232e561-74e5-4551-a12b-08dc1c0c07f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 12:08:37.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOXyPAzTTDILkuggtxPFRlBIUAsgatkSi/IG/c7dflWjBM9oGQuSNwAz3d3oqPY/dDYs/X0ZVO/3VSN/oUOMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

PiA+ICtlcnJfY29tbWl0X2ltYWdlOg0KPiA+ICtlcnJfcnVuX2ltYWdlOg0KPiA+ICtlcnJfZG93
bmxvYWRfaW1hZ2U6DQo+ID4gK2Vycl9md19tbmdfZmVhdHVyZXNfZ2V0Og0KPiANCj4gbmFtZSBs
YWJlbHMgYWZ0ZXIgdGhlIHRhcmdldA0KPiANCj4gPiArCWV0aHRvb2xfY21pc19jZGJfZmluaShj
ZGIpOw0KPiA+ICtlcnJfY2RiX2luaXQ6DQo+ID4gKwlldGhubF9tb2R1bGVfZndfZmxhc2hfbnRm
X2Vycihtb2R1bGVfZnctPmRldiwgTlVMTCk7DQo+ID4gK291dDoNCj4gPiArCW5ldGRldl9wdXQo
bW9kdWxlX2Z3LT5kZXYsICZtb2R1bGVfZnctPmRldl90cmFja2VyKTsNCj4gPiArCW1vZHVsZV9m
dy0+ZGV2LT5tb2R1bGVfZndfZmxhc2hfaW5fcHJvZ3Jlc3MgPSBmYWxzZTsNCj4gPiArCXJlbGVh
c2VfZmlybXdhcmUobW9kdWxlX2Z3LT5mdyk7DQo+ID4gKwlrZnJlZShtb2R1bGVfZncpOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGV0aHRvb2xfY21pc19md191cGRhdGUpOw0KPiAN
Cj4gZG9lcyB0aGlzIHJlYWxseSBuZWVkIHRvIGJlIGV4cG9ydGVkPw0KDQpJdCBpcyBhY3R1YWxs
eSBjYW4gYmUgZHJvcHBlZCBub3csIHRoYW5rcy4NCg==

