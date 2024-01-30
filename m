Return-Path: <linux-kernel+bounces-44405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8981B8421A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E34A1F26212
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584DE664BA;
	Tue, 30 Jan 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FlVy2dkm"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A765BB0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611244; cv=none; b=peTBu1AGopTIOlkBeK0aTeRQ6kr6VqAuAwndB+cvM+Z9DF1UxSxGsx3NC8OYnr/fRoI7ruJWO9hjSCuFNJ4uY8QXqeP6Bn4JKQqySbnX4Wd94rh7T1ZSsKgsCx+ozOAR92IIgn8QzdzDcgCzDuNUYfPQwTqP6+Az+1TOCJfKx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611244; c=relaxed/simple;
	bh=ETdl8coLEmvqaxOFLDsn4/glTC/AoKOwDmqO3n9zkAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXh7cgphduDcy7vX0UQfs98/7VwjQQevUPFTFayHO7M0OPGQUFfMSE2rjGB5VdZsGJ5PO3keCGw27V+7l8C5Mi1ewU9YUzfWWr5mNyEUwGzx4OTbtlf3g2/5X724n47iczXCzlHUiYQYSLzXn9vcEX8AKCItHEHxbLmymzzJrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=FlVy2dkm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f35ad4d36so192827a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706611241; x=1707216041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpht1JVVU83PUsSOfehDgTwxwvmRcn3OoCMGwiYoquM=;
        b=FlVy2dkmMTm3VdInTzYzAVaHF+mck+lV2jkocL6K9V/yoLpfW8TxGh+hPuPO8Gc/jP
         jsoY9okfXGxxpxdPmN1WiKHmImOHqvN0HYVkdWHUSbYNl7RhPq16oxRAP7oI294IDWX6
         tgDOrKnuBQONnsmTBh56esl8g6dVEx1XwOYk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611241; x=1707216041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpht1JVVU83PUsSOfehDgTwxwvmRcn3OoCMGwiYoquM=;
        b=Y+zhfZaGv0O6313m/3mCjq18eLWeHndoupm32mfUCHIpMemJUPPjfgLOQJvuU9xB5G
         9Sn31mWBfCj8TLZQzgSnQq3Ze5gmgQGcQYkZQXvwm043drRk+nP3KdVGIz5jZuoBGIBk
         WEOWD9jF07lD6VcN38OcjtxQ41r+lTpcDc19dWVLemp9Scb1NJMenercmJpeLuFrxklC
         TMrUOjHH8zD73wFWnaO+eOxJFwptYIOsXNrmEtakEvCvHHv/AGJoMOSgVNGBWV4/VcoI
         +7xFwnmyvdPua5Z6HP/f0qTtPp+RveTsTAUURiBOBgV/b907ZD7bT1/MW6c8g0BHRwI9
         G65Q==
X-Gm-Message-State: AOJu0YyHq4ByZuaC5FUE7wLydVrwBZ4SXTdVTXBp9AEhRmk52GT9ZIk2
	j0FglGhjsvOARScko2gcJas1XAA3+2AdG+t12L1h1dLDLWlKqnHljFYeSqPsLZ4=
X-Google-Smtp-Source: AGHT+IHZ1+k7/jhfw/iaNOKyePTFN9as60sY4ufogxiCp9dTJV9WWo6nCqSg8dJHFMfPftGHyW34Rg==
X-Received: by 2002:aa7:d04f:0:b0:55f:99:fb30 with SMTP id n15-20020aa7d04f000000b0055f0099fb30mr3223522edo.4.1706611241253;
        Tue, 30 Jan 2024 02:40:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id es19-20020a056402381300b0055cffd3fd32sm4749393edb.68.2024.01.30.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:40:40 -0800 (PST)
Date: Tue, 30 Jan 2024 11:40:38 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v5 1/6] dma-buf: Add
 dma_buf_{begin,end}_access()
Message-ID: <ZbjSJi07gQhZ4WMC@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Christoph Hellwig <hch@lst.de>
References: <85a89505-edeb-4619-86c1-157f7abdd190@amd.com>
 <0fe2755fb320027234c086bcc88fd107855234c5.camel@crapouillou.net>
 <577501f9-9d1c-4f8d-9882-7c71090e5ef3@amd.com>
 <7928c0866ac5b2bfaaa56ad3422bedc9061e0f7b.camel@crapouillou.net>
 <2ac7562c-d221-409a-bfee-1b3cfcc0f1c6@amd.com>
 <ZbKiCPhRvWaz4Icn@phenom.ffwll.local>
 <c97e38ee-b860-4990-87f1-3e59d7d9c999@amd.com>
 <Zbi6zQYtnfOZu5Wh@phenom.ffwll.local>
 <a2346244-e22b-4ff6-b6cd-1da7138725ae@amd.com>
 <7eec45a95808afe94ac65a8518df853356ecf117.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eec45a95808afe94ac65a8518df853356ecf117.camel@crapouillou.net>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Jan 30, 2024 at 10:48:23AM +0100, Paul Cercueil wrote:
> Le mardi 30 janvier 2024 à 10:23 +0100, Christian König a écrit :
> >  I would say we start with the DMA-API by getting away from sg_tables
> > to something cleaner and state oriented. 
> 
> FYI I am already adding a 'dma_vec' object in my IIO DMABUF patchset,
> which is just a dead simple
> 
> struct dma_vec {
>   dma_addr_t addr;
>   size_t len;
> };
> 
> (The rationale for introducing it in the IIO DMABUF patchset was that
> the "scatterlist" wouldn't allow me to change the transfer size.)
> 
> So I believe a new "sg_table"-like could just be an array of struct
> dma_vec + flags.

Yeah that's pretty much the proposal I've seen, split the sg table into
input data (struct page + len) and output data (which is the dma_addr_t +
len you have above).

The part I don't expect to ever happen, because it hasn't the past 20 or
so years, is that the dma-api will give us information about what is
needed to keep the buffers coherency between various devices and the cpu.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

