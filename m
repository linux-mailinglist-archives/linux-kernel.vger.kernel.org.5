Return-Path: <linux-kernel+bounces-3019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF5816631
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1351C21455
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D16AAD;
	Mon, 18 Dec 2023 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWyTJBrB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E763D7;
	Mon, 18 Dec 2023 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702879058; x=1734415058;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EUwgnCLnOCjvSoWerIdZN9qy6Wju/5BfP/1nGT2V6Qc=;
  b=jWyTJBrB83C6Pe1qChtM0vLoXQhWf5y0cDLrZvWZWqxKYNfpCGdIzfF8
   pO2RDFg11HR2FZiY9ARAbGJqSFMN/E/ZlxhRCP137/CcwwEk836tSKr2F
   2ilbjn1kd/WcmKSsFoSMBqOwl9iUvFM2GMBokBdHaVG+m/4eSLftfsJQZ
   llLz1TmXXNUp5sFBik8gFo8UxrH9mdc3EbIQJMxZEa++tFGh0oatdz/I6
   rgL6i1VU6ZgXyab/9f/rOi4vhd0k40aCnF3T4lfK7a274NEEHcWsFcFnc
   MVnkkp2sconZeZ8erR1xR+O8XZ0lfDipgHY6yiBDtrZnA8HxR9T4LGlP/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="481645807"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="481645807"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 21:57:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="17803674"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 21:57:33 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: <sthanneeru.opensrc@micron.com>,  <linux-cxl@vger.kernel.org>,
  <linux-mm@kvack.org>,  <sthanneeru@micron.com>,
  <aneesh.kumar@linux.ibm.com>,  <dan.j.williams@intel.com>,
  <mhocko@suse.com>,  <tj@kernel.org>,  <john@jagalactic.com>,
  <emirakhur@micron.com>,  <vtavarespetr@micron.com>,
  <Ravis.OpenSrc@micron.com>,  <Jonathan.Cameron@huawei.com>,
  <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Wei
 Xu <weixugc@google.com>
Subject: Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <ZXyQIJOim1+tE0Qr@memverge.com> (Gregory Price's message of "Fri,
	15 Dec 2023 12:42:56 -0500")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
Date: Mon, 18 Dec 2023 13:55:34 +0800
Message-ID: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Fri, Dec 15, 2023 at 01:02:59PM +0800, Huang, Ying wrote:
>> <sthanneeru.opensrc@micron.com> writes:
>> 
>> > =============
>> > Version Notes:
>> >
>> > V2 : Changed interface to memtier_override from adistance_offset.
>> > memtier_override was recommended by
>> > 1. John Groves <john@jagalactic.com>
>> > 2. Ravi Shankar <ravis.opensrc@micron.com>
>> > 3. Brice Goglin <Brice.Goglin@inria.fr>
>> 
>> It appears that you ignored my comments for V1 as follows ...
>> 
>> https://lore.kernel.org/lkml/87o7f62vur.fsf@yhuang6-desk2.ccr.corp.intel.com/
>> https://lore.kernel.org/lkml/87jzpt2ft5.fsf@yhuang6-desk2.ccr.corp.intel.com/
>> https://lore.kernel.org/lkml/87a5qp2et0.fsf@yhuang6-desk2.ccr.corp.intel.com/
>> 
>
> Not speaking for the group, just chiming in because i'd discussed it
> with them.
>
> "Memory Type" is a bit nebulous.  Is a Micron Type-3 with performance X
> and an SK Hynix Type-3 with performance Y a "Different type", or are
> they the "Same Type" given that they're both Type 3 backed by some form
> of DDR?  Is socket placement of those devices relevant for determining
> "Type"?  Is whether they are behind a switch relevant for determining
> "Type"? "Type" is frustrating when everything we're talking about
> managing is "Type-3" with difference performance.
>
> A concrete example:
> To the system, a Multi-Headed Single Logical Device (MH-SLD) looks
> exactly the same as an standard SLD.  I may want to have some
> combination of local memory expansion devices on the majority of my
> expansion slots, but reserve 1 slot on each socket for a connection to
> the MH-SLD.   As of right now: There is no good way to differentiate the
> devices in terms of "Type" - and even if you had that, the tiering
> system would still lump them together.
>
> Similarly, an initial run of switches may or may not allow enumeration
> of devices behind it (depends on the configuration), so you may end up
> with a static numa node that "looks like" another SLD - despite it being
> some definition of "GFAM".  Do number of hops matter in determining
> "Type"?

In the original design, the memory devices of same memory type are
managed by the same device driver, linked with system in same way
(including switches), built with same media.  So, the performance is
same too.  And, same as memory tiers, memory types are orthogonal to
sockets.  Do you think the definition itself is clear enough?

I admit "memory type" is a confusing name.  Do you have some better
suggestion?

> So I really don't think "Type" is useful for determining tier placement.
>
> As of right now, the system lumps DRAM nodes as one tier, and pretty
> much everything else as "the other tier". To me, this patch set is an
> initial pass meant to allow user-control over tier composition while
> the internal mechanism is sussed out and the environment develops.

The patchset to identify the performance of memory devices and put them
in proper "memory types" and memory tiers via HMAT has been merged by
v6.7-rc1.

      07a8bdd4120c (memory tiering: add abstract distance calculation algorithms management, 2023-09-26)
      d0376aac59a1 (acpi, hmat: refactor hmat_register_target_initiators(), 2023-09-26)
      3718c02dbd4c (acpi, hmat: calculate abstract distance with HMAT, 2023-09-26)
      6bc2cfdf82d5 (dax, kmem: calculate abstract distance with general interface, 2023-09-26)

> In general, a release valve that lets you redefine tiers is very welcome
> for testing and validation of different setups while the industry evolves.
>
> Just my two cents.

--
Best Regards,
Huang, Ying

