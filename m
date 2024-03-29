Return-Path: <linux-kernel+bounces-125261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA08922F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE261C23BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEED13473B;
	Fri, 29 Mar 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UltUSgYP"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC255A923
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734302; cv=none; b=nIwm7FHKdy7j/mqj5kZDZ66deKJquyzEkjWO4aW6i/LdzISCdVVxVBeeuNPpHdrRhRDwvMZxl87xziGpG+rias2PMenLP0qaigg7J9BJpne3GmwBKZQ2ikjAGa7SYSUtZKW6N6LbirJDVkp9G5aOE4QWJBV8T8lpJKfuq7Qga8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734302; c=relaxed/simple;
	bh=D/JO4zokBTwiVQDIBJzqumFwwEXMzp78pjyJU0lup9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKjRFSbv15RIfEWONnsrvyXkynWBGJV5k0e7SEXRjYdIYqxgNBRbg1aE7qeK4C+o6mjgLDsBOlk/bX5/lLiOXv9KHO65Pfed/5vsZ0tVGib+U8O9pwrkeapG6gaK5h5dZRHUtg6A9nvSsLnwD4MNmsyndy3CsA29S3lB09tfzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UltUSgYP; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a529a1f69aso1251541eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711734299; x=1712339099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7WPAvDk3zSOm8wRKlGIEh/4VbBWjZSS4f1jGmiLObHs=;
        b=UltUSgYP+v3SxKsNPXRWTwlTy7OZ56WNa8D2SBlGcZbcTrwlNJUFx5UsuntBX4PiBw
         XohnBB2tzjiCP2P4WAmLtYq6ZuWabuk7IFqY3rSCn/jPrY0HjpUUkFzYlHUrD7SydE/d
         xbIH0xwH1v5wEni8dBkhrWlSvi8gy8MKfqu4MKoiUVFAq/qU8Ed3WKbtZRaRwTleXbnG
         rkvpsvr6bkXDTDKOLB3Kgc2ZbjTpNly+AmShZXHHWKz/gsqiTmsavHB8fiRa8wV2d+jk
         zDSq44VCR1X8tqifSsg32m8C+L+TJAAei90V8H/EeyOlUhwec2GyY67hDixYjJbc+lQN
         b1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734299; x=1712339099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WPAvDk3zSOm8wRKlGIEh/4VbBWjZSS4f1jGmiLObHs=;
        b=Soh6yNSf+SZrHdNhqRP1idbPXJBHrGk2oKspCbhZnn4N4g4uVg1EKwET6NtY/u/CfX
         74mOcY27I0SCkz1g7DbWPLmNyCGn71TRwr1m/qha/tXlqKVYQwpbSpJXkdkMdB6/GQcI
         8JouaG310n8jYqSiuqGmlqpufrrn2G6p+7UjNUJ9dO3okiWK6nIv5CPFK7G2BLCN1qTT
         X0hmwdjcRM548RpAKdrhXaNQxjYXLgZagS0bgumkAzaHmhGJyPCMCOyWP2H+GmTXfn+K
         Bm6kSISLnlhn76/sQNfJ6BhYZBjdG0NUvJ+l7dpTAbgNDU4bt5PqsRFqS9DSZYfNdG+P
         e9jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7o9732rmc2/E/MkAob//Pa1kJT7lI0jIUj3R7hg1sDqxBjYcwjHfQzV6E4SUYzEl5/wFEtija81pGReLC/J1QqF67sgUCP5jn22s3
X-Gm-Message-State: AOJu0YzBnhM78YtaYi0a7ZMlRkp7nehKM5rjpMG9yq735/0FfwArisYS
	+mniMr7QLRnHlPjUSKD8thprp2NoXaHwYedbPYrTD6p9vPjr9hyvTeC1Ebs1e9o=
X-Google-Smtp-Source: AGHT+IEIzPlo+It4MAJPfvDzbeEPRL2P2vMXkvnLLN0ScdfPGcVa/y8QPQLon5sEmO5iFrWXPYciLg==
X-Received: by 2002:a05:6870:231d:b0:22a:9ea4:c18 with SMTP id w29-20020a056870231d00b0022a9ea40c18mr3176254oao.15.1711734298746;
        Fri, 29 Mar 2024 10:44:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8604a000000b004313141f734sm1803750qtm.46.2024.03.29.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:44:58 -0700 (PDT)
Date: Fri, 29 Mar 2024 13:44:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/9] mm: zswap: remove zswap_same_filled_pages_enabled
Message-ID: <20240329174457.GJ7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-6-yosryahmed@google.com>
 <20240328191109.GE7597@cmpxchg.org>
 <CAJD7tka4iKD0=MOkj7iBCXvG6Jmq6WQgvRNV3mY+YRWPnYWmAg@mail.gmail.com>
 <CAJD7tkYo90ynKfBcWyMZLu7r-GJj3egnnJyGiJ5T2SN-Tn3d9A@mail.gmail.com>
 <19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name>

On Fri, Mar 29, 2024 at 03:02:10PM +0100, Maciej S. Szmigiero wrote:
> On 29.03.2024 03:14, Yosry Ahmed wrote:
> > On Thu, Mar 28, 2024 at 1:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>
> >> On Thu, Mar 28, 2024 at 12:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >>>
> >>> On Mon, Mar 25, 2024 at 11:50:13PM +0000, Yosry Ahmed wrote:
> >>>> There is no logical reason to refuse storing same-filled pages more
> >>>> efficiently and opt for compression. Remove the userspace knob.
> >>>>
> >>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>>
> >>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >>>
> >>> I also think the non_same_filled_pages_enabled option should go
> >>> away. Both of these tunables are pretty bizarre.
> >>
> >> Happy to remove both in the next version :)
> > 
> > I thought non_same_filled_pages_enabled was introduced with the
> > initial support for same-filled pages, but it was introduced
> > separately (and much more recently):
> > https://lore.kernel.org/all/7dbafa963e8bab43608189abbe2067f4b9287831.1641247624.git.maciej.szmigiero@oracle.com/
> > 
> > I am CCing Maciej to hear more about the use case for this.
> 
> Thanks for CCing me.
> 
> I introduced "non_same_filled_pages_enabled" a few years ago to
> enable using zswap in a lightweight mode where it is only used for
> its ability to store same-filled pages effectively.

But all the pages it rejects go to disk swap instead, which is much
slower than compression...

> As far as I remember, there were some interactions between full
> zswap and the cgroup memory controller - like, it made it easier
> for an aggressive workload to exceed its cgroup memory.high limits.

Ok, that makes sense! A container fairness measure, rather than a
performance optimization.

Fair enough, but that's moot then with cgroup accounting of the
backing memory, f4840ccfca25 ("zswap: memcg accounting").

Thanks for prodiving context.

