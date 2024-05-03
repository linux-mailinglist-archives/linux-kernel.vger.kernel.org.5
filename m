Return-Path: <linux-kernel+bounces-168322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DB8BB66B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76DB1F23E13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E97E56750;
	Fri,  3 May 2024 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="huuBMvIb"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0042E3E0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773179; cv=none; b=NTC3f+VJW+9cfCukIDkcuBN8JRN1BrL6CApRilLPRReEv3DkZ7JCPychoEaspS+Aes5sYWBqvECRN3HtpytGRtQJmiAaJ/aMxYbCKJ/ExXsFtGYCCPJ+TNVqTQb1iophQJwprjGhJkwwR4KHToMwlU+j7dCzxUlb6GNVVkK1yxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773179; c=relaxed/simple;
	bh=d5soG/vdOcHc+T4G2kOCRoZhsfh2zUDag1A1J17X/z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmp5AgQ4aBcIedSIAgJY/OoxUADuNQSntor49QQtrjrNRwHg/wgJMk1BHdNF5W6nrm4GJ+1BnIXnRFjhITWj7voaI+7S+rrS2Mp9AA5Z0iLx0amAuovsTSunKcc/qw4YE9gbFasQ4MUQgJNh5c2LqdLdbLsiJIyfZgekRogY0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=huuBMvIb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a5f81af4so18528666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714773176; x=1715377976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7KwjGqB6cN3Dl955k2+YGPiXLoEdjHxOLmUV0m+ZBo=;
        b=huuBMvIbJRnhXNGnfhWTl/8RmzkvVfAA/eyOTiGwbrJpFW1AMRk4T2gc6j+pnbqa4g
         qkD29080e6P3DhOf0a4zzVcKj0oTS0l19mdgaBNgdbXLxQnAZ4vnD+aOs5IsnaDHcATT
         gZQ4zEBUYQFaZvFKsi4yYIvc0vm8F9Ue44vTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714773176; x=1715377976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7KwjGqB6cN3Dl955k2+YGPiXLoEdjHxOLmUV0m+ZBo=;
        b=Ls0I6fBN16YrrbBao8/9BSZsEAxuaCT9jWsJHGvm09/lxFoFwqjEv+DPXS53X81HYc
         16JOYlPoFNYwvsnCQiI2T27zq1VdcfRfp82/WJaV5R8pMNJYvxv0kHPSFBnYMMJDprJM
         11LH+efqlRRC5fp9WC/f/wnqK+hfpHsYiV+i6Wf6qV05Q8kEL9j4Vgd1UbpjQ0npDFnk
         zREF6i7KLO6y0e8KDZIJs26UWGKpRe+7SqM+EpJO1fgESJs8shIZHu4ZYfHxveG8YVDT
         pTyP+5pggbqmLZCXuz2KmAklulzeSeWZoXjGyOTkFiDxASsKH2gUbreobAAX+9wq/h3Z
         9/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpqjKzGpaif00ZQIJA9QTeDhLPVijiFOMHEu1l5ZU43rBtbdI4mVq88YoVzLlKSVLsHVNdkGe4Y4+Vfgh0/ygogvjv4VKLWI5X3x6C
X-Gm-Message-State: AOJu0YyaZekuyk9+awQNuNNoAvt3/2WIK2ew7IpVMk84Za6BmkfieTPh
	SxKs4METUh0nyVUHRuBndBPVeWWMOi2KQFZaD2vswOQyYn6Th5Gr0kFVZJYUxvsQlS+9+CDv7E8
	jDSzTEQ==
X-Google-Smtp-Source: AGHT+IFGxHgYcp/H6KhNb8EKYEhe0xK6mCTjl3AuFPADnxYT8yJJWnP6XA2o9a5PcoUQkSy3FbyZeA==
X-Received: by 2002:a17:906:2610:b0:a58:7f48:18c4 with SMTP id h16-20020a170906261000b00a587f4818c4mr2342501ejc.68.1714773176437;
        Fri, 03 May 2024 14:52:56 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906391100b00a5992566e62sm1109776eje.85.2024.05.03.14.52.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:52:55 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58a36008ceso16640266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:52:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjGO5c6TwiAEhql1fzdEEiRTxT5Y7gR2nTyazXV6cVVoPvNnbzH7GGrJzhyAD9dzayphP5Hr2Xpz2pxJdnqkzGcfYOoFTW7WYNXbci
X-Received: by 2002:a17:906:eca8:b0:a58:c639:9518 with SMTP id
 qh8-20020a170906eca800b00a58c6399518mr2622517ejb.76.1714773175036; Fri, 03
 May 2024 14:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240503214531.GB2118490@ZenIV>
In-Reply-To: <20240503214531.GB2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:52:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
Message-ID: <CAHk-=wgC+QpveKCJpeqsaORu7htoNNKA8mp+d9mvJEXmSKjhbw@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: keescook@chromium.org, axboe@kernel.dk, brauner@kernel.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> How do you get through eventpoll_release_file() while someone
> has entered ep_item_poll()?

Doesn't matter.

Look, it's enough that the file count has gone down to zero. You may
not even have gotten to eventpoll_release_file() yet - the important
part is that you're on your *way* to it.

That means that the file will be released - and it means that you have
violated all the refcounting rules for poll().

So I think you're barking up the wrong tree.

                  Linus

