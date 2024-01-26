Return-Path: <linux-kernel+bounces-40757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98F83E56B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10A91C22FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760325576;
	Fri, 26 Jan 2024 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HMMmvQiZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57789250F9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308162; cv=none; b=bwl+SZWT9kYH4wIA0jtRLBNsOkUueIgizAt4lCdtxaWZQ6QP0uBzcegGEwx8EV6JT3BiRf5XmFQ++JNcs33KniGawdMWgxNz7qS2vJKeaLPXu5+JWSigVEMqWd6hPGxZQmPtsc2qugS6qkUEHEnh5bFtKen1zyEkRe7DVuitmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308162; c=relaxed/simple;
	bh=bnGLdwzstqH5AfSoLZdw6+SstBNNV6/ADu5DzEq61y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu+ABuonPHe6/pozpix8pOArX27Z3phMFJfA0oUTSrEo10EbtmYySglEStVhVVynPjrR2yInihJ028CMar2GWdtgtxI1N53UuwShlGXFPskVKZY9r+wkskjFK4AQwD/31vo6t2gCkoa3VDM4B2Io6Js1ApdB1ECjRA0ruwZWpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HMMmvQiZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337d05b8942so1114951f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706308159; x=1706912959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRiurWLUnvaCNMuWmJHCRa1/X+mumAqXgtZJfgR1jGc=;
        b=HMMmvQiZpcgtqcBgmKLGP1OTAtqXFA5fFA1zn82JXWqVQdz05IFfEqaQtgeeSAdoCG
         B80fFH/6MXRB1fcioh3BmndcuHCC+zV22aIWr0b1o8zPyt2MTVBf0CvRtlOhvffp7QOF
         BPmGL2/okUnkrEyYQ0B7JKZ7I17BgPp78XZJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308159; x=1706912959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRiurWLUnvaCNMuWmJHCRa1/X+mumAqXgtZJfgR1jGc=;
        b=V7FIMsA3jzlPtsNS/O9vgU6Q2I2J+LVXLLFvhUHQoOS2dG2++2ctKpD802e35V3I4s
         C4RqUHAonz/vMP+NcRpDs7wZs9Qv1rTTzOnUedo1pFJEDBcdWe37ffJuS3CNUYOcPna9
         DTTmZ5uyZTP3CiI7Faxe/rfeMYQwNm5+gTJlXmLY9erg5jBx6rQvQ4lUAEuW7+S4Plmz
         O0nSz0Pw0z9gYyAaTqM4pr0JYeRUT83L51+Yy2r+vr+5n03pgrUUNStdwLp+fgTqH3C0
         OhibOweTvddigB2LNYSz1cHbW8YgPGhBLxkJ8YHKrwhUX1spEaZeuPbpCh/4iwvQxINM
         +N+g==
X-Gm-Message-State: AOJu0YyItrcUcUgwEWxrIt4vWsy67sffX39aOw/dBjTQqKSN5pepKaYv
	C2tWNYKcEq7sZFqlQ7dMEDmzHn6RxmRnvEg3J+Y3ocilhVqad2csOXJxW14sh5aCsQaROTkNut3
	Ati/WOw==
X-Google-Smtp-Source: AGHT+IHq7+/XIN26s8Pm/9Nf6JV5duC1iaq6GLVgybaPMxUfY/aJmCPhd1gV4qnlYhkYav4rG8f5AQ==
X-Received: by 2002:a5d:6852:0:b0:33a:debe:1a19 with SMTP id o18-20020a5d6852000000b0033adebe1a19mr203540wrw.123.1706308159283;
        Fri, 26 Jan 2024 14:29:19 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id tl9-20020a170907c30900b00a318b8650bbsm1073896ejc.9.2024.01.26.14.29.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:29:18 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so13980225e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:29:18 -0800 (PST)
X-Received: by 2002:a7b:c5cc:0:b0:40e:c5fd:8ad2 with SMTP id
 n12-20020a7bc5cc000000b0040ec5fd8ad2mr348816wmk.44.1706308158118; Fri, 26 Jan
 2024 14:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com> <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
In-Reply-To: <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:29:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
Message-ID: <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:14, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I do however have a concern with the approach of using the same
> inode number for various files on the same filesystem: AFAIU it
> breaks userspace ABI expectations.

Virtual filesystems have always done that in various ways.

Look at the whole discussion about the size of the file. Then look at /proc.

And honestly, eventfs needs to be simplified. It's a mess. It's less
of a mess than it used to be, but people should *NOT* think that it's
a real filesystem.

Don't use some POSIX standard as an expectation for things like /proc,
/sys or tracefs.

              Linus

