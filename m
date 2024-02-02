Return-Path: <linux-kernel+bounces-50328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F69847777
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB57CB261C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1814D452;
	Fri,  2 Feb 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DTsOsIw6"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86214D439
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898605; cv=none; b=LlxQclHupwU0vWe2zfgTqHrN4CiQe+CSNod7H2UraITs0Wa3n2xLqKrinpCM+qHqtPAeIpkdeGOhQ3ZxI9Hn2UNfK22e/vx8V/i1D4ZpVx52IcXFukcQx2HBOgna6XFMGkoBK24DyuFOO8JJpC6kyTonzmq3SpFkz9FLGwAaJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898605; c=relaxed/simple;
	bh=+B2EP3owSfGpJRy7wHKXkx5eiCN3WHUSCd8s+L5o5Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnXS7NbGjLP+7g10IFuQ1NP93JsyoPW1QL2pDe6dW5LFv8IRcF0FzdnUuD1ePw81YyJXyy0IWXET/Cw3sgO3W4lxdaODChRVeUbHYx2GAtmRVOYaDbX5aYRYaRE3kwnvVxdvpPjxPhEW8o0uesGMP06K3hJauHuAOtps6SA4FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DTsOsIw6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a354fc17f24so310798866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706898601; x=1707503401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wred9oKbZUWrUWPqoPWJe75vDju4/OS5/kZYLMHwsFs=;
        b=DTsOsIw6MG+XwIwjWUJF37ZNxE9AUaNJsPGdVKIQNhAZDj3+kKIMa5Lzgj0jdk+ksU
         +C6fNBRtKr//peDdPNI7l2W4wVWBXwMFEflX/lUMk53fHWcRGLXKy3vyRozs9te879A6
         KoXUwM2IE337W+ISa48E1UiLCK1xU6/guXlLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898601; x=1707503401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wred9oKbZUWrUWPqoPWJe75vDju4/OS5/kZYLMHwsFs=;
        b=NWxLfPH4uyu2iXh5H9ZQeiB6NaeWQ+jqEml2NqXQa7mkVzA7OrfuWMs8I5mcfvE7AL
         FsTm9BqT/lz5TGedDyNp0LTJy4hB4w6yWlV+hH1iMEew4c2VidQwnmCrcCsUfzJTwnjS
         3flQVQOeM7BqZYNHoQrfQh+7mPnxbMddjiVJPkygv6JyUz0H6Y5axjR9A5A1hndFmJJI
         Eu9sedhkGuEqcri2vm7nlESiLbXstc2mz22IC/1oj0e9RUvarxdpXsTR9SkN3rOzV81G
         ntTsKk+E+tZEz11POy8oT+beWLZ7j68xJABhoujTvVgkTlnZgFMmfEuwXigZAMo2fVZV
         JKUw==
X-Gm-Message-State: AOJu0YxOEUS9sAxC+u5fgk80zIjeQdYwCQw+XAA72DwSt8Oz4J/icAkw
	K++GpMUAX6/vWKrFnOQWylwq4BVrOyLyiccZz6R4oN6Pu40IDa21cSc5k2eI7IStNtfFkrrwsGo
	9aaiduA==
X-Google-Smtp-Source: AGHT+IGhm3GSI8CCYaJwayUVj/yDiIsRCKDXdvKsvfrHDoNhGdGnl1dT/ThEVHButEWWzrB0/mNiCQ==
X-Received: by 2002:a17:906:3157:b0:a37:2c8f:6ca2 with SMTP id e23-20020a170906315700b00a372c8f6ca2mr703167eje.37.1706898601268;
        Fri, 02 Feb 2024 10:30:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXgTF6gDox8LLScHzwNOvaf5eHRl8d/BxvGN7WpxSvWgrDmNlUFYpdcYNuCC7FDv3vaYSWgooqf3njcbNxL8h8uDjAxzyvUmJRWfjv5
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b00a35ed4fd4cesm1128317ejc.115.2024.02.02.10.30.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 10:30:00 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56010d9aab4so155000a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:30:00 -0800 (PST)
X-Received: by 2002:aa7:c718:0:b0:55f:e682:9720 with SMTP id
 i24-20020aa7c718000000b0055fe6829720mr317170edq.25.1706898600270; Fri, 02 Feb
 2024 10:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za6JwRpknVIlfhPF@work> <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <34210a52-f4b3-46a1-b301-c76fb24adc42@app.fastmail.com>
In-Reply-To: <34210a52-f4b3-46a1-b301-c76fb24adc42@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 10:29:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzBDLC024NXgJEsFOOpJ9BO2BkuxHXr4h5wOSYK9AwbQ@mail.gmail.com>
Message-ID: <CAHk-=whzBDLC024NXgJEsFOOpJ9BO2BkuxHXr4h5wOSYK9AwbQ@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 23:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I did a creduce pass on this warning when it first showed up
> and opened a gcc bug report as well as a driver workaround:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113214
> https://lore.kernel.org/lkml/20240103114819.2913937-1-arnd@kernel.org/#r

Ugh. The fact that *that* patch to the Xe driver makes a difference to
the compiler actually only makes me even less happy about this.

The "&a[b]" -> "a+b" transformation is _literally_ just syntactic.
They are EXACTLY the same expression, and any compiler person or
sanitizer person who treats them differently is just completely
incompetent and bonkers.

That transformation should have been done fairly early in the
compiler, later passes shouldn't see any kind of difference. At most
you might have a sanity check at that point to say that "a" should be
a pointer (because _technically_ it could be 'b' that is the pointer
expression, but at that point I understand why a compiler would say
"you're doing some silly sh*t" and give a warning)

So while I think your driver workaround is fine - and I personally
actually generally prefer the simpler pointer addition syntax - I do
not think it's fine at all that the compiler then warns for one and
not the other.

It's just a sign of some serious confusion in some part of the
compiler. And yes, I suspect Pinski is right in that bugzilla entry
that it's a sanitizer that causes this, and that's mainly because I
hope to $DEITY that no _core_ C compiler person would ever make that
mistake.

             Linus

