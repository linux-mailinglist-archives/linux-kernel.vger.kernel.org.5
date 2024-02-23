Return-Path: <linux-kernel+bounces-77785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3973860A38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CAF1C2379F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193811CB1;
	Fri, 23 Feb 2024 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQogSnRD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791511715;
	Fri, 23 Feb 2024 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666019; cv=fail; b=n/kEs5fGXWaAEHK14+wdsoz1LfTUX+KfSRZv/53xfVfvXPrcnliG+2wHh2ey3yfKWlo252B0C9L1w4fJ/4Kk87+d7axlKF+z2LANj8DYj8cHRKMBGPGZq4QJ6QEflOCGk1C8+e9Yd5jb/5KXcbeycgHgrUsGAZJqwaRNAss5ckA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666019; c=relaxed/simple;
	bh=7rjntsW0xiYo3C1TT4JdxVthl76YASnSjlUNUxyKXb0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=no0+lHgb+EDKE1ZKqAyl8LeyuapbImgUyMAj3+VlJ0eE1HVusFKoxifIC2SgxFgDyfWMdOTyLhlAq5RM8FhH6o947OJHciHi36MkDz1AI0tD0SUww+cyp7Y2ZghGQwKEqNqJtdgzNbupUzMqeXk43tAG7bKnV/S86vwWosuZOWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQogSnRD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708666017; x=1740202017;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7rjntsW0xiYo3C1TT4JdxVthl76YASnSjlUNUxyKXb0=;
  b=JQogSnRDQsqmCX5Ugmls/puyeYmo0GB7IvKKY4kUDZ2P03Xyv6tnjW4E
   a9ARPCJU2p9Fn4Ucnsy7TOlIjwQ1VvGOo7RVMps4e4ZBQWEqZh00TeR+v
   JW8pHbAiYdMUJu6v+05OzFADrl5W5yvLEk4WryxtzoH8d/jCyYQyaJYwB
   c+TB9IqvzjrAe6u4LyMQrCXlO/Pra9HUt1Mzq1js0NNyH+UsdWDY693ZJ
   /oJVfTviLevF0uBGJcDdMp9XUmgvnU7vuh3jjiON/OjKVi5X8w4JC3noQ
   mjnFLhwqxM8xYK3sCZe2uDMu4DQhLgLHeVa0Zsxk2yCFbSkJ9MoJmTcQq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3093143"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3093143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10556414"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 21:26:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 21:26:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 21:26:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 21:26:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0sb2KIUHZsGonZXhzy6Em+p2oUHYOxahWYVSPBgkqK42dDIsOQL6RNJh+kBFoyCaiOILG/ciSLCnptHzKRpfyDDHUUj8JoWRv5eMPy0/7xTq/YspffJw6Gkl+AFqdsr1DthJ5qtm0nStdpVDQ8Ah5kBxn1iMHWvT7Y3cssA7ztWdg32W0XFgmo2btZs2I742UwkRu7NmJi5shAfGa3YH2oZXRNNlrSbu2Ahx2XLqDc3M0hs7k6Rn/Wms3znBG0NOn1ynnWFXKTZOP72tcPm7oO40NtBPd6VmvJVBdLPxEloCuXIJ8AFzgrjL3PhZec4pzyBUpvP+OR38Z5sAIf2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtALn7iiPWe20aeLiEveKT7lDMZO8kWJVWk5qFg9I0Q=;
 b=WjCbSklKXG60UqooEWbw/9/1ait7SyFmnoTe4/KYCwtVuCokIiWVwBSPO3QtbtIWOpRCTk955CxGEgOKQl0TZ+/RaAp0cCEaCcrDgRpW5oqh3uEey0coQ74psth74Nhw2OqdVWhsiJx3boxvde8CJvRt1Y4d/t2JRPWYxiyBEPhETV3kEz3FldD8I5DfLNvPOG59tFJA+rCej8cGLqJTrUBJp+q8Z155qjV0IK5Pix3wf0ryTovgyyC3pUmyYyl2mJ77y6xMK4PMmv4BbsDKvi6yGS4Fzb8CrPWCe7BbcDSOru+gemDKdg9jimtyB8M1i+GMQfHFkoE5gPWmn5IT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6442.namprd11.prod.outlook.com (2603:10b6:208:3a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Fri, 23 Feb
 2024 05:26:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 05:26:47 +0000
Date: Thu, 22 Feb 2024 21:26:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	Ira Weiny <ira.weiny@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>
CC: <rafael@kernel.org>, <wangkefeng.wang@huawei.com>,
	<tanxiaofei@huawei.com>, <mawupeng1@huawei.com>, <tony.luck@intel.com>,
	<linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
 <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e104ae1-28c1-42c6-1f59-08dc343007c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwCiO+UNBKcJo3pB7sB+NMnaK5NrzmgHnwnlmq6olbVbXAAkglM/sPx3sgF5CBl73L9lANozAV67SKFCnser7L0rGkIztLvxk+ZBvWdXzG9cbhANt50QV/+TsbnRFy4I58xVSG8I7ad3mt3HT5xVE6TLImtMvPmr9SgXlLnQiP8zYMAP20rdm8dCt0pWmoSaUuoEb9rb8EB4qQbYp9hoahKerR/eS035XjSNVRUZruRvLnvxT/bEvfqy9mS/vW6x0IjIN+VrXvrue3KtxjODIcKj5rT2IdIXn6FrmKlmoXl8dHMqR14+XR55CEICusAcwJf8X7i+jCwuBQ3ufs8VhlNgHZ4lYSaaQNcbdPPkGncRlLG37oX/lDDHCr9CqEGY7LnimT2sboiIJbsLVHbFPqzUFovpxfTxItgHsoJY0ocVZp8PJ6JusmHPuLEsr/nTeB044W8Gw83rDh7SX7z8SvLbS8vSBo2AzYUGlHbbGkTuL5Ku0kjSXok8x97soi6js5qaS+qhVjlHvnot3Qb6jFIZZisZeBz/D2N4kcXvJcsW35lZM26Xp6hGSDilBA1J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvDOZPI8FqrFYhaa+S8vmKTAjUYWggoLD2veqOea1LA0cNbR00bxU8yqgkir?=
 =?us-ascii?Q?mpZgE2huyy9Tb/M9PCo5mNdre3m6lDEhfRkuK1yMeGBMVeMkfzUfoNqwaWMA?=
 =?us-ascii?Q?YW9GiEas+Vyl1ZZFH2lnKcTNkK1P5X1Q9+BtyXHN4NpfhpECxOUclfmv9+tl?=
 =?us-ascii?Q?ta3KegKSq9KkTmue9LZV7fcGpcyHykoBF+H/lHv2mB+F9N/p8X+jSR5fRUH5?=
 =?us-ascii?Q?VaOx7znTH9TjjoQSs02oTH0FL0ET275TZQKaFgdoXQ3lesPH0EuTPCRVdn6n?=
 =?us-ascii?Q?069aZ7f3nIvmaBb0RXF74H8ibDUKauogK0JtJ+ki64YX0oi/CWPHaNne6XnZ?=
 =?us-ascii?Q?yASb3dj/8LAOcbAEDpp3mF8pdhBM7Zr222J2vl2ocjsv3IywUzr9eu7jYwP8?=
 =?us-ascii?Q?bEFRStjj2JwMoutSKZbSpWK7FVyumhJgpVdzefwsgh0eF05L2LJYaceFtHX3?=
 =?us-ascii?Q?uNULy/joLLduMjNeEW1mNxzLD/cZYyvsJDxcWVreiBdL5E2bk7nz9WqZhGOo?=
 =?us-ascii?Q?S5DEkilfpY6cE8tJ7sLBxNcOI5ZTYXWl4LvR0iWuCDh37zJ7N/3tk6s+4ztk?=
 =?us-ascii?Q?sMojuOojp7KL0Ug6+jBhGkMnpeL1k4ZVh1U8767Ot8Zu9LUXRX08q4qEnjB+?=
 =?us-ascii?Q?NIP6kIR75ZkD14T5wMBnaezLLN21baeJJFVE5i61xkG1yRQZd3Nnzd7L0OIO?=
 =?us-ascii?Q?kYisr4UpETkA1rSw6GqRpZ38Pr5j0HpwLCxLyVOSWKk6b1OKDlK4Q2z8bdof?=
 =?us-ascii?Q?1pKJlLXd8yBr7YQ0f+Re8lCbi9kVOhiHlprCQJSpUVUWIxrM67fq9WP3a1WB?=
 =?us-ascii?Q?SHCUUnSH1gPPIe9jyIdLMpkIw4D04fa9BIhT3JNnjdthW3ZTr4S9gIpytNYK?=
 =?us-ascii?Q?4nkD4xP+r6CIsmMHJasYV0B7OoUG1yrXgcfeyHy3wfnKRPgYfxMNCcrrult8?=
 =?us-ascii?Q?oJOGamQ/QR6161g+A9HGxDVpF0oRD55ZwfZPNrs2r+KjbXtLhsT8tJCDnFMm?=
 =?us-ascii?Q?D2vui6dtcE06+wCzsZ4Y+j7uWdEmP9JEI8W7V3qlmCA202ZO6XMWebU7ECyM?=
 =?us-ascii?Q?q/tJzcy/Q+OQEmGCRDCFw/lpvxbRNu1Kd69in16zk4NyzaMG6IbPQo/09Ur4?=
 =?us-ascii?Q?HfzbfO1O/8iXCAOgDm7QP0OIWppEhSl5wltLdWgx4pquDwYREoyrV4uQ/sXL?=
 =?us-ascii?Q?A9ki9/LUi0dCEiHfXspWRz4DhHswJ8t3SHk2G5WrDAKiNz/2ERuN9Xib4g+x?=
 =?us-ascii?Q?ibvoLXWHBKHUairpILeArcdNud6OzwdKeo0s9/rPD8bL6BPitsIQbjL4icvO?=
 =?us-ascii?Q?wH3fnh+i7+ZPrpc3m4hkTk9GXS6VSjgUyH8dK0vbdam9hvqkWkoF5ktHnmFI?=
 =?us-ascii?Q?wwomUz9VJ24U56thWwm4+KPf9WsYf6C7OtaAa7I/xsDzN4PjABi1sPpr2crJ?=
 =?us-ascii?Q?3IyzjcVtZkDDSKi+NlrCNAN+pI3mlftL+hNknmLeZ1J62PF3s7035Pv8G5A2?=
 =?us-ascii?Q?TAVQZ1ij3Gs7MfqRZ9XHFyCWrvPJDl2zFcWuDyo7Ln+eDIqtEnBTHUEeJ5AL?=
 =?us-ascii?Q?MKKe+1SFhJuA9py3i9AqJXzQYlQMFKC44Fybi4TO1pC36Bup7BnOQBLUL8FH?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e104ae1-28c1-42c6-1f59-08dc343007c1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:26:47.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRamIWsoHiUythBLrvSfT8lSvf2x8l0k1DQOVgMEoSiKSt17Fo6ZtcEGgeWiYgQov8EDvKKRup0WRai6o6p9GrzkkR5fszDW2YMI9YM67Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6442
X-OriginatorOrg: intel.com

Shuai Xue wrote:
> 
> 
> On 2024/2/19 17:25, Borislav Petkov wrote:
> > On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:
> >> Synchronous error was detected as a result of user-space process accessing
> >> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> >> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> >> memory_failure() work which poisons the related page, unmaps the page, and
> >> then sends a SIGBUS to the process, so that a system wide panic can be
> >> avoided.
> >>
> >> However, no memory_failure() work will be queued when abnormal synchronous
> >> errors occur. These errors can include situations such as invalid PA,
> >> unexpected severity, no memory failure config support, invalid GUID
> >> section, etc. In such case, the user-space process will trigger SEA again.
> >> This loop can potentially exceed the platform firmware threshold or even
> >> trigger a kernel hard lockup, leading to a system reboot.
> >>
> >> Fix it by performing a force kill if no memory_failure() work is queued
> >> for synchronous errors.
> >>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >> ---
> >>  drivers/acpi/apei/ghes.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >> index 7b7c605166e0..0892550732d4 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c
> >> @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
> >>  		}
> >>  	}
> >>  
> >> +	/*
> >> +	 * If no memory failure work is queued for abnormal synchronous
> >> +	 * errors, do a force kill.
> >> +	 */
> >> +	if (sync && !queued) {
> >> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
> >> +		force_sig(SIGBUS);
> >> +	}
> > 
> > Except that there are a bunch of CXL GUIDs being handled there too and
> > this will sigbus those processes now automatically.
> 
> Before the CXL GUIDs added, @Tony confirmed that the HEST notifications are always
> asynchronous on x86 platform, so only Synchronous External Abort (SEA) on ARM is
> delivered as a synchronous notification.
> 
> Will the CXL component trigger synchronous events for which we need to terminate the
> current process by sending sigbus to process?

None of the CXL component errors should be handled as synchronous
events. They are either asynchronous protocol errors, or effectively
equivalent to CPER_SEC_PLATFORM_MEM notifications.

