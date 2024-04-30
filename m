Return-Path: <linux-kernel+bounces-163188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6598B66F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCB28241F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAB91C33;
	Tue, 30 Apr 2024 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugJOHsXo"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2C6AD7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437693; cv=none; b=I/zsRIZw+0S/uM0uOeCZ2t4UBSv0QWaeO46UF8Y2Fs/8eBwcANyBu+eQDeXpArpNwOJlFDuZPC+gV34peWjjZYa0qHY/8s2JXf2ojK5p9vQHcEQLgrrNZVUqeXfs0Ro2BmyDMjS6dg9ZoZ9/kTZklEEFXw/MQ3iLCc7fpqKGDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437693; c=relaxed/simple;
	bh=pk2Cj2RSwpAkddbu5ayAVxm8bKVUiyDImLMqV4vDwjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukGBq7kNNm8/4bAWoxslYDn5Tkl8QTlo2ltOg0igQV1M9nrhLrt6rB6Ni4foQx9dh5C4ECQHoJwv1PxEaTHOe4xhYfGIDzagvMpOIw4SGsJ8pEsGDUULm7IWaQBDerlbK7b5nU5WZc0I/M5xQ5XjfgSP89IkPduORT7/PPhVWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugJOHsXo; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3900462276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714437691; x=1715042491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ewGjGVlVj/i6nUR8WSz8shyu8O8i8b1LnxiquSQu0Bc=;
        b=ugJOHsXoMJR6TutipWWdvr8l2eJVlQtrvgYxaP0G6pR1Fvc6eOObAoWxgfSWjsFjl3
         n3/LuXNERxpHXpGQtk7K/oTWF63gFePQHv9GQ7yb4VkNXwkJ9S3ymJxIKiU2tWDUIBYe
         oSBRu/CdcWig8IvrCIrDI/xsKJs9eJJD9fojB5u6+ORQj9tjXvBn55ujm/5o3paSKr3f
         ODVrOOf0eMoCJwmeG8RqwCgjfAICIjX7pGHpZByzxVuJszJ6bTPW3lVZ4+yOrQwF2jVj
         eiz7iXdbKP+iFaOGRhQ6tppkWB6E7ekWEEABnKK1kHu+lTpLwnWI8oGxRYWyDM5AJbWO
         H/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714437691; x=1715042491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewGjGVlVj/i6nUR8WSz8shyu8O8i8b1LnxiquSQu0Bc=;
        b=HF6eXreR2amIaVpIzaMU+62T6hIOOX8TsW/SBxsIDgLuAxodPIh1GTQdE6KrrIx9jO
         bFZVGisNn/HBVeeOxG+rEbacj4GK45Yaex4VnRxuUomM+QoJ7ChcosKkbeaHBxHzQinI
         F6w2HZRgXMUw6UnpVMA7o/0DZ8zkj9obpuYp8ZvB95P08EjDP7ncIVI9HOK3VJd56Yo6
         oQlqPeoskDJJhMpeVKJQ+Q6DFaCHFgVz0sQULMtriFVcoQyI2CDbCwbEWXcBoO2D+GOx
         oProtbsng1A0g+S0Px4aONpZpT6w4nZfH3GHV63qhygd+iRGRMkwWcVpAay90/Y7oFCb
         tkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs3aPpQDUV7fN4/v4EIPBRl6SG02ZHPtWpXJ8UGjnjMYvj2+yNmOpvLSzpxfNhM5UU6H93E/lhE7uDBRcJ0/oPMw7KbNaXuAszUkM0
X-Gm-Message-State: AOJu0YwvkIKdumYJgse1UVn7cTVz2CrK1aFfesA9RdUeNLFtarq7YarO
	xOqPn3DmUAsgY7K0hehZ1r3A6ZKF8YTi1b4rNLQvTtWd58QO4vIXFf+dPYFdrk/Eq0udgBeJRcI
	1o3m7In6Ls2ALIT4pobeoRkFCQoCm7zxcvZOpUw==
X-Google-Smtp-Source: AGHT+IEwXWe4Z8CC1z4BRoDOt3xCr6XQiUXw2opzMRSv7RCMNxwJyE8N8t/S4Ivrg5f5f0R7smdIfn5jUi86Jmgafv8=
X-Received: by 2002:a25:ab4b:0:b0:de5:56c4:acc3 with SMTP id
 u69-20020a25ab4b000000b00de556c4acc3mr914713ybi.16.1714437690982; Mon, 29 Apr
 2024 17:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713523152.git.robin.murphy@arm.com> <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
 <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru> <2662a5ba-3115-4fe5-9cec-bff71f703a82@arm.com>
In-Reply-To: <2662a5ba-3115-4fe5-9cec-bff71f703a82@arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 03:41:19 +0300
Message-ID: <CAA8EJprxLvYEP8+ggk8fw--kHaK+_QoYan4st2wWpPicHa6_+w@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 01:26, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2024-04-29 5:31 pm, Dmitry Baryshkov wrote:
> > On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
> >> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> >> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> >> which means there should be no harm in achieving the same order of
> >> operations by running it off the back of iommu_probe_device() itself.
> >> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> >> letting us pull it all into the main flow properly. As a bonus this lets
> >> us fold in and de-scope the PCI workaround setup as well.
> >>
> >> At this point we can also then pull the call up inside the group mutex,
> >> and avoid having to think about whether iommu_group_store_type() could
> >> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> >> *before* iommu_device_use_default_domain() claims it... Furthermore we
> >> replace one .probe_finalize call completely, since the only remaining
> >> implementations are now one which only needs to run once for the initial
> >> boot-time probe, and two which themselves render that path unreachable.
> >>
> >> This leaves us a big step closer to realistically being able to unpick
> >> the variety of different things that iommu_setup_dma_ops() has been
> >> muddling together, and further streamline iommu-dma into core API flows
> >> in future.
> >>
> >> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
> >> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
> >>      is covered as well, with bonus side-effects as above.
> >> v3: *Really* do that, remembering the other two probe_finalize sites too.
> >> ---
> >>   arch/arm64/mm/dma-mapping.c  |  2 --
> >>   drivers/iommu/amd/iommu.c    |  8 --------
> >>   drivers/iommu/dma-iommu.c    | 18 ++++++------------
> >>   drivers/iommu/dma-iommu.h    | 14 ++++++--------
> >>   drivers/iommu/intel/iommu.c  |  7 -------
> >>   drivers/iommu/iommu.c        | 20 +++++++-------------
> >>   drivers/iommu/s390-iommu.c   |  6 ------
> >>   drivers/iommu/virtio-iommu.c | 10 ----------
> >>   include/linux/iommu.h        |  7 -------
> >>   9 files changed, 19 insertions(+), 73 deletions(-)
> >
> > This patch breaks UFS on Qualcomm SC8180X Primus platform:
> >
> >
> > [    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
>
> Hmm, a context fault implies that the device did get attached to a DMA
> domain, thus has successfully been through __iommu_probe_device(), yet
> somehow still didn't get the right DMA ops (since that "IOVA" looks more
> like a PA to me). Do you see the "Adding to IOMMU group..." message for
> this device, and/or any other relevant messages or errors before this
> point?

No, nothing relevant.

[    8.372395] ufshcd-qcom 1d84000.ufshc: Adding to iommu group 6

(please ignore the timestamp, it comes before ufshc being probed).

> I'm guessing there's a fair chance probe deferral might be
> involved as well. I'd like to understand what path(s) this ends up
> taking through __iommu_probe_device() and of_dma_configure(), or at
> least the number and order of probe attempts between the UFS and SMMU
> drivers.

__iommu_probe_device() gets called twice and returns early because ops is NULL.

Then finally of_dma_configure_id() is called. The following branches are taken:

np == dev->of_node
of_dma_get_range() returned 0
bus_dma_limit and dma_range_map are set
__iommu_probe_device() is called, using the `!group->default_domain &&
!group_lis` case, then group->default_domain() is not NULL,
In the end, iommu_setup_dma_ops() is called.

Then the ufshc probe defers (most likely the PHY is not present or
some other device is not there yet).

On the next (succeeding) try, of_dma_configure_id() is called again.
The call trace is more or less the same, except that
__iommu_probe_device() is not called

> I'll stare at the code in the morning and see if I can spot any
> overlooked ways in which what I think might be happening could happen,
> but any more info to help narrow it down would be much appreciated.
>
> Thanks,
> Robin.
>
> > [    3.846880] ufshcd-qcom 1d84000.ufshc: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
> > [    3.846929] host_regs: 00000000: 1587031f 00000000 00000300 00000000
> > [    3.846935] host_regs: 00000010: 01000000 00010217 00000000 00000000
> > [    3.846941] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
> > [    3.846946] host_regs: 00000030: 0000000f 00000001 00000000 00000000
> > [    3.846951] host_regs: 00000040: 00000000 00000000 00000000 00000000
> > [    3.846956] host_regs: 00000050: 032db000 00000001 00000000 00000000
> > [    3.846962] host_regs: 00000060: 00000000 80000000 00000000 00000000
> > [    3.846967] host_regs: 00000070: 032dd000 00000001 00000000 00000000
> > [    3.846972] host_regs: 00000080: 00000000 00000000 00000000 00000000
> > [    3.846977] host_regs: 00000090: 00000016 00000000 00000000 0000000c
> > [    3.847074] ufshcd-qcom 1d84000.ufshc: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
> > [    4.406550] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11
> > [    4.417953] ufshcd-qcom 1d84000.ufshc: ufshcd_async_scan failed: -11
> >



-- 
With best wishes
Dmitry

