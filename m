Return-Path: <linux-kernel+bounces-160721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44378B41AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6071A2835DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DC37708;
	Fri, 26 Apr 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWAxTbik"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870537163
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168718; cv=none; b=Kln5buGj5HK7W3atES3Wfqsbyd8Pt2Tt3YIwwuMCM5Cq0KteDkNOG65AWT4kvGvni1hSDqsqcxtTCpC+4Rr/7IF5WCe+133l3N9Su+dN7k+knCn2u1nJp1/l0Zlci8MpuFAqo9yFh8Ypzk4C4GbEmXDaxzFOv6vrT/rvFCR70lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168718; c=relaxed/simple;
	bh=GpKDeVd3Be5OZTf7mdPRg/LKaWMV3/RuUFvbHOM6pQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCykGKQTvNTrYhgxJ7M/xY0k/+tfvZzf5bQO74/xyoh22kTDRY2WrCrtOIsfOrybVAtvaicUdGS0cz3DLYEi8tNYr34aUlM92HiB8b+0Y3/ptQDYfmAHJvGmUDQlNsWNgCpYZbwhNIc/ZxL0846OENI92dvo+IQl18iycKDZYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWAxTbik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714168716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QCnlzmJ6bjL+5B5nZfc9uwhSIwhhaQo56prOJlaB+0=;
	b=XWAxTbikt02kzcDl1AzK22glPUXZQ+sA9GGmqMSDTagHr8atZPln4XYVTn7LaoRjuqx5u/
	eUW7xbfLZOquhE1ngvmJ5tauIYj4+q4KPv494ubsaEq024i3YGyC2swINJTqvSBtQOK8p0
	iKfxStbqBXhIKdCJHY6UqORqc5wRCn8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-ztQ1HOfKOM6r2BEY6AJPDA-1; Fri, 26 Apr 2024 17:58:34 -0400
X-MC-Unique: ztQ1HOfKOM6r2BEY6AJPDA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a073b075edso2266656d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168714; x=1714773514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QCnlzmJ6bjL+5B5nZfc9uwhSIwhhaQo56prOJlaB+0=;
        b=nvLL8B+kPxTF+SBJKNblX/DiPk6s6d6dMw501P/rV328zblVAwBjkmTroAaszn3nML
         6aROA1s5DzPPhBraodUXj4IEgeZtwLj9ZrPJMPGfBHImdt4h7zZsAZMluVn46NzMcUBo
         pqPiGeEUXSyeqBC0qjJxIM8DWfLg5ycR626rgPrx0eht1NWhgRINROnrAvFmWFr1nfKT
         XhTvsDUGpSoBB2317TxzQA2vYPmRApjn053ZVzKjYYqnnyI9BMDWyquGlqoUdHbiG5OM
         Zm98VjTTE0f6zMGTX1uFgsEuuNDM1mn47svgADeh8aQAbOBVvWpAwwap7kN6HgfExWay
         WlZA==
X-Gm-Message-State: AOJu0YyLdseghvVNXJsEJnuMOzR/vl0Qb7CIln7obIwnJ6OyeCOND0y4
	h5gUFnEIXfBCuMYm97F9rbKo3T0nreQyVDIqYlmuAWD+ng/UmpNU/KhtCF/YrkoKEtN7yYZhugN
	eWZJ3g2y0WpfwsbIVIieAv1GU927TVDTNv772d1nPrt2YfVGmU1uMotmmdGpwYA==
X-Received: by 2002:a05:620a:17a7:b0:790:95ad:9260 with SMTP id ay39-20020a05620a17a700b0079095ad9260mr4428403qkb.0.1714168713791;
        Fri, 26 Apr 2024 14:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9TXpTvynaKbMe+uWh4XQxgfNR94gVb6jB/4BIiWgOtfhaqFyr6WLW6qYoOzAm6Sij+K5ZPQ==
X-Received: by 2002:a05:620a:17a7:b0:790:95ad:9260 with SMTP id ay39-20020a05620a17a700b0079095ad9260mr4428368qkb.0.1714168713163;
        Fri, 26 Apr 2024 14:58:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id g13-20020a05620a218d00b00790789db3cbsm4659252qka.29.2024.04.26.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:58:32 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:58:30 -0400
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
Message-ID: <ZiwjhkTTRG1ZjyLf@x1n>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
 <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>
 <Ziuv2jLY1wgBITiP@x1n>
 <ZivScN8-Uoi9eye8@x1n>
 <8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com>
 <Ziwal-SucIye3hPM@x1n>
 <fb3bd167-748a-4548-a94f-9194443c0bc3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb3bd167-748a-4548-a94f-9194443c0bc3@redhat.com>

On Fri, Apr 26, 2024 at 11:33:08PM +0200, David Hildenbrand wrote:
> I raised this topic in the past, and IMHO we either (a) never should have
> added COW support; or (b) added COW support by using ordinary anonymous
> memory (hey, partial mappings of hugetlb pages! ;) ).
> 
> After all, COW is an optimization to speed up fork and defer copying. It
> relies on memory overcommit, but that doesn't really apply to hugetlb, so we
> fake it ...

Good summary.

> 
> One easy ABI break I had in mind was to simply *not* allow COW-sharing of
> anon hugetlb folios; for example, simply don't copy the page into the child.
> Chances are there are not really a lot of child processes that would fail
> ... but likely we would break *something*. So there is no easy way out :(

Right, not easy.  The thing is this is one spot out of many of the
specialties, it also may or may not be worthwhile to have dedicated time
while nobody yet has a problem with it.  It might be easier to start with
v2, even though that's also hard to nail everything properly - the
challenge can come from different angles.

Thanks for the sharings, helpful.  I'll go ahead with the Power fix on
hugepd putting this aside.

I hope that before the end of this year, whatever I'll fix can go away, by
removing hugepd completely from Linux.  For now that may or may not be as
smooth, so we'd better still fix it.

-- 
Peter Xu


