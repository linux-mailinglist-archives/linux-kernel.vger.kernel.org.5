Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE47785EA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjHKDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjHKDRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B1D30F4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691723776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxVuMV7NfVels7NbA1UkuP4mEMIntZymXRlB6RKGCA0=;
        b=UnsyHOwkneVM7dx6SCMwpg92cMAEkBIslBnukU7hQaQCYrR7lP6TxIQrywYGkNE2iKCqcm
        97fWROoyKylF6AzaW9MHKyqclPizsfRYEmfg4QSCHzli35Xjf6+9rQho9tHY1Ch/u4MfzE
        4sywXyE3v7QaKczA7/lzybIA+vqMGi0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-AztFw2f8MNKr95Pe9tqZog-1; Thu, 10 Aug 2023 23:16:15 -0400
X-MC-Unique: AztFw2f8MNKr95Pe9tqZog-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bdb620e631so436865ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691723774; x=1692328574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxVuMV7NfVels7NbA1UkuP4mEMIntZymXRlB6RKGCA0=;
        b=YX7IgRk+9Fz6yA+y40UmJPRREWW3CZJJdgpXKoy8Jk4TgEap3hWSUFstxf0tkYNVwS
         v60Gxfbb+Fz+awVCTG+xFeBF9fCeB9eRyWWXZtJqvLlKNy7N8uozBp8HaVF+TYlZpdQH
         Y3iQY8g3zle4c3z/od3UtkeX0Cu3Akw5TaFYWBaCtfUYAsLQ87Zlq5Hh+ieWhNvbTps8
         aMHOjFygdKGBmaS38nyBkANU0W4aw9zpvQo6O7vh1rbasHI3iTQR9teR7gflYVRAwpxy
         lwU4Vsa46DuWcSc04iUXiR5evniEypu0Z0GcombEcMLvWBGca4saaiaQSJoqsHC3bked
         Rm+w==
X-Gm-Message-State: AOJu0YxfWkmuoOKqc4CPEz0wIgivr03NBqAjrpnOeAltV05yswK6F+PN
        du9b6cRRuhUaFsG68TUWyhykHB5e6ZfJjPxaITqCzDzGd3DfMcAcEZwR8H19rIdnY5QxZjZ021y
        ZSYWLO293n1ftrctn3a5cR2sO
X-Received: by 2002:a17:902:d4ce:b0:1b1:9272:55e2 with SMTP id o14-20020a170902d4ce00b001b1927255e2mr857232plg.3.1691723774433;
        Thu, 10 Aug 2023 20:16:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh/vwl3upbeZ36WYfzpIGbtQYzH/ApexffsIYFu0eUp+KR2cyRBkYjBzFNVTGEHb4hVszsqw==
X-Received: by 2002:a17:902:d4ce:b0:1b1:9272:55e2 with SMTP id o14-20020a170902d4ce00b001b1927255e2mr857201plg.3.1691723774115;
        Thu, 10 Aug 2023 20:16:14 -0700 (PDT)
Received: from [10.72.112.92] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b00265c742a262sm2400175pjj.4.2023.08.10.20.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 20:16:13 -0700 (PDT)
Message-ID: <60a2cc0e-df09-4305-6bfc-25b3d864040a@redhat.com>
Date:   Fri, 11 Aug 2023 11:16:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 08/14] arm64: tlb: Implement __flush_s2_tlb_range_op()
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20230808231330.3855936-1-rananta@google.com>
 <20230808231330.3855936-9-rananta@google.com>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230808231330.3855936-9-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/23 07:13, Raghavendra Rao Ananta wrote:
> Define __flush_s2_tlb_range_op(), as a wrapper over
> __flush_tlb_range_op(), for stage-2 specific range-based TLBI
> operations that doesn't necessarily have to deal with 'asid'
> and 'tlbi_user' arguments.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   arch/arm64/include/asm/tlbflush.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index b9475a852d5be..93f4b397f9a12 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -340,6 +340,9 @@ do {									\
>   	}								\
>   } while (0)
>   
> +#define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
> +	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false)
> +
>   static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   				     unsigned long start, unsigned long end,
>   				     unsigned long stride, bool last_level,

-- 
Shaoqin

