Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA9752108
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjGMMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjGMMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD312701
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689250633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/8LqiC6QlUvXSN10idrMxAvpQIqE3LX2fGViAlsLns=;
        b=WczQiEu6RfxmUi1b+EZ9aaLYtjgccfnkrOwqWbViI/U49duwhePDgogWO1IK5oTXIp8LQV
        jmhdU9bMY7r/c0EoIdwBOuMRcZDz5Bi9MDU0DilK/goM3i8p8+Ap1zcRh5gJigmbwCfx46
        aFENYcBAyGmPrO03rr2j5l5qzKMLW3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-0G5kQDoXNQa7I7OtjZpW0Q-1; Thu, 13 Jul 2023 08:17:09 -0400
X-MC-Unique: 0G5kQDoXNQa7I7OtjZpW0Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa979d0c32so3462705e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689250628; x=1691842628;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/8LqiC6QlUvXSN10idrMxAvpQIqE3LX2fGViAlsLns=;
        b=LLxyP88VTzHd0EMcpDaUZwEB6DegUxLFtRM//kvzMJ/xNa4kkUw5laUofvCSa7mUWV
         JDAaqH7qYsu8T9cJBxpwAy3PwIbl8FPEdCm57fMy3hL49GNA+a+eC4ON9d6SYYScjrvQ
         zAtTXfzmv8QcWOFSikD4dapeGWxZHYXqOMo+5LzzAi9AUM60rzG6SDWKON7Qg4ygFbfg
         9bkgj4kqHxN3zxAAbufEQ/lltfjoOR10GyqQaD/EaOwGD0Ws/wACT1S/MAzPd75aaRcP
         ejw3p48Ut/Ry4lYtDk9huG76SFkzG9z3sXdNQzMXpgAS7rOVlxVM0Ch4brSCdsFfNgR9
         9hoQ==
X-Gm-Message-State: ABy/qLZGPitLPoK5qu9cQkDlrylY/Vg+MNZ1KB3PK8kczfL+0ZTRJVE2
        Va5j3XtdiOjXNa6RqCmB/kaF833FKfP9mHkmwxA2w35npCOyb37nQDkcx/88TLI+iFAevz2xxdh
        tW/yJN44Ao+dmNg58p1d/wybHE6rfVXYm
X-Received: by 2002:a1c:7414:0:b0:3fb:ba04:6d5d with SMTP id p20-20020a1c7414000000b003fbba046d5dmr1255202wmc.12.1689250628190;
        Thu, 13 Jul 2023 05:17:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpx3LU8EUsWQF1DZWtF+CPMES9CCsA5X6eHyVTsaP8JeTZuKPHy0iS78dQFv5unRikPNa1Ug==
X-Received: by 2002:a1c:7414:0:b0:3fb:ba04:6d5d with SMTP id p20-20020a1c7414000000b003fbba046d5dmr1255182wmc.12.1689250627780;
        Thu, 13 Jul 2023 05:17:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fbe561f6a3sm18254150wmh.37.2023.07.13.05.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:17:07 -0700 (PDT)
Message-ID: <24920ffd-1afa-e791-f8ae-c2eb801afd34@redhat.com>
Date:   Thu, 13 Jul 2023 14:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64/mm: Set only the PTE_DIRTY bit while preserving the
 HW dirty state
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230713071518.628440-1-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713071518.628440-1-anshuman.khandual@arm.com>
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

On 13.07.23 09:15, Anshuman Khandual wrote:
> pte_mkdirty() creates dirty states both in SW and HW bits, which is really
> not required, either in pte_wrprotect() or pte_modify() for preserving the
> HW dirty state. Because pte_mkdirty() sets PTE_DIRTY and clears PTE_RDONLY
> as pte_write() always evaluates to be true - otherwise pte_hw_dirty() will
> not test out in the first place. Clearing PTE_RDONLY again is not required
> here because the pte is already in pte_hw_dirty() but might soon loose its
> dirty state thus requiring preservation in SW dirty bit i.e PTE_DIRTY.
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
>   arch/arm64/include/asm/pgtable.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0bd18de9fd97..171d6d7f8087 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -212,7 +212,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
>   	 * clear), set the PTE_DIRTY bit.
>   	 */
>   	if (pte_hw_dirty(pte))
> -		pte = pte_mkdirty(pte);
> +		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
>   
>   	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
>   	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> @@ -823,7 +823,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>   			      PTE_ATTRINDX_MASK;
>   	/* preserve the hardware dirty information */
>   	if (pte_hw_dirty(pte))
> -		pte = pte_mkdirty(pte);
> +		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
> +
>   	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
>   	return pte;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

