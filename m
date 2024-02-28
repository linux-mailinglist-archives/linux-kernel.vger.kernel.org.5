Return-Path: <linux-kernel+bounces-84555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E30786A83A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7ED28B71C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149A2261B;
	Wed, 28 Feb 2024 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbP3/wLY"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CF225AE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100482; cv=none; b=fjXB3OKxfWWtxcIJfQeG36eP6x+Mqxxn7F9eYLYem6JEkuZv5Hq0rTL0JkN4/eYgyDWu+0ZakqKLkeXRo40V57b1aG6rE5HZdjw8z71TOPJpl88DGaOxUPjk7/WfH74BgOKLHdHTX9ndx22tm60LOkB8s9WLnddbUqUkZsAug+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100482; c=relaxed/simple;
	bh=mvlF08pv/DSbP99HlcEUEOnhnotN8+l8l/FIsGOsMqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr1250Et6zH/Nu1FXxwdsz/q9mb8fJPI2/CNrIqtbzuFjO7RD7Xfgu0yycK5ClUjKNdM96KGllfGbfYYdvfbsG0mpA5qWrBZPGH0+6sCOI99hMU9kUEd5nBTIRYBT+9edk0K3wxlCZINNiGpH8J21zER2dfPddRyP8jp49j8NSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PbP3/wLY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29aa8c4710bso420459a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709100480; x=1709705280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MeKU9LAERyJoKW+mNk4qVeJIhy/Zeo/llG2Crnx8dtI=;
        b=PbP3/wLYKAYF3Ieywrkjoohj2STu5NNjdJIvMxchU61QWOMvfcyUT1Ethff1DkP90N
         lj1/4fXdX1Njxc6fs1P2THYJ2ChiNl7FTFxKzdyCDHGpifEVSFpdcTrv92GKlOor7Gvm
         2BYgj694eO5EPXK12VLoH5SsabzdAqhrR0DPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100480; x=1709705280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeKU9LAERyJoKW+mNk4qVeJIhy/Zeo/llG2Crnx8dtI=;
        b=UdtEvqZJYwQmlSReZ2+TUFbLnjyti+PmjgrLJPF1VBN98mBzOIt6gfzUbZrCucjBoO
         0tijjZ3ln4EYToSs4nZO+mrqPF9Z+JPchhFOT1/E0oNukWJviP47XVu/QVMu/6rg7FcL
         +lzOkJF52eAF/d959xVPm/9Cy+mxvwYu4lpnZKsQtLfR28dmrVFi1ODkRGW2AVPFbYru
         If/I59q1GPsu9OLHLa8XIng+tdQAHWJODCITeIVjmHRIzgcCxfI5Y4Ted8EW4v0YLvfZ
         8tl22vxADU8NWPy3SIbtvzYckrYN4pfpIOjF18sqk+SsSh20mUFlnCRsPOOIasfGUY6o
         wu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWAvhfXOPC2wWzm5kxw75mblx7BhugM1/YXPVq63M3YbyarvHvukqxj1EkbgJ03v1L9pcLYPfMqpBtAlQBqVrWqKkJdE5I6JC1vWfv1
X-Gm-Message-State: AOJu0YxuvuzwmpgVBl3C0HGXf0P2ZTcpRWfPRwiHBCsbuIhLiGtlYlJB
	ByG9Hta/Xpc4z+jQLcaPb7/KtE0DbZcMCjisFPv+y8MOoE6Btbyb4Ys+Z1KVSQ==
X-Google-Smtp-Source: AGHT+IEu++Dtdm+Ls8/lxFgAIO7qDrPLVd2IJ6PrQUeBFnqrJPVzqTCR5jKvm4uWQjzqFBDNcn0Qsg==
X-Received: by 2002:a17:90a:2ecb:b0:299:1cce:f3c3 with SMTP id h11-20020a17090a2ecb00b002991ccef3c3mr2161789pjs.7.1709100480487;
        Tue, 27 Feb 2024 22:08:00 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id ta6-20020a17090b4ec600b0029a849e7268sm647056pjb.28.2024.02.27.22.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:08:00 -0800 (PST)
Date: Wed, 28 Feb 2024 15:07:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <zhouchengming@bytedance.com>, yosryahmed@google.com,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Message-ID: <20240228060756.GK11972@google.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
 <20240228043358.GF11972@google.com>
 <5a556476-05b2-483e-8875-eeb3e2a51151@linux.dev>
 <20240228052906.GI11972@google.com>
 <913f1a04-8fa2-46b0-85dc-edd23477a1d6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913f1a04-8fa2-46b0-85dc-edd23477a1d6@linux.dev>

On (24/02/28 13:42), Chengming Zhou wrote:
> > I'm curious if we want to add RCU to the picture, given that zsmalloc
> > is quite often run under memory pressure.
> 
> Yes, it's a reasonable point. But given struct zspage size has only 56 bytes,
> it maybe not a problem to delay its free to RCU?

Hmm, yeah, probably.  I think it'll make sense to wait for more
"go for it" from Cc-ed folks before we land this series.

