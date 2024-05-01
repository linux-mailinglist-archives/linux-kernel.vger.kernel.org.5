Return-Path: <linux-kernel+bounces-164997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB328B8632
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40092820C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88A4D131;
	Wed,  1 May 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FWt025Ut"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2086.outbound.protection.outlook.com [40.92.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FE4DA10;
	Wed,  1 May 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549397; cv=fail; b=EkG6GfH46JP6MHvHIjF/zCeK+Vu97jfsWJI8peOUgFnoIN0iB9IgaT8fBvimEdyFPrH3m+sg5Oxix5zOd0qf82Dc/oTkK0rvMPFiebZDUuMXH6FiunchRBQkBiGy5jg3sSbsDMe85Oum/hLtjw8sJGnHNk2i+FVwGgoTV7LKN60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549397; c=relaxed/simple;
	bh=i7jn3T4RGqgaKa6Dx6Yf5aTHnY3lhw+SSedKjqwokN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWreR36SqUnc1UNQ9Oy4RYw2MHnZavAVsN4UM3/5nmkBACR8CznwQpUPZYIRg4jvckn1/24ydgUvzngvd4PxxNdx7rMFsts3KUNekl9b8JkoPAoEpAoq80aeAc81iez5VIv+oFoyUrVvNecrzDONgRNOsJAcrnO5XqCIcVvqNF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FWt025Ut; arc=fail smtp.client-ip=40.92.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnV1LoAn3IFVy5U8zNYAVG5VHJnQQNYIIxxvdIVCP2QjA5Z+G22nh24KcHBiaCfdUwCYAWSOgxjBoeK2VfqiFhkMpOTF67MR5d71bohQ9PZ5clU64zru1Qu3FIBibqvYa7UTYeXzytpGtABizHKmsiJzi1OrTMg53uq7ZwLAKXCyLTtWeaHl1YaznDPP18M8Vyw0c6fJVSgSAAhXgzsgYi+yIwJmveUSdoREu7S56Bt4YR2/U67aN3XdseMaaRv8zyiP9tOw96dCf6l1aSqrE8Wrj98ZoFrIqOSQkve+81Ix4JDYF09by6bX2NTJHQnStvD7WnPElm2LVqKqVCIgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyuvXh+NkvNW+xhV2iA1T8jeMbUzt+1ZXwjB8pTj9jo=;
 b=l5mERB/zIF9/Pr/JcW/i9AAGmooQqqoHWlrFYgJxLxIJA7SWnGiPnXzUkvgomG/tyGFTyBz/cCFJvt+UP52OiaoisUh4zS3axj/eCmngGJ+vQnFg/A1lGzfeZ/l3OfxjJj+BH/LH6WKPszCfxffhF6e8GUPgmM+7X6dlxRCEYpb8n4OQCg7mRDuKMLI8pI4SDcRT5v+VR+56Fa6pepBGqA6XOv4e3NEpCdqXq1/rpYvug2KHnCwAYZkiyneLxX6NZoGYseRfEm6dkKQT5KOOs6gQD74GoJZ+tt5LFluVn5tdVs9nhRw6NbzLgeBfDkrQ+1MZh6F83ETQS1nTyxAANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyuvXh+NkvNW+xhV2iA1T8jeMbUzt+1ZXwjB8pTj9jo=;
 b=FWt025UtfJ1g6hREW8iLDlTFrqx/3q1aotbkWbm1lrTX0Mlt7L+ISdu7mFN9MzQa6NHbTaE3DQ7hZE9iWZwAPn6qa/MzNEyumJLagA3o8B1pwmau5rzKptYVncI/WVru7VRRGz/G5AieKU+F4VBAre2kZBWaI7NiS2fy4slBmfPB/pNNhbu3vKj82gks5sKvR11ri2sRY59N7sAY93tnPafvVDchJZXHTXcdrFz8nLlUXuPkHQL4VYtDnCJxHHBoKAe5IdYstUAMdi5Bz9v9twdjFcdtZk5bSFBn5KrJF5cHawlJeIdmLkoC8n7yO/OiqHshsjFxC/R9PLGSGqnKYw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7472.namprd20.prod.outlook.com (2603:10b6:610:1e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:43:12 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 07:43:12 +0000
Date: Wed, 1 May 2024 15:43:38 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID:
 <IA1PR20MB495377FCD5101F85B02BB5BCBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
 <IA1PR20MB49533772D594D18204E9F9EEBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJRtX8Rz0BhbtBJq+gSRTU3vsOwfyWjrqJ-Q1fqr7ZFeY2uaNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8Rz0BhbtBJq+gSRTU3vsOwfyWjrqJ-Q1fqr7ZFeY2uaNQ@mail.gmail.com>
X-TMN: [uMjNswBUUFnQBbtR1luVAvzIXZxYx514fUpOUEDHEiE=]
X-ClientProxiedBy: PS2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:300:56::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <k25gec5zigbo74qksnbtxztaqd4nioew7b2ms27mift7k4enco@jofw6vhd6hjj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8a9085-373a-41a3-1d05-08dc69b257dd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	lajkaeEikjgzhsIMjNsahohx2KeEBP0PchpXVxtvaWIyyo5nnzxiJwtH8DuKpwxKSjsYi+qAous3k9YTnCrFwFqmCJNTcst8D0OG7+bDWlv0WyRFm1jZJY15c3dZMIY9Bsy2y2tLX2ior6DWa8mcrpyUYj2+A1vHKZI4wyDaXphZau+cyc78aNIC+U3EJogJqA29ggQbsPFF5U4xg5cohpgIL2L5EWurk0iJ3fSyN6KsIqq8i/jNOYc6XP574n1D+gtMVu5C959mWHSkZXfEHZAQjRlJFP2mc0bkI+LoWy6lNV7twMd2k+WzYx/0I582oRcIsNptwOEVk+zIPXz8UOdFB9lkvcQ6CG6JGn23BmSVoohGrp2HNIB6tjeKdXO/OqO/vGVWj1Rd/ggddmZml0lirP2CfcOiBVGoOtZWE4oppMceTVUGdT/dWLgzBV8qtk736rsMFElp9EEE6i6hZ295zTYc7fhcL6pS9WPhwuV8kxoVyyji/6hpXJL6mofVtW4xpaJZz5t98QZ7fNwhf6gZvtvgHbSAL5sVoFkubquY2IduGpgHyqxM9PQDqgF1GBEF8+OiM0RKEaR0CehG3Fka62iylrQdDtsx+J+O0CrwmfQcY26z5UzWykfOo2aN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTVJV3ZsSUJHcVZKV21VR0JOdHV1REVMVnhwdHNKRTZFTDhLMjZCSHM1VWF5?=
 =?utf-8?B?L3dORFo2Q1dDOWl0SUZjWnJmR3lhaWU1bzd6ZW1vMG1Pd1ZnOHJDcktYbTFJ?=
 =?utf-8?B?TlJ0b1dnV3NVd25HNGttNGZGWVBnVStva0xORDRQZHZDcWphcmpYZ2ZaQ0dK?=
 =?utf-8?B?YmRCR1lJM3A5Smc0UUZWMnA0c1R1eTcrdmszbWpOQmRac3dPNHBvc1BkTjcx?=
 =?utf-8?B?aVBySW5EYmlqTUdtaVBCcTlDZHNVZUdrRUdqL2tpYWtJUjFsN2xsczlURUZU?=
 =?utf-8?B?ZlJkeDVoL0FPVjdsMFVJblBrS2tCV3R0WUhKc2VkTURiZU51UzFuUUVNdjZs?=
 =?utf-8?B?QnhKTmVLOUhsamNHMmppSVVZekRwM0ZIY3NEQnVQWjRjbFpvbnhOUUprRzRZ?=
 =?utf-8?B?K2twUE9wSXFCVlhzZ2RtTG5GRksyVnlBRk1EanBjTFBBcnltc0RNZkFUUFlQ?=
 =?utf-8?B?UlMyNXAwT3ByRndsbmx5OEY1ZHBLZ1ZlYkVPVWxxcTRaZXI2TGZPeVkrYnNr?=
 =?utf-8?B?NnFoN1N1RFQwY0FNRkVCRkJ1V2pKN09EU2MxcmE3SGpQVmMrRGYzdGx4cUp0?=
 =?utf-8?B?SHhCS0w5bHhUSDlVSlk5bURGL0l2R1JpV3pjRFJhRXVCQ0hkY2dyTzA4VTBL?=
 =?utf-8?B?eUJDQjdNM0piNWdlS2cxM2IwdXNFZncvQTVmejF5K2ZWMkxCa1lmSU5QTmNY?=
 =?utf-8?B?U3RINE9ZVFdRSS9jYkRjZ241bHpWa2ZZdmxCZ2g0VnE3UHFiUExGT3lwbnNa?=
 =?utf-8?B?VHE1Y1ZjUzVhVFJCRUlodld5WU9QLy9ENkxXT0ZTOXdqVFhQK2tUOVI5ekYy?=
 =?utf-8?B?R211U2tEb1VRdUtjS0ZjMW1RdGowcnBNa2duMkk2TG1CQ1c1K0w1c3JTdGFv?=
 =?utf-8?B?d1h6eXpKaHcvbGZ0Z0ZpTDdLZ3NWYnMwaWg0cTh4bU0wc0xNVjJGV21EWVJ5?=
 =?utf-8?B?Q2N2UEx5MTZsU2pwMmVKTzd0WGEwUlZTWUxBMldwZWdZMk00enNyb0pDRTBU?=
 =?utf-8?B?bDRhTGJBaWE2aDhMVlNyMFg0cytjRjJFT25GWXhkT3dQN1ZuMSsyS0lEQTZ2?=
 =?utf-8?B?RUtkaDhCaXNsckgrc3RMOVE4NS93L0JlMFQ4T2pWOXlvQXJsTE1zVHpBL0hm?=
 =?utf-8?B?RlJpYWdBbFpKOGZ2NEsvZHdsSExDRC8rcHpCR1RwNnliV2Iwbk5UUnZNOFMv?=
 =?utf-8?B?MzNoR0tDVjJxdll2QmxhMmQ2cjhYRGFHbXQ2RGgwZ1R6VkhiUWVIdEhMME9R?=
 =?utf-8?B?NmswRkN0RnZlMHY3TWlsSS80OTR3eXpRcDM1RVFjZEFQdjBVYmkvYmc3Zk4z?=
 =?utf-8?B?Z1pEZGhHRE81VHlnQXdvMk5GZ3pBdUpZTjdFMktSNnlLbHdOSW1pU0Vpd1Er?=
 =?utf-8?B?MEI4SXlGeTloWGhKVXk0cDBsU2dCZjgzaTkxb2hWU01BUVdUbStNWnloUTZh?=
 =?utf-8?B?WmhVUU9iSFk0VVJtZW13Q3FkZGl6RVRGaE1RV1BUNDN1R3dxMlE3TzJaWGRD?=
 =?utf-8?B?ODdSM2ZSTnVocFY5Z3pjMDdxK2c4YWR6b1l6VnBUaTd0Vk5EOEt6Ukx6bzZx?=
 =?utf-8?B?V09xNXVNWHRkYWUrY0FDQThtY04xbFpmRlh2NHY1UWdHeld4ZnVjWGI4R0FG?=
 =?utf-8?B?M0Z6V1l5aXd1S2U4VitFR2J3dlZlZHFaa1VCanozelFheVVNMGR5Qk9hNndw?=
 =?utf-8?Q?nZCqj2YLjmEw4C+EaO28?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8a9085-373a-41a3-1d05-08dc69b257dd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:43:12.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7472

On Wed, May 01, 2024 at 01:03:58PM GMT, Jingbao Qiu wrote:
> Hi, Inochi
> 
> On Wed, May 1, 2024 at 10:19 AM Inochi Amaoto <inochiama@outlook.com> wrote:
> >
> > On Sun, Feb 04, 2024 at 12:41:43PM GMT, Jingbao Qiu wrote:
> > > Implement the RTC driver for CV1800, which able to provide time alarm.
> > >
> > > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > > ---
> > >  drivers/rtc/Kconfig      |  10 ++
> > >  drivers/rtc/Makefile     |   1 +
> > >  drivers/rtc/rtc-cv1800.c | 244 +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 255 insertions(+)
> > >  create mode 100644 drivers/rtc/rtc-cv1800.c
> > >
> > > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > > index e37a4341f442..3c6ed45a3b03 100644
> > > --- a/drivers/rtc/Kconfig
> > > +++ b/drivers/rtc/Kconfig
> > > @@ -1128,6 +1128,16 @@ config RTC_DRV_DS2404
> > >         This driver can also be built as a module. If so, the module
> > >         will be called rtc-ds2404.
> > >
> > > +config RTC_DRV_CV1800
> > > +     tristate "Sophgo CV1800 RTC"
> > > +     depends on ARCH_SOPHGO || COMPILE_TEST
> > > +     help
> > > +       If you say yes here you get support the RTC driver
> > > +       for Sophgo CV1800 chip.
> > > +
> > > +       This driver can also be built as a module.If so, the
> > > +       module will be called rtc-cv1800.
> > > +
> > >  config RTC_DRV_DA9052
> > >       tristate "Dialog DA9052/DA9053 RTC"
> > >       depends on PMIC_DA9052
> > > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> > > index 6efff381c484..4efdd2d1e963 100644
> > > --- a/drivers/rtc/Makefile
> > > +++ b/drivers/rtc/Makefile
> > > @@ -42,6 +42,7 @@ obj-$(CONFIG_RTC_DRV_CADENCE)       += rtc-cadence.o
> > >  obj-$(CONFIG_RTC_DRV_CMOS)   += rtc-cmos.o
> > >  obj-$(CONFIG_RTC_DRV_CPCAP)  += rtc-cpcap.o
> > >  obj-$(CONFIG_RTC_DRV_CROS_EC)        += rtc-cros-ec.o
> > > +obj-$(CONFIG_RTC_DRV_CV1800) += rtc-cv1800.o
> > >  obj-$(CONFIG_RTC_DRV_DA9052) += rtc-da9052.o
> > >  obj-$(CONFIG_RTC_DRV_DA9055) += rtc-da9055.o
> > >  obj-$(CONFIG_RTC_DRV_DA9063) += rtc-da9063.o
> > > diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
> > > new file mode 100644
> > > index 000000000000..60a7192659f5
> > > --- /dev/null
> > > +++ b/drivers/rtc/rtc-cv1800.c
> > > @@ -0,0 +1,244 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
> > > + *
> > > + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/rtc.h>
> > > +
> > > +#define CTRL                   0x08
> > > +#define ANA_CALIB              0x1000
> > > +#define SEC_PULSE_GEN          0x1004
> > > +#define ALARM_TIME             0x1008
> > > +#define ALARM_ENABLE           0x100C
> > > +#define SET_SEC_CNTR_VAL       0x1010
> > > +#define SET_SEC_CNTR_TRIG      0x1014
> > > +#define SEC_CNTR_VAL           0x1018
> > > +#define APB_RDATA_SEL          0x103C
> > > +#define POR_DB_MAGIC_KEY       0x1068
> > > +#define EN_PWR_WAKEUP          0x10BC
> > > +
> > > +/*
> > > + * When in VDDBKUP domain, this MACRO register
> > > + * does not power down
> > > + */
> > > +#define MACRO_DA_CLEAR_ALL     0x1480
> > > +#define MACRO_DA_SOC_READY     0x148C
> > > +#define MACRO_RO_T             0x14A8
> > > +#define MACRO_RG_SET_T         0x1498
> > > +
> > > +#define CTRL_MODE_MASK         BIT(10)
> > > +#define CTRL_MODE_OSC32K       0x00UL
> > > +#define CTRL_MODE_XTAL32K      BIT(0)
> > > +#define REG_ENABLE_FUN         BIT(0)
> > > +#define REG_DISABLE_FUN        0x00UL
> > > +#define ALARM_ENABLE_MASK      BIT(0)
> > > +#define SET_SEC_CNTR_VAL_INIT  (BIT(28) || BIT(29))
> > > +#define SEC_PULSE_SEL_INNER    BIT(31)
> > > +#define SEC_PULSE_GEN_SEL_MASK GENMASK(30, 0)
> > > +#define CALIB_SEL_FTUNE_MASK   GENMASK(30, 0)
> > > +#define CALIB_SEL_FTUNE_INNER  0x00UL
> > > +
> > > +struct cv1800_rtc_priv {
> > > +     struct rtc_device *rtc_dev;
> > > +     struct regmap *rtc_map;
> > > +     struct clk *clk;
> > > +     int irq;
> > > +};
> > > +
> > > +static const struct regmap_config cv1800_rtc_regmap_config = {
> > > +     .reg_bits = 32,
> > > +     .val_bits = 32,
> > > +     .reg_stride = 4,
> > > +};
> > > +
> > > +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +
> > > +     regmap_write(info->rtc_map, ALARM_ENABLE, enabled);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +     unsigned long alarm_time;
> > > +
> > > +     alarm_time = rtc_tm_to_time64(&alrm->time);
> > > +
> > > +     cv1800_rtc_alarm_irq_enable(dev, REG_DISABLE_FUN);
> > > +
> > > +     regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> > > +
> > > +     cv1800_rtc_alarm_irq_enable(dev, alrm->enabled);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int cv1800_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +     u32 enabled;
> > > +     u32 time;
> > > +
> > > +     regmap_read(info->rtc_map, ALARM_ENABLE, &enabled);
> > > +
> > > +     alarm->enabled = enabled & ALARM_ENABLE_MASK;
> > > +
> > > +     regmap_read(info->rtc_map, ALARM_TIME, &time);
> > > +
> > > +     rtc_time64_to_tm(time, &alarm->time);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
> > > +{
> > > +     u32 sec_ro_t;
> > > +     u32 sec;
> > > +
> > > +     /* select inner sec pulse */
> > > +     regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> > > +                        (u32)(~SEC_PULSE_GEN_SEL_MASK),
> > > +                        (u32)(~SEC_PULSE_SEL_INNER));
> > > +
> > > +     regmap_update_bits(info->rtc_map, ANA_CALIB,
> > > +                        (u32)(~CALIB_SEL_FTUNE_MASK),
> > > +                        CALIB_SEL_FTUNE_INNER);
> > > +
> > > +     sec = SET_SEC_CNTR_VAL_INIT;
> > > +
> > > +     /* load from MACRO register */
> > > +     regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> > > +     if (sec_ro_t > (SET_SEC_CNTR_VAL_INIT))
> > > +             sec = sec_ro_t;
> > > +
> > > +     regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> > > +     regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> > > +}
> > > +
> > > +static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +     u32 sec;
> > > +
> > > +     regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> > > +
> > > +     rtc_time64_to_tm(sec, tm);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int cv1800_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +     unsigned long sec;
> > > +
> > > +     sec = rtc_tm_to_time64(tm);
> > > +
> > > +     regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> > > +     regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> > > +
> > > +     regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> > > +{
> > > +     struct rtc_device *rtc = dev_id;
> > > +
> > > +     rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> > > +
> > > +     return IRQ_HANDLED;
> > > +}
> > > +
> > > +static const struct rtc_class_ops cv1800_rtc_ops = {
> > > +     .read_time = cv1800_rtc_read_time,
> > > +     .set_time = cv1800_rtc_set_time,
> > > +     .read_alarm = cv1800_rtc_read_alarm,
> > > +     .set_alarm = cv1800_rtc_set_alarm,
> > > +     .alarm_irq_enable = cv1800_rtc_alarm_irq_enable,
> > > +};
> > > +
> > > +static int cv1800_rtc_probe(struct platform_device *pdev)
> > > +{
> > > +     struct cv1800_rtc_priv *rtc;
> > > +     u32 ctrl_val;
> > > +     void __iomem *base;
> > > +     int ret;
> > > +
> > > +     rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> > > +     if (!rtc)
> > > +             return -ENOMEM;
> > > +
> > > +     base = devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(base))
> > > +             return PTR_ERR(base);
> > > +
> > > +     rtc->rtc_map = devm_regmap_init_mmio(&pdev->dev, base,
> > > +                                          &cv1800_rtc_regmap_config);
> > > +     if (IS_ERR(rtc->rtc_map))
> > > +             return PTR_ERR(rtc->rtc_map);
> > > +
> > > +     rtc->irq = platform_get_irq(pdev, 0);
> > > +     if (rtc->irq < 0)
> > > +             return rtc->irq;
> > > +
> > > +     ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> > > +                            IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret,
> > > +                                  "cannot register interrupt handler\n");
> > > +
> > > +     rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > > +     if (IS_ERR(rtc->clk))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> > > +                                  "clk not found\n");
> > > +
> > > +     rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> > > +     if (IS_ERR(rtc->rtc_dev))
> > > +             return PTR_ERR(rtc->rtc_dev);
> > > +
> > > +     platform_set_drvdata(pdev, rtc);
> > > +
> > > +     rtc->rtc_dev->ops = &cv1800_rtc_ops;
> > > +     rtc->rtc_dev->range_max = U32_MAX;
> > > +
> >
> > > +     regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
> > > +     ctrl_val &= CTRL_MODE_MASK;
> > > +
> > > +     if (ctrl_val == CTRL_MODE_OSC32K)
> > > +             rtc_enable_sec_counter(rtc);
> > > +
> >
> > use (ctrl_val & CTRL_MODE_OSC32K).
> >
> > Another thing is that I do not think is a good way to let the
> > rtc driver access RTC_CTRL area directly. You have already
> > know there is a 8051 device in the 0x05025000. It is necessary
> > to make some room for this device. Maybe you want to implement
> > them all in the rtc driver? If so, I do think it is a bad idea.
> 
> 
> Do you mean that RTC drivers should not directly access the 0x05025000 address?
> Because there is an 8051 subsystem on this address.

Yes. At least we need some mechanism to share these address between
this devices.

> Firstly, I do not intend to implement 8051 in the RTC driver,
> but the 8051 subsystem is located within a module independently
> powered by the RTC.
> So if we want to implement the 8051 subsystem in the future, it can be
> used as a node in RTC? I'm not sure.

Yes, this is what I care about.

> Then, Alexandre told me that there are operations related to PM in
> RTC, such as the following files.
> This matches the description of address 0x05025000.
> 
> drivers/rtc/rtc jz4740. c
> 

I do not think this is something related to the PM. 8051 is more
like remoteproc. So it is necessary to arrange them carefully.

> >
> > > +     return devm_rtc_register_device(rtc->rtc_dev);
> > > +}
> > > +
> > > +static const struct of_device_id cv1800_dt_ids[] = {
> > > +     { .compatible = "sophgo,cv1800-rtc" },
> > > +     { /* sentinel */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
> > > +
> > > +static struct platform_driver cv1800_rtc_driver = {
> > > +     .driver = {
> > > +             .name = "sophgo-cv1800-rtc",
> > > +             .of_match_table = cv1800_dt_ids,
> > > +     },
> > > +     .probe = cv1800_rtc_probe,
> > > +};
> > > +
> > > +module_platform_driver(cv1800_rtc_driver);
> > > +MODULE_AUTHOR("Jingbao Qiu");
> > > +MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
> > > +MODULE_LICENSE("GPL");
> > > --
> > > 2.25.1
> > >

