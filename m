Return-Path: <linux-kernel+bounces-16275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDA823C08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C69287D98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8B18ECC;
	Thu,  4 Jan 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCoogXs2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5601E52E;
	Thu,  4 Jan 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704348424; x=1735884424;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uPiewepm8PfvEB9N3GZvZfx/+4uX3nbmL/Wb6i5OHqg=;
  b=SCoogXs2Vo9x5blnb3CNA0KzkIZ8HZBf191BTCO7bTA7ZOasKHHgUd+U
   YsJu8KdoxgVKIy/I2FrhQGekaQw1oub9rseKvZgQxbUMuXdfgZN77jORn
   XU+KwD0RjSTVw7VGLs46I5u8eprJFreY8U0SiJXuB3hZzsftBHPz9zINT
   PbgUm2gcR2xYnEkNJUAMBKilEUuM5+73fj1EYOsPRjCIShrkTdf/QTc3q
   lFS4N1WZ5TvLzuum5s88Qpa5mdoBvqeOuhO9kYSg5+dxZ8/hJr7Hh/xHV
   WVCo8R/4QbeUEMfNzyt49uMJfScRsYNRDSZHw2ytdg5W/g7kR98fPKJfU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="396855975"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="396855975"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 22:07:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="14741076"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 22:06:59 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Srinivasulu Thanneeru <sthanneeru@micron.com>
Cc: gregory.price <gregory.price@memverge.com>,  Srinivasulu Opensrc
 <sthanneeru.opensrc@micron.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,  "mhocko@suse.com"
 <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Wei Xu <weixugc@google.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	(Srinivasulu Thanneeru's message of "Wed, 3 Jan 2024 08:47:57 +0000")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
Date: Thu, 04 Jan 2024 14:05:01 +0800
Message-ID: <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Srinivasulu Thanneeru <sthanneeru@micron.com> writes:

>> -----Original Message-----
>> From: Huang, Ying <ying.huang@intel.com>
>> Sent: Wednesday, January 3, 2024 2:00 PM
>> To: Srinivasulu Thanneeru <sthanneeru@micron.com>
>> Cc: gregory.price <gregory.price@memverge.com>; Srinivasulu Opensrc
>> <sthanneeru.opensrc@micron.com>; linux-cxl@vger.kernel.org; linux-
>> mm@kvack.org; aneesh.kumar@linux.ibm.com; dan.j.williams@intel.com;
>> mhocko@suse.com; tj@kernel.org; john@jagalactic.com; Eishan Mirakhur
>> <emirakhur@micron.com>; Vinicius Tavares Petrucci
>> <vtavarespetr@micron.com>; Ravis OpenSrc <Ravis.OpenSrc@micron.com>;
>> Jonathan.Cameron@huawei.com; linux-kernel@vger.kernel.org; Johannes
>> Weiner <hannes@cmpxchg.org>; Wei Xu <weixugc@google.com>
>> Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory
>> tiers
>>
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> you recognize the sender and were expecting this message.
>>
>>
>> Srinivasulu Thanneeru <sthanneeru@micron.com> writes:
>>
>> > Micron Confidential
>> >
>> >
>> >
>> > Micron Confidential
>> >> -----Original Message-----
>> >> From: Huang, Ying <ying.huang@intel.com>
>> >> Sent: Wednesday, January 3, 2024 11:38 AM
>> >> To: Srinivasulu Thanneeru <sthanneeru@micron.com>
>> >> Cc: gregory.price <gregory.price@memverge.com>; Srinivasulu Opensrc
>> >> <sthanneeru.opensrc@micron.com>; linux-cxl@vger.kernel.org; linux-
>> >> mm@kvack.org; aneesh.kumar@linux.ibm.com;
>> dan.j.williams@intel.com;
>> >> mhocko@suse.com; tj@kernel.org; john@jagalactic.com; Eishan Mirakhur
>> >> <emirakhur@micron.com>; Vinicius Tavares Petrucci
>> >> <vtavarespetr@micron.com>; Ravis OpenSrc
>> <Ravis.OpenSrc@micron.com>;
>> >> Jonathan.Cameron@huawei.com; linux-kernel@vger.kernel.org; Johannes
>> >> Weiner <hannes@cmpxchg.org>; Wei Xu <weixugc@google.com>
>> >> Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between
>> memory
>> >> tiers
>> >>
>> >> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> >> you recognize the sender and were expecting this message.
>> >>
>> >>
>> >> Srinivasulu Thanneeru <sthanneeru@micron.com> writes:
>> >>
>> >> > Micron Confidential
>> >> >
>> >> > Hi Huang, Ying,
>> >> >
>> >> > My apologies for wrong mail reply format, my mail client settings got
>> >> changed on my PC.
>> >> > Please find comments bellow inline.
>> >> >
>> >> > Regards,
>> >> > Srini
>> >> >
>> >> >
>> >> > Micron Confidential
>> >> >> -----Original Message-----
>> >> >> From: Huang, Ying <ying.huang@intel.com>
>> >> >> Sent: Monday, December 18, 2023 11:26 AM
>> >> >> To: gregory.price <gregory.price@memverge.com>
>> >> >> Cc: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
>> >> >> cxl@vger.kernel.org; linux-mm@kvack.org; Srinivasulu Thanneeru
>> >> >> <sthanneeru@micron.com>; aneesh.kumar@linux.ibm.com;
>> >> >> dan.j.williams@intel.com; mhocko@suse.com; tj@kernel.org;
>> >> >> john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>;
>> Vinicius
>> >> >> Tavares Petrucci <vtavarespetr@micron.com>; Ravis OpenSrc
>> >> >> <Ravis.OpenSrc@micron.com>; Jonathan.Cameron@huawei.com;
>> linux-
>> >> >> kernel@vger.kernel.org; Johannes Weiner <hannes@cmpxchg.org>; Wei
>> Xu
>> >> >> <weixugc@google.com>
>> >> >> Subject: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory
>> >> tiers
>> >> >>
>> >> >> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments
>> unless
>> >> >> you recognize the sender and were expecting this message.
>> >> >>
>> >> >>
>> >> >> Gregory Price <gregory.price@memverge.com> writes:
>> >> >>
>> >> >> > On Fri, Dec 15, 2023 at 01:02:59PM +0800, Huang, Ying wrote:
>> >> >> >> <sthanneeru.opensrc@micron.com> writes:
>> >> >> >>
>> >> >> >> > =============
>> >> >> >> > Version Notes:
>> >> >> >> >
>> >> >> >> > V2 : Changed interface to memtier_override from adistance_offset.
>> >> >> >> > memtier_override was recommended by
>> >> >> >> > 1. John Groves <john@jagalactic.com>
>> >> >> >> > 2. Ravi Shankar <ravis.opensrc@micron.com>
>> >> >> >> > 3. Brice Goglin <Brice.Goglin@inria.fr>
>> >> >> >>
>> >> >> >> It appears that you ignored my comments for V1 as follows ...
>> >> >> >>
>> >> >> >>
>> >> >>
>> >>
>> https://lore.k/
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7Ce9e04d25ea7540100
>> cf308dc0c366eb1%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> 8398675187014390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> &sdata=k6J1wxcuHTwR9eoD9Yz137bkn6wt1L9zpf5YaOjoIqA%3D&reserved=0
>> >>
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7C3e5d38eb47be463c2
>> >>
>> 95c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> >>
>> 8398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> >>
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> >>
>> &sdata=7fPxb1YYR2tZ0v2FB1vlXnMJFcI%2Fr9HT2%2BUD1MNUd%2FI%3D&re
>> >> served=0
>> >> >> ernel.org%2Flkml%2F87o7f62vur.fsf%40yhuang6-
>> >> >>
>> >>
>> desk2.ccr.corp.intel.com%2F&data=05%7C02%7Csthanneeru%40micron.com
>> >> >>
>> >>
>> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
>> >> >>
>> >>
>> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
>> >> >>
>> >>
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> >> >>
>> >>
>> D%7C3000%7C%7C%7C&sdata=OpMkYCar%2Fv8uHb7AvXbmaNltnXeTvcNUTi
>> >> >> bLhwV12Fg%3D&reserved=0
>> >> >
>> >> > Thank you, Huang, Ying for pointing to this.
>> >> >
>> >>
>> https://lpc.ev/
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7Ce9e04d25ea7540100
>> cf308dc0c366eb1%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> 8398675187014390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> &sdata=%2F0AW8RYpTIa7%2FiScnkzmmTeAE9TYqjsuWWjTuxBPptk%3D&rese
>> rved=0
>> >>
>> ents%2Fevent%2F16%2Fcontributions%2F1209%2Fattachments%2F1042%2F1
>> >>
>> 995%2FLive%2520In%2520a%2520World%2520With%2520Multiple%2520Me
>> >>
>> mory%2520Types.pdf&data=05%7C02%7Csthanneeru%40micron.com%7C3e
>> >>
>> 5d38eb47be463c295c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806
>> >>
>> f%7C0%7C0%7C638398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJW
>> >>
>> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
>> >>
>> 000%7C%7C%7C&sdata=1fGraxff7%2F1hNaE0an0xEudSKSUvaF3HgClMkmdC7
>> >> n8%3D&reserved=0
>> >> >
>> >> > In the presentation above, the adistance_offsets are per memtype.
>> >> > We believe that adistance_offset per node is more suitable and flexible.
>> >> > since we can change it per node. If we keep adistance_offset per
>> memtype,
>> >> > then we cannot change it for a specific node of a given memtype.
>> >> >
>> >> >> >>
>> >> >>
>> >>
>> https://lore.k/
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7Ce9e04d25ea7540100
>> cf308dc0c366eb1%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> 8398675187014390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> &sdata=k6J1wxcuHTwR9eoD9Yz137bkn6wt1L9zpf5YaOjoIqA%3D&reserved=0
>> >>
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7C3e5d38eb47be463c2
>> >>
>> 95c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> >>
>> 8398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> >>
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> >>
>> &sdata=7fPxb1YYR2tZ0v2FB1vlXnMJFcI%2Fr9HT2%2BUD1MNUd%2FI%3D&re
>> >> served=0
>> >> >> ernel.org%2Flkml%2F87jzpt2ft5.fsf%40yhuang6-
>> >> >>
>> >>
>> desk2.ccr.corp.intel.com%2F&data=05%7C02%7Csthanneeru%40micron.com
>> >> >>
>> >>
>> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
>> >> >>
>> >>
>> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
>> >> >>
>> >>
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> >> >>
>> >>
>> D%7C3000%7C%7C%7C&sdata=O0%2B6T%2FgU0TicCEYBac%2FAyjOLwAeouh
>> >> >> D%2BcMI%2BflOsI1M%3D&reserved=0
>> >> >
>> >> > Yes, memory_type would be grouping the related memories together as
>> >> single tier.
>> >> > We should also have a flexibility to move nodes between tiers, to
>> address
>> >> the issues.
>> >> > described in use cases above.
>> >>
>> >> We don't pursue absolute flexibility.  We add necessary flexibility
>> >> only.  Why do you need this kind of flexibility?  Can you provide some
>> >> use cases where memory_type based "adistance_offset" doesn't work?
>> >
>> > - /sys/devices/virtual/memory_type/memory_type/ adistance_offset
>> > memory_type based "adistance_offset will provide a way to move all nodes
>> of same memory_type (e.g. all cxl nodes)
>> > to different tier.
>>
>> We will not put the CXL nodes with different performance metrics in one
>> memory_type.  If so, do you still need to move one of them?
>
> From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
> abstract_distance_offset: override by users to deal with firmware issue.
>
> say firmware can configure the cxl node into wrong tiers, similar to
> that it may also configure all cxl nodes into single memtype, hence
> all these nodes can fall into a single wrong tier.
> In this case, per node adistance_offset would be good to have ?

I think that it's better to fix the error firmware if possible.  And
these are only theoretical, not practical issues.  Do you have some
practical issues?

I understand that users may want to move nodes between memory tiers for
different policy choices.  For that, memory_type based adistance_offset
should be good.

> --
> Srini
>> > Whereas /sys/devices/system/node/node2/memtier_override provide a
>> way migrate a node from one tier to another.
>> > Considering a case where we would like to move two cxl nodes into two
>> different tiers in future.
>> > So, I thought it would be good to have flexibility at node level instead of at
>> memory_type.

--
Best Regards,
Huang, Ying

