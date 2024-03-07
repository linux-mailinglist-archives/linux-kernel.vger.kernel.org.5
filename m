Return-Path: <linux-kernel+bounces-96073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309E8756C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C651F217D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392213665B;
	Thu,  7 Mar 2024 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGGKnv/8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29A135A7A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838650; cv=none; b=CqSOEfiQQxNiUWmsz0XERDC65HRXmDHMGaMmWHJtkC+O6r3yn5+/kIxGu9Wbq9cw46kNyD+B43TTN6TQuWYF3MlpD5+/4T5kp+TR6HtnfNRUaiWEwtgKd/uVbokabKvpDIwWER6BiwRxR9S79/FHqRZEga0PBQnGe8mUjvPdm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838650; c=relaxed/simple;
	bh=izSH/PMxUOlhLqiqWhtGUMGagmQW6jaoeudrrfnJ9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti22Y3pPQYbJ1p2rUdU1q0zRwp7u0kmK7jElfPmaJ3vfRMpslM0//MsG0FOF4cMxQfNKlQ3C2he5bE+M3DkIxwctC0urP1goei8wZ1WE/c/rt81EEO30ylOs8jg8j96c9wZ+oaivKoWtWaFia3lCrJPIEWzv3i9gAWLLU1DyEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KGGKnv/8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so993939b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709838648; x=1710443448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6/jADR/0UePn6YUf/L4DAbrCMU1cm50ZPRMKWLUirY=;
        b=KGGKnv/8YuctKrGXVQXW8dxWq8ftiGlZx51D84ZxcYEX42nz27+TWRx9Uh8mpm2tVH
         fnEjkQ28SUetzzWjr0Ouk1OG2F1J30fVbfy4gBafrf+QqGuTb++PJFj/cb6huPtBqXtu
         +h8BGP8cL6aEqg0eZlsINgnPvumAdxMCYiE4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838648; x=1710443448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6/jADR/0UePn6YUf/L4DAbrCMU1cm50ZPRMKWLUirY=;
        b=tYscl5aiOFBrxnzn2L32j5kVs24PsA+XnSRzD5FygRBa2RbE7E227QCMUvODkmv64G
         7U2JZfndrWEqy5QjqzUXmH3EjaVpliSaIj+Hz3JSsI9AaFnY1R7yxEpYNmAScVORHc6I
         gHrbz/bbWYJXUsx+Y5SqBtB9oRhGrKHgdiGw9LGoHECaIwoc2wymNA25d5eUDqWYkbWP
         HA7MzwHVz3v2pR+ZVya2vx8X0WFsAO1rSBRFi1HYCmzg3Z+9zIor6GA+J4p6F13vPIF/
         +yU/O5+N8dEfSCJHgQsJBGn7LVXYhSiWX48Gk7tboqoMNNbafIesgiJkApviavUVckrX
         hs9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTqq2m8/4Sgo9C58IpMEq1HD8VRhcfON4CYUMT9glBJ+jY31/QHvLYo1LTUketeYWU2m6jx1pNtXCs6/2ZE2gFCrLD/7aoWmU9xe5b
X-Gm-Message-State: AOJu0Yy+109rWwg7UCEqbN5LIiRj3k6efQtwcAzj8AaR8ONi+vZcnukL
	6Qyw4pwTn9K2uSbaltjHI5+PEOkBURkYq2XK8ihb8HfiZKU/9LvjkaP4ybxdYg==
X-Google-Smtp-Source: AGHT+IFN6Sz1G8Qiw0tjzpneM1RD2JAmKvXtZLyGSb+PlWyD/N9lVUXVr/U3iktkEiuQ0N39CeDwsA==
X-Received: by 2002:a05:6a20:5498:b0:1a1:6914:6bc0 with SMTP id i24-20020a056a20549800b001a169146bc0mr3186404pzk.5.1709838648372;
        Thu, 07 Mar 2024 11:10:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r11-20020a63ec4b000000b005d880b41598sm12872052pgj.94.2024.03.07.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:10:47 -0800 (PST)
Date: Thu, 7 Mar 2024 11:10:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>, Guo Hui <guohui@uniontech.com>,
	Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202403071105.C3B038C@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>

On Thu, Mar 07, 2024 at 12:10:34PM +0100, Arnd Bergmann wrote:
> For the strength, we have at least four options:
> 
> - strong rng, most expensive
> - your new prng, less strong but somewhat cheaper and/or more
>   predictable overhead
> - cycle counter, cheap but probably even less strong,
>   needs architecture code.

Are the low bits of a cycler counter really less safe than a
deterministic pRNG?

> - no rng, no overhead and no protection.

For the pRNG, why not just add a reseed timer or something that'll
happen outside the syscall window, if that's the concern about reseeding
delay? (In which case, why not continue to use the strong rng?)

-- 
Kees Cook

