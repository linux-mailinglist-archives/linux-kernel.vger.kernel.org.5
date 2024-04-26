Return-Path: <linux-kernel+bounces-160078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1438B38C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051EA286598
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B956147C90;
	Fri, 26 Apr 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnQJ1dJI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61A147C7D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139106; cv=none; b=HHESYRqZ/3oe1TaMWRaZXD0wfmyH/uuxNOvNJxmEl32w0zPMGyOo0+wqR0TUxF3W79v2gLTdqGYsWyS3PdWCbcVcoxZ7YkxNLYOn8PS6KJYWaS01hC+cC1VPLP+aazxu0rqBPuGgopY31w2SmE0NKSZgb8rlaBxti1O8m6sC8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139106; c=relaxed/simple;
	bh=/wyjt9d4AZ8Mo8vzASxA6mAa3oblPdVQKxM3OHzZLF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTY14G5b/fzAIDrVbQMQiLgESci2sBlFUbo0C6ZJqqrh7J2zfsX9mMlWkdshxvDBYw0BXm0QriFa1Pm/0xRn25RaCSSsS7RoYJR/1L7LCu7JUd8zcHNBuZBGVHk0dkRrSxNCGVjNrgoI2I27x9rLzJl+HdSY92NMNsEfzs+4d9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnQJ1dJI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714139104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uF1kPlR2Ck3Z44kTNMrT7zanJ3tMGvooilBaXGx0yJc=;
	b=AnQJ1dJI3MtJ+7I0tkcWnraRJUBm9MW1uPpoAEPQpP6czxDrPrFfY2kGvbxe30YS501/Gb
	PSLgnbiOQZ/7zQJxoekoEhYqIxC3Za3r1Srf5f+U0V+3uinJqwqRjSzCEDqUXtxMa4WzCo
	R83vtPBuT6SQIbOeXPccWXoDQIHCLVo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-zuXsfHvVPbyEkwWJfe8mNQ-1; Fri, 26 Apr 2024 09:45:02 -0400
X-MC-Unique: zuXsfHvVPbyEkwWJfe8mNQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6eb607b308bso679389a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139102; x=1714743902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF1kPlR2Ck3Z44kTNMrT7zanJ3tMGvooilBaXGx0yJc=;
        b=Iobz5yBhZiSYdKsbW6FHz0dMpPxMAEm3ulP66gFLlLC5TD5I5ODBNJ0fzYKbD5B7cd
         ldeGD5wXxCJiVisX+q1YiEOnulO40iHl4B+oFVBKbKefH8oY5a262+PgBzurDgeg3fwZ
         8Ti8zRQ7X+AilQ5CKHLPZ1/OinBhQ1nV0SFN7iDJ4QcJj50th0rxXDfAsiKcYfD23Mx0
         9/j1BQ+fEImbVUr7PJpmUlO6YywYFeHT1d9eWFseRBs6O1h182XeXIl7/IkGtqOQdjHQ
         9cNFnTQpB0ocd/2GZdXW1e9T01qm1YNLmVLYvNL4I6YlR1iAjudEwMqcMHVBJTiBOiad
         SgYw==
X-Gm-Message-State: AOJu0YyhoUhnRxshZUxQyjbFcm0YjMtu2afkG9qOcLszno4PXMLNMI9J
	hu4LMkAbpUD+gsFrB2bpEWuV+5ZcyLqAMZlNaQ84NXDUJkKYt4Nf7dnVpn1zdE5J4KyOBUwonfS
	MuWXA+cHWtsgXe35quwl53+zDGu83MKCYLW9pNhgNsh5X+Yw+C2Yl0dOip1ejDQ==
X-Received: by 2002:a05:6808:d53:b0:3c5:f29a:5fda with SMTP id w19-20020a0568080d5300b003c5f29a5fdamr3101418oik.3.1714139101705;
        Fri, 26 Apr 2024 06:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzrxrCF28uWDRUo6q+zp4qFvioOS0q1e4hOagwn8iRvVD4UFCuaQuTxLkqj/Vp49yVezlG5g==
X-Received: by 2002:a05:6808:d53:b0:3c5:f29a:5fda with SMTP id w19-20020a0568080d5300b003c5f29a5fdamr3101360oik.3.1714139100964;
        Fri, 26 Apr 2024 06:45:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id w9-20020a0ca809000000b00696b1050be8sm6864026qva.133.2024.04.26.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:45:00 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:44:58 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 1/3] mm/gup: consistently name GUP-fast functions
Message-ID: <Ziuv2jLY1wgBITiP@x1n>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
 <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>

On Fri, Apr 26, 2024 at 09:17:47AM +0200, David Hildenbrand wrote:
> On 02.04.24 14:55, David Hildenbrand wrote:
> > Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> > all relevant internal functions to start with "gup_fast", to make it
> > clearer that this is not ordinary GUP. The current mixture of
> > "lockless", "gup" and "gup_fast" is confusing.
> > 
> > Further, avoid the term "huge" when talking about a "leaf" -- for
> > example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> > "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> > stays.
> > 
> > What remains is the "external" interface:
> > * get_user_pages_fast_only()
> > * get_user_pages_fast()
> > * pin_user_pages_fast()
> > 
> > The high-level internal functions for GUP-fast (+slow fallback) are now:
> > * internal_get_user_pages_fast() -> gup_fast_fallback()
> > * lockless_pages_from_mm() -> gup_fast()
> > 
> > The basic GUP-fast walker functions:
> > * gup_pgd_range() -> gup_fast_pgd_range()
> > * gup_p4d_range() -> gup_fast_p4d_range()
> > * gup_pud_range() -> gup_fast_pud_range()
> > * gup_pmd_range() -> gup_fast_pmd_range()
> > * gup_pte_range() -> gup_fast_pte_range()
> > * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> > * gup_huge_pud()  -> gup_fast_pud_leaf()
> > * gup_huge_pmd()  -> gup_fast_pmd_leaf()
> > 
> > The weird hugepd stuff:
> > * gup_huge_pd() -> gup_fast_hugepd()
> > * gup_hugepte() -> gup_fast_hugepte()
> 
> I just realized that we end up calling these from follow_hugepd() as well.
> And something seems to be off, because gup_fast_hugepd() won't have the VMA
> even in the slow-GUP case to pass it to gup_must_unshare().
> 
> So these are GUP-fast functions and the terminology seem correct. But the
> usage from follow_hugepd() is questionable,
> 
> commit a12083d721d703f985f4403d6b333cc449f838f6
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Mar 27 11:23:31 2024 -0400
> 
>     mm/gup: handle hugepd for follow_page()
> 
> 
> states "With previous refactors on fast-gup gup_huge_pd(), most of the code
> can be leveraged", which doesn't look quite true just staring the the
> gup_must_unshare() call where we don't pass the VMA. Also,
> "unlikely(pte_val(pte) != pte_val(ptep_get(ptep)" doesn't make any sense for
> slow GUP ...

Yes it's not needed, just doesn't look worthwhile to put another helper on
top just for this.  I mentioned this in the commit message here:

  There's something not needed for follow page, for example, gup_hugepte()
  tries to detect pgtable entry change which will never happen with slow
  gup (which has the pgtable lock held), but that's not a problem to check.

> 
> @Peter, any insights?

However I think we should pass vma in for sure, I guess I overlooked that,
and it didn't expose in my tests too as I probably missed ./cow.

I'll prepare a separate patch on top of this series and the gup-fast rename
patches (I saw this one just reached mm-stable), and I'll see whether I can
test it too if I can find a Power system fast enough.  I'll probably drop
the "fast" in the hugepd function names too.

Thanks,

-- 
Peter Xu


