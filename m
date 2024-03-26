Return-Path: <linux-kernel+bounces-119947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6988CF3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD33B1C32BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D0712B156;
	Tue, 26 Mar 2024 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7SvCAom"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F7745E4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485807; cv=none; b=oOUaAzGimI4zWHrXi3VC5ik6bGneqkg8BdTlEoiG47gcuXcGMzwwxMN2anTjnhiF2/Q2NTZgxPhW4uKUKM+O3FGlBw/ut1JHUmD8e0Qc+0EixUbxB1CfmGgnkUdoL2cNh2KDGOi1aHiWwhtlTGd5AAZNT6uvQtz8psxHXVX5whY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485807; c=relaxed/simple;
	bh=xpgv3sgDQ7rpy8eSB8hXWoT4c/rHDCJv082+mAKX/Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol6WAPFFYJ/DMhodfCjrTZaMEJt3NdqRP6RqoPLSheHftbFmv5mLL0dc4KPbju22GzfeXc31BytBYwpF8GEkGgLvb54Cyb/qFeTzbswmbw+dn1V1erIGlHRBsXrvSYfg0zZg5CHDdflBN07qKFGiyc55XuNbeSS1jUEvBjWYfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7SvCAom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711485805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7bjw/hteF8djmOoWPYQb6GfOlzxEGXIn8a6dn1jJ20=;
	b=J7SvCAomlKsBUl3Oo8vPw7pRWDU2+PH628xnmqz0k70HQgJzAVAymdmeZun/0cmi42qvyL
	wemvIRuM7mX7aCb0U1RvH2WZjZSYPWI947ilCNB4J27FAzptzn03MVFOT+n8q4LpodjQEy
	sW7/kBxhwZd/5D4iO/lVkjDSoqMW9MQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-HH0yrNPKOZmYaVsvd4hiJQ-1; Tue, 26 Mar 2024 16:43:23 -0400
X-MC-Unique: HH0yrNPKOZmYaVsvd4hiJQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430c9bbe925so10267951cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485803; x=1712090603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7bjw/hteF8djmOoWPYQb6GfOlzxEGXIn8a6dn1jJ20=;
        b=NLb5DqGHJBNEpZi0KVWfGEFKsKoUwn1zHDTnBdoj1Lc2h3CPr27I68oJl6id5q5ZWQ
         fwJdJKuKQR1KGzcyHzseQbeUJ/c919O5xj82dXVnFMMKt8LWE5CSo45GemdT5Qzih8b7
         YO5ryB6xz7NVwNbchcQ6SVGq+dt+zUQadRakwpNT4r3ktuqtIrTW08U7R6cLLsFh6Fbl
         Q9+UU1OPWwDd0J2ecll89X/Iwpm+9XlHtJt26F4JtJR6bu1XYw1YZDbNoDT1AZjVgFKc
         KuGl2awgTUUX9FvA7rnQ9XxKHVNbu66vSWWIRuzwM9hlm8TMgKGCEjwL1aUoJOP8NtOL
         uzaA==
X-Gm-Message-State: AOJu0YzQrsRclH2bBA+MzVO9K4cNMMbWcV+K4fdf0F7wpi+PwC/MAozy
	kZvSwEHnrYtGOXJlQMDm2Zef5X5ItjneBkm/kEb8ZLtDzO5e1Y5Qi/7amkHGzQX0X+e6QGS+zu2
	pZVyv1SNJgkqhErp992nJbyC1Hnj0clqZ+msOEwUf8FM5l0AY6g1YsJbIob2fmA==
X-Received: by 2002:a05:6214:3d8c:b0:696:6f95:4421 with SMTP id om12-20020a0562143d8c00b006966f954421mr12036053qvb.1.1711485803023;
        Tue, 26 Mar 2024 13:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9o8Lvkh94OFhBwTYfrdCOZFUwRaCCOcIoegLN8mEEkmbFgDRGFirXEVx9siaWwZdIpqlZMA==
X-Received: by 2002:a05:6214:3d8c:b0:696:6f95:4421 with SMTP id om12-20020a0562143d8c00b006966f954421mr12036034qvb.1.1711485802644;
        Tue, 26 Mar 2024 13:43:22 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fw11-20020a056214238b00b0069693e10869sm1875364qvb.143.2024.03.26.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:43:22 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:43:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/arch: Provide pud_pfn() fallback
Message-ID: <ZgMzaMu7oILiNLcG@x1n>
References: <20240323151643.1047281-1-peterx@redhat.com>
 <20240326132726.67e82559a928ac1636c8050c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326132726.67e82559a928ac1636c8050c@linux-foundation.org>

On Tue, Mar 26, 2024 at 01:27:26PM -0700, Andrew Morton wrote:
> On Sat, 23 Mar 2024 11:16:43 -0400 peterx@redhat.com wrote:
> 
> > From: Peter Xu <peterx@redhat.com>
> > 
> > The comment in the code explains the reasons.  We took a different approach
> > comparing to pmd_pfn() by providing a fallback function.
> > 
> > Another option is to provide some lower level config options (compare to
> > HUGETLB_PAGE or THP) to identify which layer an arch can support for such
> > huge mappings.  However that can be an overkill.
> > 
> > ...
> >
> > If we care about per-commit build errors (and if it is ever feasible to
> > reorder), we can move this patch to be before the patch "mm/gup: handle
> > huge pud for follow_pud_mask()" in mm-unstable to unbreak build on that
> > commit.
> 
> I temporarily disabled that whole series a few days ago.  Because of
> multiple build issues, iirc.
> 
> Let's make that permanent.  Please redo the whole series against
> mm-unstable and resend?

Yes, that's the plan.  Feel free to ignore this as this is not used until
that GUP rework series, I'll include it in the whole set to be reposted.

I'm currently doing the build tests; just finished writting the harness for
testing the matrix.  It'll take a bit time to run through the tests I
specified (I tried to cover a few more archs/configs), and I'll repost with
all patches included (fixups squashed) when test finished.

[side note: I think I can reproduce the other not-reported issue, on
 arm+alldefconfig; that'll get covered too]

Thanks,

-- 
Peter Xu


