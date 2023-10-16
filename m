Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B77CA489
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjJPJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9AE8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697449913;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fj634e+VaD+ebYjjG6WWajLk8f8HNx2dl58LD2RwMjg=;
        b=ZIetIRVjByNZZ6KgzMvOwe0H8n5LaBdofIHtT8Xv++/iv4zgwFNX121/tLYcFConYQiLjf
        5Y1rxPPoauoJ5Cei13aHLH6c6r2ovYJHNgk199cPNwrTekNBu7wpGZoizJcY10Np5elXtR
        sS+xQ4wuYDMh/7k9Cx6hln9+UTBd7IE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-GloTaaQNOSOA6XGMQlSs5g-1; Mon, 16 Oct 2023 05:51:52 -0400
X-MC-Unique: GloTaaQNOSOA6XGMQlSs5g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65afd7515aaso50400156d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697449911; x=1698054711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fj634e+VaD+ebYjjG6WWajLk8f8HNx2dl58LD2RwMjg=;
        b=UNSSjH1O0ThPJcgPQoKCX4d3E4mA+kDmk9758pE/noZVCQop7to6c6kKT9S+qXe8uS
         hn6C1xsFWXbCo/Qr4abxOcCV3V95ux0dHp/+olUzHTqZBcnQJTVZtufkcvgWlbt4CMfB
         91OAre7s6Ecgb/CN3YuYXjkJClOdq8kbqm1Zctf5sAEIe60yQ8qYR/CBHUHsxMvTPSlO
         UZTF3iX1NxcSX63l3XQpQwVsvuGz89Lng5t1n58a2Xbae9rme5s/pvKXuU7JlGV62RgS
         DRgooCqbzykHjJ99KrTjk4iG+UJDOM5BM0wJfLC0xRA3Izze1nCBNbwuCDhLCQ7e4NYn
         XbjA==
X-Gm-Message-State: AOJu0YxLvlLNObAMzeWSxJ/ifeQ/rF90/NCkYnJ+BHElCFXcZGBhwr1B
        0U0MstNo9Ft/7A+SB+az1+k1TZoK8Dzw50ruQ0R1hrKCqpZzCDAXwUrcVhTr+Bd6hgR/IoZvgE0
        sCQuynDazTWA/W+zTIdZ0sl2g
X-Received: by 2002:ac8:5916:0:b0:410:90c7:5185 with SMTP id 22-20020ac85916000000b0041090c75185mr42288208qty.54.1697449911580;
        Mon, 16 Oct 2023 02:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5RLADwQA8GUJ6p2b4QyBiClPbS3YW1wz+PHSV7G5Jk5lya6TvrOhvPDh7G0jnEos8F37WSQ==
X-Received: by 2002:ac8:5916:0:b0:410:90c7:5185 with SMTP id 22-20020ac85916000000b0041090c75185mr42288195qty.54.1697449911350;
        Mon, 16 Oct 2023 02:51:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id v8-20020a05622a188800b00418142e802bsm2904361qtc.6.2023.10.16.02.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 02:51:50 -0700 (PDT)
Message-ID: <47f2d130-c077-d3fe-e0ea-6bb7c86190a0@redhat.com>
Date:   Mon, 16 Oct 2023 11:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 3/3] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Miguel Luis <miguel.luis@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20231011180103.91774-1-miguel.luis@oracle.com>
 <20231011180103.91774-4-miguel.luis@oracle.com>
 <7df53e6b-9141-de85-b7a3-b9eb092ef7b4@redhat.com>
 <e6f3002c10848e911c4bfee3a1d472aa@kernel.org>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e6f3002c10848e911c4bfee3a1d472aa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 10/12/23 22:36, Marc Zyngier wrote:
> On 2023-10-12 16:22, Eric Auger wrote:
>> Hi Miguel,
>>
>> On 10/11/23 20:01, Miguel Luis wrote:
>>> Implement a fine grained approach in the _EL2 sysreg ranges.
>>>
>>> Fixes: d0fc0a2519a6 ("KVM: arm64: nv: Add trap forwarding for HCR_EL2")
>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>>> ---
>>>  arch/arm64/kvm/emulate-nested.c | 88 ++++++++++++++++++++++++++++++---
>>>  1 file changed, 82 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/kvm/emulate-nested.c
>>> b/arch/arm64/kvm/emulate-nested.c
>>> index 9ced1bf0c2b7..3af49e130ee6 100644
>>> --- a/arch/arm64/kvm/emulate-nested.c
>>> +++ b/arch/arm64/kvm/emulate-nested.c
>>> @@ -648,15 +648,91 @@ static const struct encoding_to_trap_config
>>> encoding_to_cgt[] __initconst = {
>>>      SR_TRAP(SYS_APGAKEYLO_EL1,    CGT_HCR_APK),
>>>      SR_TRAP(SYS_APGAKEYHI_EL1,    CGT_HCR_APK),
>>>      /* All _EL2 registers */
>>> -    SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
>>> -              sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
>>> +    SR_TRAP(SYS_VPIDR_EL2,        CGT_HCR_NV),
>> I think you miss DBGVCR32_EL2
>
> I don't think this register should be part of this list. We don't
> support AArch32 with NV, and the spec says that DBGVCR32_EL2 UNDEFs
> when EL1 doesn't support AArch32.
>
> So the change that needs to happen is to inject an UNDEF when trapping
> a DBGVCR32_EL2and not forward the trap to the guest.

OK this makes sense

Thanks

Eric
>
> Thanks,
>
>         M.

