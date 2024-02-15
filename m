Return-Path: <linux-kernel+bounces-66950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9368563EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FEC28AE78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370812F58E;
	Thu, 15 Feb 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYvDWg3Z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0612B162
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002198; cv=none; b=kyIVnBI9i52jI1wZDEIXW/7nkyeLJ+zu+eatZmTVd9j7m3jjVI5qYZs8bnKEpqlZqrPu/pMA32ui7SPtGEL4+JAsq+1U9mgOz4tfQb/pFqf8keUZ5wEqevzNHKDibCiLMbpfJFMHtdYB5sdzzOq05p42qT0AlqL0GrEQyv1tHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002198; c=relaxed/simple;
	bh=wvApUvfsPpkye9qYeykoXI5vL0JTgpBbmDj74OcOvPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZqAkXucRauy/BpyTMmkf2A5y12v7QQOgza/6sTAJ0mBxKQOsuTHdDX7DMsy1iDLbv5EUPfaK+SMb3M/vio31UCljbznSWR58GijO92TE9xvfS+rFkyt7DIo0lHtxid4hRlmQDOEQvuGDROKDsfho5o0JZ96tYPSi/AZdx2L0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYvDWg3Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563b49a0f44so866094a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708002195; x=1708606995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8gYmBFcHw+PMY96x5bP3A9cd014PWA82CxsQ116n3w=;
        b=QYvDWg3Zh68mLlYVJGdedlSaH+gS7hQjSAzX5xwWdnVFqgNsu0bMIlkQE8yWZ+Fxkq
         T1/xmmQ0w1xk8hvoeboPJ/g01GDSrseTvJhLns2TJ+kVBsLJUUdRtIph1IjlfQyLHxkL
         xDEKZ/ZaIDRftfjo4uXSmthtVpebqqgc8OpGpa4S9gK1vXZ6KBjJKKkCujqXt83L+3dG
         XPEfhuUWb0uy1jCApWP9kUSii8hD4kUiODHUykKU9vyH3KEVSSpgaGUBnM7O7uWf76Wn
         tskSaLkMRo63VU62l9I2tAN2nv3buWT9mNg+PeyG8+/x7Egxn1WGmaLSMDavL1iuTvzn
         DqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002195; x=1708606995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8gYmBFcHw+PMY96x5bP3A9cd014PWA82CxsQ116n3w=;
        b=CuJoSANthOOrOAc2/Fr1qSgjYxRBuJfdqkm6hyDA58+5mWxfE5oBMlCmkPhZBVMokn
         uI/INqZmOAWffQcke1sPhKF1ukyFwTPm4sz4rwm/hCzdHPrMCSDr9lwHpKn0dpp1okal
         XsDFthoOOZOVQjqsDIqobwrRNeBHI3FqEAMpZ9nUIclz+5K2fwqz22ZSz43Q9H72z4Bg
         Cyu+zDpKknyz56wiYTQXkVbBqx084s+65OQ+p2GUqcUI3w94Zbbnu0/A4TJaW4uwzSpp
         XW/Bgi97WRFVqLZmez8pKbYt/vCwHkpc/bCES66W+7Wi0EikGYM2AQ2ZFIqghh30DrG2
         pB9w==
X-Forwarded-Encrypted: i=1; AJvYcCU2laeCx2SMo6eF7xaVXzNSTSucDwif2j9v3KCvO1DoWWwvL8chpF8NVeMDhP7tD77zQ/I4ydDajVxB45Duaygu9cc7EfC6N5QdUBYK
X-Gm-Message-State: AOJu0YyMk9fQVGy1JgyeZ3mjfZ8S0QOV3TiXjM1p8e6utV0vTVJdkm0O
	Ry8LHlxNwDmMlndUdoiYpmsH/x74nJFOuULYm41v2aMnt4C4CLUIoEQbvoqn3sP99iwrKfSeqim
	c
X-Google-Smtp-Source: AGHT+IEb+RndYySUvLziRX7ktIL1fHsO13e6I5nTzg2PeebZxffYPxzn2nhNVF5dHx9ZFPWdwJfmzA==
X-Received: by 2002:a05:600c:3591:b0:412:41:bb3d with SMTP id p17-20020a05600c359100b004120041bb3dmr1648825wmq.3.1708002181939;
        Thu, 15 Feb 2024 05:03:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id fc10-20020a05600c524a00b004120c78fc39sm2387969wmb.3.2024.02.15.05.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:03:01 -0800 (PST)
Message-ID: <00d0beb5-6800-418d-be1a-89e32b867fb3@linaro.org>
Date: Thu, 15 Feb 2024 14:03:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Drop spaces before TABs
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <480478a53fd42621e97b2db36e181903cc0f53e3.1708001426.git.geert+renesas@glider.be>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <480478a53fd42621e97b2db36e181903cc0f53e3.1708001426.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/02/2024 13:51, Geert Uytterhoeven wrote:
> There is never a need to have a space before a TAB, but it hurts the
> eyes of vim users.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - Drop change to removed drivers/thermal/st/st_thermal_syscfg.c.
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


