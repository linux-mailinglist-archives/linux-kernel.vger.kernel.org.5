Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F1773FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjHHQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjHHQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:51:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A4A4C149;
        Tue,  8 Aug 2023 08:58:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bcc0adab4so847060966b.2;
        Tue, 08 Aug 2023 08:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509934; x=1692114734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKx1/VaIgRqUN/ndVcw3NROdMrmRr8duDpEd8AClkoQ=;
        b=g9uHo+MBsxq1lZ0NRFaIAFsFrp8ARjLkVo4AbK5iMs+VmpxaIVwgNpIhmtyZJVF9Kn
         9sE4z5jXFRpv05CaoqCbTpTvUCXFeDKl4Zvzodcx1S+2GtHSZ5M7wRUL1OIUxOR0Knt4
         VUCPmAOdVAJK8fyr/nWE2hjkQU9Rvy0fc3hiE6HAA75UqaV74kFr+AIZWFq5rkQm4Fym
         f0vat7ys/HcW0lwJ0ZF8OzCB5bqb5QUDasKOYcp+oElFqlhKCOqdV1K6vmaBmXtbGpL+
         3rShtP0bY6mEZysk933U69SJ7KEeKsQfckZGKvzlPmdwamwamnxXtKwys7AlSj4ByIi4
         nxMQ==
X-Gm-Message-State: AOJu0YxMd/i6+L0PtieckCcCrl2IRviSKCNLGKJZcpUK0yF6HhkinXz/
        Lak8l0uV3oRA+pi3YMe52fK8P38lSmsGfQ==
X-Google-Smtp-Source: AGHT+IEasP0f7uh5KfcBuXX9IzUxuEcy7FQjGihwCKiz0bxM6gSLGw/llf+xsy++JBMe+yBcn1yP/Q==
X-Received: by 2002:a2e:9d86:0:b0:2b6:df23:2117 with SMTP id c6-20020a2e9d86000000b002b6df232117mr8325133ljj.43.1691474571353;
        Mon, 07 Aug 2023 23:02:51 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id si10-20020a170906ceca00b00992e14af9c3sm6163483ejb.143.2023.08.07.23.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:02:50 -0700 (PDT)
Message-ID: <92a26f67-1b24-ea35-2f39-7c0b75027617@kernel.org>
Date:   Tue, 8 Aug 2023 08:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] ath5k: fix WARNING opportunity for swap.
Content-Language: en-US
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>, mickflemm@gmail.com,
        mcgrof@kernel.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
References: <20230807201057.340371-1-mahmoudmatook.mm@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230807201057.340371-1-mahmoudmatook.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 08. 23, 22:10, Mahmoud Maatuq wrote:
> coccinielle reported the following:
> ./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()


OK, once again:
https://lore.kernel.org/all/0c3acbd4-6ab2-5cc5-6293-54e30093cce2@kernel.org/

> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> ---
>   drivers/net/wireless/ath/ath5k/phy.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
> index 5797ef9c73d7..f87eb684f223 100644
> --- a/drivers/net/wireless/ath/ath5k/phy.c
> +++ b/drivers/net/wireless/ath/ath5k/phy.c
> @@ -1562,16 +1562,13 @@ static s16
>   ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
>   {
>   	s16 sort[ATH5K_NF_CAL_HIST_MAX];
> -	s16 tmp;
>   	int i, j;
>   
>   	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
>   	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
>   		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
>   			if (sort[j] > sort[j - 1]) {
> -				tmp = sort[j];
> -				sort[j] = sort[j - 1];
> -				sort[j - 1] = tmp;
> +				swap(sort[j], sort[j - 1]);
>   			}
>   		}
>   	}

-- 
js
suse labs

