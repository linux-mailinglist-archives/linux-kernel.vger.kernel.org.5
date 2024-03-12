Return-Path: <linux-kernel+bounces-99770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BD878D04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F0DB21BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13079C0;
	Tue, 12 Mar 2024 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="XZk1aV+B"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2916FF59
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210865; cv=none; b=YFv7AsCiPFPHt24O+KrQg+u0xBYDaEx27EZwbhMT8lHFh5Rzm2pF0OYSOebUiFCKzQRdD0t7NOqI9feR5E/tHSgKCjWXPQFcPUk0eHR372WUOetPhHvRm57VdXcgpyogcfa3f4c44IecxFU41vOrH9yuUiaVUGu+V3NvBW0rktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210865; c=relaxed/simple;
	bh=Jmy6Tw7F3sY8Z5+Gd5eo71IMr8d0DdObPTM7iHTRVDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEtgk1wHuu3MvsXzDuhD5iSs6UUKdGc2HviJMqNje55apELil/hOCBgSoJc/CA9gXvb2Z3J7FQx/r1ULXEMZJfRuME0j6e+GmT1FCxVnzVZlBacgH1uv/6DyT394dCkdFCX3n8cfiwGzwNFF9ELpUkpvso1dBFScBItaecO61Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=XZk1aV+B; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690c821e088so17321506d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710210861; x=1710815661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub7QivAAtZjYlqRZBrv6vJV8M2mzOE2hIvtqdNYKl2I=;
        b=XZk1aV+BUFd38FmFtaRJQlgkSUm7TnosgKgwr/4OuX+0S7iWb5ss4nrVSDWlIkDQza
         hJEmV4f9mRUlK8QG0EIyOOMgJ3PK05PyFctHgXR/K0xcUgvuVix0ELCxT3A/dlehBW9T
         PJv09dEYCZJ/3P+acM0fdZAe3H5v42A0+X3nSHfXbq1XS5GZ+dVginLX8UhsP7cssztV
         0tvfifQNYcrhRZPW9l/R2F2is7Dg1jKwm5EyuqAzVDu8XwuneFG75uo8aq53SkGcq3hK
         cDFTWS4N1SLdLqqm7Zv+xwgGGLwdtNFxLIIXcdAVPlWOlsGOiHb66OGqiNafdqlOlbxy
         tUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710210861; x=1710815661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub7QivAAtZjYlqRZBrv6vJV8M2mzOE2hIvtqdNYKl2I=;
        b=J+os67QY7Ilno7MDE/L6uFFNmsOIdH2TVxVipBa7h9VzgffMHO9udWICNWi2ZQPM/8
         42IjyP+/EnczAzVWgEI9cQyJf9ZwwR20FHj7OGk8Qg0Sismc345BS5uhpmmUKQBoal6k
         W8vOtjDlpOnbb7iKMsSDItWEGSk9mfVDmRi03hPi+viZWcA95DUYXYMYsc0ZjR6btnXR
         FIgss/02zjFvea7Q6aFVzuMy2GPVSl6ojSTBgblQgd0plq8gTUR9SU/+re6NjI1aYHKW
         WM1IbDJSWoISVLx8y22x6d9kEiLA3EKEfezlDpS6wT4Uyqh2QcPoDnJfLNs+rtsPBStJ
         Le7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwtIzAExwvtDXFzgVbnPtxTXXMy68bs7nH+OKapj6HvVBQBO4HpDPCSkZhhdM4AUVg9jQECamcM9gaOaYXWQk5lM1fzeq5f6q5BWZh
X-Gm-Message-State: AOJu0YzDamZ4Jgh8/qXIrZ9zdWL0B0vq8DZOqT7QP4oH2x0e27J3ciiQ
	YrCK574fo7C0pyA/V0+IhX3XrmytL8PXN2dOPI+87jMjKWtc9vsUU17W8BcD7z8=
X-Google-Smtp-Source: AGHT+IFZulKC4BK1ZVU8uTLFFrfjm6Xefz3DkxAwWmYaazdkd3ur2Bhrw0giRjFsHSXurhumfm+JBQ==
X-Received: by 2002:a0c:e20c:0:b0:690:e32a:76c7 with SMTP id q12-20020a0ce20c000000b00690e32a76c7mr1126158qvl.15.1710210860777;
        Mon, 11 Mar 2024 19:34:20 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ez16-20020ad45910000000b00690c7a788b6sm2346220qvb.48.2024.03.11.19.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 19:34:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 22:34:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: zswap: optimize zswap pool size tracking
Message-ID: <20240312023411.GA22705@cmpxchg.org>
References: <20240311161214.1145168-1-hannes@cmpxchg.org>
 <Ze-BH5HDNUG5ohJS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze-BH5HDNUG5ohJS@google.com>

On Mon, Mar 11, 2024 at 10:09:35PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 11, 2024 at 12:12:13PM -0400, Johannes Weiner wrote:
> > Profiling the munmap() of a zswapped memory region shows 50%(!) of the
> > total cycles currently going into updating the zswap_pool_total_size.
> 
> Yikes. I have always hated that size update scheme FWIW.
> 
> I have also wondered whether it makes sense to just maintain the number
> of pages in zswap as an atomic, like zswap_stored_pages. I guess your
> proposed scheme is even cheaper for the load/invalidate paths because we
> do nothing at all.  It could be an option if the aggregation in other
> paths ever becomes a problem, but we would need to make sure it
> doesn't regress the load/invalidate paths. Just sharing some thoughts.

Agree with you there. I actually tried doing it that way at first, but
noticed zram uses zs_get_total_pages() and actually wants a per-pool
count. I didn't want the backend to have to update two atomics, so I
settled for this version.

> > There are three consumers of this counter:
> > - store, to enforce the globally configured pool limit
> > - meminfo & debugfs, to report the size to the user
> > - shrink, to determine the batch size for each cycle
> > 
> > Instead of aggregating everytime an entry enters or exits the zswap
> > pool, aggregate the value from the zpools on-demand:
> > 
> > - Stores aggregate the counter anyway upon success. Aggregating to
> >   check the limit instead is the same amount of work.
> > 
> > - Meminfo & debugfs might benefit somewhat from a pre-aggregated
> >   counter, but aren't exactly hotpaths.
> > 
> > - Shrinking can aggregate once for every cycle instead of doing it for
> >   every freed entry. As the shrinker might work on tens or hundreds of
> >   objects per scan cycle, this is a large reduction in aggregations.
> > 
> > The paths that benefit dramatically are swapin, swapoff, and
> > unmaps. There could be millions of pages being processed until
> > somebody asks for the pool size again. This eliminates the pool size
> > updates from those paths entirely.
> 
> This looks like a big win, thanks! I wonder if you have any numbers of
> perf profiles to share. That would be nice to have, but I think the
> benefit is clear regardless.

I deleted the perf files already, but can re-run it tomorrow.

> I also like the implicit cleanup when we switch to maintaining the
> number of pages rather than bytes. The code looks much better with all
> the shifts and divisions gone :)
> 
> I have a couple of comments below. With them addressed, feel free to
> add:
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

> > @@ -1385,6 +1365,10 @@ static void shrink_worker(struct work_struct *w)
> >  {
> >  	struct mem_cgroup *memcg;
> >  	int ret, failures = 0;
> > +	unsigned long thr;
> > +
> > +	/* Reclaim down to the accept threshold */
> > +	thr = zswap_max_pages() * zswap_accept_thr_percent / 100;
> 
> This calculation is repeated twice, so I'd rather keep a helper for it
> as an alternative to zswap_can_accept(). Perhaps zswap_threshold_page()
> or zswap_acceptance_pages()?

Sounds good. I went with zswap_accept_thr_pages().

> > @@ -1711,6 +1700,13 @@ void zswap_swapoff(int type)
> >  
> >  static struct dentry *zswap_debugfs_root;
> >  
> > +static int debugfs_get_total_size(void *data, u64 *val)
> > +{
> > +	*val = zswap_total_pages() * PAGE_SIZE;
> > +	return 0;
> > +}
> > +DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu");
> 
> I think we are missing a newline here to maintain the current format
> (i.e "%llu\n").

Oops, good catch! I had verified the debugfs file (along with the
others) with 'grep . *', which hides that this is missing. Fixed up.

Thanks for taking a look. The incremental diff is below. I'll run the
tests and recapture the numbers tomorrow, then send v2.

diff --git a/mm/zswap.c b/mm/zswap.c
index 7c39327a7cc2..1a5cc7298306 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -504,6 +504,11 @@ static unsigned long zswap_max_pages(void)
 	return totalram_pages() * zswap_max_pool_percent / 100;
 }
 
+static unsigned long zswap_accept_thr_pages(void)
+{
+	return zswap_max_pages() * zswap_accept_thr_percent / 100;
+}
+
 unsigned long zswap_total_pages(void)
 {
 	struct zswap_pool *pool;
@@ -1368,7 +1373,7 @@ static void shrink_worker(struct work_struct *w)
 	unsigned long thr;
 
 	/* Reclaim down to the accept threshold */
-	thr = zswap_max_pages() * zswap_accept_thr_percent / 100;
+	thr = zswap_accept_thr_pages();
 
 	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
@@ -1493,9 +1498,7 @@ bool zswap_store(struct folio *folio)
 	}
 
 	if (zswap_pool_reached_full) {
-		unsigned long thr = max_pages * zswap_accept_thr_percent / 100;
-
-		if (cur_pages > thr)
+		if (cur_pages > zswap_accept_thr_pages())
 			goto shrink;
 		else
 			zswap_pool_reached_full = false;
@@ -1705,7 +1708,7 @@ static int debugfs_get_total_size(void *data, u64 *val)
 	*val = zswap_total_pages() * PAGE_SIZE;
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu");
+DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu\n");
 
 static int zswap_debugfs_init(void)
 {

