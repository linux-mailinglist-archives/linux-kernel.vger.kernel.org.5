Return-Path: <linux-kernel+bounces-50547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF602847A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B48285B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAF182AE;
	Fri,  2 Feb 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aFG4K6G8"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6ED18050
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906236; cv=none; b=Nd3o94hKqZoQ2c+oAo0k+0A4cGD2J/WU3sj4s0kPKDr+uiFDqEko5L9xpSwS48YjzDgMe1mYK3at1YTUxJk4tR5nAQltwGTfO0ZJ3y94/Z8depSswFDqRoCJQgrplhEfpGGaSUV1bCMPdGvh/2wvxQfiaGjltqWo4OQfGbGY+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906236; c=relaxed/simple;
	bh=7Mvu1Qvmq1BUG1gJYlb4UcjxOFlgOR8rt+Lqx6uTvnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iJ3um2e06lMU8mWJxrWfgImZg606pz4kplEk3dROzpt7y5yn7rBday5nW2tSFBgmWqWwoZPfza/EGM4WTnZkh1UIpRAuYsMIsL8BMajf33Sjdn1jC+v4+EqYGDSHHG1WmOED5nnZn/zcTqvCEeX9mhiCBYoBWH6Z0xIwtrrubCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aFG4K6G8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d061f1e2feso29738011fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706906232; x=1707511032; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+Lf+IboQG1dTAVnxNBjsFez85NCfDl/n19nRqwUon8=;
        b=aFG4K6G8LcqNRYTrWhlGHYSgWWcFi+gMBdQJyUy0WDu67HodFz0nNogSSUgLlcJ7nA
         4Z6dQlcbjM5hXGnWMQ/iQG8eHjY2PbGrFQszPvjuBq1V7dnF6aOwHWUsngAER1+Qvq/W
         WENmVedkobibziQAlOo6LPTaQK1KEWQ+RdPyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906232; x=1707511032;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Lf+IboQG1dTAVnxNBjsFez85NCfDl/n19nRqwUon8=;
        b=hjNJoGOdwytQFWlswd7WcwIzuqahTuEMpuhj7RPorvgwI70hHzBq+LmVKgjzhJKBFk
         qctuHs+Z7trjFsYI/RnnNBZWFQ7T8j09c+y6h8NJZkexOiCkvqnCrEJV6Gzz+jNYX0nk
         tFKvOYSZHLlSnQNai1HKZGlF6v5nsJC52Nls0+T4TyTWKtkATm2f7jwpZ1M+MH8w0wNT
         yK0EIAwwSgy4okZBss9Hj7EJA9sFJ/D5SPfsRaPx8cvZ6Q92r5WA/fv3Pd6siGUinCsK
         N4PZ5uEPUVv59sSLDOwgxpzZ1g3aVTHKqb0mA6SpWBWgurFAB5JE7GucsaD/Vwbu/bq4
         vxYQ==
X-Gm-Message-State: AOJu0YzN8C2hVOGg0fUFmji85bDWpvYY2uf1l8vcDe8QdW4gpyCoRqNj
	qNGyYXZ1oa6/qAamk/W9Ga4Z2bvBJkdEmfyeM0X2CzlT1V1D1JrrG27ve6itpSK4WLuXe6OGQ8j
	TvsvWtA==
X-Google-Smtp-Source: AGHT+IE6gYdqdh77ZqzXW17FksZhx8uBEkyTRcOLg5I/d2c0S/fGaZ33J/HqWWm0qq8UO5FS8sxopA==
X-Received: by 2002:a05:6512:2030:b0:510:1b77:62d8 with SMTP id s16-20020a056512203000b005101b7762d8mr1962895lfs.23.1706906232263;
        Fri, 02 Feb 2024 12:37:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDzENwG5Neqf3yFG51fs7ReA2/F0oM1SiIreXAn3SUVDwrGUSYMuDKA2RyTzvsQAG3gCvWQPibE6RKAn/6mtUWLOk9cc5cgp0zlg+Q
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x21-20020a19f615000000b00510213a6afesm398891lfe.253.2024.02.02.12.37.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:37:11 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d066b82658so34777511fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:37:11 -0800 (PST)
X-Received: by 2002:a2e:9081:0:b0:2d0:643c:c2aa with SMTP id
 l1-20020a2e9081000000b002d0643cc2aamr2137336ljg.20.1706906231031; Fri, 02 Feb
 2024 12:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
In-Reply-To: <85714.1706902336@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 12:36:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Message-ID: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 11:32, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Unix system calls must be atomic.
>
> They either return an error, and that is a promise they made no changes.

That's actually not true, and never has been.

It's a good thing to aim for, but several errors means "some or all
may have been done".

EFAULT (for various system calls), ENOMEM and other errors are all
things that can happen after some of the system call has already been
done, and the rest failed.

There are lots of examples, but to pick one obvious VM example,
something like mlock() may well return an error after the area has
been successfully locked, but then the population of said pages failed
for some reason.

Of course, implementations can differ, and POSIX sometimes has insane
language that is actively incorrect.

Furthermore, the definition of "atomic" is unclear. For example, POSIX
claims that a "write()" system call is one atomic thing for regular
files, and some people think that means that you see all or nothing.
That's simply not true, and you'll see the write progress in various
indirect ways (look at intermediate file size with 'stat', look at
intermediate contents with 'mmap' etc etc).

So I agree that atomicity is something that people should always
*strive* for, but it's not some kind of final truth or absolute
requirement.

In the specific case of mseal(), I suspect there are very few reasons
ever *not* to be atomic, so in this particular context atomicity is
likely always something that should be guaranteed. But I just wanted
to point out that it's most definitely not a black-and-white issue in
the general case.

             Linus

