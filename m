Return-Path: <linux-kernel+bounces-122354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EE88F591
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C234D1C210D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D57025776;
	Thu, 28 Mar 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="IpxG38lA"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2069.outbound.protection.outlook.com [40.107.114.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53822816;
	Thu, 28 Mar 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594360; cv=fail; b=S85lM7GQoFoASNoMvP59eeRBDsL9uOvMwLfIJhVEqQ5OpX2JAY7N32CP/3G/EDkHLwYdY2M/R2AC97MKFz2UxPGl5sxDtS8PCZjSysr6Pendx6ra+NDDmYm/6ZoWsaqA4G+g49a+IO9nWwwNBGgdCXGBUqDFg1Qf4U6ZP6tLo1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594360; c=relaxed/simple;
	bh=ybsx27NoJvyszQOnp2tPwww9ARLuR+T8seHFy4vfLes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1ji1bEJECijGzrB2jjdmbt+NGBDO+yJ+ifz1QVJfdF/3q4gna6hcbw0lJjeX07eIJQnzgbATBxmsFPlFTNzKHoimLq19bJ3MCTF4ZBXjhenPYYaHqmNL8UyADK+ouFZ0IEC28MqKvFv3lUvS+gLccvXzPridIzs2S4syk+0YkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=IpxG38lA; arc=fail smtp.client-ip=40.107.114.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dcb/Tc8agKexhW5FNtuEv8Ldjt0KjM/UbxEcGFX34j6I1LqsxYx4v+r7rOXat+yog2Q4Sz7gMFHU/Cy8W0ds+jbd0XphWuGu6PgnDVLu6CeOvR0bfogM4MwADCRNKRc7GYajokihfCZ7VkTaYjOTdxk5VHsBlrt2ADckcKB1q3Ei7sp+laahJZCt5jFGlzeBkuUpOmFP/o9DOom6QPa/j9EFO45QkGDaLpuThszN8qM7+1q+ZzywsBqidusYu5bQjilrEqW7m3DUKSShi5zNrWS01iHJu2B6pqoFHWMzRDqLrPcwsUluyr3LZbzU+SYqnnmdnYMTIKtA/+pKinptQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjroXfKuJZthA1F0Z7CbH1CAQfagnEZUaYVtWUriaDA=;
 b=FQtbcWN9m1TamNWQBvMlMm4BQEMPFsZVKa3xUj7jJA542oPn6TMKar0Y2fOWXzKEcAezkDL/Ju58T5wpPWvTtWAbMbK2mro7Sb+p/lIGfIYfMAzcpjyhnGYGVi8mq/MMCPbzU/SNVcM3m0zMqF70uCP2ZM8tDCMs5BJxZ8Vli096MY+oCcUT0xdJFIAVYwe2kJ/lXcrVHUKUSi0IedQtFvwsgvCf6N0xYU3alR5S4J4s5J8RqOKwCvJPv5kmeFuPfaNF1qzbdl8dSmJZgvpQ8rK68XT6MDVuMegBQgKGs0y/ep6K+JStA7MEgg2GePOsNhvS7ITNWg5WMJbU2rC2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjroXfKuJZthA1F0Z7CbH1CAQfagnEZUaYVtWUriaDA=;
 b=IpxG38lApi3199cAyJz2lUZD07nqW2m036l4e1Ux0r7qxJcyoTfowTY66SHnu51dr7d5NSSwJpWHX+MgbJp2q9iZuWOTe+GDTriKEyeKRIuUmVLDLf6qIYbqZOMazDlCD5IqjTk1um6u3KTxxp7tH55e3j2Cazs8CvFssceM92127mmLFpirAGX8tCFwqfJnPn21THf3vMI0LXH4hlQDpTI8cHHWPLApitLmZYY/ck87hor85CvMsTtE/t23WBUDnzsl6QPB5V2FqRgogimzLaqWjWDVRNbz2mzglTUkuzN6tdrpXVDnBdVst1Jh7BLkEN3BPpQBFJc7dRteFZlhDQ==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYWPR01MB10224.jpnprd01.prod.outlook.com
 (2603:1096:400:1e5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:52:35 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 02:52:35 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"usb-storage@lists.one-eyed-alien.net"
	<usb-storage@lists.one-eyed-alien.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Index:
 AQHagAnskZ+PrXZ1a0CyN6BGkMIiXrFLFjOAgAAcfLCAAAKHgIAAAT8ggAAHUQCAATOvEA==
Date: Thu, 28 Mar 2024 02:52:35 +0000
Message-ID:
 <TYVPR01MB10781C18C8177783D8DEF7E69903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <2024032745-transfer-dazzler-2e15@gregkh>
 <TYVPR01MB10781723CBD338DC3EEB5F20590342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <2024032750-violator-trivial-90a3@gregkh>
In-Reply-To: <2024032750-violator-trivial-90a3@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|TYWPR01MB10224:EE_
x-ms-office365-filtering-correlation-id: 54a2e613-bbc1-416a-9b75-08dc4ed21f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fo8RMfpnV6cl9PlxNBXFUdXUe5MBY3F2KRY4R040oD6Sms8nOHpZJmLSzkxerd0Wn6rVxe7ghdf4QKv4WD/LvaUamhcn7+JluSvmjcpO1+2Vbryh1gmY4nTlsfhvr2eq7ME7NsMA3aKmKi2A1yeXj6MnK0u18KD6BfYrHmxyHDGNQzHTuRLy6NTOadi13nXxeZKgwBIxvuqhxRDIn17OqFwZBhQShnqzLeyp0D90oy3SIPJvlgNAi2L//hcsYoUKFRoLOUn9Vs8KpLYhZg09TD6UwG4ajAD/Sxe0GyCdJhO6AVZTARF9xPjRZEmehT5BX2HXlkNIOmZde0nT7R0Tym8/C42LQJL1dggo2ianipt+uosjrPYO14zBJslHsja+H2wkaQuBRfLYA+GliXh+4kcMbWEJbgPGiSN9SXNoJuSKFa5B/tQGKezTALvqCwJC6uAKcQdwKk/xbL64i7+HqOZywjb0vqmG8oACvcj0b6iXRDRGjy42HFJAa551DOSLHfxHm4OxnQyX3B5sZk6zLMarpkse+r+PxUlJ4mqG9gaPqtoCgZMMUYLL3BUQnHfhgeeZ35JckWyFSa6dS2UHkOvAKAky4kjW+x0Pw0EaG9QXtIkdqENYbetWhIm4P6T/LpO7ioXE1mMQu48uO1zRcptIPuUHnc31I/q1NffILK2N9L7vI++NyFdlZjUEmSuhXdzYdPUH3CFjVQm3Accp+w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?bTNwVGdGWnh0ckV5NzI2dmxPeXJMSHE5ZG1rR3FCWlN3ZTdWam5RbTh3UVZW?=
 =?utf-7?B?emtsM1h3cXg4NjI5NGlzTWFiSUFGVHZ0bDcrLVBLdC9qY0F5ZzcwL3B4ZjZp?=
 =?utf-7?B?T1cyajB1UW0wOVVxMXVJSlZpRUZVRE5LSWlCSEpYS1BNN0RpOXlUYjBMR3lx?=
 =?utf-7?B?TkNLdmM3enpVR0lSNWlWV0xrN1EvbnR4d29xWXVqbUN0Um5wczdWY1JVbmZl?=
 =?utf-7?B?SUc0NXVScG1UWk1PeUFEL1BvWUhQYkUxKy1KQjBDckRGWU9uN00xM3FjaXBw?=
 =?utf-7?B?Sjc5NURvc1dxekdzWXJKYlVqZWtwbWlnR2VTcXFXM1hsemp4eTJ5ZVZhc3l1?=
 =?utf-7?B?R29ibkxBckFuQ29INDZpNE9TMVdza1d1NzNtL0JWaCstbWl0ZE1GaVpmKy1v?=
 =?utf-7?B?ZVZlSVgrLUhqd1lMd1pxYjBMMVZUakFSdkI4WTZ4aDRJZWJsZXJ5TXpvZlR4?=
 =?utf-7?B?QzU4SGVVbTY2QkVJd0hvR0RHNllxRnA5Ky1iMTFMTXJJUllsUHhleXVJaTJz?=
 =?utf-7?B?dElRTHFRb1JscUo2WTFWaVprZTF5WnNDb04wZGFOTDhBR3ZyU3R5cTRxUFNE?=
 =?utf-7?B?WFpydGtwTnlxMEFDRzJFcHVRZ25CYm9YNlUyQk1YdUU2VXk1aHFmVTlhZEhG?=
 =?utf-7?B?a1dDS0ZLMG1aWVdURGZzbGtBWXBXcFlQUkY3UFRHQVhETXV0N1gwTGZxRFFP?=
 =?utf-7?B?dVM3b0dRTjV4WlpyQmV5aDljNmFySGtReENsSGljTjB5WmNpQ05XTWVCMTFi?=
 =?utf-7?B?YllJOTRKTmFId001SjhtMEFtS3E2elk0OFd1WjQ0WWVKdFZtSXBCVm81aVVn?=
 =?utf-7?B?RkROc1BPdVRodUFTeUsvTmsyOGtEKy0xU1B3cEh2Z00wOHR3R1I0ckJGUEVT?=
 =?utf-7?B?TktVaU9TeWN4ZlkxMTRBcUNlM2VqOGpadHpRYkc3VGh4TTkrLWsxVWVnNmxp?=
 =?utf-7?B?aE5qU0o5Q3ZpbHJaT3VqR2hXbFhKa044b2VwYThpZ3hDdXdHL1N4dGZFNXdk?=
 =?utf-7?B?OWI4U1dIbzREdHFlajJ6MXlOTWJKcFpQR0gzZDE1TVR4L2VJQmpLemJTVGh3?=
 =?utf-7?B?VFpXRHp0SkhwQmlSY0pmc3lVS0t4NVBrdDJPMVhnTDZuT0Nqc0ZNVW1iazE2?=
 =?utf-7?B?UTU2NnlJRzdBRzBtT0ZCWndxNkZrUXJIWWRYZzNlQ3pHY2lsdDBndS8zcUZk?=
 =?utf-7?B?Ky1tekdlN1FxaHVSaUR6eXBNa2lvcGZQOGh0WFZkRndOSmE2VTNCSG55N2Jm?=
 =?utf-7?B?M3NqeU1aT2p5MlhpdzEybystOTZBSGxFZWZwUzlrQzI2czh2MFh2Zy9pRWV3?=
 =?utf-7?B?UW5jd1VwdkRHUTYxd1ZGWGJZaHdmZjd4Ky1DNWJOOTJwSC9vYmEyMXpKMlAv?=
 =?utf-7?B?NkNONlYvRGZhSnRaOXc3WDFOdHVjTTBONk50cHFlUlVZQUVZNzdxQTV6RDMy?=
 =?utf-7?B?cmxKMDNmWXNUckFFSEtjbTZ3c2FVSXJJdWtBZktYZ3JrVjBCZWI4TDkvZnUz?=
 =?utf-7?B?OVFTZVo4dUlXZWVpQ0xYcXlqdU8velE3bzJlVU5TekRuMXBmZmtQMUxhN1ha?=
 =?utf-7?B?SnJFVzk5eEJFMjlZT2dXMnJiREpSVVFzVG5iWFh2ZFdlT2ROaVJJc3dGOFZz?=
 =?utf-7?B?cHc4bjZKNHQxNHlsN2dkcC9vYUdQSlJkTWNaOXFOTURONkUxMUNhKy1pNzdY?=
 =?utf-7?B?V002dFhsVnowaXZLN0h4SGNXS0FXaU8xTVY4UFJUOWozMDBhVG9GVnhseFRt?=
 =?utf-7?B?OE1jY2FpZFlrVmlRYnFHeWVUYi84cWFXNTkrLWpydEErLXM0NFJzQXZKd3c=?=
 =?utf-7?B?Yk8rLXBmQlVuM2Q3U21nRjV4b3ozTHRxdzVBc0U5VmtNamxkT0VDbDQzTWx3?=
 =?utf-7?B?WTFwMmZQQXEveGNVaTN5dW81NmVFUk5STFJVMk81Ky1CdCstL1FMSXBsMnlr?=
 =?utf-7?B?b0JOZDR2bmxXUjRnVTBZQ0N0VTdQWUZ4T3RwTTBNbFRZMistMHRNSk1NRldR?=
 =?utf-7?B?SG1aWW9GS0h3YjZKdmlTT0x5VzV4NUtuWGttZjhvSzFqVWVuYTg1d2Y0REll?=
 =?utf-7?B?dDRjVSstckJvOUd5U0o5NkpGYXZWRHkwZXBSM0wyZmhTb2lIeEM3cGwyU0k2?=
 =?utf-7?B?cGRjZUlTRjlxMGlzYUUwbFFSWlYrLXRqakhpdEYwU2IxanBzZXpBcEY1REdx?=
 =?utf-7?B?WQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a2e613-bbc1-416a-9b75-08dc4ed21f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 02:52:35.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+3ry7qiVdb7O1/VNUd7/tGPumWC6fHwnzRacdotK791zLor1S34R7Igt9uSy+AmSgFte+XXViwAhZhO53m43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10224

+AD4- +AD4- On Wed, Mar 27, 2024 at 07:39:55AM +-0000, Norihiko Hama wrote:
+AD4- +AD4- +AD4- +AD4- +AD4- Sorry, but module parameters are from the 199=
0's, we will not go back to that if at all possible as it's not easy to mai=
ntain and will not work properly for multiple devices.
+AD4- +AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- +AD4- I can understand wanting something between 1 =
and 0 seconds, but adding yet-another-option isn't probably the best way, s=
orry.
+AD4- +AD4- +AD4- +AD4- 1 second does not meet with performance requirement=
.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Who is requiring such a performance requirement?  The USB=
 specification?
+AD4- +AD4- +AD4- Or something else?
+AD4- +AD4- This is our customer requirement.
+AD4-
+AD4- If it is impossible to do, why are they making you do it?  :)

It's possible to do because we've changed code to minimize delay by ourselv=
es,
Then no issue observed when we configured delay to 100 msec as far as we ha=
ve tested.
The background for the requirement, it's important for end user how quickly=
 access to USB drive when it's connected.
Of course there are a lot of overhead to do that but that's why we would li=
ke to have a chance to minimize such a constant long delay.

+AD4- +AD4- I know we have multiple devices with delay+AF8-use+AD0-0, but t=
hen it's recovered and detected by reset after 30s timeout, that is too lon=
g than 1 sec.
+AD4-
+AD4- So how do you know that making this smaller will help?  There are man=
y many odd and broken devices out there that take a long time to spin up be=
fore they are able to be +AD4- accessed.  That's what that option is there =
for, if you +ACI-know+ACI- you don't need to wait, you don't have to wait.
+AD4- Otherwise you HAVE to wait as you do not know how long things take.

As previous my comment, we've changed code to minimize delay by ourselves,
Then no issue observed when we configured delay to 100 msec as far as we ha=
ve tested.
Sorry, we have no theoretical proof but I think it's same situation with cu=
rrent 1 sec delay.
So we want to have a chance to change such a constant delay.

