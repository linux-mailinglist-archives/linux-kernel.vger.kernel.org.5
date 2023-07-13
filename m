Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35693752109
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjGMMSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjGMMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A926B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689250638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9Ye8KfETUuRbXwbLJ8cBLC8vHqrIxM24kzSIqos1xM=;
        b=Raoswb7HfYaQ7uIolIbOkh73VOgUkd6DJkgYPRp99e+vODWbwsN0gi/Txp9pCf4y4IP2wQ
        2qnWkXGRh16AWmH1pieCyaL7Hqv5XnLGQX+tPnmJR0tkygaIF9+7UZV0R05JcpneeCZU64
        zT7pEksbM91Tt1kGziYRX9GrhtH3Slo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-7Chm2BpON_GL14t_YIGKgg-1; Thu, 13 Jul 2023 08:17:16 -0400
X-MC-Unique: 7Chm2BpON_GL14t_YIGKgg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbffd088a9so3414865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689250635; x=1691842635;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9Ye8KfETUuRbXwbLJ8cBLC8vHqrIxM24kzSIqos1xM=;
        b=ZKGXD4EgolomK4LXbW0tgTMbysX1+q4vAkzZYfhOaV/hxHZzlhU807aKewgMre6rmg
         SSN/UXt/10hjvs/aTRdadl2Gp2PJPfmPaStabBNxaBg2CrreCKnhLN3suP2w9HWf2ldy
         pRil1rjhe/f0EFi1nUbl30Ke/U9V5lBFrK1+lI6ry1fj61zkQK1A6vC2V5tYTyYmUtvN
         Mp8SCrH3b6wFh8+1GIv9foywOWoTepzbNbOxFYsCcIkBNj/wem9ILaC2uhGUk4xDkGB7
         2+eHxFtsK0zgyn240AxmsVGIVgXM8vZiJ4iqlgh2iL/+3y55AkqiwD3umjIlGB2M7tDL
         02OA==
X-Gm-Message-State: ABy/qLYdjmhFgSpwJ4LS4qiiXgw8vKBYSZaRoaXkObNeNgrK/a2Bzgh8
        Im1dF1GhLusODx0AGap3XVEFghUW4GA+IFWpmwYz3457V2wD9bTV9tgqcFfc5188YNOnfayREjt
        B1Zyf5PsDnBgIUQz9DZv9apgF
X-Received: by 2002:a05:600c:20c4:b0:3fb:e054:903f with SMTP id y4-20020a05600c20c400b003fbe054903fmr1237408wmm.36.1689250635418;
        Thu, 13 Jul 2023 05:17:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH4K1xzW6AnUhVBZ0m3bhe20kl+YjcL/Vw7G0f9UZ/hZUDowjjuFLDR26UZuruzxrGYqelQkQ==
X-Received: by 2002:a05:600c:20c4:b0:3fb:e054:903f with SMTP id y4-20020a05600c20c400b003fbe054903fmr1237397wmm.36.1689250635215;
        Thu, 13 Jul 2023 05:17:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c220e00b003fbacc853ccsm7630178wml.18.2023.07.13.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:17:14 -0700 (PDT)
Message-ID: <68392d51-ef9d-e687-f659-983bf2ba237b@redhat.com>
Date:   Thu, 13 Jul 2023 14:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64/mm: Add pte_rdonly() helper
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230713092004.693749-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713092004.693749-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 11:20, Anshuman Khandual wrote:
> This replaces open coding PTE_RDONLY check with a new helper pte_rdonly().
> No functional change is intended here.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.5-rc1
> 
>   arch/arm64/include/asm/pgtable.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 171d6d7f8087..72c2e8431360 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -103,6 +103,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>   #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>   #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
> +#define pte_rdonly(pte)		(!!(pte_val(pte) & PTE_RDONLY))
>   #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
>   #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>   #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
> @@ -120,7 +121,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   	(__boundary - 1 < (end) - 1) ? __boundary : (end);			\
>   })
>   
> -#define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
> +#define pte_hw_dirty(pte)	(pte_write(pte) && !pte_rdonly(pte))
>   #define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
>   #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

