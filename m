Return-Path: <linux-kernel+bounces-79381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A7862169
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C911F247A4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF794439;
	Sat, 24 Feb 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hDTytCMZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9415A4
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736687; cv=none; b=jMfUusnPE0n6/o+i/tXA9Gf1qlljpnWq7exu6rayYWU9UPJ2mSBdzkO33ouJHR4sf8hC6nP6GI4FSEMTWAKIY+2VYKAT/WlBO8UIhCciwhsEi6AxDUWrnCPMtDG3+/D2dWUg/5ps4c30y8vRznf6IzHaqlHarXHq//B449edhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736687; c=relaxed/simple;
	bh=czByRd1ZtLG1ytyTx6JHZ0MsK0WUs6+OU6X2ecDmaiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXqKe1yldB3gw3U0bfqb/Bcn4Kw69mf9GWb3LFXVigDaXuNNN4Uk4eWn7mN/QAj4/qXAvRfmRPTnK5m4Mna40DXa4TGicgKjV67V6XP+vjEMCdbkdE78ptPvbga9UYpL8x0JTDxJLh4Z+yJWmJ9LHsBFwcV4IgKL4xfGTHa+1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hDTytCMZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc7abc692eso5715475ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708736685; x=1709341485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQKkVKoC62UNhXK21zihqEnfMAgk8ODcwjqvMq7e3Fw=;
        b=hDTytCMZjXMcc7dOtYwFFM4rdy8tCW0LtvCuewIQXA+GNLevAOsOUKvHDkHn5M3/dL
         CTTWrNl3Dyevh0z6tXJBitwSesEHgNAhD16osTPqXoquEczotZbqww3bXThTbEW10jxR
         WGEiwWEBd5gzKwNDzmQ0EEw7GqcX/AEklXEdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708736685; x=1709341485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQKkVKoC62UNhXK21zihqEnfMAgk8ODcwjqvMq7e3Fw=;
        b=vzdrtNXrAHEzyW06O6eES1+W5YewdehGJYrdd2FQlsRfIFFTNton0kvz3e4iZZSIS2
         jtrG+X91MYxOOCQDLeALmojmj45oBed3gZ/Svb+/B+8e703/q+jg7unRFceLyZr5sPQh
         NLT8PtMTqLBARBeKJyYbhrQhMeV3K+EN+rhxK6UuDqN09KRJW7WiapsoqVdCIaemt8IG
         myXg9Oyq3ltodNN88rX6jwdaTa0dJBR9MbFJ0woWiIKEHxGg71drrETvYkVl9RNRi4R6
         szi7maJhqALApIqhxho2EmmQOePcIOJFNYbA4+lB0AYKbSVRheB/OqVDEGo9GQPqfSTm
         Ey5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMjv8jfKP/c/GOL80bNbiy3/A6UMnaoGcaTGEDOz2Hz7SIjwChqV1F6cXM1ksUkp47zDii+pdCNz80sBbVBMwPrVHkpCJ8DREVCmWa
X-Gm-Message-State: AOJu0Yyc3SalLWCbSVhhEA6zGuGILtD5QsQzWSUtZuQ32SESZF1CCBJh
	XoAHPO2+30Z9tiXZWmnDZBjcSn3G8ZEon0t0N6VwMSVjJXooHua1zggi2jId6w==
X-Google-Smtp-Source: AGHT+IG0YdtHF9dbaoGm8JzoVb9eQcmcaxlFTDtLUPRbBpYTUj0A/EB01yqRCMLQjT23cQBmTcoxXA==
X-Received: by 2002:a17:902:eccb:b0:1db:b69a:3fb9 with SMTP id a11-20020a170902eccb00b001dbb69a3fb9mr1864564plh.25.1708736685645;
        Fri, 23 Feb 2024 17:04:45 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bd3-20020a170902830300b001db6da30331sm33159plb.86.2024.02.23.17.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 17:04:45 -0800 (PST)
Date: Fri, 23 Feb 2024 17:04:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Li zeming <zeming@nfschina.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Remove =?utf-8?Q?unneces?=
 =?utf-8?B?c2FyeSDigJhOVUxM4oCZ?= values from vma
Message-ID: <202402231703.8D5E862@keescook>
References: <20240220051830.61099-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220051830.61099-1-zeming@nfschina.com>

On Tue, Feb 20, 2024 at 01:18:30PM +0800, Li zeming wrote:
> vma is assigned first, so it does not need to initialize the
> assignment.

I don't really like removing explicit initializations. They don't cause
any problems and the compiler will remove redundant stores, so there's
no benefit in dropping them.

-- 
Kees Cook

