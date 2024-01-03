Return-Path: <linux-kernel+bounces-15274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2582297B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFDA1F23D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D66182AF;
	Wed,  3 Jan 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ3RxjMN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1EA18059;
	Wed,  3 Jan 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704270706; x=1735806706;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=K2D+DOH/3k8UCY1rTsgGy6wghC2CdFVcWHWsDmKE3ec=;
  b=KZ3RxjMN9232lkF+LevQsNw5gbdXrH8fE7lmHMicTyjV9y0mUskoJ4ug
   AiHThL+2qYVlsMzbg7do5A6fkW8ZFOcctdZBHwE+oPrVz89sat9VmXndI
   NtVHBIAnFgk55wPq4YaSOzhVU/E8Dd82r1bEiOuCPAauvfyRUcPAb321F
   saezyA9rLFzLx4jScHpTzMNu6e7Ypix47qFDzNKJei6XHYD5rO2jB/Aua
   1fnlfmlSANOfbo0xyqOKZ2s2g7bqTCalgu0jKPxswzp6xljN5ON646TXO
   batwxC+E35aGvub4wOlxHFy2cey9JWeTPOnsBf9wy+ine014dOFoU9tYb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="395854473"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="395854473"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="773079904"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="773079904"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:31:41 -0800
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
In-Reply-To: <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	(Srinivasulu Thanneeru's message of "Wed, 3 Jan 2024 07:56:42 +0000")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
Date: Wed, 03 Jan 2024 16:29:42 +0800
Message-ID: <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
>
>
> Micron Confidential
>> -----Original Message-----
>> From: Huang, Ying <ying.huang@intel.com>
>> Sent: Wednesday, January 3, 2024 11:38 AM
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
>> > Hi Huang, Ying,
>> >
>> > My apologies for wrong mail reply format, my mail client settings got
>> changed on my PC.
>> > Please find comments bellow inline.
>> >
>> > Regards,
>> > Srini
>> >
>> >
>> > Micron Confidential
>> >> -----Original Message-----
>> >> From: Huang, Ying <ying.huang@intel.com>
>> >> Sent: Monday, December 18, 2023 11:26 AM
>> >> To: gregory.price <gregory.price@memverge.com>
>> >> Cc: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
>> >> cxl@vger.kernel.org; linux-mm@kvack.org; Srinivasulu Thanneeru
>> >> <sthanneeru@micron.com>; aneesh.kumar@linux.ibm.com;
>> >> dan.j.williams@intel.com; mhocko@suse.com; tj@kernel.org;
>> >> john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Vinicius
>> >> Tavares Petrucci <vtavarespetr@micron.com>; Ravis OpenSrc
>> >> <Ravis.OpenSrc@micron.com>; Jonathan.Cameron@huawei.com; linux-
>> >> kernel@vger.kernel.org; Johannes Weiner <hannes@cmpxchg.org>; Wei Xu
>> >> <weixugc@google.com>
>> >> Subject: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory
>> tiers
>> >>
>> >> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> >> you recognize the sender and were expecting this message.
>> >>
>> >>
>> >> Gregory Price <gregory.price@memverge.com> writes:
>> >>
>> >> > On Fri, Dec 15, 2023 at 01:02:59PM +0800, Huang, Ying wrote:
>> >> >> <sthanneeru.opensrc@micron.com> writes:
>> >> >>
>> >> >> > =============
>> >> >> > Version Notes:
>> >> >> >
>> >> >> > V2 : Changed interface to memtier_override from adistance_offset.
>> >> >> > memtier_override was recommended by
>> >> >> > 1. John Groves <john@jagalactic.com>
>> >> >> > 2. Ravi Shankar <ravis.opensrc@micron.com>
>> >> >> > 3. Brice Goglin <Brice.Goglin@inria.fr>
>> >> >>
>> >> >> It appears that you ignored my comments for V1 as follows ...
>> >> >>
>> >> >>
>> >>
>> https://lore.k/
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7C3e5d38eb47be463c2
>> 95c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> 8398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> &sdata=7fPxb1YYR2tZ0v2FB1vlXnMJFcI%2Fr9HT2%2BUD1MNUd%2FI%3D&re
>> served=0
>> >> ernel.org%2Flkml%2F87o7f62vur.fsf%40yhuang6-
>> >>
>> desk2.ccr.corp.intel.com%2F&data=05%7C02%7Csthanneeru%40micron.com
>> >>
>> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
>> >>
>> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
>> >>
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> >>
>> D%7C3000%7C%7C%7C&sdata=OpMkYCar%2Fv8uHb7AvXbmaNltnXeTvcNUTi
>> >> bLhwV12Fg%3D&reserved=0
>> >
>> > Thank you, Huang, Ying for pointing to this.
>> >
>> https://lpc.ev/
>> ents%2Fevent%2F16%2Fcontributions%2F1209%2Fattachments%2F1042%2F1
>> 995%2FLive%2520In%2520a%2520World%2520With%2520Multiple%2520Me
>> mory%2520Types.pdf&data=05%7C02%7Csthanneeru%40micron.com%7C3e
>> 5d38eb47be463c295c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806
>> f%7C0%7C0%7C638398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJW
>> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
>> 000%7C%7C%7C&sdata=1fGraxff7%2F1hNaE0an0xEudSKSUvaF3HgClMkmdC7
>> n8%3D&reserved=0
>> >
>> > In the presentation above, the adistance_offsets are per memtype.
>> > We believe that adistance_offset per node is more suitable and flexible.
>> > since we can change it per node. If we keep adistance_offset per memtype,
>> > then we cannot change it for a specific node of a given memtype.
>> >
>> >> >>
>> >>
>> https://lore.k/
>> %2F&data=05%7C02%7Csthanneeru%40micron.com%7C3e5d38eb47be463c2
>> 95c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
>> 8398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
>> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
>> &sdata=7fPxb1YYR2tZ0v2FB1vlXnMJFcI%2Fr9HT2%2BUD1MNUd%2FI%3D&re
>> served=0
>> >> ernel.org%2Flkml%2F87jzpt2ft5.fsf%40yhuang6-
>> >>
>> desk2.ccr.corp.intel.com%2F&data=05%7C02%7Csthanneeru%40micron.com
>> >>
>> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
>> >>
>> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
>> >>
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
>> >>
>> D%7C3000%7C%7C%7C&sdata=O0%2B6T%2FgU0TicCEYBac%2FAyjOLwAeouh
>> >> D%2BcMI%2BflOsI1M%3D&reserved=0
>> >
>> > Yes, memory_type would be grouping the related memories together as
>> single tier.
>> > We should also have a flexibility to move nodes between tiers, to address
>> the issues.
>> > described in use cases above.
>>
>> We don't pursue absolute flexibility.  We add necessary flexibility
>> only.  Why do you need this kind of flexibility?  Can you provide some
>> use cases where memory_type based "adistance_offset" doesn't work?
>
> - /sys/devices/virtual/memory_type/memory_type/ adistance_offset
> memory_type based "adistance_offset will provide a way to move all nodes of same memory_type (e.g. all cxl nodes)
> to different tier.

We will not put the CXL nodes with different performance metrics in one
memory_type.  If so, do you still need to move one of them?

> Whereas /sys/devices/system/node/node2/memtier_override provide a way migrate a node from one tier to another.
> Considering a case where we would like to move two cxl nodes into two different tiers in future.
> So, I thought it would be good to have flexibility at node level instead of at memory_type.

--
Best Regards,
Huang, Ying

