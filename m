Return-Path: <linux-kernel+bounces-96195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B99875861
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00032281262
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4CD5FEE3;
	Thu,  7 Mar 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PcZLmtxG"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01224B29
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843481; cv=none; b=Veo/MKV/a1uh20xNbx1UudylsdPl/ihlssD4Lk7BfuvxL6qH7NuJ/BDqp0LY6/Yjo+a57U+npg6zPyorKZSQvHV04NDntmrrJzUZEU9n7z38WmLEf9vIzZn6m4dmWC5ToT/rP2i934FOOL3zHmWp3izGRGJ/5YUpQqdm3ghDqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843481; c=relaxed/simple;
	bh=uFkSV3XWA6pSvBdWPTS5Z4D4hTCdELrOUpWgEurePV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPZjbZqZu6yp/sir6Mc9Tt9tftfXY3Acn3MJ8XWC1OoK+bFPlNIqqN3FGbuUyTpfO+2szOIRQ/xp3yKyGX1KzPR3qrjl/nt9tz7ed0ITJEJ0JvBqjxVJP9A4hvI4XCOC+KTN4ljwI4mxYJT4/NQBx/KD5fEQ9uACIPtRyklY2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PcZLmtxG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so10170705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709843479; x=1710448279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=td/qc1v+LcJcAxN8xi3WFcUXSnLHGt1lHwkmw1ZD0As=;
        b=PcZLmtxGTh7uVIpOoxFb+QeLRCq04OP99KCB1sSGFi0d/uUTcPGVZwkss6BrXiAiUi
         fhV3wi1KmFHke/EUAggJyb4TDH8uN6X9TWvYkhoFq/2TNkOkurSMCYzZ/OAwgZQkYQx8
         +JL3tjctLJ3J2e2JwyNP5wJw6MY3H1FSyEZ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843479; x=1710448279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td/qc1v+LcJcAxN8xi3WFcUXSnLHGt1lHwkmw1ZD0As=;
        b=ESPm1SSz1QGLxe2x5O4ZykXDjpfyOVXALRtjQ0CL8NFlGIJzzq91/qfk2kKfr8EHLp
         4d9fY+i8hlHd+ftFSC8Wy/Z0GRi5DP5A4SDzvEZfbxzEp928ptF0iy9yW6SWBxWvb0J6
         VN0t1ch6aCNLqWDiN6Jyvs4tFgH5k0a1JLxmx34z3i5qPONxqCEPDJ7XKjwQI9bqaGCg
         KFOhu5Ic7ezmFdo9bT7pS6adFI6bBgjvbj9Lwv9tIEGbB1D7Ewi3e3i2j5TAIf8DG77y
         /WWKKzoVucQODGLqW5xELQM4jeG6GdZOFfRikSDVq0ajnweCPhTLcaYRnD0Jn7VV3j4q
         EyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+/w5uCXXS+vLoZ//UdFHJ4E5mtJe2mEzRqAxOfG0WvGir4AATIZjEQ2ciD2qIV29TbsvD4fgCH9kZ3Flc9U9f9o2tf35t8qzQTmJl
X-Gm-Message-State: AOJu0Ywqj8WVSpIe0toBgsjmkVBZv3aqgCcS9OEp1q6/8r6R1XQC+ERc
	lAL37638oz3W9mWSPu7gypJ9JEFsNOTLmsZvTRpp+BIJXW2OZ43xgT5SC/n1Yg==
X-Google-Smtp-Source: AGHT+IHhycg/pXareFKjHDwHXtqmeBe85lRVxuPqPrSPkJ5nHJkgXlFDDbM6P1CA4nS+KS/ufBK3GA==
X-Received: by 2002:a17:903:22cf:b0:1db:9ff1:b59b with SMTP id y15-20020a17090322cf00b001db9ff1b59bmr3493970plg.23.1709843479184;
        Thu, 07 Mar 2024 12:31:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001dcc09487e8sm15044171pla.50.2024.03.07.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:31:18 -0800 (PST)
Date: Thu, 7 Mar 2024 12:31:17 -0800
From: Kees Cook <keescook@chromium.org>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Message-ID: <202403071227.D29DE5F8C4@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <b5f9f094-51d3-445a-b19b-99fc1cd7cac1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f9f094-51d3-445a-b19b-99fc1cd7cac1@huaweicloud.com>

On Wed, Mar 06, 2024 at 09:47:36AM +0800, GONG, Ruiqi wrote:
> 
> 
> On 2024/03/05 18:10, Kees Cook wrote:
> > Hi,
> > 
> > Repeating the commit logs for patch 4 here:
> > 
> >     Dedicated caches are available For fixed size allocations via
> >     kmem_cache_alloc(), but for dynamically sized allocations there is only
> >     the global kmalloc API's set of buckets available. This means it isn't
> >     possible to separate specific sets of dynamically sized allocations into
> >     a separate collection of caches.
> > 
> >     This leads to a use-after-free exploitation weakness in the Linux
> >     kernel since many heap memory spraying/grooming attacks depend on using
> >     userspace-controllable dynamically sized allocations to collide with
> >     fixed size allocations that end up in same cache.
> > 
> >     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> >     against these kinds of "type confusion" attacks, including for fixed
> >     same-size heap objects, we can create a complementary deterministic
> >     defense for dynamically sized allocations.
> > 
> >     In order to isolate user-controllable sized allocations from system
> >     allocations, introduce kmem_buckets_create(), which behaves like
> >     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> >     which behaves like kmem_cache_alloc().)
> 
> So can I say the vision here would be to make all the kernel interfaces
> that handles user space input to use separated caches? Which looks like
> creating a "grey zone" in the middle of kernel space (trusted) and user
> space (untrusted) memory. I've also thought that maybe hardening on the
> "border" could be more efficient and targeted than a mitigation that
> affects globally, e.g. CONFIG_RANDOM_KMALLOC_CACHES.

I think it ends up having a similar effect, yes. The more copies that
move to memdup_user(), the more coverage is created. The main point is to
just not share caches between different kinds of allocations. The most
abused version of this is the userspace size-controllable allocations,
which this targets. The existing caches (which could still be used for
type confusion attacks when the sizes are sufficiently similar) have a
good chance of being mitigated by CONFIG_RANDOM_KMALLOC_CACHES already,
so this proposed change is just complementary, IMO.

-Kees

-- 
Kees Cook

