Return-Path: <linux-kernel+bounces-120213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42B88D483
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D04C1F2425E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB9208CE;
	Wed, 27 Mar 2024 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbhDNKV7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51F200C1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506447; cv=fail; b=AMtYhkoVrBRF64xerCPhh3CShyAXD2Uel/j2pG1rPJb6xyT1cjsjeRQhFjJXqNQ6ySibifOz73IDmyy2SKjlXapvnLOc7l6Oiph3dKu3xo0C6piVkKtBOD0xw67v1mdCL58n/3CIg4q67ALIpO7/rFikYPe9/VFhjvunPwU4VHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506447; c=relaxed/simple;
	bh=l3E8n6+x3J+MbySxZ28pkQBlfuUuPz5BR8akSJq0Ao0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MRl10BY7oOktO+VUDflFwETJTQf6ZEdg3N5PlOBiwwuwohKEA3/bSTAdOxlSa8RecvJo2HFPiKdMQDItktgqNLMqG4EPK8841ICYUlnY7BqmsjnThUtt5IGHCHZsD4Cg2uQ827WHi1ac27yuwKRI2uFkitc/QSh24OgEtvFZcR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbhDNKV7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711506445; x=1743042445;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=l3E8n6+x3J+MbySxZ28pkQBlfuUuPz5BR8akSJq0Ao0=;
  b=ZbhDNKV7Woehut0r7VuDm+rPtZi8sIhVV3DpP/psN7k+pZ1L04BCnZlw
   DPbnv/LlZSZXiFzc7RikMy553e/7BXAvyFsre0LYh8Vi9nz0wy7OY+fxD
   TGUBctO2dPnR1Z7PhM2eoV81odk1nvIJG6K5jzJJygBLcpSgu6demos6i
   zqObqTTMFWziN9gvMkkAYL8Qo7W4Tjk5L51GwKG3cWT8kAGu0ALGgSO5X
   yU1jgjhOz5rQMYDY/SWKzTwxlj2epn3IEw+vJSe7gv2QnbJJop/e9Eh/n
   7YpFWSwX8qvoJsVAuH2lBNGxRgTGkI7jdWbxyJW7fbaPTEoMYzi9iE+0j
   Q==;
X-CSE-ConnectionGUID: OsAo/3pvQkKCphyXpGUszA==
X-CSE-MsgGUID: vjehSfp1S4imzOLshBI0cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9551777"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="9551777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16138888"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 19:27:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:27:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 19:27:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 19:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmaosfcwxFBzKkl1mJBXxNu+mfRw5NU1tEyMop1UWue6qp5mmMEQP4bobpq+y9CVcs437NGLFSGIoejK7xuq7tvsMA7OvTXcXoaGCLC7Lv0vQZBW6B6IYPoWTQrHxcFSyzmtvBwidzAWJGbDAXhHhRFBg7mWzAhFIpxRdkNalKQU6T1FjBnmbi+krPrPDttgRfCgqklbEBpsa3PnZVaLtnqi7xBjTg9+LOPVL/1SIbbiCbzK8kOqYGRoe/OFkTtiNuDoYbTClrBkXl9CHGBpKIVVygwPkvB1789QcvRW4T/XSJ/mzVneNFYUMVipa7zrFUBoOS5uKMETosK9uUdvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BkzIS9Cx8CPMzjHg0CPshKhhyedlit8utNzCEDA77g=;
 b=ghvdUcIC3YAKA/pnlrv1qpVRaeAgub5kgFtIDkky67B3+PSaitAMaFbWT58qdRkusH7u/muMTzK1SBYPMI0jWtkCU+bwO+LSh2cNDoMZrLv2KVjoU3WrmIRWmnxzUlTaxFjwIP7VJfLPHEEUwauiQlJZaiH8pNdNhE3Yw+iMgfO7vZr3vOLRpfN7waxd63zAvSQOR3SlwpJ3nQ8HZ6e5rhunwn8pBXZGNi4kBmlh/3gf9B55BWwMmH4NDz6Dvblw/AYnfBk//j3JRMfU27mpGLc9Y6wmRpYVAcy+MFpRt7JM5h9bUR7YAuEJycB55+pvGs5jI+gvPt2j2vgaVSDm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 02:27:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 02:27:20 +0000
Date: Wed, 27 Mar 2024 10:27:10 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>, "Andy
 Lutomirski" <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys
 Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf
	<jpoimboe@redhat.com>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [x86/percpu] ca42563486:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <ZgOD/oj9/YKnije5@xsang-OptiPlex-9020>
References: <202403251658.8e92a8bc-lkp@intel.com>
 <CAFULd4bFbhOQ+mx2=pKqLbLznR-UFZamS4HhdUYZF2qFKNcDVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bFbhOQ+mx2=pKqLbLznR-UFZamS4HhdUYZF2qFKNcDVg@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8747:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFcj2Ddys829UTK0oKPYccYBvH0/BJe0ki9f2nMBWHvcN0vZK1Wa969vkLTj2Z7K5/qyeruPKlODkcx5mYsb/ejIx5S+jl4edFJoJLMd2FM8rmjvoXtdS2VCFjaGv24DglQH9tbp6GZOqHuYlGg8/RplZlcH4SfqLTcZ/f16b73UHgbGwh8Sqhr/eGOzrFkCjvyfg0VmfIGXhRa2ANpIjHapPxS5UYFGZnae6QNFSJgUtAf5I2j7bPzsy0bUSdtvvtK9Xp3I+FEO19BWEk5QHkVWK2gs3VoHUAreiv0YZKYF1UvM6lEU4gIak0B/hbZ6Y+LHZ+qjQlSOLxsKaFcNMdKvHI7rvPti81ZDv/w45aRSzxFXDovd0IgqGftMCTootzS7ELbse7r1cLpdYNzs+FwpKRo3atKgAe4O8oJgUFlNd0nDc72Vst9a4JymgG2wLJEj8jJC84FeklgT3RUQBWkVA9vro2d1UL1eonHn1OYGOuDpZCxkxRVui6icXPrd4OazmZb49Y30GKxrHw3NWmWn63KSZPREZb53EAc5mDjwWlUoWx9IP7lujHfAmdz7AvGsengXwFacAiaz48v4k6nYni3OsdZfkCR/HeZflPYj3lORy+taT7HwcZrs2QHr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFGTXNtYlZLMkhneWRsOXpSZUVud3VqU0tTTW40SEQ3RnZPUFh6aEFhNjNm?=
 =?utf-8?B?VzFUOWF0OEtDV0x2R0RXOWxWNjhURE5sUi9IRUhnSnF0RHh4bW5NVGJJclBG?=
 =?utf-8?B?V1RBTXlJd0lUZXlYSTNaM0dnQVpSY2xGVGVDdGduSXhwNFE2THZQN2I4VGVi?=
 =?utf-8?B?V050bXVaaDFvT0h3L1pEVksyNDJVcm8ySENMK1VqemxYWG5rZ3c0NHhtUWxh?=
 =?utf-8?B?ZjcvU1Ewb21RZVFFQk9pMkNZZjlmd1Fabi9SOEluSWdwT3lMQzFCVGlCV0M5?=
 =?utf-8?B?UnIwcHF5MHZOMWR1Z09mUHQwbjJ0YXhjSjZ3eTd6bnhsbEVTT09UQldEalpa?=
 =?utf-8?B?L2ZmdW1GZkVEeDk1NnlHUk1LanBTcTBRQTIxa1RKS1lZakM4Z091RVNKTGsy?=
 =?utf-8?B?TXBCbFBZbnNtd3NVdm8vRzI5ZEFXZ0M3bW1jdlpxREhnRzBEcURObWVXcnRp?=
 =?utf-8?B?Vzl2MDU5ZlY3S09CVWtUOXVhL0lQeExHaWVjRURDK1Y2am9LY1lOVlp6OW43?=
 =?utf-8?B?TE1ERUhOU1duM25rYXZEeXZKbEpFT3VsMnExQks0R2JaUHpyWGdvR2g5Ukcz?=
 =?utf-8?B?KzBCVHRpSGd6a1ZxREgwaXRiNFNvdGRFR2NmRll3MGlNMEZ6RXNkQVlDS2hq?=
 =?utf-8?B?aFZrbjU3bFVzM01QOVZ3SmZjbGxOK1lLcXdrMUE2TEVDNWlrMjJRUExGOU1W?=
 =?utf-8?B?ZnYwcHpoQk5VYVk5dWc2c2xXeUFiZ0FKTWQyZ2VYNUoxbzFjYUZLbW5ReXdH?=
 =?utf-8?B?RnpMRXdyTW94T2VwemhrUTdKbVJNSGVRUTJZd3ZqR1JJdkdzZWNrbTF4NE85?=
 =?utf-8?B?Z2Q5Q0NJck51ZnVleTZvZ0VNcEZLU0VXcmhJdUdqbkppQ3JGc3lJSWc5T3Rj?=
 =?utf-8?B?TVNmL3U0eTNjTlZWUlozb1Q2SmJDTDVzUEFlVUxyeFRYV3hLU0hsMU42QTYx?=
 =?utf-8?B?Yk81T1RwTVhSVzhXOXlHaE1SRzJZM1R0QkFjQ29jaDB0MytRaE9jSGZpaXZm?=
 =?utf-8?B?UGNORkhwbmNXVS90YkZSMTV4Q2VEcFl3R1NJZVNDOG1IRXlvUGE2UHJwdkxq?=
 =?utf-8?B?dFRZR0xnZW1YYndxWGVGYUlBN3llaUkwTWtFRUNlWko1b3crYW55TUxKYlJY?=
 =?utf-8?B?OU91Smt3MGcrMmdJOUE2V1p0TDRTL3hJaS94N29ZWjZGSWpxUE5Xa1hRTXVP?=
 =?utf-8?B?RUlWYVBhQlVnQ2Rld1ZQVlJkNGhLNmQzQVJuSEk4QUF1MFFhWlRXdmF5UnMw?=
 =?utf-8?B?R2xhTnlRZXZTdDhldThBOTI0eWdqSkdySFNQcGphdmtsUWJCdENNQk9WTTJm?=
 =?utf-8?B?RUsweGxGaFhwd2VIa0dmN2ljNitJbExKL0hjYlZYRlg0MmlyazRMcnptTjVW?=
 =?utf-8?B?cVlHWitwZDdZbzh6b1pRVENBcmUyR1BrRkJ3Vlo3YW54TElQU1c5WnkySVpx?=
 =?utf-8?B?VnJUU0l2UmpJL2lxMnU1KzBzeldGbzBRT1FaM2NHdVdQcHRxLzhNdmpYWUZH?=
 =?utf-8?B?UTJ4Y0FOdUhmRE5uV2U0SHA1d3d5ZHZLbXdaWldWQ2tZZUtrb2NZNnBYTTUv?=
 =?utf-8?B?MlVKbFNJSWd5dlF2UmZQT3RrWVRicksxbngvSDZKTWhRek1iV1VEVjFITWl6?=
 =?utf-8?B?RjhlMktFSXlUd1FCWXp6b1FHNkZDT1ptRDQrcjkva1BOeVJXL3F6amczQmRZ?=
 =?utf-8?B?QWtudFlqbWx0QUdnUVorcmlvVUNqalV5c1JiYTJBZDdqOEJRU3BDMVBvT0lI?=
 =?utf-8?B?Y0dtaW0vZytzVzBiWDJoQmJmY0wrcU0zK29ubjZjY3g0RGJrUGJjM0lleHM2?=
 =?utf-8?B?ZzdkWEZpOVkyZEpiM0xYcnZxRFRPK1dFRDRyenFaRkxFTnZWUGprN2NFT3I3?=
 =?utf-8?B?YTBHYklXUG9sbTk2VGVDTlZ4ZGdZTWN4bXphUXpyek1mSjFtVEllT2NuYWl3?=
 =?utf-8?B?TVBKUWNONjNoMnNHRnVvWHNTRjBoeGhvd3laMExoVkJwTmN4OTBOaFdRSVZZ?=
 =?utf-8?B?WXU3bzk4WFoxMWlWc0F0SUhwTkVnc1A0QlRmVlBMRFE2V3VWWFgvMTlmb1dN?=
 =?utf-8?B?b1VGaHNNa3pwVDlISFRGRXBqUmMvOTZuTDdhVStlMFpLbHdPV1FBSHBLT001?=
 =?utf-8?B?aGQ3bTNJUGZVbTBBendmYXg2OVdGaUtIdjhIYjJ6aVNScEZDWnl0OFNwTWx4?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 755dd55b-cf91-45f9-de53-08dc4e056e11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 02:27:20.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ebsCykBeS9rIqh9iy0yFa2nFHU9TEb67jDjkOOumbapzeKnowzEctpUluYEQRLfJFYoqlW8Xm3JTrqeP3foCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com

hi, Uros Bizjak,

On Mon, Mar 25, 2024 at 11:31:40AM +0100, Uros Bizjak wrote:
> On Mon, Mar 25, 2024 at 9:50 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> > hi, Uros Bizjak,
> >
> > we reported an early crash issue for this commit last Oct.
> > https://lore.kernel.org/all/202310071301.a5113890-oliver.sang@intel.com/
> >
> > as you mentioned at that time
> > "It is KASAN that is not compatible with named address spaces [1]."
> >
> > now we noticed the commit is merged into mainline, and we observed a different
> > issue related with kcsan_setup_watchpoint. below detail report FYI.
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com/
> >
> 
> Yes, it is the same issue, but with KCSAN.
> 
> > Hello,
> >
> > kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
> >
> > commit: ca4256348660cb2162668ec3d13d1f921d05374a ("x86/percpu: Use C for percpu read/write accessors")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master b3603fcb79b1036acae10602bffc4855a4b9af80]
> > [test failed on linux-next/master 226d3c72fcde130a99d760895ebdd20e78e02cb5]
> >
> > in testcase: boot
> >
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> We already have the candidate fix for GCC [1], the fix will be in gcc-13.3+.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736
> 
> Please find attached an emergency patch for mainline that disables
> named address spaces when KCSAN is enabled. I'll post a formal patch
> submission in a moment. The named AS will be re-enabled with KCSAN
> with a patch via -tip tree.

thanks a lot for information! we will apply this patch.

> 
> Thanks,
> Uros.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 39886bab943a..4fff6ed46e90 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2439,6 +2439,8 @@ config USE_X86_SEG_SUPPORT
>  	# with named address spaces - see GCC PR sanitizer/111736.
>  	#
>  	depends on !KASAN
> +	# -fsanitize=thread (KCSAN) is also incompatible.
> +	depends on !KCSAN
>  
>  config CC_HAS_SLS
>  	def_bool $(cc-option,-mharden-sls=all)


