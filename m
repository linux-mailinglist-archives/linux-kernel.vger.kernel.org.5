Return-Path: <linux-kernel+bounces-21738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2130829395
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DBB1F26D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA632C71;
	Wed, 10 Jan 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grS0AZGh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2186DF6C;
	Wed, 10 Jan 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704866928; x=1736402928;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xCUpG7MPuTydGqWkJiwHDdaFqNDHXSJYG5vfi+6flw4=;
  b=grS0AZGhNq8soDcw6nbog9S8KeGUMle8P2BED5TJf+QI7Bbv4pwyINI+
   AhFVbeljHYndWyjl2eZYZMbEHvn55vyagcRpzfcOxLmLdpxmoBRa/Yzxk
   PIjaIdnXJRm+/EJC7iRPQW8e1BtE55jqP8vQOp5lxEHQe21YhmRYq+HU9
   p401qReKBNpTcWfe1MvRheh0Yn4JCcNNoIaY3y0eHzAwVUkF1xRkzUgln
   lHPJVyAQWCRh3XWT8Py2Nwfwawwx8Q7SO7uP3DkXq6sWAxfoRM0OZd4jU
   ZoAOhHXI35eHwkTQjAsXGxKoX9IVTYB4SkXTGJ3qp904K18/c3HRt2rOd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11765306"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11765306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 22:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852435366"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="852435366"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 22:08:42 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Gregory Price <gregory.price@memverge.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  Srinivasulu Opensrc
 <sthanneeru.opensrc@micron.com>,  "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>,  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,  "mhocko@suse.com"
 <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,
  "john@jagalactic.com" <john@jagalactic.com>,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  "Johannes
 Weiner" <hannes@cmpxchg.org>,  Wei Xu <weixugc@google.com>,  Hao Xiang
 <hao.xiang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>
Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <20240109155049.00003f13@Huawei.com> (Jonathan Cameron's message
	of "Tue, 9 Jan 2024 15:50:49 +0000")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZZwrIoP9+ey7rp3C@memverge.com>
	<87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240109155049.00003f13@Huawei.com>
Date: Wed, 10 Jan 2024 14:06:44 +0800
Message-ID: <874jfl90y3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 09 Jan 2024 11:41:11 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:  
>> >> >
>> >> > From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
>> >> > abstract_distance_offset: override by users to deal with firmware issue.
>> >> >
>> >> > say firmware can configure the cxl node into wrong tiers, similar to
>> >> > that it may also configure all cxl nodes into single memtype, hence
>> >> > all these nodes can fall into a single wrong tier.
>> >> > In this case, per node adistance_offset would be good to have ?  
>> >> 
>> >> I think that it's better to fix the error firmware if possible.  And
>> >> these are only theoretical, not practical issues.  Do you have some
>> >> practical issues?
>> >> 
>> >> I understand that users may want to move nodes between memory tiers for
>> >> different policy choices.  For that, memory_type based adistance_offset
>> >> should be good.
>> >>   
>> >
>> > There's actually an affirmative case to change memory tiering to allow
>> > either movement of nodes between tiers, or at least base placement on
>> > HMAT information. Preferably, membership would be changable to allow
>> > hotplug/DCD to be managed (there's no guarantee that the memory passed
>> > through will always be what HMAT says on initial boot).  
>> 
>> IIUC, from Jonathan Cameron as below, the performance of memory
>> shouldn't change even for DCD devices.
>> 
>> https://lore.kernel.org/linux-mm/20231103141636.000007e4@Huawei.com/
>> 
>> It's possible to change the performance of a NUMA node changed, if we
>> hot-remove a memory device, then hot-add another different memory
>> device.  It's hoped that the CDAT changes too.
>
> Not supported, but ACPI has _HMA methods to in theory allow changing
> HMAT values based on firmware notifications...  So we 'could' make
> it work for HMAT based description.
>
> Ultimately my current thinking is we'll end up emulating CXL type3
> devices (hiding topology complexity) and you can update CDAT but
> IIRC that is only meant to be for degraded situations - so if you
> want multiple performance regions, CDAT should describe them form the start.

Thank you very much for input!  So, to support degraded performance, we
will need to move a NUMA node between memory tiers.  And, per my
understanding, we should do that in kernel.

>> 
>> So, all in all, HMAT + CDAT can help us to put the memory device in
>> appropriate memory tiers.  Now, we have HMAT support in upstream.  We
>> will working on CDAT support.
>> 

--
Best Regards,
Huang, Ying

