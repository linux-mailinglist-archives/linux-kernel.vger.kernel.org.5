Return-Path: <linux-kernel+bounces-69373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B0858831
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08A31F23238
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDCF1482F0;
	Fri, 16 Feb 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TdZbvg5k"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8326145B03
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119957; cv=none; b=MX8og+tL6ByCBPvHLoX03ViOl5QHF+Is4nCVgf3ZxF2ApdtKK+VIewUa2Ifgenz7y9UGahaJ7M1AgWEWH+Mdhg9cmyOAxO8+Vieo8t/gm3dzrwEuQFBV3ltlg45GLACrqukoIG/SYWJqFo/AfMsDCrc7Tnd2gLPPBPpUe3P2mFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119957; c=relaxed/simple;
	bh=sWcb4QWZQerF6dGRRf3Saf0ygsiHNPwWHpaQ0U2ubAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX4I3CKclvLx6zvzgu+G6bGjh1p7BOhBMfmN5CEqmkzMeJ2tAyGRr2uFS0orlcIpftJTslluvE3sStNf5kvv8qDKydWUYK+OvwItrEwYReB6NZ2hN/f+WjMHaPEuMuC03u1zEduLoydujOm4JE7GAxPaE3Kj4OoGcC5F5qy3rls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TdZbvg5k; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59fa37c33dbso433769eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708119954; x=1708724754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jksvwB5iTFy80QFc8o5j3z92gnehVl2fAGc//WCCKZg=;
        b=TdZbvg5k1WzoSRChsZ8ZH0hIBJkpubl4faHGJBahsAR4Rn1FbSpuNIqXbeQxN+Lqv3
         cl5u9EIsM6UTMHn1zhkGC3A8fvhn+6ZBQ0aSS07tZXNk8Ix1XkWGigxhdKpvhSubBrYd
         irmgEFLSC+x384R3lGCtxIpLBrVn8qbSNCONA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119954; x=1708724754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jksvwB5iTFy80QFc8o5j3z92gnehVl2fAGc//WCCKZg=;
        b=UAPsZyrq1C2wOQsLn/pL34w0vLZTWp7qANxvI+4cYnWJxyhS/qcN4gfISIVhySlVkf
         g1MWFfP2c6W9z/XPoNmgxxZJgfoHrWDBSDHreTdkiJNAIycnhJ8Iv6w+lTpp24SMF5wo
         2rydAPt57SEC9jjFGZdEOEKtc7ftPRblYpJx3aQMGnQpFfWPmknJT2jaOQdZa5K66fxy
         mZb6gr5RBJpNKPhtcaZ/CC4xOdneEsQBalINwvIWBpg0a03BZ6z9Dm9WqhyCRSmgzxJn
         axROuV3WPSeykq/kWsY9AT+7rzNTD+DlGi1KDrd2G3XS7AMDHAMPp7g5ohQ1J0MnvLvv
         Ecvg==
X-Forwarded-Encrypted: i=1; AJvYcCWmG+mtiT4xgzLVIG/lXoPOEwhN4MnTK3dh4scKJrqkxRXelPsexJWhzWlTWOJzKaPzDdKmQgxKnaaL1rpAQlxq6ju7kr99ExO6ml7j
X-Gm-Message-State: AOJu0Ywhq3ivJhZ68v+g9vjrkYwGJ+9A/EyXcleWS6x62J0aoW1AuG00
	IIxIF9WqjhAWgonyt9I2s5olbJ4Yld/UGbBmOejU3mKfwwd7i8LTVf7RVzMaMtH3fsQTG542y50
	=
X-Google-Smtp-Source: AGHT+IF9+vJFbk3kmtKKuYnkYafkp2Qrd9UzE5RWwOf99PqpIE62RSHCclH6Xu0D7RM+/Fd/EwCtzg==
X-Received: by 2002:a05:6358:648b:b0:179:2136:9971 with SMTP id g11-20020a056358648b00b0017921369971mr6537867rwh.11.1708119953974;
        Fri, 16 Feb 2024 13:45:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a6567cb000000b005dcbb855530sm296297pgs.76.2024.02.16.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:45:53 -0800 (PST)
Date: Fri, 16 Feb 2024 13:45:52 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Include more details when reporting overflows
Message-ID: <202402161343.DC688FDB@keescook>
References: <20240216203935.work.829-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216203935.work.829-kees@kernel.org>

On Fri, Feb 16, 2024 at 12:39:41PM -0800, Kees Cook wrote:
> When a memcpy() would exceed the length of an entire structure, no
> detailed WARN would be emitted, making debugging a bit more challenging.
> Similarly, other buffer overflow reports would have no size information
> reported.
>
> Always warn for memcpy() overflows, but distinguish between the two
> cases in the message before continuing (warn-only) or blocking the copy
> (hard-fail). Additionally add size information to existing overflow
> reports.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

This will need a v2 ... something in my manipulations is triggering a
bizarre warning in Clang:


./fs/dlm/rcom.c:490:13: error: member reference type 'int' is not a pointer
  490 |         memcpy(rc->rc_buf, rc_in->rc_buf, sizeof(struct rcom_lock));
      |                ~~  ^
./include/linux/fortify-string.h:636:47: note: expanded from macro 'memcpy'
  636 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                                               ^
./include/linux/fortify-string.h:591:20: note: expanded from macro '__fortify_memcpy_chk'
  591 |         __underlying_##op(p, q, __fortify_size);                        \
      |                           ^


I'll track it down...

--
Kees Cook

