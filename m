Return-Path: <linux-kernel+bounces-84124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61786A265
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5600328616F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565411534F4;
	Tue, 27 Feb 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TxbEAeAx"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0914E2C6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072736; cv=none; b=qu/gVgJD4FWg/3tF1xF3IT7P8smLxZ1lh1fwqjKcX/c7/naxE6Z3bu5n33FCz9eqoFvq1jsWIRIjVEU1/7ustYRH1BAH6ch7TmjdjJ5c6MKTjcbVHTqx8jI+DNza+TykYYWtt+ZoLZwPTp5OdrhWpe5gogZ2Xzj3A/ynBjdCDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072736; c=relaxed/simple;
	bh=BZY4406wVhBlJfwB6Ze/m6sBQx4rV1wHkhecYYyQdRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1quMnmALqd2f1C5FWHVNYkM2pJCyzOYJ5ZbWLpmGjiIhwFvCDDg4T/EB9Yy+nMtLvCeejTgL/3naIhG2BTlpL2gl7wbn2U8fXce2tU6l1ixZxXPXi778G7PqoASPNA31j5sAFGlqROrB41oOI4g9YukX5s8PVKZpFqdBpRBeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TxbEAeAx; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-365138d9635so17095635ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709072734; x=1709677534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdXNDkfHTZPTT3aVBNl95bQTluN5p5khhWSdLMgwQYE=;
        b=TxbEAeAxERK/L1HcKf2Lev7ex+mNVmId4B52vgrvuG8XFSpLPIqEfhJAy1vv7YhaC5
         G9j6y4DdmSkf7nSfGQl4dB/RbkMZyV9KxNWME2CC+MmzKMnkItxXCxeIBzgr5zT9aVWS
         nuHMzty1HbBO58+6lluKiq99K/AAW43J4TfRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072734; x=1709677534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdXNDkfHTZPTT3aVBNl95bQTluN5p5khhWSdLMgwQYE=;
        b=OmlHzP1ORDmXmXeM2yoqrFXLpI2M83VbethUrhACZXI2FX5k5PaCBAqqrkOqEe1xtg
         Y1NojYc4zsLTV6yBR2ZcKlcTDF+wVVUFm7hdZCkast3asohPzyFa/p80f8TTHYcjyftw
         9jd1QQfFz18VzSMBDcuXkTMv0F0NmESGoDqprpxzdhKEx5vXfdgbhdEZnW6Ml+ZVqHJy
         Sjm3gnT/ohjcshkZZRP9mucBmtSUoF+bhn3ASMggf5sYBdxeBn39ORIKWAvNi31CzrrZ
         h4vP+df2sK1kXWqP9aFWYqw47Li9phJNtOi2wcJZ3huvxsLnSxa9hB2SvaEItFtKsLB2
         asoA==
X-Forwarded-Encrypted: i=1; AJvYcCXjpLKWEgw1uF2RWUsQmRPs6nB0nHdkDw6b5iubCkhOhFKpXzuMi2LxxvYRLrRsyhjBQNIbTRcpcN8yU27+XQrWIOqtmBrs0jp0ZZOv
X-Gm-Message-State: AOJu0Yzczxlfb9hXkjrEsvqKBbPOsRN2fXUmNIraOaBDOPoR4uJJy/Rd
	66WdIX4beZ9m12QRjc9VDXsO8VovpdG0i0pJjet31OxDzxlQuCA7gkNZSZeTRzLsGXpu8gXyX4M
	=
X-Google-Smtp-Source: AGHT+IGYBuwXLHIC8vZCmts7zTsMpo7UiyuHbbLT+oFTxhaG3QafWqmUk98iK4Wky6XsIPvMdRF6fA==
X-Received: by 2002:a92:c606:0:b0:365:101e:b47d with SMTP id p6-20020a92c606000000b00365101eb47dmr11694652ilm.0.1709072734378;
        Tue, 27 Feb 2024 14:25:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b006e4432027d1sm6586909pff.142.2024.02.27.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:25:33 -0800 (PST)
Date: Tue, 27 Feb 2024 14:25:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: stackinit unit test failures on m68k
Message-ID: <202402271423.270DBF1@keescook>
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
 <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
 <202402271401.CB43AB2E8@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402271401.CB43AB2E8@keescook>

On Tue, Feb 27, 2024 at 02:19:07PM -0800, Kees Cook wrote:
> It is basically doing this:
> 
> static void *fill_start, *target_start;
> static size_t fill_size, target_size;
> 
> static noinline int leaf_char_array_none(unsigned long sp, bool fill,
>                                   unsigned char *arg)
> {
>         char buf[32];
>         unsigned char var[16];
> 
>         target_start = &var;
>         target_size = sizeof(var);
>         /*
>          * Keep this buffer around to make sure we've got a
>          * stack frame of SOME kind...
>          */
>         memset(buf, (char)(sp & 0xff), sizeof(buf));
>         /* Fill variable with 0xFF. */
>         if (fill) {
>                 fill_start = &var;
>                 fill_size = sizeof(var);
>                 memset(fill_start,
>                        (char)((sp & 0xff) | forced_mask),
>                        fill_size);
>         }
> 
>         /* Silence "never initialized" warnings. */
> 	do_nothing_char_array(var);
> 
>         /* Exfiltrate "var". */
>         memcpy(check_buf, target_start, target_size);
> 
>         return (int)buf[0] | (int)buf[sizeof(buf) - 1];
> }
> 
> and it's called as:
> 
> 
>         ignored = leaf_char_array_none((unsigned long)&ignored, 1, zero);
> 	...
>         ignored = leaf_char_array_none((unsigned long)&ignored, 0, zero);
> 
> The first call remembers where "var" is in the stack frame via the
> fill_start assignment, and the second call records where "var" is via
> the target_start assignment.
> 
> The complaint is that it _changes_ between the two calls. ... Oh, I
> think I see what's happened. Between the two calls, the stack grows (and
> is for some reason not reclaimed) due to the KUNIT checks between the two
> leaf calls. Yes, moving that fixes it.
> 
> I'll send a patch!

Oh, no, that wasn't it. Something else is happening. The stack pointer
isn't moving between them. Is there anything special about character
arrays on m68k?

-- 
Kees Cook

