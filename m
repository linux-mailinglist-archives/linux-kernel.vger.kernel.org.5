Return-Path: <linux-kernel+bounces-84239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAD886A414
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C35D1F23AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64B56766;
	Tue, 27 Feb 2024 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKUB49gi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351358ABF;
	Tue, 27 Feb 2024 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078220; cv=fail; b=TzAU7lAtiovPUtmTyNYHIqVOnM6rDD8ZY+3dNWMEMekTBt1ikpfQVnLWJAZWeuiIJFd1GI4JE5hjWiawxreTqRlOwfjUz0GHp0ceuW0I4pH8XWoWmfmAx7t8qG/hgoNGfphxzgnq+E9938+5iV0wApTQ995xGiGFt/frzpkxspU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078220; c=relaxed/simple;
	bh=I/6u5dvSdz7x0xGhHi3WBvmFrnUk3SwZBN2NtyjKAQo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=peZbfV0PdjpO1bOfXK6q+fh4dUdhZu+Sozf2jGLR0bP6dDTXsjP22nDptoN2cUuVMf2fuNKpFs2x8KRP4ykihE+ShxEzZXueE/HO006KuZ/uf6hAuy2c+9zZO7YQeE9gyPA6ExaBaf1EI416z6O8H/VN61rAT0BxpN1L9O2HJDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKUB49gi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078218; x=1740614218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I/6u5dvSdz7x0xGhHi3WBvmFrnUk3SwZBN2NtyjKAQo=;
  b=HKUB49giyg+GL1M5QWxq/ETSKxTGj6/T+LkowxQXp/RgTJpTE2zxA4TO
   qCwEEmDhR+n9uaW+IOggtGTqMPIePfXnZiQDNbIq0nkr5gWrAvIloAngO
   ZdUxTD8IHgH/v3csycDbaNw72ytDMrbFyWanPh6M0twh8KhqZpJOaRsSr
   AIs2mMaDvT+OGpLYrHn4NFaV/yPvuJ1szBMFg9erP406TGXL6Pj96Qv4B
   bT/4B8kG3uySCxH67BFTedo2SGXeC8ikkdCKNQ+kJKhslBAlLBkCOXwtM
   YUjy4biCNiY5Cn2oOf0T0MR0L1cAXwEUup/S9rSKanT6ZHg5UGZMvRG9N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14164233"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14164233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7083001"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:56:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:56:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:56:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:56:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDlZBsOnpAzVTCKG7JY5NuDPMPPghZmi+cxGbN/hJaOtpKegh5hHKXZYbn0tJDCifhpHAg1JZQwXUfLw4w2K8VBZAk61WnfjbjEsOj9QBvJXxw0jTtjZzp0Q0M2FYYL9+ZTPGfoY5TMFtXNxvpVhtxJAks8tPiLrz13npgM9SuBeWHrQfY4+G/KIWurNsXrn9ETjKoyj5eTo9s4TBn13djAXYFZqgf95FhGGkrORAxW7lIWrGCl5iZ5M3DCAiZeecmxmRTHX+u97wHsH1VSIxZBe0xPOJP7QYGp11wzv0mSo2QOnEbPNeu8oB2ca1deH8wVIu86G+xWpqYBB5fLr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP0wqmBQlwDxEpguIChWTSrc8JDYKU1Uv4xHAByaTTs=;
 b=VUXwzua3ILDu8xieIwG06+RdU8fzdOPxrVl0Xj9oq6xEEopBJxrBCv+CBPfTsxePtDTn7Ux50bch9Ry8cUOLQVi9QspY5YeD3pzIqqsN4suel8Vno6rhw7ngCvzodZOiT1GujNLHhXM81SnIwpmUrZyX2HqLRMX7D3a8USmMoXr9n0ZvcGksJxYaNsuyx0q01l9hBtbUeFyBWDEZoQdB4DfwNzdfrqhX2VCxeB7fWTuKtrtSXRW2jD/LdMaQqlc2e0hPcYFBlg0qDq96WBZ0e06he8fh4V59L1kztkOvSG1y2xJPjgYeXQTXbU6y28DMwNG60rzc4TPhledODaqP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 23:56:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 23:56:54 +0000
Date: Tue, 27 Feb 2024 15:56:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <peterz@infradead.org>, <gregkh@linuxfoundation.org>, Ira Weiny
	<ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
Message-ID: <65de76c3be2ad_1138c729419@dwillia2-xfh.jf.intel.com.notmuch>
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
 <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
 <65de5725824ba_1138c72948c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=whYxkfLVtBW_B-PgNqhKOAThTbfoH5CxtOTkwOB6VOt6w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=whYxkfLVtBW_B-PgNqhKOAThTbfoH5CxtOTkwOB6VOt6w@mail.gmail.com>
X-ClientProxiedBy: MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 069e275e-3ad1-454a-899a-08dc37efc5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idNKdArACE9gfl98uUSlh52svDai2Mu/x+/8gDGCZ1IiJzWwThB6rxOkmOUEOMata4L7RDgzzh4JU6stcw20MqIqM2GLfBGTRcsC61HCL0885Zdvv4+iYv/NUNw/NvpJnAU2yM4NpaFPPLbgppTsFFocFMdjaZh+ZUNlKxKxUBv7+jllr5F8BVLWh8XkpTjIIU5XpazH49yDbM1Gm2sdoFtDuk8OR+5gE8/FbkdRXZht1Re3pDG95QjySkEkKIE2HBINZmmu1xeA1njjYdEBZtCXJmftdLKyAYuHyOLOMZ2b3iQvxxyr1EP0/9OLRueCPNDAv65ymVn2OGukhlaaP/UM3ZpFtE5Cwc/5IMyo2pEenfCvYDTR8/CyJezqSlYzZveY0gImvUltHAPvCrVN09nLIzfMW1cpQIXOcaxOON3LQs1Oq97COtOZ7RaJsygUZrxUSQYjaGSRUGXuTrtPx1d7mrEwP/YTVS05VcSZlOXFxOEyN0qKdsVfLoewZRsGwlUajUDedJOsk9kOqtST/TmtlLbUIZoVZa+pZpTh9Cn6PWnss+7+Y4vSmSFoz5D7Ezr8ToIpzOMdH2Qrt8hMj6H99s7o6DkAWSgvvqxiOxSX/EK/wCtMteCNY8Tjt7fdcAZcN2QeWUKL9iu7wTw6uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ElibTby5ViOUJyYNZHYBr4Y8XutVK2ma3xhlYM7zkV+XX+BXvlFO/Ch7nK8V?=
 =?us-ascii?Q?fcZVbJtt8GAfJO9gj7wR8LOOqbdwJ8jW2A/cXg3bUw8q/YzzmN5loVr/KyvK?=
 =?us-ascii?Q?NPxWp9bRL+wcCSU6Pk4oxMaX23hxLY+qPV1qZ1ot3izxkraEPwIGuhAGK3/D?=
 =?us-ascii?Q?EFsaV+2HwwGcFyhUE9g8n+nbqE8L0mFo5itrz0TDwLGopOZHYAbI606iR2Ph?=
 =?us-ascii?Q?XHCrnELOw9akUO4/Oc4wkE2nsYtnRCk8kasnyr5/KA5U1Fvqiy05y5mldK/y?=
 =?us-ascii?Q?g2azozJ8gejQaWiNHavMg/08krSckeQom3kgCwnNyyva39A0F48fDA22inEF?=
 =?us-ascii?Q?/VXtreX6f+23ALw/JPNuXMxlJx8mhkCWPfIO4SRQ37FNTLhSzSzRFt+gl82p?=
 =?us-ascii?Q?fUrQ4IaiAPTxYPgnBIyyD+3PCaRIe493A2F9qaaBGkI6RoPnWWrZV90RMtZ8?=
 =?us-ascii?Q?ykllsI0Hve8oS1JBYNEmlIqbICBZaDl0c8l1c74KSTzYwYaH42/SbFxQN1OC?=
 =?us-ascii?Q?EVyEmMN0h7TZiog0DSB+80cLheYfCrsqkw+fL54pjC8ReFYrACtzch6HTEyM?=
 =?us-ascii?Q?PODT7GKprWZKyw7XlgdopsZz79Idl52Vs+QxwrdMDbEWsGOB1qQCXcbdbacx?=
 =?us-ascii?Q?olbF3qU3OSzKtGn+5RIsbv0oVRvNFrNfhf7Azq421Vme0mVbHcihvlC2006F?=
 =?us-ascii?Q?vB46PwN8u6WgDiOAdrXEf9Swq2/TWCMqBUwJ/qVDQtNiTFOlimdX0wbZEnr8?=
 =?us-ascii?Q?Vb38+66upN54JRyeD/ZT2h4bRXuT1fSwq87e0TVEzkwrbO10CeMn7rULGBae?=
 =?us-ascii?Q?n4GDz8ThQLpN30JyCJPaRuwZO0muuxXinaWb3sGE6wzhA9WyPDcbdWCOyk1c?=
 =?us-ascii?Q?PEWotf8YNHRVdEEzjacCgQDU/cOLVfk3YDbg/F47CpoZI57kdu7xHaI+y+jX?=
 =?us-ascii?Q?/Cwh3kPjuG8rQX2Mzzu+6Uu7AkeAV4nJ0hCJbuNMTxEpIQmQcv+EvHYejxeB?=
 =?us-ascii?Q?8F3xOEaARtrjfLGu5y1IDECPcNg+jvEAmVAIduFMh/GNUPlBrdc87SMpLOl7?=
 =?us-ascii?Q?Xm82Bpvp0pQJNBvYhss9XXuphCz8kTkj6P5svmKwqBm4cT1jd5GNBTLVIpuQ?=
 =?us-ascii?Q?+4RZFlUxuJKB2As+j7NB7L2ruwdjJAOpUnYY2cDsf4XL5UZNVS8fe3Pgt6Mo?=
 =?us-ascii?Q?oIdJ1TeT1eVANbYdF/6FThqQ92PZaiTVN61fS1Y+2SeW5lZ7bT92fOY8ELGp?=
 =?us-ascii?Q?CdP32DT1C/YExzulUF8o3/FKqZKddQbiUeaDMawTB7XeuP0117Hc45PyuyyF?=
 =?us-ascii?Q?7F4H+f+A4UDUnYXuXfXpVwvCoKwcdepVYUhXHIq1aQIxnOZnVNj5Fygkv3m4?=
 =?us-ascii?Q?OeN13v2+zngP7YP4gpQdP7reNdgH/OeCVzm6lTkJ/HTwFgQsw33Xd7bBle7k?=
 =?us-ascii?Q?vDzGGrXJVvMrEzTyfWWKGKhCN3ZACaymWD8X0ihUtbbYrzOhfqrUN8oJSuBV?=
 =?us-ascii?Q?6JUOF94uCROFGM296i/7iH8B/0bCaLfo+jlPldP/pvo+jHw28nDgIgTiLfMA?=
 =?us-ascii?Q?O7SuglvsiuL2Myv5KueMXilCVZ68ws6WIleW9WXbVKYfO5e/ikjc+JiHf39F?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 069e275e-3ad1-454a-899a-08dc37efc5ff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:56:53.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oSA2KY05tjOukyY0/hh1E53YVSQDjgmEqjGBbefwIHHQostTficL50AEEkx+jlruRWGmfbqxEx0Ek3qcXeMnHg3OUk8CimFSGi+PByuMaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
X-OriginatorOrg: intel.com

Linus Torvalds wrote:
> On Tue, 27 Feb 2024 at 13:42, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > I will also note that these last 3 statements, nuking the proposal from
> > space, I find excessive. Yes, on the internet no one can hear you being
> > subtle, but the "MORE READABLE" and "NOTHING" were pretty darn
> > unequivocal, especially coming from the person who has absolute final
> > say on what enters his project.
> 
> Heh. It's not just " one can hear you being subtle", sometimes it's
> also "people don't take hints". It can be hard to tell..

I appreciate that. It is difficult to judge what size clue bat to carry
from one thread to the next.

> Anyway, it's not that I hate the guard things in general. But I do
> think they need to be used carefully, and I do think it's very
> important that they have clean interfaces.
> 
> The current setup came about after quite long discussions about
> getting reasonable syntax, and I'm still a bit worried even about the
> current simpler ones.
> 
> And by "simpler ones" I don't mean our current scoped_cond_guard()
> thing. We have exactly one user of it, and I have considered getting
> rid of that one user because I think it's absolutely horrid. I haven't
> figured out a better syntax for it.
> 
> For the non-scoped version, I actually think there *would* be a better
> syntax - putting the error case after the macro (the way we put the
> success case after the macro for the scoped one).
> 
> In fact, maybe the solution is to make the scoped and non-scoped
> versions act very similar: we could do something like this:
> 
>         [scoped_]cond_guard(name, args) { success } else { fail };
> 
> and that syntax feels much more C-line to me.
> 
> So maybe something like the attached (TOTALLY UNTESTED!!) patch for
> the scoped version, and then the non-scoped version would have the
> same syntax (except it would have to generate that __UNIQUE_ID()
> thing, of course).

This would have definitely saved me from thinking that passing a
"return" statement to a macro was an idea worth copying. I like that it
puts the onus on the caller to understand "this is a conditional" you
are responsible for handling the conditions, the macro is only handling
releasing the lock at the end of the scope".

> I haven't thought much about this. But I think this would be more
> acceptable to me, and also solve some of the ugliness with the current
> pre-existing scoped_cond_guard().
> 
> I dunno. PeterZ did the existing stuff, but he's offlined due to
> shoulder problems so not likely to chip in.

Ah, ok, yeah has been quiet on this thread for a while. I will take some
inspiration from this proposal and huddle again with Fabio.

Thanks for the nudge.

