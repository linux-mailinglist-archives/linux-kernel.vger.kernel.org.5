Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E737F587F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjKWGnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjKWGnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D07F112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700721802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Y6v5Xhwln7tu/9zxftOsUtL05MptTTj1UHVhZFfC54=;
        b=BC3KbxyY1cqWZHExLgz5VzrUmHGWFze0yQzZNNjt96zxXpMgdGteh1fzFufC++tZZI2v7d
        MZI2Zr8baoMJcwtrvTWetFhx8RZ37zeV84zS+IbUn1mlzHwNM9DS4iSkd1SGutJmJDl0hM
        vYy1yOpDvSJyvYFeUQ5aYBA5HINYyOY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-BqVzwA5QM0yqoEDGqaRxug-1; Thu, 23 Nov 2023 01:43:21 -0500
X-MC-Unique: BqVzwA5QM0yqoEDGqaRxug-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2800fffc08eso168480a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700721799; x=1701326599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y6v5Xhwln7tu/9zxftOsUtL05MptTTj1UHVhZFfC54=;
        b=drdvimiQZa29aLpK6CdxcXlQLYZHPeB4227bn0RX3w9fQmW+O0WNvJXqNBQ7h/W6tF
         /R5wI9biMZYC7HSJ8TEr6Z22wYEu0P870iAlIXE+RsfXocxP+9NwzPjlQMs0NVzEJHuc
         HWL/0VzFnEigc9yO9fgG7rUY7peN6T0nYansgV77TUqZIMriBwzD90KsCJQhWQj8vFw9
         j+bqAusO4GS0h+OIPLYo2qIB5A4sG0PxRADliNhDRA2+ZvlJtkBdlTDIg7WhVbFScS9q
         dp+m3jFBKtKFf1KPkjop5JYX4wnqBNhqAvwWdfuFMYcrMfGLf6895Ov6dA3WLJRouXPt
         +tWA==
X-Gm-Message-State: AOJu0Ywjau2uidYRooXT7F6JMyvCUnfed1uDkrHNNjdKZBQ7QepRXyZ2
        Hm01P3WOp+XUuqIWiiw7uVERnck2GTF88dffE3zhUs4Ue9r9YMABjrI7BznO74/IQLwQ16jVV7o
        U47acJUDjXUSWIFVDmE2rArxTcbHh5+w61+RBrA==
X-Received: by 2002:a17:902:d486:b0:1cc:3c2c:fa1a with SMTP id c6-20020a170902d48600b001cc3c2cfa1amr5191037plg.4.1700721799477;
        Wed, 22 Nov 2023 22:43:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqJ7t5K0G/lG65L6yMQON3n741jzN2NtB/hlBiB4j/kh7OASHj0JQgIsOvheK+O1VEnunV1Q==
X-Received: by 2002:a17:902:d486:b0:1cc:3c2c:fa1a with SMTP id c6-20020a170902d48600b001cc3c2cfa1amr5191028plg.4.1700721799075;
        Wed, 22 Nov 2023 22:43:19 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001c9d968563csm538754plm.79.2023.11.22.22.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 22:43:18 -0800 (PST)
Message-ID: <d5cc3cf1-7b39-9ca3-adf2-224007c751fe@redhat.com>
Date:   Thu, 23 Nov 2023 14:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] KVM: selftests: aarch64: Remove unused functions from
 vpmu test
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20231122221526.2750966-1-rananta@google.com>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231122221526.2750966-1-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghavendra,

Those functions might be useful for other pmu tests. Recently I just 
wrote a pmu_event_filter_test[1] and use the enable_counter().

There may have more pmu tests which can use the helper functions, so I 
think we can keep it now. And in my series[1], I have moved them into 
the lib/ as the helper function.

[1]https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/

Thanks,
Shaoqin

On 11/23/23 06:15, Raghavendra Rao Ananta wrote:
> vpmu_counter_access's disable_counter() carries a bug that disables
> all the counters that are enabled, instead of just the requested one.
> Fortunately, it's not an issue as there are no callers of it. Hence,
> instead of fixing it, remove the definition entirely.
> 
> Remove enable_counter() as it's unused as well.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   .../selftests/kvm/aarch64/vpmu_counter_access.c  | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> index 5ea78986e665f..e2f0b720cbfcf 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> @@ -94,22 +94,6 @@ static inline void write_sel_evtyper(int sel, unsigned long val)
>   	isb();
>   }
>   
> -static inline void enable_counter(int idx)
> -{
> -	uint64_t v = read_sysreg(pmcntenset_el0);
> -
> -	write_sysreg(BIT(idx) | v, pmcntenset_el0);
> -	isb();
> -}
> -
> -static inline void disable_counter(int idx)
> -{
> -	uint64_t v = read_sysreg(pmcntenset_el0);
> -
> -	write_sysreg(BIT(idx) | v, pmcntenclr_el0);
> -	isb();
> -}
> -
>   static void pmu_disable_reset(void)
>   {
>   	uint64_t pmcr = read_sysreg(pmcr_el0);

