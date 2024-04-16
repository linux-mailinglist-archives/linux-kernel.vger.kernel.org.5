Return-Path: <linux-kernel+bounces-147250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71838A7189
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BF7B245B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBA39FCE;
	Tue, 16 Apr 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="EyhIbSE1"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2129.outbound.protection.outlook.com [40.107.247.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BBF9F0;
	Tue, 16 Apr 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285306; cv=fail; b=fZqA/WMnG5aqUWCGEzXfw1bQfJKSGfVxaU6vqAkdewXG8xD7JHxUCgTmfjQrEv2a4f9TnPYxP4BBLD0iKCJrMtBN1IfJhCMH619ERVqu4LJJ+muJ+y1M6QgS2RxkIjs4qgcraqKucHClaIko8Tq1rcPvbtrI0hjKCjdfdiBmfxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285306; c=relaxed/simple;
	bh=jY7odxM3F5zS8u8WyG9LAFnvlAP8OyC7187BcvaO1mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qSmQYqn+31qJGMn8PwzYxXC3Z+c3xHmLJ5gu3dbtLFsTWFrjjIplEI/EFwLo+dJcIJGvNpm2FAVrOhIpu00hPAWocfugBVCI5tr3hI4GVh7WY5lJ4i9v7OsvTdt5jQyvGxvPeqXq8ELLjsVFW/kxium+4/g7gHujW0fDgI4aUIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=fail (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=EyhIbSE1 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.247.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXVQ2NoWlPJNwrxuFyXZZvMS5gkOeoqafKDXemj07U4MaymBFp7Dofh0ZM9A5tbLlj23qGvxwgt+9JwtA1X579HF7hqH9WSQXS9izmBy45uLx87juKVTTsJF44wbcf83DRD+GT3Kiz3GvcjnfsCrpHEHVSDKhpvl2iRylmAsCeRQboGU/mzxSdFJgOKbV3eDv3tqnWuAXzy2GbndRfZP6GX/U/086aAO02bZhP4KqoyEM+d7aYjtXoGRBLbCro5aouIXIj3XKyTooZ4oPdBP1igy2ENiQAVyvy2vTH0JIox/OjT6HajXGgG6O80pzoRP6e/veEKzQEglW/gq/lJN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bcEQpvahvPKIwQZlnwpD1ofKD4vPWJbXCeQULKBYT0=;
 b=RatYyz1Qty95UpIonLLzJlx8scYGGKKp7sXjfeolryg867r8cOeGMsHQMVYYd6O7S1haoBB2t+em03aJNfDRPDHA3aJpUyWNS+Rfh57nOSARlfJKUzQ6GoWHR5ZlMYNrFvJpi5hl6lekBsMRVZuDiG2Di+WIj51zWtf6Dm7bIvWFIELN5H8f8VJwjSfiYKSN4hjgm+NXfrm1Rsr1IPm5ZbVK+PWuOVworkgKPYlVvyv2gUsiFa4xYhTwBXMfEiFAcRhHYXynobN4dW2Lv8Gei0u96qKYMg63jgRqgM/KQJV3e5i0x5fnpjWcHvzjedN/U0SFjxwMDf7hVco6Mrqk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bcEQpvahvPKIwQZlnwpD1ofKD4vPWJbXCeQULKBYT0=;
 b=EyhIbSE12tF0eg/BSmzxvR39A77CSJaPhnnz/lBxVQmlMIm7mz9ppAz3iNkccv0Nq2OXdhpSWv1Vh7fCj7illwqkvGMs/dW74W7bL74D7QmJCARFpTf8SwblcL+gwIBbvfbW4/QOOr2+dlQBCgHPb86m55z+94snqnZ2A7KIx9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:34:43 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:34:43 +0000
Date: Tue, 16 Apr 2024 17:34:42 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>,
	corentin.chary@gmail.com, platform-driver-x86@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: add support for vivobook fan
 profiles
Message-ID: <Zh6oooU-DL2IXLg9@laptop>
References: <20240413202112.37729-1-luke@ljones.dev>
 <dccc5701-f533-e80e-09f8-199f232f447f@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dccc5701-f533-e80e-09f8-199f232f447f@linux.intel.com>
X-ClientProxiedBy: MR2P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::23) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: f406e4e0-7347-42d9-b9c9-08dc5e331f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	utP6Pn51K0TMxkPaXT1o4J4j54KcmIdYjW9LO9ojmkoJs9u2gr+3Ww90VrLbbDU46ND/GXOTmTqPyIYBfa5TJS8FOdS2LSlsXN43QMu7QBawmlueJzZxiIXXZkIoLHQVSKFvud8piztaVLrICJR9KhhJzLboD9jTjwgONFY8n7dR3JPU9MU1Sk7snfzzfNXQP9WoaXOjJjHNSMHR5ZJXg6bsO7KWunRv9s2tIl5u4QUpWvW3x38/H/kIpYenEWT/iidN3ya7W7A7WMBdmr/TmTvFC3qhWP6oyOuaZl+fjRrMhcr8bUKMo9k5Jln2wBAoZg9PPPwUm8O7VCyHbCQAIUwuRSLO7iZgNpH2yW/ZU6nCMtJpqdxVgetLyT18jOLqwe0tkcxtUvmzFWlYYlQG7NP9fm9Ufp8vBeweeI2hBkvd8zsXmoKiAoREk12t480rZgknCHYRARKzLXkd6MeCnl8yrY9vmM6BtyM/LNk/eE9Bct5ju/XC8fj1vzT3M+/tUIZ9L2kIlMMczCCPreCDQrInNvZ9fD3NuYXlPFW5He/TwOxlRYnZ9bTxd8M6841xdJ2LFm60eh8+qlhmqDQvAmi4TFV2KAaZY8gRQsXv7us6hPfL8t46KKJ4+HS1YvHbU02HnltCG4V/3guw7iBlldfBxHnE5eufdTufazDwQZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HL958PgSwG/AGvWG4b1AxMT3+COJgcP//zQutjE4JVIpVoUe3+JHOxk+tO?=
 =?iso-8859-1?Q?2arB+Bp0YMJyBaVFXttUPhCswvo1gGpUsNe47rFVU91CFr5EF9p7vo5P47?=
 =?iso-8859-1?Q?dlUT0tT3c3qQ+4aPSi9K7yo1LRvQ5TTHKxXcpU5Ks6yX+qd7ZmkIZg/o1C?=
 =?iso-8859-1?Q?fcEE8XhN5CeGrNVqVOIJdca2ctPeeba2J7ILSYGzjM7Nas0xkhH1YtzZYD?=
 =?iso-8859-1?Q?WR6q2re/dtQO+TAwjFgoVuJzojdDr8XYv76Tqy7fCIilsIKpeq5dB3xsYW?=
 =?iso-8859-1?Q?3oFKUmkUfsLk2pHrw2sF931aftx0TFDTLHLRulIejI5rQxPauZMsWa06sj?=
 =?iso-8859-1?Q?EGJoPiJEelVNksY/Xui1dwQA2+YAVeRoVUXNPqmI59sX9B3Ikd9aFQ/gAJ?=
 =?iso-8859-1?Q?RzqMTEUGvsAJYfsL6zzaJ/6UxgtqjFZ5i66XbP1YYD4JAJZjkcJZKG0XVF?=
 =?iso-8859-1?Q?CvQa272URVYIk1Kedk+yDUIA4y+RryEfHvvdaUMtfR8vzFM+45Uy6oO7a8?=
 =?iso-8859-1?Q?3p9IiSF5Re3D2rA/cRGNM8TKebDONJk+TbAaXOmWe8Tjvh9Uumg6cCgkZZ?=
 =?iso-8859-1?Q?hK53UagDRdNQhI945HuphpfdaRS3q1B/p1M6LxzpUJYUz2mL6ncym8NKk6?=
 =?iso-8859-1?Q?JXP8YFw2mccm/mK9ESPVExaiQmw68UYibmMvSf9WapxQm4kfJmVg7q4DHu?=
 =?iso-8859-1?Q?nEZLw+7FfV1/4agmWxPff1qsjazoe6vBii4D7Aogdb3WgQdgLSaU1ccCqS?=
 =?iso-8859-1?Q?/DlpQPYmIGV4PSaJBQ79ntk0ywTntoe6CsgmDtVphYNkv6XfJIMgaCHv1L?=
 =?iso-8859-1?Q?5rRx/syDSuJWuX7sLr47WC3WNsXYNTP8LL/Rvr+CCdlwxai3TzmrysAQX3?=
 =?iso-8859-1?Q?sjdZf4KvEa9KyZ6JxrBqfsIN46OSsVKOevvxiqKPn958K8AHm9zuMcOSsP?=
 =?iso-8859-1?Q?KGWP/Tw3AuVMEUyCNIqV5wwYEBoXxsSao29W3J1H+yv7kecy+O3adSLZfA?=
 =?iso-8859-1?Q?CGUanFFdLMWiemH+TawJmIyps2/k72IQWdfjOTIcXZu4xOF7daUYyHQIhK?=
 =?iso-8859-1?Q?9q86tc0dSrY+0H70Z0XZNlnw15/vFVH2bmtvZyirY7SF4dQcqrMyK9sXBj?=
 =?iso-8859-1?Q?b5zKfw+kkLtOChTBwQ7edX4MiQlZNgkKKXaNQOi3xmKEPLmgedSnQLH4Fj?=
 =?iso-8859-1?Q?c0xzsLa86Q5fPoRXwMYtSFM0GA4osDGV0EnwTAJezQy2b34VJU+MLtoJnM?=
 =?iso-8859-1?Q?U79DIKCF4ylkkNbdiut+HUESV/hssyfHfS2OZNevwH5qX0x9xllMZmwX43?=
 =?iso-8859-1?Q?HtXr/F+1I77UfeMXueUx4YUmM0dhyAu5tD6fmhFFayZov2RPoo2AyY/Qu+?=
 =?iso-8859-1?Q?iWGXu/kxgbV6hTEQ9C+eAVEUJ6jMTTTPtc28/djjgkvjfbLhhv3ZdtdCzF?=
 =?iso-8859-1?Q?lwX+G82/yGzcoQX7wGWoqadRFZGxEMdPZp0t18ZBoe9HE28P/6Td4Xr+Vl?=
 =?iso-8859-1?Q?CTtm1lGDuBlblTciyUjHHQjHCFhgM05eenGJ+MLEZGUbM77tIXWZwyQxeS?=
 =?iso-8859-1?Q?gZ/pVasj4MKdgZXg416cWNm0GLyBHbsOrdrpPvBjIhm+2bEcVQxixDD6MO?=
 =?iso-8859-1?Q?Xbki8+QQJ499Clx6oJ33YnbVxuuxLITw4Tf8KPkIUUOESMv+7AIQgMeVJd?=
 =?iso-8859-1?Q?hwIMt7xJYDjQikI3yQz+IVYiOefm3EgwAgB8tQBXIv568jNg724/Oe9vAD?=
 =?iso-8859-1?Q?ndWw=3D=3D?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: f406e4e0-7347-42d9-b9c9-08dc5e331f0a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:34:43.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjoJ4+CuVQM3N2soNGdZaasZTcNzUj/X+24XHJlBQBP11b+tZkROIsAisrKymvQjFbtS0pLQIiwvEKMHrOBg/yM5P9ruJ1NCH6oR5TI4kp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506

On Tue, Apr 16, 2024 at 03:51:03PM +0300, Ilpo Järvinen wrote:
> On Sun, 14 Apr 2024, Luke D. Jones wrote:
> 
> > From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > 
> > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > to adjust power limits.
> > 
> > These fan profiles have a different device id than the ROG series.
> > and different order.
> 
> Fix grammar.
> 

my grammar is not the greatest so i'm finding it hard to know what is
the error you're referring to but I think that 'add'
should become 'adds' ?

> > This reorders the existing modes and adds a new
> > full speed mode available on these laptops.
> > 
> > As part of keeping the patch clean the throttle_thermal_policy_available
> > boolean stored in the driver struct is removed and
> > throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> > 
> > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c            | 100 +++++++++++----------
> >  include/linux/platform_data/x86/asus-wmi.h |   1 +
> >  2 files changed, 55 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index 2d2b4eca7fd8..439d330fb80b 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
> >  #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
> >  #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
> >  
> > +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
> > +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
> > +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO		1
> 
> Any good reason why these are not in numerical order?
>

these are not in their numerical order but in their logical order

from the point of view of userspace both asus ROG devices and asus
VIVOBOOK should behave the same: 0 -> default, 1 -> overboost, 2 ->
silent.

I'll add a comment to better explain the reasons behind the order
of the macros.

> > +#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED		3
> > +
> >  #define USB_INTEL_XUSB2PR		0xD0
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
> >  
> > @@ -285,8 +290,8 @@ struct asus_wmi {
> >  	u32 kbd_rgb_dev;
> >  	bool kbd_rgb_state_available;
> >  
> > -	bool throttle_thermal_policy_available;
> >  	u8 throttle_thermal_policy_mode;
> > +	u32 throttle_thermal_policy_dev;
> >  
> >  	bool cpu_fan_curve_available;
> >  	bool gpu_fan_curve_available;
> > @@ -3153,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
> >  	int err, fan_idx;
> >  	u8 mode = 0;
> >  
> > -	if (asus->throttle_thermal_policy_available)
> > +	if (asus->throttle_thermal_policy_dev)
> >  		mode = asus->throttle_thermal_policy_mode;
> >  	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
> >  	if (mode == 2)
> > @@ -3360,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
> >  		 * For machines with throttle this is the only way to reset fans
> >  		 * to default mode of operation (does not erase curve data).
> >  		 */
> > -		if (asus->throttle_thermal_policy_available) {
> > +		if (asus->throttle_thermal_policy_dev) {
> >  			err = throttle_thermal_policy_write(asus);
> >  			if (err)
> >  				return err;
> > @@ -3577,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
> >  __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
> >  
> >  /*
> > - * Must be initialised after throttle_thermal_policy_check_present() as
> > - * we check the status of throttle_thermal_policy_available during init.
> > + * Must be initialised after throttle_thermal_policy_dev is set as
> > + * we check the status of throttle_thermal_policy_dev during init.
> >   */
> >  static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> >  {
> > @@ -3619,38 +3624,31 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> >  }
> >  
> >  /* Throttle thermal policy ****************************************************/
> > -
> > -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> > -{
> > -	u32 result;
> > -	int err;
> > -
> > -	asus->throttle_thermal_policy_available = false;
> > -
> > -	err = asus_wmi_get_devstate(asus,
> > -				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > -				    &result);
> > -	if (err) {
> > -		if (err == -ENODEV)
> > -			return 0;
> > -		return err;
> > -	}
> > -
> > -	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> > -		asus->throttle_thermal_policy_available = true;
> > -
> > -	return 0;
> > -}
> > -
> >  static int throttle_thermal_policy_write(struct asus_wmi *asus)
> >  {
> > -	int err;
> > -	u8 value;
> > +	u8 value = asus->throttle_thermal_policy_mode;
> >  	u32 retval;
> > +	bool vivo;
> > +	int err;
> >  
> > -	value = asus->throttle_thermal_policy_mode;
> > +	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > +	if (vivo) {
> > +		switch (value) {
> > +		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > +			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> > +			break;
> > +		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> > +			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> > +			break;
> > +		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > +			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +	}
> >  
> > -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > +	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
> >  				    value, &retval);
> >  
> >  	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> > @@ -3680,7 +3678,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
> >  
> >  static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
> >  {
> > -	if (!asus->throttle_thermal_policy_available)
> > +	if (!asus->throttle_thermal_policy_dev)
> >  		return 0;
> >  
> >  	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > @@ -3690,9 +3688,14 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
> >  static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> >  {
> >  	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> > +	bool vivo;
> >  	int err;
> >  
> > -	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > +	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > +	if (!vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > +		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > +
> > +	if (vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED)
> >  		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> 
> Hmm, add a throttle_thermal_policy_max_mode() helper instead so you can do 
> just this:
> 
> 	if (new_mode > throttle_thermal_policy_max_mode(...))
> 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> 
> 

this is definitely better! i'll make the necessary changes in v1.

> >  	asus->throttle_thermal_policy_mode = new_mode;
> > @@ -3725,13 +3728,17 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> >  	struct asus_wmi *asus = dev_get_drvdata(dev);
> >  	u8 new_mode;
> >  	int result;
> > +	bool vivo;
> >  	int err;
> >  
> >  	result = kstrtou8(buf, 10, &new_mode);
> >  	if (result < 0)
> >  		return result;
> >  
> > -	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > +	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > +	if (vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED)
> > +		return -EINVAL;
> > +	else if (!vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> 
> Use the throttle_thermal_policy_max_mode() helper here too.
> 

i'll do the appropriate changes here too.

> >  		return -EINVAL;
> >  
> >  	asus->throttle_thermal_policy_mode = new_mode;
> 
> -- 
>  i.
> 

thank you for your time.

