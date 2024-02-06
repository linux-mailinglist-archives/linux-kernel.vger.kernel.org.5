Return-Path: <linux-kernel+bounces-55224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87784B94D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5CA283641
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6271339A7;
	Tue,  6 Feb 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AX0jZkDe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E6A59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232533; cv=none; b=luwserlvKw/qwDMW5qHNzQyM+JRRLTF0ZnJ0WVOW5gZB5udT8E79zJADUkkp++UbMul5zlHZdbjJzsWCN/VWysBc6l7nU+EFPaIchZsLAEdzsYTBgrEr5SI2m/3OPhGxzyUcfAdY9wt1WezQaQqM5G0P7g8EGuSVifGeMuetA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232533; c=relaxed/simple;
	bh=inWx0OPLvr2OQjTcBlOb7olL8AjhKIRK7jtiD3HZZZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuO4DwaEmrKWrJTgoMlJrZW22pp90AnwJTYj9fcwNGwd8qVFkckGVyWUA3LTAhdNhg7lIAae1HJGUzpkaQVpq9GTjXd1FyhVCH4C/zdraKCVN1JvCS6byW62sWwx0gHM6YXTie9w6Da6Fml6EEK+QDj9sDaAVgWAth2EZF7RzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AX0jZkDe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so1287315a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707232528; x=1707837328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gBnKK77AV0+CN8NcnVmcSVbE7VVIsZ5+lIFHAO1uLY=;
        b=AX0jZkDeiHdbPo/VBNLzJ4JQEOyX3wgwzGVCi5MH/1G72gEoipby07dluMF6SpF670
         nsr7JUlPLvRM0pS+WZJ5CRyfRdK9e0U6ThqC7pSFyilpRzVu8/+CtjCJhwuLBTXFEUVW
         jRAI83uNOrivnAzi87fAhGB555LqnJpTz08RIPOqxZ/xeKxaUbpxsane9mt4cgwfuUui
         AIv9GgXlRPp9naVQ3S/5C+FQIrVk8aK7Mw+0i7fZdyk2Cc2MWr7ir6LcuPqoGq37dQ3+
         cJ7MFR2OVIq7taWsEBqaMfT0QiVqjH6t1+s6zu5CnOTNmy+lnh2n/lXeuqBBykXyEzoo
         Q6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232528; x=1707837328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gBnKK77AV0+CN8NcnVmcSVbE7VVIsZ5+lIFHAO1uLY=;
        b=ObXtsEQoTZPYh9Irr730R7YU/ZHy46hW+MlgWDkRkIqQ3sSR0wR4SnMKGHPDyT4fB2
         d/c0dRGmPXggzS4brMMsw2m0lqUKMPONdFtsgdbWT9u2TZWHOLI0FR+A/g9heL47rrJL
         DReegHzir9gP/8XOiONrAi4vXFX6Y10klyFzlDNH8f5Bg5cCBlgMmfpimLcyLmV0bfva
         KTOkFa0bq1cCi1JIqCUK+yd4XfI7cASeQoO/PGPdKlsvIAhJebyuQ0rDSMODbvONxraa
         Unwc5PVG+Vl9M9jGg6Wtkpbcm5U6ilDGPtYxJTMul4t7N8NNMa/Nh9io0iO8Bl6c8+7z
         jSLg==
X-Gm-Message-State: AOJu0Yz1Km+9/HV332YeCzczE3cCRWbayjHuq6siwYYviGGaxLBHmvwx
	uTZU0G3yNaxxp4p2zGsiw3JkJeZ6NZYSiGIryjrHHKG7KyGireS6sS+g4O7ZJWU=
X-Google-Smtp-Source: AGHT+IFQnaKZqeh5Rj4xqEMX0k6pttBa4Vu1n4Z0CI4CRMpqbmsUFuB5tmsthzYeBD6KzApNV8jfhw==
X-Received: by 2002:a17:906:7c4d:b0:a23:7633:59ae with SMTP id g13-20020a1709067c4d00b00a23763359aemr3112272ejp.9.1707232528329;
        Tue, 06 Feb 2024 07:15:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUg9wW+S7ycBthefkD2WByjBb+beZRpaMOnm58bFhiH+rMC4v4yIEFIixiiBRuvnLUWNHASoKCQ6koWvzr7wDfLACo/vhOqMf4D8E1dgCAwJywxwIBuWzPU0xOQNd8z9gAwuxqpRKpioQ0c0XXpwyu3Hy4rGpvg8oj19AFfLGP6XEg69HNLGGa+6/bE6BwM9hGKRFzC0qvOT4E6VqQYUu7Fi7mJ3qGP8w==
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a382ba97f95sm765703ejc.143.2024.02.06.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:15:28 -0800 (PST)
Date: Tue, 6 Feb 2024 16:15:23 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	yosryahmed@google.com, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_state: update zswap LRU's protection range with
 the folio locked
Message-ID: <20240206151523.GB54958@cmpxchg.org>
References: <20240205232442.3240571-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205232442.3240571-1-nphamcs@gmail.com>

On Mon, Feb 05, 2024 at 03:24:42PM -0800, Nhat Pham wrote:
> Move the zswap LRU protection range update above the swap_read_folio()
> call, and only when a new page is allocated. This is the case where
> (z)swapin could happen, which is a signal that the zswap shrinker should
> be more conservative with its reclaiming action.
> 
> It also prevents a race, in which folio migration can clear the
> memcg_data of the now unlocked folio, resulting in a warning in the
> inlined folio_lruvec() call.

The warning is the most probable outcome, and it will cause the update
to go against the root cgroup which is safe at least.

But AFAICS there is no ordering guarantee to rule out a UAF if the
lookup succeeds but the memcg and lruvec get freed before the update.

I think that part should be more prominent in the changelog. It's more
important than the first paragraph. Consider somebody scrolling
through the git log and trying to decide whether to backport or not;
it's helpful to describe the bug and its impact first thing, then put
the explanation of the fix after.

> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Would it make sense to add

	VM_WARN_ON_ONCE(!folio_test_locked(folio));

to zswap_folio_swapin() as well?

