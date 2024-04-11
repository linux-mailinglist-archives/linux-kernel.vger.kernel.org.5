Return-Path: <linux-kernel+bounces-141304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346708A1C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF36A1F28675
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484915F402;
	Thu, 11 Apr 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISpH3VVU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B815F3EC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852144; cv=none; b=jNtYj4LGQDKRAZA08J4wo/acRSPKbSV852XZdCVbcwxzrSFjDrcdmyIq70LAmkQwZOn92DC9CyqZDeslfuZtoTPPGXmx4t1Duu44gqkAzK/ceXAqEC+rPJh2sxDJZMU9bMTvmciGvqsEIR+EzKOpTPPdANbOPGDnQpDrZlKPxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852144; c=relaxed/simple;
	bh=tdZgX5nfBuYfMPaNrv80HJY9z415EFRiBOih/5/8FZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onn9SkIb7BloSbSTtkUqa3tNAvX+/qIOR2pRWRctHmEJoCb2XdB7vj9kFVkGg+8XKynUjABVrrc5A2UVGGxUGlHP+dYSLHLjbcKfcLNv/nt8km7F5J2fzsvbiXHA0q+07SjLysW4K7PG/q0LKd24/psKECQhsqmPX9k96jALcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISpH3VVU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712852142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZmlfwQwEwqX8N6AuyRgtrgEEEIO7a43RiQoCYN1PMM=;
	b=ISpH3VVUbcrbPvxbJI0k5w9kiSbUFQibRu6ac3nrfCKLDMHiuCyb9ZFTU5WfnxGSxP3mMc
	fXG2lI2eIqzyMwAe8bBYbnIQml9Zc0JrX9ei8WnMIwUfh6xHOdVQlRzUK/xQ1IDEmMjFh4
	pW45RLXPK3m6mzag7XTlhO0W02cyjBE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-nq2w6T9CO8-2H_oyBWd4jA-1; Thu, 11 Apr 2024 12:15:40 -0400
X-MC-Unique: nq2w6T9CO8-2H_oyBWd4jA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ea19a84c22so10646a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852140; x=1713456940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZmlfwQwEwqX8N6AuyRgtrgEEEIO7a43RiQoCYN1PMM=;
        b=JnOr0W/uFbnSh3xonLKIZ6vgQVWC8WP26btzO8uqZpUB7IZZKp4NSHYgzoUsK1RORU
         p1nNPxsni8IvOOq6ZzUfXku9Aak+ywqay5of6bD2t3M7e/F6+MhlASwPgXvgJ+H475Hi
         ZS6GoYIXT8eQ322Ox98zxGSUyTSu5AK7tPa3SB1spR7/bZBRVQpu/lB+3xFlWtPUOXEn
         YZWlhlclh9qQHlz982o03trwP1AIXLOuSQEu8r/YhT5czA6PkmM0w7Jy0SgyCZjE8MDX
         ude7Djr9zuP7jHdU5ccW7nbHop/Ta38/J1Mn9En0wadFjNS0p7lhv8GkXKtTtrzaaeBy
         egOA==
X-Forwarded-Encrypted: i=1; AJvYcCWQgALrjtBjqT+KPeKp9MTQlYE4V8TfLG4EiK6vyWlrEkkW9pI8x88BHvgJuxO1xE6jIRlez06BtVWz+X3/4SMpnylfaL9pXaUIMJy8
X-Gm-Message-State: AOJu0YxGDjmZMvx87I5HSJMjs6O7Gl4sy+wpPYCz4CazmjQYbbm344Dc
	UoP69WBLYClo1FnbQIho7n2qIaJ9khAfJvPONBO6oDNiTf88YMocrRvFbb9A75Umu0yJzuLA6L3
	ko3294gTbp3AI3flnmDnrM7KBSrQLU0riZRPTWh3w8Sr4BLuqvYFTX3eMwNpPrSLy26Mz4w==
X-Received: by 2002:a05:6870:7183:b0:222:81cc:ac9c with SMTP id d3-20020a056870718300b0022281ccac9cmr6146576oah.5.1712852139658;
        Thu, 11 Apr 2024 09:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHX6QtF5SydubwLrtRDzMOYoSKh757kSXH1BgbFRQt1iTYEViuMR5roQkhSWQN8EQKuvV3vQ==
X-Received: by 2002:a05:6870:7183:b0:222:81cc:ac9c with SMTP id d3-20020a056870718300b0022281ccac9cmr6146547oah.5.1712852139258;
        Thu, 11 Apr 2024 09:15:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id bi36-20020a05620a31a400b0078d677e72f3sm1195367qkb.118.2024.04.11.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:15:38 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:15:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/8] Reimplement huge pages without hugepd on powerpc
 8xx
Message-ID: <ZhgMqF7SNaISrYMJ@x1n>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
 <20240325163840.GF6245@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325163840.GF6245@nvidia.com>

On Mon, Mar 25, 2024 at 01:38:40PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2024 at 03:55:53PM +0100, Christophe Leroy wrote:
> > This series reimplements hugepages with hugepd on powerpc 8xx.
> > 
> > Unlike most architectures, powerpc 8xx HW requires a two-level
> > pagetable topology for all page sizes. So a leaf PMD-contig approach
> > is not feasible as such.
> > 
> > Possible sizes are 4k, 16k, 512k and 8M.
> > 
> > First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
> > must point to a single entry level-2 page table. Until now that was
> > done using hugepd. This series changes it to use standard page tables
> > where the entry is replicated 1024 times on each of the two pagetables
> > refered by the two associated PMD entries for that 8M page.
> > 
> > At the moment it has to look into each helper to know if the
> > hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
> > a lower size. I hope this can me handled by core-mm in the future.
> > 
> > There are probably several ways to implement stuff, so feedback is
> > very welcome.
> 
> I thought it looks pretty good!

I second it.

I saw the discussions in patch 1.  Christophe, I suppose you're exploring
the big hammer over hugepd, and perhaps went already with the 32bit pmd
solution for nohash/32bit challenge you mentioned?

I'm trying to position my next step; it seems like at least I should not
adding any more hugepd code, then should I go with ARCH_HAS_HUGEPD checks,
or you're going to have an RFC soon then I can base on top?

Thanks,

-- 
Peter Xu


