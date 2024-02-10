Return-Path: <linux-kernel+bounces-60294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0948502C8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32623B262D2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC618C3D;
	Sat, 10 Feb 2024 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N560i041"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E587168C2
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547452; cv=none; b=TDDDGJHKgpYBe2jSU517iLIPUbOvpN62txo97Gfo6NJTCK85vc7jRHOdfvheN2NRuSo6yeCoLc1k7hClso5H3UtVmqn1A6cxCJrvVvbElN2mTuvmwBsojh7R6+W5OLzovJplA6Xjvb06rRZX9ZsO0RaqWvrw4SkUkBgKf23/GJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547452; c=relaxed/simple;
	bh=rVJjCi3N8tFMrvczpodogpdGzRK8ypIs28YYsOP9OUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF/UG/3Q0u7K3d7yIDAfS5b9Jg/4aQyxHYX1HUwiaQlrgWrhGeQts5KS34sqiDUGsRtonXFTgAdkArXoBnn3dAr1RMV2qGyYRi8iga8CLx6bp39pAMLP2bS2IURcaNm86mnOT3F3DcfVFahVwd/9FuUaTfsI+pUKS5sWaWX2gVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N560i041; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d918008b99so13060085ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 22:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707547450; x=1708152250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzzRqglaHu6KYBZMYaRVn/OJnKTukB5u8vObEjsjaYY=;
        b=N560i041ETqWrrczx6n/aVllaGIG41Lis4bIEx57eZnZ8FNcoX7Qm+Ws2IetXfVv+C
         61SMH/IB7YdXu2rynUfozZO1/M53ebL+CrWjnuE2Hk+OM0uNcesq4zlCgV9tapbcup72
         vt0yYmWthK5v7H2x1KqJt4kAkgieH13aVfI6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707547450; x=1708152250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzzRqglaHu6KYBZMYaRVn/OJnKTukB5u8vObEjsjaYY=;
        b=iz2nHE7nO+3ATiMoV6JOvlWkFjJuVZtSynNeVzM/bbsWXjOvqVy8Udw+uiGo9RErWn
         UrGVnJVyjchgqpX/TnJnhMGiPjBANo9dmiK2DAVC1VGWz79dJMlg1Prontcj2xEUKwDf
         9K4oDK45jFoJry4WF0kRPdZarKVqMgzTAHLcWC809Q274oPNtn8GrdNiBXK3isGI+hrC
         DrbBQmRy4yu4Gw7rqEJYi0m5+2g5ieLiOg6ZsCDocWC0kSuH9kW9ril6pz9bDjGNTZDW
         18/7YSCpphuT6Ti3kw3j4+u8Tidj9gEBTStBzYkziaA05gFfuOfHTFTBPbQiKbcRDoUY
         iLqg==
X-Gm-Message-State: AOJu0Yy1cikWCkDrukXBe1O6sX4OfFbAHItNsYtMDccPhfQzChpgtArG
	dv9ly8V3OgXIRlM2MyHpFqI5pXgB/otie6aKt8VbulOaHfgkx4QR1SbNLXMwDYhzftkwiB0ziLM
	=
X-Google-Smtp-Source: AGHT+IF/n9LddPfvqJcL7BuYnk/5KgvC1XuhGYDU21J2sba5hxtRpCu1IMoaSwUmtvIDuYhc9EieoA==
X-Received: by 2002:a17:902:ee55:b0:1d8:b2f4:28ce with SMTP id 21-20020a170902ee5500b001d8b2f428cemr1318074plo.42.1707547449837;
        Fri, 09 Feb 2024 22:44:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1A8ml7120+1/TEaeBtijUSyOdzgTpH0u9DZ3YRPOgxeyZdHo3JDDaJrApPemRkdzvxM0f/YGknM0F4J/5caaKrSSUQKywSTQ4Bg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090330cd00b001d9c0c321c6sm2465613plc.67.2024.02.09.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:44:09 -0800 (PST)
Date: Fri, 9 Feb 2024 22:44:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the kspp tree
Message-ID: <202402092243.D04BE3C@keescook>
References: <20240208144842.5491303d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208144842.5491303d@canb.auug.org.au>

On Thu, Feb 08, 2024 at 02:48:42PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/string.h:142: warning: Function parameter or struct member 'dst' not described in 'strscpy_pad'
> include/linux/string.h:142: warning: Excess function parameter 'dest' description in 'strscpy_pad'
> include/linux/string.h:142: warning: Excess function parameter 'count' description in 'strscpy_pad'
> 
> Introduced by commit
> 
>   0bf7961afff1 ("string: Allow 2-argument strscpy_pad()")

Thanks! This is fixed now.

-- 
Kees Cook

