Return-Path: <linux-kernel+bounces-134624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71989B3CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A8B22382
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA63D569;
	Sun,  7 Apr 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itvcH/o/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1D3BBE9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517607; cv=none; b=BZiGdrgncKBq7ZwnaeRVD84mv5ColJMCTXJBsJt10MqKumCQG/mepkqV5nyiZLu8xa3RS4cbu1nrEGaiwXDSpECJn4LpE938yaCI6TzTSqB/RYzJnc77DxlGOE7//VsrwlDMuJmcG97Uuca+HjZ9g2qXmJxGTxpuntCuBbjxtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517607; c=relaxed/simple;
	bh=yKUf9+eI9dHg7NMd2gkSCi29eY0g+VVpaWcKMEypZ50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA0I3yoPJ2kjwMB4X7l0nf8DLMYOGXR7fqsaCReWXxRdmS5a3cIODL/lvb19arRQaeN5aakJaMzvGzDRUdtg/hOIOI0SF57gbg/BrdA78B10qNr9DP+zdsAcjNTv+zXN+OLwgviRyej2rT+Qo+GzJ1+AT6YaJEAVCWuBmnlHboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itvcH/o/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712517604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epmQzRcGvXH7QxC5v7WEbN06GWyO/3oH4p1c8L2F2xA=;
	b=itvcH/o/mX1rb0jBNgEpD3Jrw24ZOZ1CBw52kpj9PAv3fs1suCKcvlgT2LIBN0AY4ZOnTW
	+EulL+6vdvtxGocQH1ktCC0nF3nsTY+sWHuUV5xstdxEC7oQgjbdmPRSun9Msh93o0k3+2
	220765E5RWv481TqBHI33tZCU3/UyZs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-DmeTXL_zO4OPVUwo4afsWw-1; Sun, 07 Apr 2024 15:20:00 -0400
X-MC-Unique: DmeTXL_zO4OPVUwo4afsWw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6993921ae18so3430086d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 12:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712517599; x=1713122399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epmQzRcGvXH7QxC5v7WEbN06GWyO/3oH4p1c8L2F2xA=;
        b=tAKOxsvo2yN/iaZbAQPY1crseZXHGRL1uuIV97SilpNlWwgQClCjY1mXiDT+tZuh36
         WmRkW5JKHFmbT1cF8rzN/sikuc7brD9XL0DuSg/Q7Ms3umfintObmHOkF31qQyPrJjYk
         hjBOA8nD71YpOj2BXhdoBGClyb6hDvdllLT/nxsyzAK52cA6iiYMliPIZDodgR3f8FVE
         yddbYNE0sLC+rVuBaeKEHxbG0bKVe96Z3Bo3ba/QBMk20lKIrPtS5J81269aoszp0zad
         Oslrc3B+RgIS890zLFb5NKau0PkLhOMujC5jZEOChaq/VaFi8qaod9/mi8FgEs0OUylF
         TpSg==
X-Forwarded-Encrypted: i=1; AJvYcCV6qtWO+8nKuNRxUq/mpnZddWvampyRqJe27AVRLGslJaeJL3olt/SnjjxgFL3MUbbW16/kYZ1D+HzqOswEvarUbUsMFHGqJP32gRrN
X-Gm-Message-State: AOJu0YxDu9xcs0j/g/O6YiA29C+GF8qouvZWTYwgiO4SoMKxWgZrcFm4
	NHaeWavCj9GotcQVe4iRDuxHax8c0U4JQewBazO2xessupi/TzkQItCLqY+2XfwE0frIBuNp1RA
	nM588AfAa4m6rpgAHZe7dD9s2tNcGvkRP+yCHxvhvOcyJTQaMj8t2VYH4gSHPUQ==
X-Received: by 2002:a05:6214:2408:b0:699:2d88:744f with SMTP id fv8-20020a056214240800b006992d88744fmr7791716qvb.4.1712517599493;
        Sun, 07 Apr 2024 12:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdyfcCTiDHVrnBYdH/QV6bU53cJSUCzy2yWOpLwTRXIDtNac8PNjf55b5kNOa6A1BTkng8Qg==
X-Received: by 2002:a05:6214:2408:b0:699:2d88:744f with SMTP id fv8-20020a056214240800b006992d88744fmr7791699qvb.4.1712517598978;
        Sun, 07 Apr 2024 12:19:58 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id do18-20020a056214097200b0069942d4cc06sm2111164qvb.115.2024.04.07.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 12:19:58 -0700 (PDT)
Date: Sun, 7 Apr 2024 15:19:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
Message-ID: <ZhLx3fwzQNPDbBei@x1n>
References: <20240407130537.16977-1-osalvador@suse.de>
 <ZhKmAecilbb2oSD9@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhKmAecilbb2oSD9@localhost.localdomain>

On Sun, Apr 07, 2024 at 03:56:17PM +0200, Oscar Salvador wrote:
> On Sun, Apr 07, 2024 at 03:05:37PM +0200, Oscar Salvador wrote:
> > Tony reported that the Machine check recovery was broken in v6.9-rc1,
> > as he was hitting a VM_BUG_ON when injecting uncorrectable memory errors
> > to DRAM.
> > After some more digging and debugging on his side, he realized that this
> > went back to v6.1, with the introduction of 'commit 0d206b5d2e0d ("mm/swap: add
> > swp_offset_pfn() to fetch PFN from swap entry")'.
> > That commit, among other things, introduced swp_offset_pfn(), replacing
> > hwpoison_entry_to_pfn() in its favour.
> > 
> > The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(),
> > but is_pfn_swap_entry() never got updated to cover hwpoison entries, which
> > means that we would hit the VM_BUG_ON whenever we would call
> > swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM set.
> > Fix this by updating the check to cover hwpoison entries as well, and update
> > the comment while we are it.
> > 
> > Reported-by: Tony Luck <tony.luck@intel.com>
> > Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")

Totally unexpected, as this commit even removed hwpoison_entry_to_pfn().
Obviously even until now I assumed hwpoison is accounted as pfn swap entry
but it's just missing..

Since this commit didn't really change is_pfn_swap_entry() itself, I was
thinking maybe an older fix tag would apply, but then I noticed the old
code indeed should work well even if hwpoison entry is missing.  For
example, it's a grey area on whether a hwpoisoned page should be accounted
in smaps.  So I think the Fixes tag is correct, and thanks for fixing this.

Reviewed-by: Peter Xu <peterx@redhat.com>

> > Cc: <stable@vger.kernel.org> # 6.1.x
> 
> I think I need to clarify why the stable.
> 
> It is my understanding that some distros ship their kernel with
> CONFIG_DEBUG_VM set by default (I think Fedora comes to my mind?).
> I am fine with backing down if people think that this is an
> overreaction.

Fedora stopped having DEBUG_VM for some time, but not sure about when it's
still in the 6.1 trees.  It looks like cc stable is still reasonable from
that regard.

A side note is that when I'm looking at this, I went back and see why in
some cases we need the pfn maintained for the poisoned, then I saw the only
user is check_hwpoisoned_entry() who wants to do fast kills in some
contexts and that includes a double check on the pfns in a poisoned entry.
Then afaict this path is just too rarely used and buggy.

A few things we may need fixing, maybe someone in the loop would have time
to have a look:

- check_hwpoisoned_entry()
  - pte_none check is missing
  - all the rest swap types are missing (e.g., we want to kill the proc too
    if the page is during migration)
- check_hwpoisoned_pmd_entry()
  - need similar care like above (pmd_none is covered not others)

I copied Naoya too.

Thanks,

-- 
Peter Xu


