Return-Path: <linux-kernel+bounces-91819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA109871716
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EC3B21B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500B7E771;
	Tue,  5 Mar 2024 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zu/T7wl+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060D7E103;
	Tue,  5 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624353; cv=none; b=EaX59gIRwsoN1AXbvFHZL4kqbcTOwdgkE7h1Zoy3F/6brC4PuUtVCB5ImaUre00SkwafesBOJA0HCfXB5bkm52nMfJaNIBRBk1qU8TUcsPIC7XQGQDZAQjQPWzkFwFW5CkgcYmlGZSYPzx+V95gtqEOBgU4Jg2EvXQ+s/xAyEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624353; c=relaxed/simple;
	bh=A28suRbme1QZpr/dRcM4LmjGdNPiTUN8DUTSDscbeIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iw6PBNRGVIbWYE/fFfwGJ878H+Fb6QqC+EImtUPrCXvp+8oJUNJQg6DeWQD4u/liEUFKD9XXmNHG32JLl3fBIsdTbEwj9rf16/zv6nnUEeDvWbE9bmtxdze4o7sJxh5ghbL/LalNPY3WBm+QLqEh4h03rY08EdndLRUYmtnYg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zu/T7wl+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709624351; x=1741160351;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=A28suRbme1QZpr/dRcM4LmjGdNPiTUN8DUTSDscbeIQ=;
  b=Zu/T7wl+oHr0nCwDeA6lP32g2ShtvLaUai8M6K6dykhTCGe/Pys1tvpe
   BwY2Xtlvt1S24gRYTkepiD5vXsKMkX107YUafGtt8RVO+A3w8yCpEJ2rW
   Q8L9Q4L1osZ/JXsqo/+jtMr47uczchfrd8cHz4fYuOwFu3bzwW1Sc5LdX
   QH6fa3eeQtXOX0KWcimhwToy4Mu3VSCgKaEzXmsWOIB9wxw/wLZo17/af
   qNbgfjzZsS0a5h+alKC+S3PgHNC1ngHzQeN6UpheGmH+JwXFtw3oBCf1m
   V1Brc9uFciVbh1HUBI8VQiPedmzBR5SNHJFCSAtGIodw4h/P6Nr3iI8Vm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4742114"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4742114"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9185248"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:39:05 -0800
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
In-Reply-To: <CAKPbEqpVSsva3P2mEs5LThJZVO12u6nxuDA4KJOEhKNY811-hw@mail.gmail.com>
	(Ho-Ren Chuang's message of "Mon, 4 Mar 2024 23:10:39 -0800")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
	<87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
	<87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAKPbEqpVSsva3P2mEs5LThJZVO12u6nxuDA4KJOEhKNY811-hw@mail.gmail.com>
Date: Tue, 05 Mar 2024 15:37:10 +0800
Message-ID: <87zfvd86zd.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon, Mar 4, 2024 at 10:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>>
>> > On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >>
>> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>> >>
>> >> > The memory tiering component in the kernel is functionally useless =
for
>> >> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because th=
e nodes
>> >> > are lumped together in the DRAM tier.
>> >> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A=
860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>> >>
>> >> I think that it's unfair to call it "useless".  Yes, it doesn't work =
if
>> >> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
>> >> please be specific about in which cases it doesn't work instead of too
>> >> general "useless".
>> >>
>> >
>> > Thank you and I didn't mean anything specific. I simply reused phrases
>> > we discussed
>> > earlier in the previous patchset. I will change them to the following =
in v2:
>> > "At boot time, current memory tiering assigns all detected memory nodes
>> > to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
>> > such as CXL1.1 type3 memory, being unable to be assigned to the
>> > correct memory tier,
>> > leading to the inability to migrate pages between different types of m=
emory."
>> >
>> > Please see if this looks more specific.
>>
>> I don't think that the description above is accurate.  In fact, there
>> are 2 ways to enumerate the memory device,
>>
>> 1. Mark it as reserved memory (E820_TYPE_SOFT_RESERVED, etc.) in E820
>>    table or something similar.
>>
>> 2. Mark it as normal memory (E820_TYPE_RAM) in E820 table or something
>>    similar
>>
>> For 1, the memory device (including CXL memory) is onlined via
>> drivers/dax/kmem.c, so will be put in proper memory tiers.  For 2, the
>> memory device is indistinguishable with normal DRAM with current
>> implementation.  And this is what this patch is working on.
>>
>> Right?
>
> Good point! How about this?:
> "
> When a memory device, such as CXL1.1 type3 memory, is emulated as
> normal memory (E820_TYPE_RAM), the memory device is indistinguishable
> from normal DRAM in terms of memory tiering with the current implementati=
on.
> The current memory tiering assigns all detected normal memory nodes
> to the same DRAM tier. This results in normal memory devices with
> different attributions being unable to be assigned to the correct memory =
tier,
> leading to the inability to migrate pages between different types of memo=
ry.
> "

Looks good me!  Thanks!

--
Best Regards,
Huang, Ying

