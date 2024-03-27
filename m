Return-Path: <linux-kernel+bounces-120775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832AF88DCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D19297A84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEA12BE94;
	Wed, 27 Mar 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BQBpcsby"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140912BEAA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540203; cv=none; b=W+ksuWxVD6pvR9jiRrhwxBK1dPLXbKL89bBJP6R3E2XAnDM0PwRYclbAwvlCBznjA1iYTVA8+sVTFHe9kdogLpLms3urNCkKUEpx/BQrYtlyTeRCEIydio4mRI8r6zWHk0WrOZ3OaAfadMr67GkIO7HY2mXF09+ThSHBktLD+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540203; c=relaxed/simple;
	bh=jUGLMXfJA53XClr/yZYHyekFyse0uCD0AkZBZQ9HFPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMAVG3qiTPU3iBko1WmW/RCg9O16cDInbH2c+ggKRojr51NNd3GOl3K2kBQDQSAQqQcDQo7oDX++Kd756RvyRSwg7z0EWyx4Bvd+1CF3kXGA3OF2d1HH9PLXY5u6czhuq9C9L37r/X0mf+ds5TryIibekVH+3WGRFckPUqDkd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BQBpcsby; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789e2bf854dso388859385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711540200; x=1712145000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRCwxUtywPyv/sfMfB7vDdhGhWd2UBJnlU1eKR4NMmg=;
        b=BQBpcsbyXCy0ANtozaTBatHeafDnspgjIEG2xp6GBwPgOxoUijzM9jeUsUmXP6fAvL
         5VWSwAUiIyjShgj/OP2Q3356zJ7kL0fwkz42TM4jCBA0EwG6zofcfW16DZ4uTLhbaQIc
         J45x64Z+Vwav2A+pKQRPuMThDY4lrOGgKnUQT14O3nu4dxTMiVZ+MiWgllzJ3GDk8psw
         XQsHkKLz+1B7nRJaqkeqiPURhksE4fgkipKmNxMBM3Da7+oruXvhLwhrXSSDe5F/tX0c
         6qrxMk4OD5x82v83ndu2aqnRGpYOHBfB943qmPcTj+ZgoYju4PxwLyihCgSMCnDtxqUZ
         c6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711540200; x=1712145000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRCwxUtywPyv/sfMfB7vDdhGhWd2UBJnlU1eKR4NMmg=;
        b=B+g09JthKA33AvFdsVBW/xj9T2fDmkwBJvFRlEAcaodPOEDkQLVonkg8QQIm8e59YE
         xKsiVplt1rr6X92A+krz6sbjXHfxeQUARxgJVhvxbfeGIo8ka5I8qD50566RlOaQ8YDG
         0St97FX45EeVWvS84VraQYexQisHCaudJLSZbTgU6xTSvHmAstPi2YHfjyuCVlgcScWU
         1Mt2DtAPlm4SFnPeZB+CTbkCT9eCpfJYTVc7oVn/GjM2jSNc/768FOgnjrh9JSHjY5cG
         gSP5sZkBtsc0P9GxbllBJUwTvsjH7I5TEgeCjOUKWIX9nmmqExvshUOoOoGLdTi2E8nR
         c3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxJVHZYZIYAJge+GuToKjEEy7ziYCD+07tLESdKpi6/ACBZSQQJIi+v2ndJB4kAztcZ2Xp7k435irRex0gRxfSDrNCdT3qeFAcLGu1
X-Gm-Message-State: AOJu0Yw+oT7bjDCpyzNdVpeaqhJN0FkdxJF1YiJDP7FohRp0W2Lm4avZ
	UXjdN4Timef+Wkjg9XCe5xgoe/K2f1LcLV8Le9vrsbeDI7CTVC8m+vUcD31U62Q=
X-Google-Smtp-Source: AGHT+IHwk5sSFKdm6Uh7Tlt4FGOA8xWOgg7e771JOsFUfYRAlXL6Y42sG4BEWKBvccGOUUtZiQb1mA==
X-Received: by 2002:ae9:f407:0:b0:78a:5feb:d3aa with SMTP id y7-20020ae9f407000000b0078a5febd3aamr995720qkl.15.1711540199785;
        Wed, 27 Mar 2024 04:49:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k26-20020a05620a0b9a00b00789e2961225sm3808233qkh.61.2024.03.27.04.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:49:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rpRn4-0051gL-Np;
	Wed, 27 Mar 2024 08:49:58 -0300
Date: Wed, 27 Mar 2024 08:49:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel@collabora.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Message-ID: <20240327114958.GG8419@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>

On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
> > On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
> >> Even after applying this config patch and following snippet (which doesn't
> >> terminate the program if mmap doesn't allocate exactly as the hint), I'm
> >> finding failed tests.
> >>
> >> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
> >>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
> >>                    mmap_flags, -1, 0);
> >> -       assert(vrc == self->buffer);
> >> +       assert(vrc == self->buffer);// ???
> >>
> >> On x86:
> >> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
> >> On ARM64:
> >> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
> >>
> >> The log files are attached.
> > 
> > You probably don't have enough transparent huge pages available to the process
> > 
> >       echo 1024 > /proc/sys/vm/nr_hugepages
> After making huge pages available, the iommufd test always passed on x86.
> But there are still failures on arm64. I'm looking into the failures.

Oh that is really strange. Joao? Nicolin?

> #  RUN           iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap
> not ok 139 iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear
> not ok 140 iommufd_dirty_tracking.domain_dirty128k.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap
> not ok 144 iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear
> not ok 145 iommufd_dirty_tracking.domain_dirty256k.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap
> not ok 149 iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear
> not ok 150 iommufd_dirty_tracking.domain_dirty640k.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
> not ok 159 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
> not ok 160 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap
> not ok 164 iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear
> not ok 165 iommufd_dirty_tracking.domain_dirty256M.get_dirty_bitmap_no_clear

> #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap ...
> # iommufd_utils.h:374:get_dirty_bitmap:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap
> not ok 169 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap

> #  RUN           iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear ...
> # iommufd_utils.h:374:get_dirty_bitmap_no_clear:Expected j < npte (1) == test_bit(i + j, (unsigned long *)bitmap) (0)
> # get_dirty_bitmap_no_clear: Test terminated by assertion
> #          FAIL  iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear
> not ok 170 iommufd_dirty_tracking.domain_dirty256M_huge.get_dirty_bitmap_no_clear


