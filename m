Return-Path: <linux-kernel+bounces-109215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891B881647
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C81E1C2314D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866E6A01D;
	Wed, 20 Mar 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZN2DZJY9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3A69DE8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954912; cv=none; b=ZuKrZOZTggfVUaqcZAVpX6fGsW7axyO1TAz44cMaSF6enKuljqDps3vjSf9C9lOnOko9vtt3gWNk1ZIG8uDA0zbXSSUDXEm8p7RLud077nWaxCa6MErCIryeQQDbVjWiTK0Z/o5qsVPeGXd35W8Jzcy6m/MNSbgq7mbophhRiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954912; c=relaxed/simple;
	bh=I5S3KGbEZ9dmN6jv/E2GZnbqjJ1tmnibQpIjYvR2lg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbbpHRV4CvdU9pCQMnBXf3Z1Nch9yk1LBPm+9cmk951+2VdUYECZW26tfrWbwqHmwLGJWmhOVhJNrgvBNiGHH9BSrKN9PpeLSgZP2/7snwAQ6lty2WPHWlL+nk0TNaDZ0LF7Ncot2t/xaaRsNSXHmrCHOUv4/uLaxlMgyn3oQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZN2DZJY9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso5635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710954909; x=1711559709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAfBGS9lgN4PadnDyLpBcUPMVu2nmn91giWvF5pQde0=;
        b=ZN2DZJY9TpZ5L7HnNTUPauk8oWV7mJj663Cb5ZirSPZPT/2g14R+ghReJF39Qf8YMl
         ZaLhNm4FRIW/1IN4+S1coMSO5NEHCyRY9p3DjEompbWPTrJGzkOvrEluy7GY6tgJV9mD
         4aSKyPZAoWI+DygCWnGB9jnq4JoHWb7K6MCFlL4VRzsTy+paQbWwCFtm5eMAhUb2QJVe
         0/wVjjJ6ibLdZR2/jx2P6b6lSsldpxZMhR7E1MKrp9zL39agurzN6I6zUbm6dAwKbevj
         bAsJODNTLLqem4AaRVuIRRATwLjqyrebd6ADYuCUQkJGunRBNtpt1sIYOoH/bJcJs057
         5Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954909; x=1711559709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAfBGS9lgN4PadnDyLpBcUPMVu2nmn91giWvF5pQde0=;
        b=SjL8Un5YF7nSS4J3TJ28nL/GcL8OmiA0agG6hBVqAc/SZhTdqgioTxfjh3gxAIP8De
         k33K2N3xsgsEwxH3OzwRNcdREfppuyDIGz26wWjHr0B+mehXAILDCYEbo4Coo7SDfRN2
         4iRNmTARcEuK7BpOd1WYKZgazgI1gJsIsraYPzjm6aB7f2wGfcTcw6d11beWVLj4tyxb
         itbYQEj5ZmmOz2FjIwnCYC6qR/VNReGO7q98f8bGfeQv+nY7O1IhwR5iSnwPJcS6vTFa
         h+ENAt09BaV8GopX+LRRaLnqnzOiHqYJsVaGHYEedp0BJrA+DrCHe/zYVc/q1OUXnuoX
         x7WA==
X-Forwarded-Encrypted: i=1; AJvYcCUGBnnHzDwwKjv68Zopq0ZYUS9RjIHWYblhtMfaNpRER+ndYwf2onJlAXXNP5nm0JZMK1E4J2KDJcTkM6pX1kx38KK+IpYZ8/PoT8Cr
X-Gm-Message-State: AOJu0YxoDzVoIR5OCU4quKmpOUzCq16QT1lABLnVsmxytpVSNcpBlHU3
	PPBLivcf2ChAIA8LYW8l+1C7ivyXXafsS1Uly3sKet8rJtoEPtjzuZOzYGGRAA==
X-Google-Smtp-Source: AGHT+IHgsBic49slU1Dk0/+SnE9BsDw9Yb6LT7CDKzPy9+x6UIkDK3L0ju5RzzvzPPeg+Z8EmARnFQ==
X-Received: by 2002:a05:600c:3b9e:b0:414:11:ec14 with SMTP id n30-20020a05600c3b9e00b004140011ec14mr271767wms.6.1710954909350;
        Wed, 20 Mar 2024 10:15:09 -0700 (PDT)
Received: from google.com (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b00414108a1c55sm2820774wmo.16.2024.03.20.10.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:15:08 -0700 (PDT)
Date: Wed, 20 Mar 2024 17:15:02 +0000
From: Keir Fraser <keirf@google.com>
To: Gavin Shan <gshan@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <ZfsZljA_mmHKkBsA@google.com>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>

On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
> 
> Before this patch was posted, I had debugging code to record last 16 transactions
> to the available and used queue from guest and host side. It did reveal the wrong
> head was fetched from the available queue.
> 
> [   11.785745] ================ virtqueue_get_buf_ctx_split ================
> [   11.786238] virtio_net virtio0: output.0:id 74 is not a head!
> [   11.786655] head to be released: 036 077
> [   11.786952]
> [   11.786952] avail_idx:
> [   11.787234] 000  63985  <--
> [   11.787237] 001  63986
> [   11.787444] 002  63987
> [   11.787632] 003  63988
> [   11.787821] 004  63989
> [   11.788006] 005  63990
> [   11.788194] 006  63991
> [   11.788381] 007  63992
> [   11.788567] 008  63993
> [   11.788772] 009  63994
> [   11.788957] 010  63995
> [   11.789141] 011  63996
> [   11.789327] 012  63997
> [   11.789515] 013  63998
> [   11.789701] 014  63999
> [   11.789886] 015  64000

Does the error always occur at such a round idx value?

Here, 64000 == 0xFA00. Maybe coincidence but it's improbable enough to be interesting.

This debug code seems rather useful!

 -- Keir



> [   11.790068]
> [   11.790068] avail_head:
> [   11.790529] 000  075  <--
> [   11.790718] 001  036
> [   11.790890] 002  077
> [   11.791061] 003  129
> [   11.791231] 004  072
> [   11.791400] 005  130
> [   11.791574] 006  015
> [   11.791748] 007  074
> [   11.791918] 008  130
> [   11.792094] 009  130
> [   11.792263] 010  074
> [   11.792437] 011  015
> [   11.792617] 012  072
> [   11.792788] 013  129
> [   11.792961] 014  077    // The last two heads from guest to host: 077, 036
> [   11.793134] 015  036
> 
> [root@nvidia-grace-hopper-05 qemu.main]# cat /proc/vhost
> 
> avail_idx
> 000  63998
> 001  64000
> 002  63954  <---
> 003  63955
> 004  63956
> 005  63974
> 006  63981
> 007  63984
> 008  63986
> 009  63987
> 010  63988
> 011  63989
> 012  63992
> 013  63993
> 014  63995
> 015  63997
> 
> avail_head
> 000  074
> 001  015
> 002  072
> 003  129
> 004  074            // The last two heads seen by vhost is: 074, 036
> 005  036
> 006  075  <---
> 007  036
> 008  077
> 009  129
> 010  072
> 011  130
> 012  015
> 013  074
> 014  130
> 015  130
> 
> used_idx
> 000  64000
> 001  63882  <---
> 002  63889
> 003  63891
> 004  63898
> 005  63936
> 006  63942
> 007  63946
> 008  63949
> 009  63953
> 010  63957
> 011  63981
> 012  63990
> 013  63992
> 014  63993
> 015  63999
> 
> used_head
> 000  072
> 001  129
> 002  074          // The last two heads published to guest is: 074, 036
> 003  036
> 004  075  <---
> 005  036
> 006  077
> 007  129
> 008  072
> 009  130
> 010  015
> 011  074
> 012  130
> 013  130
> 014  074
> 015  015
> 
> Thanks,
> Gavin
> 
> 
> 
> 

