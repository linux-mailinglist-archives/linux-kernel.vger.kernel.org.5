Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA17A9E84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjIUUCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjIUUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:02:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFBEAE25F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:58:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053cf48670so272825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1695322690; x=1695927490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KW8ptBjfzraMHf44Xf+Faj+9o+1k3zhlihjZp+x+Tf8=;
        b=BlKtt3pBDuWV5jR6XN88wUQ1cApSwGz6JmULqqLY+eVbX2566cEa7IlekxoyCEt0Y8
         TM/3Hh96/OEcARyYOrjE61EXsC2zfiTXZsOGS6ZOJPkVYmNumZBfjakCHukeU5X1bofj
         YMKFjKMSGz2gai2oIG226k799jQSdeOTZiNC2Yw+G0FoWt14AFIsxRuZNyjyM+VEi85L
         kFG5VeWPEHIgjlfHnMBIwFEmoZqGPo6eknztp+xx0opRowAHyjzlvSd+om5vYBHdx74V
         NKerBSAkN2X+RtJFQFDTk2oNqhBeaCIA+Pw0q8g7LeaYOgKSEyKb3k8oIvv9gGqQr/q0
         6HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322690; x=1695927490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW8ptBjfzraMHf44Xf+Faj+9o+1k3zhlihjZp+x+Tf8=;
        b=uvIll75PfbP3Iudahyb/ssK1BWJNXg7iOjbaufaQ2AglfT8tz8TeMXdSPsfBiVgrwy
         Edi4xNakEA32D8kF+0do3i77jFQ7qDZ4wYUR7MYpMfegQlh2DPCDn5ZbwEMB9E1Hk/xR
         TbROzJNAFGm6jn8U8QRGuA0MFW4liB73EKxr8KZcGwjw053Vs9/Muw3U1C/DbBmJgBrG
         2G5TXO4ztVf1fUWQGZ1O+GjjPfclc3SSC3Zont1RZV+6nkadN1hIm3abENKAE5hdKfTA
         h5DLA+aRfaWuFK93lmSkvvxW8Wvyu1BdMqSBFYCtsGFxRJT6niDVBOKXRIJhI8wYlPed
         fUSg==
X-Gm-Message-State: AOJu0Ywpe0QbVP1RN4k6wZ7G/qdN7YPu6QSY6Bt3w+s3EwKVniD3yiop
        dHBzpa4mljBF78g8LeWBaFSfiC0uJwDPAjLuAo9TPA==
X-Google-Smtp-Source: AGHT+IGB+xWpEg1KqRLjENdA7FRVUtuQvkZPkq5ESDKlloikTKnib1nrIsJDstUiJVr1a0TFc10UJA==
X-Received: by 2002:a05:6512:3e17:b0:502:d35b:5058 with SMTP id i23-20020a0565123e1700b00502d35b5058mr4844512lfv.4.1695280645785;
        Thu, 21 Sep 2023 00:17:25 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0b:f500:9282:fc17:35d3:acf0? (p200300f6af0bf5009282fc1735d3acf0.dip0.t-ipconnect.de. [2003:f6:af0b:f500:9282:fc17:35d3:acf0])
        by smtp.gmail.com with ESMTPSA id dy6-20020a05640231e600b0052718577668sm420330edb.11.2023.09.21.00.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:17:25 -0700 (PDT)
Message-ID: <0e86d1cb-a042-7d80-b410-0cc4b31744aa@grsecurity.net>
Date:   Thu, 21 Sep 2023 09:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Content-Language: en-US, de-DE
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Cc:     ssengar@microsoft.com
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.23 06:52, Saurabh Sengar wrote:
> There has been cases reported where HYPERV_VTL_MODE is enabled by mistake,
> on a non Hyper-V platforms. This causes the hv_vtl_early_init function to
> be called in an non Hyper-V/VTL platforms which results the memory
> corruption.
> 
> Remove the early_initcall for vhv_vtl_early_init and call it at the end of
> hyperv_init to make sure it is never called in a non Hyper-V platform by
> mistake.
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Closes: https://lore.kernel.org/lkml/40467722-f4ab-19a5-4989-308225b1f9f0@grsecurity.net/
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> This patch is dependent on :
> https://lore.kernel.org/lkml/1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com/
> 
>  arch/x86/hyperv/hv_init.c       | 3 +++
>  arch/x86/hyperv/hv_vtl.c        | 3 +--
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f0128fd4031d..608f4fe41fb7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -610,6 +610,9 @@ void __init hyperv_init(void)
>  	/* Find the VTL */
>  	ms_hyperv.vtl = get_vtl();
>  
> +	if (ms_hyperv.vtl > 0) /* non default VTL */
> +		hv_vtl_early_init();
> +

As the kernel's console will already be initialized when this code gets
executed, the possible panic() in hv_vtl_early_init() will actually be
visible, thereby...

>  	return;
>  
>  clean_guest_os_id:
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 36a562218010..999f5ac82fe9 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -215,7 +215,7 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
>  	return hv_vtl_bringup_vcpu(vp_id, start_eip);
>  }
>  
> -static int __init hv_vtl_early_init(void)
> +int __init hv_vtl_early_init(void)
>  {
>  	/*
>  	 * `boot_cpu_has` returns the runtime feature support,
> @@ -230,4 +230,3 @@ static int __init hv_vtl_early_init(void)
>  
>  	return 0;
>  }
> -early_initcall(hv_vtl_early_init);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 033b53f993c6..83019c3aaae9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -340,8 +340,10 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
>  
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);
>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
> +static int __init hv_vtl_early_init(void) {}
>  #endif
>  
>  #include <asm-generic/mshyperv.h>

Acked-by: Mathias Krause <minipli@grsecurity.net>

Thanks!
