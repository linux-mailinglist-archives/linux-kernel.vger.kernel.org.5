Return-Path: <linux-kernel+bounces-84389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A386A65B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034B5B2AD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA43FD4;
	Wed, 28 Feb 2024 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPtLAS6R"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F823BD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085284; cv=none; b=ao3dSnnARNABtz52ez//2FGFi+vGPnUikESQ2WanLVU2N+vJYIcyiTl6GuC586ddY+0aTEZli7yJztPr+2GiUqttq+rB1lvpSFZi8h/mb8dx+yACDQ20dwQgt3wm4rX67LAEplw3E1vzl7f/j9QDU+RK29+IjoKH7vE8qkkqMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085284; c=relaxed/simple;
	bh=E0Z3uo3Zpq69vSIMMbfAIvUQwkJkLrk+UNg4bbe4O+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnP+iCjWG/BUqZGbYJR7tibe859EyFeFBWeeOcIkPH3OvAz8RKBAu1UHUtMwOVaOs79yYwXSDBRehJL8vpdwfc2GbioDe6FemCc7421s3DDsp9L81cW3M7n84wNQxYKgiOFRtnlhGNjPYy3zcOcAVD6pzD33OYatliky6j5Cz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QPtLAS6R; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1b741aff8so144577b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709085282; x=1709690082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc/Ezc697PEIA5Ksiw6r1nbfjVv1RcjD2G5KFRLlKic=;
        b=QPtLAS6Rg7ag/Ei1Sy7Hcgle4tgS9RbPBrhulkgg1gzQ6bXTs12zbfZwRAthoDwNXJ
         xdAWAmvaYym97Y/bfYsqCHEWOpmXxPGmpConF5l3IoLj4Hk+sg687ikGyBfQ47J6L6yj
         D5Ui5Oxlf7DHQww0CXIstqEWSLH0KP2JQtbcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709085282; x=1709690082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc/Ezc697PEIA5Ksiw6r1nbfjVv1RcjD2G5KFRLlKic=;
        b=XiVO6f43ATZ8zKoPdc740fF9AqFLfhJ3C8ZFXo8UNchzfYwSoFTu7n8CyU5wAIap3N
         4VeY1VHL4j1FD6hrW+12uYxpEt6L8OWb3NtN3Wre9rRR3YERKKDEAtKHsXo0MS3i1H1g
         3ML5ZaRip3zrxNPfnAoumqkuvEF8XkUzBf5R8sAqyZL5B0fdqXaISU9pk3YIeZDeFnxV
         qjolsSfuc3sExJmUTswX9b+YyE/SAdeOmRPTYJFf3/IWY4nh+86SVZC71d9O+tZP3wgD
         KNHU3jPALh5d8u3OTOh27ztSeu2ZVGCFcRemTMmUMDcSFGQNn7V7reEI4DVwEqLaq9C9
         9myg==
X-Forwarded-Encrypted: i=1; AJvYcCVRmBBKN8HBKpJn1UUfoloLkJ6vrvv2USPNdzVZ4eNqKOg9Um0/BOmdWWsyxgw0xAJj73HAC2fxvibZdHsVruqhPQuo5kw/CJKf8ys3
X-Gm-Message-State: AOJu0YyqOQJmD/2yprdKNSw2sn3IieDEHq/NfGUbngrHWCBR/3lQ/hH5
	qC1NaRbT+S2l6LUg173Z7HKcp2cbH3+V8pqIMsCqte9XyLRkW+OXCRvFC/JINQ==
X-Google-Smtp-Source: AGHT+IGyfyIJBYJTY8rklLWwv37s6BU98y6vjPcrG8g+PL/VK0zg6o62zicYugg3UHGVOU0ViEOYyA==
X-Received: by 2002:a05:6808:54:b0:3c1:40f4:92f4 with SMTP id v20-20020a056808005400b003c140f492f4mr3285999oic.16.1709085282433;
        Tue, 27 Feb 2024 17:54:42 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f4f0:fb4d:aa01:9068])
        by smtp.gmail.com with ESMTPSA id y38-20020a056a00182600b006e56277fd45sm148915pfa.190.2024.02.27.17.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:54:41 -0800 (PST)
Date: Wed, 28 Feb 2024 10:54:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org,
	akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
	yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] mm/zsmalloc: don't need to save tag bit in handle
Message-ID: <20240228015437.GB11972@google.com>
References: <20240227030045.3443702-1-chengming.zhou@linux.dev>
 <20240227075209.GA11972@google.com>
 <b54646e3-44bd-4937-a2dd-4b88ca7ab672@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54646e3-44bd-4937-a2dd-4b88ca7ab672@linux.dev>

On (24/02/27 16:16), Chengming Zhou wrote:
> On 2024/2/27 15:52, Sergey Senozhatsky wrote:
> > On (24/02/27 03:00), chengming.zhou@linux.dev wrote:
> >>
> >> We only need to save the position (pfn + obj_idx) in the handle, don't
> >> need to save tag bit in handle. So one more bit can be used as obj_idx.
> > 
> > [..]
> > 
> >> mm/zsmalloc: don't need to save tag bit in handle
> > 
> > Does this mean "don't need to reserve LSB for tag"?
> The head of object still need to reverve LSB, to save (handle | OBJ_ALLOCATED_TAG),
> only the handle doesn't need to reserve LSB, which save (pfn | obj_idx).

Correct.

> > We still save allocated tag in the handle, that's what
> > 
> > 	handle |= OBJ_ALLOCATED_TAG;
> 
> Yes, this result will be saved in the head of each allocated object.

Right, that's what I was talking about.

> >> Actually, the tag bit is only useful in zspage's memory space, to tell
> >> if an object is allocated or not.
> > 
> > I'm not completely sure if I follow this sentence.
> 
> What I mean is that only the head of each allocated object need to reverve LSB,
> which is used to check if allocated or not.
> 
> handle address -> handle (pfn + obj_idx) -> object: (handle | tag), real_object start
> 
> I'm not sure if this makes it clearer?

Yes, thanks. I think separating handle and object header in the commit
message will be helpful.

