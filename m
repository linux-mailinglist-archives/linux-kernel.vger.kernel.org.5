Return-Path: <linux-kernel+bounces-142839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7258A30B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409C7281C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC6131BDF;
	Fri, 12 Apr 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDtYIR1n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C278131743
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932264; cv=none; b=Un2UZNMYnuC5lRflQEef+U3iquMLae5NuoNpmFTvSdIIELNWy0v6Wajf58QecnT0OsXJu51FNRGjBmykkYHr+1Z0RkDk9cvXvdwLDtU8QrX32MH7xNMa29cqkuQPVmfHF7caoVYLNI7755Bf9eKGDjZUIxJRTPnxQuua8th6XkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932264; c=relaxed/simple;
	bh=4ThYEYhUvaUw47UOcMLMS+Cxo5AyCYFbSUoKwVf4WDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU1y+zpZxVAvMfraRSHgaFDd3nMtKnOJB+bY3EAZqattVEQLB2LPbvWgk8LokcN/ZjKHf2x1FJW7SVvv/Krl1MgGa63CYhL517f2youhJJiG3DVlzjg9/SMqHsP/lKX1/RSNgSPrMZUQL3iTruAOzS2TP/1yKEocnVzMook8w6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDtYIR1n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712932262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gvIPcFWYwEFpmmOj32QPWexxorRFZ+mmSvRstzL0kU=;
	b=XDtYIR1n6iSdsHvy27IMipSEjegKy7mTt+VV//kPOF1q4J/Sq/IPfKMz0iSkjgiSZEnDtT
	4lO7VGc8btICl27LRX0UznS986E28Yi8IUpPS6uPqeTLiv3pSJIShmJla3jPTzTu6GJiEH
	MfrvLl2I38HmbD9oqLVy+l2II0R5ciA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-ICkwcvEENz-EzRue954cwA-1; Fri, 12 Apr 2024 10:31:01 -0400
X-MC-Unique: ICkwcvEENz-EzRue954cwA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-436507937ecso3033981cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932260; x=1713537060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gvIPcFWYwEFpmmOj32QPWexxorRFZ+mmSvRstzL0kU=;
        b=XmV6KeaiWbZ0K1U7b9tORbXGD7dZpzT+BELEwgqSpTWA6k6Ihj6FeO/HFnXt4OJZ6O
         uHtTLWx+0hzI5BtQejh/t9/04vBZL4QDDK6Z9FyAb33Ve9SK8acHRIG+SIqru6HM/gWL
         RpXrXO2YGsmOqmAsqUbdwdrjjE71mEr7rqP4t7yxxw8+y1R92VpxjDuaKaA91QnkuYbl
         7VCqZp9GTiibW1ubY+VWhg/zSvc1yjmDdKhG6y5owFzmYK4HK0lmQtNC+w4WmfUKFWjA
         il7utR0cOeOJG9xSDipLWurGlIYwol/I4dltxY5hO0ejv3lAUZQfgddyyJoUBED+UL0q
         +2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVeWemLoyT1Ty9ahKrMOs+wl072YNcub8YQCPcj3NDNvn3S41HuJki9FmbO1uey/POR/X466qhlbVKBWRxdGUS6Ww+QjgxLkMBJIvrZ
X-Gm-Message-State: AOJu0YwUFOwBwjp5fM233CXHrTO5MRz9azCqbl1SUnRDpqEntMZyVdL8
	G+0rmq57DopmaepMTs9fwX7XddhYTAg1ZQ16hf1oQgEkwHr4FkGIMKhaWUtaurtz0KbGWl+DWje
	hJG9WJhSdfQHB+wWwnp8MliXm1vceEroDsx62cFvMMOuQruvteasx1EgzZQCie1T+RBaXRQ==
X-Received: by 2002:a05:6214:27ec:b0:699:1c74:bd54 with SMTP id jt12-20020a05621427ec00b006991c74bd54mr3044510qvb.3.1712932260275;
        Fri, 12 Apr 2024 07:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDgbuVeaiYa+iRpf0cfy8PiIaqZ4WRcM9oHh6Gsf+qbEBfhxoFcZIHBXMGQOqhTvyFuTiFRw==
X-Received: by 2002:a05:6214:27ec:b0:699:1c74:bd54 with SMTP id jt12-20020a05621427ec00b006991c74bd54mr3044473qvb.3.1712932259555;
        Fri, 12 Apr 2024 07:30:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id r26-20020a0c9e9a000000b0069b5c6f074bsm514693qvd.112.2024.04.12.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:30:59 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:30:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 0/8] Reimplement huge pages without hugepd on powerpc
 8xx
Message-ID: <ZhlFokakZo3c90C6@x1n>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
 <20240325163840.GF6245@nvidia.com>
 <ZhgMqF7SNaISrYMJ@x1n>
 <d236ce4a-1dde-4ee9-8cef-fe96242c2f4b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d236ce4a-1dde-4ee9-8cef-fe96242c2f4b@csgroup.eu>

On Fri, Apr 12, 2024 at 02:08:03PM +0000, Christophe Leroy wrote:
> 
> 
> Le 11/04/2024 à 18:15, Peter Xu a écrit :
> > On Mon, Mar 25, 2024 at 01:38:40PM -0300, Jason Gunthorpe wrote:
> >> On Mon, Mar 25, 2024 at 03:55:53PM +0100, Christophe Leroy wrote:
> >>> This series reimplements hugepages with hugepd on powerpc 8xx.
> >>>
> >>> Unlike most architectures, powerpc 8xx HW requires a two-level
> >>> pagetable topology for all page sizes. So a leaf PMD-contig approach
> >>> is not feasible as such.
> >>>
> >>> Possible sizes are 4k, 16k, 512k and 8M.
> >>>
> >>> First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
> >>> must point to a single entry level-2 page table. Until now that was
> >>> done using hugepd. This series changes it to use standard page tables
> >>> where the entry is replicated 1024 times on each of the two pagetables
> >>> refered by the two associated PMD entries for that 8M page.
> >>>
> >>> At the moment it has to look into each helper to know if the
> >>> hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
> >>> a lower size. I hope this can me handled by core-mm in the future.
> >>>
> >>> There are probably several ways to implement stuff, so feedback is
> >>> very welcome.
> >>
> >> I thought it looks pretty good!
> > 
> > I second it.
> > 
> > I saw the discussions in patch 1.  Christophe, I suppose you're exploring
> > the big hammer over hugepd, and perhaps went already with the 32bit pmd
> > solution for nohash/32bit challenge you mentioned?
> > 
> > I'm trying to position my next step; it seems like at least I should not
> > adding any more hugepd code, then should I go with ARCH_HAS_HUGEPD checks,
> > or you're going to have an RFC soon then I can base on top?
> 
> Depends on what you expect by "soon".
> 
> I sure won't be able to send any RFC before end of April.
> 
> Should be possible to have something during May.

That's good enough, thanks.  I'll see what is the best I can do.

Then do you think I can leave p4d/pgd leaves alone?  Please check the other
email where I'm not sure whether pgd leaves ever existed for any of
PowerPC.  That's so far what I plan to do, on teaching pgtable walkers
recognize pud and lower for all leaves.  Then if Power can switch from
hugepd to this it should just work.

Even if pgd exists (then something I overlooked..), I'm wondering whether
we can push that downwards to be either pud/pmd (and looks like we all
agree p4d is never used on Power).  That may involve some pgtable
operations moving from pgd level to lower, e.g. my pure imagination would
look like starting with:

#define PTE_INDEX_SIZE	PTE_SHIFT
#define PMD_INDEX_SIZE	0
#define PUD_INDEX_SIZE	0
#define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)

To:

#define PTE_INDEX_SIZE	PTE_SHIFT
#define PMD_INDEX_SIZE	(32 - PMD_SHIFT)
#define PUD_INDEX_SIZE	0
#define PGD_INDEX_SIZE	0

And the rest will need care too.  I hope moving downward is easier
(e.g. the walker should always exist for lower levels but not always for
higher levels), but I actually have little idea on whether there's any
other implications, so please bare with me on stupid mistakes.

I just hope pgd leaves don't exist already, then I think it'll be simpler.

Thanks,

-- 
Peter Xu


