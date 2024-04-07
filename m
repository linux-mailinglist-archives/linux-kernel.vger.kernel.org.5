Return-Path: <linux-kernel+bounces-134106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF589ADAF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24B81F216CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C1629;
	Sun,  7 Apr 2024 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIizov+N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362FA18D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712448517; cv=fail; b=tcUJf8jIcX/ISX+k6jIX/h4Glt4on3aDwXmTcKk4fYpR11e44ZJMCk4nFIHCuoM9Oe+LkpUqyzxADyCEtC0es60qF6sUvyMaCxc0rWDW6NaYnPxgtsSzbTNZUg8qubv+y3ZIODxhNwiEOXu1pd7FJk1PPWMchletGttxtxNZT2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712448517; c=relaxed/simple;
	bh=sdYPmXM5Ol3/KLyFRyY0PAy6HAbq18nY8fQ/nOh3HGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScHnYc7Aqi23Y7AubJxpcOUFPlfAV2x0GSZZLWy3L5Snh8VB3ltRf+tFwy+JUlSN7hpD3gsxhWOIJMJImyxHHesMt4flmwk4cqX7WJpKMDNg8iunOOzwr9fdF3HuA9vR5dG6vV/GlCz6I9PnGXLsIvdlqxiF+qY4YOgJTjKoJP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIizov+N; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712448516; x=1743984516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sdYPmXM5Ol3/KLyFRyY0PAy6HAbq18nY8fQ/nOh3HGk=;
  b=BIizov+NSQ5ffxQMc0+eXzEHJqLoIC5r4FOErJHkg3f6con+aao0JI8F
   aGmPE0j64l6dtv9KlOCSkc8OemGhIKee+Rq7s4jHMwZcvFPYxHbPM8T7J
   +QslQrB0AmHifrv34z8p0vylcTqDS+VMO8zpM/8uQNro6BDapscJZrubv
   ROitpb2+bXQXG9BYhAHvdLJMqYtRwfFzzdK6OISwi0T51h42AwSmEGj8S
   sNC0Od5QHGdoraJtuj/z+ZVR6b/rXBLKixxZwRLe4M4ryIDwPc/gWjhOY
   OB2fDt7mRID5zF6YSh4jnzdKapVZrVeVQ5gtsDm4OD971AaRgGrP0yqoY
   g==;
X-CSE-ConnectionGUID: eSfyAB9YS5ukMy1rTy+RJg==
X-CSE-MsgGUID: tA5OLUb1SbWmVyrHUJWMlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7655360"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="7655360"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 17:08:35 -0700
X-CSE-ConnectionGUID: ssYwYdIjSo6L9O0isrC8/A==
X-CSE-MsgGUID: oJdxyhuQQ9avBQBojAe6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19532065"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Apr 2024 17:08:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 17:08:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 17:08:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 6 Apr 2024 17:08:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 6 Apr 2024 17:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBtDZlEpxSkUCwmdfV47VA30q6jInrwnw5CXd+BDqqn5dhSAePUyfnoIo1S9hvjDY9iuJI/bMLBBgoikdpzN9qxaMW0aOdwmAsAGmQKJ73moGoXG1R3QwaJacunPVoA+EITzsq/U62c3Vbt95QjgBLWDZoPRDY9h0nnDa67EjnhDONSOGrQufUTIOa8w/jUNtRKrL+Npwgz0x2XQLc7eWimjZ/6PVfUkBJJgStjwb/OxQCxXQYZss7xSGu4owp62ijfEKIzBvjNC1p+ilQRKDD8qYdPHgvGAho3dx/fTpXS3vJmaydZ1ojQpJChDreS4EEdG2B2ALjMJuX/p6qsyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwKYzRdaq2mpBS264gcPZoynSRvKCdlYxbiRZTymPGw=;
 b=EG49nwpY+mc9BzN68V2BGuFB1ze7w/GsnqRKCLlDN+y7Q7TpfrSQqhBjKzj+ievzk3AiIZ+vQW4ojYi4TV3XST8zGbGCBi84gMpep0zuQeTyweZ27yIDDunFlF6FkWT+uXLcMPRWVinBza8a/qwgQWlxPLC0uoYFg6Ll7AyKLnFtkfKwvVHloNSg6y3jnDe0a6r+6UK/Lgb4eCrMY/64fC+szAY/GNnGQQloTubCQ9Pi7BlgOBCACWhuUzZWi5ZNpDx9IW7eoFWkK7zSnMEqULAN7F83e76/r8XKKYugYMlM8Tgr2Kb820pyf1O1WlNHB3LpqbaV5YErfowj6Cstdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 7 Apr
 2024 00:08:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 00:08:31 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Oscar Salvador <osalvador@suse.de>
CC: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Machine check recovery broken in v6.9-rc1
Thread-Topic: Machine check recovery broken in v6.9-rc1
Thread-Index: AQHahymLPB0TDn1nE027XBXiiAzj6bFZxGewgADPMSmAAApqgIAABVuAgAFIWAA=
Date: Sun, 7 Apr 2024 00:08:30 +0000
Message-ID: <SJ1PR11MB608323D7E6113B78A35F4999FC012@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZhCQPwgMWo9w3LlO@agluck-desk3> <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
 <ZhDHh_W1WZuFhsfg@localhost.localdomain>
 <ZhDMBZ2I9M72D87F@localhost.localdomain>
In-Reply-To: <ZhDMBZ2I9M72D87F@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2mb7lCQ9rB4SRoLQwvc45p8EF2svkE8nkxDM7+NOdW095mAvxq6wCTq+Dha1oPLGhUl2xTLb1ZO1tAZGOMaOrobihocWct/NJ7tln6A1mpNDj1YRrBI0pi0JyyqT+eRtRGkmXzcOc4czfoVTm/aaRnA+6diRScY/tYO9zndn91y/Yk8uJBszMaYDpQOT2gzm8jhi7H+RvAdYYLrJ2RnN7mIufO9Mb6Hsf6m5zkfnMlRXkaaILCWY1OvMCZUM7bjuap9/IAQEffW3kDlo7NG1LMs4HpqGtjj9fEha/m/cJVFllakIwnKrOpoQystzbAJdsF0D4B5sIrF/a22muDC2pLpjMFvfk+2NOQV29BkEMd32blnedbn7h4bOjl27Oh6Z5d8TL5HPWp6BVmHyTulzMzcdJXSg/b0dO1JsicPr/LY7gOMYYSlK/E9pqMh+6aXPZSJc56TFTj7GiTrN0y4N9U/5A4ag61MhwtMHFAJmoPplknEwMneCLZ7f2fOsiDuzuWGoj4/O6HTRLtERZg+NgFj82GiCfEU/PuYt8sm4Dbm5O7PByCRNhmfthkbUgY4qjMWbDKZ9WflkcFSljCFhH1TWEvJJIft0XC9kZezX64eCw8YhaLlr5IXdh/jA2caXwHyUfuK8GKB8fUuaCODOsC4PVLcbD3ei+C7v8IZYiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2YcjvS0uk8uf/eRWTPrJT3GDiA5kwsJSwzEvFyxJvBm4jfcfqwB88rVETMo/?=
 =?us-ascii?Q?FFiaGefUu5ZeB2/E/7/WjsNzymwhgk3Mej06EWUVmWPaby4ni8ajx2ytZGnI?=
 =?us-ascii?Q?+bqYDeVucLjLBoBeqY1TlEuHNcC0nEoPs4A7aE2hyXmd7WvU6BIVMnpBOaw7?=
 =?us-ascii?Q?uj2KLNGLZstjlFUF7UC7YIA8vF4pHGFbzvSERFL0CwLUzJXy9xaZwMsPLxEB?=
 =?us-ascii?Q?BeXn8pP7oeWdttzUzjgJ5cQcEyUVXsmB8a23bMAzUscJlZaQCJdnmRAJFdG2?=
 =?us-ascii?Q?a0wz7eTUmCVzO4vmbtGtXFYOhcYQfcs0VbKU1vOMvdXMAAsgSmesx/HZ5ffC?=
 =?us-ascii?Q?VUku4sAaz0SnSalVnV+3olNIZSb/KVLal0QY/rNoGUj74f1/Vn8EuHdsbFuA?=
 =?us-ascii?Q?s5SeeEKiMzo1EtNYMdE9CnGmSDBnKLRW7cBTzPuh6TmSoRP/90YAi7BEfBU3?=
 =?us-ascii?Q?EMDS3IZTg1A6SyWFrIlAoeDY4ABkvaRiHiDBios7ineMhvy47pX6XP8L5I2n?=
 =?us-ascii?Q?Nqpp1thv9lcKXHLowJFdCR7Qa7qP9RXe+y42MwYNS9DVV0usj0hf9ajnY58K?=
 =?us-ascii?Q?up9KZP4zXxBc+SL1BRE3NQYu5zOsuksAqcIaml2SCRwqRXegwcIAtim2dwOS?=
 =?us-ascii?Q?JhxQp/ST4aZtMOr2x8mbYf7MKyJTXNIiuL7ukd83PVC2P1Ap4FnppG6Xhu2K?=
 =?us-ascii?Q?n5HxQotAuofZ5N0rwBMPHaYljlEROFB/uHRax2ufGg69Exe9Cq+2pNWJZJWR?=
 =?us-ascii?Q?S2uu1HcyYS6yIuKP/161a2ZZQGuTZDO+lxY5AO9VJ6ATscsPd6cKeYb4wui+?=
 =?us-ascii?Q?4f5dFB73QqZH6vGgc8jwzvCFZcNdriiTAecsrmsEqhra1WVWsGmFHPFNOyOR?=
 =?us-ascii?Q?itNVFEWCDSCciDX+X+gyc2iZpdPgVN4bjYMC5p+ZB74msS1HQIqZN9jT1Tb7?=
 =?us-ascii?Q?tVCoYOHDIdRwKmOgAJeVhO8H4TYoDt25iEE8cuP8A40J7en0B5pV/cmRpizQ?=
 =?us-ascii?Q?DZsOd4c/MCH/YDLLwV2iYxsTEZ+db+LR/l/QQTTGxImyHGb7wCu0r4aQejDi?=
 =?us-ascii?Q?2bJow8Zn2dyIDPWz8CnC+aAj8c850XNIeqEVdI4OXl1FBtc8I+lXrVYqlTpU?=
 =?us-ascii?Q?l19cGHFnHei8lNgdOlRXwp0uMuSKct5tahgscR225F/iMRS9DqquarDenUuV?=
 =?us-ascii?Q?ccXzDwGOnmXZTzBe/w3YxMeKdIuJ0Dhkke85lyYZIAoOVRLasm+ASOEYQHjj?=
 =?us-ascii?Q?LyIYse28Zs397d57wC0OvWbvRWkyTR8117Qzg4hXaTxPZ/l79G+GJ06kAFtF?=
 =?us-ascii?Q?9CI+wQaOKWD3VNDZLx5Mg2C067NMqI+l1V6hkurKvVoHytqqV98qyH0yqtnq?=
 =?us-ascii?Q?jGyJQrL1CS8+4PFAeJKkduXRv9xDG/n+k0GGRY07xU69pc+gHSR5JYR6B6FM?=
 =?us-ascii?Q?Go+6BJZIR9gUumsEnv+HwkYUovHjRFIyECmr6weUQBhKh8d7+KcsRoPWqyw4?=
 =?us-ascii?Q?XSRAoP732b4kXH0LGo4vNfaN5qqvBcZSOBh4wMUSO8YKEHstJpy9kNcn4upH?=
 =?us-ascii?Q?1UE9UYMswbA6V9lehWJwUKSuMOYrLxsliUXhi4Ht?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f809916-03d4-4caf-0e7d-08dc5696dbab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 00:08:31.0140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3aRW5pP491PwNcTlYR1jpoUFKhfxWa1C1SohsQGeOKfm26yTf4QN67vEdqID6gtsBSvaz2SM0ZHkDBNQk484w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
X-OriginatorOrg: intel.com

> This one is against 6.1 (previous one was against v6.9-rc2):
> Again, compile tested only

Oscar.

Both the 6.1 and 6.9-rc2 patches make the BUG (and subsequent issues) go aw=
ay.

Here's what's happening.

When the machine check occurs there's a scramble from various subsystems
to report the memory error.

ghes_do_memory_failure() calls memory_failure_queue() which later
calls memory_failure() from a kernel thread. Side note: this happens TWICE
for each error. Not sure yet if this is a BIOS issue logging more than once=
.
or some Linux issues in acpi/apei/ghes.c code.

uc_decode_notifier() [called from a different kernel thread] also calls
do_memory_failure()

Finally kill_me_maybe() [called from task_work on return to the application
when returning from the machine check handler] also calls memory_failure()

do_memory_failure() is somewhat prepared for multiple reports of the same
error. It uses an atomic test and set operation to mark the page as poisone=
d.

First called to report the error does all the real work. Late arrivals take=
 a
shorter path, but may still take some action(s) depending on the "flags"
passed in:

        if (TestSetPageHWPoison(p)) {
                pr_err("%#lx: already hardware poisoned\n", pfn);
                res =3D -EHWPOISON;
                if (flags & MF_ACTION_REQUIRED)
                        res =3D kill_accessing_process(current, pfn, flags)=
;
                if (flags & MF_COUNT_INCREASED)
                        put_page(p);
                goto unlock_mutex;
        }

In this case the last to arrive has MF_ACTION_REQUIRED set, so calls
kill_accessing_process() ... which is in the stack trace that led to the:

   kernel BUG at include/linux/swapops.h:88!

I'm not sure that I fully understand your patch. I guess that it is making =
sure to
handle the case that the page has already been marked as poisoned?


Anyway ... thanks for the quick fix. I hope the above helps write a good
commit message to get this applied and backported to stable.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony






