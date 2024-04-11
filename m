Return-Path: <linux-kernel+bounces-141639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0AA8A2114
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459851F23297
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6C3D3A2;
	Thu, 11 Apr 2024 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNCQghwd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9263D0BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872013; cv=none; b=an9pPIFltuB71jQWHS0WD69pwPXq7rJEpEyuRViadFBhc0ew3TfItvl/zeA2yxRuwyttWbAQUzgEjNbKpf5VRZNo9z3040HfrOecjDmmaYyQ9VT88dvWBPtVE7QoHJiWT+hAWfM4SwyRbCfQzw6dHXrhPLbYyuztU5/VI0V6DB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872013; c=relaxed/simple;
	bh=3qpcb4sx+uvqkoXVaq9GbAkMpl1h3tXu6keJYB+Vw8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD6p2XupcetpBU2ckCdi56UcQQR8lMynuDLDYyfEe3AHRsS4rfGbru9Rfkh0/ED0sMzRsgCSjxOXGFLFQzPbRARBSoxjYAPCiK7YmEXhnRg0M3AWJQrfLdOeSwcUmxMeeMEZxuaB+lBYhSW/5NlWXHIvikV6MuHiIjuBPKqFQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNCQghwd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712872010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AeVZHyp5zTZkCWGV00qc/cGGvaWCHb1eULABPjhz724=;
	b=XNCQghwd1yUjKBAE/05nuWtl9ji3o9CJwufBhDYxPxUrj4mfdWPyLM9HTpbYd8UZ84oL8W
	j4L/RvEMOquFQnm8UiphxLQ7ZnKqSm6X9shF27HdliiGnH3cPBkTPVz6sjarJL2q/eoo5Q
	uo+9lYDhyhcrXHMNlbJC0CZiRV+pEXE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-3lQz3klsOw2Do_2q9pvEIg-1; Thu, 11 Apr 2024 17:46:49 -0400
X-MC-Unique: 3lQz3klsOw2Do_2q9pvEIg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69b3101297cso1032846d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872008; x=1713476808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeVZHyp5zTZkCWGV00qc/cGGvaWCHb1eULABPjhz724=;
        b=jGlaZnr1FdLwrg2cZ3P8TWwfjw6Zv8cr8Mgs2Js+toDH2uo6LXCfB1iSZJEm9THXTG
         D0dm8c9J3iFES1n24tgNBrByJyjrQ0MvdnR7PxHAI5PNalXU5HMuA7AcHpIvudJwC+m6
         pNs/xfK0ySyNSGpHDNYCiN5NrjoR41zlZdDTwU0FqDL3RqxX50ZwV/o2KGsJd5MvMota
         qqNJaK04rXJIZ9Xo4GktlTppFJ4SBE3cKF1HYQtmD+PHYkxSJwanOKXGBpVqDcJlf8hn
         30Ynwxw6eHWlXr6z+naOb4xApIvd5MT0Q5V2g1P6lUvY6dOnEZKSpkOR7HRsE3O07tjw
         3IpA==
X-Forwarded-Encrypted: i=1; AJvYcCXRexNHoLMj3iKG5HHvXXYkb04bufuieWvM1NS0PSjDVn/kBfqn0QHt6SNYP/3eWE8zblIQrDh/5HCoYtR13j8+rEq33GYG0SG9wSVX
X-Gm-Message-State: AOJu0YweYB0eRCmVPivNpaSAs3tT/z2kRd+83+o0yoDpuCiyOisy8ebV
	gqr58C0ZM2jcA+/NZReGzj4IASHzkbmwQ2hzedHl62iuzcw2jqw/hfehSXkbDqDf4EDCMLl0gxl
	3tKT7meYn6B9WudMk3HVn/MJDgXovHd0nwBmGpx/2tZCShjgcNpZ0RNJEEv2vHA==
X-Received: by 2002:ad4:5f48:0:b0:699:dfe:6015 with SMTP id p8-20020ad45f48000000b006990dfe6015mr881589qvg.5.1712872008348;
        Thu, 11 Apr 2024 14:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+ZOTuw/NuvV3LjmlcZIImugiwW7Rk2v2zySMF8EcG7C0GQ+zVIzdYdJFEvUq5bzSuJYCOVA==
X-Received: by 2002:ad4:5f48:0:b0:699:dfe:6015 with SMTP id p8-20020ad45f48000000b006990dfe6015mr881570qvg.5.1712872007735;
        Thu, 11 Apr 2024 14:46:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dm8-20020ad44e28000000b0069b4964460esm1392353qvb.82.2024.04.11.14.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:46:47 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:46:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhhaRXHKk7w_hKgi@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhhV3PKgEX9d7_vA@casper.infradead.org>

On Thu, Apr 11, 2024 at 10:27:56PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 11, 2024 at 05:12:02PM -0400, Peter Xu wrote:
> > The question is whether that's intended to make it as complicated.  For
> > example, why don't we check anon_vma for anonymous too later when prepare
> > anon_vma, however we do it late for file memory.  AFAICT there's nothing
> > special with file memory in this case.
> 
> Yes, it's absolutely intended.  If anything, anon memory is the special
> case that checks up-front.
> 
> Congratulations on adding additional instructions to the common case.
> I don't understand why you persist with your nonsense.  Please stop.

How many instructions it takes for a late RETRY for WRITEs to private file
mappings, fallback to mmap_sem?

Did you even finish reading the patch at all?

-- 
Peter Xu


