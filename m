Return-Path: <linux-kernel+bounces-112504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F99887A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA0B2146F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE685675F;
	Sat, 23 Mar 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clFd2VtX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13D79F5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233061; cv=none; b=Dg7NfkbYs/1whPlDJxgGDBy41m51dwj+PiIav+ZjiDWbgDZUAhJ7H7T+8uSvRMpUBBhwkYsXyy83NpXYcz6yJJ6UUl64YDnrKJLecTh4GWGeUtMyczAYBAfhLPLZ/PfXUTtO3vHfJ3evwuJuxiFDPPtgBgb+B9Rhkae/J3BjVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233061; c=relaxed/simple;
	bh=PojwwhLQ0f7eE47P++0q9jpP2oeL01I849PctSEwux4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeySB0QvKDqAjxHK6pk4T3UmVuK8nP+M/1jSEtKc+MMMsrXOmO9yu12d5kTpFen+5nDmSyUSMeV0Atz7NkcarwOLMaPyW+obBzGlDkuuk3nqWJuhilTct65DfLvsAlZtVH5dLpjhMaFGAIvcko8riXPUCZQOyKnchESrJ5O2SQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clFd2VtX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a467bd57898so100197866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233058; x=1711837858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pIl9ecoJqRC4Nq8p1VbyTskDTfwqQJ3s481KX+SUP8=;
        b=clFd2VtXaNnUAX2J/Ri/ZIbB8Oy4iGlxR6rmCK6RdSK/lp2OhyJGpIx8H6U3mPsS72
         Aq2+qXZ3SHHRMY1Zp1FvkQP7tvHHBtThorvqUb/ZcuD1pFDGKzcUgM9FR89VZK6aSEWu
         0nAvXO1msrypRvWVOEcX0FugUkgRP9nzYg9rsjAgux2kh7Lac6kLHwiFG3s/YK50ZlOD
         IthtbUrSId8A7KcKvM0fx2m1T0a+SIYHPC9hJXVE61DWnrYL7Hs77aSPCZDhZQNsuvqM
         V6/1xxDHwN0NaCe0uW601Hf2ePrhTU6XTAfawdlu2cZI9uDO5DblxXltilD+EwQ/csjh
         siWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233058; x=1711837858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pIl9ecoJqRC4Nq8p1VbyTskDTfwqQJ3s481KX+SUP8=;
        b=qiP2azZww5YCj8qBvPQAhgTqYU4EfNGycVvk2czlTsklKVoRoodgvowB7myC+fTlv5
         aRe7g04rXSget1bOyYFbraKpPeFmEhc7Z9lICu7wAdfAXinUon72iq4iruOvJImWVGs7
         oMcZVPO9Ha9fx9Ci7YKTznqDfjFSvNxbdZ18JUnv4mHOErdSdYKNOWLS1E6N7ByfUzRx
         IdjXdIOyqOIaFv7V05YRrBPI2Ce18MbUuKJ3YGPRQTQUGwsIOprxhWRswkpk07PpugkP
         fAJOwhrCPHKPIvRCoXAe0e5I5zg3qP9BkWnrqwkTSWrmIf6XHeTdVvDhogkAhM4ARXuY
         fvxA==
X-Forwarded-Encrypted: i=1; AJvYcCXFULhxEvG5QS5lWAgCefe83IKQI4xmne2dvl+/MVSMhds5LckjIIaCB82n3NrAYeeJ8HpL4MVULb5gP3k4gff5yvaf9s6AMFlktEQ/
X-Gm-Message-State: AOJu0YyOzF2UOjhD1bIiNUCyfKeThSbw7SUpT3eMeqpmI7UsyP2285k8
	Gtgwy3Qg3o5CpTuR0AIQkgv+DmsrcN3thwKMHi9eGwHlB2+OZxvGFujILjdq
X-Google-Smtp-Source: AGHT+IHP7VQ0+i5S/9MzwJNbjpPesGT6wzx5M370QsxZ7f+lCQaRj3tAMz8UvBv8W2bdYNZhyT9jbA==
X-Received: by 2002:a17:906:646:b0:a47:366b:21da with SMTP id t6-20020a170906064600b00a47366b21damr1842602ejb.4.1711233058191;
        Sat, 23 Mar 2024 15:30:58 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709065fd200b00a46cf8aea7bsm1348645ejv.30.2024.03.23.15.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 15:30:57 -0700 (PDT)
Message-ID: <9d8f35f6-2d23-43bf-9ac5-c88e4f65609e@gmail.com>
Date: Sat, 23 Mar 2024 23:30:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Rename variable bw_40MHz_en
Content-Language: en-US
To: Lautaro Javier Fernandez Pricco <ljfp@ljfp.xyz>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 outreachy <outreachy@lists.linux.dev>
Cc: linux-staging <linux-staging@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <Zf4fhSomoYzCE4gW@ljfp.xyz>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Zf4fhSomoYzCE4gW@ljfp.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/24 01:17, Lautaro Javier Fernandez Pricco wrote:
> The bw_40MHz_en variable triggered an 'Avoid
> CamelCase' warning from checkpatch.pl. This patch addresses said warning by
> renaming the variable to bw_40mhz_en.
Hi Lautaro Javier,
Checkpatch is wrong with this proposal. The offical abreviations for 
MHz, kHz, GHz, dB and so on can remain as they are.
This is easier to read.

> Reported by checkpatch:
> CHECK: Avoid CamelCase: <bw_40MHz_en>
It is not required to add the name of the tool who found this. Much more 
important is a good description why this change makes sense...
For example:
.. to shorten code.
.. to improve readability.

Thanks for your support.

Bye Philipp


> Signed-off-by: Lautaro Javier Fernandez Pricco <ljfp@ljfp.xyz>
> ---
>   drivers/staging/rtl8712/hal_init.c        | 2 +-
>   drivers/staging/rtl8712/rtl8712_hal.h     | 2 +-
>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
> index 1148075f0cd6..efea4f97488c 100644
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ b/drivers/staging/rtl8712/hal_init.c
> @@ -98,7 +98,7 @@ static void fill_fwpriv(struct _adapter *adapter, struct fw_priv *fwpriv)
>   	/* todo: check if needs endian conversion */
>   	fwpriv->hci_sel =  RTL8712_HCI_TYPE_72USB;
>   	fwpriv->usb_ep_num = (u8)dvobj->nr_endpoint;
> -	fwpriv->bw_40MHz_en = regpriv->cbw40_enable;
> +	fwpriv->bw_40mhz_en = regpriv->cbw40_enable;
>   	switch (regpriv->rf_config) {
>   	case RTL8712_RF_1T1R:
>   		fwpriv->rf_config = RTL8712_RFC_1T1R;
> diff --git a/drivers/staging/rtl8712/rtl8712_hal.h b/drivers/staging/rtl8712/rtl8712_hal.h
> index 66cc4645e2d1..3df687fce79d 100644
> --- a/drivers/staging/rtl8712/rtl8712_hal.h
> +++ b/drivers/staging/rtl8712/rtl8712_hal.h
> @@ -85,7 +85,7 @@ struct fw_priv {   /*8-bytes alignment required*/
>   	unsigned char rsvd025;
>   	/*--- long word 3 ----*/
>   	unsigned char qos_en;    /*1: QoS enable*/
> -	unsigned char bw_40MHz_en;   /*1: 40MHz BW enable*/
> +	unsigned char bw_40mhz_en;   /*1: 40MHz BW enable*/
>   	unsigned char AMSDU2AMPDU_en;   /*1: 4181 convert AMSDU to AMPDU,
>   					 * 0: disable
>   					 */
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index bfb27f902753..0e5b07ad5a8f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2331,7 +2331,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
>   		}
>   	}
>   
> -	/* to disable 40M Hz support while gd_bw_40MHz_en = 0 */
> +	/* to disable 40 MHz support while gd_bw_40mhz_en = 0 */
>   	if (channel > 14) {
>   		if ((pregistrypriv->bw_mode & 0xf0) > 0)
>   			cbw40_enable = 1;


