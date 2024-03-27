Return-Path: <linux-kernel+bounces-120485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E288D839
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3660CB21899
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271B938382;
	Wed, 27 Mar 2024 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="SrXbSmLb"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2051.outbound.protection.outlook.com [40.107.113.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2237140;
	Wed, 27 Mar 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526278; cv=fail; b=utYy5fgBWZl6+1/OkYEYZHuFS9Q2c+Wn73sq7Gd3k94sZxlwJISpY9fPvpBvBj3Y9bKlFFr2SXAX6jyWmX1sp51oV7S1lkuI89SVDI65sW0ul/nTwuH02jlLXZVhekA3Kg2Ss+HaldJRsMxaXG8B0Ys/8PSpb5Cyiq4O/JKMr5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526278; c=relaxed/simple;
	bh=0WhJBLt5dEv3QOkGYNnlpAl0Ww5Sk3sBEx0nDMrXrIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwze6zLzP6LODk/GMEY5cwQjk+aAUB7E5i2VKYGYjHrxPvX5uuzhiCWp3hWVAz4QN78HWixHbNcS08/UuCHHByI2dj/2ZAZEc2UYNf88DxkViR2WpW+d8boJYPKnkN7TLsshKJmkhNH8/Qfgj+1uVMwCG8TTA0If4vmxTMQ+KdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=SrXbSmLb; arc=fail smtp.client-ip=40.107.113.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOYy+WIBPQGm2soXDbublHGD7khZzUPnWVLFW+0T5FzgwC0hU9zOddDs16w9uM+R5CahWrZW9qJaft/mlv+ygXDZpv9gq4DtDwinyhATnQw6yzmcKmgCSHZiGr+8wtlnO3AnQvC06YDgSqkr1RMPCSXdMkKD+VDoETZr9bWKtUYK+gV5sPiTcyI0aUZMtPwJ+GkFfYwP0p6TNReU5pJ3rdPJibymgzuul4ZWaBcgW3OUKhUbVihfRUElawLk0rADk9Ffaug9hwPRUEEiFQi5OeCV4mZVta6KTPOrCeG1ICArqOxLgZwoHE78kLk78Gm0YVDURtVhl3u/3axWHuu+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUnY80AUxnZ/SEHOshOFlSNKDOPCX0MdUNrtcVIJwFo=;
 b=RyifpvFY4UAW9Xyhm+DMDeL7iGjD0k31mNe09J7VxghUazC6fYe4qmzScRIER5nZ1Hi9yQpp8LUrg30bfthztSB+1OfsQS7kIpiNDQDJ0o0uoLZS/kJp4dbmisyOqRkGmuTeplyCxVsfDu8CBmtlXoHISMCwWMW8OOZHuoLboxNHfRBtXUk1a/+Py4LRdidNk2PxbV7K4HnRubn+DdbODgwcPrVdvx64xr/PMA9JtZ+iOz78LHaWcFJj68FnbNTOa6Ia/vG2kSCNQl+uGS5HGntxl6xzhbHyCC3XcTn1bA/kKkSXo6IkYGaxOWMmjie4LUa22v7YGAIisU5z87EQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUnY80AUxnZ/SEHOshOFlSNKDOPCX0MdUNrtcVIJwFo=;
 b=SrXbSmLbrmvu7tmujNvPu4OfQJ5aJwJEd/yrf3Mp2SjB5oMvLXlBUbdlAmuLizRbeAMIt6tmLPBwRsWez3eX/3bfNMOMVFbdqcJu9zZ2U00ewa9ncByurK2iKxnaCc37ppiYaj15DP37kqIO6lTEHo9q68Zp33IVOMN29rcrS6SwbzlPQZ0gU/UzZUfQRRLFV5JSVlKsAmlFyKZ+6WEuOwGwAL3WOVw/jZ3o1/QW9Jvz4n53+RX3cneCMUHps6yC4ySZEXhVsnSwl2sA5spgBGz/q8NfoIKZSipBCf+Tz/DHANxB7NQXtW1VjH1cdO+QFQ+mazdHF0qg6jdsot3f8w==
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TY3PR01MB10191.jpnprd01.prod.outlook.com
 (2603:1096:400:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 07:57:52 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::b541:f53c:6306:6e2b%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 07:57:52 +0000
From: Norihiko Hama <norihiko.hama@alpsalpine.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"usb-storage@lists.one-eyed-alien.net"
	<usb-storage@lists.one-eyed-alien.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Topic: [PATCH] usb-storage: Optimize scan delay more precisely
Thread-Index: AQHagAnskZ+PrXZ1a0CyN6BGkMIiXrFLFjOAgAAcfLCAAAKHgIAAAT8g
Date: Wed, 27 Mar 2024 07:57:52 +0000
Message-ID:
 <TYVPR01MB10781723CBD338DC3EEB5F20590342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <2024032745-transfer-dazzler-2e15@gregkh>
In-Reply-To: <2024032745-transfer-dazzler-2e15@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB10781:EE_|TY3PR01MB10191:EE_
x-ms-office365-filtering-correlation-id: 60c2d1fd-55e5-474a-1f21-08dc4e339ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rAaip505sk1A37Af8lujYVEUSipPbYbY1h7ushptBr8tNI6exQ7WGXaW2Nr7XLZiqyDiMLZyDJN9qIN0I2c9WJLcdZ/sJtpkGIma67FbM9cNUDZmq0AkTVSQJnAVLgFHVLrv7ShEDqx6ADnYZwok6I9vSvQEv+/XXzPFpZ33fwjVJjhTJ+kGw5MAb6iAgX8lcaLNV3fRGwqrOO82krTZ0LVJIP6BBQUQGvglIQbuLpSu/d78qLfpb1zgX+llk4+nWs3MfuQeoKOgG/7Ki9LKiby1q1gBhu4Pp48EyuwAHAZdApQvTu9BdZGkbsDkLDBSXjXFp4xVRQ8OrbewzCh9y7GErguwPgemW6jygIihW6binA7AhjeGyfGsbehePY2waH5/Dj8y8SOJr8K7EJLZWwoy3uBroEHshRcumHDnft/I9Rl1kuh4to0OIPpxVQWaSZyHDSy00sJNfg9gnytRrwGLHQ9TAS8FBobZj5UT6rJ1jFpA6hwRLFN2DC9pq6Rlk90psp8HxBmbTf5sW0JesE4dlt03OTKjE+9pfrr4VLCImjuyJDU5Q4YsQ3Kb4tG7Mp82o9rPDPNwwA9jqP+R9aKbYGEZpvxwjfd02gP6LpIbqpl61hw9SBjZUbxn8gomJoGRw9ijOTcpCwt1fyWdxVpVPrqGz3TBMNNVhIXYCRuY1UPZOydvBCPBTHp1OYAbAbG3VaH8bYMsEcKvoGcOFAXRIC7NHlBXNnc70wPyNUU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?aU50clphZUhLSGxrcEVqelJ6bGVHTkRTRVROMHduc0RxemJVTG5HY2pXNmw0?=
 =?utf-7?B?Z2FqRm1YVzhWTlcrLWdjWVBidVVQWlliTnppeTM3LzdmUVBUYXY1L1FGRUlp?=
 =?utf-7?B?amFVVWx3YmIvNVpqWEUzOW15L1pIN3E5YjlLa0o4b0hTdXBVemlVbldXWEdp?=
 =?utf-7?B?SjBQVUtNN2NvdnFFQ1hHNFJpeXdJaGd0MGhJVDNRdml2MWxwakN2dy9zb21F?=
 =?utf-7?B?TG1IWjhuSTZiSWhtT0EyUFR4S3pPTUJIcEY0UEpKcGtnNFQ4NHRsU29oMVBL?=
 =?utf-7?B?S1NOaVlyKy1ZTFYzeldYc1pkU0llWXNTKy1NbG4yL0hGaUNhN3dwcCstUVR6?=
 =?utf-7?B?VjZremIxbDA1dVAyLzJCZTNyRzRSVklZeXJ5VnN5MjNuVERBVm9rbmRENmM4?=
 =?utf-7?B?T3FPcTdNZDlleFRMdVlnRHVSOTFJMmFmNFg4U3lJV2o0Q2V1UHJvaUcvMWZw?=
 =?utf-7?B?a2s5UzVmc21aTnVhVGgrLWlKMk54TVhEVVBJcTRzTWM1UUFOQU9wVDBNZGdi?=
 =?utf-7?B?aEtwWGRSMHVZcHpSNEs3Z21oTklvWnBSYk85NWZ3OVFXbll5RzUxdystTHZm?=
 =?utf-7?B?eXlmcWhQdU51aDU0ZEFYKy1FZzBFVGtBcXQrLW1oWVNYdDd2WlI1YUtFYnRB?=
 =?utf-7?B?WUt3bjFZTElaMkV0ZUF4a3hFWjdKcUFyNFRWRmZDbk5wRXN0TE5TMFh6NkI2?=
 =?utf-7?B?YS95MlZRbzVMT2lSSHNjaE5vZzdSd1hCeEpUODdRVFo5UjczVThLSGZHRk1l?=
 =?utf-7?B?bGhvR0ZwNGpocWRLRFFtVkZQSGg0dkxFeFM3M2ZuRWNDOGxXWXlqcktDVnN1?=
 =?utf-7?B?UERhdTRucVI5a1lNRDNRNTU4U1Q5b0NOdFQzSGd6YzlSYUpXZ1lUQktqS2NU?=
 =?utf-7?B?bjdQdjNxck1RaHNDVmhpa2VFQ25IdnVoRFJrY3F0Z0NsTjVBNFFRNmd0RHBT?=
 =?utf-7?B?UWx6UzZLcFN5b25nMVNVVk0zRmRwbTRRN3BGVENCcjJBRUZLWG82U3RpeFM2?=
 =?utf-7?B?SjhuNXBRV2Z1WnExNlhldDM4SU0yZmg4RWNHNjFBRENLeWp4b215T3QyaFB3?=
 =?utf-7?B?Ky1GN1hFd3ZuKy1wNEw4RzI4WFJTaTlCTURMUUpWRWtDVlBPMWJnQWFGNmFm?=
 =?utf-7?B?MXFUZ2c1QW1BOEp4Y3E5QWd6ZlVQanhoVGkyYlNhWXlneFlnQWZoZnJ4ZEF3?=
 =?utf-7?B?cGhKSG1jeUl4UnlBYVdDNk42VEFhRDhHYnZGeFFLZmhiRklGeEFzMHV6V1lF?=
 =?utf-7?B?SVNVMTRjZUZZN2NpeVVsdkx4WmF4MEVWeTZlby9PcmdQNCstM0x6Q3hNc0Fk?=
 =?utf-7?B?VmI5aFFPTFphMEJidGRCWW1ZL2VYNkhyeWlGTEZTODNsY0J0VUVjUzFUVjZI?=
 =?utf-7?B?YzIxbzY4SmRPcldSVVJTNTJXWTVvME1mVistUkFieTcySUNscmdGNFBGZHFR?=
 =?utf-7?B?Zmd5T2hxQUEwOVpkR05xL2NYUjg2NWN3bjR4ZEcvR2EzSzlLc2xtVWhJdExk?=
 =?utf-7?B?WW02RDd4Z1lObm1rL3V1ZzJKZ1JYOFY0TnNFVTVZcEZXTkNiNkQ1bWhqY3dq?=
 =?utf-7?B?MWFBT2tRL3ArLVlQTzM2dXBNM2NBeUtVaWJ6eml6b3pONGlXNmtjb0pIdnlq?=
 =?utf-7?B?OFNoRkNSLzNldEFQQmk5aE02VzJwcDdIQTNwYlJvaEZPMnplWGs0N2hmSGtL?=
 =?utf-7?B?WHVUeFpGWXJYTFFZVzFGY0tzTTRzSm5EbnpwT3JVd2xVeGZNZ0xRaEh3NXdk?=
 =?utf-7?B?RlhqYXZXZnlkTmkrLUFjNDMrLWNzQUI4L0pnWHNKb01GajVaL0lPa0poTVhV?=
 =?utf-7?B?SWZBOU1UaFJLb29OS2srLTlxOTdFY3kvZmxpdU9ibystZjh6bmxOZ0t0NjBv?=
 =?utf-7?B?c09GYy9WUFJ3eDdhTmZYNmxKQ1dSb1gvV0YvNHZGM0JodFZ5Ky15NlVuOG93?=
 =?utf-7?B?VU8vSzJ6VFJ3clVzeFk3djFUZXdkcnhJTEczdjdsalBBYSstb1lpQmR5MnpX?=
 =?utf-7?B?UG13Vm9EUThRU3FseVdnWlh4MThKamlGanM0Q2VkY3lnNkpsdDQ1TjlZZmVa?=
 =?utf-7?B?aEk2Ymk0T3E5SUJzVkVEc3dpSlVRbDFIaUoxdUdlMk9ScGY4clJSKy1PS3dp?=
 =?utf-7?B?OWVnQjVJTTltSTlFWndzb3NWNmcrLVNYS1BkekNBOWZTR2o1SkUyMEJHMGE4?=
 =?utf-7?B?Ug==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c2d1fd-55e5-474a-1f21-08dc4e339ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 07:57:52.6197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kg5hXeOcwW8pdPxIvwkc7tBgNHG1d/Vc94MUsI/B+gPKfE81e5U4uoaiwzJgN5oxYaQvg7cVtwpZw7M7BbsHJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10191

On Wed, Mar 27, 2024 at 07:39:55AM +-0000, Norihiko Hama wrote:
+AD4- +AD4- +AD4- Sorry, but module parameters are from the 1990's, we will=
 not go back to that if at all possible as it's not easy to maintain and wi=
ll not work properly for multiple devices.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- I can understand wanting something between 1 and 0 second=
s, but adding yet-another-option isn't probably the best way, sorry.
+AD4- +AD4- 1 second does not meet with performance requirement.
+AD4-
+AD4- Who is requiring such a performance requirement?  The USB specificati=
on?
+AD4- Or something else?
This is our customer requirement.

+AD4- +AD4- I have no good idea except module parameter so that we can main=
tain backward compatibility but be configurable out of module.
+AD4- +AD4- Do you have any other better solution?
+AD4- How long do you exactly need to wait?  Why not figure out how long th=
e device takes and if it fails, slowly back off until the full time delay h=
appens and then you can abort?
It's IOP issue and difficult to figure out because it depends on device its=
elf.
I know we have multiple devices with delay+AF8-use+AD0-0, but then it's rec=
overed and detected by reset after 30s timeout, that is too long than 1 sec=
.

