Return-Path: <linux-kernel+bounces-91776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D820871670
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CF028408D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD180052;
	Tue,  5 Mar 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BmiT7d+o"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CD80026
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622653; cv=none; b=QjmD7B5VaSSj1huEg+QYtaqkBQw7t4PUFTLs3HmFrtrd0a4Uhi/2cPr8E08D2ngWtSBC80s7qG0406lgkbNBe5DSTAvmzNiCAYN713RO6FG9LXrEZamGWdkNeV8U8UEVuYw26uaRliP6C49+vBrUwrrsnTIRa0gZ/Z3LZDcaCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622653; c=relaxed/simple;
	bh=2B/WVU0womanPSvPs9cbtf8LsjLR6ZlbTDwOQDONY3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO8TNEeZRaQgXNDw2HGzqu4JtCc8qZvyu3gmARkE1+nkFpgXebKpkG8m5YMiltwX82TntdwG0WD6vR2sOqLtkpV+RG4RdpigPhujwCeUZUNM6dm0capTqrg2OFweDAidQ7T4TMh99iyBAa61zMQkgTrOMe6ANdhuw4VPo+aYodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BmiT7d+o; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso2965300241.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709622650; x=1710227450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y36f7posl7ZMNySYHsTNdos9pSPjUErfBNricXfxXss=;
        b=BmiT7d+ojPGJPlqT5T5cuaDgCVW5RVGjXkE1ZZiDBtYQeB9o7XajMtcWSyBRv1rZOS
         RU/LPsiujGjtpJgvWLBYwAeVQI0r76dbBmURxxkMIeGEMzSynu6lYyKukkikWJ2/AGaj
         pI2CKdPYgB6T4AuRPVSSdf8K2E+WAqHYFOrlBsuUuqJd5kNr1FCzT18OXen+bzPC8+mv
         lV+3ZSFg0cZi8eUyL0mfiyh/A87qTtcae9f0vmjA08PATH73RYjRxa/++vK8o7a6ZpA0
         0G/OhjK9Hkrnv560XrHCl+oTBnfMUJa9/7eWpuh3PyhAklbXr1knUgND/Nrv2gpif2bz
         Mt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622650; x=1710227450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y36f7posl7ZMNySYHsTNdos9pSPjUErfBNricXfxXss=;
        b=uQAwugzIDjmcHmSmQwe6hiHN+GmYnY4G/SOs+6b84SUhil7ktbPpc23uWu6NQXu5xY
         ubfTdTP7kTHhjiZ+XcHTiYlAVvqt9naxkJZTOSo5g+ByuUtt4QceQ4kGntpeCjjOoV7F
         8bqppb7v6j44o74MwXWQvqwyQUDRcbUM+TCYaMmsQPRXkzmVatF+yfo2Ic2HZGz/DjZt
         UIxyOUVEHDVsse7e70BSdinEo0oPGdMN+q5NETrzYUn7o8OIBuNZl4mRxoAUwJpuxDmM
         nZhqDp2LluFGVIWHtY4xYorfoDLGewSJs+xrbsw33yReSMpvVoAAtrRJ+xHa+35DIc7v
         h/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW3pHnvJZvwarj/d4ii/ybMs0GMVUZS4wP1GpNPmeSVnxJrv+eAuV1jKXT9DF2CSSYQabe5J0OfrwTRf67VX4urnyYeti8m6EGRfvsd
X-Gm-Message-State: AOJu0YyEvB5kgRVz9dAzHAok8JcolpgMoX4wlCXDHx+nNZAsnDAfTApx
	rdGomcYQ0QX8R7zM9WgTnuH9LpU4HhiBXDlLJoMDu11hil6kPDpTVBjvtoq4Cp0saFiPGQA2KGU
	gRhF7YXEttmOF5WsFpUfCNBFz5o5F7rEzzn0TmQ==
X-Google-Smtp-Source: AGHT+IE7ZWEURNC7vMd05rp6rJaZD8Db0t4zZRyqV8oa+Hv15rpZuLuTzski8EfVy0sAWkUwbXcMNnQVkDKF9+6ak1A=
X-Received: by 2002:a05:6102:160b:b0:471:c414:83b5 with SMTP id
 cu11-20020a056102160b00b00471c41483b5mr1203643vsb.18.1709622650347; Mon, 04
 Mar 2024 23:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
 <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87h6hl9og3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 23:10:39 -0800
Message-ID: <CAKPbEqpVSsva3P2mEs5LThJZVO12u6nxuDA4KJOEhKNY811-hw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
> >>
> >> > The memory tiering component in the kernel is functionally useless f=
or
> >> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the=
 nodes
> >> > are lumped together in the DRAM tier.
> >> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A8=
60A@PH0PR08MB7955.namprd08.prod.outlook.com/T/
> >>
> >> I think that it's unfair to call it "useless".  Yes, it doesn't work i=
f
> >> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> >> please be specific about in which cases it doesn't work instead of too
> >> general "useless".
> >>
> >
> > Thank you and I didn't mean anything specific. I simply reused phrases
> > we discussed
> > earlier in the previous patchset. I will change them to the following i=
n v2:
> > "At boot time, current memory tiering assigns all detected memory nodes
> > to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
> > such as CXL1.1 type3 memory, being unable to be assigned to the
> > correct memory tier,
> > leading to the inability to migrate pages between different types of me=
mory."
> >
> > Please see if this looks more specific.
>
> I don't think that the description above is accurate.  In fact, there
> are 2 ways to enumerate the memory device,
>
> 1. Mark it as reserved memory (E820_TYPE_SOFT_RESERVED, etc.) in E820
>    table or something similar.
>
> 2. Mark it as normal memory (E820_TYPE_RAM) in E820 table or something
>    similar
>
> For 1, the memory device (including CXL memory) is onlined via
> drivers/dax/kmem.c, so will be put in proper memory tiers.  For 2, the
> memory device is indistinguishable with normal DRAM with current
> implementation.  And this is what this patch is working on.
>
> Right?

Good point! How about this?:
"
When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation=
.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory ti=
er,
leading to the inability to migrate pages between different types of memory=
.
"

--
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

