Return-Path: <linux-kernel+bounces-84559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51D86A848
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA51F23375
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94B2231A;
	Wed, 28 Feb 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZeupXzAx"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E272206E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100847; cv=none; b=HuzGbK2lcl+Y/23L7lsHKV39J/OJiXVmo04cfNx4EE3pGZZx+lcfPrGX1TvqkvhhiqE5ngLyS2u/9ssoQPuGOLpZe3+v/ox5P1NG3TR/I8PGJdGpbz4Ch1caecSnCcNhzjLXUlNX04JsHmYSt+djxch7GP2hULevCo+LbnXO1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100847; c=relaxed/simple;
	bh=12nycYZQ1aRgcuUCH0OFehoDWW1+NXqehLmtPLJJqFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCpHRoM1SWfuiF7+pRILzwL2no0n2bbmgVfsGDB+Ake/dxrm9MCg0VdT0bULky4GBfzn3bkp47DetDkHqqm1aCM3O8VtXq9iN+8oGE6ZcV+NxPwy8rRSfIBculkVc+LtBJIQBkhMRdbpsyQJqnXB46hYx32JkxEecd8YeUK1dXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZeupXzAx; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb9d54575cso3992526b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709100845; x=1709705645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YZK9rYAKLKlbEkTkUln4qXABZAOuRPgZMIaxIIRKSU=;
        b=ZeupXzAx80zXHM2HipvfVizUB7hmjMXmJmMo/0H92bTLeZKrwfqdZBRHouN4td4BeB
         2qgms2n20VdfWycTUNrtLaSCIdwG9SZPeG4N5vj1z7CLHmrWSYP+rDoFTvLdJDWEG8qf
         lljCaiqEZXnEn6zUD2zQj5Q/FYZDTv99+yYaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100845; x=1709705645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YZK9rYAKLKlbEkTkUln4qXABZAOuRPgZMIaxIIRKSU=;
        b=dBoPxON/beVun6GEZaqZR2pfRswyxyqaP9aSspt8RVlMSp5Dm2+Qf3eDpc/kJfjnPK
         2CXsVVwwNIoVtCTscWLrERJok43rMVm6q59MXItSJB+XyZK+f+gFki0shG72BEeKmJW4
         9/xb/NUSOE3Eis4vy+EEDa71r3Vu9pOMJPAf3BQdhs8cG4X/I5niu592XqLR7puVs39Y
         GPNzf+HjHanMe2ggvGn4T2tETXwwdJog1uKVdMlZ7h2hYu/3+87J5S9DTD3NAr6UvVTI
         k+PVd+0/dqO41uk0wex7+E5faiykXJ3jylbDKnu02U7pHlz87zuM9djIMxFen7Km0V1k
         cnHw==
X-Forwarded-Encrypted: i=1; AJvYcCUkV9YkqMbn1XeD3HlcbwPmcNk4ixSzgyMNLNutRPK1RZ/Mpd7orpe5dXX44zlsignezJ3wQKNUqB4bcc9sQ4HfvwUV1zoPRI7bSjyV
X-Gm-Message-State: AOJu0YwbSuQrItvzR4Jvgkr5XEBvXozekK9RDCDcdtK6L5Iy0nnW8p9h
	i7YPz4ZuwczpAAHI4JoTs7E6ex54el3NK8t/hYe3moEaQwtLLhzv5oirRGXM0A==
X-Google-Smtp-Source: AGHT+IEI8ekSagUeDaZFwR7wTPlSjwTCQ44y3FRd5rcJuls7tY+oxNVJARqKthLwgp48Es+n/vRmGw==
X-Received: by 2002:a05:6808:486:b0:3c1:66e4:47dd with SMTP id z6-20020a056808048600b003c166e447ddmr4062283oid.16.1709100845504;
        Tue, 27 Feb 2024 22:14:05 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:50c1:1ad2:3268:cacd])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7980d000000b006e1463c18f8sm7002428pfl.37.2024.02.27.22.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:14:05 -0800 (PST)
Date: Wed, 28 Feb 2024 15:14:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: don't hold locks of all pages when
 free_zspage()
Message-ID: <20240228061400.GL11972@google.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
 <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-zsmalloc-zspage-rcu-v1-1-456b0ef1a89d@bytedance.com>

On (24/02/27 03:02), Chengming Zhou wrote:
> @@ -834,13 +841,12 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
>  		VM_BUG_ON_PAGE(!PageLocked(page), page);
>  		next = get_next_page(page);
>  		reset_page(page);

reset_page()->__ClearPageMovable()->PageMovable() expects page to be
locked.

> -		unlock_page(page);
>  		dec_zone_page_state(page, NR_ZSPAGES);
>  		put_page(page);
>  		page = next;
>  	} while (page != NULL);

