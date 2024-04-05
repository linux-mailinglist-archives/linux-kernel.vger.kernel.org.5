Return-Path: <linux-kernel+bounces-133106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC3899EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E7FB224F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16E16E87D;
	Fri,  5 Apr 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7t1TVfO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7F16DEB9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325891; cv=none; b=GMuv/7P8AhPkjmRC4H0kCPx1s+KcZvhhzpjHJ+ILv8VbTxPmSaKt8wGLrQ7GK5bTsdJnG9Ok7luDzDMCPsKYACq4F6+eWZkU7nX1UiHLyd19Ia8EjwrDgZgBk/VF46ziLKEA7e8z+NycaRbyA8VODqNh5IohD2jCKsVyEEFdxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325891; c=relaxed/simple;
	bh=YLppziVi18FS86lsRUFYbik4pdpKw9o5av3kYjqyrXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQnqh4VtwO/ANbUGiZw0iuWkRXX6ZskdJPNPNNXYEzuVTZYNW0r5kKUs8XIVfj4KzMDFevFOwR0EDUUaVRQ4G3whb67ZHIKfYiA7VytD5uhrNCibrFO/nO+BxPcw0OKSYgRQsdk5EgPm+wTIMA8O62gwUURgFNJ4lUgYDUF2S9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7t1TVfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712325888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJZjF5huZ/IS92CnJZN2AYaHFZSXzZinDMU0oFLcit0=;
	b=i7t1TVfO0HOEXTMC65+a7B6Lgc2RIzofh9Cicw99C94tM5lLb8c8bDMn8bIR7EW77V7lRi
	fRaT53+kz7chQJVxf6R6GQQ1R6br197ywdjN6VUQfDO4YHrpiUNoFp35zbsvxz6vykhujl
	y1n5BCf6+DCkSCEvdpif+4rsi/Ywi50=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-21Upf3aQNLmTuWpvX18YBg-1; Fri, 05 Apr 2024 10:04:47 -0400
X-MC-Unique: 21Upf3aQNLmTuWpvX18YBg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78a687cc579so255256185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712325887; x=1712930687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJZjF5huZ/IS92CnJZN2AYaHFZSXzZinDMU0oFLcit0=;
        b=rkd/Z6ad8xqefdZ+FwAQSAg8nL5G7iFMJozMyTMCOLUE1fXHZAhWzKfL868di6UKHR
         +8Pd916RXM/8TDvMVc+aEcCZe3IXXwn+zDBvU8VFbQiYX590JCPHqNhHhl2+VCMn37Lv
         WGYNyq3BW2wsV3XHtVSuMJyrsoms2nJdaJCOWFzwfoMEG6xB0WcJG/jMWDHRp+RWicRz
         wNX8LCY7NkJJwisEzcTAWlDCEycuLzzVaZv2yWIC+zMlDPsFy5nAJFwCDehvzDMaFPr5
         LmKip46vrKq9KF2SGCxKROQtlwz7ENP8vGDxi86B31eEK/1XRw/dcFGpkFzH3PTezfGo
         6ftQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbRZG1Xo85M5u/aylaxaPIOD0zLS3KJj/XxZWM7VfGdKrvfrkg313tF5eClQEyBAnVZlfIk0nBrx8XrJ+sWC32ya4xS9SUv/0NNxA
X-Gm-Message-State: AOJu0YwZjuVDyS4uU0SxKIWPmFY7OBTbWdLmyFddcAcN3xG3T2avd97w
	9lTvqSeKLt5MTs88KOFKsOM0/hBaGqM9is5FeXNMDTecT7s5nMMEICX4rGGFHAvI/liufbPL8OH
	qwsNKEtvTBQ9QWMBPXJb9MifcU6YfZsXQlO9O254C9jocp2ljeX9zAd3+k0byMw==
X-Received: by 2002:a05:620a:2b84:b0:78a:72b3:b629 with SMTP id dz4-20020a05620a2b8400b0078a72b3b629mr1708178qkb.44.1712325887098;
        Fri, 05 Apr 2024 07:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeHEjy/9A/4fTjZi0cCVsMnWNGemn3Slh0adyB59fLgBdpF4HyFXzqH7mBOCLvsV91+RB47w==
X-Received: by 2002:a05:620a:2b84:b0:78a:72b3:b629 with SMTP id dz4-20020a05620a2b8400b0078a72b3b629mr1708136qkb.44.1712325886596;
        Fri, 05 Apr 2024 07:04:46 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a030900b00789fb5397d4sm654993qkm.100.2024.04.05.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:04:46 -0700 (PDT)
Date: Fri, 5 Apr 2024 09:04:43 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, robdclark@gmail.com, will@kernel.org, 
	iommu@lists.linux.dev, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com, quic_cgoldswo@quicinc.com, 
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com
Subject: Re: sa8775p-ride: What's a normal SMMU TLB sync time?
Message-ID: <lqdosfpb7gdjooqswgjnabzxapocndzam3ws7dq7god5bn55an@igvaowz6h7ye>
References: <kord5qq6mywc7rbkzeoliz2cklrlljxm74qmrfwwjf6irx4fp7@6f5wsonafstt>
 <Zg9vEJV5JyGoM8KY@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg9vEJV5JyGoM8KY@hu-bjorande-lv.qualcomm.com>

On Thu, Apr 04, 2024 at 08:25:04PM -0700, Bjorn Andersson wrote:
> On Tue, Apr 02, 2024 at 04:22:31PM -0500, Andrew Halaney wrote:
> > Hey,
> > 
> > Sorry for the wide email, but I figured someone recently contributing
> > to / maintaining the Qualcomm SMMU driver may have some proper insights
> > into this.
> > 
> > Recently I remembered that performance on some Qualcomm platforms
> > takes a major hit when you use iommu.strict=1/CONFIG_IOMMU_DEFAULT_DMA_STRICT.
> > 
> > On the sa8775p-ride, I see most TLB sync calls to be about 150 us long,
> > with some spiking to 500 us, etc:
> > 
> >     [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd start -p function_graph -g qcom_smmu_tlb_sync --max-graph-depth 1
> >       plugin 'function_graph'
> >     [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd show
> >     # tracer: function_graph
> >     #
> >     # CPU  DURATION                  FUNCTION CALLS
> >     # |     |   |                     |   |   |   |
> >      0) ! 144.062 us  |  qcom_smmu_tlb_sync();
> > 
> > On my sc8280xp-lenovo-thinkpad-x13s (only other Qualcomm platform I can compare
> > with) I see around 2-15 us with spikes up to 20-30 us. That's thanks to this
> > patch[0], which I guess improved the platform from 1-2 ms to the ~10 us number.
> > 
> > It's not entirely clear to me how a DPU specific programming affects system
> > wide SMMU performance, but I'm curious if this is the only way to achieve this?
> > sa8775p doesn't have the DPU described even right now, so that's a bummer
> > as there's no way to make a similar immediate optimization, but I'm still struggling
> > to understand what that patch really did to improve things so maybe I'm missing
> > something.
> > 
> 
> The cause was that the TLB sync is synchronized with the display updates,
> but without appropriate safe_lut_tlb values the display side wouldn't
> play nice.

In my case we don't have display being driven at all. I'm not sure if
that changes the situation, or just complicates it. i.e. I'm unsure if
that means we're not hitting the display situation at all but something
else entirely (assuming this time is longer than ideal), or if the
safe_lut_tlb values still effect things despite Linux knowing nothing
about the display, which as far as I know is not configured by anyone
at the moment.

Any thoughts on that?

> 
> Regards,
> Bjorn
> 
> > I'm honestly not even sure what a "typical" range for TLB sync time would be,
> > but on sa8775p-ride its bad enough that some IRQs like UFS can cause RCU stalls
> > (pretty easy to reproduce with fio basic-verify.fio for example on the platform).
> > It also makes running with iommu.strict=1 impractical as performance for UFS,
> > ethernet, etc drops 75-80%.
> > 
> > Does anyone have any bright ideas on how to improve this, or if I'm even in
> > the right for assuming that time is suspiciously long?
> > 
> > Thanks,
> > Andrew
> > 
> > [0] https://lore.kernel.org/linux-arm-msm/CAF6AEGs9PLiCZdJ-g42-bE6f9yMR6cMyKRdWOY5m799vF9o4SQ@mail.gmail.com/
> > 
> 


