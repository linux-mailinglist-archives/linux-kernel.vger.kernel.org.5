Return-Path: <linux-kernel+bounces-91742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047B8715E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E7EB231AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D63CF6B;
	Tue,  5 Mar 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa9TzRKE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DF2595;
	Tue,  5 Mar 2024 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620600; cv=none; b=Py1iTyXn0eTIZBRFIn+qsCVM0dSPwjLQ1w0nar44/qASYyq7sG8GBrd9r1fkIiH2XeoZq1mNrfJA4vk9B61eI1VvG6fi7X+4A2+JFmKZXwsmZdrBQicr49OT+uwXRfeMx7RQIgQYxLXAOnADdrf2f6rfMIS5PSn93HGOrXeb3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620600; c=relaxed/simple;
	bh=fsK+f7bh6SaYyPN7/YyJPG+tUPYKxJnt+4ogSrVq56o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lmgHHIzQv1TKvf7CB656STo9d3h4l5gN+/ST+fH0tM8jTihXN5YYavNbVdoxLB+Pq3vdUkTxaS/BpDZRe9FVx4c+XFP0vWGxgS9FBECZcIFLG0rRqCPmrRm/eUp+fvUtDEh2DBHEtIGlVnLEGMHgFJIy8I8hy3IySohrIOpVzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa9TzRKE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709620599; x=1741156599;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=fsK+f7bh6SaYyPN7/YyJPG+tUPYKxJnt+4ogSrVq56o=;
  b=Qa9TzRKEc8ulOgl/EThine6lkMWDgtZ5I4TVw0CZVToljXo2mdvvBPMV
   vnQjop4Cn1Y6kAc/TlXFpLJ7Gw5OVpKLTquAu/WehmD8yRmsTvG9pthMz
   G3zgPm9FPXSleYjUZAK7sDHHj/mt5TNHdBWRrWoLBto7SF8ojLiU52hvJ
   9CpgEOWYA71mp9w7PHaQsjrrp6ah+WwxKdxwLczE4CBv19eQhk+GKg3wa
   RjqEb2022Hqf6EryffGgrVQ0ev/4UJ0wo3yUsngiTESiW/s+/ZfFzUw7F
   ba2HdOEtzUJQcHHzhUCpxmoszTfmkNjU2NjFr0bgHf+wHy2Lg49e5fY93
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4076922"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4076922"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 22:36:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="46795681"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 22:36:31 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
  mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  Alistair Popple <apopple@nvidia.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
  linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
In-Reply-To: <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
	(Ho-Ren Chuang's message of "Mon, 4 Mar 2024 22:22:59 -0800")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
	<87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
Date: Tue, 05 Mar 2024 14:34:36 +0800
Message-ID: <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>>
>> > The memory tiering component in the kernel is functionally useless for
>> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the n=
odes
>> > are lumped together in the DRAM tier.
>> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860=
A@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>>
>> I think that it's unfair to call it "useless".  Yes, it doesn't work if
>> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
>> please be specific about in which cases it doesn't work instead of too
>> general "useless".
>>
>
> Thank you and I didn't mean anything specific. I simply reused phrases
> we discussed
> earlier in the previous patchset. I will change them to the following in =
v2:
> "At boot time, current memory tiering assigns all detected memory nodes
> to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
> such as CXL1.1 type3 memory, being unable to be assigned to the
> correct memory tier,
> leading to the inability to migrate pages between different types of memo=
ry."
>
> Please see if this looks more specific.

I don't think that the description above is accurate.  In fact, there
are 2 ways to enumerate the memory device,

1. Mark it as reserved memory (E820_TYPE_SOFT_RESERVED, etc.) in E820
   table or something similar.

2. Mark it as normal memory (E820_TYPE_RAM) in E820 table or something
   similar

For 1, the memory device (including CXL memory) is onlined via
drivers/dax/kmem.c, so will be put in proper memory tiers.  For 2, the
memory device is indistinguishable with normal DRAM with current
implementation.  And this is what this patch is working on.

Right?

--
Best Regards,
Huang, Ying

>> > This patchset automatically resolves the issues. It delays the initial=
ization
>> > of memory tiers for CPUless NUMA nodes until they obtain HMAT informat=
ion
>> > at boot time, eliminating the need for user intervention.
>> > If no HMAT specified, it falls back to using `default_dram_type`.
>> >
>> > Example usecase:
>> > We have CXL memory on the host, and we create VMs with a new system me=
mory
>> > device backed by host CXL memory. We inject CXL memory performance att=
ributes
>> > through QEMU, and the guest now sees memory nodes with performance att=
ributes
>> > in HMAT. With this change, we enable the guest kernel to construct
>> > the correct memory tiering for the memory nodes.
>> >
>> > Ho-Ren (Jack) Chuang (1):
>> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
>> >     HMAT info
>> >
>> >  drivers/acpi/numa/hmat.c     |  3 ++
>> >  include/linux/memory-tiers.h |  6 +++
>> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>> >  3 files changed, 77 insertions(+), 8 deletions(-)
>>
>> --
>> Best Regards,
>> Huang, Ying

