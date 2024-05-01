Return-Path: <linux-kernel+bounces-165208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAB8B8986
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387E11C2283E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50284D0B;
	Wed,  1 May 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3AXXAEBE"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8282893
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564931; cv=none; b=YX39AEd2vTiAr24wpZ+/tva22Xl6/6fmd3OS94XKTkiskWN3r9aDIPAyi9R9JB0NlMIfAkulo2aSJ1wuXna0myPeGbjYPnkXIEHhfDtSow9iHbXp22x26cjn93ra2y3tmUu6AOJi6owdhGZDDHJQjYF4Un2QHFv2eT5al2hp1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564931; c=relaxed/simple;
	bh=kPqVO4gkmQec2j/rZpF8HaGgeJQsy8uBuIEkqskjQSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiYVQlb8UEBBp8qIFZOVDeeqUJZzl8OQhHvTTejvgPiGueYQ11N1z0GuiyL/oObMB1mbPKz/nu+8+IYfJybt0KZnz5Xg73B382QxdteO93gfK+D6DmH/c8Kas8uIW0BHAa6BcS5REBW9lL9Yf5Dls8/pzkAXaH+mUHSbXZnDpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3AXXAEBE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-790eedf44faso278680285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1714564927; x=1715169727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfLk7bGUufEMZraSml5jPutCQGtddj/TkwI16oNdBn8=;
        b=3AXXAEBE5RM1yYhx5YRHTUJtG9CM3OtTD7VJXVZaZKKbbTtfndgirQjAxx1jf/OGKL
         fOlRq0afAS8k/zrAz1YlMkX/rzufhZMcer2iugUQ8uJkzxRctBWTbhYkTRn5lY2KzQR2
         kHVhc+rZyCU2aKMJ5jsTtw/TXU3ZzINTKjFYzxGzB+7MOPn+C464sxOGFB4S551TiJYx
         zOMBvWBgPsB36dp9HHgZui2GvRYRFpWhnQuTrqt4gTZaiqRngxQ+PvW3CEFovkQ9K0RD
         wCXnbFRSvwnvSdxcVNbQDNzVK4XJY5ZL/ywJ3V02xpz/Z1isgAjH5I1i9smXaDo/4JEj
         0Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714564927; x=1715169727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfLk7bGUufEMZraSml5jPutCQGtddj/TkwI16oNdBn8=;
        b=VliV3LRF1OCVHq2jAyF+5Pj8dtQVzBSoRW6IFjV/Rdme+hBP+LeU7VUA2CC19UQtVp
         ahoqSBxvcfcTTrRkNJOuq+LxBsE3O5qy/8XnmSyGUb6Qe/gQ7fZSR+glkpDe+j4kQfmd
         IRB2rN0wRRtxQDGTPnbePbinhC/mK6yxf9c2w9e+G1MSf1uMdhulrwnSRUsOj/OWWGwX
         w0OqYE145UdY3wRRsGNoc4CuD62cdQe/qn5WbRQjv7Z24SJ+Oa+0DUtg6KjF9adX5adl
         BTgF2cgb+1cdEeUsTNFmr4UjUDolPlQDp/Bh5URisNftoFwumElAvrGggtt18/krQTCp
         yKBA==
X-Forwarded-Encrypted: i=1; AJvYcCULGEdceXR+OMsvVCAWuMz62EPgHevVMHzB6bOyDgqbfeB+N/v2wXRr/QEvzO6F8YHLjb+c/2iJ6GoK83A1p6TcgeQZ9xPTFw72yk6r
X-Gm-Message-State: AOJu0YxBcDFERsft8YUmd4GaTHojoIQ1hqPZqFCELU+BOn+SW+xr5H8z
	NhYh2T6apthLbBgALitpnQFswrhxbeRVdkWU2XUJ3walwqjjoPL+cNV7jwebImE=
X-Google-Smtp-Source: AGHT+IEWthroIrb+JTNpr43+vunLRZ22Cm5i+grgJXt6uS17vY6dRRy34/CUCxuB6exEJiF9j+hfXg==
X-Received: by 2002:a05:620a:2051:b0:78d:6649:4c79 with SMTP id d17-20020a05620a205100b0078d66494c79mr1958138qka.70.1714564926606;
        Wed, 01 May 2024 05:02:06 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id wd40-20020a05620a72a800b00790f5a43245sm2627782qkn.37.2024.05.01.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:02:06 -0700 (PDT)
Date: Wed, 1 May 2024 08:02:05 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, nphamcs@gmail.com,
	corbet@lwn.net, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] cgroup: Add documentation for missing zswap memory.stat
Message-ID: <20240501120205.GB2538005@cmpxchg.org>
References: <20240501095349.1407643-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501095349.1407643-1-usamaarif642@gmail.com>

On Wed, May 01, 2024 at 10:53:49AM +0100, Usama Arif wrote:
> This includes zswpin, zswpout and zswpwb.

Good idea adding these!

> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 17e6e9565156..48ec54627814 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1454,6 +1454,15 @@ PAGE_SIZE multiple when read back.
>  	  zswapped
>  		Amount of application memory swapped out to zswap.
>  
> +	  zswpin
> +		Number of pages moved in to memory from zswap.
> +
> +	  zswpout
> +		Number of pages moved out of memory to zswap.
> +
> +	  zswpwb
> +		Number of pages written from zswap to swap.
> +

They should go between pglazyfreed and thp_fault_alloc to match the
output ordering (they're event counters, not memory counters).

>  	  file_mapped
>  		Amount of cached filesystem data mapped with mmap()
>  

