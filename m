Return-Path: <linux-kernel+bounces-81844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F086867ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83611F2B09F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F112CD86;
	Mon, 26 Feb 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MaNCkGVG"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20C129A64
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962722; cv=none; b=YI463F8DkzcuasqYtwlaXk/cS5eH7lL3JvC+fn/BFdFWF7VxfED4ptRsnIERtWkEPXbYlu0zxk2Di0/zsyksUQt2YQmqFCbjshVwK3mkGYysEbIdML4zDg9YyZpHIIVhRlATPTtiiTjK92IF3aU9HPWTCQjko9qXBC/o87TPdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962722; c=relaxed/simple;
	bh=4AsTNZ30+tE2qP7aKE3qwCaW72A6stH1s4P5QBsgrak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DamHcWO/STKHN8reaGB71/i/TxMBMQ0LUpqklVYt4p1/58zMsI/MGgYLobQrIn2DYYHvP3s0ITZQ/eS32dRPQB4b5Df8gmWIZ2CQuKDWu/TIMAmtNw3tbcEisrOHvqAIcN5kZTlHw//LQRzNvB8MJzjocRzm+N32//tyReiAAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=MaNCkGVG; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bc21303a35so1416708b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1708962720; x=1709567520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CUSSeKCNfrI8SENdwKZ8ZDRRQjwEDrUx9VFbPLeuRnM=;
        b=MaNCkGVGuliNvsHSgDdbxbILOwZfJaafmk7gn5cokZG+D2q+2eY/WeiZ7SrTlAkTwb
         sqRJ8jvk8kIV9qk4SKw9q6Mv/qUg3j+WWgEXPC8zubZrqIvYbSPM0uNMmnc5qiKx5+oE
         mgOjvmIoeznTX8eolEtCGVma7TeTeSdbsAA0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962720; x=1709567520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUSSeKCNfrI8SENdwKZ8ZDRRQjwEDrUx9VFbPLeuRnM=;
        b=OmyGZPhqPqtLkqYWp2HfQKEqeC40tWCmZFQ2WmpuZIlgDJ/0UU9V2x7CC/q6u5v5RV
         agWi/uoobIDLsG+jWUdAsFF55mnDfbUZaxZozPrgeIURTXHE/RGncNYSTdNSak5vqv14
         aUVb/vIWnBvcZ9pExClHftycZqF9RYA0WVYHFgca2M8FNEdVd6XjP8Ze7qLKKvUnTNNc
         D1yEZKxHqnV7laCyZcH4cbP0o0DEtUkl4imKoa0bYCyKPNoJHsKRCQnKcQpajHG9p5lH
         lO9+Vl6SGhAPHTo4icldqMMiGWraGn1rYMbgyjsFukDGcxU172z2r4qUoSVHM2uZiODP
         yexQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZaxxvioBCsWsiCJu69T/5KJw3O5okEb/vZKR4A4fo+TDOiVv6iy5FK2cLEKcgojpFPwsFQoPj0eojrGFiPwxIZ74vPAaT1AOhbjQN
X-Gm-Message-State: AOJu0YxZhiEvdHeIb/p+aNpGN4JPQfL6t/Bu/oueOeLrNtLsHWvsUyBV
	k4UEFIiN+UnToy7Gkw0yLE4jj3UQt3rD87aUOT29P2D5gN4jgBCPAsZhOW1ZaOP3BEIQ29vlO1d
	JY6ejkWEL3UF9G5/y1uLvT0ogdD2oHIfW4QJCOg==
X-Google-Smtp-Source: AGHT+IEdiQ4U3Em4o9sDuL5RsHg1cNC4nB6yTF5zoOIg2giWwAyj6LuCUE3soBJh3R3CnQ3rPqB5bTGOiWA/ta2lfdE=
X-Received: by 2002:a05:6871:3427:b0:21e:be91:ae48 with SMTP id
 nh39-20020a056871342700b0021ebe91ae48mr8491032oac.1.1708962720214; Mon, 26
 Feb 2024 07:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208114411.14604-1-jirislaby@kernel.org>
In-Reply-To: <20240208114411.14604-1-jirislaby@kernel.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 26 Feb 2024 16:51:49 +0100
Message-ID: <CAKMK7uH-22rmncSn0iP2qdeUNEsmOQgG5xHcOPTLwnwqANtvYQ@mail.gmail.com>
Subject: Re: [PATCH] fbcon: always restore the old font data in fbcon_do_set_font()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ubisectech Sirius <bugreport@ubisectech.com>, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> Commit a5a923038d70 (fbdev: fbcon: Properly revert changes when
> vc_resize() failed) started restoring old font data upon failure (of
> vc_resize()). But it performs so only for user fonts. It means that the
> "system"/internal fonts are not restored at all. So in result, the very
> first call to fbcon_do_set_font() performs no restore at all upon
> failing vc_resize().
>
> This can be reproduced by Syzkaller to crash the system on the next
> invocation of font_get(). It's rather hard to hit the allocation failure
> in vc_resize() on the first font_set(), but not impossible. Esp. if
> fault injection is used to aid the execution/failure. It was
> demonstrated by Sirius:
>   BUG: unable to handle page fault for address: fffffffffffffff8
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD cb7b067 P4D cb7b067 PUD cb7d067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 1 PID: 8007 Comm: poc Not tainted 6.7.0-g9d1694dc91ce #20
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   RIP: 0010:fbcon_get_font+0x229/0x800 drivers/video/fbdev/core/fbcon.c:2286
>   Call Trace:
>    <TASK>
>    con_font_get drivers/tty/vt/vt.c:4558 [inline]
>    con_font_op+0x1fc/0xf20 drivers/tty/vt/vt.c:4673
>    vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
>    vt_ioctl+0x632/0x2ec0 drivers/tty/vt/vt_ioctl.c:752
>    tty_ioctl+0x6f8/0x1570 drivers/tty/tty_io.c:2803
>    vfs_ioctl fs/ioctl.c:51 [inline]
>   ...
>
> So restore the font data in any case, not only for user fonts. Note the
> later 'if' is now protected by 'old_userfont' and not 'old_data' as the
> latter is always set now. (And it is supposed to be non-NULL. Otherwise
> we would see the bug above again.)
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
> Cc: Ubisectech Sirius <bugreport@ubisectech.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Reviewing patches to code where assignments in if conditions are still
cool is a pain :-/

Merged to drm-misc-fixes with reported/tested-by credit tag for sirius added.

Thanks a lot!
-Sima

> ---
>  drivers/video/fbdev/core/fbcon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 17a9fc80b4e4..98d0e2dbcd2f 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2395,11 +2395,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>         struct fbcon_ops *ops = info->fbcon_par;
>         struct fbcon_display *p = &fb_display[vc->vc_num];
>         int resize, ret, old_userfont, old_width, old_height, old_charcount;
> -       char *old_data = NULL;
> +       u8 *old_data = vc->vc_font.data;
>
>         resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
> -       if (p->userfont)
> -               old_data = vc->vc_font.data;
>         vc->vc_font.data = (void *)(p->fontdata = data);
>         old_userfont = p->userfont;
>         if ((p->userfont = userfont))
> @@ -2433,13 +2431,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>                 update_screen(vc);
>         }
>
> -       if (old_data && (--REFCOUNT(old_data) == 0))
> +       if (old_userfont && (--REFCOUNT(old_data) == 0))
>                 kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
>         return 0;
>
>  err_out:
>         p->fontdata = old_data;
> -       vc->vc_font.data = (void *)old_data;
> +       vc->vc_font.data = old_data;
>
>         if (userfont) {
>                 p->userfont = old_userfont;
> --
> 2.43.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

