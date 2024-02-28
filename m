Return-Path: <linux-kernel+bounces-84717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDD86AAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96A91F2474C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2872DF87;
	Wed, 28 Feb 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxkF83T5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7515C8;
	Wed, 28 Feb 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110873; cv=none; b=UW6VxbpCwslCzk4Cbqj+hz8aaN37tGUP6TfXwUQO5SN9DCW4aUSEvaPA/ZlNcwCUZoPYKAO7lgvjn+atf701J38XgWjsjdS3J0Pd5Ytr+UlWZXTx0UMEMjcdXp2M5zSDnimVwRBZtf65z1aNZBtNivS6pOYq2Q/W3veSPzI5lag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110873; c=relaxed/simple;
	bh=St2mI7xVXbL+lA9fBOBoKS5cIK6Zgvtjh49RUEUmf/0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RTVfAAXPSOXgskcz7xYTufPANZG6WEyDWTEUUYT2tl/MkbaBCXEFL+AOA19JP91sqN0clqavqusJZZ4CFKuZI4hHTeiyz458lYYqAXsiF+H1jX/yVRCo6KEdEhXdhdygJsjdlXxo0DnwV9vkq/c6i1RY0T1OL5kc+LzjqKt9Y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxkF83T5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d24a727f78so72830271fa.0;
        Wed, 28 Feb 2024 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709110869; x=1709715669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUvDMhsl6oy6IveJwxumA9llbNHU87BvCC54vL0p+Cc=;
        b=gxkF83T5BHrS5USGqD60dmyCu2wYltkf197eVc+oSy6HcCVljEz55DCXvvR5JoAoQh
         zGV2MGo9cHFJltV2dXDAeTKjjLWC3BLuquRMOQ1JN97ux3SyglsIfRFqOTeCKBT7KfEx
         MRYfD2Zi+pR/dWr382N8WH8zeWhQ7Oz7Ga2YrKHxcWnkbO2UHhMIhugQ5pUylbSD6u3f
         lBroNuv6Um71sm+jRV8puwen/pdF6RxoHJ+hOwPti7KS2MySIOh6j/1VDUiucWkxVAhE
         60dbjE7Wr/4i1KTnlO+9lGU+8ajspgEfjrFMlsvSY2SYkTJ70+bHkj+bVm6zTrrqKsJN
         pv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709110869; x=1709715669;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUvDMhsl6oy6IveJwxumA9llbNHU87BvCC54vL0p+Cc=;
        b=cKqaiHW8DGeBi7y3wmYv6f7AK1Eutp7bxriZ1Niw+dcL99/U0hK3ybGxwc7AG/RIjl
         qlQzAF1fHwsQvsxVaxVbTSX50m3vud35JPh8kis+BNMJuWcZBGGEZ1ERqWgq6oL+eml8
         4P48Ru7iz2y6khsQ3WRiHvS3KfU7AYNaoMOKO5F2axw+y3TXQqCfqRFB8Zj0c63EEoAQ
         0AAbLoEjdvu2WbbmdkewGLRJD9wFZAz9X/WPejeQ9Xauts1i9ReefwerM+fMPqzE697k
         GwsUm9pN3Wk5kvUwU4c7v5MxPNRNkwFNGPSx6S1BfNj7Ag+L5MXHCVV4Yant7wISdAKj
         A8JA==
X-Forwarded-Encrypted: i=1; AJvYcCVcy/LS0AHAmFTC+QoOnUUb0CP9aiDPC+H/aCUrvs/9iKs8A4SsHQEQQVFepXhAYRdg/KWzVwarC6WlAEVyHAoGP3xpgQmPNzHXL/CTPSx56YSNkGpxA2jTt4RCVhhmUun1
X-Gm-Message-State: AOJu0YzeuestyBzTlE+HJduR9GcTM8L020XUcs76LFvVK9IF4HLkrW+a
	ASpSbsue7aBtwO581DLugQNB1I0RBx0kGnYEWmbtDSg2iPw+ZZF7/3eDpLiZ
X-Google-Smtp-Source: AGHT+IGDK+6JPNhwuBcCySabqFiOhYLZspUubETKjlF5ohYMgyVV35TL+E10gSCIvF3N8omTlqvSPw==
X-Received: by 2002:a2e:b8ca:0:b0:2d2:4028:9799 with SMTP id s10-20020a2eb8ca000000b002d240289799mr9388126ljp.29.1709110868494;
        Wed, 28 Feb 2024 01:01:08 -0800 (PST)
Received: from [192.168.1.105] ([31.173.85.77])
        by smtp.gmail.com with ESMTPSA id s24-20020a2e2c18000000b002d11c91dbd9sm1479140ljs.61.2024.02.28.01.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:01:08 -0800 (PST)
Subject: Re: [PATCH] usb: xhci: Add error handling in xhci_map_urb_for_dma
To: Prashanth K <quic_prashk@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
References: <20240228083343.3101303-1-quic_prashk@quicinc.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e4f87b6b-4561-8058-3449-2ff9086c81a4@gmail.com>
Date: Wed, 28 Feb 2024 12:01:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240228083343.3101303-1-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2/28/24 11:33 AM, Prashanth K wrote:

> Currently xhci_map_urb_for_dma() creates a temporary buffer
> and copies the SG list to the new linear buffer. But if the
> kzalloc_node() fails, then the following sg_pcopy_to_buffer()
> can lead to crash since it tries to memcpy to NULL pointer.
> So return -EAGAIN if kzalloc returns null pointer.
> 
> Cc: <stable@vger.kernel.org> # 5.11
> Fixes: 2017a1e58472 ("usb: xhci: Use temporary buffer to consolidate SG")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/host/xhci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index c057c42c36f4..0597a60bec34 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1218,6 +1218,9 @@ static int xhci_map_temp_buffer(struct usb_hcd *hcd, struct urb *urb)
>  	temp = kzalloc_node(buf_len, GFP_ATOMIC,
>  			    dev_to_node(hcd->self.sysdev));
>  

   I don't think we need an empty line here.

> +	if (!temp)
> +		return -EAGAIN;

   Not -ENOMEM?

> +
>  	if (usb_urb_dir_out(urb))
>  		sg_pcopy_to_buffer(urb->sg, urb->num_sgs,
>  				   temp, buf_len, 0);

MBR, Sergey

