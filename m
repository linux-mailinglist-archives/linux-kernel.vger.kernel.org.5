Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E9768B03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGaFUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGaFUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:20:19 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A891AC;
        Sun, 30 Jul 2023 22:20:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso2291124e87.1;
        Sun, 30 Jul 2023 22:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690780815; x=1691385615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PCaV7jz4ZhQusEGOkRMQPvD1GkLtKnvc9bqZW1yacw=;
        b=YYnYrbEVxNRqPGDdLmkffSNKNSqUgMBz2W56nZ+ZvcO90FjsPp2xD6rwT3YFTHEq9F
         GBxWMbmjVLT3sYpTcz7QJMxuXPgaK52eflphBE3+7tnM6vlgR8Vhc/lubIYR8EBSQXrY
         36byq++4eBa60p7pLwPWpHCim6YkwvWKIqZpJWc8jfJUIRTLjwmskgDPjtEO7PPiqV68
         36n3LSkySAZ5zvVZ/XtnDZVTMtepZ6VNPTpMGeO5wy9IwmInLdeSqT8H403QGptc3aOi
         NEXF7qUPfu7Py0jRT1v5rZ/FfXQs57Dh7i9B9kD58p8rpE9CAxXbaSDVLKCgalFv0QTv
         d1Yg==
X-Gm-Message-State: ABy/qLbi3QaLY1n/jdSLNnR55a/5YcJtqt3kS7KJqRegia2edJ7SAlLm
        jxdC3xShwz63F3O8wi4OznDE9CRPF9E=
X-Google-Smtp-Source: APBJJlGK6TLfK80q1RYfkwG2/SJEzHxRS0T9UKRwbX9NrS83Sc9RKwlda1+Sn43xdx2oArIubQhClw==
X-Received: by 2002:a19:8c09:0:b0:4fe:1e74:3f3a with SMTP id o9-20020a198c09000000b004fe1e743f3amr4545975lfd.58.1690780814940;
        Sun, 30 Jul 2023 22:20:14 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l22-20020a1c7916000000b003fe22da3bc5sm803508wme.42.2023.07.30.22.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 22:20:14 -0700 (PDT)
Message-ID: <e411e3c4-37ae-f5ea-b50b-4a5c0718c857@kernel.org>
Date:   Mon, 31 Jul 2023 07:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ath5k: Fix debugfs_create_dir error checking
Content-Language: en-US
To:     Atul Raut <rauji.raut@gmail.com>, mickflemm@gmail.com,
        mcgrof@kernel.org, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230731023820.26571-1-rauji.raut@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230731023820.26571-1-rauji.raut@gmail.com>
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

On 31. 07. 23, 4:38, Atul Raut wrote:
> The debugfs_create_dir function returns ERR_PTR
> in case of error and the correct way to check an
> error is 'IS_ERR' inline function.
> This patch will replace the null-comparison with IS_ERR
> 
> This issue was found with the help of Coccinelle.
> ./drivers/net/wireless/ath/ath5k/debug.c:985:6-12: Wrong debugfs call error processing on line 985
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>   drivers/net/wireless/ath/ath5k/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
> index 4b41160e5d38..08058b3f7e22 100644
> --- a/drivers/net/wireless/ath/ath5k/debug.c
> +++ b/drivers/net/wireless/ath/ath5k/debug.c
> @@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
>   	ah->debug.level = ath5k_debug;
>   
>   	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
> -	if (!phydir)
> +	if (IS_ERR(phydir))

Already fixed by:
https://patchwork.kernel.org/project/linux-wireless/patch/20230714081619.2032-1-duminjie@vivo.com/

-- 
js
suse labs

