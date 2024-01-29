Return-Path: <linux-kernel+bounces-43631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9F8416E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5671F249A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0315524CC;
	Mon, 29 Jan 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD4lsmy0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F08537FC;
	Mon, 29 Jan 2024 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571090; cv=none; b=TMkqLy95CP5UnbkobAlbk6WftVcPyhpedUSaFY7ycZD+SXobXDyGcJbXs/faVVdR8/5r71u1vJ/517wm7STW044CFpztKgXMb+TiT15M69fqpAI0o82UuHn0/dahfZNsoobyqkFkJ7bQDbXeIgK0B9o0dyXF/zOj3XUHSRpMNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571090; c=relaxed/simple;
	bh=dVuaFc64rvJbB9R+yIeTupEaMGFc3XN/LDmpxH6yLk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZDsCZPOE1xscw04QPTzzO2moJTNInEzou83a2+uHOD6OUI7VuaGYTCXSaeUuok7Uh90u9KCe6ShNOEFIMDrJCN9S4Cb7/9LvfJLQDS9YoybhCGNBVcQnv/oY/4/kxXAiFBd8aC9V4HjxgG0nd2K8CQ92Ay09la+60YD1u6poRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD4lsmy0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a293f2280c7so357397366b.1;
        Mon, 29 Jan 2024 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706571084; x=1707175884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEMJTXl+GfGonQl14oiWn9O9imAgSOHWkAMPGfCNJF4=;
        b=LD4lsmy0r09Cr/yaoC+upaW1//XB7YaoneYjiwVdg5orysDQhR8yzknLTzn6qUJIFl
         pS2M7qnXgs1k6dOvcT7fy58RrZmQkfOb7OQ5fh47tdI4mxeOkZqDQgx+K/iqcKqqyQee
         HCDgqNvTBaqPl97ApKPDPZ1swr6uUlQP+j/l2kwISlh0bYXZSUBCsOAZIfjNaiSayVoB
         dqXBZrQfrNjITzfNhuYrVbk1e2Y2aawcOCHWVRcE9VehBIV42nAtZau8NCembS6r1uO6
         x5UKWEh0zQRQn5ObbKMUM+0iJgPrUn/qpA3k5QIOfwnan8484LUHUS94VfNQrl+wA79f
         BsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706571084; x=1707175884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEMJTXl+GfGonQl14oiWn9O9imAgSOHWkAMPGfCNJF4=;
        b=WfLlNhOjhtHNE44NibzTq80Mhc4l5VQ1YQ1Y06RedkZJQEua+FoM59RjiKJ00bJvec
         g77mBII1jzOdrgQqsV9IXAgnOxRJj7W3UBrqcTH+B5wdL5nO78g4FxM2y4nJEaJ0ECyj
         llEYTdxYph+R65ELxD6XPPcw1qEragueK6PepS2F6VYvcuNguOwc22qbRwyV6ENmaC3Z
         lX3QzVxCHd0Aba10POE8uk2yqRazUW8x5PNxxXuYY/zh11rjKg/nHH0IdNmKOxPq/yiX
         Bmzu0Y/fIA9+72ZZ88psZRb95PmE+ivvIqc2WUPoIMtms3TaAqU88Pi5B222uED1YF5n
         kfMg==
X-Gm-Message-State: AOJu0YwXyV/kr5flcb+RVb686xRaePTY8cQ6gLUCulxd0Rn78/PnBMRn
	8eok88nJCK9F6fXhuQRmcmWe8SpsyZO9xQljC3x3huDR1Vb3FW+jgn/CspJ4W/+BCMDN52iIq5n
	F5DKraE9hP4Mh4UHLaycDwuMKL8w=
X-Google-Smtp-Source: AGHT+IH3SNNJNGlOeMtK5U/x4y9vVRUCg+PUM8gRxqf0GGrB6Ub6SFsxnV8xfyz1Ls6PTr2x65tmGcIR3qDQ9/xeJkU=
X-Received: by 2002:a17:906:fa0f:b0:a35:3bfd:9e87 with SMTP id
 lo15-20020a170906fa0f00b00a353bfd9e87mr5008860ejb.60.1706571083725; Mon, 29
 Jan 2024 15:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129202901.work.282-kees@kernel.org> <20240129215525.4uxchtrywzzsrauc@google.com>
 <202401291357.DAA9670F3@keescook> <CAHp75VfgmLoACfjphHi30hSkL0Sa1AueFeG=qGQvwnewqyjrRg@mail.gmail.com>
In-Reply-To: <CAHp75VfgmLoACfjphHi30hSkL0Sa1AueFeG=qGQvwnewqyjrRg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2024 01:30:47 +0200
Message-ID: <CAHp75Ve=bnGQR=mf2B-uPKjhwcOhBr6O=7Q-wm5AWSShOg+urQ@mail.gmail.com>
Subject: Re: [RFC] string: Allow 2-argument strscpy()
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Andy Shevchenko <andy@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:27=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 30, 2024 at 12:03=E2=80=AFAM Kees Cook <keescook@chromium.org=
> wrote:
> > On Mon, Jan 29, 2024 at 09:55:25PM +0000, Justin Stitt wrote:
> > > On Mon, Jan 29, 2024 at 12:29:04PM -0800, Kees Cook wrote:

..

> > > BTW, this hack for function overloading is insane. Never really looke=
d into
> > > it before.
> >
> > It very much is. :P Hence the RFC nature of this patch. I don't think w=
e
> > any any other API in the kernel that does this (though there are plenty
> > of wild macro wrappers to do similar tricks, like the syscall wrappers)=
.
>
> PCI has a couple of such.
>
> > > I like this, though, should you include documentation changes/additio=
ns?
> >
> > Yeah, though I'm not sure how to do this -- kerndoc expects a fixed
> > number of arguments. :P Maybe I can just do something like add
> > "optional" to @size:
>
> Use ... See again PCI header (pci.h). One of the macros there has a
> valid kernel-doc.
>
> >  * strscpy - Copy a C-string into a sized buffer
> >  * @p: Where to copy the string to
> >  * @q: Where to copy the string from
> >  * @size: Size of destination buffer (optional)

FWIW,
https://elixir.bootlin.com/linux/latest/source/include/linux/pci.h#L1517


--=20
With Best Regards,
Andy Shevchenko

