Return-Path: <linux-kernel+bounces-76885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBDE85FE26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345A91F275C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F672153511;
	Thu, 22 Feb 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXqxUpHV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5118841A8F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619769; cv=fail; b=TpRgw+cxXChmtTxvpAEqSAjb3OP/mahTdG9wt/KD/+oZ3J4ppkPkyBwHZtmwlPEpOlM/vHQP5aKvrfvldBvZtsmNshh/ljgqw1BAPB9tUnlxH8xIr/F7gZW+WyACxKAeIVYWHTdMrShuJy+qlH6vnIpSUWKNJX9AXPfyRkLbigY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619769; c=relaxed/simple;
	bh=2CqciIUKtMDXuPH1Ddbh6AX/x9HgmsRLVM0aYqOh79k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aviWwh/esVqMvHD+sTL/vTVNirWYlE6jrPQ7ieIWBVec1L5HO6L4SHyI5qUaVkbbADa2fcEaU0TG3j+DSpAYgeMBXXehlxfhTVzCS0SlXpfaZIuX6drFQKr0ErvgnFUFp1sP2eOAG4JBJNDojwZjPip7xgqY5gQ3rrVmly+TUy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXqxUpHV; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708619767; x=1740155767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2CqciIUKtMDXuPH1Ddbh6AX/x9HgmsRLVM0aYqOh79k=;
  b=FXqxUpHV4Kw/Y46nzT47Aonykqsr7W/84SPIO4QgQ1ROB4pgve7hcxkK
   9qu4/siB+RurpGFi7z5cROVYJVP1ZCiJXz0S6CftR4HURyTdNPMJtLjWE
   2HVjI8dmMa1fC/KzcioyVmCnJCg+FoaM911p7dtpcgcNdlIWiLFPp4IID
   ejts2U4pnisRcDp7SWu4MEhdRGAqsjzi15TsNCqTByHodHpjo5D0gXXvd
   IHE+r3q/dKI8NB1M3+qEeL03/qgUsQdd1fCoSdQ+gEJtBS+2EuvxfXKfC
   PCiBKnx4fcy6WURmaEoH0l4H+u+GyznnKznRgwAAd7OMBtvZ/nTpnsfwx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13558164"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13558164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10135480"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 08:36:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 08:36:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 08:36:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 08:36:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 08:36:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATIQYhYUHRYTAJEd3bg897KqipVSTaQzkALwXYmw9oaPByScHw8TOt7aSntYEhlgmtBj54ttv/Ne3OZMAKzHJ1sKBYdxNosO2a8EI6DvJINPNX0vQdtSZttoIUYUhqDDVf/9KSej4gAf2O168Ue9VhOKrmD7IjnUW7d/iTysLiRDoCIDMhVT65skL25ThFZkBBZ7OBor8WnC4TESk7FrN1QlqQoX0B/ZJngUBFRZN1ZAFgeE06sKMBpC4TcqEUaAHWswfqLlqZyNPMXp4LWwfYfCIL3w8UZ+UbLRiA8R1slmCJ4bvazKTUAy8Lef0gLCJ/aL+1ACNQ9M1nVJkB5rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4cnHHkB9IPNNglCnh4Zu+4M/XzJp0qiCLG9Fjfe0tY=;
 b=S9F+GN+KT5jSxWjcuhpBTJjUSsH2o0Hmt/oLoppkxMoJtW9To/g2sW0131si91Pm9H86Vl7dBfHs2jXj9fzBWlJb/2L/6vH2u/cXXATSfgvaNLc5glp7Nw4DcVXlBpF3nNdXbTVAwBk0HQMRNa5xzsx+LYvUNhrB74MAj0z4GxRuQeczfMc9J1YIsJXfIWwSu14+WoOSDm2xQqoCHP4Er+xCBbbE549c+7p04dn/A43e+K9OPryHipAEy7+IC6fg8+z+b+jYwX1azO/sD5EuCcFQryqXRKucgs7hsyaMsLptXTQ1Fc7dHmuYfKLC0nke0tICyRYabcO6rpwHTDUiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 16:36:01 +0000
Received: from MN0PR11MB6135.namprd11.prod.outlook.com
 ([fe80::6c14:55af:8583:6ba7]) by MN0PR11MB6135.namprd11.prod.outlook.com
 ([fe80::6c14:55af:8583:6ba7%7]) with mapi id 15.20.7339.009; Thu, 22 Feb 2024
 16:36:01 +0000
Date: Thu, 22 Feb 2024 10:35:57 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, <intel-xe@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: Re: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Message-ID: <fmndbl54srecq54nytq5ethwhzryv3owfnkd47xnqbyib7qx5l@hbne5n5v5ibz>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-3-lucas.demarchi@intel.com>
 <ZcZYhZbLyzSXX8PU@yury-ThinkPad>
 <erg2ymp6raf7ru5ggj4hrrhet4i762msoqa2ronv4znfhlkc6o@nxu6ygtdfmrj>
 <ZddfiNP5qGWNDtiT@yury-ThinkPad>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZddfiNP5qGWNDtiT@yury-ThinkPad>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To MN0PR11MB6135.namprd11.prod.outlook.com
 (2603:10b6:208:3c9::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6135:EE_|CH0PR11MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d01cbe-755e-4a80-79b9-08dc33c45adf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvXIXvqLFng8wjPCGBr8YY8Adqr7SmrSqpFPBhDHw+4/jqO1NekE1qXIYxiIwelkT5yO+mYM/tIfVoO93wL0GofsIQ8gA53646Uxuu56le4Kk77t7iI7zFfKyEsnO+VjQUHefrpWNg8ZBt2ArkPns7q+i2ztsU4seypiv1DwxreQ8UYSMN2JcuvPWgLd1ITinwxOvrRs8qbuw6DXRfYWi1MVmyiLHvGIq83FExQkukOCs7IOE+fQwJTgBJro44JdBIE7WbLO8daPFBxehWiHhPoJMPG7wAYKO7PgX1KieJ82VulLdryB2+s9rlcQx6e9BSzFauCjMvnCLNjFrbRWLzkOimsrPGY2l5tvPAO8tFw7nQeDddv4G0TF3AhU2kdYwtK76hEnr9rbvBk/9CYpEHb5mAPTYlZOEntJGst7anwpKQEowlMVheqjwNpXfZs3N0kkLAkSqQAapO7Xd29XMmNxODZqj+Tx3B5pQrZde9UPVhBnJBgCbUhQ3ohSd7urc1ThB3VxFRCtZ0boIclbQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6135.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVsz0NUWArmZpwBNfS0CMan1uTPLtlwxS7rf3cHJWBuEEQb1DkBFfTdkoijm?=
 =?us-ascii?Q?soi4zsC+35cKwWIrY7cDM7smW/bVaoocdt8P/yGlwDQxTRNGgsAUxjRUVySF?=
 =?us-ascii?Q?JzG/0G5BkMCdN4RGGZJVQ2bJQ08vYAf9HtJwpRWP1V8Zj0RGzDjEUDEF9T1S?=
 =?us-ascii?Q?uTX+w/0kLMGJl17rfbCiB8bI1PjJVm3id337TD0Ejfv7IMvc4MJwAhd2exqA?=
 =?us-ascii?Q?MKamL/i5UjlsPCHRfXQA8FvGDOxvZNwX5wA9KGxkScoX9uIcJp1egtFPTnlZ?=
 =?us-ascii?Q?IWQSbnJKu/EPJRMTtSFSmHkM6tkhN0/zblmRfflMUsau4xwq9NYQU0TTqNus?=
 =?us-ascii?Q?ZxJQXj6kCS8SDGlTJzNBLQGMlfyM3BX3kPt4Ws32BBOJRrAcrYRyXQJVq96G?=
 =?us-ascii?Q?6dtwTWenvfkbJGCj5Etic8jdz+ydM4e0NgrGNm9sV4/EvJAY1nIzhiaizW/e?=
 =?us-ascii?Q?stgm6nRdFTrQ25YQllzjnaIjydvrrpVT62CqRhJzvZ7wdlTeQLAkt93sG5PY?=
 =?us-ascii?Q?ngXVfhoDjnTXfVpFlyzcXKxEXs6p2l44UdRnhp31yssJOShDF/oKTBMFyZWg?=
 =?us-ascii?Q?W71AyOh9PAhsBv8bKw0FAiGpq8X3F4OF3fe82fP17wwtX0WFOuH40ITYEjSE?=
 =?us-ascii?Q?oyqBAl/EKK4nozEOBKNTSkxs89vMRYNWUFP6HGQPiwAAEGxVP6i4SExsudm7?=
 =?us-ascii?Q?ZVpCWXGtO6QIcwL8zUCCr+y7Rnodp3aI1lkjltR3CMZQ7/nsY3m/vdkTJBnv?=
 =?us-ascii?Q?HuHAp/398vAXUBWDqOyrb/s3EOG/Io+Zh5iJpgWSYf6uOE7yD26N8eEL7BkD?=
 =?us-ascii?Q?qtzsXFu9V9kxOKkdgGjE775ZusDkgqbsS0C7QgYikKglIBPdwQaX6Mrp0e+e?=
 =?us-ascii?Q?y5NPSwdboZb/QHyq0i1XGCo8ZIkH7UEBrZRci9VTkhxLmPiJE32xMW23WuD7?=
 =?us-ascii?Q?TKzy55wMDpBBbuOoXza67lV/0gZZI9EsclY3QEDVjfw2d/nYUjXDvygr0KLf?=
 =?us-ascii?Q?4BbWmMF6eBkY3CiA7Z/sOlMBgp0gke0MJ1S+UFyBbLgIoFymRVqAN0G00q1b?=
 =?us-ascii?Q?xWnqzvCG4UJXUcrmUHDmXjkokwMQ+6u3BdF6XUeBOhnmZMMhLxErxyvzHiaL?=
 =?us-ascii?Q?xtVDu19Bg89HxhPMJ5MdA4X8EczKbyjdaqPL6gn8VsLl7axNVLsrOU37rGVe?=
 =?us-ascii?Q?xDMHD9noUnA1euZhrWmpqflUzWf+WuZjq6jOTVlv6CO/nB7RYVKqXGJSl9qC?=
 =?us-ascii?Q?WBgaFA8bZ7lbwLTOpqAPp6PGjhPop4fpb8inSRJnFYtoEmsPj17pVvF7iekH?=
 =?us-ascii?Q?vTCjd+TZ5Wva6An3bg45TyoZ3vaybyBrRsNg0oq5WW8BS9L0v7YqswkXcCP+?=
 =?us-ascii?Q?DR2ef1Gf4MAHQTnzGbjjRXjx8Jl/n7R6mSjJBYJnXBD2D0rmTgV6RJf4HDcG?=
 =?us-ascii?Q?uV0Mne0etHCQtQ0godnfFHWJWWP+3eeQ1c6jg9VLshDPou/uDPqZRvRUEXCo?=
 =?us-ascii?Q?czLZqdEvhVZ7pADgOK/A7oWKvb6lqwMJevfnJS1H+tNGcHiBZLu3QUJIU06H?=
 =?us-ascii?Q?QCuXFykJoygDkJasGMGlDVMl/MSWhPZpGbsYl/ayrg8uquRhXqQSAS6XN/Tn?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d01cbe-755e-4a80-79b9-08dc33c45adf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6135.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 16:36:01.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NWqQjfeS0+TkB9x9ZOeOUmwEse+iIR6O9ZrIcG2+9SFuayFTnfqttCb8kdgP2cgHb0TUDFBLpEbErhSPXn2sr5THaw1CCniFyp9DXnLk2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com

On Thu, Feb 22, 2024 at 06:51:52AM -0800, Yury Norov wrote:
>On Mon, Feb 19, 2024 at 11:13:57PM -0600, Lucas De Marchi wrote:
>> On Fri, Feb 09, 2024 at 08:53:25AM -0800, Yury Norov wrote:
>> > On Wed, Feb 07, 2024 at 11:45:20PM -0800, Lucas De Marchi wrote:
>> > > Implement fixed-type BIT() to help drivers add stricter checks, like was
>> > > done for GENMASK.
>> > >
>> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> > > Acked-by: Jani Nikula <jani.nikula@intel.com>
>> >
>> > So I get v1 from Jan.23 in my mailbox, and this one is v3. Did I miss
>> > a v2? Anyways, please bear my reviewed-by from v1 for this patch.
>>
>> Jan 23 was actually the v2 and I missed the subject prefix.
>>
>> My understanding was that you were going to apply this through some
>> bitmap tree, but checking MAINTAINERS now it seems there's no git tree
>> associated.  So I will just add your r-b and merge this through
>> drm-xe.
>
>I've got a bitmap-related branch. I can move this series in there if
>you prefer. At your discretion.
>
>https://github.com/norov/linux/tree/bitmap_for_next

yeah, sounds good.

thanks
Lucas De Marchi

>
>Thanks,
>Yury

