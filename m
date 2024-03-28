Return-Path: <linux-kernel+bounces-122364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AFD88F5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE8E1F2C0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5CD2D03D;
	Thu, 28 Mar 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="jVoMX0Pl"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2066.outbound.protection.outlook.com [40.107.114.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAEB32189;
	Thu, 28 Mar 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595097; cv=fail; b=bDVVxEIcZj4VRUmkBexg131NRXnv4zd5cnEO5T0C2p4N8I+o1agMtxlc8eP3ZZK2d/JLoI02MPcBmAdU4xYpePYGgmu3I7jqrA7snYHbStEDSOeIJenT6y2KCblfSO8xk0ZLMYnOSsenN4zMYgU2sDfoxPy3ki+qUMEd/nIRl0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595097; c=relaxed/simple;
	bh=BKW3qS+TwUYz1PPd03eDk9VJDaWutyu2MdLzfZhJmN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cc2i3r4ZZucBB049HZUoEOPptEnsV5psHaYnMmgtgHfot/nJ6BO4wNsZu0PNHCtJZEjgiKxKrlveqP9fvOIcKqNNd5SjlpdNL+4pykAIulwq6MJjUMqm29+dnygsAlXiCJFjKSLCE3Akt6Pjcr2nqCBcGFDCQZ7+I6Cat1TRpUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=jVoMX0Pl; arc=fail smtp.client-ip=40.107.114.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2EjIkSOk0Q86EhaEzMMtDky0sLZEUlB4SQWwBwRFWPLIrX7tzgTEqfGUbCPed0AnXIag8PyTSGu2W31/rCn7ySa8ToWDCLdWTjn2k5l++BVb5yv94fDG81OC4Msq5vOUtvyvi9+LQHUKwsbV+EMHnrwLDJJlfNBMN5aHkB6mgoxzX0fbWFJF+kMxGv4jV0JireBkBYP++4a5H74mGCHOjntBitRsbP3rwtVw7Ci9WZXqE2Q9Bbn3ZPQsdYs8Glwnp+YqUhHv8Y+wQbgr3+Aw/EIBvo0KgxuEmnm5hSdie9lO6fCBix4a7xxkJY2ag8aSdRSr5/KQgO2v4r3ZhZu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKW3qS+TwUYz1PPd03eDk9VJDaWutyu2MdLzfZhJmN8=;
 b=K08maiNtefEtlV0LE4OIFiCeS7FmaR9DicDkGNJNs5bc3L/F7aA2VOxlPeyDdThMK0QnKqgUctuMDhD5OHRkcuRDtZrvM0TuTbP1xRZJNWCoxc85WKAguAUG4TKnmxdRwowegB2m9PmEyR2szwnyqJaOI9L52E5ar4NaSoNvGvzVMtqh+Lbcs/oAV40GRwNhfDRa9AMko3FZV3rO3sXdi20VQdjAyApBFcVeppj86rxLgm4yz/X5a+rRQe6yvdk0heDV/X2raUcZN56z0dqtVlR3CgLUfLvIBGD/deImi1T8uqUbFCshHKhmiYIrGttRksXKbt66YdtOKDoj3wsTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKW3qS+TwUYz1PPd03eDk9VJDaWutyu2MdLzfZhJmN8=;
 b=jVoMX0PliHNnDA/aCa7MTYBjuIMh3QsCuPpM8ptfxys4q4wOqh48LJLn3UNpwiWVAENNR+bTlrZo8lf94P5H3FQfitHUTgGsLLNgmP0G3kOX+slytGOfkIyeeUZjjrg/Ny8iuexFAT7JUoejU24LJdl1PJ/A58OzhE7wPgz6epC5Pb5UCoicjMr5hHxw2yGcCUBJ5H8JQItte/0Zps3Zuu+Ad5XLnwm54PzE/9AU9PrOAFr+an61SyfSkTZmavkJDiqiXX8PSsrhlxb+6KThEKWWLQwYO9fSaK87sSKyjnDAu1xdtsJaU7mKVPxcn2Zq4s9PPvZokLHrIVEXaWwMzA==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by OSYPR01MB5432.jpnprd01.prod.outlook.com
 (2603:1096:604:86::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:04:47 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 03:04:47 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "usb-storage@lists.one-eyed-alien.net"
	<usb-storage@lists.one-eyed-alien.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Index: AQHagAnskZ+PrXZ1a0CyN6BGkMIiXrFLFjOAgAAcfLCAAG5DgIAA1Sdw
Date: Thu, 28 Mar 2024 03:04:47 +0000
Message-ID:
 <TYVPR01MB10781AA8B37E147E318597B46903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
In-Reply-To: <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|OSYPR01MB5432:EE_
x-ms-office365-filtering-correlation-id: 58dddad0-7a2b-46b6-c61a-08dc4ed3d39f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dlQRM3Db9y9Ms8wMH+rFvSCMXsAiwXT8FwwjrnFjb/1QNezRc8ZlX1h6rh4i2cMtGFjyFdp+gyKw8ECL3mvjsLf3wpw8zCc2XQGRv5WecRnhyCqX281i6jZVNCQXwX/sWQfJ7Um3nMpZp4qHJBc23Yo7sqJ5QYhEuxG6RS3Ew9IrzxyI4+39EofJsODEzk4xkYaXGEbA1l2V5uwsppW7xc6tLDv7zHAyZZjm1psiqIS3bthcFxyJZ2WK9GOYStS7iIrwQ2f93uytR0VPd8CSjP5L6Vy461nkt3M4zx8XgSB4Y4BE+IeQyXUpRS8NzjL0okO6nWTNwul0Jl0vQFF3rr3QMb3NYCniLWVBljQSuddoc0fRmTOhAhm4XVCMfImNzT2nYLtBAacOmY8R4YPNjC1vsZyKoN0+0WQ6pDVDb+gXEpffMwkmdMWTBE7yyw9h9zrnvnM/dTgYeWTt17rHo5AuKUxeOBvQWCI8TXlleU65x6EEH9I3BR/Z4fXaHrDehWpYOpUrdYlrcEtmTebMLl8GqwDYTUI6PE5uX7zHz+AsCgXviWXsHkmf5y6IjaxCKppZ4UC7mmis1xkteQd9Awl6d6/jw/nTP0JUVVtd3P2cvwAUJrxKQ+/ApIQUfAMhiFjH88/tnkSipK8got8+YhSzn9SbK2z3kdcCsWKny3hdAGKJP8PXlEdYC2HRj5z9FPtIwWnJHcjxG5nLtG2aqDOGjwzMa1W9D40/FV2E0Kg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?b1BNL1Q4QzlnSGFWZVA5c042V1Q3VmZkU3NzckpFZmFlN0cyMFBkS3NJdEU=?=
 =?utf-7?B?Ky1vNVdHaG1hMHhJNXRRaVNNNSstS29JUElsbGVKd1ZkTHZOZVFvUlpRMFFm?=
 =?utf-7?B?bXFlWFdWNHJ3MVpXdEtBeTNjaW1QUk9QeHd6TktlVUtRcnVSaDF1bUJ2RHdw?=
 =?utf-7?B?QkdNM3EwT0lac0Mxa0pGQ1Fpd1VlZk11N3p2cWR2SURkNW1tdDg5bW1qZEdN?=
 =?utf-7?B?cFJCUlJFRVhnV3VmKy1Fc3BYTEZVb0RWdElpWjUwQ1BBeFZpTGU2MlRNaFVp?=
 =?utf-7?B?QVQwbW9IQnNTTjg0NmN6NWtOQXBTeHgzUVVnNXBhSSstS3dRallDbGxSZ1hl?=
 =?utf-7?B?V08vYzVDTE9VU2RWb3hVSDV5NGRYNktIZFhncXBIekpGR0pKZGsvczVtTUR4?=
 =?utf-7?B?MlR0aEpGZUZOL1R3azNsbzdLTGUrLUc5dTExbm5RNlBFOVkwcWtEUXAyR3E2?=
 =?utf-7?B?RUVrOWdvRkNNT0Y5QmtNclFENC9NTEVrQlJTNU5xb1hqRnhWeGZrcG1xbWhT?=
 =?utf-7?B?YnoyakF5UmJyL29YeHdyOXRIdTJlRVQwVFNnUm4yNistR1prYVcwcHpaQUJX?=
 =?utf-7?B?eVZHaWtrazFxMmlKNGFsa042TTNrNjM2a1lJVlVSSjRNYW12bktvMWlMTTFI?=
 =?utf-7?B?L3dBb0krLUkzYzFlcDhTRnZFalExdmVGUVdHYndGZ0VEeXNCN1VIUWNHcHBV?=
 =?utf-7?B?T3lJQTdvcDdEaUFORXJ0Q3FyaDFvQUFiM0NOanUxV2dqTG9ETWNlZGQ4WjRV?=
 =?utf-7?B?Z1lGdEJlQ3NFN1EwQlhENk9wMEN1bjBPbU5ycFJSa2NDamZHeEJQT04zbGtk?=
 =?utf-7?B?aFdKaHBhQzd5VmhXaTZScWtGVHBibnd0WjFMQUJ0U2E3NldMTjA2WFJqN2xX?=
 =?utf-7?B?dnRsTC9hVUdKUlBycEVnKy1jd1BWMnQybmlyOWRhODBvQXVSR2xOZFBCS20=?=
 =?utf-7?B?Ky0xemx1RnlrNistcmdJZXdOZCstSGJlZXpyR3VPcDJjVW93aFdRWmYxQnFy?=
 =?utf-7?B?OEs5c2dEeU1HazRjbkcyV3dZcm5pcVNrSXE0cXlZWnNFVTZ4M09UTS9CMGRU?=
 =?utf-7?B?U1J0SDk0b010V1VkTmJCWThPenZCenliOW5YemY5M1BjNE1KNUY3bUt1dk1C?=
 =?utf-7?B?Ky1saFNhQTRSQ0doWUFONzdvRnh0YlJzUTJhNElaNTlqd0tsZjZLR1J3SkNX?=
 =?utf-7?B?M2VMc04vdjROb0tZRzJNbmQ2cE1EV2ZPWjVlKy00dldoaERWNW5jTXNVRVFN?=
 =?utf-7?B?NkcvSGJIRnJiUWtsYnlHWGtxUk81cVE2VzBoNUN6U2ZqdEgvZEUzdVBZZ0Vh?=
 =?utf-7?B?c2pxT3kzKy11VUxYc2hEaGt3ZThNUmRTa1JXZ29xeVVVMGJJKy1RQkpkN0N1?=
 =?utf-7?B?Y21wd252NHY4R1ZncVk3Ky0vQWxMN2pCd2o1U3dhWkhHL0lFbjVFcUcvci9x?=
 =?utf-7?B?NnF3VzNTTmdBYXMyZjRISjVZU2hJM0hLRm5ZclpvTFlsbTNPSE8zeXk0L1pW?=
 =?utf-7?B?RFdiM3pQbHl5ejg0NG0wVkxqY21mNystd2kzTUIvc0lnMjllWWlVR09NMWhI?=
 =?utf-7?B?Z1hRTFJFRmthd3FJbTVOTlVhaXZnaXk5d1lxZ21TbXZsQ1U5bUJOUHlRTnVn?=
 =?utf-7?B?dVovUk9ua2hlbzBKNkN2c2NaNTY4ZVNMT3NsZUlnTmNxNUlOVXIwZVBFRWhp?=
 =?utf-7?B?VTRtZWdGZmlZV1pvSTc4eGJ2SWlYUnk1VGdrei9uSVMzNDdaKy1sRnFmUDZR?=
 =?utf-7?B?NXkyVHN2OWl6cHNwcTNHb1IwbkpWUHRUL0wxZDl4cnE4bXQ2YVlrQ1Z6Ni92?=
 =?utf-7?B?ODBFWCstekdXMm9qUnU5bWZYU2ZpUVp3VzNOTEpQSm5uMHAySmpBakp1Q2k1?=
 =?utf-7?B?LzYyNjZsc1NjU29NZlBMVjdJeThkMjVYTlQ4enBqV2tJUGg5S2xCNCstV1pw?=
 =?utf-7?B?YkJFeTU1OXlER0dhMFU5Q1EzNDBIeDhTaXVFb25LZW5xbXhOZCstNWtSRzU4?=
 =?utf-7?B?TEw4ZkRtVjQwZTk3MFRZUjcrLUJ6MUFIQmFRNXZuak1NZmhDYWJNZHFUS01q?=
 =?utf-7?B?elpOVlhSYmc2amdqNWFaNU0wLzI4aUx2N29lRU54ZDhsV3B1S1ZpSGd6ZTEv?=
 =?utf-7?B?TEFKaXNGZWF0ZWlXVWdmd2NBdEs4cXM1aUlvdUhvU00xd00vU255QlV6bFp2?=
 =?utf-7?B?UXliOQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dddad0-7a2b-46b6-c61a-08dc4ed3d39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:04:47.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUEtNeOX1XkNN/oQuIfCuzugno5d2qBfiBPQ7oqbK9VYV7fvxzgYxRyUEevGiw+eNDEUwMxleOCsgDYU/8fR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5432

+AD4- On Wed, Mar 27, 2024 at 07:39:55AM +-0000, Norihiko Hama wrote:
+AD4- +AD4- +AD4- Sorry, but module parameters are from the 1990's, we will=
 not go back to that if at all possible as it's not easy to maintain and wi=
ll not work properly for multiple devices.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- I can understand wanting something between 1 and 0 second=
s, but adding yet-another-option isn't probably the best way, sorry.
+AD4- +AD4- 1 second does not meet with performance requirement.
+AD4- +AD4- I have no good idea except module parameter so that we can main=
tain backward compatibility but be configurable out of module.
+AD4- +AD4- Do you have any other better solution?
+AD4-
+AD4- Can you accomplish what you want with a quirk flag?

I think that it's hard to do that because 'quirk' is specified for a device
but it's difficult to identify the devices to make quirk, especially for fu=
ture introduced devices.

Can we change the design of existing 'delay+AF8-use' ?
For example, 'delay+AF8-use' is 32-bit value and the value +ACI-1000 secs+A=
CI- does not make sense to set it,
So if it's set to '1100', it's treated as +ACI-100 / 1000 +AD0- 0.1 sec+ACI=
-. Is this possible?

