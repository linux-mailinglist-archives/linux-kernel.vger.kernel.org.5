Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05067B17B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjI1Jkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjI1JkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB077195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695893971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Anogelpb6h+UmmPhFBLKjKjv5aWf5PDgUgDUDdH3vlA=;
        b=LTadL7zdrkOKBX+JcURT1JdONf8J1Ah61l4LGSs594v8lGUKkrQMnsUKyf9j5d2MTNEtm9
        t/Ew8smZbTIEP8UcBWg3nDx1irxSnw4Yxafuc6UdxYAXYFUt3KKRGyZWt3FfgXbsfoq0FB
        sq3cM/4AoRP9kqGRv/duLCfW8N4Wdeg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ETn_sjBmMTi6GwvHoox4MQ-1; Thu, 28 Sep 2023 05:39:30 -0400
X-MC-Unique: ETn_sjBmMTi6GwvHoox4MQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-417e128a7d4so176160321cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893969; x=1696498769;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Anogelpb6h+UmmPhFBLKjKjv5aWf5PDgUgDUDdH3vlA=;
        b=HYSjUb12+4x6oePbaet1ICrZ0mQz9yHUyHUKe8Pb154yILA1P0g4hspVLS/tPAGWM3
         IFna4pzBB7w9AklWbkrRxFt8OZRcgvMm07h9chfMaSf7WPAmLFdUaZby+RmAEYvwDnEq
         xVqdUBhuXGCyFywSOwtc1D7Qbr+0X8nnasOBPEef3BI5WgJA3jhPzdxdt/PX5GP5oFmK
         LAjCxNElIvKUi+xzN4C5JI7NAqQoAd7BegVDYoNrlOd/4+qCqUz2mFxsRemBkFHtKLLv
         a+mQmO24z0iqDFOs8mJc/bVr6mOfHVD+SQtVWKdU2sUit4di74P+1YHyQLQwAtAyEi9Z
         PbXg==
X-Gm-Message-State: AOJu0Yw1tzmi/q7+XJnZv/K6aDj/6YG/V7yNX3AE9h8w21sacXoatJlM
        pGBZWjiJrj/RJTFlxWionNkBM9T8ukBvRRt5qSI7W0aNoMa/kRdYabk4X6TLxl6ia4g9C6LmCmb
        X6zUf4eyOB7SJWGVegHOaDxfz
X-Received: by 2002:a05:622a:13ce:b0:418:14ee:ac55 with SMTP id p14-20020a05622a13ce00b0041814eeac55mr764234qtk.25.1695893969653;
        Thu, 28 Sep 2023 02:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdWWxVcXbNbn+HgbQsUoYBrNHNPHxvQrzvItXYSki4Ld2HbeRJumvkdOsWecilyPT0AOtxoA==
X-Received: by 2002:a05:622a:13ce:b0:418:14ee:ac55 with SMTP id p14-20020a05622a13ce00b0041814eeac55mr764221qtk.25.1695893969332;
        Thu, 28 Sep 2023 02:39:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id jz3-20020a05622a81c300b0041811e71890sm3572492qtb.33.2023.09.28.02.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 02:39:28 -0700 (PDT)
Message-ID: <ec8ffc8f-1f53-61ca-8268-f13616a658d7@redhat.com>
Date:   Thu, 28 Sep 2023 11:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] arm64: Add missing _EL12 encodings
Content-Language: en-US
To:     Miguel Luis <miguel.luis@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230925162057.27548-1-miguel.luis@oracle.com>
 <20230925162057.27548-2-miguel.luis@oracle.com>
From:   Eric Auger <eauger@redhat.com>
In-Reply-To: <20230925162057.27548-2-miguel.luis@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,
On 9/25/23 18:20, Miguel Luis wrote:
> Some _EL12 encodings are missing. Add them.
> 
> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 38296579a4fd..6e167bbf44ff 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -568,18 +568,29 @@
>  
>  /* VHE encodings for architectural EL0/1 system registers */
>  #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
> +#define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
> +#define SYS_SCTLR2_EL12			sys_reg(3, 5, 1, 0, 3)
> +#define SYS_ZCR_EL12			sys_reg(3, 5, 1, 2, 0)
> +#define SYS_TRFCR_EL12			sys_reg(3, 5, 1, 2, 1)
> +#define SYS_SMCR_EL12			sys_reg(3, 5, 1, 2, 6)
>  #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
>  #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
>  #define SYS_TCR_EL12			sys_reg(3, 5, 2, 0, 2)
> +#define SYS_TCR2_EL12			sys_reg(3, 5, 2, 0, 3)
>  #define SYS_SPSR_EL12			sys_reg(3, 5, 4, 0, 0)
>  #define SYS_ELR_EL12			sys_reg(3, 5, 4, 0, 1)
>  #define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
>  #define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
>  #define SYS_ESR_EL12			sys_reg(3, 5, 5, 2, 0)
>  #define SYS_TFSR_EL12			sys_reg(3, 5, 5, 6, 0)
> +#define SYS_FAR_EL12			sys_reg(3, 5, 6, 0, 0)
> +#define SYS_BRBCR_EL12			sys_reg(3, 5, 9, 0, 0)
isn't it sys_reg(2, 5, 9, 0, 0)?

> +#define SYS_PMSCR_EL12			sys_reg(3, 5, 9, 9, 0)

>  #define SYS_MAIR_EL12			sys_reg(3, 5, 10, 2, 0)
>  #define SYS_AMAIR_EL12			sys_reg(3, 5, 10, 3, 0)
>  #define SYS_VBAR_EL12			sys_reg(3, 5, 12, 0, 0)
> +#define SYS_CONTEXTIDR_EL12		sys_reg(3, 5, 13, 0, 1)
> +#define SYS_SCXTNUM_EL12		sys_reg(3, 5, 13, 0, 7)
>  #define SYS_CNTKCTL_EL12		sys_reg(3, 5, 14, 1, 0)
>  #define SYS_CNTP_TVAL_EL02		sys_reg(3, 5, 14, 2, 0)
>  #define SYS_CNTP_CTL_EL02		sys_reg(3, 5, 14, 2, 1)
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

