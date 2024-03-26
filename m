Return-Path: <linux-kernel+bounces-119160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285688C4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71643B21D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A07F7E6;
	Tue, 26 Mar 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbuoEnqh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3242768E0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462633; cv=fail; b=GFFGFeDKdCk5eu80Oie6DU31m971TGyqcX3EU5PRzWDC/51pvtCxGFCYw1fja87wcjv7lFTUxWBhVDHHBSayvwoh6Hij7cIqa9vnfIGXspRpWr5wlKgBthia/I1BsLusMPBs4x/QVeLUaZTb5J3zQo1ua9G69LiTU9NsoovqUO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462633; c=relaxed/simple;
	bh=Y1z+L8vl6ub9+HyDi3yoSkmciBISD8ZlcUXPOnLG0x4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mp8mHgQ7AP1QGu9tfKu3sneu5mVeuavL5p/k+jfDusEHQjOdERsFuqFU+49vFMnvRPT+iEAJtMfmiq4Ifb9PaFfS1jP9VAl0r1/M3YXcFx+OXlhR3IMrqrtaoXbI1H16WNy3MaRlptB5afh+qMIgQEl45mdyHRGus2z8e4LBB8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbuoEnqh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711462632; x=1742998632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y1z+L8vl6ub9+HyDi3yoSkmciBISD8ZlcUXPOnLG0x4=;
  b=LbuoEnqh3vrMBP6nMJyWUGbLQcUntMLQThIIuhVja/JHZHnx0awUeb6D
   AxUQ6TGWZaCJ/aoWkVD0QcEl8O0Iib7jSBFNeTv9AiyRLrMedRjW0Qilr
   8PhwV1UtrE43JSPdypiz/7aoNC08WTgkKqK/HSivB6YKgEjF48oyU67wr
   6GVQlo7WWkbqDmJUtOHg7hpjeUaa1+TC6RbFXzJUOncamrDSHhhGfa7xq
   ZXpvLK6+VkKlgm8Zsnxg9fGpMWuLrouWtHsnrkACNcYEBvvSdx/2Ud+dd
   dbDNfZKKES50E2exJAekMd7ykwcMUwIGd7H1cbMWBq4Im/BmifEA8zNGN
   w==;
X-CSE-ConnectionGUID: e619wt9tT+SBen2Xkdt0YA==
X-CSE-MsgGUID: oCxwFDmwQju51YEbVezGxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17945036"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17945036"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16058160"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 07:17:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 07:17:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 07:17:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 07:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khM5kdl6r8bPKTIGZW4YRLcIlXjtKOcSdLUA/z4oyrovU5aiXw7TcDnjpMC3Qojrq+JKcO6MiN2L4aKfQ6Q4RpOKepbEmHc+MfjKVxLduE7bVc16CpDUovaxQTZcLOfc9dA0ekDCrebErR8Bg9FYSDzpNihbwNfWfFP1xQaa57viPBUgjjCR7/0AlZxsfvEyAtykgUaHBHNROekxBsm8HD6SnjLQCPItQ9SAzsQo5RI3yfa++MB+UwGp/PR4Ny0drYggz2J3IXT5ovmAfJglXJuf0dR9EdGlJD0ZlBAf663htl9VF405W+1tzecDuxGOFU/HajRAGikuuvU66+AQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEENwBISf2lYmMOYgIw1AjnIExMVXiJexbPZXqchEJg=;
 b=LZoBk8I3ezJhxBBBW0C+Ado3MpoIHeVdazmLPbuZXJa4aHnG4cUb/eq97HctD+wI3mD4hmIsWulziyGq5dZJ125FoSUvzlYmSGk/jMjxmaxKNZFzr3/8Azz69H/kJJma6Da9bsbZT5PiaPVE0f201y90plfAuh58rNK2pJYkZ7ncu6O41kBAalCKVTdDpEEB2kdRdTIYcOzFbyjdUIGVe5YPRI74tODrLhye3jJ26lSDdY6zwq6KlCX5wcenUL3D4ht8B1DRoVzhHpMNXVekTTb+4hSvETBpc/54zDyacupkwFegy71998x2qiJAYFYRyjhFDSlPmfO3yeNxjdrDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 14:17:02 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 14:17:02 +0000
Date: Tue, 26 Mar 2024 09:16:58 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Tiwei Bie <tiwei.btw@antgroup.com>
CC: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <jani.nikula@intel.com>,
	<linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v3 0/9] um: Minor fixes and cleanups
Message-ID: <zhm2eyo5hy6wta5ga6zqgg546q2atjekdxoivksht2kdrqppoy@6ck7iwpfxidr>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
 <fbd44e8a-713b-4e66-9241-e18fc78c9168@antgroup.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <fbd44e8a-713b-4e66-9241-e18fc78c9168@antgroup.com>
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB5190:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7KgfYazNhBw3SaSH24gh2e+3bF43w1ay0dt7PLFuqHsD+Ze80soKO1YN/VBsL6cksW+7P+CIpm9NBWhkJ6go9kA87xYvXlIqfRZAlyQlflBT5dIxMo/LqeXHgc3GNHCoxZow9VbF8GOm4kUjqP73RKH6OVO8h39XAzs9T2b02abrWQW1XMXoiJ+PnsdCxI2Qg5zCjuvVQt5jGzC+A21vEvaZ2cEivuYI7DkmAs8b3SgI/7Gycq9JP94G6y0h9N//e8cFXr90+2O65KrS91q8ov0KMG/ZEiAudlVYKB5a851w+XHzUTCEUYW7ebUPlhq/MXuR+aojhYWis2IhPAcTgykjS+X4tBXrCz3l8pl29/mtHmGNJqh1xGFRvynNONEdTA5jPgC8WPE06xs6nPw7VfUoecogw9cHR9quEcRsx8lyyCHxg8sCakv4pXR1MwKLGIzw1t6WA932Gh44PIpqe6WtWXpq4qmGxqoEpIE+ToPp/eqjNteiVhtETb+sJOzQX3zq8o+bvQKo1Pix/tSH6D8c6K+eac3HfLWtOzcE+X087ha66HgukeaX0bp4d5vdMoQGb5WvuwbG3hubZ94MShbjZIaNmS/7JVXN9lWqBse77UujMCfmhBZQ3zkh9b+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QeECTciXk0tut2ZlB5ExRgP8tOj/4ujVxlR2FqVEc6+F6BXNzmLfRCEXyCrO?=
 =?us-ascii?Q?2o9++fqTa65gKxb8m7uc+wfspjTPtnWrnPx0EOyBpzHLahO6MC9GtynmSfCI?=
 =?us-ascii?Q?Sbt6Cfb60R/i96s3AsFd0IZi6EBIPx0kc4JxGbZcpBWQfC6CFCOpkl6Oc2cf?=
 =?us-ascii?Q?jW6qlh0tGTc+2ymWuaUtf+kZVUDRGTKWJBtXsYdGN5Y0faQX3F1zhD0q6sjw?=
 =?us-ascii?Q?0ETUzv2UlGN707qH5LIPAqH7z2tiEyGQkMsMNuqvVFpIQH+04HcQFYvuIHh1?=
 =?us-ascii?Q?THnhK/tnwlYLYpHH/yIQZ5AISRhlVUIy6spnzE71YZ2M+6812AVaHym3pMV+?=
 =?us-ascii?Q?vIMguTUEJjMVcsyH/hhg6MhWFT+T2WzBb685Imqyxl6/HwonwYdCsVz/PwSJ?=
 =?us-ascii?Q?vJ6PS8OJrPUoDstz/WgJ0eMwafSLm5w3VIDrpb+SG2T/IxMVqsfKD/oDnOQE?=
 =?us-ascii?Q?nJRz6uEDeU1gAxdI4kMNPLyjhoGXxxi/9SeDWySz0sObBEU++LYihgcNeBme?=
 =?us-ascii?Q?xpAMZZYAcwuL9K4pLa7tYZuhnp86AtxeJOakOfPTovFwEmnavhi9cupY0kpa?=
 =?us-ascii?Q?VzPqQ2H6VF+J5dIW8mOm4ndsD9fgtonKxh2hd/guTIcyVV6hMq+lJ3UqZHfO?=
 =?us-ascii?Q?ijcvSSjAKQ9afnDZRP0GM0oP0D4icBonmtjJxYp+13lncnr5/S1PVMikh005?=
 =?us-ascii?Q?tfvGuqZMw7Y5Najt+RxhgDXkdheXrYDemiQX+ZHzgDYvvLT+5Ihk247+Bl8n?=
 =?us-ascii?Q?2LMQgQwm376nRJ+OgPC/bi38AMppLE5nzhceX48LU4k+MNkK8gebsGHsbDdC?=
 =?us-ascii?Q?IGY7d7eVy8Fd5Gvq1ds6+Ki+zGFdiSpWRWe5HjBd2UhXLcmLD3U2IwymLy9u?=
 =?us-ascii?Q?SsTrWx5BofIWwgOY7CH8FpXo9wBnH0ZI6WgB6E/ibdIrOO6eaW5rm/oXfe34?=
 =?us-ascii?Q?FvscbLfmERLnSQ3cXITMUgwh6o0jOLGF6fCJGWpF1JYivnZrz63mSdchPoGB?=
 =?us-ascii?Q?OGG5CWwvLx/aaFSZKwROdvEqlInkKHK1JzgHs3CahXBusHqknc7B5xLWJvPB?=
 =?us-ascii?Q?7eulztONDzfic/+pauS4EdbrNDjRWeyo68rELJHaCeETvzF/Q5bherM1phJw?=
 =?us-ascii?Q?GLl6/snzmuQvTqW6vsX4VCCjgaIr2z4ivi7DbiCvns3r4nMcoP0Um9FHrf7R?=
 =?us-ascii?Q?sFU+k/7f3EqTmUvwHeMLIo1tUFaRqZ+gatQYdjjN6Oa6f+fFZEitpKPmifAH?=
 =?us-ascii?Q?3zkXKU3rWU81orZoTsdMvwqfAVjjtzzAplRYsPcfqRabNCYq62zOWMnUPj2C?=
 =?us-ascii?Q?k4aBeFaSy+Vk7MewT77gePnxdG+7k3GfmGi89J5vV5Ts3uEVT3p3fHstEulk?=
 =?us-ascii?Q?5hiwoFMih3kYRjhspNnCrwRfyb1gD0feopofQ89Dt81FBCopiMTsB2UUDKFp?=
 =?us-ascii?Q?bjmojGhxu5OHdiHYBmw8NflGVpHHpNoAq9zMxXIKlM10zzwDlvc7Xf7PjbX5?=
 =?us-ascii?Q?iYbrqo6MulA9dH+GNl8NeLyfEG928rkigZj/qv+B1QiWjbsiT2r69+qjLOZR?=
 =?us-ascii?Q?zRs4S0UpoNcMnL3YmtGdvLlbYfY2t+UhKbPS1E+ddRJW9Uyde8ilPbbU4fWe?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f154ea-ddfc-41fb-6ec1-08dc4d9f6819
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:17:02.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9xYDM+1KOWZdUnz/VJRgP3adsK5TTCkUIfAqBOFTUctGZMMXzzahtUB9iSH1AokdCkwS4vyKKL8UhyeddnNY9HQmatevyLJ8VZi3zRl9zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com

On Tue, Mar 26, 2024 at 08:27:25PM +0800, Tiwei Bie wrote:
>Hi,
>
>Gentle ping.. Please take a look at this series if possible. The changes
>in this series are very straightforward, so it shouldn't require much effort
>to review. But they cover a wide area, making them prone to conflicts
>with other patches :/, e.g.
>
>https://lore.kernel.org/linux-um/20240326073750.726636-1-surenb@google.com/T/#u
>
>Sorry to be impatient, but pinging this. This series was originally posted
>two months ago, and hasn't received a review yet. Just want to make sure that
>this series is not lost..
>
>PS. I have tested this series on both of 64bit and 32bit platforms manually.
>There is also a CI test report from patchwork@emeril.freedesktop.org:
>
>https://lore.kernel.org/all/87bk7rzj70.fsf@intel.com/


yeah, it's a clear improvement.

For patches 1-5 and 7, feel free to add my Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
I commented on patch 8 as I'm not sure it's the right approach and same
thing applies to patch 9.  Patch 6 I'm just not sure as it's the first
time I see that file, so I will leave it to others.

thanks
Lucas De Marchi

>
>Thanks,
>Tiwei
>
>On 3/6/24 6:19 PM, Tiwei Bie wrote:
>> A series of minor fixes and cleanups for UML.
>>
>> Most changes in this series are very straightforward. Please consider
>> picking this series for v6.9.
>>
>> There are still some remaining -Wmissing-prototypes warnings. I plan to
>> send a followup RFC series first to fix those warnings.
>>
>> Feedbacks on this series would be appreciated. Thanks!
>>
>> Changes since v2:
>> https://lore.kernel.org/lkml/20240205114708.25235-1-tiwei.btw@antgroup.com/
>> - Add "um: Move declarations to proper headers";
>> - Add "um: Fix -Wmissing-prototypes warnings for text_poke*";
>> - Add "um: Fix -Wmissing-prototypes warnings for __warp_* and foo";
>> - Make do_set_thread_area() static;
>> - Add the missing header for calibrate_delay_is_known;
>>
>> Tiwei Bie (9):
>>   um: Make local functions and variables static
>>   um: Fix the declaration of vfree
>>   um: Remove unused functions
>>   um: Fix the return type of __switch_to
>>   um: Add missing headers
>>   um: Stop tracking host PID in cpu_tasks
>>   um: Move declarations to proper headers
>>   um: Fix -Wmissing-prototypes warnings for text_poke*
>>   um: Fix -Wmissing-prototypes warnings for __warp_* and foo
>>
>>  arch/um/drivers/pcap_kern.c                |  4 +-
>>  arch/um/drivers/ubd_user.c                 |  2 +-
>>  arch/um/include/asm/ptrace-generic.h       |  3 ++
>>  arch/um/include/shared/as-layout.h         |  1 -
>>  arch/um/include/shared/kern_util.h         |  1 +
>>  arch/um/include/shared/um_malloc.h         |  2 +-
>>  arch/um/kernel/kmsg_dump.c                 |  2 +-
>>  arch/um/kernel/mem.c                       |  2 +
>>  arch/um/kernel/physmem.c                   |  3 +-
>>  arch/um/kernel/process.c                   | 48 +++++-----------------
>>  arch/um/kernel/ptrace.c                    |  3 --
>>  arch/um/kernel/reboot.c                    |  1 +
>>  arch/um/kernel/skas/mmu.c                  |  1 +
>>  arch/um/kernel/skas/process.c              |  5 +--
>>  arch/um/kernel/time.c                      |  7 ++--
>>  arch/um/kernel/tlb.c                       |  7 +---
>>  arch/um/kernel/um_arch.c                   |  1 +
>>  arch/um/kernel/um_arch.h                   |  2 +
>>  arch/um/os-Linux/drivers/ethertap_kern.c   |  2 +-
>>  arch/um/os-Linux/drivers/tuntap_kern.c     |  2 +-
>>  arch/um/os-Linux/main.c                    |  5 +++
>>  arch/um/os-Linux/signal.c                  |  4 +-
>>  arch/um/os-Linux/start_up.c                |  1 +
>>  arch/x86/um/asm/ptrace.h                   |  6 +++
>>  arch/x86/um/bugs_32.c                      |  1 +
>>  arch/x86/um/bugs_64.c                      |  1 +
>>  arch/x86/um/elfcore.c                      |  1 +
>>  arch/x86/um/fault.c                        |  1 +
>>  arch/x86/um/os-Linux/mcontext.c            |  1 +
>>  arch/x86/um/os-Linux/registers.c           |  2 +-
>>  arch/x86/um/os-Linux/tls.c                 |  1 +
>>  arch/x86/um/ptrace_32.c                    |  2 -
>>  arch/x86/um/shared/sysdep/kernel-offsets.h |  3 ++
>>  arch/x86/um/tls_32.c                       |  2 +-
>>  arch/x86/um/user-offsets.c                 |  3 ++
>>  35 files changed, 63 insertions(+), 70 deletions(-)
>>
>

