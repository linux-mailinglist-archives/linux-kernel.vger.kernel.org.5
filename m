Return-Path: <linux-kernel+bounces-89103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B385786EA78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DD428BA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794073D998;
	Fri,  1 Mar 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knvWd5hA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322C3D996
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325729; cv=none; b=azwwFUwZAfg/oUvGCrPOGhH9rtsfBFEAjhA8r/McTi2gbYVjZ5zHbEetxJcJNaXdhMRwjOnqLTn9SygVi15QQtcA/WePoLaauKWz8rhuDj98Gd3UWo8gLwi5ZRr4GFe9zU/mDZOmCRhsTI2f5hm3NFtTQ3/g/VrNDPLrt85Q9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325729; c=relaxed/simple;
	bh=0fhuNSDX54Sst9GcjEyXWR9CexJHgJMRh1Qzt6BCRkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvQuJ0rzlCPQEZm0ALS/7muE73lyYMGUgTCtdxnwpmP9eT7/NNGIEIi3sxA9tRwyvyrxNxAdhFzVQdQtsh+fjo4cghnoHyov5P/Bi8x8K1y+57QzJU36lnt4cXFbhIuKINOp+RaKv4UzilPrB1lLr+4gEAyUObFOj1TdZT4mJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=knvWd5hA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so9720925ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709325727; x=1709930527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yZ/wvCDmHKXxingPVnUfxmRxohhXJOHZFReqLyClyU=;
        b=knvWd5hAWjzX2Et+7XWtXd2GPBDmPpk41CvVahWLBQ/F6xsFtQ0Za+wsCaURMEbZJl
         8bZLFjTDhhRVVeS0TZW5H7J9iUBMOVqsAUnvdkYiH6o7hyu+liv9IWlaMm3I9EzpIHzX
         OJ9Y587s8inOGyf7hZ6Ly5YkrlbKxsGgvp1Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325727; x=1709930527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZ/wvCDmHKXxingPVnUfxmRxohhXJOHZFReqLyClyU=;
        b=VvGZ5diwKvcPtZ9lVJIEOx8PpN02LLcx/IFVmUwQ6+JUpfE2wUI60+V0hYm6plAWnB
         tHiZc6onGhkZkWozICZyc6PeahpQc52yAVameEo51Ud9AI+b6x/cwrJBn1ucZlr35ntI
         P94V3uEzDDcM1F0UH4uXsIZCDhHjqqcIocLKVzaO2L7qzKb6sNKQ/0whwtc28g3THfn5
         NE0S0OOHAHnlO5H7Xt7GsazL08YyvjO7UwvDRcT/ntQH9xkH6e6YooWPRamJfVTORQSA
         0kKjaLy2WcOCvt9XiCV3Ael7SqS53+erM2xljjxJxOESzVTS2ZO/GLttU/w6mWru+B+B
         kC0g==
X-Forwarded-Encrypted: i=1; AJvYcCXOuKWJKcMi62QLchZDVBNcIR1xKNbFTYbtZyxlIybat0LjgDTdSPHplp7/yyQ0spxz5GbogvOcHot/nB7g4yVj0JJdT+KOMvzfG2Nz
X-Gm-Message-State: AOJu0YyFGFjaoS6SW6sf93NKSv47qQzPEOxF77zrIrn3FU+pkP+7b1Ue
	FZVqu6bOXlHUeVmQ6VDo9bedIkAkmaUWfuKJFY2TQo9dqLx7Zo7p0sptNWr7EQ==
X-Google-Smtp-Source: AGHT+IEdOQY/C0bG3YJv9E/3op7+gpy4qW3uyPZdC3FGAVXEJ3godvG4Ky4Z1kSPJMWEesnqRJsQ5Q==
X-Received: by 2002:a17:902:eb88:b0:1dc:43d:962 with SMTP id q8-20020a170902eb8800b001dc043d0962mr2987376plg.42.1709325727627;
        Fri, 01 Mar 2024 12:42:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001db337d53ddsm3943854pln.56.2024.03.01.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:42:07 -0800 (PST)
Date: Fri, 1 Mar 2024 12:42:06 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: axi-spi-engine: remove p from struct
 spi_engine_message_state
Message-ID: <202403011242.C7C42CCCF@keescook>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
 <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>

On Fri, Mar 01, 2024 at 02:25:18PM -0600, David Lechner wrote:
> The program pointer p in struct spi_engine_message_state in the AXI SPI
> Engine controller driver was assigned but never read so it can be
> removed.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

