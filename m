Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2276C7A3FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIRDew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjIRDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C5311C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695008032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHzH+a1yYhJkfNUv/Dy9j8VaViRqaOEkd87Y+pYRKHg=;
        b=de7SCyqEm0AjEBTEDKJDehgm0YwkxrQDfblTnYgFz82/p5ryAjMxTZ+1KPEHqQmlo/fl4r
        mri8PlOY10mmj6/ZSckyVg9M34dSIUc/Z61n5zu4cTO5MdF6ylYwz6xtHNsG7W1xq3c9Yx
        ljALUwG7mXM7I9Jk0cNREv1TirHUJJI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-uCKjcSeKPD6vdeDXMeLthA-1; Sun, 17 Sep 2023 23:33:48 -0400
X-MC-Unique: uCKjcSeKPD6vdeDXMeLthA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-274c8d0771aso1289520a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695008027; x=1695612827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHzH+a1yYhJkfNUv/Dy9j8VaViRqaOEkd87Y+pYRKHg=;
        b=q9+s0VcOP2cn35Wb3WJfhM6KOFCu5kSjBz1PHhR3jzk2/96O81KpVboo4+LeS8vw7u
         n1T0vVn6d9XOaNW48u0wFS5AxL03+yBbj0ZMmGCgYqZSy0FRb2h9eLVMuHshu9kSANKM
         IkTfkink1d5KDtyNtFnCMSUoTtyfhkaEJtD7eCqHPGY7bryYBKNMb4G6ssh6wV/Xb2sl
         NvTcMMT2cNjsWhkFmhmOjbFzvfXD1mF26udwpHF0cH7jlX9L/5Ohru1W5ltEjR3Lem0V
         orOkRGLeq1Bxql6dQPmEoZIJi38rDGmnc/uWMXIxCDigj56CzFzALF1xdD+vyjDomHy5
         ppqg==
X-Gm-Message-State: AOJu0YwLBzhAEJmMfk6grE02ocZ0Xs+THCjbkiwY4QXeYqRgfGvoPwgB
        dEUNF9I5CEmGztq35zqOmZY1GOZgePxaEG7baB4rfBUZ4Cj27P5oEgDn8mLW8K+U8bGivp8wSLT
        IpJesRWhhCi8KUE6XxtXc3uyF
X-Received: by 2002:a17:90b:890:b0:274:7de7:d6fa with SMTP id bj16-20020a17090b089000b002747de7d6famr7131226pjb.9.1695008027065;
        Sun, 17 Sep 2023 20:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdFVHnxmGek3zqSMDKaRzCcHQAQEv2cIpV7L2yNs7LNSqm4GiEBUNxLVrj5jEdjCAv9J4IOA==
X-Received: by 2002:a17:90b:890:b0:274:7de7:d6fa with SMTP id bj16-20020a17090b089000b002747de7d6famr7131213pjb.9.1695008026727;
        Sun, 17 Sep 2023 20:33:46 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b0026b420ae167sm8825822pjb.17.2023.09.17.20.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 20:33:45 -0700 (PDT)
Message-ID: <2c23ab17-7516-e310-8b79-b8c5fc02984a@redhat.com>
Date:   Mon, 18 Sep 2023 13:33:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 05/35] drivers: base: Print a warning instead of
 panic() when register_cpu() fails
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-6-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 02:37, James Morse wrote:
> loongarch, mips, parisc, riscv and sh all print a warning if
> register_cpu() returns an error. Architectures that use
> GENERIC_CPU_DEVICES call panic() instead.
> 
> Errors in this path indicate something is wrong with the firmware
> description of the platform, but the kernel is able to keep running.
> 
> Downgrade this to a warning to make it easier to debug this issue.
> 
> This will allow architectures that switching over to GENERIC_CPU_DEVICES
> to drop their warning, but keep the existing behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/base/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 579064fda97b..d31c936f0955 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -535,14 +535,15 @@ int __weak arch_register_cpu(int cpu)
>   
>   static void __init cpu_dev_register_generic(void)
>   {
> -	int i;
> +	int i, ret;
>   
>   	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
>   		return;
>   
>   	for_each_present_cpu(i) {
> -		if (arch_register_cpu(i))
> -			panic("Failed to register CPU device");
> +		ret = arch_register_cpu(i);
> +		if (ret)
> +			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }
>   

The same warning message has been printed by arch/loongarch/kernel/topology.c::arch_register_cpu().
In order to avoid the duplication, I think the warning message in arch/loongarch needs to be dropped?

Thanks,
Gavin

