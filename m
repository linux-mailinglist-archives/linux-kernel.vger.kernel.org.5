Return-Path: <linux-kernel+bounces-73916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C385CD94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA86B1F235B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5F46BF;
	Wed, 21 Feb 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1m1hVpO"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFE6FAE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480430; cv=none; b=p+lFrnt1fCoiMWQ5SCFqufE9ngshqDJSPm43RZ7s3aXj1t3VRd+SGTtiAK+i++rK9ptKfESfIUKtsxb196tkCpvZRqDVQ6DFkITAvcsGKPxIUkpPbfSz1tF5VBaetWc3bt6vN/A/zRndbo9ZUJlnmuwyOWbwMxb6MCvi5WMs02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480430; c=relaxed/simple;
	bh=X7DS4AxqZmwIGaiOTbhL7uSmpzpJXN4zPisSmEhXWzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ylo8lfogLL4ptGzw+j4LzQpp/Je3yuPQXI/fTVj3WtlhoL2p3mNlmGjAGJibhwioYhVvGYukorxPAzaLF1fmdRgp16snHyFz6raOZfVRj6sFdm9xAEBqu9SJJtOwAC53mYpuu9HUcGuKvo0vnbh1iy76cdk751XIUg+OTPhQ2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1m1hVpO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso1074201fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708480426; x=1709085226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xNv57wTrROpvBu7D7eRkAMBX/0S6ivveyoxRqXbvKXQ=;
        b=p1m1hVpOwX/WbQY1KOCL3TDL7t+jJveS529gwfL5BcYVmp2m9MiXlGX5//upZDhYJ6
         2BmYVmhUl/3EE2KPIJQpIxJ4yzi/0/nC9eUzI6yqhQBDWR+1QoUWlfkuWFdIBFFcR56P
         yBJrW7qWCfHoTPidBUtK93YX9ydV2Ya8yYeGcQfUY+lDs8OBLi71HsNThXcN6aDwAimH
         IxFef8G6sZ9zCjc/wEn1JkhvWW8BxOS20BIwJlC7PsIYaG6/Xi933r51RS3G/247B+KC
         OGi0lanGqoKcJXG2AfzF712v1huH37O8RDKOkMEDkMcoGUg3ah8Au4UrZeOsIOwZH0kt
         nLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480426; x=1709085226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNv57wTrROpvBu7D7eRkAMBX/0S6ivveyoxRqXbvKXQ=;
        b=XIQZreEF5ygbT6hVJ/ps9CuCibxEhE8A8LC11knG5DLeyju6M5JhNSO4IL5ddlODxr
         RWQwhr20DOCvMxHwknjXOzZpltsgO7/6cUJvX207+LH6aPnEuaI/9EkRMKneOtg548BL
         5TLO0zOGTXw/jSJ8rDKcOEEh64zoMLnozsiMQX0LmuAqjqWviOqwPWj9mJHaQFsWCxNH
         SkbkXVQnX++QfkfTTu257tSzwxB+rYP4H0q13/g92DJLD6FKF3KzkwGOrgU+cSavRwt0
         KdmfOhMdCjbk+PyxVa5nanwmXtNK7l7DCn0f9Nh4oPOVESp8a5JW9ECmyLET+RzqGhzh
         SA1g==
X-Forwarded-Encrypted: i=1; AJvYcCXfdjjeBUAGchv3SMX2bXCAqrxAv3rUk5psu/F3u4H0GzM2eGXKD120hY+G69CFzbywVlykHdIzaiS6cxyhESmzWW7ItgrnCGHMWnk+
X-Gm-Message-State: AOJu0YwknRTyfEzGBlacalYruYSDzRdagbNzfiHUQNjAjdVWh4yl2u5j
	SVOCjvGnbCcSwbXDjbqzsG/1IXwz6orKGcf9dTbY9dVysMsYwE07pBNtAtAH/PRu7yzNnIjDUNC
	huTKnbyZPzF2RDo0kdGLDxZDg5hSmbXKx9HZ8oA==
X-Google-Smtp-Source: AGHT+IF7gRjr9Hk5fW6BUGGbPQ45tQ34I5uYoYOH7wMtdjE5w7kHEwr10LtY/FMpzS+Tfzw5d9v8DCNbOYESwUeLQKk=
X-Received: by 2002:a05:6512:2021:b0:512:b041:d6cc with SMTP id
 s1-20020a056512202100b00512b041d6ccmr5213332lfs.29.1708480426340; Tue, 20 Feb
 2024 17:53:46 -0800 (PST)
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
In-Reply-To: <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 09:53:34 +0800
Message-ID: <CABQgh9HTH9Utx1CGfni42VykJAFDoYChVbucSA0tmCpeV6Wpxg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 09:28, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Tina
>
> On Wed, 21 Feb 2024 at 07:58, Zhang, Tina <tina.zhang@intel.com> wrote:
>
> > > >  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> > > > mm_struct *mm)  {
> > > > +       struct iommu_mm_data *iommu_mm;
> > > >         struct iommu_domain *domain;
> > > >         struct iommu_sva *handle;
> > > >         int ret;
> > > >
> > > > +       mutex_lock(&iommu_sva_lock);
> > > > +
> > > >         /* Allocate mm->pasid if necessary. */
> > > > -       ret = iommu_sva_alloc_pasid(mm, dev);
> > > > -       if (ret)
> > > > -               return ERR_PTR(ret);
> > > > +       iommu_mm = iommu_alloc_mm_data(mm, dev);
> > > > +       if (IS_ERR(iommu_mm)) {
> > > > +               ret = PTR_ERR(iommu_mm);
> > > > +               goto out_unlock;
> > > > +       }
> > > >
> > > >         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > > > -       if (!handle)
> > > > -               return ERR_PTR(-ENOMEM);
> > > > -
> > > > -       mutex_lock(&iommu_sva_lock);
> > > > -       /* Search for an existing domain. */
> > > > -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> > > > -                                               IOMMU_DOMAIN_SVA);
> > > > -       if (IS_ERR(domain)) {
> > > > -               ret = PTR_ERR(domain);
> > > > +       if (!handle) {
> > > > +               ret = -ENOMEM;
> > > >                 goto out_unlock;
> > > >         }
> > > >
> > > > -       if (domain) {
> > > > -               domain->users++;
> > > > -               goto out;
> > >
> > > Our multi bind test case broke since 6.8-rc1.
> > > The test case can use same domain & pasid, return different handle,
> > > 6.7 simply  domain->users ++ and return.
> > >
> > > > +       /* Search for an existing domain. */
> > > > +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> > > {
> > > > +               ret = iommu_attach_device_pasid(domain, dev,
> > > > + iommu_mm->pasid);
> > >
> > > Now iommu_attach_device_pasid return BUSY since the same pasid.
> > > And then iommu_sva_bind_device attach ret=-16
> > Sounds like the test case tries to bind a device to a same mm multiple times without unbinding the device and the expectation is that it can always return a valid handle to pass the test. Right?
>
> Yes
>
> The device can bind to the same mm multi-times and return different handle,
> Since the refcount, no need to unbind and bind sequently,
> The unbind can happen later with the handle.


With this diff can solve the issue, what's your suggestion?

@@ -88,10 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct
device *dev, struct mm_struct *mm
        /* Search for an existing domain. */
        list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
                ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
-               if (!ret) {
+               if (!ret || ret == -EBUSY) {
                        domain->users++;
                        goto out;
                }
@@ -141,8 +151,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
        struct device *dev = handle->dev;
        mutex_lock(&iommu_sva_lock);
-       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
        if (--domain->users == 0) {
+               iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
                list_del(&domain->next);
                iommu_domain_free(domain);
        }

Thanks

