Return-Path: <linux-kernel+bounces-69330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F75858776
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A82E28FE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B72FE28;
	Fri, 16 Feb 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE6/RjMg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C4182AE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116418; cv=fail; b=WFqPK532b23xqkntYuvnFij0oVObA5pvXounRgdgSR1H/c9FrfwQ2hUFSLbG94TPvFnEECdRVmruHEYNgSjOQq4zlhfam/rjdgDrGqxDOyBUv2UkdOEdvTQ7bdMMvPFpB04KXDFZxbq+KKAMl17pVMX92QQRqardj2Wyn83tjmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116418; c=relaxed/simple;
	bh=7eOjsa/w3lDWOOEx3jIPDVZc2lL1KxJUCi1Ne1HeTCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEo3diS8ij/xTymjD9TEXhTcKmils+wp5l1rJ5wJyW+EaNAIyDoJhVniEm8RaFPsm6+dMAmCjIng7kKjxN44C5ejol2GICl9S3OYCatmMVXJ0vQVgJs0mutwAmOBqwX7lpIUAEVZv73KL02KKHYhEjq2xn6TMrThx3qSQ5ipjjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE6/RjMg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708116414; x=1739652414;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7eOjsa/w3lDWOOEx3jIPDVZc2lL1KxJUCi1Ne1HeTCs=;
  b=nE6/RjMgwWMbnLRnWibqUx10K08fgADAbaMylNh4Jc1aJSgpOBXQFmLB
   iw20AiEbBmGlr0KvHEUT9upnEvFTfQ6DyQTkCr1YL6oHxGW90XUZt0rNE
   NMlVBtXYe5fdVoojvxPhiq5Mqa20TnfQGBM7tEhl6c4aeEw5zL7i6mo0V
   N3P90T+M1sW2YBTJKq/d40C64rgvBHsA8Z7v6z7kkv5FYv2oMtEP7IZSV
   wxmvDn/cXc33NCEFgX2YNkxlMjMqLwQJbB5SmnCkXF/PdTdHC2zP/ytre
   8LMhK7gpco70sD/AsWhs7jferqP1OCO3xteC7WN+7Svc/pvu1h+mb9mj7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="19784324"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="19784324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 12:46:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="41425484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 12:46:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 12:46:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 12:46:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 12:46:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 12:46:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MybacHLX8Q8bEuWb76XtEhCN+GSsmp/DZjhPwuNoyZ8ldqks19McWV/dWwNth5pgMzmP21MNLcSeiwgzoWEHeHJj/7Jk9zZa+oVPZo2mmtdkk0oVtouWNq2SAdbmYu0vnWdxR3a2kPj3yKpmGdwNgOrZJrIZHXcXKYPgw9ja4vt+kbIJPkczE7CPGlD4zNwUV4bY76Rx7z6ixzvPel5ruon+eJ8ijbLF7+xaMgRBcoU86tLRR7PoxFOvIqYXnHSt8YfIMfFSZFumbUlbqavOSa1kXCpxvxOeINaPOb5JDq6Sm+e1LmS7sP/hS9WMgGNRJUmRYUYGEeyW63G97y42xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgS4wN2FOYtWJhkiO0k3EAVpASZJzadl23aC/448Lzg=;
 b=U8ObDXNDIvU8Jz8qedTLCPaQ9BFQ+A/rBDW+8gftNVM3fBBhRmmx5KgzpiBy5Zw6b2eCj66TgOt57s/CRvQFdNPOfNw3vdnljzSNY9llxoGdQJfM+Xoa84PAezNWr+JHz4jSe/jmKzU3LKAZ8Ut2QZ8cDWuVUOSSoIuLAnLqcn/bT3jvonZogzddL4XkK2QLJvbcmdm/wK2YneBrlKMWQCua733z4LubsmjAzqqi3WoDUQeXBqzWa0oIrt23j3aWZv2V/wIl2EUhnV2l9MYBlQMnUz+r1RvyoPhD8HgKsDRdA4V/8IGsqX0A4PGs2GxjLP2xCJpboYAq0boNtlT31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Fri, 16 Feb
 2024 20:46:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 20:46:47 +0000
Date: Fri, 16 Feb 2024 12:46:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Message-ID: <65cfc9b581b4_5e9bf2941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <afabdd17-7f1e-4d8c-a7c2-dbbbb230fccf@amd.com>
 <65cad52616ffa_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ed3d8b93-2631-45fb-dd9d-69a97a9338a7@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed3d8b93-2631-45fb-dd9d-69a97a9338a7@amd.com>
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 81095728-ae51-4c59-2ad3-08dc2f3064bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hluBI22g1a/qmdfipoVg3q6Y2PeXXr/T3BeGV1QJiYHXNN2TJg7JK9Ww8LvgLqHwgj+DdARqmu8zB7On8+bh4FiHbMdOxvfPeT6RXiSAVD+8sfBJYvYV3grjHbCpMxYrbB+xQH88vuIB7e0ZEIihtncnbBZ+kaHMk0GhT5fASYsBVwnrgYUP2wM0+lX96a3RskcabUbIGBLfkxqiTg/OjSzyNSNrGFmpQL5sGLeBH7LwiVB2hAN8XNbhZPjxGk4aVuxa4DdvmtSsSy3kvdf8yCQTmi+Eh+0Iwt5u6tVUDEVqIAjD6hW8QFAwWTBnoeq0A80mQCORD6qrQaA+tMe+iINACujeBpcjjSjctVb2zMq6URtIYeDjQTEOO99/bFN9ZzpXb95DwWDiiPY44/wwqiDmlUQY5RGabhS0ME04v2pDKalq+NScvlenXGGiSyS0z6j7oaxgqNi6ZRBFa9KoAXOS7mgrdGCgvz6bHB70UbCElvb9m2r8yEh+ahqNZQwAUVfLsqyFcByuO99cmYB5uMfdfzQWIP1J7XznChcTLiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(66476007)(66556008)(9686003)(8936002)(66946007)(7416002)(6486002)(966005)(6506007)(82960400001)(26005)(4326008)(83380400001)(6512007)(38100700002)(478600001)(2906002)(5660300002)(8676002)(316002)(41300700001)(54906003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkFE3Sjss0RUz4DVHfiOPXiVGoi33GGsgIs3Ep5iiMBYfmOatyJgoK61Bu1O?=
 =?us-ascii?Q?moigUZhvbcXNvYfQkgD47nts0j93p50tvkCeduptxZkHB5krEm68W2gv8DA6?=
 =?us-ascii?Q?qJLanE68W/1QETXJuGspO6c9FQ22K5k2YRjQ7/EYgV5ngtFZ7aXCEtJ4HULU?=
 =?us-ascii?Q?ctWkVb76yYtQexNQebMwl8v224z5ycCaWQATHSntjXjUwgGcCHijHRH1htPD?=
 =?us-ascii?Q?kmdusb0NgLR5AgeKwSTVjBgRT81e8S791PSyZ0hadSgbd3y1q75fO2/Ex+co?=
 =?us-ascii?Q?tLjcUIlF/kVo8LcgX8OcM9jRl89RG3hOk30SZQtuYPgDi5Z1zSIuI6QBcQzW?=
 =?us-ascii?Q?KNHuUbl8L4ew8NyXTh7g3TaPbRgCpFtLhp5Jg3fkKwTfOzGsg5d0xOWJbm76?=
 =?us-ascii?Q?npKPEQbDygW4S2ABCaVAszVUj1nHQoScr1X0nE3G8VI1p9WSIlf88ICqzSNR?=
 =?us-ascii?Q?hrIoBJ01nkom9REo42m0CZ6abtCHZyjqtfmx1J98gZbujQBzBEIwMkeL9h+j?=
 =?us-ascii?Q?/bP9QjWdf8RRVL65YOXmNDP2GaZtcGK4EbmbALETBQJewpx8hpbV/HTu+P6f?=
 =?us-ascii?Q?XFLBb0ov1Z4d9oyIXPhlhNQF3WrZkrlrk/Ey02+bfYcQgCcT8Y2QROsVwm8a?=
 =?us-ascii?Q?XUltKpvSZ+Tg3FYQPI0766xaAo029Yavko6c2Wa/MA7FyVvA27Uj03dLrhVI?=
 =?us-ascii?Q?h7JeZr7gyZShGUDNMlZI/szLAhOg72bTCnuuCQNbqr/Fnui4nCcwrWkXL+9W?=
 =?us-ascii?Q?cypKFC6ffvqH9OYhMp5g1Y7EIfRPmEB7aN2N+4yYmzWewlj8g5o2/vvDChgx?=
 =?us-ascii?Q?erTNXhU5bjOYMseZrAQRbuwwb1AtR09TaTfwmkx9gptHI9vYuOhgmI/+XdxG?=
 =?us-ascii?Q?1NBAqIc55mtkL6syNCbG+rsasBZ1ucg1Q3z+gb2N8e58XYVz+vZZVGwKXvun?=
 =?us-ascii?Q?MJmUEG1pFPpmt3dTRfMC6Ylex+y6T3AMt+6uFq1v8J9+/l3pLmTlXzjo8ws1?=
 =?us-ascii?Q?tPx7pJrZ6wx9V5h//V/H0t7SCzU7DT2pZilGM+wye7wJAmuC4j68n82+dZa7?=
 =?us-ascii?Q?qwqDAhK5J2MUzNgrRjMM/e+TK6LwH5a6TVKEFW9XhwFfwJyjrWq1e47tjIgn?=
 =?us-ascii?Q?zfsMOKd1HuaSaOV4Zl8jS3nSbb+YwPQgKaKl2oGBBp7aZMpbW37ufpADqfO0?=
 =?us-ascii?Q?jlUUnykFLUTgcsuU43u1UDlIhkF6Jcxd6aU/M8Xe8oAq/icmSN/qJaKfnZOc?=
 =?us-ascii?Q?XqV2nkRbo+Vm+dvngV6zuUKQ0QbbRpjovMBtlGX3Qb/qaLT0hI0lcPrU+1U1?=
 =?us-ascii?Q?JdqHhnEUiOqqDu0zxNfC2lT4SsONTZMHlozW8ToozAohWyQiJTDshgcXZ04G?=
 =?us-ascii?Q?NRSvx9mERk2E6zaiaH/i2xM064MMg/7AmxQGjmh8f/yh3+//UyXtTNuHK3me?=
 =?us-ascii?Q?LT/Eiy3nD9Pg+pOd35Jd1G0rWMS4EgBzWYfjq4DUMpkBfcfZfZqYta7bxJ/V?=
 =?us-ascii?Q?YPnn8UOWiyL15MS04jjVb57FiYA/svfLXn9CQNPZpa1DOJDr4JGBtLEtG+6T?=
 =?us-ascii?Q?tDzR8qK13NMU5lQ7RUEvz6I/LYwujcFLlglhuZGO+NB8nyxrJmZeAZUL3M57?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81095728-ae51-4c59-2ad3-08dc2f3064bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 20:46:47.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYKVtXxM7nHYTuBNv/CmnvWWTdvXN1QdKQL2AFGzUCnqH1awQQKyNGR1uK76qLCMKG6qdQNH/s1qvlTfZhzNCLydMjPN4Hqfkh27wD9Rm/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
[..]
> > If it is the same format, and the input is user controlled then I am
> > confused what the new ABI is selecting? Could it not be inferred by
> > privlevel?
> 
> The new ABI selects whether to go through the SVSM to get the attestation
> report, which will additionally return a manifest that, along with the
> nonce, has become part of the report through hashing.

Ah yeah, that's a lot to overlead to the meaning of privlevel.

> 
> But, yes, I mentioned in a previous reply [1] that we could use privlevel
> to determine whether to invoke attestation through an SVSM request or
> through the standard method of issuing an extended guest request.
> 
> [1] https://lore.kernel.org/lkml/3fca61f2-6fe0-4431-818e-9c7b96c6a391@amd.com/

Missed that, thanks. Lets keep explicit as you have it and not overload
privlevel.

[..]
> > Can the version be made to not matter, or be inferred by the presence of
> > a new enumerated service capability? For example, make the same compat
> > guarantees that ACPI methods do between versions where extensions are
> > optional and software can always use v1 without breaking? Otherwise, I
> > am not grokking what software should do with this version.
> 
> Software can always use v1. The idea is that if a service wanted to
> provide additional information or change the information provided in the
> service manifest, then it would have to do that via a new version of its
> manifest so as not to break existing users. By default, zero would be used
> for the service manifest version and have to be updated by the user if
> they wanted a different one.

Can it just be the case the manifest can only grow but old fields never
change? Then software can determine the "version" based on manifest size
and no software gets built with an explicit version check, and is
instead built to understand a certain point in the evolution of the
manifest.

To be clear this is my standard response to any specification that
transmits a payload that "may change in the future", if it is an
awkward fit in this case it would at least be good to clarify why.

> > Separately, is this a version for the service protocol or a version of
> > the manifest format? The description makes it sound like the latter, but
> > the "service_version" name makes it sound like the former.
> 
> Correct, it is for the manifest version. I can rename it to
> service_manifest or service_manifest_version. I'd rather not rename it to
> manifest_version since it is specific to an individual service.

FWIW, service_manifest_version makes it crystal clear to me, but maybe
even better would be that the output size already conveys that, this
attribute is not needed, and userspace reads as much of the manifest as
it knows about.

