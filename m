Return-Path: <linux-kernel+bounces-158934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE808B2719
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458491F225B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F914D701;
	Thu, 25 Apr 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="ykxfozSJ"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2090.outbound.protection.outlook.com [40.107.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406C14D6FA;
	Thu, 25 Apr 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064668; cv=fail; b=ZP21rdvfr0PXW8ghmriejtwU/Sl2ZH0LDM+KjndUv+kIpWUuW0wgdeSSPYXIeTo+RNboh4sPw1TS8UniE8HcHKKERFNL/CBMhjdhEszfX9ioKF4aNXHCDkRmOEPmhN8ZwYaJEbG7i0bBZWagvlHUPnH7q8oi2CSo8P7a0tNdhL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064668; c=relaxed/simple;
	bh=Ig2WV3a9YT6wJGVSPbB4MuhrCoXNcq0lLgRa1OsPS1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HalKzVg5gtc+Dv2a9LQBT7GBFME2iPRpvmB2Uxdw4xr04ReTAObfytk4OzAOKZuKrEvIO/ycg0rJIoqo9M3MarZVwlXYNN8I/g+gMYXIG819mhAe5FSdjGNK2Qsvon1ZtpD0/CicmFeQrf9DqJzxIZxvB9Q0FoN2lTaSkt2r4ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=ykxfozSJ; arc=fail smtp.client-ip=40.107.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaDHyoYE7v/qjEwGkSIeCSFalFnT1K79Bsp7CoA2rAHK4TE8L7GLuO8T1O7oKO16hBfa7HB11bLtJkHRR329iktxJLbXxwpBB00CZHF/kiY59RSsQELLwBfQPB09WyYFjp6yxrryt2pMo/JdadQewEhAH9m5oI7H/0yg/C/aM4VotowUV30/thK2D4dcm6gWumMmKTIJrjSaubC1t3chFQWYMKxLaOIqixhctUhm+084NWMoPZwMlchxLnFbcrt+3KuJLfl8ErNTcJ6iIXYxX2OzBjW+luAAI5rg37Ilwv/6lK4PadZmXXq+qt+hgjrp9G3yAzRY4ma6BvkhvJE12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLTH3vlJ1KHXXfOEB7mJysN8Fz4erf3d8L9FnX7yy8A=;
 b=h7ICY77zFOTaU5ztSF11CpVYMP84fPM5XcGHuXkHxVIhmEKipbIxOwfNBV9fVMXeLLAf8pKX1oZAyuSES/A/9MKakdzckIxB7v21N89mjNT8HhkiCm36pJCYaisFZQhINjq94dr2eKm2JKWplsmphcWgOXCN8xIGKe+kYrlj39X/y++7ZNJFjAn7j8YRJ7+xV4FjrLDD1/QQWA3Jcj6BmCZCmStV+spjr/+tQg7i7TT0lsNAplZPUAbunjzR4EkXJL1q4J/0o4KvFPCHLzpAAXi+Gl8YHkcbFEFjCqU+nFO1OqGlbbrsZCHh27qTDv0RRzsYz38pxdFETx5PqSsZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLTH3vlJ1KHXXfOEB7mJysN8Fz4erf3d8L9FnX7yy8A=;
 b=ykxfozSJHCuTZMKJcMY5uEnxHzOsmL9XixnLZDT1U2i0zS+00R/1BW+HSmzxZ8oBYBkAVuhrbMr4cfwNRAaumeQT7HmD0PZTRkgkIDc0U/9Je7wu43/PqF8te57Fz83cGxaNCGCuwD6fPT0OkWhn+gmt6soXqhmpIhWsOjDWANo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FRYP281MB3305.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.11; Thu, 25 Apr
 2024 17:04:23 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3c3b:8bee:9e1a:3579]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3c3b:8bee:9e1a:3579%5]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 17:04:23 +0000
Date: Thu, 25 Apr 2024 19:04:21 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: Update Uwe's email address, drop SIOX
 maintenance
Message-ID: <qmcthzs3jfhunsu25ps3dv47hroyvws452rzl25n235lbarnxl@obtnzeh6sbsm>
References: <20240424212626.603631-2-ukleinek@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240424212626.603631-2-ukleinek@kernel.org>
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FRYP281MB3305:EE_
X-MS-Office365-Filtering-Correlation-Id: b650ef29-5614-4d5c-010f-08dc6549c144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?uvAqsNsIs9ZcVQ2Fi2tvwE8ZIvEfp6juLYXejLglnQL0SLrjX0zPRdY5Qx?=
 =?iso-8859-1?Q?gjvkuj2M6/pakvMaQoBC2XsrJnDEpB5BIRQonh8LUBfZLt1c7PCxZ7ZlVq?=
 =?iso-8859-1?Q?Isgi0JD7LzX8O/PGtKKSgbujOADPgjDkmbsNxoZEVZU3VDbrSZkPpOyywm?=
 =?iso-8859-1?Q?piOVtQe4obqrAkkUnHi18XHw9dY+RqIeiPWdoxF5/QYZQ6u3RwzCk302Y2?=
 =?iso-8859-1?Q?+V3lKvkEAZ+DL/3IwC+rnK43U7VqV1jq20b/a53dIlKIIfHqqBt3n1Dnjo?=
 =?iso-8859-1?Q?z/vI4T2OXFrq4zmdxV1ZxABP49bRcxOz69i7igPem6nJZjXIuatr9gFbJN?=
 =?iso-8859-1?Q?2uYWwGiT8ZTiOhenzCEcf78xEopk+4MTpMBwtoTmYJzMGgFX0VzdnsXfzN?=
 =?iso-8859-1?Q?tNj71j5lcoliDyHdxmzN9zVhCyewg6zz+cij1jvKBOHcuorQbTcgNYhw5F?=
 =?iso-8859-1?Q?rSI4QIWKbtrXCEIvba1AkdcEr8X9B5xK7t2UiPRppdhtdrMZDDFptFWZC1?=
 =?iso-8859-1?Q?DOu7m04XTtJIO86xfXEFz/K75iKAxabNsUReDktLMuu4C+IBA1om2QFVIU?=
 =?iso-8859-1?Q?LntGeecW2ohd3JTzbPf5M/Z8dhpny1DBZS8o+U7Sxmf4ze8xaN0wBU/9fz?=
 =?iso-8859-1?Q?3aR0MOeyqk0M57Vtwut+rr+tW+uwLdIUJC70FoQtLNZjAS9OJpLVg3VByj?=
 =?iso-8859-1?Q?1yVEUubAP1JtT3E584L5cQbwgaRsnvjKB4GhFzBbR7eWXLuxMtOxkQmGWZ?=
 =?iso-8859-1?Q?q2e1Om79KDpWKRKyxm+QK3DD7Lr5+H8pgzJ726t4YBD63cUO2zcwnha4QC?=
 =?iso-8859-1?Q?I8cB8wulGULisqHUF21WA9UXL6dSlwBCzHZtBI2ZDumA37XBqdOauHZd/X?=
 =?iso-8859-1?Q?Z/zag1v1dC+B4hlkKwDSRx/tovScjXkwBQoDqj7oi84J/5sYfB1cvsUpMB?=
 =?iso-8859-1?Q?T7VrnvxLbde2M6+hF2rLlp/dQal/iZPp9nzretrCLDzz9P0czIVCcznBok?=
 =?iso-8859-1?Q?Ri8qDfWzPefPE16CCR59kvm3aN9qqgoTNuQtWaUhKao5yxIpq8zgbZI3Lw?=
 =?iso-8859-1?Q?NmnQnnew3gM0i7CnYUxf8gqV5KPIs4QKntF9JbbWSH7hjN9y+S3cYUpdF+?=
 =?iso-8859-1?Q?C7U9cVSL/80LDLiYsNclk/y/YCSl7cOEKz3Es42nmRFaM9F2R3dDo+egNd?=
 =?iso-8859-1?Q?hcHWnOKM7vZenu6mufHGLQwVv45Llz+Ga3KPE9JKzD9mJIR+bp6NyPA8cE?=
 =?iso-8859-1?Q?38iTCNfGdtHUJS/HXkIZSje8MBXQw7RsYISXaDcgqcIqreY20GSFVety0c?=
 =?iso-8859-1?Q?csbY0xvtsIsuhuReBM6gOPCFnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ecRPAAf0vqqdCOz15TMEOQ06/B+9kLRoudldovad0HmlX0BcFClSs7ow05?=
 =?iso-8859-1?Q?dHOdvnGzlHxzlW0e+BaBbvcBFyasLrQpbhdjDDgjws5lNuARqLRp0c1tcr?=
 =?iso-8859-1?Q?v7ZTqQmyRPex8aaq7QUzoRyKfZjGol4tayarfKPqu+o52oou/Vo2AwguCy?=
 =?iso-8859-1?Q?eLeV01H5qsEIuakqM9sM715Ni+T5335fSYZtDnro3JYtf0MVAZFZLTEZ3K?=
 =?iso-8859-1?Q?X/S2YzzhPbjKQ4PYiiHt7Mn/4skkGAnW8HDi6AtEpORlttimQT1x4vzlRP?=
 =?iso-8859-1?Q?ebviSgDhM4CbfVCIObJJJe6EttVVFepkAzli1CsejQOfbTvfpL8DoYBY1D?=
 =?iso-8859-1?Q?ydD4DbxD56upJ2yj+LG9clVqgULDvT3+iaZMmrNjx/JDQvcVEKy9pofB2X?=
 =?iso-8859-1?Q?5w2uau9hKIRzeP2U3IMTVAWICdQ2+6m+2MepCao7q6w4r4IUHVpy0fPtE3?=
 =?iso-8859-1?Q?W6Fxp8DnhBhS4Bmkjqfeupl7yvBKMSGhOsuSDynV3vMOXJJyHjM0O3zmjs?=
 =?iso-8859-1?Q?3TTHCD2AEbt2+zLaZrUaH8strmMORgTFMUkIr9xplqwPBPVhwZFdqNCIY9?=
 =?iso-8859-1?Q?UMgO53ohOrzsu8BE/CH/aVQDlBPaGKXrWnQUc70tVgNGATQY3s1leAd39f?=
 =?iso-8859-1?Q?2gX7Zl0Emlc/ZMjUH5rocaQE7X8biXCB6wzxxqHz/w6F2q11QYLthl1h4V?=
 =?iso-8859-1?Q?HIwQNM1UwQNVS2C6AitUCzOxy5VXIduHeTeRx4Y9M2NtFxpM7XkRljN99V?=
 =?iso-8859-1?Q?vHJhGJSmjd+dT/DgR9gX7dpDUdYN4LOis+nTEds1jqVDo0JbXjutjtD/7k?=
 =?iso-8859-1?Q?C0eWOMEWFy5RyHBLIhtLKrfWx9+L4YDvaEc6jguyRaw/0dArlW6IzZ/uBL?=
 =?iso-8859-1?Q?W9us8pBV9lClMpiGAaaAuxTmy+xfnjOlN0za62+/Dx+NnmqiKWS/5um3KA?=
 =?iso-8859-1?Q?Gkp70i5EdeeDrHNPB7WoRYqR1yoFTWoS6aMw/fS9AjQdXJLCDHQZTCgp9Z?=
 =?iso-8859-1?Q?ONxuM9jiuKlKLKydNer4UyUfZHFnLnmqJu0Y9ISIoT7dO09TzV0FM5fa4o?=
 =?iso-8859-1?Q?xERk9tHtlgYidpCL7rgtYjq9wu2gguDSOP1CYm5GAcoIyv2iCAa2+gv1cC?=
 =?iso-8859-1?Q?WgLxL1pLjUQXSBcUhvqsSe494Qt3+Femj+MsMjvjKuMoYH/GPomo9PGG8E?=
 =?iso-8859-1?Q?O8yYc1eG26lw4e3eHdHfKWq+IKY9smdPTAue+3e6AvFv7zLTOrpJb6awwl?=
 =?iso-8859-1?Q?Pxs+PzPuEJ5B/sKvIJK37rrFe2eN1xzVnNuN/bPsD2ktK1wUmlPfaAcn3p?=
 =?iso-8859-1?Q?lrIIj/mwxbQpVfXX4eFkytW8qBtUPyCM7Qb3MubFXMQBxdJHuwEiKxZiQU?=
 =?iso-8859-1?Q?co5GwxzNDilOqJPeEDq4TFcIs5BTy3FRxuOA7nDv2ZRnDOoP8Nqi6joFyk?=
 =?iso-8859-1?Q?4ip3LDtOfRm+aKEuQl8JUhI+uEELqXcNZqdZw8+EJN1Iz8i30SkbQf7RsH?=
 =?iso-8859-1?Q?5LLrIaxoONEIFS8KcvMs8pBqtB4GZzTheiyXBL/PDYoyRf14vet3QvzCRa?=
 =?iso-8859-1?Q?jny8DkHNCHahUHj7PDcnjoNEpQVctdnscBAUUEXIRZ48h/h0iBIo0OGsUJ?=
 =?iso-8859-1?Q?dj4MnfyyfK1oneBo4vnN+mlO0jm+CJDkKCjQuTBt0xWNNClMAqYmWhqmPy?=
 =?iso-8859-1?Q?bLYbmuyGHOpOKjMusgXsmyJl/3b9LkDsTTsszDo7?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b650ef29-5614-4d5c-010f-08dc6549c144
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 17:04:23.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wi3FKaKUMFH+sVPpMaEzf+lZ2VrCaIv5YcdGIne1H4k2jcidY9J5fDVBkx2euEQCST4h0glcO7TqTP/AyUPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3305

Hello Uwe,

On Wed, Apr 24, 2024 at 11:26:27PM +0200, Uwe Kleine-K=F6nig wrote:
> In the context of changing my career path, my Pengutronix email address
> will soon stop to be available to me. Update the PWM maintainer entry to
> my kernel.org identity.
>=20
> I drop my co-maintenance of SIOX. Thorsten will continue to care for
> it with the support of the Pengutronix kernel team.

thank you for taking care of SIOX and mainlining it in the first place.

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebf03f5f0619..85a32423e9ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17873,7 +17873,7 @@ F:	Documentation/devicetree/bindings/leds/irled/p=
wm-ir-tx.yaml
>  F:	drivers/media/rc/pwm-ir-tx.c
> =20
>  PWM SUBSYSTEM
> -M:	Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> +M:	Uwe Kleine-K=F6nig <ukleinek@kernel.org>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
> @@ -20177,7 +20177,6 @@ F:	include/linux/platform_data/simplefb.h
> =20
>  SIOX
>  M:	Thorsten Scherer <t.scherer@eckelmann.de>
> -M:	Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>  S:	Supported
>  F:	drivers/gpio/gpio-siox.c
>=20
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
> --=20
> 2.43.0
>=20

Best regards (and best wishes for your future path)
Thorsten

