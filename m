Return-Path: <linux-kernel+bounces-4656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC67818055
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55950284A59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CFC5380;
	Tue, 19 Dec 2023 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ0nxbo1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254CBE55;
	Tue, 19 Dec 2023 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702958356; x=1734494356;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=3s4M1Ke7Zp6dpbGPTolOm9J70ngTk0LFGbPc1ei/amY=;
  b=eQ0nxbo1MXmiT5C6ACUpn4NouqgpK2BG95tsLpSDo8ZiqkFho4gnZ8MO
   +R435YpmLXIbfTBKPOeX4snjc4DTfJsD/DcU2aFM4q/AaF9poU/JNC5yf
   +Kqnn3gsbVNuxOuwev+swv9Hb/WLCxo26WXroIp/8ymKYb51oU4XaJ3iJ
   9cc8jqrahruoBlMGU2ooH0VuCv/2PrmOGh4kQCuYv7MLBdS9uTGUOGzrT
   YXnaw/BvrYh2yLTCHxJFgrlSI2RYxIegRdkBahOJG4mYy8ASVO6PudC6E
   BbbMWnNzP7AUAGlW6CEfEiLUrZwzoNVvldXPkP4akBAEGmX/7FT9A4ABe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="386023776"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="386023776"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="841740575"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="841740575"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:59:11 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Srinivasulu Thanneeru <sthanneeru@micron.com>
Cc: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
  "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>,  "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>,  gregory.price <gregory.price@memverge.com>,
  "mhocko@suse.com" <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Wei Xu <weixugc@google.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <PH0PR08MB79551628EFA3B1B3CB55DFFEA890A@PH0PR08MB7955.namprd08.prod.outlook.com>
	(Srinivasulu Thanneeru's message of "Mon, 18 Dec 2023 08:56:02 +0000")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79551628EFA3B1B3CB55DFFEA890A@PH0PR08MB7955.namprd08.prod.outlook.com>
Date: Tue, 19 Dec 2023 11:57:12 +0800
Message-ID: <87o7emn8tj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Srinivasulu,

Please use a email client that works for kernel patch review.  Your
email is hard to read.  It's hard to identify which part is your text
and which part is my text.  Please refer to,

https://www.kernel.org/doc/html/latest/process/email-clients.html

Or something similar, for example,

https://elinux.org/Mail_client_tips

Srinivasulu Thanneeru <sthanneeru@micron.com> writes:

> Micron Confidential
>
>
>
> Micron Confidential
> ________________________________________
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Friday, December 15, 2023 10:32 AM
> To: Srinivasulu Opensrc
> Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org; Srinivasulu
> Thanneeru; aneesh.kumar@linux.ibm.com; dan.j.williams@intel.com;
> gregory.price; mhocko@suse.com; tj@kernel.org; john@jagalactic.com;
> Eishan Mirakhur; Vinicius Tavares Petrucci; Ravis OpenSrc;
> Jonathan.Cameron@huawei.com; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
>
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless yo=
u recognize the sender and were expecting this message.
>
>
> <sthanneeru.opensrc@micron.com> writes:
>
>> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>
>> The memory tiers feature allows nodes with similar memory types
>> or performance characteristics to be grouped together in a
>> memory tier. However, there is currently no provision for
>> moving a node from one tier to another on demand.
>>
>> This patch series aims to support node migration between tiers
>> on demand by sysadmin/root user using the provided sysfs for
>> node migration.
>>
>> To migrate a node to a tier, the corresponding node=E2=80=99s sysfs
>> memtier_override is written with target tier id.
>>
>> Example: Move node2 to memory tier2 from its default tier(i.e 4)
>>
>> 1. To check current memtier of node2
>> $cat  /sys/devices/system/node/node2/memtier_override
>> memory_tier4
>>
>> 2. To migrate node2 to memory_tier2
>> $echo 2 > /sys/devices/system/node/node2/memtier_override
>> $cat  /sys/devices/system/node/node2/memtier_override
>> memory_tier2
>>
>> Usecases:
>>
>> 1. Useful to move cxl nodes to the right tiers from userspace, when
>>    the hardware fails to assign the tiers correctly based on
>>    memorytypes.
>>
>>    On some platforms we have observed cxl memory being assigned to
>>    the same tier as DDR memory. This is arguably a system firmware
>>    bug, but it is true that tiers represent *ranges* of performance
>>    and we believe it's important for the system operator to have
>>    the ability to override bad firmware or OS decisions about tier
>>    assignment as a fail-safe against potential bad outcomes.
>>
>> 2. Useful if we want interleave weights to be applied on memory tiers
>>    instead of nodes.
>> In a previous thread, Huang Ying <ying.huang@intel.com> thought
>> this feature might be useful to overcome limitations of systems
>> where nodes with different bandwidth characteristics are grouped
>> in a single tier.
>> https://lore.kernel.org/lkml/87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel=
.com/
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Version Notes:
>>
>> V2 : Changed interface to memtier_override from adistance_offset.
>> memtier_override was recommended by
>> 1. John Groves <john@jagalactic.com>
>> 2. Ravi Shankar <ravis.opensrc@micron.com>
>> 3. Brice Goglin <Brice.Goglin@inria.fr>
>
> It appears that you ignored my comments for V1 as follows ...
>
> https://lore.kernel.org/lkml/87o7f62vur.fsf@yhuang6-desk2.ccr.corp.intel.=
com/
>
> Thank you Huang, Ying for pointing to this.
>
> https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live=
%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
>
> In the presentation above, the adistance_offsets are per memtype.
> We believe that adistance_offset per node is more suitable and flexible
> since we can change it per node. If we keep adistance_offset per memtype,
> then we cannot change it for a specific node of a given memtype.

Why do you need to change it for a specific node?  Why do you needn't to
chagne it for all nodes of a given memtype?

> https://lore.kernel.org/lkml/87jzpt2ft5.fsf@yhuang6-desk2.ccr.corp.intel.=
com/
>
> I guess that you need to move all NUMA nodes with same performance
> metrics together?  If so, That is why we previously proposed to place
> the knob in "memory_type"? (From: Huang, Ying )
>
> Yes, memory_type would be group the related memories togather as single t=
ier.
> We should also have a flexibility to move nodes between tiers, to address=
 the issues described in usecases above.
>
> https://lore.kernel.org/lkml/87a5qp2et0.fsf@yhuang6-desk2.ccr.corp.intel.=
com/
>
> This patch provides a way to move a node to the correct tier.
> We observed in test setups where DRAM and CXL are put under the same
> tier (memory_tier4).
> By using this patch, we can move the CXL node away from the DRAM-linked
> tier4 and put it in the desired tier.

Good!  Can you give more details?  So I can resend the patch with your
supporting data.

--
Best Regards,
Huang, Ying

> Regards,
> Srini
>
> --
> Best Regards,
> Huang, Ying
>
>> V1 : Introduced adistance_offset sysfs.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Srinivasulu Thanneeru (2):
>>   base/node: Add sysfs for memtier_override
>>   memory tier: Support node migration between tiers
>>
>>  Documentation/ABI/stable/sysfs-devices-node |  7 ++
>>  drivers/base/node.c                         | 47 ++++++++++++
>>  include/linux/memory-tiers.h                | 11 +++
>>  include/linux/node.h                        | 11 +++
>>  mm/memory-tiers.c                           | 85 ++++++++++++---------
>>  5 files changed, 125 insertions(+), 36 deletions(-)

