Return-Path: <linux-kernel+bounces-53003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E3849F63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC625284054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE393B1B2;
	Mon,  5 Feb 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvybJFVt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A923CF5F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150110; cv=none; b=KJWzxI224U8W0/MyY1hPa85WCs5GxfnSQD6LVQPTYsPS0FSDu+gh8WJrihJdxwNrp/TBtzi9W2ZUqW6FGbtotDp0uCQWV5XGruPjfdeK6E/JEUYInEmCuUotLQVKKelVWIWvG9LKLEXFWahzGMYT7zCRE0bDaGO9G6jABheOnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150110; c=relaxed/simple;
	bh=IXbS5jwsg2soia7aLFCzN1PxbuLT3Im8P95YoAzLLis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3+9rxZvIx7IPXXK528CRScAswKENaDmNfqP8GVGB0gFhk6OnSPCdEKO+kPo//aN2UALC/mwYy7RPoWkUAsuoGE85vE4virwuzlkAe+HgVyJ1u+llYxthkrxnhzfGL0yFR2V6QKJJuRCRPyuX5xvpIcnyj7ZoQ61Y/FqX8HT5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nvybJFVt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d746ce7d13so37645565ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707150108; x=1707754908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZwZeufc6RF0LGvmSyP+thskIiStXIaE1teIek3hvHg=;
        b=nvybJFVteIgFCTbRfJdnY04Rd7s+py9FJph9J1Ip1Yg1G8eKhVHc2v8SztDGWYdUiC
         l3ysn8gAqFgCGrofQ4rRFHfr2apTwq4CeK61G8RFn4fInjlYUcK8lFQPq97+udM7tepz
         MijKsAAtu/e29FRDISRXAt3LWwEE9VgvW9HnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150108; x=1707754908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZwZeufc6RF0LGvmSyP+thskIiStXIaE1teIek3hvHg=;
        b=b1CfrVN9IdLLCIfkAJL847sAO4pXYL8EZm8JZnHzmwodpZVBpk/8vttNlJvKBkBMOA
         /q/KpxaX2gzqjGnkOj3KREA3SIXKrX8W/0/R0ffj3fHozQUuxMt/q3PszE+r0cMVFYtv
         rGSTVpTfJaU2ZoU5rZGwY1hSAOgur6ImT/Vs3V54996K4lwoEHv1j3PumCluzsHiKgLm
         c67KJwWbMWiUfdDwMAHBOA5MaR3jYVo/Q0zi80Rl4UW8nCLwiHHGJFbtCR9O12fvbnOj
         O2oKlbYMPGXfIWKp0v5mnQ8RHRrCqUbpTrADU0rQjAGGz0TMApsy7CqnmDuJUJBwJvlJ
         v2zw==
X-Gm-Message-State: AOJu0Yxt5aUcihxruyx80Z/TRCJTjvgjBGJ/TVvJ1cn1DeFovRCPtGi1
	tFHtl94fEKILQ5KS6Z2vgtmH/MZ9Q8+OA5ufblSh/zpReIGdYEPt8+80PJWV+g==
X-Google-Smtp-Source: AGHT+IFOi6SKmDq+rEHuXD2yZIUTwg+48hSe9Nl9MGs2+LH2Mbti05+94D2DxPC7gvcjww9srmpYXw==
X-Received: by 2002:a17:902:d544:b0:1d9:ab92:1550 with SMTP id z4-20020a170902d54400b001d9ab921550mr6160873plf.63.1707150108625;
        Mon, 05 Feb 2024 08:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6WBBeNWFvorF+DbpeeCWedea/8Hkd20BNUPZaVZN2ePQGBivtHSul7DKIIuJwuuF2cfCRt3rZQEuOU4nr1E091Z3sguDmfGyKCX9U9vDmUvI/9caOUHHvwesqbnybtOo758qz4hn00Rp8Wgs1iXMzkg38eh7if5QgTNZviORqXScYOWUg19rqx7Y3peu4C0l59fwnXixxz0MOLr40N4QoWjp6pJEwQayI3wHJ
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001d88d791eccsm46955plb.160.2024.02.05.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:21:48 -0800 (PST)
Date: Mon, 5 Feb 2024 08:21:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: Add __uninitialized macro
Message-ID: <202402050818.B11CFAD2B@keescook>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
 <20240205154844.3757121-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205154844.3757121-2-hca@linux.ibm.com>

On Mon, Feb 05, 2024 at 04:48:43PM +0100, Heiko Carstens wrote:
> With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled the kernel will
> be compiled with -ftrivial-auto-var-init=<...> which causes initialization
> of stack variables at function entry time.
> 
> In order to avoid the performance impact that comes with this users can use
> the "uninitialized" attribute to prevent such initialization.
> 
> Therefore provide the __uninitialized macro which can be used for cases
> where INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO is enabled, but only
> selected variables should not be initialized.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thanks! We had something similar a while back with syscall entry:
efa90c11f62e ("stack: Constrain and fix stack offset randomization with Clang builds")

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

