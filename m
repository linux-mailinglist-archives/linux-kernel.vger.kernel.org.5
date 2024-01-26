Return-Path: <linux-kernel+bounces-40681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F228683E405
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE882873BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4634A24B29;
	Fri, 26 Jan 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DPwOgIVx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAC24B20
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305001; cv=none; b=fvESEMSGlwx33An/5+qCh7B4sr/yaRkctoHRM3qCnRY/0GEhI1o8eR4//DkonXlgV4wYBjqQQcKyHHQFEMHhd8d+xx/qkjpI6hU+Kdhoxm7BQWux/Jx1JFooTKMauQq4ctin0g+u5fYLki39zAoEhADQVdCPYLVF6NUJnv05Z9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305001; c=relaxed/simple;
	bh=YfaSbj7aWucYRD8fpKinICpQCEEwoP2iLjQO/Z3wcuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvw9XwT+BbNlzloF6QG5a2wgeqcUS4cWIkjUoti2aKqPBH7CHl8koCsjd4M5YgQeeCWIHVHWEmgHu6n+yhJJu2UP36GQV/G5vqtTMGGmq9AwlasM5DZeW/83hYkYeEVMBCsWw5G7hs91+WCdWwJaxq43G825ODgB4XY/EIX602M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DPwOgIVx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c1ac8d2f2so641776a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706304998; x=1706909798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvqA4oK/Qg0raxZ+27W7q7BWtiVAxq8zsa6fXWM1cKw=;
        b=DPwOgIVxzJMnMsXzBSSz89o/d9U0v8DSGhqcRiyP6iOiczYcymiMnQKXfn9H7FSxoU
         GwUQm8T0JH6v2+2lbk3HqVjhaL7m2vgBg5KSycBSgMk/OMmbcgzlJL4FI5LgBpHELvSt
         xUITg8FSEElnzWQZF2m4bX+d/tcrP8Oz51wx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304998; x=1706909798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvqA4oK/Qg0raxZ+27W7q7BWtiVAxq8zsa6fXWM1cKw=;
        b=ReJYlEUB1CPm4YVoK5B9Klw+xGROz6r+XCtAVj+84lJQtiwd6AzFa7Cn6A4rEiuDxF
         bNGv656RN/iVda7UJyKGxvzTEdUmNc7RgOdVB5AemmT3DVG5eSbp/FHEvSpBCYWn8fjI
         A+X/a1AJmaFc7iXfWWQNV7ugN3pJDB2j6VnamXvH5/4OKoqexHnNo1ul0tHIfI7geE/I
         3Z363a1jnZlJHitSPW0xbOuSzjjyoYTVMVCwIt/wgWHF0cYimgD3J1uzB67hKh/bA2RC
         SBONOWOG4k0I2ZEcGhhgxt3r6c2tg4qtkT0HEibSzNLgybRpD2iuh70Dm8EZeRRsN2+c
         yibg==
X-Gm-Message-State: AOJu0YyiEdfP42wrLxGzBqpT1fnOvK/eiPauLSa11zi2EAg0+5p9o+pe
	wMHTt32YRKuHOkCpLA/GtkJZAiwTORX+/IP1t3O3GF+jOtsn2BqrqLOLeWqIH7fKweGG7OA2ZoT
	fsSG+dQ==
X-Google-Smtp-Source: AGHT+IE7cauMu4I9UxnhBJ3aiTusyS5TNrYBam9W4rT6dLYBw1nDMwhNIjf5rb04McGtaWTpnIGnNw==
X-Received: by 2002:aa7:c1d6:0:b0:55a:9133:2a2c with SMTP id d22-20020aa7c1d6000000b0055a91332a2cmr204313edp.13.1706304997765;
        Fri, 26 Jan 2024 13:36:37 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id v22-20020a056402185600b005592d70c31esm951537edy.17.2024.01.26.13.36.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:36:37 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso576686a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:36:36 -0800 (PST)
X-Received: by 2002:a05:6402:1656:b0:55d:4375:cd14 with SMTP id
 s22-20020a056402165600b0055d4375cd14mr223875edx.26.1706304996651; Fri, 26 Jan
 2024 13:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
In-Reply-To: <20240126162626.31d90da9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:36:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
Message-ID: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'd be happy to change that patch to what I originally did before deciding
> to copy get_next_ino():
>
> unsigned int tracefs_get_next_ino(int files)
> {
>         static atomic_t next_inode;
>         unsigned int res;
>
>         do {
>                 res = atomic_add_return(files + 1, &next_inode);
>
>                 /* Check for overflow */
>         } while (unlikely(res < files + 1));
>
>         return res - files;

Still entirely pointless.

If you have more than 4 billion inodes, something is really really wrong.

So why is it ten lines instead of one?

Dammit, this is a number that NOBODY HAS SHOWN IS EVEN WORTH EXISTING
IN THE FIRST PLACE.

So no. I'm not taking this. End of discussion. My point stands: I want
this filesystem *stabilized*, and in s sane format.

Look to *simplify* things. Send me patches that *remove* complexity,
not add new complexity that you have zero evidence is worth it.

Face it, eventfs isn't some kind of "real filesystem". It shouldn't
even attempt to look like one.

If somebody goes "I want to tar this thiing up", you should laugh in
their face and call them names, not say "sure, let me whip up a
50-line patch to make this fragile thing even more complex".

            Linus

