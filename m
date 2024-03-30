Return-Path: <linux-kernel+bounces-125569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD88928DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B2282F3D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A7187F;
	Sat, 30 Mar 2024 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwcfqojT"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4C522F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711764373; cv=none; b=uD/ZTIFAOLZAoL9wnRRyZC/LS+DUJ7ia/wKekmaiK/ERHakQX9nklJ733sF+k+5ZIF8FYlumMnwTaXV0vaHxM8nAdXTMnZAB3uIbmJfyHK2jlsDDDmn9+xVEiJE5jMs3Nif1XqWwX0z3dzrzw3R+L4jHO2p5kCD/RNnsbJ/60vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711764373; c=relaxed/simple;
	bh=t0Hz0IPe/fb7iYcCk0H6dJUvRpizatFmMMLfnMLxuG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm272FmXDObA/+McVpDRRWkvu5nQSOSRIsHJ8EcMsarkJm3BIFjXcXxnNS+O44KHu7hp1+IBkcPWkOrcYM/0K0gvo3fZ4V+M5TmYw5deKZK0/DBR8iE9nl6RuOloQPzsftI6MpKYcOKvMesjh/fWrpki5gOtpnMduyIARoqFDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YwcfqojT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4d435a036so969326eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711764369; x=1712369169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZoxhsymi+AEBAv8CEqRs1EG6a56Ts64GeVC5M6dE6M=;
        b=YwcfqojTBmq/j10fo1+5GhvVHns3eg2r44YjY9moRlsTTliqCske+a48shWkooaHTz
         i11c+nQ+d7qNyBUyRLiKl8xUrWB6+KwT0UueYxDq5kW8ksdJ/eIvT47RE5B4T7qJk77Y
         PcILGqYrb44B6nkLfpJeABEYWM3NDSCWn8tTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711764369; x=1712369169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZoxhsymi+AEBAv8CEqRs1EG6a56Ts64GeVC5M6dE6M=;
        b=TRiiZlUBpBoz73cH2bpr29mQRakm+hngy9of4LtwoUrJVJDxC8pYuijNVYyHM9yapO
         Xb2cV8i2mQS1ApGeQ35KgiUvrW+JyKaMoeuqla2/ZQje1Q5GI6B1dvMhnjvNqMyR9Aqd
         UHiRLTl7CN6ROHU+j30owOmAXgvLU+z0rUwkvRNjX2DbEqIrnxqRuQPd7OuDg98dbBFx
         uRO6ErNIF2c6s/bZV5SVNqXOC+mDiAp90m7Fcq+gWLE1RUZO0UKVLyvOvfaEHWfL98//
         e2DFOzzM3wTkaAaKiYs5z8pgjkjLDwP8R7T/mbTu7eR0XPDaL02a7Fj5jA5RVwvUj0wq
         IAcg==
X-Gm-Message-State: AOJu0YwJEQouksBAecnZgSjxXCKyFUJanR/5mfEA0jr9jLMSiRPMWCl8
	mFEYOEYKwZYkcuvDfDO/fxIjuG+qmEmVi+jHE2sy2U3WYN+CmPKf3mcOiUCbng==
X-Google-Smtp-Source: AGHT+IHwHlTfLV9GfVQAhEexD8rGmEIWClX4bK7Ct2vKWmplx2znlAy02xAfUSs94N3Wc3qoALt16Q==
X-Received: by 2002:a05:6358:5409:b0:183:4d1d:dcaa with SMTP id u9-20020a056358540900b001834d1ddcaamr4207104rwe.3.1711764369017;
        Fri, 29 Mar 2024 19:06:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ac70b00b0029bc9c34a39sm5670564pjt.50.2024.03.29.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 19:06:08 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:06:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>, linux-sh@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 75/98] sh: Fix build with CONFIG_UBSAN=y
Message-ID: <202403291905.7749C8A8@keescook>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-75-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329123919.3087149-75-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:37:46AM -0400, Sasha Levin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> [ Upstream commit e36b70fb8c707a0688960184380bc151390d671b ]
> 
> The early boot stub for sh had UBSan instrumentation present where it is
> not supported. Disable it for this part of the build.
> 
>   sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
>   misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401310416.s8HLiLnC-lkp@intel.com/
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <n.schier@avm.de>
> Cc:  <linux-sh@vger.kernel.org>
> Link: https://lore.kernel.org/r/20240130232717.work.088-kees@kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Same as the other:

This is harmless to backport, but doesn't do anything. (The UBSAN
changes needing this are only in Linus's tree.)

-Kees

-- 
Kees Cook

