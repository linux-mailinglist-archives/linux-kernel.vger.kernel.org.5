Return-Path: <linux-kernel+bounces-145530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D483B8A5771
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D375287EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C988061C;
	Mon, 15 Apr 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GiUzGe5z"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12B811F8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197682; cv=none; b=HP9HDq33TdmxrcJ7cx/TZZ+kHc3umfB8WXpyL1D3qwfMXQqleD3waQ0Qb5KLkgVLEIVq5SFxITqeTT2Q0Sx0x5ANzIKWMQ16ikBXmCnNR8Qo8T6U1/lz9gaU+SehDoZn+3pjP9JoJoJTkQmKtdFLpR1IY3kZS5n75wo4qUsIUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197682; c=relaxed/simple;
	bh=rquWVadfj6Yy0WoSxsb5IHBjslGBtA7x3EuuyCTZdjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNpmDQT8bJY0drzcOGLYXJ18F4rRiCThnvD816K7vTBh70jVzk/bI44/GeqS39xDylzaBLnZtWEqMPathmKHUu6dWHfvj/iDRFSbYKm32wZdpdUAe1OjS1lZey8vIF4jknlCkUkM7Xlc/ax+mvUbfxXErlRHp0N3mjvm+iewdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GiUzGe5z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3c3aa8938so21257485ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713197680; x=1713802480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESjTQEjB6T8D9BX5RBjgYE4FpXh9kObuptxS+F5zuE8=;
        b=GiUzGe5z34BY6zeJdhN3wvu0a7PYCIf7nq+L6SMWCrkLKL0xwDlp74JrEysCkeKn4y
         /lOGr1I0d8rPqTFMlHRq2gPfVbMt0DUwV/jvOmJb/itGJNRXPk9v+yOWaNw6/xHHxrxx
         qwvVsfU04DHg9KedMTBM6pFBfUhBb/DYlCyHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197680; x=1713802480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESjTQEjB6T8D9BX5RBjgYE4FpXh9kObuptxS+F5zuE8=;
        b=XY54+RzRbMz0y6iQcNH77/cHKpIqGcBoCVWVvGBonepNyL7ypLS3774d/Vg28u9F7J
         3xv34d5UGoGkuhFMumR4QOXqMQvO2yP45dkBVOZq3Y9lrwermsPzmymAUn7OesW01gA/
         iHw0j7iW/CHgPRT1nKrgGQLwivGCOYhT8RLCDE041wGcQiig0Q0e5NMFOP0isfQKV6pC
         6J2bNIck13sKDqeRi2cXc/67vun1AruGsK0R6xjzWwbZCJeGUAdXECxc1pGvDXSISEVB
         C00fdiX7/OIWOMFTxNedqwOLbFPWVsfAh+Qg4+hfRUYX5Tz9IZv6BxMnlG8HLPcBSg+J
         Nwdw==
X-Forwarded-Encrypted: i=1; AJvYcCUNPDFQcaKX5kMccto1028dnnozsvKyIHZV2w3AxFxyNjDoiSgG0Ya6Qw7/B2BdX7OC/QvAav46Di7UWTOAcOgNbpyLA3t5o54Y2HTe
X-Gm-Message-State: AOJu0YyJropNRWtjf7VR5agfbGd0GwufZorn7EQhMuoAXL7JzgZ2qyrB
	H60SCevUPHHLa02KYbBn4vCmcMa5BO3HCs8ZY2k1A5je4cxlnqvsWKwlkSFUZg==
X-Google-Smtp-Source: AGHT+IEe1jv52+Td77XuCCAwHJ71uxuy0azFMdvGaqzkxeNt/5dBr0b2bIK8CztJl0u2nID5zkc5Kw==
X-Received: by 2002:a17:902:cf05:b0:1e5:a3b2:3da2 with SMTP id i5-20020a170902cf0500b001e5a3b23da2mr9918860plg.53.1713197679742;
        Mon, 15 Apr 2024 09:14:39 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902934900b001e45c0d6be6sm8070099plp.246.2024.04.15.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:14:38 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:14:38 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>,
	Gatlin Newhouse <gatlin.newhouse@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] [v3] kbuild: turn on -Wrestrict by default
Message-ID: <202404150909.E703A96D0@keescook>
References: <20240415122037.1983124-1-arnd@kernel.org>
 <20240415122037.1983124-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415122037.1983124-4-arnd@kernel.org>

On Mon, Apr 15, 2024 at 02:20:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All known -Wrestrict warnings are addressed now, so don't disable the warning
> any more.

Ah, great! Yes, I know Gatlin was also looking at this and doing a bunch
of builds across compiler versions to verify this was ready to do too.
Gatlin, are you able to provide a "Tested-by:" tag for this patch?

-Kees

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8b3f5b62b837..95466a04d51b 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -98,7 +98,6 @@ else
>  # Suppress them by using -Wno... except for W=1.
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
> -KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
>  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
> -- 
> 2.39.2
> 

-- 
Kees Cook

