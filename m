Return-Path: <linux-kernel+bounces-84837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59886AC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B781C222E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002B12AAD9;
	Wed, 28 Feb 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fzMvT8nL"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2043.outbound.protection.outlook.com [40.92.99.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE87E57F;
	Wed, 28 Feb 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116986; cv=fail; b=T0szzfnRy/pVUL/W0olwDwQQoCjI9GCgExEvvAydWe2F8by3VrVItmdsuq8SBKTv4lNSvZxf5KxqL++qt16aIz5CQgoF2yCPazdcoYZatxWR90tMFsPeYjE8C+v0+DwXVeS4WFi+xin7YRsw4VAz3P6J+iVfUwK2xhxcwueiqyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116986; c=relaxed/simple;
	bh=T4oi2Ha1zFlCOSHf7MkaI/pTPNHd39RNktowMMWDMAs=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=coULWGsYbk5Z4TNGOYIYobh4wVgDPH50TVBeeIIs8vLAv4aecEUkUHFtByIoo0mbgD7RNOffWM8Qnw7OxorBNhXQxQ4qkRnIH2yYbZ9ushAUZUzQlDW4dYxWNOv/2rWYJ8/gBFybBMd7M6rLMbmnb2m1Wb4rRrapnJM5XboaP9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fzMvT8nL; arc=fail smtp.client-ip=40.92.99.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bddGVXNn1Ru5KllnK6BUIvQHrQEs3ItTpCOVNTXgZHMguHKJdHOWC0aGljzGogv4nIJTkF4YJslbnthHzq0n9IztgVrmHz+9s0i/yImirNji+gOhZZcKnSju6MgUQlRCPz66/1vNMFjHHDQdrSxMmeO0ts0uazAlN1+dMaLqq0KqOslpTZSnQgNCh7mKeMNSSozcMdxOyXcK5kmK4GP2awWS0zwSgkhcGQuV5UmV/nRQ7y1kYwsfHt2XfO/MVx0ZkJXw2/T3kmVVwONvPjmCEmQ0dj2X7+vz1v8OaawOkjWwNLdaOazgA6FyP9xZvnOA7OXW0reRQiv++YXpV0dJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4oi2Ha1zFlCOSHf7MkaI/pTPNHd39RNktowMMWDMAs=;
 b=nIV0agXAS4NZ64rC0sDP9knY/+H5X8nexPdu2CgtyVxNf3iNQy512uhdyIdTVvkJLSktBUr6E3b4HELcnva6DpeJveQsi48thjfP2Z4nzIFMoQlRc7Pg8Em/fiu4IqAJfPRo8BjEOUot6sqYg4+nlagR9JY/SzkyoyDr+2msgmCAuQmr6fYuUjggZpMWAWf9J+qJgODqfsWdpYBUVeI9GGtHJ6fW5hkaGV7IWcIm8dDIpOjQGoLk5BYVTbk5tQKTTl8EwTkee32SNLy0PPACCK6ybZc8yjySCLoAGnSrqEuXID+MfNedBoTfgtHQuM3quYlvsr9dWXCCFnqaxgPtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4oi2Ha1zFlCOSHf7MkaI/pTPNHd39RNktowMMWDMAs=;
 b=fzMvT8nLD6FV05dp+A+2wx59g2UopETbuucMhsijjOMhKpKGXVVERT3rVP3Ipo2aTTmlxfNUmfcP+N+q/DDQE/SrBzkGd6mDsty9BEioeeHxb91qAi28FXY8SSJZ3F6MSNvZn0cYOAmpp3QebxcWyumroaCL/1pr1O0vdxcKzS2WSnMRhgoYvWNqU8Cu+y3p5JCSyrcgvHR1tL9YG+8hZBlq0pefAochIbdXtRhNZXSkp+Yln7eR62Uohc5EVZY2gWBANUspgewOw/Ej6UsJ3W+YY9kKfmd9VBR2TuVqqn+71cbGsGObUhOtWzMIHR4ByAhVYtHs5dVNgviGfT6j+w==
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f3::10)
 by OS3P286MB2325.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 10:43:00 +0000
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7c33:300a:6339:781e]) by OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7c33:300a:6339:781e%7]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 10:43:00 +0000
Message-ID:
 <OS3P286MB2597F3FDEAB7A1CC886F414798582@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Date: Wed, 28 Feb 2024 18:42:55 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BbRKNf1DixLI0NCSCbUbEI0Q"
X-TMN: [Qml3pa6gpilulxWG0A/E7vtXaXPOdEgyg8wy0h+cE93sWrqKkaOcyFgJ3Emp2bL5]
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f3::10)
X-Microsoft-Original-Message-ID:
 <1c386e38-03aa-4798-8f4a-3a57c72c2e9f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2597:EE_|OS3P286MB2325:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db20820-4c61-404e-7d93-08dc384a08bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mozr7T9SAJD509tozCbTdWDdIKFvP0Jp+jVCs7xk70mQGFQErpiR0LQCxOJKF9wDwMsuiMGLWo/dHJXZUdxaZbZBC1TvlThZ3ocIX182jwomWCp5+5L42Q9d9P7yqWWNJFU+ziam4Ts1irg7kP2eXaESlM1rUtyHPIYrtBaPpskmhYzxeD6oiFfvRshvuGqYsh5TwYCMQ4O91nMs8UoksdA11FgnjZpL+ktlFkaRk/8P0HIii6X9o9vpihwAaBeL0MlJqqqoR/u6DD9nUXeqVwskSZEOSX8LxsEoAErEiwsLULWV+SoI3hi87Jl7KECfVevVK1Zu4ULx50zs814XfvXfbM09THMAwYzjoD5RlKKyisrneM2UIlb3YXFa/Og89Ul/IBtBsREagyrzDmqP4xrhrraGaJUNQz1aUSMuPTjgd6kl05Yi0g7mAEc6fZJF5DZ+aOOV9tKuWDGWhQseyCGhWIVJ68DURxAdW/JFI1zGRVSQFt7p4VUOIRCPMjHKKaNRonkXP3SpPUkSdSIUs4ii5C80N5eX0qHV6it18jQw4PVqBuTxWHgRjXApBuYHCYP19O4sHvKPncg/Lk6CeTTH1ofxtBaLJCFLlX5BaosEM9q0o6dtGGfw7OkE6uNez2/XVjfg2o1N67sg7kZavg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZMZHAxK0hTYmRneUFwcGNMZW9abUlyUkRSRkU4bjl1L3M0MnkvMGF0dUxq?=
 =?utf-8?B?a1BBV2VmOEt0MmNoNEt1U2VnTEZVeGRZTkR4OEd1RHZNaFJhQ1J0SXZHUHFI?=
 =?utf-8?B?WGVQZkFQMys1N0lTK3FyTm5GWHNtQU9oVDQyTHRKcVdWWTZDTE9QcUV4ck1i?=
 =?utf-8?B?TTFPbE5Md1llc0NRZnBBa1FtZHhrc29VU0pIRW1kTlE1NFdiZUxLejd6WjZQ?=
 =?utf-8?B?b0lGK3ByMVZwdFY1b2NacjVIbFgxU1RyRlhMZERmRjdLeE1VUUZ3SVVFSzJq?=
 =?utf-8?B?bUVST3NoZGczM2dHZnVBQW1EV3NoZ0xkeG84OUxCOTROVVpGc0FsZ0R0VXFt?=
 =?utf-8?B?YW5LTlZPeHROTEtvUk5rNnlDTGo1RlBNUUFVYlo3N1AxcDl2ZlRaSXRiV0Y0?=
 =?utf-8?B?TEtVTi9yaUhqMURKUXkyOEdSSU4ycFV3cmdsd1ZNZzVjeC9VVld6QjFlUnEy?=
 =?utf-8?B?dUl5R3lJbjNHYmdZWmd3VDF5WE5NdlovZ1JHSmVvR3BwQ2swZFRaeFl0TklD?=
 =?utf-8?B?UldBSEZSYmM3TUpWZGhZdHlWZHhoODhpdDdOTmpFVE9LVDJ5NjE4dEdRRVFm?=
 =?utf-8?B?WkhLYXpZcFZud0VraUduZ0RFU3VoVW1YdlJvWW9pSGFrVzkzNFZ6b1ZSVGM2?=
 =?utf-8?B?c1FUOGlzdHZvTTRDamxlT29ZWEJkVjhuQThpM3FpWkp2cC9kVWlKREQ5c1A1?=
 =?utf-8?B?cFJFYkl1dFVrZGxQdFBzU1lVMFpYRkNCekp5Uy9Qai9WcGsvSTcvdWpnRUps?=
 =?utf-8?B?NTRXeXBKZ0wzRENDOUV4aWFzc2lVa1greUp1QlczVDBuTVp4L1l2MkpYSFRO?=
 =?utf-8?B?ZjBuaTBlZDhMcFZyYkJDVXFVOWV5YmgyR0RpQlVSN0w1ZFgyeWNReHZ4ckNM?=
 =?utf-8?B?OGxaaXdNWU1Pc1B1T04xSDViU09XV0IrUjBBWStNbTFGTXdzRlJxdmtJa1Q0?=
 =?utf-8?B?VmRyN0tjRG9vc1JoQ1JTb2QrNGtiM3JmQ0VPODFXWEM5OTRkcWZXT3llVDNa?=
 =?utf-8?B?ekdRa1R2eHFIdVVBOGtNRmxrOVc4YnBYc25ZY1B3aEtZN0JNTnpMWkgvcDFK?=
 =?utf-8?B?TytwZFU4a2M2VUNtN0sxR2dXVzJmOHRyWlJKUUgwTGN1NXZUZVpDbkhhWTk0?=
 =?utf-8?B?ZVNuS2h2aHREY3J1bC8yQVlwR1BuZWJuUUx4UHgxd3lremxQL3p6QkFJMlV0?=
 =?utf-8?B?YkhHeDM3RTZDMWNMWklpeDhNTDdPRHl4TkRZd0ZjemtkdG0ySDB3YVBRNElT?=
 =?utf-8?B?VlVXNmZUbVRDZlFRTUErbjdkR0NmakZ1ZnlxbGNwYXNDOVZ1V1pzc3VVK3Zr?=
 =?utf-8?B?bnNpNjBCc0JnMnUzd3l1cXlISnNCTFFpekxNZWJRZ1hvajhrVlM4aVc3bStN?=
 =?utf-8?B?UzQrdlh3Z1lXcDBuTGk0SHUweUZNZ0dQVzZsVDBCR3hXQko0alpUOHFldnpM?=
 =?utf-8?B?OUFCUFIwQ0hFV0pGb0NFZnlESU93S3dkTE9aM0Q4RzVJSnRtWWJ4d1NFemtr?=
 =?utf-8?B?M1JmS3R4YVNEcmRtWEZlNVR6TmpMaGdPNjd4bURiNVQ3WXR3c3NEL0E3dW11?=
 =?utf-8?B?THZUTjZhWmQxTzJJWWRvUzkydDc4T0EvWG15SHFaOVd1SU1aTEJPZVg0WHVU?=
 =?utf-8?B?c05EUGowdFNpeEhDREFxRkhSVElyaHQ1am1kL2dtc3R4L2NDb1JOY3lEZGpO?=
 =?utf-8?B?cUYyMWpMWEsxdlgxYTBQUnNsSFNjdzFZVXhPRTFCaFZDdlVRUEJ1WkFydm9k?=
 =?utf-8?Q?6W86+qp4HBCeE8jmKI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db20820-4c61-404e-7d93-08dc384a08bd
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:43:00.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2325

--------------BbRKNf1DixLI0NCSCbUbEI0Q
Content-Type: multipart/mixed; boundary="------------DZ6xKdaDvYUIQEkbM4nlOYLg";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: wiagn233@outlook.com, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <1c386e38-03aa-4798-8f4a-3a57c72c2e9f@outlook.com>
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
In-Reply-To: <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>

--------------DZ6xKdaDvYUIQEkbM4nlOYLg
Content-Type: multipart/mixed; boundary="------------x5yJo8BxSjasBcIzFOjZQ3CJ"

--------------x5yJo8BxSjasBcIzFOjZQ3CJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUnVzc2VsbCwNCg0KSSBnb3QgY29udGFjdCB3aXRoIHNvbWVvbmUgdGhhdCBoYXMgYWNj
ZXNzIHRvIHRoaXMgY2hpcCdzIGRhdGFzaGVldC4NCkhlIHRvbGRzIG1lIHRoYXQgYWNjb3Jk
aW5nIHRvIHRoZSBkYXRhc2hlZXQsIHRoaXMgY2hpcA0KInN1cHBvcnRzIGEgcmF0ZSBhZGFw
dG9yIGZlYXR1cmUsIHdoaWNoIGlzIGEgUmVhbHRlayBwcm9wcmlldGFyeSBTRVJERVMNCm1l
Y2hhbmlzbS4iDQoiIFdoZW4gdGhlIGNoaXAncyBTRVJERVMgb3BlcmF0ZXMgaW4gUmF0ZSBh
ZGFwdG9yIG1vZGUsIHRoZSBTRVJERVMgc3BlZWQNCmlzIGZpeGVkIGF0IDIuNUdicHMgYW5k
IHRoZSBFdGhlcm5ldCBzcGVlZCBjYW5ub3QgYmUgaGlnaGVyIHRoYW4gdGhlDQpTRVJERVMg
c3BlZWQuDQpUaGUgU09DIG5lZWQgbm90IGZvbGxvdyB0aGUgRXRoZXJuZXQgbGluayBzcGVl
ZCwgYW5kIGNhbm5vdCBjaGFuZ2UgdGhlDQpTRVJERVMgc3BlZWQgaW4gdGhpcyBtb2RlLiBU
aGVyZSBpcyBhIGRhdGEgZmxvdyBjb250cm9sIG1lY2hhbmlzbSB0bw0KZW5zdXJlIGNvcnJl
Y3QgZGF0YSB0cmFuc21pc3Npb24uIg0KDQpJcyBpdCBlbm91Z2ggdG8gcHV0IHRoaXMgaW50
byB0aGUgY29tbWl0IGluZm9ybWF0aW9uPw0KDQpCZXN0IHJlZ2FyZHMsDQpTaGVuZ3l1DQoN
Cg0K5ZyoIDIwMjQvMi8yNiAyMzo0MiwgUnVzc2VsbCBLaW5nIChPcmFjbGUpIOWGmemBkzoN
Cj4gT24gTW9uLCBGZWIgMjYsIDIwMjQgYXQgMTA6NTE6MzZQTSArMDgwMCwgU2hlbmd5dSBR
dSB3cm90ZToNCj4+IEhpIFJ1c3NlbGwsDQo+Pg0KPj4g5ZyoIDIwMjQvMi8yNiAyMjozOSwg
UnVzc2VsbCBLaW5nIChPcmFjbGUpIOWGmemBkzoNCj4+PiBPbiBNb24sIEZlYiAyNiwgMjAy
NCBhdCAxMDoxNjo0NlBNICswODAwLCBTaGVuZ3l1IFF1IHdyb3RlOg0KPj4+PiBIaSBSdXNz
ZWxsLA0KPj4+Pg0KPj4+Pj4gT24gTW9uLCBGZWIgMjYsIDIwMjQgYXQgMDk6MjM6NDZQTSAr
MDgwMCwgU2hlbmd5dSBRdSB3cm90ZToNCj4+Pj4+PiBPREkgREZQLTM0WC0yQzIgaXMgY2Fw
YWJsZSBvZiAyNTAwYmFzZS1YLCBidXQgaW5jb3JyZWN0bHkgcmVwb3J0IGl0cw0KPj4+Pj4+
IGNhcGFiaWxpdGllcyBpbiB0aGUgRUVQUk9NLg0KPj4+Pj4+IFNvIHVzZSBzZnBfcXVpcmtf
MjUwMGJhc2V4IGZvciB0aGlzIG1vZHVsZSB0byBhbGxvdyAyNTAwQmFzZS1YIG1vZGUuDQo+
Pj4+PiBUaGlzIHdhcyBwcmV2aW91c2x5IHN1Ym1pdHRlZCBieSBTZXJnaW8gUGFsdW1ibywg
YW5kIGNvbWVzIGluIHR3bw0KPj4+Pj4gZGlmZmVyZW50IGZvcm1zIC0gYW4gT0VNIHZlcnNp
b24gYW5kIG5vbi1PRU0uIFRoZXJlIHdhcyBleHRlbnNpdmUNCj4+Pj4+IGRpc2N1c3Npb24g
YWJvdXQgdGhpcywgYW5kIHRoZSByZXN1bHQgaXMgdGhhdCBJJ20gbm90IGFjY2VwdGluZyB0
aGlzDQo+Pj4+PiBxdWlyayBmb3IgdGhpcyBtb2R1bGUuDQo+Pj4+Pg0KPj4+Pj4gVGhlIHJl
YXNvbiBpcyB0aGF0IHRoZSBtb2R1bGUgX2RlZmF1bHRzXyB0byAxMDAwYmFzZS1YIGFuZCBy
ZXF1aXJlcw0KPj4+Pj4gbWFudWFsIHJlY29uZmlndXJhdGlvbiBieSB0aGUgdXNlciB0byBv
cGVyYXRlIGF0IDI1MDBiYXNlLVguDQo+Pj4+PiBVbmZvcnR1bmF0ZWx5LCB0aGVyZSBpcyBu
byB3YXkgZm9yIHRoZSBrZXJuZWwgdG8ga25vdyB3aGV0aGVyIHRoYXQNCj4+Pj4+IHJlY29u
ZmlndXJhdGlvbiBoYXMgb2NjdXJyZWQuDQo+Pj4+IE5vLCBJbiB0aGUgZmlybXdhcmUgb2Yg
dGhpcyBzdGljaywgdGhlIHNwZWVkIHJhdGUgaXMgY29uZmlndXJlZCB0byBhdXRvDQo+Pj4+
IG5lZ290aWF0aW9uIHJhdGhlciB0aGFuIGZpeGVkIDEwMDBiYXNlLVguDQo+Pj4NCj4+PiBI
b3cgZG9lcyB0aGlzICJhdXRvIG5lZ290aWF0aW9uIiB3b3JrPw0KPj4+DQo+Pj4gSSBtZWFu
ICpleGFjdGx5KiBob3cgZG9lcyBpdCB3b3JrPyBIb3cgZG9lcyBpdCBrbm93IHdoZXRoZXIg
dGhlIGhvc3QgaXMNCj4+PiBvcGVyYXRpbmcgYXQgMTAwMGJhc2UtWCBvciAyNTAwYmFzZS1Y
Pw0KPj4+DQo+Pj4gVGhlcmUgaXMgKm5vKiBpbmJhbmQgcHJvdG9jb2wgdG8gYWxsb3cgdGhp
cyB0byBiZSBuZWdvdGlhdGVkLg0KPj4+DQo+PiBXZWxsLCB0aGF0IHNlZW1zIHNvbWUga2lu
ZCB3ZWlyZCB0cmljayBpbXBsZW1lbnRlZCBpbiB0aGF0IGNoaXAncyBTREsgKG1heWJlDQo+
PiBoYXJkd2FyZT8pLiBJdCB3b3VsZCBhdXRvbWF0aWNhbGx5IGRldGVjdCB0aGUgc3BlZWQg
cmF0ZSB0aGF0IGhvc3QgdXNlcyBhbmQNCj4+IHN3aXRjaCB0byB0aGF0IHJhdGUuIFRoZSBz
eXN0ZW0gbG9nIG9mIHRoZSBzdGljayBzaG93cyB0aGF0Lg0KPiANCj4gVGhpcyBzb3VuZHMg
cmFjeSAtIGJldHdlZW4gdGhlIFNGUCBkZXRlY3RpbmcgdGhlIHNwZWVkIG9mIHRoZSBob3N0
IGFuZA0KPiB0aGUga2VybmVsIGNvZGUgcmVjb25maWd1cmluZyB0aGUgaW50ZXJmYWNlLiBN
b3JlIGRldGFpbHMgcGxlYXNlLi4uDQo+IA0K
--------------x5yJo8BxSjasBcIzFOjZQ3CJ
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------x5yJo8BxSjasBcIzFOjZQ3CJ--

--------------DZ6xKdaDvYUIQEkbM4nlOYLg--

--------------BbRKNf1DixLI0NCSCbUbEI0Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmXfDi8FAwAAAAAACgkQX75KBAfJsRnT
vg/+IhmHWjnPkXUagD1OfJSWdILoTU1lN/rkkWEf4VRkjyE5tlHVQ3UA5yHl5Mn7Ocmvjhm11h2u
JrthdNOpk/yB4dEUciIrlwTb2YB7USaYAABvNfLkZzo3dlIpRIn02e8FqX08URGr1qP/EJbqbvkx
JYtb2IEOpiDO+u/AexVql1bq9M5YqgTJK08ET3fqpU2yk/t6Tjv7Sg99H1ROj0FAZg6urylU1uNK
wY6koxNE7xdJUxrBTHPFCtuG+Pj4JCvSc+xT61lj6WiGJcLN3e1Mo4isj9UbDXkBGr3z16//BCT/
2wAWL26tfVC8KNVXdivktVehfVzI62BM8pHSo81gFuyEZaNB3CUXnLMfH7XksrJKjp/uR+3GVFMS
ghMxDzH1Kl+XdyYaLCXpkenW1iGo5E7y7smMxZDQ63ByTyD538uaUH+bGdnlxGSYH2QAmcku/7kl
u35BIOKxQis2g+64s0c7wySUDfo3mlEZ2phQ5227dPP7dvyGjcUScA7uwyUprfdk6zxNgzUC1sdF
sIcPDIhre8qFypK/1oifOAUC86yOEOECEVExQoZhmAnh6SNOfaGfVp0QUeyJdIJiXOSzHrHs4d7z
IHGX1SxPUii2EBDipMcFKIdLqZGQCClxEt/zB4M2VTSVpICnij2XDs2tAZKMA/EFOKSrDMWjOAGi
U3s=
=TuCk
-----END PGP SIGNATURE-----

--------------BbRKNf1DixLI0NCSCbUbEI0Q--

