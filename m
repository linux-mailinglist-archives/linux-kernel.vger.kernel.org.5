Return-Path: <linux-kernel+bounces-137108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AA89DD13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6932288DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8212FF94;
	Tue,  9 Apr 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H5SG4Q6f"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AC12F5A3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673702; cv=none; b=nFAbL9KnmVrotRjKCK2Cy+eg2IdkJXzmO55bS3WVPrI5R6unKczzgITnAFZT/IxxsTMl9/Ps1+MiaWinuVz396iNk6ZbOR6PUypT38B5+0W1eF6AB5xjyB1+QRLMcdRSJoq8aXtu63IY0nTsH3ASsUivkUztwTV6aDrvReCihDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673702; c=relaxed/simple;
	bh=1Mniz3dgshc7E3Db3KWa+vxnT7MISvNh/+gY777tGEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av92DNBFaOWQqxnEE11pFfeG3OFqiRNPL4ZHAqXp6ugooxF4U7w3EgYmtYI1t0QAuyNBiBWXU/827NFwzgmdgASwGa3GIy/gQFnvH6Hi6n1e7QJwR9xknHDN7b26+OKPVxjNQc7tZ9BFg5DKdn330kUaJDMflt6ULQKUjGZFEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H5SG4Q6f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0bec01232so46149095ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712673700; x=1713278500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCNea12o/6VUNWUfcyPcbIWG4VttNplpFFNalEKl1QU=;
        b=H5SG4Q6fB80fjFi/kEpbT2FX1ccDaIqQ/QSlg1jKw0MaC7TFXzqT5IzV1Vx/3HSyff
         GK59FBVEL+el9UttKD2lHz9n3nHcykxEm9pnaww8Bcov8ah8Zk7W8ndnsVT7r7mIc5on
         mnEIm5vlmYaA5iWHkjzxdxmvazxXUhlyTIp/SVr+RWnC5FKpXqJBGiLZcytrbf8Ka0+e
         Qi4Euj8d8abMzjXbIfCCTZcDuuGeRWBMmNnk0auYo93E2DVpyMm/7R70IEKubfyiD+qg
         1tEsojN2byowR1V2HDgM/UJUucoTNm+FuqqTomTGNUsJj/YI5DV9tuhyP2blRbuug8MO
         +JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673700; x=1713278500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCNea12o/6VUNWUfcyPcbIWG4VttNplpFFNalEKl1QU=;
        b=RnwekFKWvgXgv3Ihfs/Nmtd3oqbCmf97kJy/vyHgZtkYVsriM+gSFWIhG9eOu9mj8n
         gFYe4A/ehIfOEgNXzI0RoHUm1Ba8LG2B+GZ/tfZqDF3GToVvGS0HVLZjXe0rK1LfwYzX
         4yhS1Tlw31LfWc7YBv7lYH1b2aoR6N9Dad49oj3HXj3BwdkvnqeGZTwmjBtWL1ubAkGC
         eAQzOM9ZseZug4RDMWeRF9kZTydM/b0lZgiN/K5l6dwWERpzfvaZLw1EDVgZInEeAwsk
         xYMepiJCCa21klBiezas4/0cdupKTCYJSUTKtZ0T0jvft9KL80KELH9lhJKIV2lwTwtV
         74Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVi06SrD5DKo2EUR/kVe3Pm9azewxquSMDZxYOoug6pXI45tahTZTxGg1q0Fpft/E/mknzTtvXWgHbcveDPpnV09CveMPE1JmvZihK1
X-Gm-Message-State: AOJu0YwezYEQVTp27VSc21UkUPqhhe1/2jp/x6bVqo1pTa5fbP2wTSPo
	Gi9Y9XnhgRkf2Z99M03KXoQ83/BUPWKAbkQxzPoWOh5/N7/HbMnhlQUqDTnqxTU=
X-Google-Smtp-Source: AGHT+IGRw2dBpQjaGcDhXFkJbiyZJFy2cQnXUEeD7DIfCfoahwMGNRpxCQuIp2dqwMnS8QCDwuCNIQ==
X-Received: by 2002:a17:902:eccb:b0:1e3:cfc5:589e with SMTP id a11-20020a170902eccb00b001e3cfc5589emr10181571plh.64.1712673699804;
        Tue, 09 Apr 2024 07:41:39 -0700 (PDT)
Received: from bytedance ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001e120a9e964sm8798565pln.126.2024.04.09.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:41:39 -0700 (PDT)
Date: Tue, 9 Apr 2024 22:41:32 +0800
From: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ryncsn@gmail.com, nphamcs@gmail.com, ying.huang@intel.com,
	songmuchun@bytedance.com, david@redhat.com, chrisl@kernel.org,
	guo.ziliang@zte.com.cn, yosryahmed@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
Message-ID: <20240409144132.GA542987@bytedance>
References: <20240408121439.GA252652@bytedance>
 <20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>

On Mon, Apr 08, 2024 at 01:27:04PM -0700, Andrew Morton wrote:
> On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com> wrote:
> 
> > Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
> > Create 1G anon mmap and set it to shared, and has two processes
> > randomly access the shared memory. When they are racing on swap cache,
> > on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
> > took about 1475 us.
> 
> And what effect does this patch have upon the measured time?  ANd upon
> overall runtime?

Hi Andrew,

When share memory between two or more processes has swapped and pagefault now,
it would readahead swap and call __read_swap_cache_async().
If one of the processes calls swapcache_prepare() and finds that the cache 
has been EXIST(another process added), it will folio_put on the basis of the 
alloc_pages_mpol() that has been called, and then try filemap_get_folio() again.

I think the page alloc in this process is wasteful.
when the memory pressure is large, alloc_pages_mpol() will be time-consuming, 
so the purpose of my patch is to judge whether the page has cache before page alloc, 
then skip page alloc and retry filemap_get_folio() to save the time of the function.

Thank you.

> 
> > So skip page allocation if SWAP_HAS_CACHE was set, just
> > schedule_timeout_uninterruptible and continue to acquire page
> > via filemap_get_folio() from swap cache, to speedup
> > __read_swap_cache_async.

