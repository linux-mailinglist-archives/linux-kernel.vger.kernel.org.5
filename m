Return-Path: <linux-kernel+bounces-56025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246C84C515
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAEF1F258CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739414A85;
	Wed,  7 Feb 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eh9IR6aR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B761CD22
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288183; cv=fail; b=MpVvj4rsD4WXu5JIYC/kfGhx9pM3/soPPZs/6aOBrR8bkHoeJ/9IKO9DogGFwBgCVUWN/Ke8vQtKPwh9gUPkyiAGoJMGU81kpXQ15DXBqT6PvREWuh/ylm0/ZBxZljaGELkRAAllb6obv2QxVRgN5EboUAw+8FpDi0p6PUCNKzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288183; c=relaxed/simple;
	bh=ip/88PzYp6nG4ZqoqxbKb9YXzH+cd5/5duuZW+PPbNE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=a/zAj0ugwMEphKKmrL7TH7QU1rhMZ/MSD0S0vaaQMla9P8eO7OA/yjwgas0DXlU4ertoysrSJ1KCj/P7swIPU3XYDS/2QJUIIFJN6QnajMhMc/AaP2y4B2zuR+rV7UG+sM3U0QnX55HzfAecFw5lIFy/OAySeWsMd0Mc+h6wK4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eh9IR6aR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707288181; x=1738824181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ip/88PzYp6nG4ZqoqxbKb9YXzH+cd5/5duuZW+PPbNE=;
  b=Eh9IR6aRpV3Wt2rvlL7PxYnZkEzPBuELsuUKO6gayVkClgYr+vTvVq5j
   KXOxqTLZWR3Fgi8v+PqJv8tuwt7OP484GcRGafcqqHD6iEU+WInzh5sMT
   FjP1bW7UcamrQ0NrHflUG5xcU3MdgvEcfi5gpDUKUEz5BC76IDhrnVK8b
   /tmi/bqkd7nQ4yYEYwrGwikfMzfMIzVzVPTf8CGuxZ3khADvBWoHaZhAg
   C6IEHOgSRFXcgBNQvEVDB5IjLpjUzi7R9Ai1L9hX4YGO4zSEqPrMLYmXe
   Owvglgw5BD7Jv1fex9JnpNtwkU3nWIGtk0rhOyzLXIxtdIVA7tUlxo3Fw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="813718"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="xz'341?scan'341,208,341";a="813718"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="xz'341?scan'341,208,341";a="1297574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 22:43:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 22:42:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 22:42:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 22:42:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kII5puKtqW9qvMYiVfWVPLHQuUHtdIBrOvvgdnTcHscvcjTUp72jhq/a4X4vSg9x7RGOrhK5vU2AzNqe0FORxN3Oby4HEHxDzbjyI37iPXRx1flqM6az3T+SJfZ8/OKSIENE7HLqkZ2PPnmEfl1AqPUahguyngTm3G1MZdLGifA8KabzW4XLBfqS7ZCW+O2ufsKp22j6Mtz4OY8MePo2PCvqFsIbx94AaAG8SNTfkYUgfMCW+CKUMt5lGLGpI0DpW96sAoZxv0BqxMZdAIL/aVcEttyrImWZiaxUEY8CjPVFSGjzYGdw4GpOCKfknebld/xO3nFINJmX71lc5OcOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8btwdLVULEpIqZXe+or2iDDyUHkaq5cTmJnhLqJx7g8=;
 b=RprMnowXm60RfkfdybEZ+Av7tiZMJ0/oVWbj64hYlfpdnSheNRG9aFNr2IBwkhWUr6yLTaD0fh8+zmKANhZXpDukJT+qtlQjP0lV3mkR4WtAlgYpS5ilRdOdvuN7vkmlZ/fOFlDsJn8nGsbfwZgFi2gzvhpsqk1ivhDfSFGuStYZmYOqNRcYxk3KrWzNUuLNgNv8NCDs4maLiHCJajPAx3C8QMp4ZcqmEBMx0nEKItEXA44Z9loXaE+856XlbgChVBXhb3JIdXP3qPqo6zrFK2Da6f4xK7UAMqEiqFc2JGngs3idU9nw1SKBt8QNwC2hupscuekNgosSoyVHcMSpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 06:42:50 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4ad0:937f:995f:3c95]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4ad0:937f:995f:3c95%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 06:42:50 +0000
Date: Wed, 7 Feb 2024 14:42:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <oliver.sang@intel.com>
Subject: [linus:master] [kobject]  1b28cb81da: canonical_address#:#[##]
Message-ID: <202402071403.e302e33a-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="OPDvY1d921AH+Zy0"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|PH0PR11MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 84077575-37db-47b8-e5eb-08dc27a80094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCuoObF0FldzYPwt8028ZklrwC+pn+70SzMY7x5IqvJSiP4usTeyX44jQsPNcGW3nLPO9QeFfo3uclb6Sh3WHtfgwzsfI6nz7U53w7zr50IIOyZHxzk/qEYlRG6LEdX3lnDY+WvHSHI/25/XoNmiWr1nWzLjONakLpH3U5rfGvWItH0mgTxyOi9T5jTyscZNS8ax7YgX/1yvaolxvBuGWNXXxMbDxz+OZ/qbh7WPnm7niXUY6o8klnHduqYurxttP02kdoQDfSZCg/7rzPd7pT+wIVGqBIbe+EcCz00iLhW7txiaTxU2xX+w9pow93Am14Wim46A6DvKyMo5op3E03JbgKHIR7Z0oKLOjSgMIZzymAlCA0vczWLRpzpVk0XjU6dVsFsKY4Vag0fcK0adlMocvvjAxWAr52OZsFdPU8nkHSHNjSnmBVaFrQXxFeE39HFWb8nWFbiSumMURXKU/2lqFdVTKYYpTRluF5TxZ46uujCJbzb5qtVifRNcC2cEl/IS2g9xtXMZ5iqgv6X7yootQnPMWvkd42SqLbZZ2ZSYt5iB0x77DB+zJYkueUkv+LQ7LrgumEFRWVhv5IP5xbEScWqa3hR4wJFGoVhYsPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(2616005)(86362001)(26005)(107886003)(6512007)(1076003)(41300700001)(5660300002)(966005)(235185007)(6486002)(478600001)(2906002)(316002)(6916009)(66946007)(66556008)(66476007)(8676002)(4326008)(8936002)(36756003)(6666004)(44144004)(82960400001)(38100700002)(6506007)(83380400001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Avn+hhjwJnDAP+Zs7jBeEBCT/zxBQYCQLvAI+62iD9GZpcLAHPMynLneOdDB?=
 =?us-ascii?Q?vkWTN+W0DSYT9BVXoJLest0V3M5CcJTewoi4rK5dTY0oJwlhelQ606lEhfMC?=
 =?us-ascii?Q?P6CAGEqfU2nUVPqqMOrKomHZVvXfYcVnZE8oCPjeKZDTozhIIeFNT0OSjA6V?=
 =?us-ascii?Q?JJd544pZ1cbpmlW618iMrVy6zS2eQSbnMj0z4H6Zph19aD1k2TFS48u9zUZt?=
 =?us-ascii?Q?yI2hnKswR0GFQEGynnu8/7TfRRncSUIH23vE06nCLIZiVTjPRVzFf2nISNxv?=
 =?us-ascii?Q?pa2Szxtb3kzyoyRiH3IBiIYzgDwIp5r68QqL6r4jezUBmNjywsjQ6qp30yKK?=
 =?us-ascii?Q?nG+uNrav0vEQ8QPjSrUpP8rQD5ICsz7MHbwGW/s/oyECwkFFZUFs1aT3Kn8K?=
 =?us-ascii?Q?KOUiJ+gG3nDxd4AukiNd7GyTS4zf97mR/vbDxR+3uH1FcoysEqp+uT7+ONJz?=
 =?us-ascii?Q?VM21DjvKln7IknY26HML6SQ6+ViOzkdB3LMuRdf/cv6rPQf74st3jIDQaiR8?=
 =?us-ascii?Q?DeMJTlFBAn2csI/gsVJETkIbLJRgfW3kQK6VV1jyXC+nr0CYawf070lYVRQN?=
 =?us-ascii?Q?/0BXw4wK8UTT8HgEL3GCiqVuzWBwrTsDaM4IAyLcRgBL4g/pw2cKlY1V2Dcm?=
 =?us-ascii?Q?G5cWLlYtSoSMKZL4mJB9iuutgKuGQEngPcmN6xX1ZnKFh9MFoExd8DJklCZy?=
 =?us-ascii?Q?YnwY8P2XEKAb+Gvx8DHBWkB+Lk3NsZczZNiikj2lmVf+k0FkM+yXLVowDLvY?=
 =?us-ascii?Q?PhZ0+/lKyylVJS5ipgt/vGsV72hdKQa6Td5pF86BWNnyvC+l5vEqc9W5kLAf?=
 =?us-ascii?Q?p7hu0Vh2HsXxgtGgQ9md/lPWra0cksJr4uPzx8U5fgoyvAGfmjqk37XSzztT?=
 =?us-ascii?Q?B7Ulw1jocwzqsi4kCn5M3N6QnNBReJ3SOatpjP7hgeYfR2z2r9s8W5uaDAD9?=
 =?us-ascii?Q?b4D5gVhnScWF/Qyasgo6v/7QU+H0fxz1iBGf13eOspZR6sH360/X2btsffTJ?=
 =?us-ascii?Q?0vegwJM71gsz/d2IIG9MHdtvkn0GUx+V7o2yl6P6iFscTSsntppR0ivilEdJ?=
 =?us-ascii?Q?df44EcH3nI/psIEL6jZGGA71hb0hGVtQXH7PG/v2L4u5dEE2pcsKouAzwjQu?=
 =?us-ascii?Q?afR9bWMHqtOjzMNWW0z/4eLI4+rxUpARq7CkFZFR2I5c7Srmr86remjmmJAN?=
 =?us-ascii?Q?KSfvysDfV4ovaxXc0pcXMM/yXupE7lqk3xTga+bWUXuhmKAqlyWOFanqRW7F?=
 =?us-ascii?Q?aGbrapqg1bAlIvdIlETyB7PxUdBpmPmdqp25C3sP8JuW8NaRdLqXgAOtK6T7?=
 =?us-ascii?Q?M1cXCFqgTfUh6YM0I34X3ECglJpy+GePZeJah5KPgbnmJIQfw2ujhGJtV6za?=
 =?us-ascii?Q?W8WNsIgrT3Zyx3nH+L1e480FSR1kdmpyWHRKWrtGsR/AK5PIaYwmmlL1tVfD?=
 =?us-ascii?Q?s6g2aM3vVZvKxg1vdkoPMcMp4yrCuKP6eDEQ3aEMSQg2i2/SFr1Bsn0dSWfY?=
 =?us-ascii?Q?HvHi7avyqnM+tDKZn4NIqFAq4MfQXPaEnTqQF8cgZ9Eibaba/B7ua2KwMsrC?=
 =?us-ascii?Q?yPxZepOGRmlFIjy5m26V2qpG4sgZw2un4TW6uPJtfebKz6ICfSYddAlK3Ez/?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84077575-37db-47b8-e5eb-08dc27a80094
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 06:42:49.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxQrWubiTHP6mi3ENyaa/QOauSBM9JUnx9j+kDjrtmCy1r9ilW6fRx9A0yqx8e1kKtO9RS3wVLHtMHNCznd+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-OriginatorOrg: intel.com

--OPDvY1d921AH+Zy0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: 1b28cb81dab7c1eedc6034206f4e8d644046ad31 ("kobject: Remove redundant checks for whether ktype is NULL")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478 (v6.8-rc3)]
[test failed on linux-next/master 076d56d74f17e625b3d63cf4743b3d7d02180379]

in testcase: boot

compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



we noticed this issue is very random, as below, observed 4 times out of 68 runs.
but we didn't see in on parent.

meanwhile, we noticed there is another random issue on parent, the dmesg is
attached as dmesg-4d0fe8c52b.xz. we didn't see this issue on 1b28cb81da. FYI
(the dmesg for 1b28cb81da is uploaded to [1])

4d0fe8c52bb3029d 1b28cb81dab7c1eedc6034206f4
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :68           6%           4:68    dmesg.Kernel_panic-not_syncing:Fatal_exception
           :68           6%           4:68    dmesg.RIP:__kobject_del
          5:68          -7%            :68    dmesg.RIP:kobject_put
          5:68          -7%            :68    dmesg.RIP:refcount_warn_saturate
          5:68          -7%            :68    dmesg.WARNING:at_lib/kobject.c:#kobject_put
          5:68          -7%            :68    dmesg.WARNING:at_lib/refcount.c:#refcount_warn_saturate
           :68           6%           4:68    dmesg.canonical_address#:#[##]



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402071403.e302e33a-oliver.sang@intel.com



[   75.238491][    T1] IRQ13 -> 0:13
[   75.238931][    T1] IRQ14 -> 0:14
[   75.239377][    T1] IRQ15 -> 0:15
[   75.239833][    T1] .................................... done.
[   75.342389][    T1] sched_clock: Marking stable (75300013917, 40623244)->(75406217264, -65580103)
[   84.458843][    T6] general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
[   84.459548][    T1] kmemleak: Kernel memory leak detector initialized (mem pool available: 13821)
[   84.460356][    T6] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[   84.460364][    T6] CPU: 0 PID: 6 Comm: kworker/0:0 Tainted: G                 N 6.5.0-rc4-00030-g1b28cb81dab7 #1
[   84.463835][    T6] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   84.464399][   T61] kmemleak: Automatic memory scanning thread started
[   84.465113][    T6] Workqueue: events slab_caches_to_rcu_destroy_workfn
[ 84.465127][ T6] RIP: 0010:__kobject_del (kbuild/src/consumer/lib/kobject.c:592) 
[ 84.465137][ T6] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 23 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 28 48 8d 7d 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f6 01 00 00 48 8b 75 10 48 89 df 48 8d 6b 3c e8
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 23 02 00 00    	jne    0x234
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df 
  1b:	48 8b 6b 28          	mov    0x28(%rbx),%rbp
  1f:	48 8d 7d 10          	lea    0x10(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 f6 01 00 00    	jne    0x22a
  34:	48 8b 75 10          	mov    0x10(%rbp),%rsi
  38:	48 89 df             	mov    %rbx,%rdi
  3b:	48 8d 6b 3c          	lea    0x3c(%rbx),%rbp
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 f6 01 00 00    	jne    0x200
   a:	48 8b 75 10          	mov    0x10(%rbp),%rsi
   e:	48 89 df             	mov    %rbx,%rdi
  11:	48 8d 6b 3c          	lea    0x3c(%rbx),%rbp
  15:	e8                   	.byte 0xe8
[   84.469942][    T6] RSP: 0000:ffffc9000006fcb0 EFLAGS: 00010202
[   84.470698][    T6] RAX: dffffc0000000000 RBX: ffff888129354838 RCX: 0000000000000000
[   84.471694][    T6] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000010
[   84.472675][    T6] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   84.473661][    T6] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   84.474651][    T6] R13: ffffc9000006fdb8 R14: ffff8881002c2ea8 R15: ffffffff83ac74c0
[   84.475621][    T6] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[   84.476712][    T6] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.477516][    T6] CR2: ffff88843ffff000 CR3: 0000000003435000 CR4: 00000000000406b0
[   84.478471][    T6] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.479449][    T6] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.480436][    T6] Call Trace:
[   84.480849][    T6]  <TASK>
[ 84.481216][ T6] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 84.481738][ T6] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:787 kbuild/src/consumer/arch/x86/kernel/traps.c:729) 
[ 84.482409][ T6] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:564) 
[ 84.483127][ T6] ? __kobject_del (kbuild/src/consumer/lib/kobject.c:592) 


[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240207/202402071403.e302e33a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--OPDvY1d921AH+Zy0
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-4d0fe8c52b.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==

--OPDvY1d921AH+Zy0--

