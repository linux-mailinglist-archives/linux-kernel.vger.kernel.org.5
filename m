Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2577C4AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjJKGfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbjJKGfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6EF9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIAMyUmlxWrNU8XizAtbyVA/LuGwCus231d845v8K30=;
        b=fTf9KLGVAd4vTH3WTZkXjXCR87pOMZ6HlmxZ3QfqoF3Iz3G27OlHPRu/UPOhTTOZBtEnyU
        o9M4tKt5XAtQt/cIgARAAYwOgfibhZL17eEAsCsEo1LWaT25zlG+3aFJrYVlI9i2kDRamK
        PRMPSpuO9pcd1D/U/Zfm5kGa49I6eOQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-VjfaBTLHO4CZKUqt7C_2EA-1; Wed, 11 Oct 2023 02:34:33 -0400
X-MC-Unique: VjfaBTLHO4CZKUqt7C_2EA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b65c46bca8so490343866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006072; x=1697610872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIAMyUmlxWrNU8XizAtbyVA/LuGwCus231d845v8K30=;
        b=V+QOW4wyycSkkIii3IQrNsEodpzh7CLo/VPoG/IFMbnJ5UBUKeNIRbHX2OuvrF8dbf
         LPYiXgJ/nDyPEmdaTOxQ/OxkPylufMfO1HO1d00e3CLi+4j9rk+U1FRt/ZvEZm7J4cwn
         3U6Np811d3Y4kJGBp6IrhDXoEKFl0GI/ygjU4ikqedj8s1rWe/tgzcaYJMTBC3iYw9Ix
         V5gcKtfo9QHQYkyBWg/0jisQWo/XUgbI1v5KFc8NrA3RYMdB0lw3khxAeq3bqtMa/gix
         gYq/zve1stM+fpj26n+IEExqh95zUo/4yWG+vCgHn4s2ctenr4+y1hT7hM8ttL130d9c
         9T7Q==
X-Gm-Message-State: AOJu0Yy4KQ06wkja58Znf5VTV3vQtHCZP9oggFInd4r+s7uVxuVXpOrz
        0o7dUt5tQCVjR7KJp3HOlWuNzh7F1VExzB8LQ1G/HVco+PHc0BkOJqxxYo067MOolFoyl39XpdP
        ue5YqlJHTs9531FmW5tmvMNAR/TFkO2wr
X-Received: by 2002:a17:907:762f:b0:9ae:5898:e278 with SMTP id jy15-20020a170907762f00b009ae5898e278mr18082589ejc.59.1697006071786;
        Tue, 10 Oct 2023 23:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Me0EZixeTyeE4zeSZNFscGp8BuKKX9KKpuFaxePk+Ru3aD5eiRwHnkiENimnGBUZNAB1ow==
X-Received: by 2002:a17:907:762f:b0:9ae:5898:e278 with SMTP id jy15-20020a170907762f00b009ae5898e278mr18082581ejc.59.1697006071530;
        Tue, 10 Oct 2023 23:34:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id pw23-20020a17090720b700b009ae05f9eab3sm9339295ejb.65.2023.10.10.23.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 23:34:30 -0700 (PDT)
Message-ID: <b56b6333-bbea-e451-0ddf-c14622e5a80e@redhat.com>
Date:   Wed, 11 Oct 2023 08:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vboxsf: Remove the unused variable out_len
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231011025302.84651-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231011025302.84651-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/11/23 04:53, Jiapeng Chong wrote:
> Variable out_len is not effectively used, so delete it.
> 
> fs/vboxsf/utils.c:443:9: warning: variable 'out_len' set but not used
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6776
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  fs/vboxsf/utils.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
> index 72ac9320e6a3..9515bbf0b54c 100644
> --- a/fs/vboxsf/utils.c
> +++ b/fs/vboxsf/utils.c
> @@ -440,7 +440,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  {
>  	const char *in;
>  	char *out;
> -	size_t out_len;
>  	size_t out_bound_len;
>  	size_t in_bound_len;
>  
> @@ -448,7 +447,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  	in_bound_len = utf8_len;
>  
>  	out = name;
> -	out_len = 0;
>  	/* Reserve space for terminating 0 */
>  	out_bound_len = name_bound_len - 1;
>  
> @@ -469,7 +467,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
>  
>  		out += nb;
>  		out_bound_len -= nb;
> -		out_len += nb;
>  	}
>  
>  	*out = 0;

