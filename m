Return-Path: <linux-kernel+bounces-162338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A38B598C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BAE1F21F38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE5745E5;
	Mon, 29 Apr 2024 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS1ujtiX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94A74431
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396228; cv=none; b=D7jmPO9KxwdQrBGFH7G0Rw95N457Psw8qab4qsh+pL6tfTwDOe5so/7bhOd9Tt/mEfBMnPaFkf//oCgN/0e6H5PSJTMluh52Z6sHAw4W3ntFEBBKl1R/AH2lPl+zjpDdtz3l4n9MO4VNpGzBnrD6qPvyFFEqJXgLnF2buVR4tHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396228; c=relaxed/simple;
	bh=XlmmX0KZjLD/kDmKaaL/EXxPqMDOJASOyO9Ds9GFzvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJPtC7s9Mvw4FVGBxgBM/wUui/rExDgf0nuA8Lya2Ergm59X8T3A9yDlIFu8F66ZanjBwKUUeU+eFk/mFmXXBmNPBDdMxjNzRNY60dB0J+2DEAXd7ClkSvDey1jEX36MpzX25c31NHPSUwCvc1sC/mVe/5/XFibwuqT8Qk6zQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LS1ujtiX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714396225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkfFCXYv9UcZuwlRLfrkkATbPa3Z5klq1PrYHXMu/1k=;
	b=LS1ujtiXGc7n0MDCTdzMI5cni6DEwZYnb5V1hChlbUNZsAHhsNm026p0RPdSPiQDPHESI6
	2aWJHiL8QfGsw4ebUjfxL4LCWIrf/bJ4yI8AuNBZFA5LnarBBxszu3UgYLAffrUwTerY6Q
	i24q29E9J5XUUmIGq3NKAsj07vbkyq8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-H4d3ON9INOSUc1jvGFBbdw-1; Mon, 29 Apr 2024 09:10:20 -0400
X-MC-Unique: H4d3ON9INOSUc1jvGFBbdw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a0cf97d669so118906d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714396220; x=1715001020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkfFCXYv9UcZuwlRLfrkkATbPa3Z5klq1PrYHXMu/1k=;
        b=Vxj8zupvbMi8r34MeghutcDjd2B1ysPbUxj1dk9nF3FGmSO03jec3k66FOQuUiKMWu
         icDW7s+y0118wu+4NleI+6Bwo74nful0rBgWEhduCHIlfKaevhNB6AlwwNPGmXzSYP28
         l3IYFbK4PaVa5M96PQg4dP6JhQ5DheV74wF9LfYlqcYVq8MYGY0daWi8DuXW9dpWrVP1
         yUlYZj6yzkDKMYFLXoXsNwJCDWlYXGPz0GUjPrmmKw/XnTlgjbTTzqpAcwHGJdazQ0a/
         totMLtuvr85uMRGzBd+u3+zPhcCpY/dRS+gGEAKQxAi9D4IPDO7QBhZiL2fPTj6WXIcj
         epSA==
X-Gm-Message-State: AOJu0YzgQffr4putw1BIwKV283QRzTRJGNrZBzFyepw3EELUd9EcbNoA
	Moe7GX1F7gmayBIuSMnJPijI5saB1Fcc8IYUoCXHqensm078SRFireuXQuA3/Pbpwss5GmzvnUg
	3+OWKoU9h5rLoonr/1r2xVqsE4J2GTQrqLCF28qXBANoXI5X2SPAWEmyR/TAsYiX8f4g1UQ==
X-Received: by 2002:a05:6214:d08:b0:69b:7d34:9f6 with SMTP id 8-20020a0562140d0800b0069b7d3409f6mr11995232qvh.5.1714396219888;
        Mon, 29 Apr 2024 06:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3QEggTWhye5fJGV3QCGhFkQqVWr8moqX+4hjr2aO72fCK+ZED3EYpcL7QxN7jCYiTunNTIg==
X-Received: by 2002:a05:6214:d08:b0:69b:7d34:9f6 with SMTP id 8-20020a0562140d0800b0069b7d3409f6mr11995189qvh.5.1714396219169;
        Mon, 29 Apr 2024 06:10:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id g6-20020a0cf846000000b0069b7edb9665sm1896238qvo.19.2024.04.29.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:10:18 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:10:16 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/2] mm/selftests: Don't prefault in gup_longterm tests
Message-ID: <Zi-cONgqV4_kUIE4@x1n>
References: <20240428190151.201002-1-peterx@redhat.com>
 <20240428190151.201002-3-peterx@redhat.com>
 <4171dbb6-81c0-4553-a405-a55f75be4cb7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4171dbb6-81c0-4553-a405-a55f75be4cb7@redhat.com>

On Mon, Apr 29, 2024 at 09:28:15AM +0200, David Hildenbrand wrote:
> On 28.04.24 21:01, Peter Xu wrote:
> > Prefault, especially with RW, makes the GUP test too easy, and may not yet
> > reach the core of the test.
> > 
> > For example, R/O longterm pins will just hit, pte_write()==true for
> > whatever cases, the unsharing logic won't be ever tested.
> > 
> > This patch remove the prefault.  This tortures more code paths at least to
> > cover the unshare care for R/O longterm pins, in which case the first R/O
> > GUP attempt will fault in the page R/O first, then the 2nd will go through
> > the unshare path, checking whether an unshare is needed.
> > 
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   tools/testing/selftests/mm/gup_longterm.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> > index ad168d35b23b..488e32186246 100644
> > --- a/tools/testing/selftests/mm/gup_longterm.c
> > +++ b/tools/testing/selftests/mm/gup_longterm.c
> > @@ -119,10 +119,16 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
> >   	}
> >   	/*
> > -	 * Fault in the page writable such that GUP-fast can eventually pin
> > -	 * it immediately.
> > +	 * Explicitly avoid pre-faulting in the page, this can help testing
> > +	 * more code paths.
> > +	 *
> > +	 * Take example of an upcoming R/O pin test, if we RW prefault the
> > +	 * page, such pin will directly skip R/O unsharing and the longterm
> > +	 * pin will success mostly always.  When not prefaulted, R/O
> > +	 * longterm pin will first fault in a RO page, then the 2nd round
> > +	 * it'll go via the unshare check.  Otherwise those paths aren't
> > +	 * covered.
> >   	 */
> This will mean that GUP-fast never succeeds, which removes quite some testing
> coverage for most other tests here.
> 
> Note that the main motivation of this test was to test gup_fast_folio_allowed(),
> where we had issues with GUP-fast during development.

Ah I didn't notice that, as I thought that whitelists memfd ones.

> 
> Would the following also get the job done?
> 
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index ad168d35b23b7..e917a7c58d571 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -92,7 +92,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  {
>  	__fsword_t fs_type = get_fs_type(fd);
>  	bool should_work;
> -	char *mem;
> +	char tmp, *mem;
>  	int ret;
>  	if (ftruncate(fd, size)) {
> @@ -119,10 +119,19 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>  	}
>  	/*
> -	 * Fault in the page writable such that GUP-fast can eventually pin
> -	 * it immediately.
> +	 * Fault in the page such that GUP-fast might be able to pin it
> +	 * immediately. To cover more cases, don't fault in pages writable when
> +	 * R/O pinning.
>  	 */
> -	memset(mem, 0, size);
> +	switch (type) {
> +	case TEST_TYPE_RO:
> +	case TEST_TYPE_RO_FAST:
> +		tmp = *mem;
> +		asm volatile("" : "+r" (tmp));
> +		break;
> +	default:
> +		memset(mem, 0, size);
> +	};
>  	switch (type) {
>  	case TEST_TYPE_RO:

Yes this could work too.

The test patch here doesn't need to rush. David, how about you prepare a
better and verified patch and post it separately, making sure to cover all
the things we used to cover plus the unshare?  IIUC it used to be not
touched because of pte_write() always returns true with a write prefault.

Then we let patch 1 go through first, and drop this one?

Thanks,

-- 
Peter Xu


