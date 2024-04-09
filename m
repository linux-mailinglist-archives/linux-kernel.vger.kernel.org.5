Return-Path: <linux-kernel+bounces-136770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E489D7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2FB1C2451E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E86F12DDA7;
	Tue,  9 Apr 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVqNuGT9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7121272A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662323; cv=none; b=E8NJH1Tn5ZNrQIGSAKl1tmMVbPu5ks3kyi7f7CD4BLOY0iIdp5FM18SqzY2FdmdZM0mJ8rwlFrcRPG56Dl1oWBLwgIq6hHQbo9MvW8e/noNe4hcvDx1JKkqjQCMqQ7Kh9NrH8IL8PxGfH5cz7MLScFHJkFOZuiyeYtOBBMC7YdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662323; c=relaxed/simple;
	bh=e7xh7zUpQO/f7HZi7UU4sg3MF2Z15fxZPQmiWM4x8uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7bImzKGQGiBX9O6JcTXV5OnUumwIKGo1WmBfrdiaWWrk+RgifjZN9k/qlNQGZH0+91iobPNth8UF4BQ3XsMTTCbjPFUqmkOzdhG0vKEOD8/6pI+mmN27IdsFcwSHLPzLd/5KctWjeR07D+ygHHZnCoKIk5Qz88eGbKrclzpErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVqNuGT9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso72335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712662320; x=1713267120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4DFnz/WvqbVMqJ3REDURlQMNEnJzpbcoDSyqNDWBm4=;
        b=lVqNuGT9ZI4VEvMxvaTQOEs8fiCSdkq9nYR32/Ytps3NNYVHbh5kecaV5bJecyX+zU
         8s6lZbqoiEnMLBR9asOR55fUuYvQUppF9BKbjD801ithARXSucufAP+2a8U05vhFp7N1
         ja5Mtwlc+GmI7UzXBScTns8mo9tdtzM77Pg76hrWCdLEWgeFROGYzAiXgJx708h5gcyw
         WipRBP4WHQ1/sZu+EAEeSW2CmH9dt1B/5PENxecb33g5iDrS9DMMnYT87BiKXdx1JXhY
         OxJZtEgR1z2b0yXU3Wr4I9OrCLK1IhNirWd4PT0mrWeoS/rtSs2NbR5sJ3nxGeUfAh0A
         kPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712662320; x=1713267120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4DFnz/WvqbVMqJ3REDURlQMNEnJzpbcoDSyqNDWBm4=;
        b=XW8TXbkN/e/k95QQfZOAyYXNRDR61/oFH1F4/UYP5YNHkOc7HGHZXFOT8AxPFkgk7I
         kxVxzrhhNpAHz9Fipk4bbwjkOByy5a/YZuRU9e+9Hyv/0LtmUzln+A+jNbqJKDOHQj9n
         dB31PDFHoLhv6nW6XinHXRTpLfnSwpZMfaFXWdnF7+yBgMMk431MEm4leJ+bd7NaV1vJ
         8dCzzM4fuCUttoQJh7Zx/cjQSuKapZs1qKllsStuVaMOBhE2FH6nZ6FPcxwMIGQVQ14K
         W+imvwgmRTbS6hCsK6qJuISRztdbzt4o3AYnCIVmlJJLkQpwee2MTWFir2QD2JRygXSI
         7Ojw==
X-Forwarded-Encrypted: i=1; AJvYcCWWlvFmu0G9NExPvVmAiSse6I2I+28EXhpA4IIntlpT29Jip2a6h4r9mbSf9JEEkwu1Mh81k53RnHNGZyhcQZ+OCGM4nPZhV0pA+PcG
X-Gm-Message-State: AOJu0YwglprFj9r/KNQ+mbbxRKbRw3WvcU9CNTn9IvRy5DpsGLvQo987
	BK6NEXiyCVfz9iDMnc2i1da66l2RDnQMuzV2xYvpgMSx0OZYNlpSo9mPkDxRug==
X-Google-Smtp-Source: AGHT+IEKhWdjBCLhSgPhpTkaQshxax9sUIa24Y/ydpxEHLgbRl9WWQbrCX4RqHImsXU0Q6eJ0iLhyA==
X-Received: by 2002:a05:600c:1e0a:b0:414:1400:a776 with SMTP id ay10-20020a05600c1e0a00b004141400a776mr121340wmb.5.1712662319674;
        Tue, 09 Apr 2024 04:31:59 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b00416b8da335esm400432wmo.48.2024.04.09.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 04:31:59 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:31:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Message-ID: <ZhUnK1-Pvcix5dyI@google.com>
References: <20240403053759.643164-1-aaprelkov@usergate.com>
 <ZhUbw6gAeBjpFz5C@google.com>
 <8a7f0218-39e3-4e4b-ba99-7fe4389fb703@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7f0218-39e3-4e4b-ba99-7fe4389fb703@arm.com>

Hi Robin,

On Tue, Apr 09, 2024 at 12:17:54PM +0100, Robin Murphy wrote:
> On 09/04/2024 11:43 am, Mostafa Saleh wrote:
> > Hi Aleksandr,
> > 
> > On Wed, Apr 03, 2024 at 12:37:59PM +0700, Aleksandr Aprelkov wrote:
> > > If devm_add_action() returns ENOMEM, then MSIs allocated but
> > > not freed on teardown.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 166bdbd23161 ("iommu/arm-smmu: Add support for MSI on SMMUv3")
> > > Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
> > > ---
> > > v2: Use appropriate function for registration failure as
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> suggested.
> > > 
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 41f93c3ab160..8800af041e5f 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -3402,7 +3402,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
> > >   	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> > >   	/* Add callback to free MSIs on teardown */
> > > -	devm_add_action(dev, arm_smmu_free_msis, dev);
> > > +	ret = devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
> > > +	if (ret)
> > > +		dev_warn(dev, "failed to add free MSIs callback - falling back to wired irqs\n");
> > 
> > I am not sure that is the right fix, as allowing the driver to probe
> > without MSIs, seems worse than leaking MSI memory.
> > 
> > IMHO, we can just add something like:
> >      dev_err(smmu->dev, “Can’t allocate devm action, MSIs are never freed! !\n”) ;
> 
> Honestly I don't think this matters. If we ever really did fail to allocate
> 16 bytes, SLUB would already be screaming and spewing stacktraces, and the
> system is dead already.
> 
> > Also, we can’t unconditionally fallback to wired irqs if MSI exists,
> > according to the user manual:
> >      An implementation must support one of, or optionally both of,
> >      wired interrupts and MSIs
> >      ...
> >      The discovery of support for wired interrupts is IMPLEMENTATION DEFINED.
> > 
> > We can add some logic, to check dt/acpi irqs and to choose to fallback
> > or not based on that, but, if we get -ENOMEM, (especially early at
> > probe) something really went wrong, so I am not sure it’s worth
> > the complexity.
> 
> That logic already exists in arm_smmu_setup_unique_irqs() - the messages
> here are in the sense of "we're giving up on MSIs and falling back to trying
> whatever wired IRQs we may or may not have." The critical point is that
> we're not using MSIs for some potentially actionable reason, i.e. if the
> user does expect the system to be MSI-capable, then it could be an
> indication of perhaps a wrong or missing msi-parent, for which they may
> pursue a firmware fix. In other cases it's normal and expected not to use
> MSIs though (e.g. the system just doesn't have an ITS), so we don't want to
> be *too* noisy about it.

The case I am worried about in this patch, is for systems with
MSIs only.
With this patch, that means, we fallback to wired irqs which don't
exist, so the driver will probe with no interrupts at all, which in my
opinion worse than leaking the memory.

Thanks,
Mostafa
> 
> Thanks,
> Robin.
> 
> > 
> > >   }
> > >   static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
> > > -- 
> > > 2.34.1
> > > 
> > Thanks,
> > Mostafa

