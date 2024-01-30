Return-Path: <linux-kernel+bounces-45351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA0842F26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C5B209CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4700914AAA;
	Tue, 30 Jan 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCtrMZ7b"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD257D3E3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651546; cv=none; b=OgSMUYKwc15jLYY46FI0P5ZSTaBLJUIknVN9pX2an/4T00mJJxICGTwHcfAZoG0wMgjN2GTTU/kKccUzyvoaTNFbhnTkZPY+h4gj3GJhvkEiqzGi1x0gzdyWnn6AqPJbPpE01IWNDvyT/nElmPxFFLkrzKkM0k7qXUF42T/NsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651546; c=relaxed/simple;
	bh=+qk4vgKPY6g/M0jnFj6arXo9HY1VFRhgbxgqYyNRIGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeldLi/S6OaQP2li8Xo0gU/O3SO6BbBTmYaXUUr2piZpXwwON8vcQlDowkyEX1vPqUGkumNWTU+cVcja+ePR8oIqRSLlh5R4S9gD35kx22+MLbBCkZJcyr6fU0+YM0oggTpbBEM3khEIufXleOWnskvHKSE5B4ppPO+y+x34JAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DCtrMZ7b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30e445602cso59983566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706651542; x=1707256342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z/besbXOlWgDfiLFxKbwW3KTuDEF1myzGGPgRYrtdjU=;
        b=DCtrMZ7bDmdjTtllWpRZ2+7nKAB2lObHXYuNPzu2HexW1SwamGtKyFCLTquLgJTWze
         WtWHyPNuJ0r6T16e+MB+2k34o3UNwY1jPaOPcRYnJaP2mGLHMs9KwuPdvix7m1DEw9W/
         aZiDc98W/IowygrbijqDFifkTe5oa4XmxgBy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651542; x=1707256342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/besbXOlWgDfiLFxKbwW3KTuDEF1myzGGPgRYrtdjU=;
        b=LJGiIF00AWLHX7orpvcw1M7fRQUnjh7y19SfneQ82r6nbNiIV9JwdoyVRKeqxKecGE
         WJGR+ivkZlZMGKIQoa5qRqMyA86j1rJQXxGgAJ3BMUwW8wWLQOGvBMqC1I2LC+uIaP6a
         3Lh1xfvx8DjUc0FTBZn/IyS9+9Fygz4wZX5mzYvqDzhp5b1XajGmkOThBApsPOhTuwnA
         psiAx0EXVHr2HR7g+Bc7C0aqv6IHbGXj71xxesGkCAzDyvtvzOZXllCcvaEeKit/E/BP
         zv2e7tZGKfKFig1jegD+Ssi1lZa3ThSt+B3qEtqt6lY29p/aDLbpv+e0VkRrWfTK+7Xi
         QglA==
X-Gm-Message-State: AOJu0YwXGH+uVg7ywXv2mxQSUrgien0rQjpVVyN8oRZuskfoZzO8sZo9
	5AZy+Ffg5p5I7DJ/n37tFGSI0OnBjkQUEyl5VA9vJVmIFKi7E0tj8KYZBx6hH/NbqNUPOdSuQwK
	v2GxxhA==
X-Google-Smtp-Source: AGHT+IG9ofX1g0X726rsv1HNP05a54ky0ooZiHH5oQu7IfYARRhYwXuuR5SvTzxW8ccJjatu0WUxQQ==
X-Received: by 2002:a17:906:2714:b0:a36:5924:77e0 with SMTP id z20-20020a170906271400b00a36592477e0mr697926ejc.10.1706651542689;
        Tue, 30 Jan 2024 13:52:22 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id cw1-20020a170907160100b00a359558648esm3218804ejd.24.2024.01.30.13.52.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 13:52:22 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso465007a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:52:22 -0800 (PST)
X-Received: by 2002:a50:ee12:0:b0:55f:2ef8:7fec with SMTP id
 g18-20020a50ee12000000b0055f2ef87fecmr2373087eds.21.1706651541820; Tue, 30
 Jan 2024 13:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
In-Reply-To: <20240130155550.4881d558@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 13:52:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
Message-ID: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 12:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm going to be putting back the ei->name pointer as the above actually
> adds more memory usage.

I did it mainly because I hate having multiple different allocation
sites that then have to do that kref_init() etc individually, and once
there was a single site the "name" thing really looked lik ean obvious
simplification.

That said, I think you're confused about the memory usage.

Sure, 'kstrdup_const()' optimizes away the allocation for static
constant strings, but what it does *not* do is to optimize away the
pointer.

In contrast, allocating them together gets rid of the pointer itself,
because now the name is just an offset in the structure.

And the pointer is 8 bytes right there.

So allocating the string _with_ the ei will always save at least 8 bytes.

So whenever the string is less than that in length it's *always* a win.

And even when it's not an absolute win, it will take advantage of the
kmalloc() quantized sizes too, and generally not be a loss even with
longer names.

So I'm pretty sure you are simply entirely wrong on the memory usage.
Not counting the size of the pointer is overlooking a big piece of the
puzzle.

Btw, you can look at name lengths in tracefs with something stupid like this:

    find . | sed 's:^.*/::' | tr -c '\n' . | sort | uniq -c

and you will see that (at least in my case) names of lengths 1..7 are
dominating it all:

      1 .
   2189 ..
     34 ...
   2229 ....
    207 .....
   6833 ......
   2211 .......

with the rest being insignificant in comparison.

The reason? There's a *lot* of those 'filter' and 'enable' and 'id'
files. All of which are better off without a 'const char *name' taking
8 bytes.

              Linus

