Return-Path: <linux-kernel+bounces-41385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F96783EFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522D31C21B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24912E652;
	Sat, 27 Jan 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h/wNPzfV"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373792E632
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385708; cv=none; b=QseoiBX2Mfe66OcgWnBFrfIj29MiFCptgvX2fL+exDtlmcMGMspobqkVkf7uUIgU2wIjC/hBnZTipiJDtHs6bX64D8qW2uU7RvbonR5vp9m0R+50uFiMbCYiS2OtYiHiuL+PgttUfPlKnDnnxDyxTEZzHUMbDUTl4RZlYDaIRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385708; c=relaxed/simple;
	bh=N4yM4Sx3Bo4zjchytKwAIMFmf9vDnuWdHVbRYVkfw1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApNkTanM3Khn3eiD3YU3jlypnuTlSr5GE6/G6xHP4SBKxE3VVDm0uyv5wvIH+WVXN4IvXwDiefxvmQI7+GU66VhQGpisjz8PW44hc36pN9/JR1fy0BCjq62jiAp3LIQoo8clAZY4dOV6dl3q7fgtOCn93O0EP/2OhIqzvzNeIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h/wNPzfV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so2276541fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706385704; x=1706990504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqDQR2DUv5doyugas4NFosE1WpuO2lGhHoJ/mTvORLE=;
        b=h/wNPzfV9Q1rRDUoWVacLyh4Xt9/kpTkRIzNlMlkiSLGRVt0vsEsUuaN6xD1FtkSls
         B9ib8hlnzQ1fbar84d7k99ecyQFLM1MxE4fTCDNwp/OWCzCAvVEG2/V/QjWJsfaba1Pp
         ykv62JFHVRl6WomEqwO3TRcIDpjio6xXv3lpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706385704; x=1706990504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqDQR2DUv5doyugas4NFosE1WpuO2lGhHoJ/mTvORLE=;
        b=WDivJQLGzrUAQ9miZ7PwqtyQtZ9PSkHyOBRKXLRGhYCMraxk5PhMtM63lU/e2V8WRi
         XqVh6xgYhZBSYsisTF0FFjhzhWxwNzmCqy98+A16POmK7f0gzIsiXfbx6p4E79KkPdxj
         xal7Mgmo0pJ6Abn1Hr003qmwz+QI3JAmTkC6a4MuV4sPSsvVuw9bbV62FpTPWu0sIEOh
         QdXEG65Pz/Fs5B+lRTamJLqZsfir4ERs/+RmjvpBXRkFzJI9Gz+OHNhFs+97j+WCs7k+
         5f9zE4ozxFVtVFkHGvTZ8CpHBXCSe+gapVOcn/aOmf10n8MBuOrT89fl6uNqJbfRQRZH
         d2yg==
X-Gm-Message-State: AOJu0YxaFpy/mxxrcKipA4Kum7y6Oez+/7dKTUKLgRcKKNLwEBMXBzmX
	Grpb+nefW/bnu92k3OZt6PrYFDg5YhNonEW9bs7mFs3fL7p8Axnl97/+BmnUCb23+fu/xdUBxhN
	g7Nmzng==
X-Google-Smtp-Source: AGHT+IHv7ZTZO5gCX3EePT2jsA37LEeli7oAvk8RCcvZwqF3C3ViVijN6l5pZfJNJq90wsZNTM2Bpw==
X-Received: by 2002:a05:651c:200b:b0:2cf:41d2:ff57 with SMTP id s11-20020a05651c200b00b002cf41d2ff57mr1773721ljo.10.1706385703735;
        Sat, 27 Jan 2024 12:01:43 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id d23-20020a056402079700b00559c71e70e3sm1930970edy.79.2024.01.27.12.01.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 12:01:43 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so1653649a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 12:01:43 -0800 (PST)
X-Received: by 2002:a05:6402:3137:b0:55e:b30c:e0db with SMTP id
 dd23-20020a056402313700b0055eb30ce0dbmr1269613edb.35.1706385702705; Sat, 27
 Jan 2024 12:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <9b34c04465ff46dba90c81b4240fbbd1@AcuMS.aculab.com>
In-Reply-To: <9b34c04465ff46dba90c81b4240fbbd1@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jan 2024 12:01:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgX6VV4nEpC7+f=QZq6VDrJxVJd_7vVfJdhq5aWDHM0oQ@mail.gmail.com>
Message-ID: <CAHk-=wgX6VV4nEpC7+f=QZq6VDrJxVJd_7vVfJdhq5aWDHM0oQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: David Laight <David.Laight@aculab.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jan 2024 at 07:27, David Laight <David.Laight@aculab.com> wrote:
>
> Doesn't Linux support 64bit inode numbers?
> They solve the wrap problem...

Yes, but we've historically had issues with actually exposing them.

The legacy stat() code has things like this:

        tmp.st_ino = stat->ino;
        if (sizeof(tmp.st_ino) < sizeof(stat->ino) && tmp.st_ino != stat->ino)
                return -EOVERFLOW;

so if you have really old 32-bit user space, you generally do not
actually want to have 64-bit inode numbers.

This is why "get_next_ino()" returns a strictly 32-bit only inode
number. You don't want to error out on a 'fstat()' just because you're
on a big system that has been running for a long time.

Now, 'stat64' was introduced for this reason back in 2.3.34, so back
in 1999. So any half-way modern 32-bit environment doesn't have that
issue, and maybe it's time to just sunset all the old stat() calls.

Of course, the *really* old stat has a 16-bit inode number. Search for
__old_kernel_stat to still see that. That's more of a curiosity than
anything else.

          Linus

