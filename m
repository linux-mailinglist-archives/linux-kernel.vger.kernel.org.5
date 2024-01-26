Return-Path: <linux-kernel+bounces-40491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E783E195
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6573F1F28C53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B120B38;
	Fri, 26 Jan 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wx2A9qie"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28049219F6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293888; cv=none; b=nsxOBsljejegJ/JG1oRvSpE+i3jNZdGoyQFp/S1cTQQAUsQXoKiyrGQ6DfJjtVdTwi9srn7nEgr9uf3Y76oteAM5yK04B/UflKGAg8w08oHdi6Y2Jy8Yi44INGG4dRUio46wcq2MFL9XaqBB/0b9mpVd4na+IqckJlw9W2ME630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293888; c=relaxed/simple;
	bh=W7B76i3+B9hYS0jCDzE1qW/RvQJCSXTVBuxx+AfGDdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7OjNW48lUZeXjEym4Evqzo+VK8gS0fQyluaw05U5x97WwPvG3oBP+mjgmOJrBKYtIUTOJZUMj0rY7DWr643yiYPmWsA1u5qAZSG50v6MklDe5Le+Zq/6an5QhqQlIcdsmEVw/Y5X92YT/U3jrnQ2Dk5i1PiEObFNTqSWpA7z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wx2A9qie; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so6841021fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706293885; x=1706898685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdy4NXmtqUV6APWQzUWxFYpWUDUY5MY8BJqI1nPSu7g=;
        b=Wx2A9qieYIbSrzzcEStmTkov8NiyT7165kKVH7ip7ciWsRocp0fzGNISspD3qf1NKH
         hQRA6hLnrrf8rdBpzJWu19hewRfRfOidN6aBT1RQxpj4xTLVZ/X0nTmUrqYwlPMU0XKj
         lY7eTZ+yH2qp5ZnSQCEAMCZ9Z8kzTW3SEFKlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293885; x=1706898685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdy4NXmtqUV6APWQzUWxFYpWUDUY5MY8BJqI1nPSu7g=;
        b=nPfuwRdgAo34WWzlrm5NKDxuMtbOwgdL/zbufLz0DpdO4ljqHDS8+rnQSQHoxttCm/
         kYe4OhCOKkjz5fLCG+9Nu05DiKPTOyf/Fs5LNfuNI+UhQb5LfVY0YcrZl7yW+pxkv9f3
         tDT9RCESR/wdAmUUVsD1m4VMWSttQbK+UDJSimsp4csBbWsiGDo5uN7bQDr9I2ZaZN/I
         GarYvwxiRz6o7KdaCjCl1kbbEl/PeCfL7OANk9uUbGF3cHVTh0krLCF//ixoYKK6W0jt
         XMkqGJO+/k7ZSWPo7DYTJaVlVZs0vZEG148ndpObC4N4M9O3Kb7LebgZZiqBPDjHSG79
         fP7A==
X-Gm-Message-State: AOJu0YyH16KXJRpbeR8E4hxKM8iLMzGgS2rWCW4hSgOGv6PkneP2IEkb
	u5jLamUGHOf9RGgvzlbLyOJwmx2+DYBZCmRohfJhjyLmHzXi2SUxhXH/x1PYGjWR04cDDnFzMjc
	bGKU=
X-Google-Smtp-Source: AGHT+IE8P1Dv6WwhpmMXN2aoqOtM8BQYoEqM6HHzP39FTQHNkRIfon8tx2WpW4bP7zyyH+N6pkv17w==
X-Received: by 2002:a05:651c:626:b0:2cc:de75:71b4 with SMTP id k38-20020a05651c062600b002ccde7571b4mr87731lje.188.1706293884678;
        Fri, 26 Jan 2024 10:31:24 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e7809000000b002ce06c6ee29sm231681ljc.77.2024.01.26.10.31.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:31:24 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso7556291fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:24 -0800 (PST)
X-Received: by 2002:a2e:be8a:0:b0:2cf:12a2:c1fa with SMTP id
 a10-20020a2ebe8a000000b002cf12a2c1famr96305ljr.215.1706293883810; Fri, 26 Jan
 2024 10:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126131837.36dbecc8@gandalf.local.home>
In-Reply-To: <20240126131837.36dbecc8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 10:31:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
Message-ID: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 10:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> By following what sysfs does, and give files a default size of PAGE_SIZE,
> it allows the tar to work. No event file is greater than PAGE_SIZE.

No, please. Just don't.

Nobody has asked for this, and nobody sane should use 'tar' on tracefs anyway.

It hasn't worked before, so saying "now you can use tar" is just a
*bad* idea. There is no upside, only downsides, with tar either (a)
not working at all on older kernels or (b) complaining about how the
size isn't reliable on newer ones.

So please. You should *NOT* look at "this makes tar work, albeit badly".

You should look at whether it improves REAL LOADS. And it doesn't. All
it does is add a hack for a bad idea. Leave it alone.

                   Linus

