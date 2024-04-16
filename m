Return-Path: <linux-kernel+bounces-146093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090818A608D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CFA1F22432
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBAD79C4;
	Tue, 16 Apr 2024 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="pBHEJRJj"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2068.outbound.protection.outlook.com [40.107.117.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467124C7E;
	Tue, 16 Apr 2024 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232132; cv=fail; b=kV0UqDzPArEoCL53H5aiqcJFVFUPki09IOJMsGKI1/K7EMjLkiAkpbeDlNUZ4eLYFjripxjULTiMM7fmbaIKFSu3G8Tg7bow45uZY66jE8SFllwpo9kDuULN/94WJTYMkuUtQI6VnOc5akIzRd3/fnm8PxchnhkHVeK2H3jHTLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232132; c=relaxed/simple;
	bh=mtcV5UWsq923Fxe2WzGnisiLmy06Hz5RGHKO+zZ4+LQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ktH4twLU/ZkPnym0nVaeMgZ1NRNfPekmKaJhN3w3rjy8Azr0pvjjt7aRmKa85om9ApL7aL6cwU52JvAytAil3DHfTKbxEjDRZWegxnPDextBhw5Q74JziOcudKroMBDKDNH0dmR09R9HbfXjGtOXN6Hiy85SIUm/YG2QF7DN7Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=pBHEJRJj; arc=fail smtp.client-ip=40.107.117.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGeka1BjmObIg41Mdm/H7s5ltWznxmDrzyIfdhfA0O0Gc/O7cY9P6nK9PGiW43Z8etcL0Vz+J9O6drKdBjpzXLzsXYj3lLsCgdyFVK9itHc88nVoeFC7FTMtyaIgrxxV8jrjhy6MnHkgdiFzjHOz0id9FHIgzZWQAE+fIyrUqlPGSJRe7jLUnJ2hw2kboCHbKFIyUMBjBu2B8DMOqj/S37Hk7HkSmkM2LFV5DiwIKCUA1qHuK8hus8pYXpaMF+iVgvelXYN0bPFgrS0/Jc5f320WBREUIvQ1iA3Vi2MJNThHpy9V8MkPb9wsR9KPh7nlC9UWDaExtjEbW5DsxbRtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUHqNu+CIo0jYpq7+l7ljtl+KiKvOGBm4qW6O/x6sW4=;
 b=VufAc1O6w0j9Y2rAxIzG2qL1J+2smeWZVpZM3pKFE80Oz/rC0hK24iUEuAg/6dcpypP0LJp6sJaU91vRsnMLdZOgBUGnBzH/DWLzj3rsMOfSHCmMj34vB59sbBtbEbjuSt50y+CVi22o9h6sQPA+Hh9VaHLL5Mufw1NSzoWZMAKQQNwQ8pNMkDetw2ssiqK7gZhb1EdXdRrz5nhDTcLcuEyeDbc9EbUz3Jo9k7GH8zkwmawEkLb/sAr4mL95S7f/5RU4E5EE0Jkv+G173i91a+S3z1kZPmyKVzeKVG0FZa2Svkx/uMREmoqcTn9TtcWWqn/rfXJjIx0LmXl0UsHGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUHqNu+CIo0jYpq7+l7ljtl+KiKvOGBm4qW6O/x6sW4=;
 b=pBHEJRJjDtD6Z631uOW824V2IyvL/AI3vN9OSr3nuW/L1MJoyePaYMacw4YN7MhlmZ3MOmQL8vfRFzlBm43j7uIcOkPnywNPUSaoJK5t4FVn3Fm1G4HGLvanxj9gUFP6N6G1ha1TApWTKoYZrwOEfhHde+kLTAyczSfSVDo0qplBP9kgJy1nwxCpEitotyztuTUUv4osvHXXbd9d7g37akZBKEn0AfBgW4NGK5TzZtqPEQcIeLXjH7aX2aOvbbkY0DvAjGs6bNcqsR1VcV5JAggcz1Xf+ndu8gRCzQxScT0S1Gj0hsEYz9W1BfsH0+f8eHARN2+Als9/+dADNr0lYA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by PUZPR04MB6885.apcprd04.prod.outlook.com (2603:1096:301:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 01:48:45 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::9bcd:8112:b072:faca]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::9bcd:8112:b072:faca%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 01:48:45 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Guenter Roeck <linux@roeck-us.net>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>
CC: "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Jean Delvare <jdelvare@suse.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] hwmon: max31790: revise the scale to write pwm
Thread-Topic: [PATCH v1] hwmon: max31790: revise the scale to write pwm
Thread-Index: AQHajIkmo9cWMbxIOkGH9cQc4G//sbFkmoSAgAWImEA=
Date: Tue, 16 Apr 2024 01:48:45 +0000
Message-ID:
 <TYZPR04MB585382F43299E49FE1D2F2D0D6082@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240412032559.3352846-1-Delphine_CC_Chiu@wiwynn.com>
 <d82d5585-ec6c-4611-ad33-9c2d00745176@roeck-us.net>
In-Reply-To: <d82d5585-ec6c-4611-ad33-9c2d00745176@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|PUZPR04MB6885:EE_
x-ms-office365-filtering-correlation-id: 6d9c031e-0daf-4f9a-d496-08dc5db75a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xQwl63vZAZBIbDA+CUlqKOHtZb38QZOLgfyoHKiqeD68tA6SHtR0O4J+f9BGXmklPowq0hTfyr80bOVRwb/4g66Id35SMM1GhvFGz8SYif024tOR38jsI8MCCItawT8RpCDHitNM7Xg6cjig/HjnwC/hWfG5gJnmJy4BYSN0doMV2wbV6jkAfHnNhDS8SHBCf+c1TfrUPNPp2BSCSs/in1BFW5SX5aVOt4l80O7G/SIAXUrXaWlGBGxn+uU6RdIJiOcdqW13m2Q97YTGvNUciWcjPYEKV1NblD6mHHvnGTA6jAiH55v9OwugoUm6bHCbtzkxINVOw1SG1LAZ7G+sWFAD+H1NkmvRdppcF2HMWRiCZHzG+a+uD/KvNygiDPevWlVMN9LQbn4RNdjIDQi5cB5VQH1rsLCDXbdWXUPcsNybGmK+IvRwMUwbYiAbc7i1Ra2uCMbVDNSsH1IMuLpXfpgLKTlIQ82xyqt7uLeh+IbziwejLaPm57OAtzzZOZuXLil1HCLaxpIUKaTMGTvrBZHbAKyvTdENxQlGzAuP7SP3FQLv2VRRPt0z5pdDwaW35Cr7QoxTmw0Vsd8YpH0GroYGY5hGjPCLrQVBbKILHO8sAMu0c93vCeL8gujFl9Evf9IwqsYCnabyPUV3iYEEPrUpeAx6A3MEzcQ+t0dkaUaKq0TZ4Yv9nmhkCUY7NKjmPg3Hyqav7p1vJvLXV+qswpZxt0isWsoc4x8ky7HYaMw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FkMbYOEUbbo4Shoydi2KppdX3fsxDAWqMbEK6JPK7xY5sw+dn9Yel1rgPNg7?=
 =?us-ascii?Q?k+X6vtrEp+NKCakbDQGjVstQ+WnIqYBisxSnbRv98I2OqyPCDnB1kjXq2I4Y?=
 =?us-ascii?Q?/5lZ6Ugc9QsT6HVYCd4CPomwmd3x1hk3mydxSCOx+ljbuiYGackMmjojCt8h?=
 =?us-ascii?Q?a0ieig6AQ6P+wJXRSAM909AOzUKRkxz/FuUpLh8fGn/NVzb3Un9qGJkK9yF0?=
 =?us-ascii?Q?hoiFIeu8B5l2iF/lVqRUdyGxljeIBSV7/vlAzLF8IFfriUGIRLo4vUQd0C3E?=
 =?us-ascii?Q?bM1Gh9uDrN3qnTiyWp7xEE5GO2NcFGbzemi9wocDJSJCaqe1wMHmK36NnKFq?=
 =?us-ascii?Q?Oq7hld3I4sN0WVggxvzYr59Halq9lvVWsNskfMRrBrVyfnkbi/V2+7p5DucL?=
 =?us-ascii?Q?ZWspJ04y/s8E7XEuevdrA+gch8TPnnigz1MlRhriyqb3FRxaUBUnbaIvQF4c?=
 =?us-ascii?Q?ZeZ2JkZYdqLWWHsBoIHGOAZAdyJDEIcKweov29LCtVxn297J7Wv6zTk2z+Eq?=
 =?us-ascii?Q?BF4MCbtG0qgWU43RrC4qYwKbjSnXiSK3qZtXDddAd3YQuT4bCtWIz2IfWPj0?=
 =?us-ascii?Q?Iy5ZGemkh9tnRRriVINLGVqwQF35+q52/QN+u3gp8imHo6vM+UYE9NrxZzyM?=
 =?us-ascii?Q?hZiynqyDTcQQy5E2SvTpBy4CmAOutHZvuFXNog599uAg7Kw1Hz4165JGz89S?=
 =?us-ascii?Q?DOLKpaK+YNR8ASjvgv79p+A21RjfA6UqdPokgBKAUkDW0kcGTOIuWUondZve?=
 =?us-ascii?Q?B0cNTzeo8rpeleK+Mu4THall/cwFEod4zaHSwrbP8fK8Mll3GnQzP4xqjWRE?=
 =?us-ascii?Q?9atBcUJ/OBWhJyMiAc2obeql3TsJO+Vrbll+zSPInoTq+NEwUY3jeqTjsv7Q?=
 =?us-ascii?Q?fdsJTERVB9IeiPU9n2qXpIegNces7xqro0fqjEb3BrYn+pRYWVGBsminxz76?=
 =?us-ascii?Q?hhgKdViQ7BPGBMELh4DOG9RLdexlNZ8cLjkhJd1P5kLJDUbZrA0Ls6UFQjBS?=
 =?us-ascii?Q?PKvzkXeCWApQogX08+qHG7e0PtqmngLL3siSO2MSTNznGAWdmOJplBvDt79h?=
 =?us-ascii?Q?C1yZfx/OKSnMjae3jze72lQxiRzz8YR8OV+meAGJdyQ8teKTKCunQQHe3fIU?=
 =?us-ascii?Q?UCBt4cTETC7LHMLaEzwVKx3rxfL0URfaEnPM+HI9roWcYtwR2nuGSdpS91rY?=
 =?us-ascii?Q?U+oUA7lqKbJN6uBAKMmvHK8mhii75DHz1n9jE4VgDJ/QUC4rJHeT754Opekx?=
 =?us-ascii?Q?+9M35CSg9kmK5CpT3cHOc70+L4mT9CQfhubIUrE5jbnIec+BLwtG17bWtfmH?=
 =?us-ascii?Q?zJISkdNJ1+ntgVWucnPgVldZusXDfoVM4aNIIiNMrahBbNgDGg7XgcPbf6/Z?=
 =?us-ascii?Q?C3UCcS0GX5kFQmoO212RKSH1antlO4Y9fW0pwG0NZ899dgOwO8a1adhjd5ma?=
 =?us-ascii?Q?YHWjoC7bnhK3xsycbrJ/L4aO3rDoMgSUNbFYaJrIwE2Y9htAy/kdxNH+njFv?=
 =?us-ascii?Q?E8I1cYshppkB48/k/7bMIINCkiiCs+7uYtZHuh6eAX8jxbs7iJ2kWVkpfVej?=
 =?us-ascii?Q?JL9HS/ZMMrkmOnGTrYqd1mteCa57PDdJ3lIQTnBN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c031e-0daf-4f9a-d496-08dc5db75a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 01:48:45.4964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKUSf3Q4gbm7qMpzB10+ixHgwVd8p6pZ2A+wmTTIMQbCaFQpT/fOURSWgCTZriTEqYQCFIHV1xNYT45cgZhHvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6885



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Friday, April 12, 2024 9:03 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
> Cc: patrick@stwcx.xyz; Jean Delvare <jdelvare@suse.com>;
> linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1] hwmon: max31790: revise the scale to write pwm
>=20
>   Security Reminder: Please be aware that this email is sent by an extern=
al
> sender.
>=20
> On Fri, Apr 12, 2024 at 11:25:58AM +0800, Delphine CC Chiu wrote:
> > Since the value for PWMOUT Target Duty Cycle register is a 9 bit
> > left-justified value that ranges from 0 to 511 and is contained in 2
> > bytes.
> >
> > There is an issue that the LSB of the 9 bit would always be zero if it
> > just left shift 8 bit for the value that write to PWMOUT Target Duty
> > Cycle register.
> >
> > Therefore, revise the scale of the value that was writen to pwm input
> > from 255 to 511 and modify the value to left-justified value.
> >
>=20
> The only difference is that it writes 511 instead of 510. All other value=
s are the
> same. I am not sure if that is really worth the trouble. It would have ma=
de a
> little more sense to me if you had used DIV_ROUND_CLOSEST(), but you didn=
't
> do that. As it is, I really don't understand the point. If it is really i=
mportant to
> write 511 instead of 510, the commit description should explain that and =
not
> talk about the last bit always being zero (which it still is after this p=
atch except,
> again, when writing 511 instead of 510).
>=20
> Thanks,
> Guenter
>=20
Hi Guenter,
Thanks for your reviewing.
I'll revise the code to use DIV_ROUND_CLOSEST().
The reason why we add this patch is that we saw an issue that the PWM signa=
l we get with oscilloscope would not be on consistently if we set PWM to 10=
0% to the driver, which would fail our hardware testing.
I'll describe more detail in the commit message.
Thanks.

