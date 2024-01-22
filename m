Return-Path: <linux-kernel+bounces-34106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966E383739D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70491C27D41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C64121B;
	Mon, 22 Jan 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Q6yuwbop"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76F41201
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954756; cv=none; b=s4/nkNoreCZWbnqUzUO7qmhTqDVE3kC99xeXqHTrB2oWQ3FypOr3k7pVfZhXFYxPS/g2PBG/sGCK8wOo2nU7YE2/8mk6u5bTxu/qfUlOFvUIAU5jcQ5sXF9t8JjYCFlbbkM9saF+IwgLxnJL0nABM5A5wStGYrn5xwTgv1JvX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954756; c=relaxed/simple;
	bh=WGRz3yDXQ7ZugsNq5s4km9+e2+Bm1ZZBHh/607Zj9BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPKVvZJTLmLPkp91euZQPwj9FlDdUBEdu6zzUERVN4LiLCqFGJDrdMx8XE3SIiEMwa+N47NRyR2QHnkbGGsVErWFFSjSxxrkzIWF80dsKZlWt/NSfu5v0nRSbhGNzJyl4WzSVcuR/mFaou9eCUbmYC6z2jsvnyRb/Brr8VO5DRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Q6yuwbop; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59502aa878aso1620548eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705954753; x=1706559553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NoT11zTLPPNLq7U/0Tn/LKj8E+qKVGOinPojsoujb0=;
        b=Q6yuwbopu/K3wfuaYkZdL4MgOTZPk2PtmSI1SeWLRA6FZ+epu80wXzq3fmfDH+uNhZ
         L1vKwXuLgCRYjCpX0nSxaeGxplhWZy5rB1U+VS/PwbcsSWn7vuTuqRPqM953vuDTX37M
         fICVw5WCc5wKwgEzXJtfYUI2Df8CD0CZBNW0/e6AlpFEdDw8mLvicetK3XhvGG8QCD8p
         R3AhjD6s4dinROXmUeyLk9+zDMz2tz24kmXXh5EczDaTR2ncgVnIOJLj4gQJIOSbm1Oh
         JbZTFdTdbSUDlAg3tQs3M9ImIdscJazSt6tlAeRc3gChoXBcXF7+NpKIc1/QcE/SVgEo
         Hdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705954753; x=1706559553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NoT11zTLPPNLq7U/0Tn/LKj8E+qKVGOinPojsoujb0=;
        b=TkiNfJxXW+2j6SbfdDXHW3QV1faUDRAQqB+1GeAAs0sevn0kNODaDUP9wcTiV+ZPrE
         tG5OZ+/9Un62hDlhNvHfUVkmmEpjX2VGFqOo3mcB0qBmYIxZHzEshceODDm5bLeIXQEq
         AihFFN+QjeCJ8TXNDgusWk7OCs9NZe2XzhycplpipZ9IlMwol84f0EhIhqH5kC0cxm/t
         Ylt1Ky05gcQmBf3yFrkctUmpJZJwNkIGWXy5Sje0dRvJo2J9FXbleOz578SD16IwKfjV
         oSX2I/ZVvdth0JbbE0xsSa1jqTyXNXdI9CeRa7s9T1fqFFahvROOK+N+AHbTAuguDpaT
         Ibiw==
X-Gm-Message-State: AOJu0YzDKROW0Bz7nwWl072btjIb3YKZSO9jKRVLz6ojp2iBBWNvsmE4
	Vlp+cPsc5z8/mkQbG1NitOJdXhjBGw3YS2ikptlDw0Bwx5xQPKev1aEngPZqNFo=
X-Google-Smtp-Source: AGHT+IHda6lcIOzqckRc7eaql4DUk3B6/+M4uucKIEuwx7759ORha0DAlnI5e/7+CNHGPUraRGcvOA==
X-Received: by 2002:a05:6359:5181:b0:176:5615:3de4 with SMTP id od1-20020a056359518100b0017656153de4mr1316841rwb.6.1705954753008;
        Mon, 22 Jan 2024 12:19:13 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id pd10-20020a056214490a00b006845032c973sm354776qvb.124.2024.01.22.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 12:19:12 -0800 (PST)
Date: Mon, 22 Jan 2024 15:19:06 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
Message-ID: <20240122201906.GA1567330@cmpxchg.org>
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120024007.2850671-3-yosryahmed@google.com>

On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> called for all swap entries before zswap_swapoff() is called. This means
> that all zswap entries should already be removed from the tree. Simplify
> zswap_swapoff() by removing the tree cleanup loop, and leaving an
> assertion in its place.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

That's a great simplification.

Removing the tree->lock made me double take, but at this point the
swapfile and its cache should be fully dead and I don't see how any of
the zswap operations that take tree->lock could race at this point.

> ---
> Chengming, Chris, I think this should make the tree split and the xarray
> conversion patches simpler (especially the former). If others agree,
> both changes can be rebased on top of this.

The resulting code is definitely simpler, but this patch is not a
completely trivial cleanup, either. If you put it before Chengming's
patch and it breaks something, it would be difficult to pull out
without affecting the tree split.


