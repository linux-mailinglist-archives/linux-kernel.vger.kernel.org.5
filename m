Return-Path: <linux-kernel+bounces-131606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426B8989FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2328216A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63D12AAC7;
	Thu,  4 Apr 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVZM3zLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC3129A74
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240490; cv=none; b=KOsvXMKT1JT26rs/hBWg6srnh1+Zn/ex0tHzkMxeeqe13N68ufSCRikxBxVuKbNg47IiWFcm/mZEy0OgMVt3j5aDIwFLtPO2zhot/BP/a+ZGrjT/+0LGqFwOwtIZPotBjhGXvVRfttFz3o7o1oIuUIBi7lh/NTOHB15MZ8fogp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240490; c=relaxed/simple;
	bh=uZs9vFWiBVwL0RNEsVNDtCzUyXIvEgWlKme4WB6s9cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNmTAlGuY4P+auUE6Sg3hoo5NXtgmchuIK/xzO3dKX+7cp1WD7uo51qaRf/7/3br1KyN0GhTigEmonDqkTvW6GWIC12UyU8dHCI8JYKmQxLKk6TdoUeZIcnrTCOaFySlNS1q2tuihI/4C/rNHSH8sdG1me4ueVZab0fyx0PKg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVZM3zLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712240488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtUY7Ryd2UNJdbdMjsCmGsf3yGM88gtp0MfZqJx3q0c=;
	b=FVZM3zLkuzHDbixk0sVRmAQJqZ8yqn1Y8yXsSVrvkdGTaGCiMTO9B+XUVqq6969+fnyBaE
	0NT6peKSxPQInoOpTxkE6Y94OkIYdp9O6ZG75EHWguMsIb0Bb+NFpUT/fqZul5wHhsSYpb
	eNzxzQVNmvWbbMO2zHewDkGSLrg4suk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-RKRQPkDYPIGX6daImIW-Xg-1; Thu, 04 Apr 2024 10:21:26 -0400
X-MC-Unique: RKRQPkDYPIGX6daImIW-Xg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430c9bbe925so1636151cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240486; x=1712845286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtUY7Ryd2UNJdbdMjsCmGsf3yGM88gtp0MfZqJx3q0c=;
        b=TK4G0fhyzV+gGGjU5JqgGk6tcoh2fNWf0432YnIX81zw8BH1Sz41ttc4QaZWihmcLn
         g44crqH/dDpJ2jCNMHfGnI+lvcJjwd3yHhoEVdC/H+rDBOUOLR8C4ocxo26gsB/IqG8Y
         TOszmrzQAjvobb9/q+LGru+G8uRZeV1puQV9eKgXCb5gjT7vHRtd4dhVhsegQCkDOVAM
         OD6h2AAfRk7yKsrIUl0U/isArw/ja/hRaXcucu/PXjYSbvC1cABRCDMRA+AolROW/WjV
         CDwsmAAkTXShTFbkgZOzHieuybqgJBFjc91UHc9G9LyFu2+G3j/QoXuQHZQBlEPeimRo
         Wzxw==
X-Forwarded-Encrypted: i=1; AJvYcCWrK2HWLKY3/HPvtHXE8qpQY+793BnrY0GGOXU92UQNLO3GYGwuKZb42+Qdw1wM5pOQiIoofZGsRNH464UK1KsCMDNMCohiBu5/HBIC
X-Gm-Message-State: AOJu0YzbghBkh9n3Ke/eSQY2Oj7ZZDekrLAf6mRCUuo2m26qXyg1/k7u
	D33PoDFw0W0mWZgWQALrWvbPsjp3aWtrR0s9nLEg2W8q+6+Mue7GvJ6O0BmWE0UvEh4sfQ5E3ly
	V+/1+NzXSdMLM0SMTIvMNT0JeAOj3+ig47uCOR9Jvg+uUWPr3iBnfBE+P6vge6Q==
X-Received: by 2002:ac8:5c8a:0:b0:431:810c:a96e with SMTP id r10-20020ac85c8a000000b00431810ca96emr2500149qta.1.1712240485559;
        Thu, 04 Apr 2024 07:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhRpq+S4LQZCpwLVYW+GY9j4DweRYw1JwLI2Ay6RMPXkR0iYHpJNomz2Qmf2zJxRBaHVxPfw==
X-Received: by 2002:ac8:5c8a:0:b0:431:810c:a96e with SMTP id r10-20020ac85c8a000000b00431810ca96emr2500097qta.1.1712240484909;
        Thu, 04 Apr 2024 07:21:24 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05622a558f00b0043439982526sm2514858qtb.22.2024.04.04.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:21:24 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:21:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
Message-ID: <Zg63YZaXqYdSLHG-@x1n>
References: <20240403013249.1418299-1-peterx@redhat.com>
 <20240403013249.1418299-2-peterx@redhat.com>
 <Zg3u5Sh9EbbYPhaI@casper.infradead.org>
 <Zg6vFtciZAl4SQHW@x1n>
 <Zg6z4ZEt7rbILgl8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg6z4ZEt7rbILgl8@casper.infradead.org>

On Thu, Apr 04, 2024 at 03:06:25PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 09:45:58AM -0400, Peter Xu wrote:
> > On Thu, Apr 04, 2024 at 01:05:57AM +0100, Matthew Wilcox wrote:
> > > 	if (PageHuge(page))
> > > 		page = compound_head(page);
> > 
> > I would think PageHead() check would help us to avoid compound_head() on
> > heads, which should still be the majority cases iiuc (assuming page->flags
> > is already around in the cache anyway).  I've no strong opinion though, as
> > I can hardly tell a difference in reality.
> 
> compound_head() includes a check for PageHead().  Adding the check just
> makes things slower.

They check different fields (compound_head, offset 0x8 for the former).
Again I'm ok with either way to go and I don't expect measurable
difference.. so if you prefer this I'm happy with it too.

Andrew, could you help update with Matthew's fixup?  The comment is
definitely better than what I wrote in all cases.

Thanks,

-- 
Peter Xu


