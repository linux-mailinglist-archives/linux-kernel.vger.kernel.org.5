Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632227F9F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjK0MYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjK0MYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:24:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC110F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701087859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYDiqW/SQ7zaMFpt/KuBFGN2HjMliY/gtAkoUJNHgw8=;
        b=CZTr838EVrjV4bq5TxRtHyclYucgJi/nCLLXNpCVUuj2bt+AxYOf+9UIBA/Av6wAtbjZh0
        Zy4G0xMQIdJP/yGeL6dFO0QCvoYMhejYSfDuVGoun9qPaE7KlnwvfteYkRN8dCl8mz8sqR
        WRhm+DpiR4zLD+Xw10ouY5MBR7B7las=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-38RhbPKLPnOjzP6V7XGctw-1; Mon, 27 Nov 2023 07:24:17 -0500
X-MC-Unique: 38RhbPKLPnOjzP6V7XGctw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a0d9009b457so101545066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701087856; x=1701692656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYDiqW/SQ7zaMFpt/KuBFGN2HjMliY/gtAkoUJNHgw8=;
        b=n8INQz1NINFNFPuTJL6PjEfvoD8kwblrcnuOJIvv5YYw/OhUv2YktyEvt3JbwE9bBD
         2zMZeaGjwtosUVy4DNOjjT99eSUL2FT+2QP2y86DT1+t5mLqsX2E5Wg5onZuRVCEa/Mp
         gZk0YU/Dl7cW+c68Uhk6556LFn2Pl+lWpTwkAbwoBmUrOX6P8UaePAEwukPHxiojXZXw
         UQ6Fj6yjfkg3OrK8ZRQjMVqz++s6FsrtP/CVd/AuL2/H41c7Z1+Ox5WM5ZbVex/hBQQ2
         7jSmZxeTKarseaQB1uJ2Kt0Sy9MESSu1fnm+xTBtLR3h7APA1vilgdzrAk36JsnNfJbt
         jp0Q==
X-Gm-Message-State: AOJu0Yx5DBvhyB6YAoHLiSlstaz/AzxQUUKu1a4ywLXO6p/8hlQ1KtIf
        92LAOkdCABpGIw7XL8Q3xdUOFBCnVktczw/RW+KiBBHfknWJZqMMC6n5xho/C59wFLVT0jeWoZb
        yEUl/D7yeVCdeNTWRHxJroO4P
X-Received: by 2002:a17:906:20de:b0:a01:811c:ce9 with SMTP id c30-20020a17090620de00b00a01811c0ce9mr9178993ejc.0.1701087856570;
        Mon, 27 Nov 2023 04:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELyxITPAfJrtjBfjgFTysn4Ore/t06/VodJ7JGyE/oEz/FT3ThRAdyF7RMdynFMEfWBjaJKA==
X-Received: by 2002:a17:906:20de:b0:a01:811c:ce9 with SMTP id c30-20020a17090620de00b00a01811c0ce9mr9178965ejc.0.1701087856272;
        Mon, 27 Nov 2023 04:24:16 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009fd727116b4sm5611223eji.129.2023.11.27.04.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 04:24:15 -0800 (PST)
Message-ID: <8d66d4c0-ebc2-43b1-98b3-c41c871b4b7e@redhat.com>
Date:   Mon, 27 Nov 2023 13:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/mellanox: Add a null pointer check in
 mlxbf_pmc_create_groups
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, ilpo.jarvinen@linux.intel.com,
        vadimp@nvidia.com, jiri@resnulli.us, shravankr@nvidia.com
Cc:     kunwu.chan@hotmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127063433.1549064-1-chentao@kylinos.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231127063433.1549064-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/27/23 07:34, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 0b427fc24a96..59bbe5e13f6b 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -1882,6 +1882,8 @@ static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
>  	pmc->block[blk_num].block_attr_grp.attrs = pmc->block[blk_num].block_attr;
>  	pmc->block[blk_num].block_attr_grp.name = devm_kasprintf(
>  		dev, GFP_KERNEL, pmc->block_name[blk_num]);
> +	if (!pmc->block[blk_num].block_attr_grp.name)
> +		return -ENOMEM;
>  	pmc->groups[pmc->group_num] = &pmc->block[blk_num].block_attr_grp;
>  	pmc->group_num++;
>  

