Return-Path: <linux-kernel+bounces-109708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28A5881CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D721F21B12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775EF4D5B0;
	Thu, 21 Mar 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9byFJpD"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9841E4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004245; cv=none; b=uYD8n6bekSQHhyiBJDClW50De+D5yXTg3qy0ti2Lxvs+AVV/eGX9Wk3mbT6CTPs2f2bGioG4ajdhFpfLI2JI5T+3/4MCkmxYfaMOcHo1TeLH3F1NScScFh16k/BK635vfY7DyMu7MXGJclGC8EVTnkRZg3w+S6LGIglHJWi9RHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004245; c=relaxed/simple;
	bh=g920GDs7VWxnuDSKOujp5wmlf+IvPEGUayy2cRVJISo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka6KZHW4QdER7DfMnwnQUIyToALbJHdlsgQTvQztIEHPZI8VXVWMTJdgNh3n3/riHmkkK6fEU2QYpESPdE2eCSO7MoNdYEJk2fEMI9X8ez+lLbaZDsadj9ahsJ3HdAEzIP3PdfM+fjrqzdWrDZ3R61xeHmflPfocMeicUxKo+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I9byFJpD; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-47603a066daso206088137.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711004243; x=1711609043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9zbV3no8c83PzjBsl077R25GMg0rcg/3po9zJLqVKs=;
        b=I9byFJpD17UwMXL1gUb4zJqkv5qEZeiDu09CsYfuSsBv39c0B90mn0/3715AtJK26s
         YRGEGK/8zTqmeWjNkhMFvZ3noLRc4qObvuVio/VQHyP2gWAuEL+I5p6qCxLdIYs/AORp
         cr99h+4jHHNnD5AYIy+znvYYfpaCaVL9nPozA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004243; x=1711609043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9zbV3no8c83PzjBsl077R25GMg0rcg/3po9zJLqVKs=;
        b=ZmabvpjQhngtMHe53sRixU8T9wP/UG0QEjY2uc9mwngbBB0pnKJRhtyIidCWiGnRuv
         P/ebRq7sxEEmXvfVlVUte0T7qfE9/6i0h6Z0YB9gigC/1aLIG5h4wWNht8rFES0GRjW4
         egHP7coeCAUdeDXECTUC2VTQD/0CWnPvjO8ZSCABn5Dn5taHukXO6j6Gd4Sl+dpfrqh8
         eMz3SjsY22w4w8G1aXJQ1uT9iLN6A0p0ryEhE88gqLyHijZ3YIWy9Mh5ezNnXvOWOWpN
         81RGz34lZWGlb3nu8K/3OcrFjmkezj+Vuc8a2IddXj3beWlLv3iHB0eJqxfOpqteGWAA
         vfuA==
X-Forwarded-Encrypted: i=1; AJvYcCXTDwZs/WdEgZYmDAl1JLCm7TmMUOe7KFEqilyxYsIw9laoWtHJRvzAZzsRI+KnVQeF4wGmkojfY82gs4Vbof45JweFEh/BaW/OOqrG
X-Gm-Message-State: AOJu0YyFzWsk8m4dZc/PYij5s047RGUbYk6qF4cFswrxDbXr9GUBMKFv
	0xI94igra4VO4pTRGUXGmv/SWTtllipC/Ao/ehNQ6hzyaskFb74hq8gyU3nadaWIC+1nStoObmy
	/rA==
X-Google-Smtp-Source: AGHT+IEKeDGIT1pgcTgw1RjeYxpGRh2we/dS+fo/7b8ndJjZ6ywyZyR7aR+wHD5KbMfaUVv/qq7JKg==
X-Received: by 2002:a05:6102:3a09:b0:476:c65b:10a1 with SMTP id b9-20020a0561023a0900b00476c65b10a1mr460988vsu.2.1711004242972;
        Wed, 20 Mar 2024 23:57:22 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id r19-20020ab06f53000000b007dbc688e5e2sm1771172uat.33.2024.03.20.23.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:57:22 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e05d6871ddso298421241.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:57:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9cvcllmVNY8XjWikb7U4xFZ2KD7rBGHfjy27jk7MwRqqhm1PngSz6ynDBDueifsXRWfmdohTx16pXTH8u2zZAU3TlWYdGeM2v9ApC
X-Received: by 2002:ac5:c4cf:0:b0:4cb:56c5:5818 with SMTP id
 a15-20020ac5c4cf000000b004cb56c55818mr989958vkl.3.1711004242162; Wed, 20 Mar
 2024 23:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321064313.1385316-1-fshao@chromium.org>
In-Reply-To: <20240321064313.1385316-1-fshao@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 21 Mar 2024 14:56:45 +0800
X-Gmail-Original-Message-ID: <CAC=S1nixtu8e1L+dOUXxfsFmqW_5xR9NPuJWzyz0OxRXFPd0sg@mail.gmail.com>
Message-ID: <CAC=S1nixtu8e1L+dOUXxfsFmqW_5xR9NPuJWzyz0OxRXFPd0sg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fixes NULL pointer access in spi-mt65xx.c
To: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:43=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> Hi,
>
> This series contains two patches for spi-mt65xx.c, both focusing on its
> interrupt handler mtk_spi_interrupt().
>
> The first patch is to fix a NULL pointer access in the interrupt
> handler, which is first found on a MT8186 Chromebook device when the
> system tries to establish host communication with its embedded
> controller.
>
> The second one is a decorative clean-up when I'm working on the first
> patch, which simply renames a variable to better follow the rest of the
> code.
> I put this after the first fix because I think that will make
> maintainers and users slightly easier to only backport the fix if
> needed.
>
> Looking forward to any feedback, thank you.
>
> Regards,
> Fei

Sorry, I found I messed things up in the last rebase and this doesn't compi=
le.
I'll send a v2 soon so please disregard this series.

Regards,
Fei

>
>
> Fei Shao (2):
>   spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
>   spi: spi-mt65xx: Rename a variable in interrupt handler
>
>  drivers/spi/spi-mt65xx.c | 47 ++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>
> --
> 2.44.0.396.g6e790dbe36-goog
>

