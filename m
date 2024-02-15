Return-Path: <linux-kernel+bounces-66374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E2855BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351AE297912
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567A1078B;
	Thu, 15 Feb 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2/rt2MJN"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540ABDDC4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983176; cv=none; b=igrrOdb1zo8hvxPWn2+8iXyLQdbYOIu91ZBturxqbvv/n5OSLABWEwBtBOKE46+ZXR6AHUE2O8R4QBjDD7/NhbEXOPBeLc8qzPQ6UajEg//VMObAHaYO3P9IQpps/UH/ycu/1emb25Xw8Sl+3++k5PO8UPMfor8/MU1/L/0G1bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983176; c=relaxed/simple;
	bh=c/2GB3BtXo0+oGkI0nfxQUO1zBWY2xEFEuuIPQ58jhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L63M7E+5hjIAJN9tRGv17zzDjQZAqCpV5mT8x+Z+DNoHfr18KsQvIG4TGi6WtVWkm5qA5yTa9C0GBVRKY35nX0b/Vp8SMTFgF9ZS7bpjPX39b8qVslUlb+hndXwqgEhqHTl83VBf2n//WwhHL9oBwgTutI/ZAA6uSiWN6RC9gXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2/rt2MJN; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c0ac2d5de7so167723e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707983174; x=1708587974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/2GB3BtXo0+oGkI0nfxQUO1zBWY2xEFEuuIPQ58jhc=;
        b=2/rt2MJNWShWJ/+7ufymqS8xIRXEyU0z6bgj7kM0VKarjNdmIWCL7Kh+FWMbAGf/LI
         IQaDnzVtWeNsV3tJbjQ2KDyzygDW6RqoHQthO/PLniAvpD6scd6iMOZNzIPIYjAt/scy
         cfoyGiiAAndkufeLc5HCz1qEKdp9a9sJ4bJcSQnVKjqAkcQ+WrIbNIFN+glK7na6pywH
         aR3gnBUF+hnXDR1IdUKqi3QyEfBWbe92mR8VGS4r/ohExpI1fGz58wmzFbD/qLWXozkz
         iU4S59EB8kRFQ6xFTltSEcEcnF+RPraClByevlM7pc1etf9xSpNPcI5HHyh8ODbipjQv
         Btyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707983174; x=1708587974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/2GB3BtXo0+oGkI0nfxQUO1zBWY2xEFEuuIPQ58jhc=;
        b=WcDPuquVbotNARaehzuRzCYG7clkDaE0N1md87ZLjcn7qPTN2tq2HoYaiAILQhNt+i
         Lpa7pvJaE+mdhvBIePovGb3GvHdGKLtfMBFhxKB1U+JCwKboPCozLFmLqY0ETEyoqTjP
         TBcOCvbkBhNLVIkhhT1ZmKQNFR2kn7OdJ+k3NovWVe5IyY90/n8FA7EmS9htOiodFU8m
         qVUexhIPuVxkip5ID6wOQZRcpIkGChJmc24l2MdanBWYOC9PGhzSv/gkyFvvQ6zIJEOq
         naYaU0T32ROf+Ruaoy85hnQKIPqC4c/I0a4tHzScZfzj8JbTM1a9I9jp0GnbXxe8P1e0
         P0XQ==
X-Gm-Message-State: AOJu0YzOY7UrWM1qG/6ICEBiKxzGqMwgwknY7s09TIos0cSkUjNrBrKu
	FyNQzgeYoPnrsaYvq7oUVDHuxQUEhqjiYlr6YD/aZ3r6hUNMkIZQzOQ/sCAZ28vf7pMBZmNvRpS
	a0dpZ/YB8h0/uEuyBTw0cAOJkXIJKgkF3nSJ6qg==
X-Google-Smtp-Source: AGHT+IGWJEHeP8ceukZBq9swU7nqm4iIxqr2YFfw7ue2G9JOtY14BpVkMbbx8NFLoRLb6GCWS0VkVQHn/Tt9QFS7yBY=
X-Received: by 2002:a1f:4b44:0:b0:4c0:24e6:f49d with SMTP id
 y65-20020a1f4b44000000b004c024e6f49dmr674610vka.1.1707983174166; Wed, 14 Feb
 2024 23:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211101421.166779-1-warthog618@gmail.com> <20240215010733.GA30995@rigel>
In-Reply-To: <20240215010733.GA30995@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 15 Feb 2024 08:46:03 +0100
Message-ID: <CAMRc=MdrkCp2xMq4_Qa3i-tMNUL0=x8ubSRgGjRJHWPzw3=KAQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 2:07=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Sun, Feb 11, 2024 at 06:14:21PM +0800, Kent Gibson wrote:
> > The documentation for default_values mentions high/low which can be
> > confusing, particularly when the ACTIVE_LOW flag is set.
> >
> > Replace high/low with active/inactive to clarify that the values are
> > logical not physical.
> >
> > Similarly, clarify the interpretation of values in struct gpiohandle_da=
ta.
> >
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
>
> Just checking where we are at with this patch, given you've merged the
> two documentation patches that followed on from it.
>
> I realize you have bigger fish to fry at the moment, so sorry for any
> distraction, but I just want to ensure there isn't something you are
> expecting from me or it hasn't fallen through the cracks.
>
> Cheers,
> Kent.

Now queued. I had skimmed through the discussion and was under the
impression that you'll be sending a v2 of this one, sorry.

Bart

