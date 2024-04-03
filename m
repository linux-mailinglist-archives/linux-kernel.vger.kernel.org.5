Return-Path: <linux-kernel+bounces-130432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14A897809
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7633328776A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6B15356D;
	Wed,  3 Apr 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUn2RWIH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDA152DF0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168369; cv=none; b=bF6gBxWhaWa1pMPPAlkry0v0ptZS6A297KKfpZmDcJwpv5pmEEIna0lJVeConNORqscAPR7m8shI+BxTnU4Fy4KGqMh4ch4SVEIEszDs0LV8yWWneTehJdc9CX6G84ASpNRizQnOzRDTS8AvywbCC9QkSmhs7CvQiK3mywi9jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168369; c=relaxed/simple;
	bh=rbR2FKkHDQVwqEiEdZlkVNBjzTI0TMlrIpI+c+AB13A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaflO7kNdqHazef1TPA9KmTokZJRYFaCeONheGS2Dwsw57eAPF89OzrDH0wWmzWZ4BZ4OuRCzQ1wZyGOWeX7Jzx/IBdJBf6xU2JnbNZuOx+0eJ0TOY/F0SGQOqe5eeaF3CVQHPLLK7ZfhyJ5bnlksvSRFdADuuQMyrKbbONnRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUn2RWIH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712168366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xdeUv3Ofjr2iqkst/jH7iP0eOxc0lfoJcFP/WPP4Da8=;
	b=NUn2RWIHCk2nZogVkzbCR8HWXGAriwl8iVsOU8ZoEyi9M8o0YcYAfSzTHvnnUj9TAoPGZ/
	6Xlzm1UZHrIS5qE91QE9FeD2pFZNC8olfLK8d6mSEOen0CRf2nvfah2omgyd4+Md5jqzcD
	GFFwaTfqlh+WpUSMx2lv9NBNjdovo8c=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Lh1zHIUQMj2bCvaXZsb-Mw-1; Wed, 03 Apr 2024 14:19:24 -0400
X-MC-Unique: Lh1zHIUQMj2bCvaXZsb-Mw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5a4d25f4795so35143eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168364; x=1712773164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdeUv3Ofjr2iqkst/jH7iP0eOxc0lfoJcFP/WPP4Da8=;
        b=c3Hx3bMFOHWbcMTQmQ3tHwAz+ccpzmJCbMzyOwrieKwcFT65xbvneHrZALTr0ocjYy
         RxC0L3W4y7lEvhSzIIQmCBi+N6kgvmR9K0gmk0Lcpd13d1YWYeyIrFLq/HN1DA9lHBxm
         vZPcRFvdHiJN2P1gnd8K8sHQw/+cU/l5bgdj3ldz3shiuq+7seysnmojoXHrYWlwOOuG
         xpadtlG9DudZlYzDpcD1ZU7o8lx+BFoRMftKpYzH4sk11h+JUHr8Ya2CdcXU1uxCGaHn
         ZJCaP3M2wUYq9NeB57HL5IoobzusV9N6MXppGGImgvV7+q6PZmJdWqpbtHRcrj3W5Pkh
         O3cw==
X-Forwarded-Encrypted: i=1; AJvYcCVIv6Pl3t5GHi0hEbC8YaCBsrkPisCPkZXmG45Gw1B7ytJYUE1mEcwRGWgMsihpqG8Xdoz8WXCzxIMcU0NIw1voTSXSMN/ygdDn8kl9
X-Gm-Message-State: AOJu0Yz1efqwns9OVNxpdO6hbW45w0mCwNfSySNyrgAeoeIHs/seVRvc
	VtGEgQG6/2ijdMgY3gKihikX5/1lLfVtBZvKsjRBC2msjupPFKgqgGRTIMttABZx/Il2ZG7rXE0
	n+UEGv56fv8nvuEh+PnliwFcmUDKPmGDganaHhgtz89Qme2UwPMDKGOcrsmCTYA==
X-Received: by 2002:a05:6820:ec6:b0:5a6:2c6b:d3b with SMTP id en6-20020a0568200ec600b005a62c6b0d3bmr207971oob.0.1712168363824;
        Wed, 03 Apr 2024 11:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHn1qy1mV6MIo0wP3BfV0wKGaxVdX31dolc6mtjUrNwwrXrfZXmbb7Bwh6zIgN4DaKiHm6bA==
X-Received: by 2002:a05:6820:ec6:b0:5a6:2c6b:d3b with SMTP id en6-20020a0568200ec600b005a62c6b0d3bmr207951oob.0.1712168363366;
        Wed, 03 Apr 2024 11:19:23 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fa13-20020a05622a4ccd00b00430bc1186aesm6767744qtb.28.2024.04.03.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:19:23 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:19:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@redhat.com>,
	Nico Pache <npache@redhat.com>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: Fix hugetlb mem size
 calculation
Message-ID: <Zg2dpzSlEantr0Y8@x1n>
References: <20240321215047.678172-1-peterx@redhat.com>
 <1c20b717-c5b5-4bdf-8fcd-d46db135b7fa@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c20b717-c5b5-4bdf-8fcd-d46db135b7fa@arm.com>

On Wed, Apr 03, 2024 at 12:04:00PM +0100, Ryan Roberts wrote:
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> > index c2c542fe7b17..b1b78e45d613 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -152,9 +152,13 @@ done < /proc/meminfo
> >  # both of these requirements into account and attempt to increase
> >  # number of huge pages available.
> >  nr_cpus=$(nproc)
> > -hpgsize_MB=$((hpgsize_KB / 1024))
> > -half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
> 
> Removing this has broken the uffd-stress "hugetlb" and "hugetlb-private" tests
> (further down the file), which rely on $half_ufd_size_MB. Now that this is not
> defined, they are called with too few params:

Those FAILs can be burried in some other libc mismatch issues for me so I
overlooked.. My apologies.

I'll send a fixup soon, thank you Ryan!

-- 
Peter Xu


