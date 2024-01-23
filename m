Return-Path: <linux-kernel+bounces-35374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED896838FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83161C23C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72867E69;
	Tue, 23 Jan 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGu8sojm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2667E66
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015534; cv=none; b=HBWJzGs8r/uzclx2WlkMDoesOSew/17p/d4ab/frmSd9MIerKiT9MhIhunPvRhVy3XH9ccJRM+06nElc/raEyjXWnomrIszrgNu5YxIh9Kf4/ZNDYmJDSUbzVQ9Z33T0SpA2ZHTdsf1+OYn24C9jIOsqI3l2WqX/xsQXbZXrqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015534; c=relaxed/simple;
	bh=ueru+mw1cE0XRlZEGPUaiKo7r27Ceou9vCB7MrFSjAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEhI08ZzmVJBLEekmAIMltSpgjmjD0o7vY+BlhLVXa+HhHlHVT2Z1r5tzFeE8/jLkvtRRL6h5sMjXRusxoiCoMqLB+DwBd78c5s5L8+3bTqrkD1MSA0nRx10sG1So9VOKU8JYvYPrtCirEeSJs8mEqcHuoEQk7ViTbEE+J3HL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGu8sojm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D932C43390
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015533;
	bh=ueru+mw1cE0XRlZEGPUaiKo7r27Ceou9vCB7MrFSjAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gGu8sojmykuWlHHtnhyPY+0ZtEO+PukTGSgIo6Dz3zo9o2W6lzcCxz/tJArjxiLqk
	 w8CGzYTNVmRd0v45K0Pn1bx4rSk5w3Xmw1+TVlWlDX57f5o7dpeCPAr8CnUCKGB9i+
	 6w90I3r/AQp/G3hdWsQ6tN72nvOy5PRItQ8Oo/purfPQ5Ktuz5Zi7lts+g0sgjBQ0e
	 EYhWgFp5iMmd5PxMknCsTDOd/fsXhw/nB8oAbZElYi5ZpG6ZSfEk5gcdrU9omBbguB
	 kwC0JO+2s8cqjvqgKkGZHf5gNp2xXKHCKpIC7hhXE76vt8x37o0CcOjZyrpeqzO2WJ
	 eRSCE5r4CtCSw==
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so48041655e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:12:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yw1jdyiDHF0zV1lh/GsWHrkuiVwCQb6cMHf4nkd0V3VQ8PPNp8V
	jg+s42g9d2Qo9WC4io/iblhtue+R0z8/AnIyPZoHh9CoxmJbCY540NxOh8gA86XkK0/8tMdANR7
	IAT7aU/4mZFgSPjICWQ/jwL8cRoY=
X-Google-Smtp-Source: AGHT+IEqHaafUVaYlL/dBnjdbyP0fljln5ORzbWGDdirMJ4HGsgSzWIh9KlIGx7RsG6VnsKDDs8KO4xQIApwjVc5wqo=
X-Received: by 2002:a05:600c:538e:b0:40e:6d7a:f9dd with SMTP id
 hg14-20020a05600c538e00b0040e6d7af9ddmr138840wmb.47.1706015532072; Tue, 23
 Jan 2024 05:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123120937.27736-1-tzimmermann@suse.de>
In-Reply-To: <20240123120937.27736-1-tzimmermann@suse.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 23 Jan 2024 21:12:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6z1mNqbyq-0ZhgkVgWXf-WK+XAxG8hTREhaM_R3J+s3g@mail.gmail.com>
Message-ID: <CAAhV-H6z1mNqbyq-0ZhgkVgWXf-WK+XAxG8hTREhaM_R3J+s3g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drivers/firmware: Move sysfb_init() from
 device_initcall to subsys_initcall_sync"
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jaak Ristioja <jaak@ristioja.ee>, 
	Huacai Chen <chenhuacai@loongson.cn>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm very sorry to hear that, If Jaak can respond, I think I can find
the root cause and fix that...

Huacai

On Tue, Jan 23, 2024 at 8:09=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
de> wrote:
>
> This reverts commit 60aebc9559492cea6a9625f514a8041717e3a2e4.
>
> Commit 60aebc9559492cea ("drivers/firmware: Move sysfb_init() from
> device_initcall to subsys_initcall_sync") messes up initialization order
> of the graphics drivers and leads to blank displays on some systems. So
> revert the commit.
>
> To make the display drivers fully independent from initialization
> order requires to track framebuffer memory by device and independently
> from the loaded drivers. The kernel currently lacks the infrastructure
> to do so.
>
> Reported-by: Jaak Ristioja <jaak@ristioja.ee>
> Closes: https://lore.kernel.org/dri-devel/ZUnNi3q3yB3zZfTl@P70.localdomai=
n/T/#t
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Closes: https://lore.kernel.org/dri-devel/20231108024613.2898921-1-chenhu=
acai@loongson.cn/
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10133
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---
>  drivers/firmware/sysfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 82fcfd29bc4d2..3c197db42c9d9 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -128,4 +128,4 @@ static __init int sysfb_init(void)
>  }
>
>  /* must execute after PCI subsystem for EFI quirks */
> -subsys_initcall_sync(sysfb_init);
> +device_initcall(sysfb_init);
> --
> 2.43.0
>

