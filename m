Return-Path: <linux-kernel+bounces-108390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EF8809E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B446B1C22D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C8182D2;
	Wed, 20 Mar 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S7sB6OwL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36F4AEDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902650; cv=none; b=VB376mKFqTloU147xCKpIZtGEsc57rpKXk6UYGF7rRDd90r+ExdDo1BqHesF3T8TV4aBa+qBycUExnkeqeAN0ikdRjx0hw0yaAoLtJOwizE0UQAAM3zATzmIhfs6MVqHzRBMPXgXRcmH8RB4+qCP2krm6EW9Z7rrhInWC5PUGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902650; c=relaxed/simple;
	bh=PfIOWQapDLAw+W44Ln09xHd20/IykxP4ixCfdV5vP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx5/nNmeeSe/A7RXLEUlljRzumcafJfwPMbHAlOBNrCUzy7kw7Bjjcly9iBCKVlbdtrmHmpxOULfRfY1WNJokpJqE88WQmLyWe2Eh/KbkczrX0T1L+NE0lPGzu1QZVU7zs1WJs6ay8TvfNVZTsHDUmwnt6TtAj7RSE5S6bka8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S7sB6OwL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so5786098b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902648; x=1711507448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfIBZvZR+X0639t+/0R7E3839UBAFzDwhD9FbKyVE5k=;
        b=S7sB6OwLK6P0pkurhfOGXCzFnM5ucGpaw+lrFgbTEk9kQexlgcNJATYaIJX0IJ12cr
         ACv6H81BiGUdn6B/4XPrEhf92KtL1zma4jAwnWc8RuPZuljuZxio3QPELQfmrN8YhunT
         CoQNd3vRTYjg9BcqSTJ053MjW2itNE0dnsy9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902648; x=1711507448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfIBZvZR+X0639t+/0R7E3839UBAFzDwhD9FbKyVE5k=;
        b=NRz6/nFscjcuV/TVVowplnS48blqpr6YhuE33JyU1OPRSTbThjHDXYnBgZL0Yl7C7Z
         lgIBQA9GE91qYwg5nfq3ix6tkpC/T/b9cFtz8xYuiDWWJ+KHIzhssPxrVRNJMBwsuAnY
         xsABnpBjafvCRufYCcN1PDzqExKtYOK7C+mlOCoM0PIhrqYy4UGPTjCNrLdnBSmmu/Vg
         ycjW9sfanOXO7RqytHWOOrLDvRnpY60f7LS2A4nk0gNLZCrLBr1tW0C9ZDXWb+NJgvnS
         zAzmcKqqIJfPBbvJw5bHGJPUhGhA9fm5R7N5pIpYfb/SEzeTPeJgdowmaUS3RVCPQUhd
         1sgA==
X-Forwarded-Encrypted: i=1; AJvYcCUkITO/lsLdQOaUdxq5BvCdNg6jPXrrJq1rPgnIi/hls9KDGwSnxYSy503hTAsqipsYsTzDKEOrt5r3gexII6nbQhFGsXQoA6hMqTKn
X-Gm-Message-State: AOJu0Yxfw75vEiD1QZPZXh4l0rcHk+OCP5S7U/uNYmdI6Uns7KAdhLnh
	eE2ULfwJeYzJ2kPhPBarD3mle1TV8Yn51C7pdKGkp4npVGHqE8Ola6uEhtVEVg==
X-Google-Smtp-Source: AGHT+IGknCDJeS90RO8ehnRZ7gHMFeBw03OZmeGDsZgVqTGTubjzVOjL99+92Uvx9d7Hh1AaJIztzQ==
X-Received: by 2002:a05:6a00:4609:b0:6e7:3254:a4fd with SMTP id ko9-20020a056a00460900b006e73254a4fdmr946741pfb.8.1710902648109;
        Tue, 19 Mar 2024 19:44:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m24-20020a63f618000000b005e43cb66a7asm9830852pgh.87.2024.03.19.19.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:44:07 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:44:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: au1200fb: replace deprecated strncpy with
 strscpy
Message-ID: <202403191944.B66E4853@keescook>
References: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-video-fbdev-au1200fb-c-v1-1-680802a9f10a@google.com>

On Mon, Mar 18, 2024 at 11:46:33PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Let's use the new 2-argument strscpy() which guarantees NUL-termination
> on the destination buffer while also simplifying the syntax. Note that
> strscpy() will not NUL-pad the destination buffer like strncpy() does.
> 
> However, the NUL-padding behavior of strncpy() is not required since
> fbdev is already NUL-allocated from au1200fb_drv_probe() ->
> frameuffer_alloc(), rendering any additional NUL-padding redundant.
> |	p = kzalloc(fb_info_size + size, GFP_KERNEL);
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, looks correct.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

