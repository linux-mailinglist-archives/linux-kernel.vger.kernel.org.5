Return-Path: <linux-kernel+bounces-77964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E312860D64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB711C2509B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109AF1B7EF;
	Fri, 23 Feb 2024 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GvU863DQ"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3B29425
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678733; cv=none; b=TQzOoV2PpMQ3FQynggfssVwe1BydULAydRf2exfg5k1kVFtxDe45bjJIJObv9dl4T/CiUPVAhyo1yWX0ZG4kcy1sFMJ7qpldcdYzIMnYZSP09qSJ9+5328Rd7NJv34i07yBtYddtn5YBm1uHhy1DAkbD7jysanwBLmud8RiPgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678733; c=relaxed/simple;
	bh=yml1Rz7s3mR6tO9FKM3OAOqt7AHAEkaT1I5a2+DNf5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJDhqpIVJHLVpH0HrsKbu0rn9XgicDNErguSgDp1yFzh9tRLYGcTaPxmtdd/+xyJXbuxAQjEU+ELHlpcbxGiShkAVRwu+xUctYCyNHTiiVSyXyJK3AQd52fGAsn0W5IfZ2K34/eHogky9Ws7CvQ1hus/q6yUgoHA0/gUe9g9GOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GvU863DQ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so207250241.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708678731; x=1709283531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uI/vdQg5UeNJ4dmbbqkc2ezjlu04dZOug2/6SvrZwnw=;
        b=GvU863DQDEVxnkTe/8Ylw7awOYKCk6s7I54BbQ8EdpyXNshjZiklUHAOq7mWIrHwlL
         jc1qebfBxOGI29+oHQLp21yGrMoAmU1SjwaSHNZJ0pdm1tcV2jhNn7nMToUoxNPudq+6
         crbnJp4qoA+BeNKTXgKP4GXSvE6hKgt02Ubt2v+1yJ2F/XCZF79E3s/YcKoEh27e6IKt
         qXQysw8+tjEtP3KeMmIwO0vh9nNLeggZvXGKAiTknW86TKesPwOZXst+KItahNOWSXaO
         J9V5zEJ1Q/FmujmKuZrL6qNmfIquAdOnQjFAW9jrg0n5pUCc/JT72WWE3vty98uhRlkT
         w/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678731; x=1709283531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uI/vdQg5UeNJ4dmbbqkc2ezjlu04dZOug2/6SvrZwnw=;
        b=p//TNrAkTpX2oONAjK2vrVjy2fBjWbrkQReuJyJD9kdnEX//PN4BOM0Bot8bn4pzye
         eIPCdcGfB2lWkfF3HTMDEQy6nVz0B3nYmsKV2VPw1628NeNYxz3QtRl+qIbbI4c9XsSy
         9i1uN5Ki6CVUK+c0/bP243jXUnYaPMRdt3dPkpjcK+U8h9xDlU1ZOSA5OMvsCzPXnGk3
         dKQorn6YKGjmEiWPNn5FvN+86MH9b7tj75JYx1lYS6a6exhc5N7dS0jtDJVHP2tXq7Oc
         /DZiGbA7C7RYg2SLRx/M3ocOWha7Qkohu/X4GzAzorLcBWQUu/sIZy9NQX6QchBv36mp
         mjJA==
X-Forwarded-Encrypted: i=1; AJvYcCXLvMXYeZghZNWk6aAbSHcr+6ZzZhzrEXTXXA+0C8WBy/FBw94MrqHFkmYWD6A4sZByorevOXu0KcuJnxrcIlnrRqV/oPl7GKuMrYhi
X-Gm-Message-State: AOJu0YzqttcNyzGVvSOqjtEWWw8FhcRdBF/8IZaXo80y51/P/SkO7BFI
	1y4d8SG6KalF9gGP0bOsCollqU1MVZD56cmVN2IYTQ5Xoxs+quEPgfD6z/Iy3fLONR/+G0NfZn/
	qhvhqPWMrjxjg9BWVQROWLIz2bwBLqEk6DGAA0xqJQMW/o+2AEcc=
X-Google-Smtp-Source: AGHT+IEdbMaYMdJXUHdgYFhnzswKsMhA3rkp7GqkfyoGQ6ZLsIJWtTIWmSWiZNIqvRb19m0SRp5908+n7KUOJ7K8MJc=
X-Received: by 2002:a05:6102:d9:b0:470:6009:16cd with SMTP id
 u25-20020a05610200d900b00470600916cdmr950225vsp.33.1708678730895; Fri, 23 Feb
 2024 00:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222102513.16975-1-brgl@bgdev.pl> <20240222102513.16975-2-brgl@bgdev.pl>
In-Reply-To: <20240222102513.16975-2-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2024 09:58:40 +0100
Message-ID: <CAMRc=McAGdmMBH2cqUM0nhfWjDWRXCWqXqS9NjXLBDErfK-Ckw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: sim: use for_each_hwgpio()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Display debugfs information about all simulated GPIOs, not only the
> requested ones.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index c4106e37e6db..88fc3712811c 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -234,10 +234,10 @@ static void gpio_sim_dbg_show(struct seq_file *seq,=
 struct gpio_chip *gc)
>
>         guard(mutex)(&chip->lock);
>
> -       for_each_requested_gpio(gc, i, label)
> +       for_each_hwgpio(gc, i, label)
>                 seq_printf(seq, " gpio-%-3d (%s) %s,%s\n",
>                            gc->base + i,
> -                          label,
> +                          label ?: "<unused>",
>                            test_bit(i, chip->direction_map) ? "input" :
>                                 test_bit(i, chip->value_map) ? "output-hi=
gh" :
>                                                                "output-lo=
w",
> --
> 2.40.1
>

Patch applied.

Bart

