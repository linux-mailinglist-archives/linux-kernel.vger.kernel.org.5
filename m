Return-Path: <linux-kernel+bounces-124104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1A891244
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B711C23642
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270BF3A1A1;
	Fri, 29 Mar 2024 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARKkytZx"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0363B293
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685093; cv=none; b=KuJIb2PdOKHd9QY4Rvoe5cK8CoBkIMEk5OLDW75hZAS76LORxoUOXGy86kueshrasjGxTtZUfO7ViMmLrTN12Mnz4jufzWb4smKJj9yfC1EjLHnW46dXVLVatFRiW9OLHUilC4gDmoZCRc5GMUuD82NhD4uyjcryX/s0zvZ6Z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685093; c=relaxed/simple;
	bh=fx75aDeb//DCFTHJW3dMQvi5gnKmJfUkKWLKThTPR94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orJcPK0vyAECBXa+lBuSZqXBQqJwpfwUC/RX5R8d2Tg6ltGQkTUHOxFfEcEdQSvTjz9H4GZ0ElbfcPT8e8qqMtGL4AUHhK4xpuCXBXH9h338bjyWGSEvhS8HeuXXAXpRu3j87aCttE0ZyWF7XK7YuwrSsY6pbaBkYL4YJnB9XRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ARKkytZx; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2220a3b3871so599452fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711685091; x=1712289891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69VUW1JBrC64hXBRbspWF21+J8tNtsC9yt2uIqIg1HQ=;
        b=ARKkytZx7biCoF4FdX911rnJCexBt0iG+IlY+ojHC5xM8lHiSpUIq2CG8gJaeSlMWT
         nsPMe9VyQDwpIYZliclOQHQOr8os5bQJU+hkKiu5pDe0HCp7R83QzE1+NtEO/eFNqPUG
         JPNX8VuAh1HeKMTvaQyumwnHeGervw7jYlD3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685091; x=1712289891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69VUW1JBrC64hXBRbspWF21+J8tNtsC9yt2uIqIg1HQ=;
        b=tMUjwftHfbhxqmgFLQf8lkryRh5kfsR4QfcrqlnUhCLmgx+Pz2n5pDSFc79abBcAQk
         hBJJxtyO85T6QXXYFvrCdiBfsFxubFhLxIu6jCFkA81VIn0Gw+HHWBZI09pwak6ld1u+
         t20A7QVKfrWKbl18SD1DMuSHrHe4+40UEOIOZXRYj5MZf++SrfIWILaScLI7GOQlClzc
         qZ+6jNUetAhcN2XpiJZGufvMeLqLi+LhRGy6sQYHfmtbsAyJ9vQrlzIiOurCKzElfDK7
         tqVWgMhE+83kS+d7kLOYShBnmkc60HihkvGabmhXcb7Lj3RRNjCTj001h66xO0ofz+jg
         tKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4m5VKt44jxDhQhxNWxJU464K8A/3MNm6dwedVh0TrJ3qHBQNItPLs5G18Yz5ZRcUDry4o3TSwQDdRBkbmP8Sw+FLOwyxslSvUFXZM
X-Gm-Message-State: AOJu0Ywe0uBJISSHfe3U9dUH7T9IPYyVoxzOPAfGGfhZJkNGebOEglgz
	AenrpXSbqejJKrEddW450b88sXSzfS4uCqviQ5xpATRJqawUDOp3k6uO77/CFelqgoE1r9yE8Vg
	=
X-Google-Smtp-Source: AGHT+IFvNh8aPME+bk9MigIg8cgiL4SPF+c4/TssLm62fUGeJU6j/Ecq0WtTIJm48S6HEzmuuKfGsA==
X-Received: by 2002:a05:6870:c34f:b0:229:c1d4:83bf with SMTP id e15-20020a056870c34f00b00229c1d483bfmr1130237oak.8.1711685091224;
        Thu, 28 Mar 2024 21:04:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7982e000000b006e73508485bsm2159777pfl.100.2024.03.28.21.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:04:50 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:04:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video/hdmi: prefer length specifier in format over
 string copying
Message-ID: <202403282104.CC17451@keescook>
References: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-strncpy-drivers-video-hdmi-c-v1-1-f9a08168cdaf@google.com>

On Wed, Mar 20, 2024 at 11:22:02PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> It looks like the main use of strncpy() here is to limit the amount of
> bytes printed from hdmi_log() by using a tmp buffer and limiting the
> number of bytes copied. Really, we should use the %.<len>s format
> qualifier to achieve this.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

