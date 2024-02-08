Return-Path: <linux-kernel+bounces-57695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3084DC71
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B32281AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7916BB3E;
	Thu,  8 Feb 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iG4dg/hp"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3626A02A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383393; cv=none; b=g+6kWQWig6WKQ+EIhikLtsf0a6nQNZWujAvAksbwUrcECHQP8En0XA2dzGqTuAAcGX+3r5+f0gDPqYs2kM87mqlYamOyVKu53uwmqfJUJBpC6pkyeC6dap+NWKGwB8WrzHXrf9aLcjMFl/nBboO1ctQs/WYSYFf4N2+ZDWvh+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383393; c=relaxed/simple;
	bh=zVsw84a2RwGpKBPrw4jYTiy1UtSi5N2mqNp6IaCH95c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI4ivJ0l+Wt7J16xqCyTGmJIYSxknDIrW6qsCsKTOfWM88PyhcgSko+MdQ8Y2HGoWD/OLRA80Fp4SDJCxWE4BrcVERk7wAb8iwjvTyL0pcpcVbuQE5DoG32U5uHX3mqIX1GuJRcyEzzS7S59IcjP7V4878o1Ri9Lb06E9481YGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iG4dg/hp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36126ee41eso213965466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707383389; x=1707988189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=si3xHK+k194EZDIzaB37YbzCU6i2qGxC7c5NTYon5g0=;
        b=iG4dg/hpLk3XHnjgPaMC8kyY5DRCph0T+VFbA9jQspBajQO+8+Dc33xrLxNZIc/J9R
         WKBUeMinRGKzQXOWDpLMG/hRVSIUHxtSiruChJpNuMZR0jaPjB39BwAvKHB209Fk8AZC
         HRKp6o0KS7VhQDxMQWJTv7MONttyNOEfMI+k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383389; x=1707988189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si3xHK+k194EZDIzaB37YbzCU6i2qGxC7c5NTYon5g0=;
        b=F7qFDqYKcBWPJward5gMMmMsB65WhpS1hWwYPSB9lf4j2N2mYpf1e3MyiAKcpJhGtN
         Tp79jRRKFzXR//blvCswCTiDohbaitB/KBIBipT/3+B7/jZzoGG6aGUoUo6+A5vWegP1
         sY4TliOBnBth+AyY/TTS0kdoMTo1nozEZSuMnQzflh//9JaLQaIcFtbP4+qnazkbJ9wT
         cYUV6P0MgPY0Ht2zL7e9oFWOALPFrIUNw7n0iiu51NP1+X+58KYkG/oNhtE5KrkRrnOV
         Kz1PF45x1eZfPLs23lvMnrYIO1P8W4VJOQRHiNHV4fqAGcOHZZXE5MESBHIPdFmryuS2
         IyvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9GxY+WkrSWk52EAdVebgKq7Wi1lUBgkXu0csePFy+AqHDYNIhNvrP9poulq7Ol5pxBTBsC/b46IlEJ1jfqT/9pv2QNY+uDIvTzN27
X-Gm-Message-State: AOJu0YzMWYkYDXJgasavQwBXm6ZJ4fKttnFrXqrSbxUR9w48GJ9pylKh
	lKaItajj+WaCh2D+cqXWMd2tv/srRkkWmUuy6J8AAD208+iKhKgpt/6u60YacmBAN2iHERGD/a5
	rbXGb8Y92DTHBhWzWIJJbe6URKA2CIBlmu2vGnw==
X-Google-Smtp-Source: AGHT+IEr5ybnrgs7QEr6RwDRUNtDFB2ss+L0SZXg8ulNl9BKfzLBHvkO0AwDNKY5TsqS9PoK/JntL0Xwn8kaVWep/Vg=
X-Received: by 2002:a17:907:762a:b0:a37:20d4:22be with SMTP id
 jy10-20020a170907762a00b00a3720d422bemr5690729ejc.49.1707383388930; Thu, 08
 Feb 2024 01:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <ZcP4GewZ9jPw5NbA@dread.disaster.area>
In-Reply-To: <ZcP4GewZ9jPw5NbA@dread.disaster.area>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 8 Feb 2024 10:09:36 +0100
Message-ID: <CAJfpeguTGdAuQ+5Ai0ZXL7p-UeCyk2spBDhm6bkdTC-0UAKenQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 22:37, Dave Chinner <david@fromorbit.com> wrote:

> ftrace using the function_graph tracer will emit the return values
> of the functions if you use it with the 'funcgraph-retval' option.
>
> Seems like a solved problem?

Except

a) this seems exceedingly difficult to set up for non-developers,
which is often where this is needed.  Even strace is pretty verbose
and the generated output too big, let alone all function calls across
the whole system.

b) can only point to the function was generated.  But the same error
is often generated for several different reasons within the same
function and the return value doesn't help there.

I think a) is the critical one, and possibly the ftrace infrastructure
could be used for something more friendly that just pointed to the
function where the error was generated without having to go through
hoops.

Thanks,
Miklos

