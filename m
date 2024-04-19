Return-Path: <linux-kernel+bounces-151660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF98AB1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760C61F22CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF012F5A5;
	Fri, 19 Apr 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqGCGbjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1D12F5AE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540125; cv=none; b=rfER0BNF16tBNei3iISqIXzinTmFMJBaJVJpHjHU5F4DcX29LiD/6w4y/wbd7IE4xywIS+qLRajon7e458bTD0ouJ/vJcrjneSHs0Yszbtu7du9JPKF1ikhS+xz4Rk9dw37Agz3UD7WMWUB8y/lswSBfHEMFZ4sTc6/VHGQZa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540125; c=relaxed/simple;
	bh=MJGoZTVpjtviiVYwoZxi+ES4Zin/KP+7Zanoc63PsIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMbv0Mo1PAG/wRQMwPqIvZSF27lxYQMh15nA5nC8ThTU2QXCDf5sBPKfMnJWzWVIZb9wxuqNVIOdhVAqWLlKFYdUe28KGHY1M76LarpVt0yLUm1YqCYUAOyPnB8G0fajxtUq6xLSAru+4Jui/dVWzWzz41q7wtGPIJ9DsxaTAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqGCGbjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713540123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYoEcbDndyhCownGWpj006Efk7M0aOxnlzP6C0Hoi1o=;
	b=CqGCGbjl+Dip8jROrPhE507Tskggu9IoTyHNA5/vsLz7EtSoy5IZKLE56wH5J5pkJOC8B/
	zip3WDIlmV/E6IyPpjBZiJRE7SKVcIRL91+RXEaTedkI2esHqKa97x1TSqgPKT0NyzBsut
	7stBC6+fuOkgmVAlIu4aV6DWnX5Fbhs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-1-RR6fVeNIukpkDih73Vig-1; Fri, 19 Apr 2024 11:22:01 -0400
X-MC-Unique: 1-RR6fVeNIukpkDih73Vig-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ebc82e112bso552141a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540121; x=1714144921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYoEcbDndyhCownGWpj006Efk7M0aOxnlzP6C0Hoi1o=;
        b=vs84T9VAfXDPNeNqdHe21YtTnk/gqaL9Wz5cTVVO/mstO7s1sWP606xYGYo34AFx+X
         Sk7K4WL2i59Z7jz8VfF8qoCW3iLyf0a0bOhKlOcdgorUglkCabcJBRjkkSQNQ89xU4MD
         P94QANIwY+b7AIg7ardR3Zh361UQStTeALYOQh5qvUiUvRCiQ2trf/ZZc50CFUQy3ARR
         23OwcdpPPAg24eVd6xgZXAedlTqL+3S2UBFcqNeDQXgMOiJacBo+klAi1aDt3FbPAYzA
         ODnFJuN7VRdH0oIs/j8f0SZA5i9Yd8vdJSjR8yLcd60A04GWGhDafRGHK8jHDtufvuc/
         zrAw==
X-Forwarded-Encrypted: i=1; AJvYcCWVtQ7YCAIxTPQxxjJCPzW6XjwLD2HJh+LKD9uRe+cZvgNe/RZD24F/WIfR7WVCNi2tLz01PQY8EnzmTGcr/XctzqSGSvaBnzk9T0JD
X-Gm-Message-State: AOJu0Yxr0YQjlFIWGacbupuMI0YB9OXQU7Mt5Vq+XcJ+bCVMewG2ytx+
	PsDY0c/utMXdh9obQJA7+/4X3GBPSa0DAZheRWjHaFFJSfhyPbiqbg4kfmw18MF5K5ESENB2cXw
	CBl4holfgJAgl7dNMPrmZ85AUgafdxKOtVuHYZB94HKbykYusg4qlpGqFJqhpF073JAltgQ==
X-Received: by 2002:a05:6830:1005:b0:6eb:d466:aaf5 with SMTP id a5-20020a056830100500b006ebd466aaf5mr2052444otp.0.1713540120745;
        Fri, 19 Apr 2024 08:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY2wIQBnATGA2C+bt/ZQ3xgZjYZvLmZNmXi8KS8LWrW44TJf7aT5W27ju6eUf2PBuAp5a4bw==
X-Received: by 2002:a05:6830:1005:b0:6eb:d466:aaf5 with SMTP id a5-20020a056830100500b006ebd466aaf5mr2052412otp.0.1713540120236;
        Fri, 19 Apr 2024 08:22:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id wk17-20020a05620a579100b0078f1c03f06csm497608qkn.113.2024.04.19.08.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:21:59 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:21:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 3/3] mm/hugetlb: Assert hugetlb_lock in
 __hugetlb_cgroup_commit_charge
Message-ID: <ZiKMFiEyjz_A-hkj@x1n>
References: <20240417211836.2742593-1-peterx@redhat.com>
 <20240417211836.2742593-4-peterx@redhat.com>
 <CAHS8izPMjBMNUStsUjobbo4rUXirFtkOZVvJTFFqD4SUafQZaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPMjBMNUStsUjobbo4rUXirFtkOZVvJTFFqD4SUafQZaQ@mail.gmail.com>

On Fri, Apr 19, 2024 at 08:03:08AM -0700, Mina Almasry wrote:
> On Wed, Apr 17, 2024 at 2:18 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This is similar to __hugetlb_cgroup_uncharge_folio() where it relies on
> > holding hugetlb_lock.  Add the similar assertion like the other one, since
> > it looks like such things may help some day.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks.

> 
> > ---
> >  mm/hugetlb_cgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > index aa4486bd3904..e20339a346b9 100644
> > --- a/mm/hugetlb_cgroup.c
> > +++ b/mm/hugetlb_cgroup.c
> > @@ -308,7 +308,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> >  {
> >         if (hugetlb_cgroup_disabled() || !h_cg)
> >                 return;
> > -
> > +       lockdep_assert_held(&hugetlb_lock);
> 
> Maybe also remove the comment on the top of the function:
> 
> /* Should be called with hugetlb_lock held */
> 
> Now that the function asserts, the comment seems redundant, but up to you.

IMHO there's no harm to be verbose in this case, so I'll just keep it
simple to be as-is.

Thanks,

-- 
Peter Xu


