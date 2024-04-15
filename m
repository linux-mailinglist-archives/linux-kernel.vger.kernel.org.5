Return-Path: <linux-kernel+bounces-145532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132AB8A5774
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEEC1C22DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4167824B3;
	Mon, 15 Apr 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvAduJRY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE883CA3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197762; cv=none; b=NyI3hHPaug1Gw0f9KHCsysBAwcAUqVWD7F1/isZaVIP8WLmDNqcPW9+fbnKqLKrG9NxWI2s5/PxerffzopeSiRBibLs5vIZQOGXvRCi04WvahFLG2KFP4mvKBhsUtU7OefD3Yls+G5ftKCNtAElDyfFuHVYJkIJcx9JpNbWONqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197762; c=relaxed/simple;
	bh=FpomtvzrUGqRcfkT9HroMgk+hHbU5BpIvAwjwjQwBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZKcfQKzV8t3JdvXcr63+LGIX2rZbYPytQEgW8zIwTGRY7+34aYFXhv+eDj7NlCLNX/Y0hvkb6V/puBZD3c/6g0Z6F+X83OXP8OivPkz8xEdcaGCtDko/zdXW6t3VnAqLDD1anukLnurlaWgo8rZ8SpukJrZlE7t9DEJE3gxopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nvAduJRY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f00f24f761so604773b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713197751; x=1713802551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxv6+5Ux2yTI1FE4TVPvIu4J5fO2aZv6AEiUOC/zMkg=;
        b=nvAduJRYogn99/bDXBlB0HTNpenyZk0GyOuWAjaykx67sfB8YFUujFYjSKtvrOhh+B
         qG/5zcAMRmEax0JWGUWh8TOMw1gM6iBjed1dZte8Befwjc1jhDlWc3Bcw/xafPrPmfQP
         0SHnZia6wbMRyBFjIZpjk221eBa6uUxhEPMdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197751; x=1713802551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxv6+5Ux2yTI1FE4TVPvIu4J5fO2aZv6AEiUOC/zMkg=;
        b=wdpW/LlpxG2s572Npi/tVn8bl8QmZTsTKlILVuYcVCsGIF3uyTmTP+RJjjq6gj1rky
         OPC74vhzFsdUiMs45tggHqHZl7wESo5tjD14Lr4i644BNQASXRlHYpBBnE6ibBG2Q65N
         IgYzd+NiagYrbxBp8cD1QelsEwi+2BzD/CNqb300VSSReCbBJDiWnK1eXK4t7EtzzVcN
         zYvKUithPDbO2vzlmxL8G/rC3LDQE+MR+h3LKEYGYfHhoGOHvV0i0gwElfKNXz4CffXS
         OaB9woDctHKAQmbv6bk+5lB4lwatn+cSEbqJOTkfpx4FHF2w51jOJk79u5k4DDECKuAP
         7LnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1VdFeVRIExewarUOyXu7iTI70XfX3uI1fDOuYESU9U9k47uM4Ce2WiIn24iYa8lv0t7L+8nh96+m8H60GQ8khX7kPg0wx6nhqi+Iz
X-Gm-Message-State: AOJu0Yx2m8moDlYwpPUdevqmJwHGuMrraKDOJanvq6aWnB/b38EZsh16
	daNG+USgbLMpiLrNCV44BGTp+YOybqvCV8IswZt0KHYCwZ7bKP/tnK/+mJIbqA==
X-Google-Smtp-Source: AGHT+IG4IR67yyuHStapORNuulY4crr6d/N1FjMFOe9RUErHsYbs5cWd6dPjndtXS3Umi/usTWq4oQ==
X-Received: by 2002:a05:6a00:4b51:b0:6e6:89ad:1233 with SMTP id kr17-20020a056a004b5100b006e689ad1233mr10566964pfb.2.1713197751331;
        Mon, 15 Apr 2024 09:15:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gs23-20020a056a004d9700b006ed4f616ec4sm7394323pfb.57.2024.04.15.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:15:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:15:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] [v3] kbuild: enable -Wcast-function-type-strict
 unconditionally
Message-ID: <202404150915.75918C8B3A@keescook>
References: <20240415122037.1983124-1-arnd@kernel.org>
 <20240415122037.1983124-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415122037.1983124-6-arnd@kernel.org>

On Mon, Apr 15, 2024 at 02:20:36PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All known function cast warnings are now addressed, so the warning can
> be enabled globally to catch new ones more quickly.

Also yay! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 202e26e6f29f..1d13cecc7cc7 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -129,7 +129,6 @@ endif
>  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
>  KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
>  KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
> -KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
>  KBUILD_CFLAGS += -Wno-enum-compare-conditional
>  KBUILD_CFLAGS += -Wno-enum-enum-conversion
>  endif
> -- 
> 2.39.2
> 

-- 
Kees Cook

