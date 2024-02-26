Return-Path: <linux-kernel+bounces-82129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9238867FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8013F2912C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C74F12F362;
	Mon, 26 Feb 2024 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VCSiRFYJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5812E1FF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971596; cv=none; b=BXvMi/wHOrm75PVahWd+2taJcPRaKhba7b7/0pGZtbRf5B61WZaMpKJRL8cj3sYj3o7+60wpfOF95YK4SC9avE5qb8gXIhMgBD/FbLw+qz1q/829hlSc1Iel2/wNysi2I1A6GAejpi23m8HswgWhONzhOsohAhg/ax93YZjQg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971596; c=relaxed/simple;
	bh=rFBHf3WhN6KMMNJ9EOPkQZj11qYxQQpZBIeoEU4pQ58=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=IZx4Devd23w/Tc0Ivp+GEwi1NjDhYjWOuN2EuL7Opzjc7GzAPe84mMceGGhoioPXe+rIqdgRQhOuIMk+2gxnH7JTVT8FxVa/yNT3pmkG7FkQ2HGufyC/bg9FxrU9BDgyO4lyj9LnA8qZomHdUC52iydoW5Xeactz1RcRSk3Am2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VCSiRFYJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a9c1921dso2560335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708971592; x=1709576392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYjZkD+0muyfme0ZAvaQZRAnb6hcDJgJvM4YVzcOSBg=;
        b=VCSiRFYJD5uvV/KMXcNAP9Xs/h7xo9pwqy4ZVnIpACbnaYfEXgC9Fy6ptw5NUErAGD
         nmitUcgwxLUcUCfFzpq978kgjHSJeHqIrIfogKZKSZ+KbzLDpjZbeLO3DKUUM8/DVg9L
         bl5EvphIKPuGWRa9dYEJ2cNGycWxeT0p3Ko/VTc+Ti14qZSR9W1Z+Vd3RHYo05dNGCeQ
         W8Fl5nd0upQq2Lt/lPSvQRk7G5sYQd/9PdZIaAuFXzEkkjOCfPfLXUauUt1X1jG5nhER
         yojp6+ozgtXUA9p4b3L8thgCCAux7zLTM3/UXynGoAwzsLhWl0OC/Vguy3uUHRrEB/N1
         Gp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971592; x=1709576392;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYjZkD+0muyfme0ZAvaQZRAnb6hcDJgJvM4YVzcOSBg=;
        b=LiwyKyYWTO8V1fIdeF/EZj93Wchc3F1LAB7vAjBowdhEDjMcgac0lAfe8UUDPHHTGV
         AWglxWn+84F0SK4Jx+/3KiHGEUxkKMhXtJbzwj9nGpziBbZ75v/QvaQWS1/4LISERaZv
         0K0Ign0uIm6+tcxMKbRu4d4p1zy2/gdhOdyw+QaDMrvQsoFCLDIucw8tJKvwPlp2x0X1
         hSrWnzPzSo8IUVzyF1b9/DSB6IuCu/R+zOMJtqZNAKygDlTD1q9mrhGUt78VZMPha5yy
         DWUaBE0GMMFPIbLo05VIk2ndklP7KpYB5RY2dIrsnsfNXcd3X+VlgXFGTL43wqgIc75u
         zXow==
X-Forwarded-Encrypted: i=1; AJvYcCXybrFr6KZpEAVnoBmqi1irFYFpIfMGcTpe4PrKylhGupwBHRZVFFtmZsuvkdqtQg6nd2nl6TmIX+vosU3btZpL3N/nskUdKC+tVkTn
X-Gm-Message-State: AOJu0YzR0kxKufVelxu4QfZi+HC2sFulcGMpxThaLXumTmBEGyRXA9rX
	CYyvKkn4Wlz5DLcN9yOQOhKHqUkrFknsEE73bL6eCpWTlivVxvR4TTb9BNsAC2U=
X-Google-Smtp-Source: AGHT+IHd4q24wEXN+ZHmPow1e3uPSDobPnHsBEDUab3+mDUNHABiOsz6pyHCGDApLnilqTkrgTRdIg==
X-Received: by 2002:a05:600c:4fcb:b0:412:78c8:b31e with SMTP id o11-20020a05600c4fcb00b0041278c8b31emr6525048wmq.2.1708971591932;
        Mon, 26 Feb 2024 10:19:51 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b23d:6981:ba6:e52b])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c028a00b004122aba0008sm8846662wmk.11.2024.02.26.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:19:51 -0800 (PST)
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
 <20240223175116.2005407-7-jbrunet@baylibre.com>
 <a828b4f7-282b-4b83-9a64-04557edf9b6a@sirena.org.uk>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 6/6] ASoC: meson: axg-fifo: use FIELD helpers
Date: Mon, 26 Feb 2024 19:15:41 +0100
In-reply-to: <a828b4f7-282b-4b83-9a64-04557edf9b6a@sirena.org.uk>
Message-ID: <1j4jdvdr5l.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon 26 Feb 2024 at 15:42, Mark Brown <broonie@kernel.org> wrote:

> [[PGP Signed Part:Undecided]]
> On Fri, Feb 23, 2024 at 06:51:12PM +0100, Jerome Brunet wrote:
>
>> Use FIELD_GET() and FIELD_PREP() helpers instead of doing it manually.
>
> This breaks the build for me:
>
> /build/stage/linux/sound/soc/meson/axg-fifo.c: In function =E2=80=98axg_f=
ifo_pcm_hw_para
> ms=E2=80=99:
> /build/stage/linux/sound/soc/meson/axg-fifo.c:149:28: error: implicit dec=
laratio
> n of function =E2=80=98FIELD_PREP=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>   149 |                            FIELD_PREP(CTRL0_INT_EN, irq_en));
>       |                            ^~~~~~~~~~
> /build/stage/linux/sound/soc/meson/axg-fifo.c: In function =E2=80=98axg_f=
ifo_pcm_irq_blo
> ck=E2=80=99:
> /build/stage/linux/sound/soc/meson/axg-fifo.c:207:18: error: implicit dec=
laratio
> n of function =E2=80=98FIELD_GET=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
>   207 |         status =3D FIELD_GET(STATUS1_INT_STS, status);
>       |                  ^~~~~~~~~
> cc1: all warnings being treated as errors

Ah, I forgot to include <linux/bitfield.h>. Thanks for letting me know.
I'll fix it

It was fine when I tested with ARCH=3Darm64 and the default defconfig so
most likely it got indirectly included.

Could you tell me which ARCH/defconfig triggered this ?

>
> [[End of PGP Signed Part]]


--=20
Jerome

