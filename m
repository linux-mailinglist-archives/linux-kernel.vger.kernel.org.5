Return-Path: <linux-kernel+bounces-69245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F77F85862C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B082F1F2220A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66D1369B3;
	Fri, 16 Feb 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5coQsS2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFE1350C7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111730; cv=none; b=VHL7r9tKbdQvjbslGTC8j60N/0EQompy1YRKkalikMTRb+nj9Pb69SteruuzP5TFwnf3bwK2jdRvHt5ALa/BH4c8txHmj0uMtS3hWG6D2Q38TmR2uFn8E0mEkCGOB2F7SzdGYSDtBZY4PnU9+nlk/EGGOcaw+BN9pcuq91sUy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111730; c=relaxed/simple;
	bh=lTlPLpCMgZP3J5G2JyWCxdrQPIx57yknIxy+xzBAuiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWlBK3CfQCpUQVTsFRTHSjRGfeNJec6LxrZWJcLiEjxh9ywsKuhK7cjNeqHY6MV8e8KzAq0B5AgbdNZhxDtJ1qOJ82ejcOlF8nqCxixMVdag1IE/f/iEeGlV/xN2P9/yFKUS8f6S2Dq5N102d4/nOaOR9SA8wOieipcW9QF2dL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R5coQsS2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d932f6ccfaso21618005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708111727; x=1708716527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8WkqZPPSvCs0Xbxi28cm5IAK+G5lVBNtuRMx7zqp6A=;
        b=R5coQsS2C1Vv8ORE4KkSAKbL7np+3B8cvptkWAn6ATmF49khFocLjmmzWjUCXVQf3G
         ZdQ6Wtk/WC1PU1DLBzXClJ9LHH2dfjOtssCJVm2vKJRP36783uvFJcvruU7v6J/5mRZK
         UHRscOq1hh9o2QadEgfeFLQFCJ8F6J3PiLlzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708111727; x=1708716527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8WkqZPPSvCs0Xbxi28cm5IAK+G5lVBNtuRMx7zqp6A=;
        b=XjkwOrUfmSIpWZwHZAxO4HIItZr/NZSZOJHB4AEPYGQc65xSJPosUYugAkpQh+vCwL
         Mwpq5ZhMqGw6HjZDr0lRV3JAGZ20Yqc1D8zbVfIEpprrYXiDz3g37fnqs/haqDAiAVJl
         cvibhNEoZeNwXin4yt8vMGAXRiPEqAXYPUFeuxZk38rxDmlVNFQiy5UJ4bE0ytiFwCnX
         Qu2Y2QMTS+f5FgMKYxxIi9uWcw6llSDSuZ1ad+MW+Db5d3xiYYo6AoYNIe9dNc9ZGqfR
         W6TRPA6fkGXNw+dUddU6YSLdtdbzSe6IO1zlq8dNV6cixmrSIx6/rES9mwqgaDk8rLYs
         me2w==
X-Forwarded-Encrypted: i=1; AJvYcCViltNNEpAn6H5eNDgGhUeehHWhJwVQRARNxgeoQPuHH578ik3Lz7j1AR3cTbY44CBCarPSIjYD0USs6IeT/j77+VBTXiYAtJ7W/DD9
X-Gm-Message-State: AOJu0Ywuc4hUzMVxrGXdwsqVfDn87Vie2qZ38FclV82BnRqE7t5PpXyo
	9PTA+jxu5Umg5iXuaBDc+jd2xKf3vMIDORsv2olsCZ2PDyXbNlAQQ1s1UM2fmSpv2K7jWqXIqT0
	=
X-Google-Smtp-Source: AGHT+IHfhAKa5A+x7ys9ADrXomzy798qL2jSR2XKtHRV7rpOOWmyF9ZLqe3tbjMMeK5txf1tPbVmkQ==
X-Received: by 2002:a17:902:ce90:b0:1db:c1d4:8151 with SMTP id f16-20020a170902ce9000b001dbc1d48151mr348857plg.49.1708111726925;
        Fri, 16 Feb 2024 11:28:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001da0a698095sm205675pld.282.2024.02.16.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:28:46 -0800 (PST)
Date: Fri, 16 Feb 2024 11:28:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Message-ID: <202402161128.21EA3F8@keescook>
References: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>

On Fri, Feb 16, 2024 at 09:14:27AM +0100, Christophe Leroy wrote:
> set_memory_ro(), set_memory_nx(), set_memory_x() and other helpers
> can fail and return an error. In that case the memory might not be
> protected as expected and the module loading has to be aborted to
> avoid security issues.
> 
> Check return value of all calls to set_memory_XX() and handle
> error if any.
> 
> Add a check to not call set_memory_XX() on NULL pointers as some
> architectures may not like it allthough numpages is always 0 in that
> case. This also avoid a useless call to set_vm_flush_reset_perms().
> 
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Yay! Glad to see this happening. Universal __must_check for set_memory_*()
starts to appear on the horizon. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

