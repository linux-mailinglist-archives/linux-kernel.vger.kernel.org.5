Return-Path: <linux-kernel+bounces-94821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E8A87459C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F931C21F72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98334C61;
	Thu,  7 Mar 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbU8yZGD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA922393
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774444; cv=none; b=SDy8mFnWSjgj6+cgHxc5IGoJQSJiIs+Br6g1jmua+NKSEKndjSy6HVt6Q3z0GlUZ08dityUEAQ0bRnKliOjdrRyJOVTiUGwioOYEert08BTPYnxBcyX69HpYFQ9XYrfm1PZjUeLy1VAnwYObPjSjaIr3F4+ZGu4kvNuOBQ3WNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774444; c=relaxed/simple;
	bh=eLWI/ao3cO+GcUymz/JHwZ5W1xR64wB1eu/BGWlakEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMo9dvMezsN0RR7z4hA5dkOVyQ9+pJEgAeXPcQ2EO2HyhVvuZ/9TtHxc4m1LIUNX4Omwpsyn/J19MRGDmQp4LLS0QPqo5Nbq+W08xdVQNZQnMZqX29ntDmbfCBVChUJeb9P3zkYdq+khRCeXxfWfe8njhdK7qkUP+Dw8rk+JeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbU8yZGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709774441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhFuQt4q8WAvXMefiMZxpPmveS96SWCF8VHgxXDffSs=;
	b=cbU8yZGDpz00t5PofV8p/RuozMT8ApC0jPGhj1y/WPA2U3cQtOHnt3btfxWlYE86HdMqKH
	7TeDQSSqeIddT2eop6YN/s79S+iVO2LBPBol9legQP91Qacyy2FchloLEM3GErV4oIUJ8T
	aka3vCRqp8ECZ9f+b1466EDEgO5avqA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-tE0vB9tHNoWqwnTHTz18Xg-1; Wed, 06 Mar 2024 20:20:40 -0500
X-MC-Unique: tE0vB9tHNoWqwnTHTz18Xg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6dbd919aba8so77901b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774439; x=1710379239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhFuQt4q8WAvXMefiMZxpPmveS96SWCF8VHgxXDffSs=;
        b=FpT5bUOQYxBhf0J+DEmVctj//UWeXcfSgTRdC1FLfAQVV7RyXLldukPUt35NG0+7t+
         PUk+oXnV5UNesXcAMCMD3bxnpox/+a3rRHhuFNZ8IDWrhqeJ6r3VVBm8kjE4jD9YQRHC
         oI7W1xKM+o1+RAj9jbbqQpL0OxHgCtxkDl842EwbndRtbLft2gZU28qy955rR14GSsty
         jcx5Yl0HUsssK6OUJQDQWJwSAh5QB3VgcJNGsbjO9OdlcQPNHdyYhXpCUL/9ec89fdsh
         cbZ0JmU3COEWUAtJj9svnev098+9xpAU2BoyToiDs5XA3N4Cvej8NtcNHVF6cExObXtf
         YBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgo/qXNGHyS+5XC/Jy7Be+20tNOQGxH//qElQWTOgIUI/4X//eEG1fSopIiu42O4x5z+IAuoHLuowj2AQgSKGXyzarKGZ+fZ8Q1Jw6
X-Gm-Message-State: AOJu0YyMpkttRxxq0JCZCa9AxgYbnczGqDwxHNBDHMCl+MQujHkKbToj
	NpP15/SlmPxi1uvizgrYTAAdcbf8pPSRjuURQZLR84HIftb4romaICLH5GtOubcZQFSpYadni3V
	PtFTW7ERsUjJGTBcKZYeLfev2S3R7uEqgusBeU2DqaK62Uhx+hnRl5zPTA0lTRQ==
X-Received: by 2002:a05:6a20:a895:b0:1a1:4de6:dd5b with SMTP id ca21-20020a056a20a89500b001a14de6dd5bmr686769pzb.2.1709774439106;
        Wed, 06 Mar 2024 17:20:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwPXix9MbbtJw37hdIIvV8ltPtJesNjs4EOJQCegYjRu+Q7lAtamF2mPHfurRr922mSFeM1Q==
X-Received: by 2002:a05:6a20:a895:b0:1a1:4de6:dd5b with SMTP id ca21-20020a056a20a89500b001a14de6dd5bmr686764pzb.2.1709774438828;
        Wed, 06 Mar 2024 17:20:38 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n39-20020a056a000d6700b006e57defe737sm11481348pfv.76.2024.03.06.17.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 17:20:38 -0800 (PST)
Date: Thu, 7 Mar 2024 09:20:32 +0800
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Add an explicit smp_wmb() to UFFDIO_CONTINUE
Message-ID: <ZekWYNPDAwD12EWt@x1n>
References: <20240307010250.3847179-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307010250.3847179-1-jthoughton@google.com>

On Thu, Mar 07, 2024 at 01:02:50AM +0000, James Houghton wrote:
> Users of UFFDIO_CONTINUE may reasonably assume that a write memory
> barrier is included as part of UFFDIO_CONTINUE. That is, a user may
> believe that all writes it has done to a page that it is now
> UFFDIO_CONTINUE'ing are guaranteed to be visible to anyone subsequently
> reading the page through the newly mapped virtual memory region.
> 
> Today, such a user happens to be correct. mmget_not_zero(), for example,
> is called as part of UFFDIO_CONTINUE (and comes before any PTE updates),
> and it implicitly gives us a write barrier.
> 
> To be resilient against future changes, include an explicit smp_wmb().
> While we're at it, optimize the smp_wmb() that is already incidentally
> present for the HugeTLB case.
> 
> Merely making a syscall does not generally imply the memory ordering
> constraints that we need (including on x86).
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


