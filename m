Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC4751867
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjGMF6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjGMF6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:58:31 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3392113;
        Wed, 12 Jul 2023 22:58:30 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-31441bc0092so450166f8f.1;
        Wed, 12 Jul 2023 22:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227908; x=1691819908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bPmkmx8MFyLGshNfOTsNG6N5oeRGXLvF/oFTCyPJq4=;
        b=AjW7Y2TuU2dHKdWm9tCiniEPo5cSMaJ57j2mcOFpzzZa23/19R27YKEaRwq2svPGGx
         dJqIir9sGPYy2opBPk0oA2E2QC/09h/xvYPhSMx6sC4N+ts9Jm7NBN3HOqx1aF8eAr1M
         lCxi4AfOT2uJI5Ms/E6HX/jZNb6RxYtx4d64aQ6bSJF2GReweeruiKl/1jK7njYBuvQ+
         Sh2oAgfNLCg8mfmt4O2ExIqXqDASSs7Gv3NV+ydr26x/znr4EVrFz8P1x4JEGjepYwm4
         fLx3zcMV+PjCn92+Nwrfm9DBar6MQ9IMoF2+5qyCj71sUWLcEFYVh8B+TcaIP5LUzUBo
         a3jg==
X-Gm-Message-State: ABy/qLbM5zOoSBvQH4Pvc1y61mPA807KOkUT6REb5miaXg1XHPRDaiDp
        p2MJcBlx98QB+FcHXZffJs0=
X-Google-Smtp-Source: APBJJlGywdVjlMxH8FW+tpHfr3aHIWUvGko8KkL2E4xGwYdfcc/spEFfb7ByYHax3buSwCv+vzkh9g==
X-Received: by 2002:a5d:42cb:0:b0:311:142d:5d97 with SMTP id t11-20020a5d42cb000000b00311142d5d97mr495644wrr.31.1689227908407;
        Wed, 12 Jul 2023 22:58:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d50c1000000b0031438e42599sm6931032wrt.82.2023.07.12.22.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 22:58:27 -0700 (PDT)
Message-ID: <eb40223b-94fa-0ddc-2612-7fd57b4c6736@kernel.org>
Date:   Thu, 13 Jul 2023 07:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drivers: wireless: ath5k: fix parameter check in
 ath5k_debug_init_device()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "open list:ATHEROS ATH5K WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230713033647.2109-1-duminjie@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230713033647.2109-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 07. 23, 5:36, Minjie Du wrote:
> Make IS_ERR_OR_NULL() judge the debugfs_create_dir() function return
> in ath5k_debug_init_device().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> v1-v2:
> use IS_ERR_OR_NULL() instead of IS_ERR()
> ---
>   drivers/net/wireless/ath/ath5k/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
> index 4b41160e5..7c8823759 100644
> --- a/drivers/net/wireless/ath/ath5k/debug.c
> +++ b/drivers/net/wireless/ath/ath5k/debug.c
> @@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
>   	ah->debug.level = ath5k_debug;
>   
>   	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
> -	if (!phydir)
> +	if (IS_ERR_OR_NULL(phydir))
>   		return;

And actually, in this case, remove the check completely (as per docs).

thanks,
-- 
js
suse labs

