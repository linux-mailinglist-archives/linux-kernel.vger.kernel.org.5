Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB517A8C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjITTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjITTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:00:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36879D9;
        Wed, 20 Sep 2023 12:00:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-532c66a105bso58602a12.3;
        Wed, 20 Sep 2023 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695236409; x=1695841209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+PzMccbuZNjT7n/B4g9tZXEDtw10LborRT6hIzo2b0=;
        b=kgBAg7SAEJU7aXIHzqEVjTpvpgfEmeqQINCzBW25cJZ+pFYM+o9ustfNMXCpbCnBlp
         LXOpufBe1e8vEkMtQo/0ENQibVrVG1hOhTPS4j4w4okyLs20Jx0hGmxdyCaZlSR5mypU
         /i/TRpldCA0DYZqHvbGfTXGxgyDFhA79fLYwHUktcEmZaq1QpBcZdU6fF1cVyiXMAubc
         BkYiftQVZHVTtFwylqZS4oScoZn4WKpzIPUKvQwglF0k+foHogl1Rt0aQTGh8D9F3SLG
         14m54yMOOT5IynaBGC0yO4ePLGY2anEmwdCZZ5+WahkY2fK8Rf5VLebV2rsoBGRyDykj
         VUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695236409; x=1695841209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+PzMccbuZNjT7n/B4g9tZXEDtw10LborRT6hIzo2b0=;
        b=Z7OoF5plkHKXE/7j7mPq7IC0za2KbCV4D3HzZnv7BZGulmKHokvjSAu/zECfbwB11q
         X0GuAbc54oh5i3MKjHK6eauMsPFd2ToMZYebQxY2TO4Wmf+0+Lsq9X6q1+0YSmHKr8Px
         M/3C0w7icxqXU3Ft57j2ZZU+bcKF+u4UVwZoZNjPaFDc1FMht2HFtCGtGQf1xneDscKx
         vvRy9RdOzmKVQhuZSkHscjrE1jXsiIdEDI4yLlRT80nkVw1Mf95Raz44TSE+n4v49C98
         1rWFhWhXmrNT0z8EaLpPiNEprP7AYzAynOlU1yjXb9UIZgwz47ZjeQqGujXi3at7OPgZ
         eLQQ==
X-Gm-Message-State: AOJu0YypdGapaw47l3aLi07PHxgj2Jd8wE7MRyG1iXYAGZt+S2CMuDi/
        HcjguEoTtmRFbCceWrKYCv9RKWw+Ce4=
X-Google-Smtp-Source: AGHT+IFkzNJuKj19gNoZDoM4UAiu+wea7+CloQ5ocUDRoHGbGH4TSVrSCkyNSp0UnJT/ssp2VtIA2g==
X-Received: by 2002:aa7:c38d:0:b0:522:cef7:83c3 with SMTP id k13-20020aa7c38d000000b00522cef783c3mr3281248edq.8.1695236409259;
        Wed, 20 Sep 2023 12:00:09 -0700 (PDT)
Received: from shift (p200300d5ff3f8700aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff3f:8700:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id co4-20020a0564020c0400b0053120f313cbsm4506969edb.39.2023.09.20.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:00:08 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by shift with esmtp (Exim 4.97-RC0)
        (envelope-from <chunkeey@gmail.com>)
        id 1qj2Qi-000000006HC-0tMA;
        Wed, 20 Sep 2023 21:00:08 +0200
Message-ID: <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
Date:   Wed, 20 Sep 2023 21:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*)
 conversions
To:     Wu Yunchuan <yunchuan@nfschina.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20230919044916.523308-1-yunchuan@nfschina.com>
Content-Language: de-DE, en-US
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20230919044916.523308-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 06:49, Wu Yunchuan wrote:
> No need cast (void *) to (struct ar9170 *), (u8 *) or (void*).

hmm, your mail went into the spam folder. Good thing I checked.

 From what I remember: The reason why these casts were added in
carl9170 was because of compiler warnings/complaints.
Current gcc compilers should be OK (given that the kernel-bot
didn't react, or went your Mail to their spam-folder as well?)
but have you checked these older versions?

(In 6.5.0 Documentation/admin-guide/README.rst states that one
should have at least gcc 5.1 - could you run with those and
see if C=2 W=1 passes?)

Regards,
Christian

> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> ---
>   drivers/net/wireless/ath/carl9170/usb.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
> index e4eb666c6eea..c4edf8355941 100644
> --- a/drivers/net/wireless/ath/carl9170/usb.c
> +++ b/drivers/net/wireless/ath/carl9170/usb.c
> @@ -178,7 +178,7 @@ static void carl9170_usb_tx_data_complete(struct urb *urb)
>   	switch (urb->status) {
>   	/* everything is fine */
>   	case 0:
> -		carl9170_tx_callback(ar, (void *)urb->context);
> +		carl9170_tx_callback(ar, urb->context);
>   		break;
>   
>   	/* disconnect */
> @@ -369,7 +369,7 @@ void carl9170_usb_handle_tx_err(struct ar9170 *ar)
>   	struct urb *urb;
>   
>   	while ((urb = usb_get_from_anchor(&ar->tx_err))) {
> -		struct sk_buff *skb = (void *)urb->context;
> +		struct sk_buff *skb = urb->context;
>   
>   		carl9170_tx_drop(ar, skb);
>   		carl9170_tx_callback(ar, skb);
> @@ -397,7 +397,7 @@ static void carl9170_usb_tasklet(struct tasklet_struct *t)
>   
>   static void carl9170_usb_rx_complete(struct urb *urb)
>   {
> -	struct ar9170 *ar = (struct ar9170 *)urb->context;
> +	struct ar9170 *ar = urb->context;
>   	int err;
>   
>   	if (WARN_ON_ONCE(!ar))
> @@ -559,7 +559,7 @@ static int carl9170_usb_flush(struct ar9170 *ar)
>   	int ret, err = 0;
>   
>   	while ((urb = usb_get_from_anchor(&ar->tx_wait))) {
> -		struct sk_buff *skb = (void *)urb->context;
> +		struct sk_buff *skb = urb->context;
>   		carl9170_tx_drop(ar, skb);
>   		carl9170_tx_callback(ar, skb);
>   		usb_free_urb(urb);
> @@ -668,7 +668,7 @@ int carl9170_exec_cmd(struct ar9170 *ar, const enum carl9170_cmd_oids cmd,
>   		memcpy(ar->cmd.data, payload, plen);
>   
>   	spin_lock_bh(&ar->cmd_lock);
> -	ar->readbuf = (u8 *)out;
> +	ar->readbuf = out;
>   	ar->readlen = outlen;
>   	spin_unlock_bh(&ar->cmd_lock);
>   

