Return-Path: <linux-kernel+bounces-117128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFA88A7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4D3231A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA02172BB9;
	Mon, 25 Mar 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKZlqmuA"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF8172BA7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372736; cv=none; b=gS5psmxS13v3Sh4neaMfONAz8I8/gbvfydaJ4UvgZ2jvy5UDenO9+Cdmv9xLx3NsZgJxdhJaImRco1HxhrJ6xLRN1KoOPxtBls822iWjO3+a79SiRidqBJU91N+xlg5r3+xdfFC8TzgwgFMqrut2BiCIBOqQAcQdffL9H5qCoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372736; c=relaxed/simple;
	bh=UYV4nZ7zGyYTe/ns3hNWN+tH5C1unFEO2/U0In3I0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn353i8rsCj65JL3x/wn9T4hNiFu2Tw9j2deC/hBYWcMGrpJ0JxU2KV6LUfIB1svMQt2ajxjblrOwa3YPXSa7mVGxCDYKBrzkWzcO7bP7cmUr5seD1n/5gurSXW+vsYsH9TY0XBdskhVNk0yjS4LYCQFhOrL+fJeHrLzywLe3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKZlqmuA; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso4374247276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372734; x=1711977534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUWQ4N8aQ4jL2fjYy2Ba7XeBW0vWjhzL38iFdr/etLQ=;
        b=hKZlqmuAWi4TVwpIBPMq2bKfDTUIXnSxso+DVvfJ88uLaA/uKva5U6w2pWthP8OhB4
         Xkjqyt9NE6lUr2mfbtBpMT4nidMQfZzzVeu0KC9MPtS+A2+FAhJ/dnGJAdB3uI1APTXk
         jV4LBgGrYveCluijMjSUTsi/nTmLdC6yJNNLK3Rqu0kMUfRJ8S91tqXIvflJZRvQXAKT
         daCTY8iS39Oi5/lnft8j1xSFknXJgPwaWGc3PJjxTEhgoSZYmzO47SQOQF5pcJXjfpod
         MuaH8YkCerM83xtAdq9Pj4/mAf1VARAjwYRJBC5KO28fKMNwvvA/+OCbMcDH5YILJLd9
         FEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372734; x=1711977534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUWQ4N8aQ4jL2fjYy2Ba7XeBW0vWjhzL38iFdr/etLQ=;
        b=Fg0UOpvY6mN1/9FPNNg9bSauLdnC6uxqIEQyDBnNF214vO5c1s74560Kw+yWuB4OX9
         v2jTP0pIit94//5eNw6Ik+ruxzV80wNicbNPqRydoe9NIeou0UZkv3Erwifz/6kJvbEk
         PwQwvg1Svzz2HLbryH1cPiRmo1iTneOEUBLt79tvkaRyQAh2uafc7QdKseR+1f9SrGx/
         awMnPDE7FCWoYJ6eUmhh+fbhSM9L16Vaj7lAZCdz5GS7tAM8RM766BKt+aUpNGh2dfQC
         nVQfZ6xwolU1j8Vj9qUacUL2wFbgebk/ouk936n/uvO5WPST1Zb2vRNpwORu6mWLeNqw
         6+ew==
X-Forwarded-Encrypted: i=1; AJvYcCX23E0AZJ9Ot4hn3/+a+CaHMX5YLW0gdj9khqVnJl3qiWo28m64/339U9pq8oJNGKY69g9Y/d8mZUfSQAnFHDDVdPnLfHDbIQghcei6
X-Gm-Message-State: AOJu0Yw9D7G5pABbBji3S66JFXxvn4A36oH06Us3GbxiLwp3sqxBoiPT
	T3LY9H2jRJ7oN/ztUGbKjs3wZKv6fWKupjj6ia5rGBNxiIiQzjR62bF7LDc5Zmtcy1j+Dy5kdRs
	XKAjj10DZvjJdjsNantWNj1sKqlT+O0zsVrigTg==
X-Google-Smtp-Source: AGHT+IHzTD+eD804dUyrAtAijJPdYapsf0OCnAi6GJ6Hmffr3CDyQqbURkpBgSiWK8ZFwu+EzGqtOUIM1EiwoY+Ah6Q=
X-Received: by 2002:a25:3618:0:b0:dcd:6c0:da64 with SMTP id
 d24-20020a253618000000b00dcd06c0da64mr5239723yba.58.1711372734085; Mon, 25
 Mar 2024 06:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307114348.3643034-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:18 +0100
Message-ID: <CAPDyKFr7hQzOzVXK7Nck9jn=PSyJF652rJfVPVayO0mzGP14nQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mtk-sd: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Axe Yang <axe.yang@mediatek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:43, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 1634b1f5d201..a94835b8ab93 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -13,7 +13,6 @@
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>

