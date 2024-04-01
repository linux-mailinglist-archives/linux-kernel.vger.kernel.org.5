Return-Path: <linux-kernel+bounces-126695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD7893BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8D91C2137C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5653FE4B;
	Mon,  1 Apr 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fz8bYd9L"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391B3FB1E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979811; cv=none; b=Pr0sE8lJs0SF3OkK6b9RaQ6k9pVY9TnFdndfcvd21v5ZQh/yA4oSytoEHe6EnliNVO7aj2ugaPKRFcKw7HV8tS+D+dnfeDSLsz3HvlmKP5GusDO/vgwui35WvUUrLs3j5UoZYKzlF5U7LWNYrlsLDw2hNf//UM3DA+LHpgZRyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979811; c=relaxed/simple;
	bh=z1rTJoyh3kQXvkGEjaAw0+Naoqr1iRiwfgcJUP92xuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYDoY0ZSALGMgNcxBnkUsieVtjn6PJBD7oFuVl/mkYPeUdDS3ArouPe+uE5CggKHApfLIzIjqgxyaIH3CbFlmT5cdGw+Dy1U5QP/u88esMvx7uJPaflcKI0pvAx456BcDpqdEw2/qmM/SyxdGzJg7O2EtspHXch8BftwgLzJhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fz8bYd9L; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78be555ff94so32448885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1711979808; x=1712584608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIsXdWS2cI3BbLNz71YpvwQlJrZcsPNHY/5w7NcKrRM=;
        b=fz8bYd9L+JabwXldZE05Yl/j+Oi4XD6t+j/8TGsWhXDXp+AWmtP8g9sqz+CxCDnTcL
         1ur6FsCnX09mjwkXo1Gfm/fg08UOpPSWZhA6PczDg1MvneLrHgnldnIHwb/1qCCgAdIU
         mX0ut28tK1k/L/e+r0DVRX29MkCHHbVXeX27o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711979808; x=1712584608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIsXdWS2cI3BbLNz71YpvwQlJrZcsPNHY/5w7NcKrRM=;
        b=bTAuNKiui7rH6gLh6VtnL/4TMRUgs5NfwPHo32yBijNgid8ZL2LllTApKcis8Vmvkl
         yrqC44xchauHhiI61/J2g6lrxqt79RDofLA76I6bhHUZg4o8Uarawx2P0AyS2L0zoRtM
         Gzq+c48oMXl6VycpXRRLcl3GIf37KnNN6G06xRzhb0hiJd3HWDbRMwoMgilj7OKDrYad
         KkdLrGK7zyErpmJW/LRTBC2l99RaIIX5ozlgaSDJV0k9XIKTqu/HR6EJ8QlJruG++Feh
         QKdtHqMipEHSEOIFe5pj0PQwtwuoCCscRiYLU5YIMAx7hSbt6/n7rKVHV4QGFYXzgxk2
         TJJg==
X-Forwarded-Encrypted: i=1; AJvYcCXPo7pnbgryc4ioHekJKOfLzAp63dMaEspB95M9ONI2eYCtzBplQVE2/w2YNrbKNVf6Do+u0DpZ8tXiuenlKPCD3CJ/Js2iKtV1MkQx
X-Gm-Message-State: AOJu0YxeZAzkGJLPHyXNpW1mvME4XAGyRF8DFfyo+RBOvWRIDwEjMXlx
	v33LhakrZSlEHO7o3ivbjf/G8Q9dPRRAtj+tQk5WJ21v2WAnlxDFV8odgyxKJQ==
X-Google-Smtp-Source: AGHT+IHpdiBgFqnnvm7ZVM+aGDyiKaOSAKL0YQHlrY6jrtN7YVvCa34VaG+vG8E4TcajtXcF8JkbXA==
X-Received: by 2002:a0c:f7cc:0:b0:699:514:3046 with SMTP id f12-20020a0cf7cc000000b0069905143046mr3624538qvo.15.1711979808249;
        Mon, 01 Apr 2024 06:56:48 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id s2-20020a0562140ca200b006990539c0aasm1418385qvs.137.2024.04.01.06.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 06:56:47 -0700 (PDT)
Message-ID: <c03b8113-e1be-4cf3-a85c-43de15163ab1@ieee.org>
Date: Mon, 1 Apr 2024 08:56:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net: ipa: allocate dummy net_device
 dynamically
To: Breno Leitao <leitao@debian.org>, aleksander.lobakin@intel.com,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, Alex Elder <elder@kernel.org>
Cc: quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
 dennis.dalessandro@cornelisnetworks.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240328235214.4079063-1-leitao@debian.org>
 <20240328235214.4079063-5-leitao@debian.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240328235214.4079063-5-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 6:52 PM, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from the private struct by converting it
> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> helper to allocate and initialize dummy devices.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks for pointing this out, I didn't notice the earlier
discussion.  Embedding the dummy netdev in this case was
probably done to eliminate the chance of an unlikely
allocation error at init time.  It is not at all necessary.

I had to go find the rest of your series.  If at least one patch
is addressed to me in a series, please copy me on all of them.

I see the dummy netdev now gets "fully initialized" but that's
a one-time thing, and seems harmless.  But given that, shouldn't
the result of alloc_dummy_netdev() also have a free_dummy_netdev()
(rather than simply calling kfree(dummy_netdev))?  (And I now
see that Jakub made a similar remark.)

More below.

> ---
>   drivers/net/ipa/gsi.c | 12 ++++++++----
>   drivers/net/ipa/gsi.h |  2 +-
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
> index 9a0b1fe4a93a..d2db54cbd46d 100644
> --- a/drivers/net/ipa/gsi.c
> +++ b/drivers/net/ipa/gsi.c
> @@ -1730,10 +1730,10 @@ static int gsi_channel_setup_one(struct gsi *gsi, u32 channel_id)
>   	gsi_channel_program(channel, true);
>   
>   	if (channel->toward_ipa)
> -		netif_napi_add_tx(&gsi->dummy_dev, &channel->napi,
> +		netif_napi_add_tx(gsi->dummy_dev, &channel->napi,
>   				  gsi_channel_poll);
>   	else
> -		netif_napi_add(&gsi->dummy_dev, &channel->napi,
> +		netif_napi_add(gsi->dummy_dev, &channel->napi,
>   			       gsi_channel_poll);
>   
>   	return 0;
> @@ -2369,12 +2369,14 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
>   	/* GSI uses NAPI on all channels.  Create a dummy network device
>   	 * for the channel NAPI contexts to be associated with.
>   	 */
> -	init_dummy_netdev(&gsi->dummy_dev);
> +	gsi->dummy_dev = alloc_netdev_dummy(0);
> +	if (!gsi->dummy_dev)
> +		return -ENOMEM;
>   	init_completion(&gsi->completion);
>   
>   	ret = gsi_reg_init(gsi, pdev);
>   	if (ret)
> -		return ret;
> +		goto err_reg_exit;

Assuming you change it to not just use kfree() to free the
dummy netdev, the above call won't work.  You'll want to do
something like:

	if (ret)
		goto err_netdev_free;

 . .

err_netdev_free:
	free_dummy_netdev(gsi->dummy_dev);
err_reg_exit:


>   
>   	ret = gsi_irq_init(gsi, pdev);	/* No matching exit required */
>   	if (ret)
> @@ -2389,6 +2391,7 @@ int gsi_init(struct gsi *gsi, struct platform_device *pdev,
>   	return 0;
>   
>   err_reg_exit:
> +	kfree(gsi->dummy_dev);
>   	gsi_reg_exit(gsi);
>   
>   	return ret;
> @@ -2400,6 +2403,7 @@ void gsi_exit(struct gsi *gsi)
>   	mutex_destroy(&gsi->mutex);
>   	gsi_channel_exit(gsi);

Please call the free here, so the cleanup is done in
exactly the reverse order of the initialization.

					-Alex

>   	gsi_reg_exit(gsi);
> +	kfree(gsi->dummy_dev);
>   }
>   
>   /* The maximum number of outstanding TREs on a channel.  This limits
> diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
> index 42063b227c18..6b7ec2a39676 100644
> --- a/drivers/net/ipa/gsi.h
> +++ b/drivers/net/ipa/gsi.h
> @@ -155,7 +155,7 @@ struct gsi {
>   	struct mutex mutex;		/* protects commands, programming */
>   	struct gsi_channel channel[GSI_CHANNEL_COUNT_MAX];
>   	struct gsi_evt_ring evt_ring[GSI_EVT_RING_COUNT_MAX];
> -	struct net_device dummy_dev;	/* needed for NAPI */
> +	struct net_device *dummy_dev;	/* needed for NAPI */
>   };
>   
>   /**


