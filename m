Return-Path: <linux-kernel+bounces-60297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D388502D5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97751C22562
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6625613;
	Sat, 10 Feb 2024 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BC0Ur6t0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D91D6BE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548307; cv=none; b=cYvfjHc3k66qipJ//TbzG0mo87RBBO1oXgR20D6rF7q1sZr7qT2X8j3r/JOlOk9Co4W0E2mK+FXC+youylexlsM4755g8CfXJdtzWVpuhsvsHZ4OJ0FLWmFBxhkh1M1m8z3bxG2Rxq8apI3Otd4wr1FcjSQKcD5xwq0jDLRnl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548307; c=relaxed/simple;
	bh=pjkxarYzMzfLr+1SzeyV0T6q4WwkNLALSAqXupg/bIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lorNQJ1+q224L73lYW4cbktBVY/LVVge+ZsoNYcJrroHWBlvB/Z2s+NYVNYj9IdATbCVNA1lUC1+WsobDU6q/oNu+HeocDQrsjRI24G6wKCC/H4PvOeREvIVjRN9tvp7Fw251JuEfldbic+AKH35yOVF856EMGz9YtXZlc0vxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BC0Ur6t0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so839202a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 22:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548305; x=1708153105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L1FT4FGi/qFudpo08ANDBDJzWIFsevGjRM4SJXRMOo=;
        b=BC0Ur6t0NRdJ42ScMEMs3p+4Q2rz5qS1oZqVn/lJaOBwpAMRX5tvdFUmrN4oDbsU9N
         Lxt7kwjPKdWWaqgjCDhqx3QwaRK/NxD0mnJlvTYlA2cHldY40/VV9a0++KEafD8dbUUH
         WDd99jQrAoZJQLUKrrt0x/XfsHy2UvX/nQ56Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548305; x=1708153105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L1FT4FGi/qFudpo08ANDBDJzWIFsevGjRM4SJXRMOo=;
        b=KYgrwy/HJpSl8Z87VTGlAJ4luWAvxbzNxk5XLyWzLNqCRV6WlAoEviksnm6uJjMbKy
         sVtpuatwsjgkGtj9cD7FbU/M3yaQu+ffabDlOlqdHDeUp76sm7N6mYdNDoIDgsKnHCGC
         au5hxXhbk95Xjuz5mnKEvITyiBvnsCpC5hJkarhiKwC665aCtZQzxu+fsJ7hoBTQV1LO
         RJ3C3Uz+MloidVKOpecz1uFKsnwJyf+DOkMfQERZxRkHb2uKNembhdA6Q2e3FYM7UuFC
         TmjdESmW8cPV+73j1qAV/lQ+gdw1HR7FZ2IC7k98Tg7cJSnbVoiY3UAr9pHS7PIdjo29
         tLjg==
X-Gm-Message-State: AOJu0YydLHcJKeUfzHsuN8U1FwtETSrcNxe//wUPD8jEIHCJThxyuFpR
	j/D1GGJSzd4cdyxl3IXhWTxHLJBzgR9dsR+suMuFVQTlxKB2dzXQCUiCd7BKbXdu9aHhEmESuVk
	=
X-Google-Smtp-Source: AGHT+IEdTo6QCMe3jHXjLeph9oNK8jOBiBk3OmYka98Un3uhEU//zuX8lKVXGDvzmaCuTvMGV23WQQ==
X-Received: by 2002:aa7:8381:0:b0:6e0:9e95:b3f8 with SMTP id u1-20020aa78381000000b006e09e95b3f8mr1584603pfm.9.1707548305522;
        Fri, 09 Feb 2024 22:58:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6Zd8kBgVOIGnkCDmW6imsRLqHW7L+v6AONPFJn8SP0CuCHXf8nxXxQP3lYU7arcXYCDChwkbWWppnt9aMqc/y/GhmS4jX2Z+6zXhvITuTC6i7YwoTf5elczEhcFdAwIPQNJO/+Q==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a056a0026c700b006e041f098absm1599775pfw.129.2024.02.09.22.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:58:25 -0800 (PST)
Date: Fri, 9 Feb 2024 22:58:24 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Richard Hirst <rhirst@linuxcare.com>
Subject: Re: [PATCH 02/10] scsi: 53c700: Trivial: Remove trailing whitespace
Message-ID: <202402092258.5F3461A75C@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-3-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-3-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:14AM +0000, Lee Jones wrote:
> Since 5a602de99797b ("Add .editorconfig file for basic formatting") my
> editor has been forced to remove trailing whitespace from any file it
> saves.  Instead of fighting this recent kernel default, let's start
> chipping away at fixing the issues.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

