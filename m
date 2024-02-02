Return-Path: <linux-kernel+bounces-49155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCF84669C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3136B1C22950
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A464DDC8;
	Fri,  2 Feb 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AL5KciDQ"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126EDF5E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845607; cv=none; b=pB8KfC2aCyDgrjElqrUV0bO8tf4ReyyzbnqoeuOaY8KMmCh/EcPdhAprYY6UnFaDJM/NVRGH5pzVsoJYVZ1wozSGE21O2X5MTl6UhjYvW/xDI36xpU26Gu6/PCr6m7Irq5D6Nge0cFyLrRbVX6HmMILyPvcMcev/xZv05DGpSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845607; c=relaxed/simple;
	bh=CHvpMXUMGdEK8NZSD4CDZcVeSXClJT86ZXmiaqeEskk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uclzHvLNGwEzgYXZK2xr1yyPoKnLu1vX9XFoGBX7uzKi5GPZ0HZLAZHmctMbR9oLfRcZ5nThZX5lm4+cA0WG7ugXwZzh1Cyq3fCcC42v/chjqmPbI24Y2y/YUXnxTNAEHtC+LR/8t2Jss0Q6I5tn+A0KstBBkzqpANTeuwh+iNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AL5KciDQ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2191dc7079aso71861fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 19:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706845605; x=1707450405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHvpMXUMGdEK8NZSD4CDZcVeSXClJT86ZXmiaqeEskk=;
        b=AL5KciDQ1Enc8Ph0lGvkcaTFXSsas6BtTihsGEB72WpVXHwmva56xO2UJmuooUG5p4
         fJHcgvFgEg9ik9TA+AtEuwQ/hczcyakIoZG0NKvhDPgMQIMCsenU24ERHtzX7TmkId7E
         gtAmL6vVe0sjk/q06XnYH14LVnE7mBILZGQpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706845605; x=1707450405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHvpMXUMGdEK8NZSD4CDZcVeSXClJT86ZXmiaqeEskk=;
        b=n8uASd6PDcpZkhdx/YOFc13vGHAOzBcU1rfA0pUaCk8oDY5fgT3RC+g3FOxeHIbXBC
         HzIBCjWtjJHah1J/mpRdkfp++o4d2tz+l9hbkn4OWCj+LBEJ13gqxsNVehzAK9bJXeAO
         U879mxMnA9YIr8UT8VM4wgfi2LvY+rJ7ihBp5MnLV96tkyEVIOwI6Pfrd4pvATfyvu84
         Y15vbtSDVWVk3/1qtYZKGrqYXDcMdPTmZ5dW0gndb4Ht+ja8zDYsknDS1H9RrQaLdKTB
         j4q8qe7Ly6X0diTTP1oHjp0e8Xcs80zawHFj7PJZMPfVQE+mhyVrTAlwfhzHaeiJLz9a
         5TbQ==
X-Gm-Message-State: AOJu0YyKgees/HUmyjTF/ErWh/ior2Lz1Id7JWtueKBrCGVHi3Ebrhi4
	kto0eDgBm2BA6OwIRYQ80/jZ+Cva9UAnRBHmIGpD7Lht0BYdEmFVy8gtPKchZBO+eZ/ZSrU1Cq9
	sk+ivz6HlsK7PZ+4p0Yz6warea+hKs217HtbW
X-Google-Smtp-Source: AGHT+IFaLYQ6xH7ZGnskC3dA5RRylRZtTukIItwMuUGMV7zHZoX35ESPs0YmlE2s6eabOCbrtEUE/tDNtzioC3obO5I=
X-Received: by 2002:a05:6870:6c0a:b0:214:f222:5c67 with SMTP id
 na10-20020a0568706c0a00b00214f2225c67mr7988236oab.34.1706845604980; Thu, 01
 Feb 2024 19:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <60731.1706826280@cvs.openbsd.org>
 <2024020137-hacking-tightwad-a485@gregkh> <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
 <CAHk-=wjGGgfAoiEdPqLdib7VvQgG7uVXpTPzJ9jTW0HesRpPwQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjGGgfAoiEdPqLdib7VvQgG7uVXpTPzJ9jTW0HesRpPwQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 19:46:32 -0800
Message-ID: <CABi2SkUmR3Sfg5QzPvFZa3JCgkrbJhXb1uY_-n2CYrwoSrD-Tg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 1 Feb 2024 at 19:24, Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > The patch Stephan developed was based on V1 of the patch, IIRC, which
> > is really ancient, and it is not based on MAP_SEALABLE, which is a
> > more recent development entirely from me.
>
> So the problem with this whole patch series from the very beginning
> was that it was very specialized, and COMPLETELY OVER-ENGINEERED.
>
> It got simpler at one point. And then you started adding these
> features that have absolutely no reason for them. Again.
>
> It's frustrating. And it's not making it more likely to be ever merged.
>
I'm sorry for over-thinking.
Remove the MAP_SEALABLE it is then.

Keep with mseal(addr,len,0) only ?

-Jeff
>

