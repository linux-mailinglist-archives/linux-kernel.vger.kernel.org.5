Return-Path: <linux-kernel+bounces-75841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5085EFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA111C21281
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9111642F;
	Thu, 22 Feb 2024 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHxwYSsW"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CF196
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571887; cv=none; b=aQXs6c/5mjXqmJcnGozpMHEZJf22mPs8Ts/1QYkAXVvZzCiFkpxuLGwG9bcUb5qSnnGd4jIc5+Mmmb8Mc6+GlrmHEqfY8JdFQLyykbE/FL3f5TENF+/uNGS19Uey54KDE68HhN2T27QoX1Go9T/+v9CuaISUvnahP96O+O8fwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571887; c=relaxed/simple;
	bh=ut2MQZOrqW8b0JO5evMbU/RELMHsuGLLv4B+MctT77A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkzIoElZTYmZdNvdMFmn5fl0uUwuc1SWYWyD6T4ksNI3L+ifQvlASjhxpFUSmENR1VW0eGu5UPF8EDm9qXsCELqxHa3OOZkmhRTbgpGvsuxCeNR8oAnalCPEdsSpFTgtIPdpQ6d6U9ka1GBnkwIvjLVYcLp7nzBkbzPnCV/KC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHxwYSsW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6bcc78so5354240b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708571885; x=1709176685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOJkSuhWivZJymWAMGzD3PY6qOFwlgiao1u3KjRQcJ4=;
        b=nHxwYSsWjsmmrhO+rvpZykPpCW+B/u5OqRRJE8QfY7A5aAWfWFU735wIRnUcc6xhHm
         gAYFKn7L+beebHhAy0y36kde7Lh6ZvO3FumzKNj39o2IOGXXNfCwl35Q4dCgYI1zv45l
         za740SeEKeQQuWvm+2zm38UM3mhcrOsoRpXu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571885; x=1709176685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOJkSuhWivZJymWAMGzD3PY6qOFwlgiao1u3KjRQcJ4=;
        b=ncyx+mol+Y67kwL8lYLeSOs0Rc2VRpfLVcYKq4pBP22rhUzTTTxC+Q4oEZssnpyTDq
         WO9H3x6PI/NHyoHLkdXg2yI8MEGMeqWQ96T7jIPe0nWdIEELeYducm7ua4K/m8MZqzAl
         0EcQgyA/kTTUIP+Pd8sZL2d7mUxjr012rFv0xMAv4914oBKu5+cxCK4bQljMmr4VQLAz
         bIr+M0ufyzxfn1Q8JYIfAkuTP3JZPyyS4svf/qC+pTML85tKd44lgpGHPT9yWBpDu2ey
         VNxjeKIqOMlTFCAH513g2IbPSXn8t7Z8pbhsxNkKlzaalt9od7l+1OA0Oh9XtTuGAppB
         R8+A==
X-Forwarded-Encrypted: i=1; AJvYcCWFUWwkzFgeYICvxI+kcSsAI6nfaslGujVEk0Tnggx2iboRNRl9xvD2W7dlmxu3xhzO6jW8zLAUUai0fApWywgR6VZlTViqAeNRn7Lc
X-Gm-Message-State: AOJu0YwPdwO3hx1Z72TGoRRSeWoPK6Jzn0U6wmSxcj9ebFbURrhWHlAK
	G8IrLKYr3Mfll3OFvYQfwbW0RH3o6CupCI4leyVe3NE5Fh0IbcmINLVSzr9+OA==
X-Google-Smtp-Source: AGHT+IGTMpsL/5XtthAE7430SoPB33wlJCVuiERPjUrN4eGkK2pC/FKYBLUB64cCqoQX26AfYHp6nw==
X-Received: by 2002:a05:6808:e85:b0:3c0:33b5:d1b0 with SMTP id k5-20020a0568080e8500b003c033b5d1b0mr22625106oil.10.1708571884942;
        Wed, 21 Feb 2024 19:18:04 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:480:9ded:eece:6cb3])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b006e146124ae7sm9696211pfn.186.2024.02.21.19.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:18:04 -0800 (PST)
Date: Thu, 22 Feb 2024 12:18:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: add some Kconfig env variables to make help
Message-ID: <20240222031801.GG11472@google.com>
References: <20240222031226.493692-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222031226.493692-1-senozhatsky@chromium.org>

On (24/02/22 12:12), Sergey Senozhatsky wrote:
> Add a new section "Configuration environment variables" to
> `make help` output in order to make it easier for people to
> discover KCONFIG_WERRROR, etc.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  scripts/kconfig/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index ea1bf3b3dbde..109e28fd6209 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -158,6 +158,10 @@ help:
>  		if help=$$(grep -m1 '^# Help: ' $(f)); then \
>  			printf '  %-25s - %s\n' '$(notdir $(f))' "$${help#*: }"; \
>  		fi;)
> +	@echo  ''
> +	@echo  'Configuration environment variables:'
> +	@echo  '  KCONFIG_WERROR                 - Turn some Kconfig warnings into error conditions'
> +	@echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfing warn about all unrecognized config symbols'

													^^ Kconfig   fat fingers

>  
>  # ===========================================================================
>  # object files used by all kconfig flavours
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

