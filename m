Return-Path: <linux-kernel+bounces-63986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EC853815
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202A11F2A0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634B45FF13;
	Tue, 13 Feb 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="flGudyZ6"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEEC5F54E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845567; cv=none; b=FwMs37uhbhTB4YgPb+4aDpWdpm6KysLx+0OWF2FN0laD++07aCYdkeaBPIG7XxRAJk3zisVyXYYo12x1+tA5Dj+mnBpjnV9lbfytmi7yoWK1nahMwlb9GAK7r4mJ6mvidhf4871XGv6lLcwQ8Z6emk873jb8fXWTOJlFn90KZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845567; c=relaxed/simple;
	bh=iJMyZXHO7leEKGXhY0RvUlFLHk+bBBH4GfVWofDT1e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q40pJ+QPRZdblTsrlA93oGlZQe6SpAvLbEL91/rQHk6jfttLR73104Ll6hQhE544hCS7hKiUzT6kv1/9WbEL5yxsArl1er+kDy6ddV3i2gEemRJI1nH4ekzbmG2ow8FaasMng6dEHZkLEBc8CFufUUC0FTJvcTNPvS3OAgAZb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=flGudyZ6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5116ec49081so4975273e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707845563; x=1708450363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPPSCHNmyHJjHQxpEEbKRb+P78oA8H97JN/+h8y14s8=;
        b=flGudyZ6DY8rSOV2YcXSYZpHWKfXeNqUv0EOWMeoT5ixxJRaUrWx3YwD/+7wv66ViR
         J5o/iddSRHXemBJk7TvnPyhuTlrGLK/KeqpuJAIMffEo6oZhaDa5Qp1joGusqZgDDUQC
         mtZYPKJ1uiqiQlIOmU8t6TlY06wOQL9OU0YBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845563; x=1708450363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPPSCHNmyHJjHQxpEEbKRb+P78oA8H97JN/+h8y14s8=;
        b=ihclBF8V0fYX39A8YvLAJIjg5CvY+i1SWjIlWx7s+eUNnfpBg7A5ihtRIw0STjNGBg
         x4S524nfq6xRLVqYoN+q3L5ZYnU1oU+L0jeoNl19gQGPLTvGNjHDT8NtOox3lJs+2mow
         k9Nm4lztyY7GHz/5yFoJMh/ZSwsmOSPb4+bT6//K8rRyhSMpuFoaXbasyNoSpQiDlVUu
         7Li5V5vpazinT+6x20boM7+gCeM9IDbkK+dAr/InHvpVlFv7xPVqh3qSvEdbrr58jdSV
         4nQaTq013+C03TCv/q54D/3UhfPG+bcw5PBfbTG3b6M0SiMCdlR2DZPE6MPnPPlEBFKe
         UKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUizSk+o3RRLdyENSzs0m+Tzbb6WejKQW6PglEs4199+Y03jxgBF7gmhuA7Zkl31pp8v/idJBbqQMsF0rbFd6uO3KEGhFKkDL11riJ/
X-Gm-Message-State: AOJu0YxuBacAT8j7vtPkcqBVY+9q/BSfWmXZaoiN39lB/GjbVF+AoXGN
	iRfGM2wVNIfFFxg1hRtKEuUrjD2ZpB7Tpi+j+/z+RgMtxjZYSjBluQOkWCTJO+ykWEZxIHtK3OW
	zddo50A==
X-Google-Smtp-Source: AGHT+IFnAghZh1w3ziINTKtbSF2pW56J8XVKeB84XtRJTBi0AWqSP1yGnidBSHM0e63UupbafAv5PQ==
X-Received: by 2002:ac2:4550:0:b0:511:54a8:3adb with SMTP id j16-20020ac24550000000b0051154a83adbmr174617lfm.2.1707845563279;
        Tue, 13 Feb 2024 09:32:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWD7M3fo469pWjbrFuBbjNdY13Xk/9EvVSP6WhRneGJlJrn8jbFCaAXvc7d4AnfPk9V8g4NdRCNiBVfrdnHPfrUZZtqb8LjdMq4zoL
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g24-20020ac25398000000b005117c7159a1sm1346749lfh.257.2024.02.13.09.32.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:32:42 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116ec49081so4975259e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHacqw5ACNWCqD7aK6ipESA843Xq5S7YdueuSh0Sptp1IJFd/+sfDHbu7KicrvkMgYC6yEIY8IDfet7XWPhWi2IPqqMY2tn5WtsEuM
X-Received: by 2002:ac2:4a6a:0:b0:511:8677:67bf with SMTP id
 q10-20020ac24a6a000000b00511867767bfmr154491lfp.44.1707845562266; Tue, 13 Feb
 2024 09:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170107.60da326a@gandalf.local.home>
In-Reply-To: <20240212170107.60da326a@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Feb 2024 09:32:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com>
Message-ID: <CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com>
Subject: Re: [GIT PULL] tracing/tooling: Fixes for v6.8-rc4
To: Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, John Kacur <jkacur@redhat.com>, 
	limingming3 <limingming890315@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:00, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Tracing tooling updates for 6.8-rc4:

Bah. I've pulled this, but since I did a new system install due to a
disk upgrade some time ago, I once again don't have libtracefs-devel
installed.

And guess what? The dependency rules are - once again  - completely
broken, and trying to build this gets the bad old unhelpful error

   latency-collector.c:26:10: fatal error: tracefs.h: No such file or directory

with no help for the user.

Yes, I know what to do. That isn't the point. And no, this isn't new
to this pull request, it's just that on this machine I haven't tried
building the tracing tools in a while.

Let's not make the user experience for people who want to do kernel
builds any worse than it has to be.

Side note: instead of the (clearly broken) special Makefile rules, can
you please just take a look at the perf code instead?  In fact, maybe
it's time for the kernel tooling people to try to unify and come to an
agreement about these things, and share more of the code.

Because unlike the tracing tools, the perf tools seem to generally get
this part of the build system right, despite (or probably due to)
having a lot *more* (and more complex) library dependencies.

              Linus

