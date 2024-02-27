Return-Path: <linux-kernel+bounces-83022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2609868D61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5033B1F22B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA41384AF;
	Tue, 27 Feb 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="a5y/i2Fq"
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2112.outbound.protection.outlook.com [40.107.135.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B051384A7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029293; cv=fail; b=Mb1uiWWzh4cQcSsV0qki7DPSq/44Kj/TlvHT3VINkSxES0oZ2MSVYoL9dnsgXjZSycKZrxNaxCXd95KuFD5FKH6ynFSvrreSo3TRb5hUGLJlJ+196+WwWwL4iqYKKF0I+x/9ppf5i7MPEA0OEE6N3oqwIq88FrOm8GtPytZPSt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029293; c=relaxed/simple;
	bh=i/nJ1lu1ck1eKJJJY3qDWvqlGFMnwdaNdHw9NtVOwyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KUl9nnZfrRLe5i8XwX07pf0pH+eawUvIHshAnU1N1Iu1eYSC4ZvKeWAOg3m1xqblJr5ncU+u1Oe7iXK/GaR4HIwII0iKnRxjJI4j2BPOkkn04GJvaaYleghItKBzJkqfPHR98KbxEuoWdi3vd9SaNh/hRpyg+v/qlX+P1fozajY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=a5y/i2Fq; arc=fail smtp.client-ip=40.107.135.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvrLWSUoMuJeDWgXXWq5p36anVGny10/rPwg+uyHOeunZiRrfR+yV6moKGx9anllvSNY40ygrXf8Zbm60hSroNsV7qmaf6MNm2U02QTInGI6Wi6AEBiuN8A5/Snm1r6a03Hxarl6tS+tlMjU+ZiQPlf6+DYy4X9tOzehpgGwdqes6fT2YavZE4X2J28O+Xe7f6tocGTk9Hc/pPT8pWVvOS/FlNzQKtw6vwq6xhOoopGNScRLK4kejYuM4MZLzoneQBSYYPPmfMKALhGMB5O35DFqcDRzSqiWg/oZT+vM1o7VDmOdOsfYrYO6stArrqP+uaOpA2iN84KzMYccK94ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5vo74ZzwUGR5gFdRgwiSkBeLziGo/Mr6tFY1EMBc2I=;
 b=hD5QogvRhR2NVjgRSQcB+mX2M9xJHAeCz83CK3NS/n1/SXDDp3wY93scsJIUZ/LLCPuf14mIgviFCaic+4xNDsPvmjEmXSYEeExbEndTPNbtSqbT8ECw89B77OqM2567vrbjswtrRJ2YjFHBCxdZ4jYXQIHs3JAR8QmYNaMWRTzbQhk62GLSwXHkNJAzPMhBsSYbcRDCjS3z26F8bTf2DPiBQWeMDxVBa6L3PQCPNE2clFVbw1QNhvuvvlpVuV/gdIr3wxzM2Nkk29lOTOa1+LPlKgWsRox65EHWITZrCNma8ifSW9AN7j5WiSTM2AItsxjtNRAzfKKw1wB6vfnDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5vo74ZzwUGR5gFdRgwiSkBeLziGo/Mr6tFY1EMBc2I=;
 b=a5y/i2FqWC07niZtqYEIjRF+ZAB47Sy3J/7YYrSXmNniDqkkAsEAYxAlf6KsVojTCKapDBMHWK1oJJUqSn5so7Chk7uppuJtpOZ6T1wNGdcG8QaINqt1dSyu0yaYgiwTtkKdFas0la7Y2wWHCXzkKCqunTNdQ5au5f4Rvg2b7VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR6P281MB4000.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:116::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 10:21:28 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f812:c649:c5e1:509c]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f812:c649:c5e1:509c%7]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 10:21:27 +0000
Date: Tue, 27 Feb 2024 11:21:24 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] siox: Move some complexity into the core
Message-ID: <lkgvr2t4wzw4jkfg523zcek6y2v5l7kj6onw77yffvvs7i2gfy@6ectsjpcg64t>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR6P281MB4000:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fb7257-3c85-4b9e-4874-08dc377ddb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0yVpR8xaE8Glv/zsNYCurZAzThZqi/lkqN/+9eYbonkKUKRhTYeWsI8CRAOR7c0yONEy3phv7mUhIwYTWd5DYu8QRS3StHZPtr7Mo0iSTwS094udlfqlOhteFhZ4QmdPa48dfKNz+c61gI106YlOTmWLrsxJtj6UfCWA/Jc+R1JPPwf7OAgFYUkQVrjC/6c41kBl8VeCPlIxFwFwaobVY1uz8ry2z7iDWgTo8zeeLewd5Qm9ZxU7559IjJZ0flNQUPResAh3F3rvCTEmp7Q8RCylBY0DQYQT6IIcti/2ppWu0IqsTZFmEcMd+KdX6W5Mcv0ThXIjGuw1JmtdYER7x79r7rghtrDPgV3Y1teMRweuqvHWqquYvhhZ4wtbj+bAwXoB3dpX+yk6bv2vo/1plBktBGkSCqQFN+so8UT3j1eQG1cirZwSVTVp9psWKMJFEJ40QZ41dnTgyimVknf/zzR99u8LyiBjy2q/pSvRZCd+9CQBZb7LbLS3GYmkaTxuMGLeNpZ3fgp+hAXPwR0E3fo76X3tS3/t/rvzsySlcLYuaDNUx/hvsBcbm1VEeoYP3w1iCHzdXmveirkTFiDXEyXYEAXhmtOsw/e/M33vdyaaPBHANqj8JoyEMzOe3xKz7dwEEnhbgwOHY96qr4kYHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?qkyPDPswgYfJYbO6gp5QVccVNINfbdg5HfX4qU/rFYUMkyS2XH8JJVrXRE?=
 =?iso-8859-1?Q?IK9aOz23SBNaitXTQRe5UN7l+TyQyt4ECC0IikyhkdbnykYDAkw7H9qpog?=
 =?iso-8859-1?Q?SefBDl+Del6sv2nstW5YJvU6e7vGLBlkqdmpC+nhlfi8fM75SERcCMORzX?=
 =?iso-8859-1?Q?Jq3Pl4w/92/5ZUPYH6COvxG4vPi0TteIJhhQ6Abl3a17fuwN1W1M9C1R+4?=
 =?iso-8859-1?Q?7IQjrJeA1egncBWuSDyHUN4y9mr7LDPYc00Iowrh/0+WuBSmw2LJxoRrkn?=
 =?iso-8859-1?Q?DuIXSAm8HFdQQqXwqtU1ev86Itu1YFxI9JVfrDPx2698F5zvoil+dppbor?=
 =?iso-8859-1?Q?EGFoWzVAfNzKC78+HovkwrheEFFObOWYaD59BeOw0z5LW6L2lDxN9erU3Y?=
 =?iso-8859-1?Q?FlPh5GeJsLqiHt/FGtWeqsgUd0jfekpB0w6Olb7EBYatZjzyAy/clxBeJs?=
 =?iso-8859-1?Q?nsIvVPca7D6qn/NpHPHkbPRd+Lxbz1mpbaPd02hhmTdu/C6/jxOb0PB1a3?=
 =?iso-8859-1?Q?qSEYgD/VYg162tkqgeiitH3uiW7F2/X/Omu4/Cry6SxEC/Bl9vNEnad4gU?=
 =?iso-8859-1?Q?B18NCzjBkVUC/2TMFxLrCk3APVJBlY7GPdaIs+P4eIF3V2sD9GDBZ+JjNj?=
 =?iso-8859-1?Q?vUxZmuQayu+rIrRrMhars9ItEqEDSelyl5pIiR/xoRzwVjl01EmFiMmPMH?=
 =?iso-8859-1?Q?XExKmJ7Cw8tGT/KDbaR9Ds1dVM74Vwgmhf3+laGjAhMEDZc+pZGWM8XMpU?=
 =?iso-8859-1?Q?ft+PkDDu76D3XYPKJVXFBHrzKu0PyXxiAgpjUVPjAKvZvLUeH7d25pgo/+?=
 =?iso-8859-1?Q?mpYi5Zi5EO73pOmXdpeJ7fsLE4s8kdxUyw0H2ok2wxgk7Q+HJmDUJx/G0E?=
 =?iso-8859-1?Q?tGdne2hygtA3xKkiz+f9a/eRzv614LCR0mRTK2QOLFZc4unq+KMbxoH2bc?=
 =?iso-8859-1?Q?QzN6iaLgb6FVbTFA5H0lBjQB2csumhxAVNk1AuBxyZpYLO2sfbNqMoEBVl?=
 =?iso-8859-1?Q?qZAeMattle4yY+TFYHcMxeKpYypzNShuBYGNAJ0t9AsE7ProqVKA0mOOD+?=
 =?iso-8859-1?Q?Mxi8a6kpFi4TGq0TsubJsN/wum8U/srMSY9UW+XsT7kw6sE7RZTjbttBmE?=
 =?iso-8859-1?Q?vLP1xuS7GVgd7UrL/1NwPO+7OF5S4fz65JM1gbVWR8Zo6vdKahEDZwdlkq?=
 =?iso-8859-1?Q?bamscEn1UVbjUzxUZjFynbDbCs8i9RoTB3Ixdbr1IA6uE6d/NlA/P2uGIb?=
 =?iso-8859-1?Q?wOwASfZUxWaS9rpXkylzcacVhOH8vbv+rJ0shXef/iZX7YAtHwOh2oFzje?=
 =?iso-8859-1?Q?VUU1RrltBc9lrs3vWsrqY7MR+gCUdgLClwihiXC+b4BdHHc4J5fIWs3xnI?=
 =?iso-8859-1?Q?FmO5K3AJJNHb1/QlnLfvVrOFZarl99coPbUb3Y2eIIFCgOR7NBHo5rr3J6?=
 =?iso-8859-1?Q?+5X+pCkCzXcQZvYwKCW+wiPLuk1sq56pSqgEotQfdQMSZw8Z+ql9fQZ9ko?=
 =?iso-8859-1?Q?6JsMEjiw1Ts6ZiwbFGMFED1GQO6xM42Odz6BB7VOfgvL3mh6VKLHmmF4As?=
 =?iso-8859-1?Q?r0Nke0WpICSQBUqh4vqTRtYASGIkAc5voUwRFcdHqNdqj1Ohdy17YdhVun?=
 =?iso-8859-1?Q?sxIsSVFJAxbysUXecZ7ommUC9pTBXj7f+G?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb7257-3c85-4b9e-4874-08dc377ddb80
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:21:27.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pky7cUfQe/oZW/gtstBGjKxJwbc2a9pcSujziCxFcOtLAJz27mC86+FPpJ1Kl31vySjvSbiHXj29ezGXu42Zfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4000

Hello Uwe, Hello Greg,

On Mon, Feb 19, 2024 at 08:46:28AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> the reference handling in siox is a bit strange. With
> siox_master_alloc() to get a reference on the master that is passed to
> the core calling siox_master_register(). So until siox_master_register()
> is called successfully the driver has to call siox_master_put() in the
> error path, but on remove siox_master_unregister cares for that. While
> that technically works, it's unusual and surprising to use. This serie's
> first patch cleans that up and then introduces devm functions to make it
> even easier to use.
>=20
> A nice (and intended) side effect is that the gpio bus driver gets rid
> of it's remove callback, so I don't have to adapt it for my quest that
> changes the prototype of .remove().

I only compile tested this as I currently do not have access to test
hardware.

The series looks sensible.

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

@gregkh: Would you please pick up Uwe's series as well?

Thank you both.

Best regards
Thorsten

> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (4):
>   siox: Don't pass the reference on a master in siox_master_register()
>   siox: Provide a devm variant of siox_master_alloc()
>   siox: Provide a devm variant of siox_master_register()
>   siox: bus-gpio: Simplify using devm_siox_* functions
>=20
>  drivers/siox/siox-bus-gpio.c | 62 ++++++++++++------------------------
>  drivers/siox/siox-core.c     | 45 ++++++++++++++++++++++++++
>  drivers/siox/siox.h          |  4 +++
>  3 files changed, 69 insertions(+), 42 deletions(-)
>=20
>=20
> base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
> --=20
> 2.43.0
>=20

