Return-Path: <linux-kernel+bounces-153429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA538ACE05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6751C213B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9814F13A;
	Mon, 22 Apr 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG9kbzbv"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A73399F;
	Mon, 22 Apr 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791911; cv=none; b=RAo7KntiwdSBDtrbf1g1eNFGZAXPjiSnjXuUSqlugxgFSud0SAbyKQpOJSOeDqWs4ceg6v7kmwfx3xPXyBOHnhmXsfAdnISchX8kAzYwniDZseThlJpoSeSXakG5sgJpeuVNwqvlr3kwPor7CH9niLgyhUQeGhjGUHtdsQg9cAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791911; c=relaxed/simple;
	bh=oH1R0IQ5okr+fcRE693xdM6cp7GPSY26awGZ2I/bPyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqDswts65feBKtKtosgVnTuQJPlNtlse1emLYMGXPwpzW0r+2fr6My6GK4BnScWMXB+b4CMgUaLjmlGD4jjZcTLqlSRkUnPfr4EgjUlUSHukC9bl7oQwrFiXDBuJRH2dqITnrOe7ISZL+0Z/nNsHqwuXtfOq3jypI3X5n6I+Ei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG9kbzbv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso6842564e87.2;
        Mon, 22 Apr 2024 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713791908; x=1714396708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH1R0IQ5okr+fcRE693xdM6cp7GPSY26awGZ2I/bPyA=;
        b=hG9kbzbv6mhe5DAmWl8v1yDByzrRRLCBG/t5SchjEGtprRwbxeC0Lv7PyWf49afEsb
         PNmsfgTRsLZ5h/ms6E9zsVfvhNcFkozC0L7xMl2CdMTjX5KE3ZVVlDvdq4gHOv0hTY0Q
         oBUXi0QvitzV75Tp+urqQj5qjBjE2ltE/JpvOo8yU2hWmpY48ZIL2YKD10hjPfhVge+B
         v8/SS/ca5z5UpkpWms6iBUSBnBU/DPXCiOcqc1gxySFS057fZf7ekR/Pyq4iG9DMNlxj
         KGxno4hklnYfNFtXI2vX4+ipcIz/KfWOfeJ/WLcUMJIOXqC6GiYalKREiKqCPB3btUvp
         RMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713791908; x=1714396708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH1R0IQ5okr+fcRE693xdM6cp7GPSY26awGZ2I/bPyA=;
        b=marvfVVVJ8C1rEXeH9l7lyb1QOZwSAzRH8yQ7JT20UVhpGJgBWqKKs8f8CXyX3yE7x
         /idy57nC0wQt6tGStymd92eEPrbNzNzK22Q/TQ9NU6g5jwvHLoOibmMI3xS+bs1TSi+P
         yPnHE5L/KHc5QrQZ7l1J7NVim4PDGIwdVkY+GOTz2emGDfN64TGG1GWZeKDX864duskg
         GfI1NzNipVoRRfXDccgvXvdfH5wGHhxqjxwDKTR9HGzokXKJCuWUZJUyvPOEfXuafLqr
         8Njn2RKne7SQ5/Gmu7sSifv+ZgcOcq1cKWPMNrd9vmfqow8jn/PCG/6WG3qSndyDdOvg
         DY1g==
X-Forwarded-Encrypted: i=1; AJvYcCW8c2Axov2+VignWgtNIrLZWGZOd1fU8s0sbqALMnDBO0lqcuMTb0bJx3ziSFtNSqg4+YNecxSTWUvP1d9gA8X0BTKaoB0B5bfoqM2UdkexHGQ0HRq5LU8txeqd0pp8TvdVPVTT6pcX/IrA
X-Gm-Message-State: AOJu0YwG1CZbXj3R3lewdj6Fpph80ST0EyhCaN39n6/y/Ticir7WJnCf
	jzbjkLyonmzz/5ols84q464snAEhzYR/ndDekoSAhDYxlYNAhcCCiBAMRsVUomgUqqo7hM/VP9W
	eUpn/ouZWqfb3PxnuEYfHvQesYMs=
X-Google-Smtp-Source: AGHT+IHiF+CJbeJBpnqiMIUJlPP+HthhFpz+ac8LBycAWGHna+D5nbZF4aeIUQwuUL1OmY0B6OQGNutg+LajTART5Ug=
X-Received: by 2002:ac2:41d6:0:b0:51a:c490:8d55 with SMTP id
 d22-20020ac241d6000000b0051ac4908d55mr6695585lfi.13.1713791908094; Mon, 22
 Apr 2024 06:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422123801.2695129-1-rilian.la.te@ya.ru> <20240422123801.2695129-2-rilian.la.te@ya.ru>
 <ZiZcyhoKRgfteO5d@smile.fi.intel.com>
In-Reply-To: <ZiZcyhoKRgfteO5d@smile.fi.intel.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 16:20:40 +0300
Message-ID: <CAF1WSuxPmzWYhCQU3tiA_GYMLowxMuvEJWRv83atithv8NCRxg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
To: Andy Shevchenko <andy@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:56=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Mon, Apr 22, 2024 at 03:37:55PM +0300, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
> > after the commit 4afeced55baa ("serial: core: fix sanitizing check for
> > RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
> > always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
> > breaks some hardware using these chips.
>
> LGTM, but I leave it to Hugo for testing and other comments, if any,
> as I don't have a HW.
>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Andy, I need to do v7 (because there is a missed fix), but Yandex do
not allow me to send more mail( So, can it be sent next day?

