Return-Path: <linux-kernel+bounces-125568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE68928D8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A21C2124C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831B15C9;
	Sat, 30 Mar 2024 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRVpnaMQ"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184F915C3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711764344; cv=none; b=T8RZ2R7qkBKsNGLjPMvyxMfasZwt7EEBw6/n8heDSErFm+fMjlx8szJ24BsGhQ3kCj2rCYqjuSwtRmxmAJKizLMpritP7f/Weq9BpcIvjifoC5jvZNCrEZLSM8pJLr0pxch9d2USX7jeZYPSfLZfrznjvKVGmN/F7apTG0geOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711764344; c=relaxed/simple;
	bh=E/jX4KlSIaa/Q8QtoYy4eUqMqZjvH5LqwLaZpzp/ucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhhp5XW80hS4Iy28rcelMM0A+wox+uHtBbrUuCRjFeKD6RDC9S5k7S0yfyFiQVCZxFxII5o1fsDhlMYPnVtGhunBEMyqKoxan3CTnWqoXSK17iCUSZhVVB8FKVk/xXKXRKc+C3MQiUU8j6Wwl4V+XLquhhMa4gSFtWlWNlaXf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iRVpnaMQ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a4f608432bso1584701eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711764340; x=1712369140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4b5SWRCYZt8i7P0MBjW3Wz+qnk6OUO4+JznjTM8IgU=;
        b=iRVpnaMQGyOifKDMKfV4HDQhfKO2I3PqjSeGvk1BCJL2XQEgqxw6gG5AIc67e8Ex48
         MgrsqNrt6KRr8GNhnVCpn7oa/2iZGkQI62KN+vNLkBCTEfeMhw3apZHPPwq79axC8JP7
         XIcvafJRVutcxNUFOUoU1vTP7a4o3bh1xpkvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711764340; x=1712369140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4b5SWRCYZt8i7P0MBjW3Wz+qnk6OUO4+JznjTM8IgU=;
        b=VlsG1OAhzQvFBatL6LQIZN7mlcUq6mQni4A5sZEsI8m0RYiV3moVmmKANddiz2PTHy
         uqQBCEOxdyzRdK4lLbl3WMg/muQfxNj/Bv0Iag9eXYJof/mlyG8RwRZH4rIg5mVMdPLl
         TbCqpobJhND3axVqWTyQQlEpmeqd6suEdsJlLl1BkVRnWXM1SvVCZx3dZpIsbWu3VolN
         DdoUUxoF5CAgJXFEfwEQwmO5y+CtRLRhs2gO2FoIVhmtdScriUsuArJnFgMyzlaI1mmg
         M8hI6Orzr21rb5bt7o59cFgONaHvS6HS5reydxVNY8QfBW1S8zkGJ2M/l6NEQmwc6IGB
         YFdw==
X-Gm-Message-State: AOJu0YwlrzEQtevGG4L2J3RDWPr5H/gfHqeyhZPp1Bdiz26VxkYnuuMD
	fvGVybl2ggvxESltKyhe9yBk0iQUQRZE+8ajwEpnHtwIIE7yH+2NTF9jjlq5QA==
X-Google-Smtp-Source: AGHT+IGZUureMcBcAiDHCXDSBEA1ISgTNfHGRDI1385rMqG8mvlZa9e/AHhEQI+LXUMGNEiBGPFkDA==
X-Received: by 2002:a05:6359:5a81:b0:183:861a:a6ff with SMTP id mx1-20020a0563595a8100b00183861aa6ffmr1969988rwb.1.1711764340110;
        Fri, 29 Mar 2024 19:05:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090ab78e00b0029c68206e2bsm3521375pjr.0.2024.03.29.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 19:05:38 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:05:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, davem@davemloft.net,
	andreas@gaisler.com, masahiroy@kernel.org, nicolas@fjasle.eu,
	guoren@kernel.org, rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 69/98] sparc: vdso: Disable UBSAN
 instrumentation
Message-ID: <202403291904.05D45FDD2@keescook>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-69-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329123919.3087149-69-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:37:40AM -0400, Sasha Levin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> [ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]
> 
> The UBSAN instrumentation cannot work in the vDSO since it is executing
> in userspace, so disable it in the Makefile. Fixes the build failures
> such as:
> 
> arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is harmless to backport, but doesn't do anything. (The UBSAN
changes needing this are only in Linus's tree.)

-Kees

-- 
Kees Cook

