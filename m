Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21E79AE90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349328AbjIKVdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjIKLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C159CE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694430878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZHlUfn/17CG9PV8K2nMC6g5yBMLaeUVhPgQcvBVUcM=;
        b=fDYUI6//0hISIOqKiuDyXWjwviNVe7Y3HcossfAUCpVeFTCgNGNupRVBOktwc/jJKlUQCi
        0uyp1er6X0fCkttZUCd9ivfFneJjmogRKINXdWGFLEID7zOUQe7WPrHLkep0lme4jF0+Nk
        yTTLFVCk6wV/HZ9Q8nbYvfkr7jSzU+8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-aq6ZcuodPCO4ISXpKulFOg-1; Mon, 11 Sep 2023 07:14:36 -0400
X-MC-Unique: aq6ZcuodPCO4ISXpKulFOg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9aa05c1934aso322608066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430875; x=1695035675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZHlUfn/17CG9PV8K2nMC6g5yBMLaeUVhPgQcvBVUcM=;
        b=nLHGGb41cg8d0czK/GkeAl49VId9s+WQD1FuCz1oEboEG1aJbkpTGnBR6sxP7l3v4x
         S3vClbbHUjexD0YZ/aq9Ve/Bhl/jnqh+7AK+UV1e7bqNtT9i/hTTnRrqiImsRVVne9ea
         oSbQ2KGdya2L+moIa/UcCJxBveniuvaf/xPAXF255T0K3Xc2s8TuMwPb7E5mw7xiOe4u
         cDiuIyPRIecrWm76HUbF2QSCPPRjLF85lYv/qmHQOA+luL+87eQJx8ImL5/Lr82zim85
         j6M/TMWP6o/RM1nUOUJ0dDZHtaOvE4Hh6Im2bKcCW7hj/YrBoab6ftcKP5Bb6gHJR4gH
         u8KA==
X-Gm-Message-State: AOJu0Yw3YRIrPNUF+X6ysSrI7DZFFH5MtqQNCghR/7T+tY0uyCZRKtlH
        jc8OyD5Fvs5c//1cXRXTdxgAwnUnfd9NxYVf5UOf3eouDFQiso8XDlo8BVKB/1ywEUPuv1WwU3+
        EOEHPx9MYJfgSOinbwnJZjvJwTg2NMPfv
X-Received: by 2002:a17:906:58cd:b0:9a1:c35b:9e09 with SMTP id e13-20020a17090658cd00b009a1c35b9e09mr18980888ejs.8.1694430875053;
        Mon, 11 Sep 2023 04:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc1yQRo/edO3xM+hTUpURKygC1fRP+bgKUURdgH3b7p2xbJeY1EngsA/BV5BKgyZZEYBdGdg==
X-Received: by 2002:a17:906:58cd:b0:9a1:c35b:9e09 with SMTP id e13-20020a17090658cd00b009a1c35b9e09mr18980867ejs.8.1694430874770;
        Mon, 11 Sep 2023 04:14:34 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709062b0700b009a1dbf55665sm5199607ejg.161.2023.09.11.04.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:14:34 -0700 (PDT)
Message-ID: <97f90ed6-e857-8b66-a4b8-8ed580bb18c7@redhat.com>
Date:   Mon, 11 Sep 2023 13:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/3] platform/mellanox: mlxbf-pmc: Fix potential buffer
 overflows
Content-Language: en-US
To:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1693917738.git.shravankr@nvidia.com>
 <bef39ef32319a31b32f999065911f61b0d3b17c3.1693917738.git.shravankr@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bef39ef32319a31b32f999065911f61b0d3b17c3.1693917738.git.shravankr@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/5/23 14:49, Shravan Kumar Ramani wrote:
> Replace sprintf with sysfs_emit where possible.
> Size check in mlxbf_pmc_event_list_show should account for "\0".
> 
> Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
> Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index be967d797c28..95afcae7b9fa 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -1008,7 +1008,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
>  	} else
>  		return -EINVAL;
>  
> -	return sprintf(buf, "0x%llx\n", value);
> +	return sysfs_emit(buf, "0x%llx\n", value);
>  }
>  
>  /* Store function for "counter" sysfs files */
> @@ -1078,13 +1078,13 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
>  
>  	err = mlxbf_pmc_read_event(blk_num, cnt_num, is_l3, &evt_num);
>  	if (err)
> -		return sprintf(buf, "No event being monitored\n");
> +		return sysfs_emit(buf, "No event being monitored\n");
>  
>  	evt_name = mlxbf_pmc_get_event_name(pmc->block_name[blk_num], evt_num);
>  	if (!evt_name)
>  		return -EINVAL;
>  
> -	return sprintf(buf, "0x%llx: %s\n", evt_num, evt_name);
> +	return sysfs_emit(buf, "0x%llx: %s\n", evt_num, evt_name);
>  }
>  
>  /* Store function for "event" sysfs files */
> @@ -1139,9 +1139,9 @@ static ssize_t mlxbf_pmc_event_list_show(struct device *dev,
>  		return -EINVAL;
>  
>  	for (i = 0, buf[0] = '\0'; i < size; ++i) {
> -		len += sprintf(e_info, "0x%x: %s\n", events[i].evt_num,
> -			       events[i].evt_name);
> -		if (len > PAGE_SIZE)
> +		len += snprintf(e_info, sizeof(e_info), "0x%x: %s\n",
> +				events[i].evt_num, events[i].evt_name);
> +		if (len >= PAGE_SIZE)
>  			break;
>  		strcat(buf, e_info);
>  		ret = len;
> @@ -1168,7 +1168,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
>  
>  	value = FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN, perfcnt_cfg);
>  
> -	return sprintf(buf, "%d\n", value);
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  /* Store function for "enable" sysfs files - only for l3cache */

