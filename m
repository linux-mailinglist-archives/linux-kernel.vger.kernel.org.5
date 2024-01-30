Return-Path: <linux-kernel+bounces-43774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B58418BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81515B214C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055B336AF5;
	Tue, 30 Jan 2024 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1sIyWzT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38636AE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580258; cv=none; b=VvP1f6oukD6q9VA/YxnJk3XWVNUged4els32fMQY/bL8rTG2LHl/IRN31kK4llK2rbPHLlJ/f52lvKN6wGohhKlaQldN5Lu/fOgWaa7MfADdWoTGrgGfjp6DVgzssdeSdPergcy0C5YclUliF9qstKbwqEDLWU1y0j1PFxXtDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580258; c=relaxed/simple;
	bh=ZCDi+CrC2xy3W0uwcFJBQ1sW5HEzmXNfG9w3CzByxBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kqo1RsyblkmY8uEVioe9/IUPtm5nkiospmD4H1g6EpKJ5ef8UTfhcR+TNHxCrCqBebV4WqWgYVeMszivCeLIixeFk9NjD2QBAut5lmT4+LbaeMDrOdb2yAaz5ZzpHAcq0gV4H1ZUAQeyqoY+BAgjA4+2eVXN/n8zhC//v60EZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1sIyWzT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580257; x=1738116257;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ZCDi+CrC2xy3W0uwcFJBQ1sW5HEzmXNfG9w3CzByxBY=;
  b=c1sIyWzTPzywP6xNfuhKMLhyP80BXluznwWP7SLgpsCzDqq5KCzhab/J
   XzsUbFS8UZ4QhSUd9C1Ac2u9uX0dJ/h0u9LkKUE5LydqWmwnW9wMN915O
   tTY5gSfvX8awhZgc2dzE9M4D3q5f1qft0G7vqXoratOyoS/tXr4lopcKZ
   lZz9ZryvW+jBXr1CYLJgdGsvj9+QMTR+H9BaFt9RrWuE8ozpDN7qoJKv3
   t85LL8V9cHEg+hthq07apNkDtcXI7Eb8JD8eVgp202qnPtBKwC85IkYVb
   Z75BMtIkabCae/6oXYPvOgqqJlalkG9g6VvEEvgM5hiLSqbnSfo3aUCdM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3019574"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3019574"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="36337213"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:03:19 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,  LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] mm/swap, shmem: use new swapin helper to skip
 readahead conditionally
In-Reply-To: <CAMgjq7ByEsYCj+YeQPS8g1tdKeJnwBhFyqPHCWufzLSfGJYr2A@mail.gmail.com>
	(Kairui Song's message of "Tue, 30 Jan 2024 08:39:34 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-10-ryncsn@gmail.com>
	<871qar9sb2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7CkKZ9-ogkU52xwQ1YRj+-jwt4fpOLhtKkumVc8ky3OFQ@mail.gmail.com>
	<CAMgjq7ByEsYCj+YeQPS8g1tdKeJnwBhFyqPHCWufzLSfGJYr2A@mail.gmail.com>
Date: Tue, 30 Jan 2024 10:01:22 +0800
Message-ID: <87h6ivinpp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Wed, Jan 10, 2024 at 11:35=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
>>
>> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 10:05=E5=86=99=E9=81=93=EF=BC=9A
>> >
>> > Kairui Song <ryncsn@gmail.com> writes:
>> >
>> > > From: Kairui Song <kasong@tencent.com>
>> > >
>> > > Currently, shmem uses cluster readahead for all swap backends. Clust=
er
>> > > readahead is not a good solution for ramdisk based device (ZRAM) at
> all.
>> > >
>> > > After switching to the new helper, most benchmarks showed a good
> result:
>> > >
>> > > - Single file sequence read:
>> > >   perf stat --repeat 20 dd if=3D/tmpfs/test of=3D/dev/null bs=3D1M
> count=3D8192
>> > >   (/tmpfs/test is a zero filled file, using brd as swap, 4G memcg
> limit)
>> > >   Before: 22.248 +- 0.549
>> > >   After:  22.021 +- 0.684 (-1.1%)
>> > >
>> > > - Random read stress test:
>> > >   fio -name=3Dtmpfs --numjobs=3D16 --directory=3D/tmpfs \
>> > >   --size=3D256m --ioengine=3Dmmap --rw=3Drandread
> --random_distribution=3Drandom \
>> > >   --time_based --ramp_time=3D1m --runtime=3D5m --group_reporting
>> > >   (using brd as swap, 2G memcg limit)
>> > >
>> > >   Before: 1818MiB/s
>> > >   After:  1888MiB/s (+3.85%)
>> > >
>> > > - Zipf biased random read stress test:
>> > >   fio -name=3Dtmpfs --numjobs=3D16 --directory=3D/tmpfs \
>> > >   --size=3D256m --ioengine=3Dmmap --rw=3Drandread
> --random_distribution=3Dzipf:1.2 \
>> > >   --time_based --ramp_time=3D1m --runtime=3D5m --group_reporting
>> > >   (using brd as swap, 2G memcg limit)
>> > >
>> > >   Before: 31.1GiB/s
>> > >   After:  32.3GiB/s (+3.86%)
>> > >
>> > > So cluster readahead doesn't help much even for single sequence read,
>> > > and for random stress test, the performance is better without it.
>> > >
>> > > Considering both memory and swap device will get more fragmented
>> > > slowly, and commonly used ZRAM consumes much more CPU than plain
>> > > ramdisk, false readahead could occur more frequently and waste
>> > > more CPU. Direct SWAP is cheaper, so use the new helper and skip
>> > > read ahead for SWP_SYNCHRONOUS_IO device.
>> >
>> > It's good to take advantage of swap_direct (no readahead).  I also hop=
es
>> > we can take advantage of VMA based swapin if shmem is accessed via mma=
p.
>> > That appears possible.
>>
>> Good idea, that should be doable, will update the series.
>
> Hi Ying,
>
> Turns out it's quite complex to do VMA bases swapin readhead for shmem: V=
MA
> address / Page Tables doesn't contain swapin entry for shmem. For anon pa=
ge
> simply read nearby page table is easy and good enough, but for shmem, it's
> stored in the inode mapping so the readahead needs to walk the inode
> mapping instead. That's doable but requires more work to make it actually
> usable. I've sent V3 without this feature, worth another series for this
> readahead extension.

Got it.  Thanks for looking at this.

--
Best Regards,
Huang, Ying

