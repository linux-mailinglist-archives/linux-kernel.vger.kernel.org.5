Return-Path: <linux-kernel+bounces-31942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864D83372E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9F4282753
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59FA654;
	Sun, 21 Jan 2024 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jb6xoVCm"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2CE361
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705796213; cv=none; b=iIGV2VLXy6MQFH8lRM9y/8t8R+eu6LmLoAoWmelUyFK+A4viYH/QF+AMQlp7n2QLAsVqvW+WE9ANflPNxsc9NIjrsTp9ui9+7Lq6AgNL6kT0a+EUeRv1YJwhUcGyCdEdMzdG6AWFQAqdu3GIOrykri50kH7C0CmoLHsrnDytrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705796213; c=relaxed/simple;
	bh=/C66J7wkQwwS2IqQ96WKFgsVf+pRy97LkmCeeYhVdP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwnKWebeCCjZiq1oHkwXqUFZaCd5ExFr8Y0spj9KZXg/AcnkkBB94ZbY/fs3mh1PJeymyC/WKdg8wYDUCMVOjsAXMdFOOXwxtUXuD0YZw/jIN6uNb6tbkgidZFEcKzJTFQ3BJL5MCrhP7a3gspkwLjLCQDVHGnf6bMNJ7mhDDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jb6xoVCm; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59502aa878aso940294eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705796211; x=1706401011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGx1uUqBJNwaB067t1zS9OZh+thLjfiev6N5olOliBQ=;
        b=jb6xoVCm4erIHuii7QR+BQMXQW1udD1XI2eGpmGrRN07v1b8g2Dans3F6BK64Hguzm
         agWG9o5d4WAs+bSZfi/Q6SQQaidl50E81tkc5ANVEDAw1sEsgqRkaAHEwRGh5ZQ0NAbL
         EjhBG8lpCf1gr06FhT8gVyDJyUCm3wAkpYBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705796211; x=1706401011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGx1uUqBJNwaB067t1zS9OZh+thLjfiev6N5olOliBQ=;
        b=WivO3GxGzvBN4m5orIFqGI6D3Y32F5k4B+WlGLkbkIh9WROhynnrUj5qoIKNTnajib
         SnyEHlQXW54F6cyzgHW7bE2aNnpl5sOUK12FGIxvLQDPUi3qHshlGAaK332l/Ulx5QdE
         /xFUjA3k4yIAskpHJMk4svwNV4U9445kKLJqfsSWaAuQYIF/LNf9mrKPVX9qRwjm9TG/
         vBy03lpwZCzVxqYf2EGHe0bJBvqVXArGUFrJMqS6tIJzCtotMxp7CdIjZxCEcD3/cP1/
         p3LyEEYPeWdytdT5RxRB66MnSq0DI60UWFep+SkSZjpPKwg1bHeZTPQooLS9y1jXVta6
         LATg==
X-Gm-Message-State: AOJu0Yw3UOBiqBIziT1IYKnUSkYJkX0gUGG91syso4BZZjZEvrGobCLs
	2CgiglnGcrzkptxOAJxhyOnOQ+fgPvaFkNPcgTfd/AToCQoAAFiai0/4l2deNgJix8UlTe94YkC
	0myBRxJ1UljDwAdjuV/0e0az42GoEeiy/6HA9
X-Google-Smtp-Source: AGHT+IFwp+DKXCAKoixsZuns+yTYxxlyPCYBxSpYdd1fXnL6rdiY+k7qeKJU05Nn//cgId/cR/5b/LaiwJxnDuIsufc=
X-Received: by 2002:a05:6870:2e06:b0:210:8df6:3b04 with SMTP id
 oi6-20020a0568702e0600b002108df63b04mr2269701oab.102.1705796210854; Sat, 20
 Jan 2024 16:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
 <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
 <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com>
 <78111.1705764224@cvs.openbsd.org> <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 20 Jan 2024 16:16:39 -0800
Message-ID: <CABi2SkVXgyG4r-SzkXx0-MOQ2dqhy1ewwhvfXMJLw066i1zJKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 8:40=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > There is an one large difference remainig between mimmutable() and msea=
l(),
> > which is how other system calls behave.
> >
> > We return EPERM for failures in all the system calls that fail upon
> > immutable memory (since Oct 2022).
> >
> > You are returning EACESS.
> >
> > Before it is too late, do you want to reconsider that return value, or
> > do you have a justification for the choice?
>
> I don't think there's any real reason for the difference.
>
> Jeff - mind changing the EACESS to EPERM, and we'll have something
> that is more-or-less compatible between Linux and OpenBSD?
>
Sounds Good. I will make the necessary changes in the next version.

-Jeff

>              Linus

