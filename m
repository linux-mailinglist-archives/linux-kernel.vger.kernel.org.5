Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE77517EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjGMFOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjGMFOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:14:30 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A22114;
        Wed, 12 Jul 2023 22:14:29 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so582988a12.1;
        Wed, 12 Jul 2023 22:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689225268; x=1691817268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfnofkg0FptbzpW86eoHnAne8pvThGCH60cE1/nO4Po=;
        b=IF7RaZOjyGFDlMX8uCniF3KcGLyeucQ9ZIb8tMY+cg2UMCEifub+MvhZzO7AkXdxGS
         nChZEFAgWI2O/d4xIMc5I0ofJ1eK/yWhfmK6BkEPdygqEh2QzSBuJ+NoCa9vQ6K0iF2J
         e9PO3FC86e4NwbXFmnUpeX/tAYQHtq6mVtocjSq0Fsc5J/s+Y57ivy/XrEdyqZdjx4wU
         cko9nh0fr4JmPH3ZmR2uibZAdHvdCBWvtrTOW1qUMYdoJB+YFAO2FGK3zpv23I1u7c1V
         DA3P/7qYMUWHYrY5KCj3BfJQzLSX29CgwDS2yJHecZX/mGX8cy7oFWKLM0BM4lBSCwb3
         t/Og==
X-Gm-Message-State: ABy/qLY8zPdFuQDtbYkR3T4mzJfaJ+Bb08PGQSjTPyLsTwBAwiD+dnH8
        0OLahjshw21bFG1zETuqb6M=
X-Google-Smtp-Source: APBJJlG9IkGuCA9qc29kS3GH6EONHM9XAJOoKE1TgztSufCNLdLnrE2U9qYniDXurrVAwKkNdaGpNg==
X-Received: by 2002:aa7:c75a:0:b0:51e:22db:897 with SMTP id c26-20020aa7c75a000000b0051e22db0897mr1210925eds.11.1689225268179;
        Wed, 12 Jul 2023 22:14:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d17-20020aa7d691000000b0051ded17b30bsm3690698edr.40.2023.07.12.22.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 22:14:27 -0700 (PDT)
Message-ID: <fcb9f467-d579-782a-80f7-68e14e98e1cd@kernel.org>
Date:   Thu, 13 Jul 2023 07:14:26 +0200
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
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
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

When can debugfs_create_dir() return NULL?

>   		return;
>   
>   	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);

-- 
js
suse labs

