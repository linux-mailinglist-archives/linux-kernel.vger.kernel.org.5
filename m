Return-Path: <linux-kernel+bounces-118157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B988B67D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D67CB3A51C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DE682D85;
	Mon, 25 Mar 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GH4vf/Jn"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629582D67
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408440; cv=none; b=DtOQekbLQGIWew0SzWG4TrfmHJg9GP6uxLN8FeDwUYSxtk+40uf9J0+x/ozEcc676pXESZpKLnKB1GDqNAFDCWGnTiA/jhGhepQs0BYcqxRyaTATxVNopLf5+8BoNfy3c04teI3tSE5MJxj1Wy4l8m+OzlqcJNJHLNGsSb8r78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408440; c=relaxed/simple;
	bh=aqJifYxn5u78ALwMxq1Y3V8SdDX+a7VN76OUmiP10H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CePaeozUJpv4Jkz6TyUs2ij8fRr328Zzb0lW4vde3qNDj7yEEzm4MdjRmzO+LZSB1IvaPEO4kQvpgcTkpG40xKqyiNXw1zz5kBySRE/W/oPBx0yzAX9KyvQLLHh4AAC6dpFF0fTOcMrqFPQOpPlUI+zXR786M3f0lKo7+IyhTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GH4vf/Jn; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a4a2d99598so2200191eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711408438; x=1712013238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTiIah+56OL95MvLxsoMlL16NsHmbf/z1NDz1O3yUIE=;
        b=GH4vf/Jnr1xb/rd3tsWz+/EJdXNILyP8iZ+ai4vChv37rtXtJ8TwT0DOadtJPcjiIc
         Kn5R7TJWxFi7V+ONpDiyRcf1Y2BbprtMs+oafRXtKPdIXz9zJ8v1km5tiDT8CjDZCmV8
         9Tgz72H0T6vToQIG3/spo3KL/AJG6xPiahLBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408438; x=1712013238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTiIah+56OL95MvLxsoMlL16NsHmbf/z1NDz1O3yUIE=;
        b=OSOlpoBKFgHfx7mauChinOYtWJcaWwnrD4wBB2KGQpcaDj4ZzWCYb3ECahfZFTY0we
         +KJfVi8JDUT12fVeoCcrIAiR20/OMm9Pmbh3hjtzghfqpCTBE1N2QS/b7ORzQoMyKecJ
         cSiX5fqqE5wGEYEqOrb078FNY5IAfXx/zMQTfnMVeoXNqAmgWM9e1a8ZxgL6NKrTjiUm
         YJ6HeCylHil8/5lx02QMQR1jphjaVO5r31Xzot9J00XwH43FLfq4sv64zVAw4M2NoCvi
         AapgA3Xh3IkxYTIxUJDDVxIUapewQyCvvxGbskb/H5qVq2IUlYOIb0aQ4kR0WiV3V2QR
         fpdg==
X-Forwarded-Encrypted: i=1; AJvYcCXy1yoADtJ0CRT2z2U7wiX5YzEI6RXKE89CsFSPDOvbr8oynbdSE8pMqUipRkERlt3ImijJzfbSEEpOOnfDOsI6j7wTOsTaQbcUMrX7
X-Gm-Message-State: AOJu0YytZRse4z1CH/dXqq3YcWzHBm7vq/4NhwBvvbA9EVkiPw9bCJno
	YBIfgmrWQfqRam1n3wC3itihAV3Q/oC+11P98D1wsE7/sWWhupQfWgVBB8m9Gg==
X-Google-Smtp-Source: AGHT+IGtyD4P4iqpqDllYpprt5vrEviS5VJKJGKD5uIFgXBnta+btyjjzK1a/0Cds/Qxz+YmqTU1tA==
X-Received: by 2002:a05:6871:554:b0:229:b0bb:3017 with SMTP id t20-20020a056871055400b00229b0bb3017mr7943491oal.59.1711408438066;
        Mon, 25 Mar 2024 16:13:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c29-20020a056a00009d00b006eabaf689edsm27328pfj.113.2024.03.25.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:13:57 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:13:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 4/9] slab: Introduce kmem_buckets_create()
Message-ID: <202403251609.1F681B5D@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <20240305101026.694758-4-keescook@chromium.org>
 <eppzf5gil6izcn6nnvzgzukagdikqnfxdvziga7ipnpl5eeern@i7jfzslklsu6>
 <202403251327.C15C1E61A@keescook>
 <67tgebii42rwneeyqekmxxqo2bzgyysdqggciuew27bc3gbrkg@5ceqjmiaxvyu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67tgebii42rwneeyqekmxxqo2bzgyysdqggciuew27bc3gbrkg@5ceqjmiaxvyu>

On Mon, Mar 25, 2024 at 05:49:49PM -0400, Kent Overstreet wrote:
> The codetags are in their own dedicated elf sections already, so if you
> put the kmem_buckets in the codetag the entire elf section can be
> discarded if it's not in use.

Gotcha. Yeah, sounds good. Once codetags and this series land, I can
start working on making the per-site series.

> "usercopy window"? You're now annotating which data can be copied to
> userspace?

Hm? Yes. That's been there for over 7 years. :) It's just that it was only
meaningful for kmem_cache_create() users, since the proposed GFP_USERCOPY
for kmalloc() never landed[1].

-Kees

[1] https://lore.kernel.org/lkml/1497915397-93805-23-git-send-email-keescook@chromium.org/

-- 
Kees Cook

