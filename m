Return-Path: <linux-kernel+bounces-165050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAE8B8711
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A44283A15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E6502AE;
	Wed,  1 May 2024 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xHlegFPw"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11048CF2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554058; cv=none; b=ikEIVp+a0IeHMduiWLIkyEvQihweryDueomkr0U0IxQTlyMd3DGRPsMqLWYEPBYfk1JRUvuNxP8iZMsSklIZE6Pz1gh6w9Nw42nVGN91F5+KqGakPZxGTp0SSUV5VAzKvsZrrnKVuqn6MDMo1rnzMSqq0vk2maTLnHT0cJ4sPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554058; c=relaxed/simple;
	bh=RvlWpLEFaTjb+9r8GV4kOWTTNkCATCgpD5gAqvzy9as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyvy6Xnux/A+LycNKuOY2gGCmG9oEMwN8OJyz4+3GVzZ9q1S/BxO8jKPvTz973gJD0MQ0qLEfp6NPRffiaUdMr27m5ROHoqu5lmbGRH9bHsKjvbts4LCItQUvEKoWHInqe/mkAPJeWsp2nG5mX5XKlEyKnOsHkDDjusqvW9YZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xHlegFPw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so86156531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714554054; x=1715158854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z/cUhjxZbZcBp200s+T3WFXuwoGui/XESvwGtAV7pU=;
        b=xHlegFPwN/OLwxjrnK5gQrF50SoPXUSJ40WMxsjVI18FkwEfVrc+tV6XmJM5WrNJxn
         602lktCye3J1+eJzzdYlAPeSAY6tUpDixPN5PD2JwK9aQn8Buy/RR2767n6nbFmOFERs
         PXoBZVDmr9AGlLlXm1YpI0LqLfxE+GAtC4t7HChb5fPMc4xVsMwaTV927hORz5phdGWn
         Ib0ThVG4mtIJ4Rlm4e9cxoSqasi6ZbyGrCiWe3Zq3tRZDqVz5o33oikggvqfQ5/CX25U
         63prh0yZoX9G+b/HJizuJibXAEKvIXS7T06yQlkw5p7ywVT0uqO7/eU03JcSpGemsxIZ
         aLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554054; x=1715158854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z/cUhjxZbZcBp200s+T3WFXuwoGui/XESvwGtAV7pU=;
        b=XPhtFloAO4wK27TkhfpIff57Df5O1kN661Df+LrTwnANhQsnETOJU6H/Qvn+Q0fjH/
         1qPaUN/Cm0Akva6No3cpO1QnhU4xrBm+ASInu1L2yaPhrM22N8s2HKgdF2Y/dLEyvqZ1
         yav4HeEYACV6WOfEIqlFdlm+dkyT1hX9OF2ahjP7hact5Pm4Tfmmp1bh8QF8Ii4C8xKf
         Dsz9tNKJzU8ptskeJ2A26plf52zMnahXbi+AqGZTklS9TgXwN5K0J0Z32+lsP2B+rdju
         VBvHLTvmYq9bb+iQT3MyPyRfFbvXb00s3/CD0WFXdxQD2xd7k8KP5Q41uJX6G6CoDpvP
         7fuw==
X-Forwarded-Encrypted: i=1; AJvYcCUFlXqc7cRVcROwVRazbz5yT8fEOJ+90y1s3OMlpOHiO0yGVDqAvzf4rgRUBGqeGbnEh38EJs4T/7NgXRw5Ceeh5Mfav+rTThnJrX7a
X-Gm-Message-State: AOJu0YyKKCJwEJ7ckfib99mH0pP0xZTu3Xmhu7cdCV6glEyqWgzz7Lal
	kOOOAJOnLiGPM0a4XsKbkQlQ1PaRHnkokYDNS2rM1aL2Hmkv35i/ifdcH7dH1Ho=
X-Google-Smtp-Source: AGHT+IE6du7GtGa4yWJTPKJ9+hxmuTCQMBAnDfeiG7v0iH1S+LQsBmxd6vnFIJ8yJppXhTWsJgTwMg==
X-Received: by 2002:a2e:3a1a:0:b0:2dc:b1c7:514e with SMTP id h26-20020a2e3a1a000000b002dcb1c7514emr1350558lja.8.1714554054077;
        Wed, 01 May 2024 02:00:54 -0700 (PDT)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b0041c14e42e2bsm1533485wmb.44.2024.05.01.02.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 02:00:53 -0700 (PDT)
Message-ID: <07cc48d8-658b-4eee-a72d-efe3cdbed967@blackwall.org>
Date: Wed, 1 May 2024 12:00:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix multicast-to-unicast with
 fraglist GSO
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240427182420.24673-1-nbd@nbd.name>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240427182420.24673-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2024 21:24, Felix Fietkau wrote:
> Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
> an invalid linearized skb. This code only needs to change the ethernet
> header, so pskb_copy is the right function to call here.
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 7431f89e897b..d7c35f55bd69 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -266,7 +266,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>  	if (skb->dev == p->dev && ether_addr_equal(src, addr))
>  		return;
>  
> -	skb = skb_copy(skb, GFP_ATOMIC);
> +	skb = pskb_copy(skb, GFP_ATOMIC);
>  	if (!skb) {
>  		DEV_STATS_INC(dev, tx_dropped);
>  		return;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

