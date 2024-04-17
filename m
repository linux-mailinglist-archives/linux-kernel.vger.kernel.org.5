Return-Path: <linux-kernel+bounces-149104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241F8A8BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349381C216CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEA224C9;
	Wed, 17 Apr 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGXC1drg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52211712
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381136; cv=none; b=e1cOpU5zLQMM74KOPA87b4/cTM1ddfnFS5EAnsDT0YgzREOhPUgJfHKHwTBXHRJtiBRadosO3s7vdhpUrkX5MdcinLEMjb6nJdTsyj1smXIPm/WuUAuYT3LlfTZm1BZ2VnFArLQqcjtIqeqaFqga7FdRKOaRdgti54MU4fBKN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381136; c=relaxed/simple;
	bh=0eEkIlTNdlmfs/h66baTKIDxetw4BgQ3T4jC0D0DQQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOaRdfT2XDGF0Xa0SkQglQMveeNfoOurQ4SYFj8eQhglqyUbWSVQ18I9NONhkFO2znNFy0Vhi0L9shORnhoJWcm19LY7EU7MwDzp8j0fJo+3lfP0m7sX1VBOUYRBmvjsgM05/ukX9EuEyntRsKWtw3G8ts3RBnuZVOWhfnR/rcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGXC1drg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713381133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uyV2nt6VGCml1aWddapRV5SNU2xzjc9vNFI97N9VRvg=;
	b=RGXC1drgN4PK1kQ2TcmitwNRIvHluzWf7zMPY49CEHNn0wvxyAsnjbtnzpVxz1hC7wj96q
	6qR8jxT+UuNahW+9gXqOGJ9/lNVouS31g/GpJoRqOvNQu3WT2rnLBXeShQKNV4eSaO2s/t
	oHOUnmeIKd106XJOfjYlhkAwo1NbVuE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-of48R0EJP1iUY2abDokt-Q-1; Wed, 17 Apr 2024 15:12:12 -0400
X-MC-Unique: of48R0EJP1iUY2abDokt-Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c7128fc6c7so5549b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381131; x=1713985931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyV2nt6VGCml1aWddapRV5SNU2xzjc9vNFI97N9VRvg=;
        b=lV3mjUjWaxmX/rwXjupkB+DEOtGGjwJ39r2plPpL132zCqUX1GM4NyHecYIKOunedC
         GwrDmT/xWzeIUfQXT+PKZ/o/JNU7OjwCt7ikpPuJ6lFS6AhAK36PGeW8F2iQ1ZObGLwh
         PBFKR+rrKfrV5DXxSyhX2r4L/MqROTc8tshXJWNtEGlaWnHh1mpVrclCg2ZR0typJgyO
         5/ypUTUEeu5a9CGWiIYKXcBGNFfrTT8VeDOHfsqcpBpXA/R/HIrcsHkerjNbK459xoLq
         JgMZgW5a+ugk1V/YQE4dyHcqO3G70V+i0lJX1o7Qqj0gmw8iUker7NURi13RtZ5mBWEt
         l16Q==
X-Gm-Message-State: AOJu0YzW/lGpSkUaZRSKtdqLBJt2y/nLjyd4wA+32JUJSsVnufm2EF+n
	3E9GT7Zrfuq8k3TmnW1cnSq0eKuTCH1Liafe/SXJI8GT/3mqYBi9Np4THY8fnLLbZo4jjyKjuDG
	epA86g5p6y2aY8iNLt2ybaaVgCbUMLr6FGL+W52RejU78gRZQVDb+3cYj/+XlrEBu2BilYNBR4R
	47J24E3FOTdi10Sm/of94pflJu2DfjDaa+7Ziz+wUtWfQ=
X-Received: by 2002:a05:6808:3007:b0:3c7:2f77:a113 with SMTP id ay7-20020a056808300700b003c72f77a113mr616702oib.2.1713381130691;
        Wed, 17 Apr 2024 12:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3tN6BkA06myLYk1eHParwrD4vGShPlY9JzOOpHlrfyyaQLIRadz9GvCDLC0D9lNpQ94kiQA==
X-Received: by 2002:a05:6808:3007:b0:3c7:2f77:a113 with SMTP id ay7-20020a056808300700b003c72f77a113mr616663oib.2.1713381130093;
        Wed, 17 Apr 2024 12:12:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id kr5-20020ac861c5000000b00437794a29aesm595880qtb.71.2024.04.17.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 12:12:09 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:12:07 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/page_table_check: Support userfault wr-protect
 entries
Message-ID: <ZiAfB9UI3TYgIXgX@x1n>
References: <20240417185217.2667853-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417185217.2667853-1-peterx@redhat.com>

On Wed, Apr 17, 2024 at 02:52:17PM -0400, Peter Xu wrote:
> Allow page_table_check hooks to check over userfaultfd wr-protect criteria
> upon pgtable updates.  The rule is no co-existance allowed for any writable
> flag against userfault wr-protect flag.
> 
> This should be better than c2da319c2e, where we used to only sanitize such
> issues during a pgtable walk, but when hitting such issue we don't have a
> good chance to know where does that writable bit came from [1], so that
> even the pgtable walk exposes a kernel bug (which is still helpful on
> triaging) but not easy to track and debug.
> 
> Now we switch to track the source.  It's much easier too with the recent
> introduction of page table check.
> 
> There are some limitations with using the page table check here for
> userfaultfd wr-protect purpose:
> 
>   - It is only enabled with explicit enablement of page table check configs
>   and/or boot parameters, but should be good enough to track at least
>   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
>   x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
>   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], which
>   is similar.
> 
>   - It conditionally works with the ptep_modify_prot API.  It will be
>   bypassed when e.g. XEN PV is enabled, however still work for most of the
>   rest scenarios, which should be the common cases so should be good
>   enough.
> 
>   - Hugetlb check is a bit hairy, as the page table check cannot identify
>   hugetlb pte or normal pte via trapping at set_pte_at(), because of the
>   current design where hugetlb maps every layers to pte_t... For example,
>   the default set_huge_pte_at() can invoke set_pte_at() directly and lose
>   the hugetlb context, treating it the same as a normal pte_t. So far it's
>   fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() as
>   long as supported (x86 only).  It'll be a bigger problem when we'll
>   define _PAGE_UFFD_WP differently at various pgtable levels, because then
>   one huge_pte_uffd_wp() per-arch will stop making sense first.. as of now
>   we can leave this for later too.
> 
> This patch also removes commit c2da319c2e altogether, as we have something
> better now.
> 
> [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/
> 
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Rename __page_table_check_pxx() to page_table_check_pxx_flags(),
>   meanwhile move the pte check out of the loop [Pasha]
> - Fix build issues reported from the bot, also added SWP_DEVICE_WRITE which
>   was overlooked before

I forgot to update the docs, sorry.  I'll send v3.

-- 
Peter Xu


