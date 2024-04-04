Return-Path: <linux-kernel+bounces-132104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC76898FBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758511F232AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2513AA56;
	Thu,  4 Apr 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNi1crAz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769613A890
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263009; cv=none; b=HM0d3zgktG64ilCw3cpngZEOfVGxB7cXsuZSTmxix9N74o2tIaklBsIbV4js5bqGj6eeWMZZG0fgrxD8GehNofSo6pjSxxxoUBJLNyS0psFVr98J9s2baZs0iGO5yA62uW8WiXFXgW7Sm4/o6y4c0TuFtgQHgPnFpUV7FMDaLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263009; c=relaxed/simple;
	bh=y1Rsrld3EEbDp6rEcRf4DJgr5shNa6Z5QESiLrsf31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUX+Z7XimExV9Bt8g/Y4k1/zflOuifhRTSqBjAKQYKTY2IgjyursGHF0brzhxJFmpPlP/UrtTN7Ki4tl+4G/gJWYQ1XU4aG8Fddn1AZcZIStH7Ia/5ZFYKZejf+HVlVsR/O6UBYPsWbNFsTkXVYfGzJElIYOJLkRJtYml2VYwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNi1crAz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712263006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/DObdPmk2vIFww25ZF0AN9UF35je65YLgjdkhWbsjU=;
	b=JNi1crAzudHf4ufDPbjHnMj2+8kpDcyqYCJUbcjrVU9W9Fg2m10shNdU5t7EnNnx9iDLjp
	oMrY58pYRkhG25+cq01qxkWiVBOBxM0zJsmzEzUmD0eVbNsqa3Y1LcZxk0n2K0V8UFbmPU
	xZY0zjWXy/9TpTRV+b4f4DVnBcA7Gb8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-7IcgZwXoNjSwOJKIxXfAUg-1; Thu, 04 Apr 2024 16:36:45 -0400
X-MC-Unique: 7IcgZwXoNjSwOJKIxXfAUg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6993921ae18so1517366d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263004; x=1712867804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/DObdPmk2vIFww25ZF0AN9UF35je65YLgjdkhWbsjU=;
        b=Akf9mQUR98+3YCZ3Zu7B3gQeMDiALiMU2PrVPqolOShUJHtqxyCzbkVha20RlEKqNb
         c6dBt7vlfC20Y4ddedCx7UY6dMIXdXIyWrmWMFNg1POj0IuLk6SEpjcOoyUbxKeQC04o
         CSi0HrIy7M/dRpqM5UDEf5j5eG2hIjeTwuIqw4lwl+uzf4pQhqTQ+y5BYa8zFaI4Ulkm
         CaiKYV/5tqtvBQjRHSbKKlQuKVuMMLE+Uh/PtttkkF3NAQ8E3QbjFxQydBaQm4kDGQwX
         D2toZHH/WJSpfyJ3R0g5Q8gepf2MNpyZOOCZwcXUEVib8DKeK4Qf54mmILTpKcDid5Sn
         tUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWheqR0Po8ToZ16TAMcCWmt4T6JIrYYW/b3oA6vvBbEfU0L6s4yKtwdlqmQP+AEHpgIqHK9ORa0NZxqYWMymqhoFYFTM6QvgZ5GA3vG
X-Gm-Message-State: AOJu0YyurDNz/NhUfWpI8nmE7K2m/+cfMB/5X/IN72lOr+WYTn/0b4+Y
	Y57+DYjIFCZWyihqTtWmRMqyvp0CAczA6gHn49dg7xeuMM0PpIBUeoKLJoCx8xw3gfqHukCrRRq
	5+UMX/RLv0wRxzgk2Qro7hPeXxe9VRcR3eykvsMjsOaUQNl5391iF2brnHkaHLw==
X-Received: by 2002:a05:6214:5084:b0:699:1b70:da97 with SMTP id kk4-20020a056214508400b006991b70da97mr3574428qvb.0.1712263004395;
        Thu, 04 Apr 2024 13:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIpQWyjNAjmxMD5sLmyARNNdxOYRp+t32fubrk31G8hnVLmzAp/R36F4eQIQpaEtl6eQpvYw==
X-Received: by 2002:a05:6214:5084:b0:699:1b70:da97 with SMTP id kk4-20020a056214508400b006991b70da97mr3574392qvb.0.1712263003617;
        Thu, 04 Apr 2024 13:36:43 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b19-20020a0ccd13000000b00699103a1cf1sm44942qvm.119.2024.04.04.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:36:43 -0700 (PDT)
Date: Thu, 4 Apr 2024 16:36:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
Message-ID: <Zg8PWdGYFEUbzbJH@x1n>
References: <20240403013249.1418299-1-peterx@redhat.com>
 <20240403013249.1418299-2-peterx@redhat.com>
 <Zg3u5Sh9EbbYPhaI@casper.infradead.org>
 <Zg6vFtciZAl4SQHW@x1n>
 <Zg6z4ZEt7rbILgl8@casper.infradead.org>
 <Zg63YZaXqYdSLHG-@x1n>
 <20240404133137.560d15c1a3bc7176424901fb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404133137.560d15c1a3bc7176424901fb@linux-foundation.org>

On Thu, Apr 04, 2024 at 01:31:37PM -0700, Andrew Morton wrote:
> On Thu, 4 Apr 2024 10:21:21 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > Andrew, could you help update with Matthew's fixup?  The comment is
> > definitely better than what I wrote in all cases.
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-allow-anon-exclusive-check-over-hugetlb-tail-pages-fix
> Date: Thu Apr  4 01:27:47 PM PDT 2024
> 
> simplify PageAnonExclusive(), per Matthew

Thank you!

-- 
Peter Xu


