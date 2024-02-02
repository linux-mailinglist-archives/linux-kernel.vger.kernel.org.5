Return-Path: <linux-kernel+bounces-49673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B56846DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197D228CD2C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749A7C09D;
	Fri,  2 Feb 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idMvPh9s"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D377C086
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869743; cv=none; b=I0UX96UQWFjUza++8loud28RgeOKrxLhblr/D8majde2EaN0c5sgkQOjPtqQhEW10n+JhSkHImhB1f93iYxQqFZ36pAlxZdiz8dMKOKWgMvpY3ytzo115I3OHBH2tB1MHLGpSszvx1iV68jqPpiavddawo8r8dZJRChD8wz1YmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869743; c=relaxed/simple;
	bh=hfTBL9aDECTY+ZjU8pGAAtn2SIcowOf+C1vhc3Y984M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DReyRG1nJTiFwkjo0JJ3IjlYJkIICupSFOTEduBpinLuD3hxI3zv/7XwxJbGKyCII/BvxiTuGdmwdT0ntGNF48tFQkjzwjeCk47zmU+M4rTN2BuIgVUZvzQb+7ErdemuyD+lL9IdCwTbgwaHN20/cJo/7+Se5Lf6fvDwWxrBQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idMvPh9s; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51137c8088dso494158e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706869739; x=1707474539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfTBL9aDECTY+ZjU8pGAAtn2SIcowOf+C1vhc3Y984M=;
        b=idMvPh9sfm0o/YVxqLFUvOiO/yvhDdqJOULxiQl4lum83pgQWjS8Vkzzesmy9qT+dA
         hemPJ0diAr7HHfX1z0dFHvMdzT6hYJZglveRqWzQexfctK7DK1UrteolXddg3Rb583Nd
         XizzmehHA4mX9zJkSLuWAtnkBGFM/OEZo9YDNBE7XEqyr+m2iezBJg3Z3FgOYz663jG0
         Fwk4OvvJA1debG4q3xrA8KYgeC6ISIFpfvXvFZN7QkWPpzJ6wh8cpPoH8an+IDDw7uPW
         Q32HWVNJQKGkva0U9jc7prsrbZB3WKIacNfH3SIXGesEY29AZiu/c16BnGhYyvz7pbTg
         8TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869739; x=1707474539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfTBL9aDECTY+ZjU8pGAAtn2SIcowOf+C1vhc3Y984M=;
        b=PjKrmUbQISEFk/JMTr+dfRM73qn28YBU1/eKJ0s6WjLSvAooDmx7EN94zkBpIUQ37S
         /oNVi1pteQr2XRC2Qk6LusnDpSd6ooNWOB1WUCY/VGU89q6PSGiEhF1U1R8X/dD48Hpu
         9W36kzlRYI3LFl7uYu4uMRIjEOst1erLjT5vaisNTJIXs+pmq/CDjqMGaKWE3rW9X9T5
         pOGdQ0VjL4lCcwfyhblS1a75RZ3oeYa9cie8X3lj3/nt/RKc9WEbL2Wx0kYiRE96m8k3
         SZNwHw70MJxsfsT8p5ZbQMoSUUsfFvPrA3PmvtyKEzLFYG5xxsgz6gDe0ZvjDzsCUyqi
         5nuw==
X-Gm-Message-State: AOJu0YyupUx3kWJTvoBh/j2i97mAhaTXzEqSQugH2gsFPPvL8CNW+6t2
	4E0wA4L7KYfVE+HOBgtQIZLcYGp9xzuwjD47jb9J+HBCtEAYM9J2gNh0+LcsrPw=
X-Google-Smtp-Source: AGHT+IEBsmADrZtTDuAXy91jZj5Ipy9Q00moOwM0OK42zDksQ9zXaQvSN6W2TFULGA37a76clD5gEA==
X-Received: by 2002:a19:f702:0:b0:511:19b1:95b6 with SMTP id z2-20020a19f702000000b0051119b195b6mr3184454lfe.63.1706869739372;
        Fri, 02 Feb 2024 02:28:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWL2xY+EdYZof303ODkqaHz/8jXKXGb/Tt/J3CM9reDHXICB6snDxVlDDNw8QXdd0Vceq/cgmSOIYqOwyhKO60vFa6h+WZVWzEFiNQDAgbRwFkxasbdAcWkEVYkrM2Vb/GBCHXvVfjiRUb9O19ROcxGbQbXe5ijmbUBQE73b8Hd5puAX8UL+6X/M8n2JnVHgu9FmMZzF2g/ihXzmEnBZDVpNyj1p7HHrzkhtNg/QAJS342/7lPVUV2nfEQQLuub7Q==
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040ebf340759sm2202718wmq.21.2024.02.02.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:28:58 -0800 (PST)
Date: Fri, 2 Feb 2024 10:28:57 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead
 of dev_err()
Message-ID: <20240202102857.GC373571@aspen.lan>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240201151537.367218-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151537.367218-3-andriy.shevchenko@linux.intel.com>

On Thu, Feb 01, 2024 at 05:14:14PM +0200, Andy Shevchenko wrote:
> Replace dev_err() with dev_err_probe().
>
> This helps in simplifing code and standardizing the error output.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

