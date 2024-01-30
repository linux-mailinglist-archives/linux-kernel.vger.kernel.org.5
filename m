Return-Path: <linux-kernel+bounces-44325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D28420B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D628B2F42E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDF6A036;
	Tue, 30 Jan 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOx9a39C"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFD67A14;
	Tue, 30 Jan 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608461; cv=none; b=gmDxR4COtE1n9TgPTFCA++PM+CoZjxtFQ3pJrcREC7kq8coMkev2hW++Y8whJckF4zdub7M+jO5BByLkuoKxd/WvVctcfA1l2PY5+UzLMposE6S5Vp5JUTLYR618PZFKQ+Y4kWSRV2hifbBbxxci740aMmCdI+ozVpz60kfSvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608461; c=relaxed/simple;
	bh=tnYqQ70kp7sfoIKQUVxIUH4w26IuosHZfWvYN+VVl6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1kcDE5SnnB5y4NNu/hIncynvcZOCX47Q4ooKZR0uEDbVR6Js4MwRULRiQeZnQPthsCf3GLT55Wn+8QXRpKBiItTPBCi9x1E3MRfbBT2i2kO/77x69/c5kt9F+ixichf8nyIQKkn8/BA9Uxx7pRdkOyk0BKyHJBI5thBNaio4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOx9a39C; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51030667cedso4485928e87.3;
        Tue, 30 Jan 2024 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706608458; x=1707213258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3MyEanSzGBKqYz8rFKTqF+DV7yB/htZJ26fWzOdfAY=;
        b=eOx9a39CAIh1IqbX0Ld6QikIwXhGDlmctGudrY0etIBh74GKH7KDKXJOabnetQxj5u
         aVOFc1VhnLGUOLAAaxSrCqZ1IsXCZSFzLgEpMpXoIgYj3AB9+Hu+KxqLwWh8tQg/3mU9
         nrj639e7XsRQFyPIvwBVTeE+pEgx1/09gZq6JbahFQVPqKq+VldWuKto+ONq1bYOgMz1
         JdgIdrn+uaVbBiFlcMNLyMaF7idgqJDZ3hzxRR+h5OCAR0isV/7X4QK9UQDvM3Emsp5m
         AdsMceZL9PZ93DOJ4MR1Mv/lcjvcpfUdUBNwJdb915KE+675q/t1pCoDWdAA5ypg5eiB
         Bifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608458; x=1707213258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3MyEanSzGBKqYz8rFKTqF+DV7yB/htZJ26fWzOdfAY=;
        b=ufyRkINXrV738o2H88hcxfUiBkKZv23Z6hP/Jue8j8zI5ZIM6fUGAz82qDOm/0CaG2
         OQqFgv5ypYUxWSS4H6D+yN4Ud0gxGSAybw/A7Ava4er9hKzhncqnFX3MoxHsUKeMoVOV
         IGysiQXhIXV1iYum1n6t/rt6p9h1Z5/P2HyJVvOljbzxhlVObJMV3lXyWfj+tjiQ7pmx
         p3/3qVVJXdZi0SP42L/NEQdhkBk2YbKri1FV0q3Ao9kxJOaD47jAmwSuVxVO2oAr0CJc
         +nbh+ogRZmt/Kk1qT7c9iFDs9q9R1hlqDQSzDutreT8NfdB9+4pTK8rzjNZuJv3/WI3P
         Pwxg==
X-Gm-Message-State: AOJu0Yz2HReS72aJ9CPaBeahABB8ScAPbwfHU3tj5x95ccsX8awihyiB
	utX1d4RgLlCL0ogPTC6t9mFcPcEA1g18siMoCaf5fDNsTAt3rMN0
X-Google-Smtp-Source: AGHT+IFGhjGZ4gnkZbgvyF06iywG3e9ro8xFxU7RHOlU1QNpWyr7wiGJp+E9fll+MCjd4KWMpcflTw==
X-Received: by 2002:ac2:5f79:0:b0:50e:ccd5:beac with SMTP id c25-20020ac25f79000000b0050eccd5beacmr4445416lfc.54.1706608457669;
        Tue, 30 Jan 2024 01:54:17 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s9-20020a197709000000b00510ee2d0ce5sm932529lfc.81.2024.01.30.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:54:17 -0800 (PST)
Date: Tue, 30 Jan 2024 12:54:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, lkp@intel.com, 
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: Convert data structures to LE
 explicitly
Message-ID: <cb7f2cozoo5l2dxb5tdgvkxttu7zjzgcjechecoy6jmqi36yqb@znitshltzrmt>
References: <20240130040632.3039911-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130040632.3039911-1-dawei.li@shingroup.cn>

On Tue, Jan 30, 2024 at 12:06:32PM +0800, Dawei Li wrote:
> For data structures needs cpu_to_le* conversion, its prototype needs to
> be declared with __le* explicitly.
> 
> Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> Cc: <stable@vger.kernel.org>

Awesome! Thanks for the patch. Definitely

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index d807d08e2614..327afb866b21 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -129,7 +129,7 @@ struct idt_smb_seq {
>  struct idt_eeprom_seq {
>  	u8 cmd;
>  	u8 eeaddr;
> -	u16 memaddr;
> +	__le16 memaddr;
>  	u8 data;
>  } __packed;
>  
> @@ -141,8 +141,8 @@ struct idt_eeprom_seq {
>   */
>  struct idt_csr_seq {
>  	u8 cmd;
> -	u16 csraddr;
> -	u32 data;
> +	__le16 csraddr;
> +	__le32 data;
>  } __packed;
>  
>  /*
> -- 
> 2.27.0
> 

