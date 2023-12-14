Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36070812C94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443561AbjLNKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443570AbjLNKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF511A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702548825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDMg3HUsC1D+7iMcfX6C49T0/PYwQi9wuLRR5tvdCBQ=;
        b=cetuARQw5MkeyzHiUK8Wngwpj++u7RtHx6RkdJA2Q6IU4vxxH139sXZVI+GQwb2zF7KyoO
        AlJy0SBCrcjkhj+NeDy7nP1xxWl7PQh5iUXHGYj2bc3pj0xfn30s97DbMLGP61Y8xZvYPW
        sc79u6F0R+B4Vf879Pjyf+/AxJyILOU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-L5EU6vbuNu2eMu-UJfHXJQ-1; Thu, 14 Dec 2023 05:13:43 -0500
X-MC-Unique: L5EU6vbuNu2eMu-UJfHXJQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9e506f794so10481955b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548823; x=1703153623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDMg3HUsC1D+7iMcfX6C49T0/PYwQi9wuLRR5tvdCBQ=;
        b=Dc+wXD2W1voNNY7Aoe8em/4+ut4tgGvMY10ihIiHIdJntHBhm9EM+ztIv5JTjK0MAC
         4wsgPLeu6eL/74nda4Ee17HRbFJDfXOAoLLU67g7OP9LcOMqfEiU1D/GBZkHA8N3PO8G
         PUIvTJaNcM0eBnw92axoW7k1co+ptO7ePuEqQf/oY92/zRZrvF2qTISl8d8GLKH3+jZE
         sVV5cHXNuT4knXHKPn1jM2N4nVztTDS9F3jhpCqTHMxoEE+WMvcEvbxIOKGpE0GxXrCI
         mbqlGdEfj3lfzi0i/5OTCPg8zJZeQZLkQIVWgCtzjyHOH+UQXWuvFvxOdhuOOApSp83+
         TJgw==
X-Gm-Message-State: AOJu0Yz90L22vmz4SXY88EXnbH4pycIj06jzbixIQHw9OfTHAPpV6K74
        3LRlF1WP5AXfrQ5786cDPS8UJxaNgq7fNMiUQRitHXAzHXpf4eK6c8zqRs+1F+JcQNll46VuO3y
        U05KKSC1AXF1x7pR+7WmWJD3R
X-Received: by 2002:a05:6358:9dae:b0:170:26c3:ae83 with SMTP id d46-20020a0563589dae00b0017026c3ae83mr8097282rwo.57.1702548823106;
        Thu, 14 Dec 2023 02:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB8csX1ryjDrxVFDCJY0uU76NV+YESezciiIbJoADXQAiSZe/NmTA3B8WcS0+AnSTCcwNpzQ==
X-Received: by 2002:a05:6358:9dae:b0:170:26c3:ae83 with SMTP id d46-20020a0563589dae00b0017026c3ae83mr8097264rwo.57.1702548822646;
        Thu, 14 Dec 2023 02:13:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id et2-20020a056214176200b0067f02d13157sm804679qvb.15.2023.12.14.02.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 02:13:42 -0800 (PST)
Message-ID: <b3882f12-04e0-4293-9f94-19895b182d2f@redhat.com>
Date:   Thu, 14 Dec 2023 11:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] KVM: selftests: aarch64: Fix the buggy
 [enable|disable]_counter
Content-Language: en-US
To:     Shaoqin Huang <shahuang@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231129072712.2667337-1-shahuang@redhat.com>
 <20231129072712.2667337-4-shahuang@redhat.com>
From:   Eric Auger <eauger@redhat.com>
In-Reply-To: <20231129072712.2667337-4-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaoqin,

On 11/29/23 08:27, Shaoqin Huang wrote:
> In general, the set/clr registers should always be used in their
> write form, never in a RMW form (imagine an interrupt disabling
> a counter between the read and the write...).
> 
> The current implementation of [enable|disable]_counter both use the RMW
> form, fix them by directly write to the set/clr registers.
> 
> At the same time, it also fix the buggy disable_counter() which would
> end up disabling all the counters.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  tools/testing/selftests/kvm/include/aarch64/vpmu.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> index e0cc1ca1c4b7..644dae3814b5 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -78,17 +78,13 @@ static inline void write_sel_evtyper(int sel, unsigned long val)
>  
>  static inline void enable_counter(int idx)
>  {
> -	uint64_t v = read_sysreg(pmcntenset_el0);
> -
> -	write_sysreg(BIT(idx) | v, pmcntenset_el0);
> +	write_sysreg(BIT(idx), pmcntenset_el0);
>  	isb();
>  }
>  
>  static inline void disable_counter(int idx)
>  {
> -	uint64_t v = read_sysreg(pmcntenset_el0);
> -
> -	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> +	write_sysreg(BIT(idx), pmcntenclr_el0);
>  	isb();
>  }
>  

