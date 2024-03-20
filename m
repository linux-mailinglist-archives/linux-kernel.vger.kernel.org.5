Return-Path: <linux-kernel+bounces-109425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413618818EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B46284C42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EA85947;
	Wed, 20 Mar 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVwV55cb"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392ED4F8B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968908; cv=none; b=qNt5oc3sGUSB7Ru91abZ6EZ2nyWMa0GqlvSbMetSoLREEyofPzUKQ+xyib7FvXZMsGfRwRfWU2lfh/AZ4O9C1GdDPR0KAL1d31w+cbqn+4fvTmBHWMIkzj63HxmkMprRK6u+w77urAKBh2yKoOTTTKy96goG7v8JIx0bajy3TyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968908; c=relaxed/simple;
	bh=db/Uh8o+Uvv9bXpTbGsPMPU7PW4//znxao0XLAMAxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddl0kWZqc4vPqrv3N2pCA2lLrY/rOzGvDBRgngeQAYtbrdO8OEvWT4Hff0UOwdyVmPjeIU6YI4IgU8TNtN3jvVXaZZko8xULPTWRsbSyoLuRYTZIWxTBBG2K/1kc58Bj7YoOUWQLty0hq2LNkWc4lp+PMIh/gY/HNgPCTeuqkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVwV55cb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso266784a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710968906; x=1711573706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLkYzB5+ZTvWOiX3IvyY6oP/ICYdTVuS+z29/pPznQ8=;
        b=PVwV55cbRtFAZ3MWedsyRPclwDtF1bC0f7ltXBBRNGuHFdeGr09/CIGUu4SsxBFOww
         gdAVz09zlRnl57bQ2Wxz+dQrBWonObKm/cnbZK/Jqe/wI63yukUIjW8C7MxZ3cdhKPvZ
         cpBKtG42Gcsw/kTn2AoF7aofX/c79zkWm79AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710968906; x=1711573706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLkYzB5+ZTvWOiX3IvyY6oP/ICYdTVuS+z29/pPznQ8=;
        b=VeguJLbWILGMKRFkOZnosPbOmZrKBttpZXHOuxoyf3RCg961O1kruudrWcd716wQls
         MKNW6dfqpMfMDe+0rSBApRU/UiUzHFUaG1+c5OXUQyuDqAcmHu26deQE/cvXJOPSntAd
         0VV3Wh8zv1Zv6iTRgx4I9JMDZbAt/ZZOEQsq+mv97VRXg09zFDdeToyWVJlpoVBhnw0K
         Xp+6pYQfQq7xajjZt1/I9FN5gLhdl4pJtoMgzLvXHa5f5cpe1iA3LS6GSUBjVRLRb4mM
         e5km3zA6cZ379Mqy4yfTKret+ekInrXB7xpzRrOQQbmGButewoDyBqYQJ7hGuNVfMulh
         r0oA==
X-Forwarded-Encrypted: i=1; AJvYcCXVAWmMlw880qwV6PYEAK1LZHlVvOySr+Wp15xXrrOPJGQmRfr0TOSoShbKuPojknnI1cYDcru4VtJvA4+xK330oZeWSnWpSriwPFhj
X-Gm-Message-State: AOJu0Yw9wQ7oGgm00clFXRYyAGs9ej/hl/3D9SgdIUttua0ak/8Id44c
	etDkk/hcmMJ++jJI6o69hNnT09xlz1rnv8smeiCXj7XcSwAUap8EOlnMoWyK0A==
X-Google-Smtp-Source: AGHT+IFltwN6J3gvzQbI/NEeVt7wOISvzFFbommwSsWSGAWyfbnUCH2tsn1YPIhLgukC979AFUKfHQ==
X-Received: by 2002:a17:90b:2c8d:b0:29f:b0a6:3c5 with SMTP id sw13-20020a17090b2c8d00b0029fb0a603c5mr206050pjb.49.1710968906551;
        Wed, 20 Mar 2024 14:08:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id so15-20020a17090b1f8f00b002a0187d84f0sm162906pjb.20.2024.03.20.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:08:26 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:08:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdso: use CONFIG_PAGE_SHIFT in vdso/datapage.h
Message-ID: <202403201408.48C8AC89A@keescook>
References: <20240320180228.136371-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320180228.136371-1-arnd@kernel.org>

On Wed, Mar 20, 2024 at 07:02:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Both the vdso rework and the CONFIG_PAGE_SHIFT changes were merged during
> the v6.9 merge window, so it is now possible to use CONFIG_PAGE_SHIFT
> instead of including asm/page.h in the vdso.
> 
> This avoids the workaround for arm64 and addresses a build warning
> for powerpc64:
> 
> In file included from <built-in>:4:
> In file included from /home/arnd/arm-soc/arm-soc/lib/vdso/gettimeofday.c:5:
> In file included from ../include/vdso/datapage.h:25:
> arch/powerpc/include/asm/page.h:230:9: error: result of comparison of constant 13835058055282163712 with expression of type 'unsigned long' is always true [-Werror,-Wtautological-constant-out-of-range-compare]
>   230 |         return __pa(kaddr) >> PAGE_SHIFT;
>       |                ^~~~~~~~~~~
> arch/powerpc/include/asm/page.h:217:37: note: expanded from macro '__pa'
>   217 |         VIRTUAL_WARN_ON((unsigned long)(x) < PAGE_OFFSET);              \
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
> arch/powerpc/include/asm/page.h:202:73: note: expanded from macro 'VIRTUAL_WARN_ON'
>   202 | #define VIRTUAL_WARN_ON(x)      WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && (x))
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> arch/powerpc/include/asm/bug.h:88:25: note: expanded from macro 'WARN_ON'
>    88 |         int __ret_warn_on = !!(x);                              \
>       |                                ^
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> See-also: 8b3843ae3634 ("vdso/datapage: Quick fix - use asm/page-def.h for ARM64")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for tracking this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

