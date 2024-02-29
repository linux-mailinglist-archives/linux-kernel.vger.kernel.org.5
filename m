Return-Path: <linux-kernel+bounces-86746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4D986CA22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CCD1C22243
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9B7E58A;
	Thu, 29 Feb 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="eixID0yb"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259127E564
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212878; cv=none; b=rl4KomRl14Nvm1Sgf3cIqIO7M4jMUQj3+HkpeBvlc04lxcjzR+gplldhp06yi0JDABq7P6AlyMhsHAf27hzeZWqrDBDopZFxW9xdA3PAWbivTM1dfUEZldYDByUNCf5btvVII1AqRH2sne59EoAdyFeQs51zG8c/D7Y2FyIpYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212878; c=relaxed/simple;
	bh=G7/4ke5O1foODR/W5e+5EmR5toRY12nyoSLmRsgk074=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr0EpnqYjtwE+Of6jT4qU+qy1GZvQf5fQlp2GJMezq/cRtp4LgoI6f2MDXIptEqMvLxOrGLBWVQQR1z2hJRbtEOJLLXckYl5nQeZucc+TF+j73ZKznmiIRbrdLiDqk1idMKHtGga+w4wEJE/0m5OQLUcTEaIAMIvu+qe2MV209I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=eixID0yb; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so40991439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1709212875; x=1709817675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtagWCDHvNpjUWPNIWwFp6OZCKzLwBZUxwMg6aAtqwY=;
        b=eixID0ybVPe2tDySiIHQlXQhgl816W40i+fM+YnlCTErY9T5UyRgvL4+SkU+Andnzy
         iSt63qLWzBYhLTSTn2xz02KpTZZUxtiFNOc8Sepp6DW+2r24DZaEmffm4+qONHktdAkr
         OKAGZb5d65TWPDwkYslIFhGB8rYCrbNSwJKuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212875; x=1709817675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtagWCDHvNpjUWPNIWwFp6OZCKzLwBZUxwMg6aAtqwY=;
        b=pq+ZH6y/HrsxTKU27eWLctJzbV2vILgwslhaPkpYrL3FJrVKgEzOkrwcQtB0vW8cKQ
         QjQEe1pqB45swF3IUEv5h3JwPMqsU11LfxzsMTKq0mWjyVYIn48n+7jRCbkseQEK28jh
         jOiZsPIaw+AEqP0DBqQI2woiLEcMC3d4xq485CF2EHGRUiEyxkyRnLbpDn1PyZr2f2xV
         tGffckPdDJRmTrW8pXRoPHWAESfjKDqvtu+17VlzSHPFbh9Yg5T19DlSX4BTky0E7dIT
         Xjr+T+3k1dY5ZqkJYp2QEmiI62SWX1oAxyKdlY3AXcese9MxDnMPsGvj5w7GXZKtW6Y0
         8+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7EBoYIJ2+84KTedFEbykgbl1BRIA6KTYhaZJGoq2xcWNrwf19/cm4/c/YaN/QzalZF4PnA1BVLVy84Q9Q+zQyuvBTsZk5pJ2lIwSL
X-Gm-Message-State: AOJu0YxgsNVMS0wGGRgpBRYO+OkHdDl9KUX04ScscVBi+iXLLSXzmGxH
	jqz4be2Oq74HvFHjBn7ocC+7ATRk0Yf63PMtPV2wkHR4IRU8jVHOpZ/bub0WnA==
X-Google-Smtp-Source: AGHT+IEFbqax2urpItdGNEfcpavfE09uSNM65EilqLl0cVmvgwRkZ6IVp2f1hsY4s2Xe1Bdy5CiaqA==
X-Received: by 2002:a05:6602:2495:b0:7c7:fd21:78c0 with SMTP id g21-20020a056602249500b007c7fd2178c0mr2084343ioe.12.1709212875240;
        Thu, 29 Feb 2024 05:21:15 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id d6-20020a056602280600b007c7a55ea0b6sm289555ioe.48.2024.02.29.05.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 05:21:14 -0800 (PST)
Message-ID: <f7b36055-a710-4d57-b952-33431876e221@ieee.org>
Date: Thu, 29 Feb 2024 07:21:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] staging: greybus: Remove redundant variable 'mask'
To: Colin Ian King <colin.i.king@gmail.com>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>, Mark Greer <mgreer@animalcreek.com>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229120541.219429-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240229120541.219429-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 6:05 AM, Colin Ian King wrote:
> The variable mask is being assigned and bit-set but it is never
> being used apart from this. The variable is redundant and can
> be removed.
> 
> Cleans up clang scan build warning:
> drivers/staging/greybus/audio_topology.c:764:15: warning: variable 'mask'
> set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

This is a reasonable change, but I don't know this code that
well and would like to hear from Vaibhav (if possible) or
someone else whether they think the mask value *should* have
been used in this spot.  It doesn't look like it to me, but
I'd like you to get a second opinion...

					-Alex

> ---
>   drivers/staging/greybus/audio_topology.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 08e6a807c132..5dc4721105d4 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -761,7 +761,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>   {
>   	int ret, wi, ctl_id;
>   	unsigned int val, mux, change;
> -	unsigned int mask;
>   	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
>   	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
>   	struct gb_audio_ctl_elem_value gbvalue;
> @@ -802,7 +801,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>   
>   	mux = ucontrol->value.enumerated.item[0];
>   	val = mux << e->shift_l;
> -	mask = e->mask << e->shift_l;
>   
>   	if (le32_to_cpu(gbvalue.value.enumerated_item[0]) !=
>   	    ucontrol->value.enumerated.item[0]) {
> @@ -815,7 +813,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>   		if (ucontrol->value.enumerated.item[1] > e->items - 1)
>   			return -EINVAL;
>   		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
> -		mask |= e->mask << e->shift_r;
>   		if (le32_to_cpu(gbvalue.value.enumerated_item[1]) !=
>   		    ucontrol->value.enumerated.item[1]) {
>   			change = 1;


