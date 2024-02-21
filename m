Return-Path: <linux-kernel+bounces-75606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A20585EBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF3B1C21A86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2E3BB32;
	Wed, 21 Feb 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SutVXk+y"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E21EC5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554797; cv=none; b=W3xYAUAyuKKyhaDMga6FU+tK4kh11zhPk3Fkj19OBseA5wuKkz5TWkKH1cdP0t75+ZYhTgl2g3sWVUSv3ZZKec63Fl0oYEKe7JV18jFgUd5O5OMsNDLiw6qC8FScDvKoDhwhNHZj/7QcH89cPGdwNXq64Y7gLusDdlY4hItLJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554797; c=relaxed/simple;
	bh=Xksbw/fPgtZJZr4Z75gW4JnJVMYPTegEonMjLBUOwi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5FcZoxywqIB+0RZHgyoEncHmTQE6s3aLEIo2433uucWrIrxXZjHkn4vrLhtSLXyr+iex6E2ePQ9svwzxvIMtNYN9ySoh1Uw8H1Jf0ki9cOzwfDMCwMXS0xz6ynP9LV1sb7rZBqLsFcVxA/IaCM5LqmQBH36fPAnfMLxMt5xpVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SutVXk+y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e486abf3a5so1313088b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708554795; x=1709159595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8D4TwkUHWL87aIgkSxQbSQsWy72efvaVD39LFXB9vZI=;
        b=SutVXk+y7hXW6I7oRf/QaVsQDgJW0P8DmH00VeY25q8D9gGD/hy2LL+hibx1dfcfty
         J54/pUt0Wv28EKFO2hp54nQ9XBfAOuE6zkbZWMzhnFkkeqX1xprYQ6K2PQLCShqn0MME
         76tsO29PD/Zht7kNKISKUjJUObnMFiNj9yO9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708554795; x=1709159595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D4TwkUHWL87aIgkSxQbSQsWy72efvaVD39LFXB9vZI=;
        b=grOmVRMGXxXOn6OzuXYuKrptzxHdhLt1YcWiizWMcQn7ivejO2XAWFbiDrSxIp0sjY
         apWcManNaWURFFYsQWR01Xk6tnIRZ4SXVqYGtkDBvIXADERWIdP8VuTxZsqO9CY0yhfe
         1sdR1UxqmRGSTKZbMTYScbLIEYck5Gm8LMih7cYtCvQLwDrawX0SMM59+JXFEdwZGhtw
         ArnDZUZwrd8OYJxhboMLfSG0iOvUPmshDcaGQfMEvMpgf/DRjdTAx4RUmtXE1qSR8iAZ
         Nd1wHnqGySci3vCHcD8NJ/IGkXYpa/5GnkWo/RMDmdhol1elXdw1l7akHedHy6GiVM0J
         mLqg==
X-Forwarded-Encrypted: i=1; AJvYcCUva13iG4Q63ZZP+R+URubbCf5CGFwJ9z00bUZnqpUzhALDv6pQQm/Uh28s2GLbdndK/93XuonfUwdJBnrKklrVZ9p/iuev+5IWhe/E
X-Gm-Message-State: AOJu0Yx+YU88sy4TwQBJTXh7JF27tTJS1zZUFE98RpURe4hi9HiKAWf1
	AawcPIrt8kgSzPLwEVoUHapAGVM3SR3ppQCY1ruQYjkVsNMCnN1QlFqFUxOGVA==
X-Google-Smtp-Source: AGHT+IGxH3t1NIUMclMdQfiukj3+5jelxBYiMBxtwm8oiHBzGyTUma2DUE2FxmbcqEfEecfLuyL0pw==
X-Received: by 2002:aa7:84d9:0:b0:6e3:1fde:cb72 with SMTP id x25-20020aa784d9000000b006e31fdecb72mr10809283pfn.23.1708554794902;
        Wed, 21 Feb 2024 14:33:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn15-20020a056a002fcf00b006e324e33ab8sm8949514pfb.218.2024.02.21.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:33:14 -0800 (PST)
Date: Wed, 21 Feb 2024 14:33:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] checkpatch: add check for snprintf to scnprintf
Message-ID: <202402211433.BCFF1FFD8@keescook>
References: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>

On Wed, Feb 21, 2024 at 10:11:59PM +0000, Justin Stitt wrote:
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yes please! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
> ---
> From a discussion here [1].
> 
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..64025a6e6155 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>  		}
>  
> +# snprintf uses that should likely be {v}scnprintf
> +		if ($line =~ /\bsnprintf\s*\(\s*/) {
> +				WARN("SNPRINTF",
> +				     "Prefer scnprintf over snprintf\n" . $herecurr);
> +		}
> +
>  # ethtool_sprintf uses that should likely be ethtool_puts
>  		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
>  			if (WARN("PREFER_ETHTOOL_PUTS",
> 
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240221-snprintf-checkpatch-a864ed67ebd0
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook

