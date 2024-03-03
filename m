Return-Path: <linux-kernel+bounces-89892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A710E86F6F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166FE1F210EA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693B479DBA;
	Sun,  3 Mar 2024 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GBcaFGZp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511342F844
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709496599; cv=none; b=WsIF3iBaEuw/zWdAc3LvQyUt0F7ZOg+bWSqplJTQOnCtpUk21Ocxa1aKCkX6E82valq5mAsf5K4lph5ubD6neiMrO9m1VSk4NmU/CMZDtjNphZbdWQR5JJljACNsPAKkrqtktAht9I/NF0/4+ekj2poOeZlGEUuyNU2jmp5GLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709496599; c=relaxed/simple;
	bh=hW/21IXh7LnksEmKN7qegncwrPQtbF2L12tld1mqOVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrKLt1x0jqllqodUsj5x4Dm7D64KrihZP87ilgr3Y+cOfNUX30pPdWFBfmSmQgB725olGieCAmt0eb/vHgOmXBH2X8ostitNVlQyVwt1dU21xwA+7wjGBCpAzdNp6yMcRjefmEuzlYZiei+7zkib9cNH7YZqHo6cVa5xJD1e+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GBcaFGZp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a446b5a08f0so444184466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709496595; x=1710101395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjejV7cjq9eF/NMC/5dDhfHhCfm9O+pm55jSOArI84o=;
        b=GBcaFGZpJF1993M5R76rPUX/4XhcZmOHOSBpWlnVhYpRiqhCdyaZ4joO1jSBSDr0T6
         0iUcY+FsVE9FpD9pq7SVb5DkS/g+WnqoyC0tdSILXw2DEVLSNqtlkrmZlFfjIYV1n2pY
         BUkbJEKEj345ghRMCdUQ41fRQeITIsHlVRTfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709496595; x=1710101395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjejV7cjq9eF/NMC/5dDhfHhCfm9O+pm55jSOArI84o=;
        b=gEWMcXCblxePWpJN8wIN7qb5bPVWIsMeLUMjjkuc5Q84FpFsiezYY1ewHzfrd1YYVU
         d4Sd9yMWRF1w8U08nq3i9ye/BBsuS9XiLw9tEfiVtS7K7QdfzKgNht2/2nM2xArJfFGP
         1Q8qmA39UYjcpY9yUVxvj5kYMXoMCImjyj3xwSKEKXY+EpS06/JiAzSiN3IvGpCpu4y7
         rygRmvzDDzgbXAvQuXNPOPslLILg5DebqCiHrJ9EsHDYhBBlLZT3hkZYUKxZb7bv3F5y
         XRVhAUve7EgAC0EzLvdJ3q7nEpAx06TNGVPkeGBPpeNLoWAIZUrXyF2iVuonf82WYCAe
         27Yw==
X-Gm-Message-State: AOJu0YzjXGpOB3ekZjpqhmkNUBT3YPRPD6pfbqc1KbBVIKxooiYpxZWm
	VR1xHH/7RSuv9wZjLOI5Wawg4txdH/xVb7Wjx0nRNJkLnYLfVZsRIk+HiUsRBuAzdnVvP2kIOzJ
	sWTzZ9Q==
X-Google-Smtp-Source: AGHT+IEnH/UUM+/1vc/6mavBKq4zV4yTvbO+zK2QQbTQrQpauXcER81t3WTdmEvCUiRxrGdz8pB26Q==
X-Received: by 2002:a17:906:55c7:b0:a44:52ec:b9e7 with SMTP id z7-20020a17090655c700b00a4452ecb9e7mr6050482ejp.16.1709496595509;
        Sun, 03 Mar 2024 12:09:55 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id bw16-20020a170906c1d000b00a3fb9f1f10csm3981637ejb.161.2024.03.03.12.09.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 12:09:54 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a446b5a08f0so444182266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 12:09:54 -0800 (PST)
X-Received: by 2002:a17:906:c2ce:b0:a44:b9e1:560f with SMTP id
 ch14-20020a170906c2ce00b00a44b9e1560fmr5315093ejb.14.1709496593904; Sun, 03
 Mar 2024 12:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home> <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
 <20240302145958.05aabdd2@rorschach.local.home> <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
 <20240302154713.71e29402@rorschach.local.home> <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
 <20240303075937.36fc6043@rorschach.local.home> <CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
 <20240303140705.0f655e36@rorschach.local.home>
In-Reply-To: <20240303140705.0f655e36@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Mar 2024 12:09:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
Message-ID: <CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Mar 2024 at 11:07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The string in question isn't some random string. It's a print event on
> the ring buffer where the size is strlen(p) rounded up to word size.
> That means, max will be no bigger than word-size - 1 greater than
> strlen(p). That means the chunks of 1024 will never land in the middle
> of garbage.

What a piece of unbelievable crap.

So you didn't actually want the precision in the first place, then you
started limiting it to an insane value because the printk code
complains about insane precision, and then you want to "fix" that by
printing it out in chunks where you know the chunk size won't hit
garbage, but that ends up being a random implementation detail that
you don't even document in that chunking code.

> > What was wrong with saying "don't do that"? You seem to be bending
> > over backwards to doing stupid things, and then insisting on doing
> > them entirely wrong.
>
> Don't do what?

You have this pattern of not actually thinking through the code AT
ALL, andc just fixing symptoms, and then making the code worse.

The whole "let's avoid the symptom of the kernel printk code telling
us that 32kB string precision is crazy by putting a 32kB-1 limit on
it" was clearly just papering over a symptom, not fixing the problem.

Doing insane chunking in 1kB pieces was another "let's paper over the
symptom, not fix the problem".

And now you finally admit that the actual problem was that YOUR
PRECISION WAS STUPID TO BEGIN WITH.

Do you really not see what the truly _fundamental_ problem here is?

Kernel code doesn't "paper over" stuff. We do things *right*. No more
of this crap.

You really need to take a deep look at what you are doing. I spend
more time on your pull requests than I want to, exactly because you
have had this pattern of doing something wrong in the first place, and
then adding MORE CODE to paper over all the problems that initial
wrong decision causes.

This was *exactly* the same same thing that happened on the tracefs
side. You did things wrong, and then you spent a lot of effort in
trying to patch up the resulting problems, instead of going back and
doing it *right*.

And honestly, I still think that the fundamental mistake you have done
is to let people say "I want to have these big strings" and you just
roll over and say "sure, we'll create shit kernel code for you".

WTF do you think it's fine to say "let people do insane things"
instead of just telling people that no, we have sane and small limits.

As a maintainer, one of your jobs is to say "No, we're not doing crazy
stuff". I still think that having so big strings that this came up in
the first place is a sign of the deeper problem, and then the fact
that you had an insane and pointless precision field was just a small
implementation issue.

Doing tracing in the kernel is not some kind of general-purpose thing.
It's ok - in fact, it's a really damn good idea - to just tell people
"yes, you can add strings, but dammit, there needs to be sanity to
it".

So I now tell you that you should

 (a) get rid of the stupid and nonsensical precision

 (b) tell people that their string are limited (and that 4kB is an
_upper_ value to sane string lengths in the kernel)

 (c) really fundamentally stop with the "paper over" things approach
to kernel programming

Large strings are not a "feature". They are a bug.

It's also sad that apparently your strings are counted, but you don't
count them very well, so instead of just using the count (which is
*much* cheaper) you end up using '%s' and do things until you hit a
NUL byte.  Guess what? All our printk infrastructure is designed for
small strings, so '%s' isn't exactly optimized, because we expected
sanity. It ends up in a loop that literally does things one byte at a
time.

And no. The solution is *not* to paper that over by making '%s'
printing more efficient. It's not supposed to need that kind of
efficiency.

Christ. *IF* large strings were a good idea, and you actually almost
have the length encoded, this whole tracing code could have used the
fact that you have that approximate count to do something like

    len = fieldsize-1;
    len &= ~(sizeof(unsigned long)-1);
    len += strlen(fieldbase + len);
    seq_write(buf, fieldbase, len);

and at least now you'd have something *efficient*. Which is at least a
source of pride in itself.

But since I really think the core of the problem is "we shouldn't have
allowed this kind of crap", I think efficiency - while a source of
pride - is polishing a turd and more of the "paper over the
fundamental issue".

And no, the above code sequence isn't wonderfully pretty either. Using
'strlen()' to find the last NUL character in a word is disgusting, and
our kernel 'strlen()' isn't some optimized thing either.

We do have fancier cases for fancier code (the word-at-a-time stuff),
but at least the above only walks things one byte at a time for a tiny
sequence.

                   Linus

