Return-Path: <linux-kernel+bounces-93697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3C87338C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE5B29BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFD5FB82;
	Wed,  6 Mar 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dhawFkYi"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF845F861
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719292; cv=none; b=PQB6zHu/phZNo1z7w+edeNa5yGU/mSDp7vd6vG95mPnQwLLuHUOYtGgCG86SuodM6G711JotvpeHTaCFyvvV4Stmzo5upI/rUos6mSmRqrM24Fy4c3Zhx0JmvCBQmAyTvck7178/W5v69EbRyKk7b5OFtxxTDqJw3KnTtsx/BvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719292; c=relaxed/simple;
	bh=xAdDe6dQomEORFaa1bExe/C2eZ99Z8ee6SsE1uK9ROM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCulipJfLbHt3KTP6bGM+lSP7RVH2txclsCJ4rrkdyTwqXI66CGVv4lw/MHv5m+AmmpAk5IJ/01xZiYURAJ5J/4j/X9ve9nVZiQBugxTdrYZR9Ug9+yXJ+mmzc8YRhzrdWGq/1Z8ZcbuSzuPTDlIGqQwyteNRmIlMw8t5zUdy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dhawFkYi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso1915529a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709719289; x=1710324089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAdDe6dQomEORFaa1bExe/C2eZ99Z8ee6SsE1uK9ROM=;
        b=dhawFkYit8n72LVYrSUXI2/0u0gkhrv+444CF8bVcYzsp1SaAS6mwHuFLDff9inxpu
         Gb9uysQGO3a6sjDH7jlZv4O11vvqp9CZpn6gYlbv5Wp5KGixKOhLk1oOjBaf4OLG0L1U
         mesva1RHhiMZ/C3jsU8h9zLCDylQ5V8HYFDNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719289; x=1710324089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAdDe6dQomEORFaa1bExe/C2eZ99Z8ee6SsE1uK9ROM=;
        b=Qz/ZavbP5ZXL5uhdVaX7x+zJtHmt8+NrGlP/8tE53e8hlj033I5nCrB5nBssky6uKV
         39KVm2vvtMcvNhLuqH6BzXjhyhOqOpUx74+NmbqmCLoavDXIGimb09oca2uLG1PL5Kwo
         SCfZMyTZSPoF+yNac8KUara43XCqDcUAyRRKzzIpUMnq6G1N1YnmmYm3lpYnP4Ru+FDz
         4FdUlQxdyzqAd/ldmJoZ0rwk86LalILwglMMalUxD8eUi85WrrCris0ckrHpqPjo/vYn
         dLJ2jCEFeKZ6Vs1v8zqGm994e+4Jl1UEgNt1xRIBqRhODPh0TdsWkF0TNkx0WbuNWQ0W
         Hg5Q==
X-Gm-Message-State: AOJu0Yw85W51Qq1qEg8iQpoigiPs5TG0PfXRdyVU6ztj3VRdPWM6l/Qe
	M3KaFtVOhPZcQwHUNqotJdQ1kGHg1XiOZ6d/20/FoKHNnJTjPxhacMOaJ7VC8bX9cdemQwexFDg
	/HCMuAAcbrzTKnCMlhY0ffLRFGQIUoKW1nAPPtUkCD0BOlAsbPOE=
X-Google-Smtp-Source: AGHT+IFDBhqs9g/3UKwHu218l/la87fPexeSsGsdIoalfWgyzMf5RYbc2YJ6ZgJNqyDhvkpz5KIiOUlcU5HvtQwcWn8=
X-Received: by 2002:a17:906:fa87:b0:a44:8ea2:23fa with SMTP id
 lt7-20020a170906fa8700b00a448ea223famr10452807ejb.46.1709719288810; Wed, 06
 Mar 2024 02:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
In-Reply-To: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 11:01:17 +0100
Message-ID: <CAJfpegtX_XAHhHS4XN1-=cOHy0ZUSxuA_OQO5tdujLVJdE1EdQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
To: Lei Huang <lei.huang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Aug 2023 at 20:37, Lei Huang <lei.huang@linux.intel.com> wrote:
>
> Our user space filesystem relies on fuse to provide POSIX interface.
> In our test, a known string is written into a file and the content
> is read back later to verify correct data returned. We observed wrong
> data returned in read buffer in rare cases although correct data are
> stored in our filesystem.
>
> Fuse kernel module calls iov_iter_get_pages2() to get the physical
> pages of the user-space read buffer passed in read(). The pages are
> not pinned to avoid page migration. When page migration occurs, the
> consequence are two-folds.
>
> 1) Applications do not receive correct data in read buffer.
> 2) fuse kernel writes data into a wrong place.
>
> Using iov_iter_extract_pages() to pin pages fixes the issue in our
> test.
>
> An auxiliary variable "struct page **pt_pages" is used in the patch
> to prepare the 2nd parameter for iov_iter_extract_pages() since
> iov_iter_get_pages2() uses a different type for the 2nd parameter.
>
> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>

Applied, with a modification to only unpin if
iov_iter_extract_will_pin() returns true.

Thanks,
Miklos

