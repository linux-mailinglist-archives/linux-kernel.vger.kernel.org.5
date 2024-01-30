Return-Path: <linux-kernel+bounces-43875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A8841A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6F1C2222B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733303717D;
	Tue, 30 Jan 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nDlLHJR+"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DF37145
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584657; cv=none; b=KD1E/zcrVCZvRmmvQGUjUaFWA/ABcjq09/JZ+OS/TWoz7FvJkbQY+C0eFXUUxdv/R2zlGM0K5aTAixAhDNwfNgGEl9ynfD8m3U7EEBGc0sW/+HsbA+55sYptD2xIml8oc5oGeTSlzoQkSzpUE3f3IZZ4zK2r8WR3azVaOC7UrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584657; c=relaxed/simple;
	bh=uVbohtlj7mu6cVDUW76JicilNRJfM5yB/HyXoIQ6x1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMghy+57sCssaKtA7Tx8tp8imOWnfWjZgw+ZhRmvzEApWUJQ1eX3SzGC7Cy3BBcL58Zn8cLRPmg+Ftyf0qaQKPGnrsF4QBMQUM3jm85Fa648jc/ZzHh34ZU7vasMDNS+R7Mp8I6NzjPBKFutS894L6sgKw/+0Y4ELe9qKjDUMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nDlLHJR+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a8a398cb2so32392501cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706584653; x=1707189453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+uMvYuPMcW2/oEhpWE+vBu0Mu5fnqXnYf4zI++OU9M=;
        b=nDlLHJR+CCl1Kgw8ONlCjZnjCZM/4t+D+YrHJU9ndvq/XeTYs3cLi6poi1kYyapXON
         Ivy02PRQDJ/++aroONXy1flNBL2JgiUFw/uKBrTWwf01lMZbDhkHEucfs8wRTgO8z2MY
         P9zFLKM+EUOxsPA4cP57iQE+aNh0aLs8WtPUXjoafiJH1Cn/3YW5bkn5BIVO+xhUIRl0
         LmwDjGnBpsmaEyD8SQi9A6BgIn0a8SOOWIQWg18cZKvBkzDUb5HhoiY0Lji7sPC/p/q6
         K9wLwtRbLRl0ei3KAv8rBAeINR+RFCHfGu+A8+P90urw90S1mO2plrLayy7C2Li9MLAy
         2n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584653; x=1707189453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+uMvYuPMcW2/oEhpWE+vBu0Mu5fnqXnYf4zI++OU9M=;
        b=mOzFB2cR98Zlia817ZubC/LtGSCzxTj2sUNpIaCMkLkxNpUsnhpLon2SW0KubEtOX2
         k+PcR2RgYP2pXXierilV8C1lr1maJNJA+YrWH49xsN74Lf6CqqBbukGMPV000Op3/MhB
         eySvNeJ4O2tC7IURSOPFciUgvn0/G90WcIyX1VyKILruxtb3E05arNFFQqxb9MioJtpE
         Rv7RQHV1XNdymqYK3uFHFvZ+nl9HVtXSw3FK/YBuE+iYdDcczQ2pbYGqIJZNJA5iyjqf
         oM+I4IqxCxlu0kheCOiF+jtRxKqCWCieq8lFxm5xduNrUMFJ/0VPJ1Q77RTlfLFIS3up
         0EUg==
X-Gm-Message-State: AOJu0YwmhrvGv6QI+aHZLwS27fTr5BZKXpWmPjKkBkI1EE41wTFIKvoG
	m5nTXZTzeF5I9ituCrCc/8RerZSV/DMRY01mcHx1CCdy3mQJb37bzD5UkeDQXBw=
X-Google-Smtp-Source: AGHT+IH2krtYpXrHWqQn8jUxf7oGQpxAVml/F9fI6Iv5KcFb1lopfNaMpnRwWqIrrTd1Htg3adZr+Q==
X-Received: by 2002:ac8:5988:0:b0:42a:ad64:bc09 with SMTP id e8-20020ac85988000000b0042aad64bc09mr1790712qte.119.1706584653281;
        Mon, 29 Jan 2024 19:17:33 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id cf5-20020a05622a400500b0042aab8ca417sm1028836qtb.3.2024.01.29.19.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:17:33 -0800 (PST)
Date: Mon, 29 Jan 2024 22:17:27 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chriscli@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/zswap: fix race between lru writeback and
 swapoff
Message-ID: <20240130031727.GA780575@cmpxchg.org>
References: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
 <20240126-zswap-writeback-race-v2-2-b10479847099@bytedance.com>
 <ZbhBNkayw1hNlkpL@google.com>
 <527bd543-97a5-4262-be73-6a5d21c2f896@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527bd543-97a5-4262-be73-6a5d21c2f896@bytedance.com>

On Tue, Jan 30, 2024 at 10:30:20AM +0800, Chengming Zhou wrote:
> On 2024/1/30 08:22, Yosry Ahmed wrote:
> > On Sun, Jan 28, 2024 at 01:28:50PM +0000, Chengming Zhou wrote:
> >> @@ -860,40 +839,47 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
> >>  {
> >>  	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
> >>  	bool *encountered_page_in_swapcache = (bool *)arg;
> >> -	struct zswap_tree *tree;
> >> -	pgoff_t swpoffset;
> >> +	swp_entry_t swpentry;
> >>  	enum lru_status ret = LRU_REMOVED_RETRY;
> >>  	int writeback_result;
> >>  
> >> +	/*
> >> +	 * Rotate the entry to the tail before unlocking the LRU,
> >> +	 * so that in case of an invalidation race concurrent
> >> +	 * reclaimers don't waste their time on it.
> >> +	 *
> >> +	 * If writeback succeeds, or failure is due to the entry
> >> +	 * being invalidated by the swap subsystem, the invalidation
> >> +	 * will unlink and free it.
> >> +	 *
> >> +	 * Temporary failures, where the same entry should be tried
> >> +	 * again immediately, almost never happen for this shrinker.
> >> +	 * We don't do any trylocking; -ENOMEM comes closest,
> >> +	 * but that's extremely rare and doesn't happen spuriously
> >> +	 * either. Don't bother distinguishing this case.
> >> +	 *
> >> +	 * But since they do exist in theory, the entry cannot just
> >> +	 * be unlinked, or we could leak it. Hence, rotate.
> > 
> > The entry cannot be unlinked because we cannot get a ref on it without
> > holding the tree lock, and we cannot deref the tree before we acquire a
> > swap cache ref in zswap_writeback_entry() -- or if
> > zswap_writeback_entry() fails. This should be called out explicitly
> > somewhere. Perhaps we can describe this whole deref dance with added
> > docs to shrink_memcg_cb().
> 
> Maybe we should add some comments before or after zswap_writeback_entry()?
> Or do you have some suggestions? I'm not good at this. :)

I agree with the suggestion of a central point to document this.

How about something like this:

/*
 * As soon as we drop the LRU lock, the entry can be freed by
 * a concurrent invalidation. This means the following:
 *
 * 1. We extract the swp_entry_t to the stack, allowing
 *    zswap_writeback_entry() to pin the swap entry and
 *    then validate the zwap entry against that swap entry's
 *    tree using pointer value comparison. Only when that
 *    is successful can the entry be dereferenced.
 *
 * 2. Usually, objects are taken off the LRU for reclaim. In
 *    this case this isn't possible, because if reclaim fails
 *    for whatever reason, we have no means of knowing if the
 *    entry is alive to put it back on the LRU.
 *
 *    So rotate it before dropping the lock. If the entry is
 *    written back or invalidated, the free path will unlink
 *    it. For failures, rotation is the right thing as well.
 *
 *    Temporary failures, where the same entry should be tried
 *    again immediately, almost never happen for this shrinker.
 *    We don't do any trylocking; -ENOMEM comes closest,
 *    but that's extremely rare and doesn't happen spuriously
 *    either. Don't bother distinguishing this case.
 */

> > We could also use a comment in zswap_writeback_entry() (or above it) to
> > state that we only deref the tree *after* we get the swapcache ref.
> 
> I just notice there are some comments in zswap_writeback_entry(), should
> we add more comments here?
> 
> 	/*
> 	 * folio is locked, and the swapcache is now secured against
> 	 * concurrent swapping to and from the slot. Verify that the
> 	 * swap entry hasn't been invalidated and recycled behind our
> 	 * backs (our zswap_entry reference doesn't prevent that), to
> 	 * avoid overwriting a new swap folio with old compressed data.
> 	 */

The bit in () is now stale, since we're not even holding a ref ;)

Otherwise, a brief note that entry can not be dereferenced until
validation would be helpful in zswap_writeback_entry(). The core of
the scheme I'd probably describe in shrink_memcg_cb(), though.

Can I ask a favor, though?

For non-critical updates to this patch, can you please make them
follow-up changes? I just sent out 20 cleanup patches on top of this
patch which would be super painful and error prone to rebase. I'd like
to avoid that if at all possible.

