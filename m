Return-Path: <linux-kernel+bounces-55887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59BC84C308
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C618B24738
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BAA13FF8;
	Wed,  7 Feb 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hg5NaB+5"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6B134A4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276115; cv=none; b=K5MWSv5RBT8JpEa5eVmH5Fd5bWeIre6zQUrd9gaYyozQzgVFXymeiRZOC2rI4edWURk4J91c5RghvUBx54apxCZzl307MSsptqvIT9ifSITNwQGdB9rm4J582duixBgyZWxm0Ud5CgeuwjmhAlFxU6YN24jVGH15sfDFc90jfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276115; c=relaxed/simple;
	bh=5pxzaNmMZc9+qSFaBDVXGxDHawGlWqY/JZ8hS8+iA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz6O5b8ZZVDKsCKajFp5GbrWpyZRmFflJUXoZGIPqUbAMVpWQchWEuwGYqoY8lYdcf8+UZYf9pCkiDmPpNDw5vcwwdpPiViJ5T3SkLH6nqUvABPEl9zncwpYDKffSaseVMSonPOyRA6zKiajzmRPAPltuH6bw14weEeNV34e0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hg5NaB+5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-296a5863237so1025030a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707276113; x=1707880913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvweSH+qaZmcX1cjz0FHPCeSe3ppOV6nsVuJOUHpS18=;
        b=Hg5NaB+5qH4U8XnMsCctozNra0lNjVsahf7j+AExLjJRv3Jr3e8IHJddILao0B7k/M
         dFvYG04kbDFIS9+W66nh0f9DSWet8Ji3JHlAGDLm0lDZdz+sIc8BvfDrbS0690Z206sy
         cVB4E0I/4pMVlao34Uo7kfsQalVDU1e9sqbcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276113; x=1707880913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvweSH+qaZmcX1cjz0FHPCeSe3ppOV6nsVuJOUHpS18=;
        b=LTboH/YS/3iKOWxbTUi7cu+2aCl4ZL4f5hb6Xg/3pu4GfAngpt4qbmzKW+zlVeL1Z6
         EHp4viOB4m4sMKSqVY4Ac0g1jAI0WkY+GKry77117J7nCNzEHBzVc1X+ks8U42BfJG4L
         a7iIymYk8c9UQEpOi+yZJtimwRE0twdDCrkQ75pgkx/8tboF5zmkM40ivZfig7QZNFrQ
         OGGDzJ+8szP2FTWeHJH3r8oacSJRzy1nswZQvJIEDKU+9QkGOMe4ZbZH3swht+EWO+E2
         a/+gz+FGMx1FnpyOXwb1Pcjm1Q2ofdZ5HRFA1MxOqa265k3F8qJnFh7/3hIF4mgXgu1c
         o0fQ==
X-Gm-Message-State: AOJu0YxFwiQ9M1NUV8LW1s7oce5mpgCyHu9lH5VOzr0IDKqSyst+2+Zy
	dwY74HvZ5hzV+ibUMIno/TIOfiJBJSEY4oi81ICRR5HrH9fT5uMncV7cvkl/tw==
X-Google-Smtp-Source: AGHT+IFJrrXprbZA+CjwH0Psh35AauMdJ0AuyLavTsMPHVZnSrSEAQq2gD2PzSdKXhnW3v8ZjxPsOg==
X-Received: by 2002:a17:90b:198e:b0:296:321c:9bdc with SMTP id mv14-20020a17090b198e00b00296321c9bdcmr1908930pjb.13.1707276113036;
        Tue, 06 Feb 2024 19:21:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW//AN5BX7VQ8JkwSzM/quJewDTXmLAecgV0tXzXipo0HobAr7UGghImrAeUePNCeTkSW877AftbHTzxouMh2hZCb0Aps8B+o7vF7E+0RJzp6ZskQqwfX08+JwR7fGVUp/UdkiGrv/jMCiBitpcn03LU1b/MFpWllH8GmlJ7mmibPQ9Kjob5vSx7Fo6kxfmJZhq+CI83bRzRqpysF9EFzwi5P+UcZOUnjq5O20Cv3OJXkj9CljVTxiYBdmAcJgCmugjn3m/r06oHyjtWebXgwW/RkBeNovY+Pc=
Received: from google.com ([2401:fa00:8f:203:679b:7168:b5c0:a415])
        by smtp.gmail.com with ESMTPSA id eu15-20020a17090af94f00b00296c9971348sm349487pjb.17.2024.02.06.19.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:21:52 -0800 (PST)
Date: Wed, 7 Feb 2024 12:21:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Message-ID: <20240207032148.GB489524@google.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
 <20240207031447.GA489524@google.com>
 <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk>

On (24/02/06 20:17), Jens Axboe wrote:
[..]
> >>> Minchan, if you have any objections, please chime in.
> >>
> >> Not Minchan, but I do have an issue with the title of the commit, it
> >> doesn't make any sense. Can the maintainer please re-write that to be
> >> something that is appropriate and actually describes what the patch
> >> does?
> > 
> > Thanks Jens. I fully agree, I requested a better commit message in
> > v1 feedback, we probably still can improve on this.
> > 
> > 
> > Something like this?
> > 
> > ---
> > 
> > zram: do not allocate physically contiguous strm buffers
> > 
> > Currently zram allocates 2 physically contigous pages per-CPU's
> > compression stream (we may have up to 3 streams per-CPU). Since
> > those buffers are per-CPU we allocate them from CPU hotplug path,
> > which may have higher risks of failed allocations on devices with
> > fragmented memory.
> > 
> > Switch to virtually contiguos allocations - crypto comp does not
> > seem impose requirements on compression working buffers to be
> > physically contiguous.
> 
> Yep, this is much better! Thanks.

Thanks.

Barry, can you please send v3 with the suggested subject and commit
message?

