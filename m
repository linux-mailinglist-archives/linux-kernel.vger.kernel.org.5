Return-Path: <linux-kernel+bounces-91734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF158715CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9264628397F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C27C0A1;
	Tue,  5 Mar 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LE8ERebD"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456F6167A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619793; cv=none; b=Ld33xLGLaX6L6o90f8luEOBBj09YSbB8ahW5/fQkonSiTzbB+1pXFWPrE7AaA6t9d/13PPB6IjLzxKulONeKeZHGarhSnCCGsNSmJX4QLi1b5KuBOLa/RJNJcj7Rh/INJ3AERSgquHnhg5Y5h4kYYqy0IDO0qCTbWT6a+AY1FYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619793; c=relaxed/simple;
	bh=oSQv4NUxnf7rEIn+bi0UJt8ayyHupEoJoCDqI6CLoMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCfq5x9BN3y5/dMj/enHXueWTSOyruYYsxkmLl+LX6Z0YwcN+busxR1/p6pJIuk08KhRTZpOEuIwjfps76wcrg8eeveAdbk6nadegVUWu8iqONkGz4Sik+6W6obDplG00qQzavHoJaXIk3/XTvLP+oSJ5jiUM+0eO8w2Z/tz2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LE8ERebD; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d3634a8015so122749e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709619790; x=1710224590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
        b=LE8ERebDii+cQmF5RG+dX0zlNm4JZ9MLewpjopaim/ryWpHJebOB9+ajkT5InRWjOj
         eI0Jfob4gzRx2w/do+JxUoZuhyNGl6onmSwU0Fdp6f8IeepPtM5e90PJSpnM3EMcjGO7
         z16WhKK3Tdg7VTYKfg6Cjf2iFpUXeIJNSWOQ8xqNprb+EP9xkSPKPFBqsz00ZBbNPxe4
         Mc08wgnPAZ2u+UM1aKYHTbAOOTBFBb1Tz6QoaRERMxLSfBZeyegh6FOlbmXUOlgaxHwJ
         xwIhWX81fBDRaONbuib7MOvyyDD1INms0iXN/2ixNLztNxw4yDaS/8yLa/8FrdwIEqAx
         mbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709619790; x=1710224590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
        b=B5omUO2Ueqj5D0R4W5ZzmjGR0gPIVmzt1XN3oi4elTsIS55ydeO+yXBQdjtDnEJdeC
         37gV+BVOGWdDwbC/17TD4cIurkuu0iIX6n9sZiJydSHSKRbVxv3gsCG13VuOUUnLKTam
         ixFd8XV58JAjYX+VDK7dfvfsgFZV3+pfBJFTj3aJA5BN+3Nw13KFeOhkNffT4VotESEl
         MqHDS+gK/5DnIWZeO4Xexr8hL8AsEO3AW259O5HzdySetj0HvG6Hn0byMHKQHW0cW0u1
         KpdWZ5nXI0zHZYh8ObiEK5VXrD01aps2nWLdNeBmIcXSt7bzNdOM4e+tasn9XUtpBBSa
         p/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUN7DNexYnsG+0Dp9Tt3p0HVd2g+IEZSwy2JoxKQtMRfOwbhEUB38oYgQJoQ6VR8VdEmy3qgwCP4FMQx3WeaI1QZInjFXymmyLITHSe
X-Gm-Message-State: AOJu0YyEHazwgCq2z+QL5CfnkoOlCOImSWXcQgnUxlCi9tRSlGoOZqGa
	Q+NtFuR0NGAurxTOI/nAwsmt/a8Qzk/wk0EVL+WoQEmZC3OGZpapUeuK+b2wmH6zt4N1hx4ORcQ
	UqDA+zH8z9ssb4n0r+SvDLNGTnMlUZnZ0EthJFw==
X-Google-Smtp-Source: AGHT+IF8wFchH2Tpcwl+m9+vC++9MiGH8pjEs4cet64MI10UrFTvnJG9+E2iM+RbR2/QpLJ5rn/dajElMcAyZ2RW5JY=
X-Received: by 2002:a05:6122:da7:b0:4ca:615e:1b61 with SMTP id
 bc39-20020a0561220da700b004ca615e1b61mr914463vkb.10.1709619790595; Mon, 04
 Mar 2024 22:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com> <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 22:22:59 -0800
Message-ID: <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
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

On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > The memory tiering component in the kernel is functionally useless for
> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the no=
des
> > are lumped together in the DRAM tier.
> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A=
@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>
> I think that it's unfair to call it "useless".  Yes, it doesn't work if
> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> please be specific about in which cases it doesn't work instead of too
> general "useless".
>

Thank you and I didn't mean anything specific. I simply reused phrases
we discussed
earlier in the previous patchset. I will change them to the following in v2=
:
"At boot time, current memory tiering assigns all detected memory nodes
to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
such as CXL1.1 type3 memory, being unable to be assigned to the
correct memory tier,
leading to the inability to migrate pages between different types of memory=
"

Please see if this looks more specific.

> > This patchset automatically resolves the issues. It delays the initiali=
zation
> > of memory tiers for CPUless NUMA nodes until they obtain HMAT informati=
on
> > at boot time, eliminating the need for user intervention.
> > If no HMAT specified, it falls back to using `default_dram_type`.
> >
> > Example usecase:
> > We have CXL memory on the host, and we create VMs with a new system mem=
ory
> > device backed by host CXL memory. We inject CXL memory performance attr=
ibutes
> > through QEMU, and the guest now sees memory nodes with performance attr=
ibutes
> > in HMAT. With this change, we enable the guest kernel to construct
> > the correct memory tiering for the memory nodes.
> >
> > Ho-Ren (Jack) Chuang (1):
> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
> >     HMAT info
> >
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

--=20
---
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

