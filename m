Return-Path: <linux-kernel+bounces-15197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB532822841
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D593284FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01A179A2;
	Wed,  3 Jan 2024 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TujT5M6C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865E1798F;
	Wed,  3 Jan 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704262198; x=1735798198;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SlVD6Rk0BkluSSjYPsszZ6WpuFk/Fh1OB487VtaCkVo=;
  b=TujT5M6C5DYdfncUqOYKwhbtUUdivG1BhH+6R6YYd+JsOiT6pSdUf69S
   F+Mi3ToUl1HUkqzacSn9nTzUdyjxHjq1xPTxrPA2GdXBurL7S22Okky/0
   Pf7b2VKXhP5q85NF4rhco+nrFVD2ax2F6dy3q2utrg4xvJDgm0JVKHA1Q
   VzbRLD344/nTntxMwt4B1/nYXr+IRmI63s9tO8Fu1L7/G7tQ/DyCg+eLK
   YVCfxeyEWY5PWIQcwaSIYyisnhalw6vmdfcS8kjVJYuX8tCOKAHeVFsgN
   tifbqrWrvmFFswjl77lPXRqb6xI/fodo9utnVZVT8yKlZMfUmhP2O4Y+c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4044339"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4044339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 22:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="903334248"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="903334248"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 22:09:52 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Srinivasulu Thanneeru <sthanneeru@micron.com>
Cc: gregory.price <gregory.price@memverge.com>,  Srinivasulu Opensrc
 <sthanneeru.opensrc@micron.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,  "mhocko@suse.com"
 <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "Johannes
 Weiner" <hannes@cmpxchg.org>,  Wei Xu <weixugc@google.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	(Srinivasulu Thanneeru's message of "Wed, 3 Jan 2024 05:26:32 +0000")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
Date: Wed, 03 Jan 2024 14:07:54 +0800
Message-ID: <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Srinivasulu Thanneeru <sthanneeru@micron.com> writes:

> Micron Confidential
>
> Hi Huang, Ying,
>
> My apologies for wrong mail reply format, my mail client settings got changed on my PC.
> Please find comments bellow inline.
>
> Regards,
> Srini
>
>
> Micron Confidential
>> -----Original Message-----
>> From: Huang, Ying <ying.huang@intel.com>
>> Sent: Monday, December 18, 2023 11:26 AM
>> To: gregory.price <gregory.price@memverge.com>
>> Cc: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
>> cxl@vger.kernel.org; linux-mm@kvack.org; Srinivasulu Thanneeru
>> <sthanneeru@micron.com>; aneesh.kumar@linux.ibm.com;
>> dan.j.williams@intel.com; mhocko@suse.com; tj@kernel.org;
>> john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Vinicius
>> Tavares Petrucci <vtavarespetr@micron.com>; Ravis OpenSrc
>> <Ravis.OpenSrc@micron.com>; Jonathan.Cameron@huawei.com; linux-
>> kernel@vger.kernel.org; Johannes Weiner <hannes@cmpxchg.org>; Wei Xu
>> <weixugc@google.com>
>> Subject: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
>>
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> you recognize the sender and were expecting this message.
>>
>>
>> Gregory Price <gregory.price@memverge.com> writes:
>>
>> > On Fri, Dec 15, 2023 at 01:02:59PM +0800, Huang, Ying wrote:
>> >> <sthanneeru.opensrc@micron.com> writes:
>> >>
>> >> > =============
>> >> > Version Notes:
>> >> >
>> >> > V2 : Changed interface to memtier_override from adistance_offset.
>> >> > memtier_override was recommended by
>> >> > 1. John Groves <john@jagalactic.com>
>> >> > 2. Ravi Shankar <ravis.opensrc@micron.com>
>> >> > 3. Brice Goglin <Brice.Goglin@inria.fr>
>> >>
>> >> It appears that you ignored my comments for V1 as follows ...
>> >>
>> >>
>> https://lore.k/
>> ernel.org%2Flkml%2F87o7f62vur.fsf%40yhuang6-
>> desk2.ccr.corp.intel.com%2F&data=05%7C02%7Csthanneeru%40micron.com
>> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
>> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> D%7C3000%7C%7C%7C&sdata=OpMkYCar%2Fv8uHb7AvXbmaNltnXeTvcNUTi
>> bLhwV12Fg%3D&reserved=0
>
> Thank you, Huang, Ying for pointing to this.
> https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
>
> In the presentation above, the adistance_offsets are per memtype.
> We believe that adistance_offset per node is more suitable and flexible.
> since we can change it per node. If we keep adistance_offset per memtype,
> then we cannot change it for a specific node of a given memtype.
>
>> >>
>> https://lore.k/
>> ernel.org%2Flkml%2F87jzpt2ft5.fsf%40yhuang6-
>> desk2.ccr.corp.intel.com%2F&data=05%7C02%7Csthanneeru%40micron.com
>> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
>> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> D%7C3000%7C%7C%7C&sdata=O0%2B6T%2FgU0TicCEYBac%2FAyjOLwAeouh
>> D%2BcMI%2BflOsI1M%3D&reserved=0
>
> Yes, memory_type would be grouping the related memories together as single tier.
> We should also have a flexibility to move nodes between tiers, to address the issues.
> described in use cases above.

We don't pursue absolute flexibility.  We add necessary flexibility
only.  Why do you need this kind of flexibility?  Can you provide some
use cases where memory_type based "adistance_offset" doesn't work?

--
Best Regards,
Huang, Ying

