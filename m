Return-Path: <linux-kernel+bounces-137311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C2189E03E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557AF1C21D65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66513E05C;
	Tue,  9 Apr 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7SCVjTW"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E213E058
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679737; cv=none; b=HrtaXJwiYiOfYctBoLoAiMXxzROpHTm4+3FjFafB5ZXJt7eMHsf5P8KP2BsLrY2qz4q0ODchQ5RlfQuZg6cvd8c+sAXWBgVjN9UuskpY8AfPR8PJeorJ071/msNlkGyRLA3WBZNdB1DM3lbkgTqfgHaTLiY6X8Tg5Qz4dCt0Dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679737; c=relaxed/simple;
	bh=oFFzmkQFjem8Slp5pGsd7lw06I6XKAmgxLiAx7XwO9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omq9jjelIj5586mciaehsVpeQa5lvNMwrGuhrkhxw1kw9cQwGSmOcDkdIdi5QG39w3lDqGoZJnXi43yRL1OS6p+yI0MgSK/e/udhyPlLlh+4Ol83dBvfOE9BNgLnkYxdSoJnKbo9x3l8UoWbjeOZ6bNTA8ynP30W9iIqO7wvBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z7SCVjTW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa17c69cf7so2152492eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712679734; x=1713284534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESgWP/mXe1bk3eSSg55Zmh/raASjeDKKtmwp4/lqxgE=;
        b=Z7SCVjTWzGrLp5pMAf1WmKQdPO3YNr7lEywWo4dLGTELvYTyKBHINF8tPQvsZpOneQ
         dJmTZE5k6/o39v+fD0DzQt5fa8pFnQu3D81wfIC7vPxP37hKrexK8ifWm6irzOLM6yvB
         qAXnlsWPT3O4A2W26fuBW2YcZHv86di57MteE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679734; x=1713284534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESgWP/mXe1bk3eSSg55Zmh/raASjeDKKtmwp4/lqxgE=;
        b=unk+EAngF+ZESEUsi3aIncbaLoKuMEgJcd8ywd3jJGqf7/fF/qFu3ja2o/XBo4EfLO
         h6XJBIbiFBBdk7TTzWitO1wtY0RVeEckrR2Nw3IpUCMiFTSxcx9OC2t7onBSFRS8AKkx
         Q917tvXYjGxH7a2YJ8emxhBHYjI2OQrDgqG/K/oPdELYKveXBW9C9+L46QaHHZEmQH+5
         /JIgzxQO21qzT/KuuAgbQRbyzo8fJnuCI9Ss6RWFRRFB0YtP0h60N7lZ0L9uQ31FFbvB
         cVqU2DnXJaBKab5AITG1ZqCgy3lQAc7dhHqe9c6xWoLfBT8dfTRNHZvMztRxF7pOKh7K
         d3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUUV8zOkpgteuSJbbWMwcevAfaOFPTvB5ymMPGJOACUYqPl0Hb9q9QuF4m8celf5AqAZBmhqu1vMMcOjomZJcAGN8ZokxIL1twx5DVq
X-Gm-Message-State: AOJu0YzJkmRlBcBXzlLGEjEmPv/3AmeJQRmhp/JJ0axTMbOqw/X0of5Q
	4vfNksuXM/hOnwN8vukLHgbbHeYh89iYMX1vbVe5FSYhmotcD1TXEds/5Qg/pA==
X-Google-Smtp-Source: AGHT+IH+ThkTK2969Ez6Dj2+W99kQzkH7mmsmVKS7EpvhvBpgbL/Drf9WpykDBO7NmDp/3SLAhuS4w==
X-Received: by 2002:a05:6358:5bd4:b0:183:f636:8a46 with SMTP id i20-20020a0563585bd400b00183f6368a46mr350390rwf.27.1712679734649;
        Tue, 09 Apr 2024 09:22:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a63210b000000b005dcc8a3b26esm8129675pgh.16.2024.04.09.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:22:14 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:22:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: replace deprecated strncpy with strscpy_pad
Message-ID: <202404090921.A203626A@keescook>
References: <20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com>

On Fri, Apr 05, 2024 at 07:52:27PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> The current code has taken care of NUL-termination by memset()'ing
> @label. This is followed by a strncpy() to perform the string copy.
> 
> Instead, use strscpy_pad() to get both 1) NUL-termination and 2)
> NUL-padding which is needed as this is copied out to userspace.
> 
> Note that this patch uses the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Split from https://lore.kernel.org/all/20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com/
> with feedback from Christoph H.
> ---
>  fs/xfs/xfs_ioctl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index d0e2cec6210d..a1156a8b1e15 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1750,15 +1750,14 @@ xfs_ioc_getlabel(
>  	char			__user *user_label)
>  {
>  	struct xfs_sb		*sbp = &mp->m_sb;
> +	/* 1 larger than sb_fname, for a trailing NUL char */
>  	char			label[XFSLABEL_MAX + 1];
>  
>  	/* Paranoia */
>  	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
>  
> -	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
> -	memset(label, 0, sizeof(label));
>  	spin_lock(&mp->m_sb_lock);
> -	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
> +	strscpy_pad(label, sbp->sb_fname);

Is sbp->sb_fname itself NUL-terminated? This looks like another case of
needing the memtostr() helper?

-Kees

>  	spin_unlock(&mp->m_sb_lock);
>  
>  	if (copy_to_user(user_label, label, sizeof(label)))
> 
> ---
> base-commit: c85af715cac0a951eea97393378e84bb49384734
> change-id: 20240405-strncpy-xfs-split1-a2c408b934c6
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

