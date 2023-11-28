Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA807FB5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjK1J2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjK1J2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:28:31 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C331CC;
        Tue, 28 Nov 2023 01:28:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a002562bd8bso988439566b.0;
        Tue, 28 Nov 2023 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701163716; x=1701768516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/I37Hy+CPxtqaGJSStMJzaZK7V1cChne6wXUX2MFad4=;
        b=A9Hvk3oCbZRaVXIKKfGepnGcLcNvJfFCshHrc13RyRUH4xZzCclsJbK5TuMAS61+YH
         fBww3etSsCPpi0ioVhKBE3z9ExuQZNx/F63KsnrN1G6+mfocW4bbccUZv9X9sJJRcMBS
         XTUkJdjGB7OhMNzI6eP6odf5EDpBVWjvduh+gdVAUH85Vdc9pwDa156EwdZpA3EVudiW
         qMrvUfJZ2oCcmwjMHJcVO66SgV5okuC81SDxxb0cMBFW4EZ6v/naLrHC5RJ4MTJAdLWc
         f2so1dD6X/WGRMP7b0gSnqLGbz9Xlf41FuSL5i8fPfKu1vhZm3tDiymEKlz+WlTj818p
         tb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163716; x=1701768516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/I37Hy+CPxtqaGJSStMJzaZK7V1cChne6wXUX2MFad4=;
        b=NH46r8Ybst3dl5fpuIRPSfouA6n0meHoQyhRG3VLdLZg5N0W4ufMrSD9ZIu2tdl/rG
         kLtzL7eyWFVlgda7dlft+jdcqkADPYdFbqMZQq9PJwC1PkCDpWIcfoYXL/Qjt3Kf5gWP
         L8huybxVrcyplHIzHH5WjhM+gpmpip+uOId/5ahDo4psj+TI7MMgneu9wRfj4+dAIkwR
         XeGVTOnrMaYqFvIRWD2g6a6FAeZVAWEoV4nCMF1HxZGx3QWTiGRN9sbL9b2wzhd9U6AS
         hex97ThU9Cf5ypuCUVf7KAk3j4b/6sI9YjMCS6cfyuy7GIc7rI5k6bHyOokgP+JKDt5o
         domQ==
X-Gm-Message-State: AOJu0Yx3qcu/gMnAtsNLMzZHM7kQ6/Hin0XpIQS+v63ONQC99KAwJhE7
        VGy98vtp1xBbIWnNOppSHGPdkYzM6yU=
X-Google-Smtp-Source: AGHT+IFEH4EFXz1SkAIQ0bi87cfTz2YfZJMxHuimsbsOY121G4/9iPjVSo4FUzJwYEYUkxZgVW3udg==
X-Received: by 2002:a17:906:c791:b0:9ad:8a96:ad55 with SMTP id cw17-20020a170906c79100b009ad8a96ad55mr16418289ejb.14.1701163715664;
        Tue, 28 Nov 2023 01:28:35 -0800 (PST)
Received: from [172.27.56.182] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906319400b00a097c5162b0sm5140142ejy.87.2023.11.28.01.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:28:35 -0800 (PST)
Message-ID: <4092804e-6266-47ae-a0f2-9658231fde40@gmail.com>
Date:   Tue, 28 Nov 2023 11:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, Aya Levin <ayal@nvidia.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231128084303.27227-1-dinghao.liu@zju.edu.cn>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231128084303.27227-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/2023 10:43, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_udp_create_groups() will free ft->g. However, its caller
> fs_udp_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by removing the kfree(ft->g) in fs_udp_create_groups().
> 
> Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index be83ad9db82a..806a5093ff63 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -153,7 +153,6 @@ static int fs_udp_create_groups(struct mlx5e_flow_table *ft, enum fs_udp_type ty
>   	ft->g = kcalloc(MLX5E_FS_UDP_NUM_GROUPS, sizeof(*ft->g), GFP_KERNEL);
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if  (!in || !ft->g) {
> -		kfree(ft->g);
>   		kvfree(in);
>   		return -ENOMEM;
>   	}

Same comment applies here. See the other mail thread.
