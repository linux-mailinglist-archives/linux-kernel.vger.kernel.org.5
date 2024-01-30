Return-Path: <linux-kernel+bounces-45177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E101B842C80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4EF1C24353
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C147AE63;
	Tue, 30 Jan 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Matk8Y+w"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9B69970
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642365; cv=none; b=M3LdA1jdeOJuK5WeiO8RXZBRb2AHh6fzhuRRMrMCyurbwnPDpfzaH6M5dKY0spc2BvRVsSBG9+0H5vpg5rfRzUg4l+3M00NMNzvTexdRZuepxroy/ALw7oil5kNqHFM3fHr2+7FAZOnaQzbAsy3Ti+Y9UbQqIejbJgzNdimztog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642365; c=relaxed/simple;
	bh=wzJcKIgs/uFgPoU/NkNhAK25xpfIJjwjPT1K5sVmsTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl/lCY2cSSpyTU6z++CxKhi7Gk5dYRqXTcEtp9Tp4YekveMs8/abj01m7Q+r63n1tSB538mZMCazvINb9elSa/OBt9DiAaOAEvFa4AkyIm8zTNRaa6an/JRurmssvYsxtCe5D17QuUymPtjj5xhhHFnEUn06mj+hmFeVwYSvywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Matk8Y+w; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51032e62171so4709077e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706642361; x=1707247161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G5HDN8hMhvJPlLwbvxkEblRc74lfQs68/VLCsSFwK6k=;
        b=Matk8Y+wALU7IVz6AyfRYZN0vhsY1qurLM4YqrNtJ5V6yfKwht1vGoBK0K4Qn6KyfY
         Zo/LBG4UjUEUHuAq23DoozdNPYVaKsdsaUQd/s7iTsRmNJG2SfuZCBY70r1fmpfUGL85
         ezN3rg5/eCf0zcHIb0hlv2qkurqlzZu1EmWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642361; x=1707247161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5HDN8hMhvJPlLwbvxkEblRc74lfQs68/VLCsSFwK6k=;
        b=FCTQdPDj60rApdoU6P9HyPFHwQOvd/S2uMjDsDKLXfpK0uZ8n0XBWwxZx9Mhhitz7o
         1NNJtRbQQHzHbv4l2IUgGJRYD1wVwyP6JXqnjauVD10DrqjJ3RidlU8S+8PwSO/VP917
         KfaVltXOCwI7Y0x78P/h1ez8IsoR9bVBS0vhi0gtucGIK7v3IRSQR/bObdX08qBxjVHs
         /9bjF/vXR2lOA4/MSG9j4Cp48sbYAQ9NJRs1tGvAPsz5KFWggHE7xGuzeAzVOa9BAcB4
         GGhJYqPnFXemHJKuiNRvWTNPzo2UZLlxKGo4vG2gf4L+5y92W6wUq1SZ88nfHIZOSB1d
         +LTA==
X-Gm-Message-State: AOJu0YyiRTQSjfDBUlhv/GNJKIcd4zQ+/ro0DwEOG36N3AsE//+lIAyF
	6wD6XIfw8D23dsWAmnF5XVgQ1w6wxXKXDD1fBPjeGXOE22ZDbsNZymNnWRdmrxSnjvzm9dAo6rI
	HBROFQQ==
X-Google-Smtp-Source: AGHT+IEJIuZguRTNPu5PtTMJZ9mtY5Mz/dRa88m4OmP9cxmI7RIhyMn+FxKt8F06uKKsB6WMb6mtMA==
X-Received: by 2002:ac2:4857:0:b0:511:9d5:dd88 with SMTP id 23-20020ac24857000000b0051109d5dd88mr4914562lfy.50.1706642361262;
        Tue, 30 Jan 2024 11:19:21 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u28-20020ac243dc000000b00511211cd8d3sm100200lfl.309.2024.01.30.11.19.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 11:19:20 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf1288097aso57793891fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:19:19 -0800 (PST)
X-Received: by 2002:a05:651c:19a4:b0:2d0:4f51:531 with SMTP id
 bx36-20020a05651c19a400b002d04f510531mr4399720ljb.45.1706642358738; Tue, 30
 Jan 2024 11:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com> <20240130132319.022817e8@gandalf.local.home>
In-Reply-To: <20240130132319.022817e8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 11:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
Message-ID: <CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 10:23, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I know you don't send patches inlined anymore, which is a shame, because
> patchwork takes care of all the administering when patches are inlined, and
> I don't miss patches like I use to.

I just sent the whole series as individual patches., and doing a

  b4 am 20240130190355.11486-1-torvalds@linux-foundation.org

should get them all (or if you use patchwork, do that)

I don't normally do these inlined patches any more, because honestly,
99% of all patches I do end up being "I can't test this very well, I
think you should do something like this".

In fact, for simple ones where I might not have even compile-tested
them, much less booted into a kernel with them, I will actively
whitespace-corrupt the patch, just to make sure they aren't applied as
any kind of real workflow - they are almost always meant as a "I think
you should do this, and take credit for it all".

And so when I'm working on a series like this, I'll send attachments
just because it's easier, and because I don't want to patch-bomb
people with some kind of crazy work-in-progress thing.

But I'm reasonably comfortable with this series now, so I sent it as a
"real" patch series. I like it partly because it just removes a lot of
lines:

 3 files changed, 160 insertions(+), 433 deletions(-)

but mostly because the lines it removes are what I consider actively
broken code. So it's not just getting rid of LOC, it's getting rid of
complexity (and bugs) IMHO.

That said, I also don't think that patch series is any kind of
"final". I didn't fix up the readdir iterator locking, for example. I
don't think the SRCU parts are needed at all any more thanks to the
refcounting - the 'ei' is no longer protected by SRCU, it's protected
by virtue of us having the file open (and thus holding the dentry).

So please think of that series not as any kind of final word. More as
a "I strongly believe this is the direction eventfs should go".

I am perfectly ok with you munging those patches and taking full
credit for them, for example.

My "testing" has not involved any real tracing usage, and while I
*have* booted that thing, and have done some very basic smoke-testing
in /sys/kernel/tracing, 99% of the work was literally me just going
through the lookup code, removing everything I found objectionable,
and replacing it with what the VFS layer generally would want.

                      Linus

