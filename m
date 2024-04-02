Return-Path: <linux-kernel+bounces-128598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98817895CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B17B2206A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A415B98D;
	Tue,  2 Apr 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCjyMcEg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE881EF01;
	Tue,  2 Apr 2024 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086954; cv=none; b=a5uprzdtheFwZUfw89JjCsKtYOO07rHUmdNElmZDeu5Pq+F9GUuABhwtfEahWxVBckFse/EIItfY4VniOe5xGtvqC6PFd+J8kZAUpDql8UIscg+RRPlhbwIzw35hRhi7rIZCikaZtufO0Tnn1ofPD5WGbJI7RhkJfYSo1qWT0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086954; c=relaxed/simple;
	bh=VLN0GvoxXHbcgeuzQAHDb4xeRudfTmKpVn5GgSsrGmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnUu8FloP5oc21Ve4Ofa/ormi377zKEsE16o92iPMK4VBapnLIfa0oAq0jTlGIfPKbceuF4gWQhlmkkBnSGzfELl6gxrEYQy5C4L8vphS1pdUeOBqWTYQsi+w+s0E6ZY7+ToQduYi41A0L8YK+nqO7qCUthGcG/H71AXV9In95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCjyMcEg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46ba938de0so742534166b.3;
        Tue, 02 Apr 2024 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086951; x=1712691751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLN0GvoxXHbcgeuzQAHDb4xeRudfTmKpVn5GgSsrGmE=;
        b=jCjyMcEgq29R8PB5jSVsOxsHpN0E8tzKtsE7uidQJKE/gqV7EtY2pCbbk0jzBdlqSy
         mjCl0mpQ/xXGoeRcmPGeakdalgvG9Dl+ncHtvr4LNK6+4y2RggIlt1sLGBBC3llZQGA4
         bu5SkeYkAAf0Nofl/E/THZ/XhSNWiNg9eHxkLt20WNN612MXFwLZeWEY0miEgNaZUKim
         XARnERZZ26rwE9Ai1cU3jMKxSSjW3EuG0D8pRTSBj1f2MWRexg5BPNZvP++/RKd330N1
         NPigUKmubdN1SOgMvus+DVJputTQJNFTlWL5x5xTP9uXX1MiQK/bD02paTFH5KTxErTM
         hlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086951; x=1712691751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLN0GvoxXHbcgeuzQAHDb4xeRudfTmKpVn5GgSsrGmE=;
        b=XRG4dtoUg+CoKpJ8GZ4dR/wE5wcrrRlKaHAyHjfk3dA4tGTAHqRxPygEw1j6fLrRSk
         rTTEkKtZSUg6Ikkunh4ntkQ6iZVTNtbbJS0zSIKnottWeG8+Faxo7r+MyESAR70PBpby
         wA+/S+prDHo+cjB9RdZEw7cnaGz++6kqod8vvuH6QAj+PByaCfoMbsu9L73gk+wgmeRM
         r4K4gWgIyoi8kHCti3wmZD6WYDseqtttXMDtJbiO31m0dDeXwF8eN6gXOOnY3Bzo5nl9
         LKs6rCbipmTYzRM+po9OFyPEBFREqkMY2YCjTsit/ScvyykepxdVGcPo0/yIEROhJxjF
         fAJw==
X-Forwarded-Encrypted: i=1; AJvYcCWkA+WLf0b4rSlbbcsLabeAFF0L/BWvIOtqzT9cFw7cYvZD9jAVRDbZG/ONdGDSaG9qQK6hhBKdns7+I4od77062f0ciMPqSzv6xVQPS+/rYdN7LBvOUd3ZG8h5HhvS66evRbCuB7WQxpg8
X-Gm-Message-State: AOJu0YyRVryQ3BKtjVbeMLx65/E36jIOnoa9yuxblK70dQ/deySpukuI
	GI1pSQ9WUzb791VJ4i+zP/foXEZ7RngZsOMcbVpE8ZrzlGG+tdhwfl5e23BF3vITaWX89dlXNPi
	tgeX3nypCYDy9+4ZkNAI71KjPbYM=
X-Google-Smtp-Source: AGHT+IGWoVUBHO6cFd46RaUv4TkpRlu3aoYPZGGnMy/legnwvw0WZjzJJayDTE22W26g9TKGq7A+GpGdtQJGuVYYT90=
X-Received: by 2002:a17:906:a151:b0:a46:cef3:4aba with SMTP id
 bu17-20020a170906a15100b00a46cef34abamr8684309ejb.75.1712086951031; Tue, 02
 Apr 2024 12:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402174353.256627-1-hugo@hugovil.com>
In-Reply-To: <20240402174353.256627-1-hugo@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Apr 2024 22:41:54 +0300
Message-ID: <CAHp75Vd0bjCdUse0yL67GZsqh5b-76aaD+N61UNAi-9rD2oZmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] serial: sc16is7xx: split into core and I2C/SPI parts
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Hello,
> this patch series splits the SPI/I2C parts for the sc16is7xx driver into
> separate source files (and separate I2C/SPI drivers).
>
> These changes are based on suggestions made by Andy Shevchenko
> following this discussion:
>
> Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=3DMrn2kbYs1Lx26=
f5-8rKJ3RXeh-w@mail.gmail.com/
>
> The changes are split into multiple patches to facilitate the review proc=
ess.
> In the end, some of them could be merged into a single patch.
>
> I have tested the changes on a custom board with two SC16IS752 DUART over
> a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
> configured in RS-485 mode.
>
> I did not test the changes on a real SC16is7xx using the I2C interface. B=
ut
> I slighly modified the driver to be able to simulate an I2C device using

slightly

> i2c-stub. I was then able to instantiate a virtual I2C device without
> disturbing existing connection/communication between real SPI devices on
> /dev/ttySC0 and /dev/ttySC2 (using a loopback cable).

For patches 1,2,5
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

