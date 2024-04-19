Return-Path: <linux-kernel+bounces-151526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523688AB012
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E37D285299
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4684012FF73;
	Fri, 19 Apr 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LFHewI16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1A12D744;
	Fri, 19 Apr 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535338; cv=none; b=BveLIPGUAPSjvb4eq23Tt4XrzYAiOnpKtB5706mUGCh8TKw7jcSUbcnB1CtCEdeixlAHmJ1lLy+aNPcY1S9f2fpTgGUSwIYnVxD0F5bpIVXN7oVPfZTjLiSNWYtzcsh+lDbnn5Y/8oHmhGdVOKirvH5B/aklnwfBM/1j64h5uvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535338; c=relaxed/simple;
	bh=FJfEI6GzG3afZWZIrknhqcjBdcZVJlc1aHXuX5s47As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNIwVy1HI/HDQVzENkE96u5RAF5t7m5u2UVJ2TOrnwrhGKJjghy/ltgCW+1ktM5rfXwIM6bIGnQfqUDYGv7WZsQZ/rq9BsFo9cUcqG8uKYpd5V/6XKAtxY2iCTI3uAB9A4Nu9AsaGctE9F/HNYh1yo1MrH82ECz3Rlr+njz6nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LFHewI16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA2CC2BD10;
	Fri, 19 Apr 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LFHewI16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713535334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5aJ+qzLIEKZVThXhB9I5hodcXOGggiyzT8HGq3lwvo=;
	b=LFHewI16bBVvlXq5Ot/4LoFfsqgfJwnvFdhQH2KWR7Tco4KfJ/5bl6iknx7sLi1YoBF4w5
	/BBvLTN++RBbzu95sUsvXLhvPPhmXJaCZ8vZUHmBzj8VBAabt3DL38vToFYdXrpFekvoel
	QLF4ecrpiprpbItyfJxyJPSElqcKZjI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5fc088bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 14:02:14 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-615019cd427so18286777b3.3;
        Fri, 19 Apr 2024 07:02:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUA2UWsaqw/o7j/sbLoc05p/nn7XMOOjyotGfpLChb90amqaB/m+AYwus5OULiPQPyfxQJja7viNxB7QvM7ltOkZAXLdjQx5AbpR8EEcLcdm9cX4OLPqpuFgYhbsNwdMpupbDgozZSdg==
X-Gm-Message-State: AOJu0YxayTPnI+jecC9R5e7BOaXIkOiomwIM8nJFui97mkpuiRXDFfiT
	9WtdoUi30sudh/XesZsF1Cd+HWcL/Mnk9/R1JA0xj9mKoDoFxGNIuhQ9BsDPzhWWcpxdwFjaA2h
	rNZjXM3VF8q5Y/94ja4IzpnYYgrg=
X-Google-Smtp-Source: AGHT+IF95L9A9VHaslFVCvz8OqaKtH0PPM3efnyCIKkVWqs7bqSEYSUJgHTQyGCVhL01ZvmdASvGQwUQ629oppW+oOg=
X-Received: by 2002:a25:3610:0:b0:dd0:6f7:bc3b with SMTP id
 d16-20020a253610000000b00dd006f7bc3bmr2116623yba.10.1713535333203; Fri, 19
 Apr 2024 07:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418121249.42380-1-Jason@zx2c4.com> <20240418121249.42380-4-Jason@zx2c4.com>
 <e4cbb6ab-975a-4d91-9bde-6976b4d84eba@amazon.co.uk>
In-Reply-To: <e4cbb6ab-975a-4d91-9bde-6976b4d84eba@amazon.co.uk>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 19 Apr 2024 16:02:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9r8+ULD74ehz-LOpuAXb57BDFCD9Gr3Aw-JPJfTLC5OCw@mail.gmail.com>
Message-ID: <CAHmME9r8+ULD74ehz-LOpuAXb57BDFCD9Gr3Aw-JPJfTLC5OCw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] virt: vmgenid: add support for devicetree bindings
To: robh@kernel.org
Cc: tytso@mit.edu, krzk@kernel.org, "Landge, Sudan" <sudanl@amazon.co.uk>, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sudanl@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, 
	krzysztof.kozlowski@linaro.org, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Apr 19, 2024 at 3:30=E2=80=AFPM Landge, Sudan <sudanl@amazon.co.uk>=
 wrote:
> >   config VMGENID
> >          tristate "Virtual Machine Generation ID driver"
> >          default y
> > -       depends on ACPI
> > +       depends on ACPI || OF
>
> Version 2 of the patches had these flag but were removed in version3
> following the below review comment from Rob:
> "One of those is pretty much always enabled, so it can probably be droppe=
d."
> reference :
> https://lore.kernel.org/lkml/CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAq=
s-mXC+Q@mail.gmail.com/

Are you sure about that? I see other drivers that depend on `ACPI ||
OF`, and this driver is totally useless without either disabled
(right?), so the dependency makes sense. I think? Not an expert in
this area, so I'm happy to defer to what you know is best, but I did
want to lightly pushback a bit.

Jason

