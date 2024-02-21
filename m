Return-Path: <linux-kernel+bounces-74150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB385D079
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACEB1C23CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC6E3A1AC;
	Wed, 21 Feb 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+0XEG20"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A554A1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496825; cv=none; b=eQS+PQCrkLdy2Cl8V0YHC/ZiFme2SDZSLn0vmALz4OSnxmE45DGfPENL5o14pZ+A7ifnhqT+YN1I54CGLcVRM/npoTf882DsHxNvEvaj4i0tiU/0zZWzFTAZVNiC9XordAvfw5UhB9JoqGH3IIZwQfSgqQ0Njqn9FaWYisSEAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496825; c=relaxed/simple;
	bh=/V5T+YQftfD2tRWQGhzHzmXn6qVrJBWkMhBmJM5xGrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnLXwx7h3m0/dVxxxRV/kzbRanO4XAwUunRlkUIIvN+UahtzCvpb8DdyaiHdrx+n50wQrbwcRyM8aTl3zmpmsIx2Xn2yT1l2FP7RLifsgC3cwg07ylCm7fzNWxnwdMC+VqPdI4G5iW+L6NktnWCJq/a+KZenYAt+ePWbFgwVgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+0XEG20; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b5568so82783051fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496821; x=1709101621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4SCakJf3fMGKD4Pc9DX3Fmx60D6/XewjZTTvU4lsUQ=;
        b=X+0XEG20oH3gTiWdjKMlBQDZMej0xMp6ft+S9UPrdyFHlRb92QjNaK2SWPfQcJwZs0
         ShaS0fCSywiH6R0YdhUiqAdUEc/cGqTCZtdjtDFMgNtLA2Ju/xeZdan+/XdjHdd4eghr
         AZXN5paPr/VDy4emRkEO9Ey1ByIIMWrrJqsKcn2x67feGW/1HHB8BfpaNbiXdr3/M63T
         jLWnBg50AOOkFnZ+uloZl77fh3wByQ9tlKPYgj9+CrJXTTLs1ZQAu19tciLO61gW7X1O
         HKqVHlTzbGjoLmo0VvU4y5U/MCu6ccQj5HLOBCA/7pOIp70z3YFAYK/7fUds/6gaDLF9
         WnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496821; x=1709101621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4SCakJf3fMGKD4Pc9DX3Fmx60D6/XewjZTTvU4lsUQ=;
        b=Mcn+D6EMxG+807MEQR8PJeLm0elKIojphKDs4TOEI3IW4r4qlOdp6DsvHUNZ2wUkDZ
         z7wj01anEyE0L3lO1sqhYAM3HJsalUIMtMqiKAIf9yPhE3H1oor/YKbNbehjSmIAYDIz
         uwTB866GOwk2iKpmzPj1AtHV/SKTYkXBSgvFyL9OVB2mvVdLI1P+g6dNA0f8b/HJOgqc
         cHIyIsFqsprOLQmWLE2dbrSvTDEu+qdyOHGjotKbCtf9CkOf8NWuY1k6szctpGvIxnVn
         np3M5ElFlwljFltr8FbR2NMQM5/brV4Mj2W34URea9r/8vrIDRcnyGpUEL4RnBxzWJaC
         sztQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbvrRjhGHY/mEiQUihaS/QlArj1zTF78rHeic4dzp5xV2gWsXAETejlaMDNvmUdBukfyG2tcJYqTp3/naOvvy5kw5lJ4HGv58RKp1
X-Gm-Message-State: AOJu0YwzZI5FNyxo86syOciAPyz+OqSnDeAN2/1hf17f5vTQK+h1GqWG
	HW0KtyduiIuXHFCuheN0KcuxpXBOQyKxnfcwH37XCGS3sbGZg0c0xLRThHMnFTBE6Tf0qQKcNpw
	j3KJKdbFJuCJDjwHTKfkGzYvVQ08DJwZHMC3jKQ==
X-Google-Smtp-Source: AGHT+IGAk9uU00zF5FiQ3NZBmkalTm/vo9IQ4bsTZa6Kjs7HQJX88+nLTvnpaddJgnUhtZkssQt6m05of8wqFGM+sVc=
X-Received: by 2002:a2e:988a:0:b0:2d2:31f1:1a2e with SMTP id
 b10-20020a2e988a000000b002d231f11a2emr5776674ljj.12.1708496821260; Tue, 20
 Feb 2024 22:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com> <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
 <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com> <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
 <55a4b5e5-e0ad-4aa4-a29b-5fff4ef69063@linux.intel.com>
In-Reply-To: <55a4b5e5-e0ad-4aa4-a29b-5fff4ef69063@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 14:26:49 +0800
Message-ID: <CABQgh9FD2fup3awxNyu3LpQcB6f-HF5eb1B4fhVHxLJ0O76oVQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Zhang, Tina" <tina.zhang@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Hao Fang <fanghao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 11:52, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2024/2/21 10:45, Zhangfei Gao wrote:
> > On Wed, 21 Feb 2024 at 10:06, Baolu Lu<baolu.lu@linux.intel.com>
> > wrote:
> >> On 2024/2/21 9:28, Zhangfei Gao wrote:
> >>> On Wed, 21 Feb 2024 at 07:58, Zhang, Tina<tina.zhang@intel.com>
> >>> wrote:
> >>>
> >>>>>> struct iommu_sva *iommu_sva_bind_device(struct device
> >>>>>> *dev, struct mm_struct *mm)  { +       struct
> >>>>>> iommu_mm_data *iommu_mm; struct iommu_domain *domain;
> >>>>>> struct iommu_sva *handle; int ret;
> >>>>>>
> >>>>>> +       mutex_lock(&iommu_sva_lock); + /* Allocate
> >>>>>> mm->pasid if necessary. */ -       ret =
> >>>>>> iommu_sva_alloc_pasid(mm, dev); -       if (ret) - return
> >>>>>> ERR_PTR(ret); +       iommu_mm = iommu_alloc_mm_data(mm,
> >>>>>> dev); +       if (IS_ERR(iommu_mm)) { +               ret =
> >>>>>> PTR_ERR(iommu_mm); + goto out_unlock; +       }
> >>>>>>
> >>>>>> handle = kzalloc(sizeof(*handle), GFP_KERNEL); -       if
> >>>>>> (!handle) -               return ERR_PTR(-ENOMEM); - -
> >>>>>> mutex_lock(&iommu_sva_lock); -       /* Search for an
> >>>>>> existing domain. */ -       domain =
> >>>>>> iommu_get_domain_for_dev_pasid(dev, mm->pasid, -
> >>>>>> IOMMU_DOMAIN_SVA); -       if (IS_ERR(domain)) { - ret =
> >>>>>> PTR_ERR(domain); +       if (!handle) { + ret = -ENOMEM;
> >>>>>> goto out_unlock; }
> >>>>>>
> >>>>>> -       if (domain) { -               domain->users++; -
> >>>>>> goto out;
> >>>>> Our multi bind test case broke since 6.8-rc1. The test case
> >>>>> can use same domain & pasid, return different handle, 6.7
> >>>>> simply  domain->users ++ and return.
> >>>>>
> >>>>>> +       /* Search for an existing domain. */ +
> >>>>>> list_for_each_entry(domain, &mm->iommu_mm->sva_domains,
> >>>>>> next)
> >>>>> {
> >>>>>> +               ret = iommu_attach_device_pasid(domain,
> >>>>>> dev, + iommu_mm->pasid);
> >>>>> Now iommu_attach_device_pasid return BUSY since the same
> >>>>> pasid. And then iommu_sva_bind_device attach ret=-16
> >>>> Sounds like the test case tries to bind a device to a same mm
> >>>> multiple times without unbinding the device and the
> >>>> expectation is that it can always return a valid handle to pass
> >>>> the test. Right?
> >>> Yes
> >>>
> >>> The device can bind to the same mm multi-times and return
> >>> different handle, Since the refcount, no need to unbind and bind
> >>> sequently, The unbind can happen later with the handle.
> >> Is there any real use case to bind an mm to the pasid of a device
> >> multiple times? If there are cases, is it better to handle this in
> >> the uacce driver?
> > Yes, it is required for multi-thread, the device can provide
> > multi-queue to speed up.
> >
> >> From iommu core's perspective, it doesn't make sense to attach the
> >> same domain to the same device (or pasid) multiple times.
> > But is it the refcount domain->user++ used for? Is there any reason
> > not doing this.
>
> I was just thinking about whether to do this in the iommu core, or in
> the upper layers, like uacce or iommufd. It seems that there is no need
> to attach a domain to a device or pasid again if it has already been
> attached.

It would be more complicated since the return handle can be used to
distinguish different queues of the device.

I think domain->user should handle this case as before.

Anyway, I have sent a patch to get more feedback.

Thanks

