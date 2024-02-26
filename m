Return-Path: <linux-kernel+bounces-81156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D306E8672FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DCEB2280B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3EA4E1D3;
	Mon, 26 Feb 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxRNG7f7"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755694E1C8;
	Mon, 26 Feb 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943075; cv=none; b=VAJ0KZHG3uJACeApaTHg/F+5h+MgDyz6wzVLbSnvjxRCEoEVuxMx346FEQpPjaXUZgGbjAdcF4wqCogoca1+thSQ80hmpoP1OWti2ABxPNjeNtBE7WoTsGnDV4JT8jDrLBCXCFvdR+XPJR6VAi6PYUW+BaSp2SNUR6ssZg+hK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943075; c=relaxed/simple;
	bh=pESL1qSJf5euaSX9jLXoCFrMOPcz0jvgu2n/nLLwJ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY13lZiJKpvxjC5uIS+IbO6lns+LP3F4dJbYFl/1qrqbNMrJ3DODENkNLD9GFySPJktKq+jqTzjUYGrDq2UHyGbUq3oegRzrLIN+FHlhHjs9ZuZv9KA2zOPDIO+mexkUELZHc13K1OsuOkz2J4vJbIZT7l2O00qqgUmxqUB2FRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxRNG7f7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51197ca63f5so4357745e87.1;
        Mon, 26 Feb 2024 02:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708943072; x=1709547872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3YYIxyO62mYogcdCUBdDIF6VWzDuO2ZuKHtLO17Pd4=;
        b=GxRNG7f76SDBa6o886eN0dyhdzFgz4OyzaIQXhCxj7C0uEL6IwTctRBwKRUngnLqiT
         t8uJNKBNweKK6GFnp6cPh/nilva+E+a34yXDrDAKy/qu2UXXfSo+Wi9uJTfMjAaPWiqk
         1lmTo+YSEky6Sw3FCjtnImsLPoYMuZZjB3Bov19pWD3OMjLDORqeD0BDnUBHluWTJoj6
         oAU5mtNjKpraSx5GZQuDsSFs8+Mfp9DTEm3HpUQIywwVY0q+8apUnBb00UtHKC3fWS8x
         oi/CLEywaJeRUXF97KhFoF+Qd+S6k21LSDAasNHCJ5z3TgckG+ZYfMJuTZSXmOQwWXca
         KvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943072; x=1709547872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3YYIxyO62mYogcdCUBdDIF6VWzDuO2ZuKHtLO17Pd4=;
        b=esOLROLI5WAV//oeCDZK6AC5w72GhWpo4KykT21GULsTFY9DK2fjuc5g/5t+R+LOn+
         g8Mfymhh0FbdMmyy/lxkZkKRv5OfuZzbiS3TaHuaT4iuezde0irqpY44o6v3cHuI1Mcl
         Tva6zHcrNoARM1EEZMaaW/Za+mavYijcEI9R9hhq7FfiapdriZ9EDFfevEce4i85UZbI
         HxVZ9Stp1MM7NuIQEbJcU/UgaA0qQQGGaRX4RfglKzpsu7lztlxYNbKtpYZDNf8JvXcY
         6NXnVlednTRdl4R/zRE3E+1ezmdgQSC7RIcwNTL4ftREr0ncJ04x8vuctrVs8UqKPkBR
         5aHA==
X-Forwarded-Encrypted: i=1; AJvYcCV+YrcmcpufkV6LM6bvpJOLh2LngjF8CRtbDM1YsTLCZ020WFLJ2NoQPh7jntBKiIuVD19eqU6z9ekimhLz0Wm5OeTwHo57e9BJH30Y
X-Gm-Message-State: AOJu0Yycv6vc8gScMavUpPnYJm66utDGOoDMouLSsSmJL8zHwsLdRY0u
	PZ17LFSxxn/y6dbTG9KKNWXnNsfO80wLGXk8jzOlo02H3/fkj0MCafO+vCJy
X-Google-Smtp-Source: AGHT+IFO1qm6qrvV4RN1D0OPylyPVVl6gLwLdkcPJx3lGllCprzwhQXmWHSbkAKWk0/6kEbJzOl6qA==
X-Received: by 2002:a19:7619:0:b0:512:d907:3161 with SMTP id c25-20020a197619000000b00512d9073161mr3855938lff.66.1708943071372;
        Mon, 26 Feb 2024 02:24:31 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id br35-20020a056512402300b0051186a82fc1sm789142lfb.171.2024.02.26.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:24:31 -0800 (PST)
Date: Mon, 26 Feb 2024 13:24:28 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] bus: bt1-apb: Remove duplicate include
Message-ID: <v5lo4g5mp2d6y7butvf7snlnbf542rpdmyacmigvdqljbrdq23@sfuludqikigx>
References: <20240226020927.111091-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226020927.111091-1-jiapeng.chong@linux.alibaba.com>

Hi Jiapeng

On Mon, Feb 26, 2024 at 10:09:27AM +0800, Jiapeng Chong wrote:
> ./drivers/bus/bt1-apb.c: linux/clk.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8312
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/bus/bt1-apb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index e97c1d1c7578..595fb22b73e0 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -22,7 +22,6 @@
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/time64.h>
> -#include <linux/clk.h>
>  #include <linux/sysfs.h>
>  
>  #define APB_EHB_ISR			0x00
> -- 
> 2.20.1.7.g153144c
> 

