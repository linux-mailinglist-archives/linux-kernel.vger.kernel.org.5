Return-Path: <linux-kernel+bounces-40489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B305083E190
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5ED81C20C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2E21A02;
	Fri, 26 Jan 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f+8TKxjx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD821370
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293816; cv=none; b=WR5wx6rRHPZp70aP2lGD7JGaoIOpU8I4PrunWdJU2bUFKHg7gb4BsXjTcitV5IVcIlPOadM2swZar6J6iYezmCdEsUCM+gHBCZB5NMcYlaI7giwjJ21ucWmDpoEcR5tNnsZtq7XU2m4LRjiQqpPBQBdBofb91gXfnA42WhCOe+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293816; c=relaxed/simple;
	bh=Um9Q+idAQFyVGXxZnVllLp3VYvAW/IRbdpgmYA1ELa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+f9ijV0srYqD0XkAjxjZ5FdxEAWGWcKnmB1wUEnHjFKKUifJI+jw4aI6+WVg9LtGdXbs9ibNWrxSapS8BZw0ZrbaWHnN6TYoSGDgjEqv+YQrqKqdnxPVr1FRryNkVEYNrBVPfgc0P8kAhZ9M1ms/So638CUfDApytvganU8J9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f+8TKxjx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71c844811so4875915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706293815; x=1706898615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w83qDmL8zuueuZtZRKkzHbmhJ/FdjFVL385VMEG2h+c=;
        b=f+8TKxjxoqAeD2M9NOKsTMOsOhwQ7PWbI1Y0z+eVvFUkXzNIGlpaPU0wBtU/D8iWie
         LYS3PRWUj/3HPuSVPmPePVYvgdvfHRQjyhJGFFGhe6tE2FCBhyTxzkXFOooSIOclWUhV
         3HUrdsQPf0hFKZmfUBnv1BtswFdIGm9YDmOys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293815; x=1706898615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w83qDmL8zuueuZtZRKkzHbmhJ/FdjFVL385VMEG2h+c=;
        b=Hj+DeW8cNWozZOZ/9pEkLDpKaz+rl0+D2HpbbTNiVe0ZjQZ30t/b9qq2z0Ix3LSbzK
         UY79oR+atNRPd/5Z6XZOwfpmZD8gueTFgqqzrR0ZNXhTWjm7vj2BYkk9L2bT6LCaldfl
         zA1UTL9E4kZEDyrIV9zYj9XRe9I0jQiJHBeO1X4sXuNUAWFV9bchUnQMjPg27ZlHZZvW
         NBYvjsLldXlZkx07ug83tCO4Cssx3JV+g8Vrrqh8OVSCCT2LI88bWC3ly4M6Yrx3h67L
         pzKk5opfNYkS2iYCBILDc54gqqw/VA75a/QOhp5Ea/lAT7zSPFd53iW6qtNhdXDusUzR
         fYkg==
X-Gm-Message-State: AOJu0Yzi2f955QyZRExAmMsU3wEOa1dSFMb4vrrEl9kLcfXbJv5L8/r2
	+Rbk2ED942RQV31Z8SLakMv509UW5+2opFpf3vlwAqyb3jEtggcGyos7d62+bg==
X-Google-Smtp-Source: AGHT+IGB4yDHqGeAdw+c4vvfPkk4mg1puukugu3tppHOgR9r29nfa83xEsQWHnsDcbn1WzeWunYpOA==
X-Received: by 2002:a17:902:eb15:b0:1d4:20ed:ec46 with SMTP id l21-20020a170902eb1500b001d420edec46mr197947plb.104.1706293814836;
        Fri, 26 Jan 2024 10:30:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902ed4500b001d7633c36efsm1233825plb.208.2024.01.26.10.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:30:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm/bugs: In lkdtm_HUNG_TASK() use BUG(), not BUG_ON(1)
Date: Fri, 26 Jan 2024 10:30:09 -0800
Message-Id: <170629380800.1588815.1983620062611427413.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
References: <20240126072852.1.Ib065e528a8620474a72f15baa2feead1f3d89865@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 26 Jan 2024 07:28:53 -0800, Douglas Anderson wrote:
> In commit edb6538da3df ("lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid
> tail call optimization") we marked lkdtm_HUNG_TASK() as
> __noreturn. The compiler gets unhappy if it thinks a __noreturn
> function might return, so there's a BUG_ON(1) at the end. Any human
> can see that the function won't return and the compiler can figure
> that out too. Except when it can't.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] lkdtm/bugs: In lkdtm_HUNG_TASK() use BUG(), not BUG_ON(1)
      https://git.kernel.org/kees/c/34b82a2fb747

Take care,

-- 
Kees Cook


