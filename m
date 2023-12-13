Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F528112E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379072AbjLMNbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378978AbjLMNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B99C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702474271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=xy+gGhL7AyEamvAPEfK3bcTxNX+yDMotxm2Egrdrhwk=;
        b=aGENIntpjt+/N54E/5w3R178kIXQ3pBPvDHlT1F+f81eAecDXnSev/Enm87rlKH+38GP0b
        CFu1n7jArlXKO3ImAmSowE9SPBI+6IqitsirzkJBE7wlJIzEgqnSKdCAVim3D5KfdIDG0L
        fh+MXbX/SmSM2yTG20pDG9OHUy8t1TU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-oKa-RXzwNKumiAPPV_qfOA-1; Wed, 13 Dec 2023 08:31:10 -0500
X-MC-Unique: oKa-RXzwNKumiAPPV_qfOA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f6b432d50so321042466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474269; x=1703079069;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xy+gGhL7AyEamvAPEfK3bcTxNX+yDMotxm2Egrdrhwk=;
        b=dvtCvjQV8osDOUobClZzdA9uqmwf1VWlG6hTPlF3c5U57IAdPdnqpfM5A/1DWHaPlw
         OezpP9tkL8GKeEPluPoyw6tSZjkcdHpzqPXXWlvR2R/trVaP+88txhPN6e2RBwyG/lDn
         U2WG+P3EP2jQZSzmhw+zWdE8RY5Q9ycFI/Gy5VTkmLBj84HC5Pf4iC/DhrLu0O3BLxJD
         UfQC1blV0+IsV7EVdVzxhkaqCRmSYYD+rlIZ8Ab0NuYDAdrqAKjKCL8uicTXdf++SdhO
         gqewGBuH2b7FCQ+hpPF0BHJ4uOWudcIHs0clVVsSSrzhL+jpK5QPjP1FPOwBDvsiTKli
         tclg==
X-Gm-Message-State: AOJu0YxFmgz+tySXMyDo2fE0uusmBVU1NqGr5T9cbbIn4QPXyL3lE9Ae
        CIAs1WBseTF4w4f4bt0u3ZhVeBOupNb0yf4XykkTapdN7vICQ4Kw7eIfBjk4vtGiTjgwohysUhn
        Hz1UgqbkaZIbifCbsiJO7fDnu
X-Received: by 2002:a17:906:f905:b0:a1c:8eb6:1478 with SMTP id lc5-20020a170906f90500b00a1c8eb61478mr4138801ejb.57.1702474269351;
        Wed, 13 Dec 2023 05:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJAR9rfNphsHvR0U+BVMfZfb5eR2gjnHHRFdyQ7X1cHqJ+1xkD833QYIbhscR0UDk/FPpEoQ==
X-Received: by 2002:a17:906:f905:b0:a1c:8eb6:1478 with SMTP id lc5-20020a170906f90500b00a1c8eb61478mr4138782ejb.57.1702474269029;
        Wed, 13 Dec 2023 05:31:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id tg10-20020a1709078dca00b00a178b965899sm7819372ejc.100.2023.12.13.05.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:31:08 -0800 (PST)
Message-ID: <40915dc3-4083-4b9f-bc64-7542833566e1@redhat.com>
Date:   Wed, 13 Dec 2023 14:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/50] x86/cpufeatures: Add SEV-SNP CPU feature
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, seanjc@google.com, vkuznets@redhat.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
        nikunj.dadhania@amd.com, pankaj.gupta@amd.com,
        liam.merwick@oracle.com, zhi.a.wang@intel.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-5-michael.roth@amd.com>
 <0b2eb374-356c-46c6-9c4a-9512fbfece7a@redhat.com>
 <20231213131324.GDZXmt9LsMmJZyzCJw@fat_crate.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231213131324.GDZXmt9LsMmJZyzCJw@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 14:13, Borislav Petkov wrote:
> On Wed, Dec 13, 2023 at 01:51:58PM +0100, Paolo Bonzini wrote:
>> On 10/16/23 15:27, Michael Roth wrote:
>>> From: Brijesh Singh <brijesh.singh@amd.com>
>>>
>>> Add CPU feature detection for Secure Encrypted Virtualization with
>>> Secure Nested Paging. This feature adds a strong memory integrity
>>> protection to help prevent malicious hypervisor-based attacks like
>>> data replay, memory re-mapping, and more.
>>>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
>>> Signed-off-by: Ashish Kalra <Ashish.Kalra@amd.com>
>>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>>
>> Queued, thanks.
> 
> Paolo, please stop queueing x86 patches through your tree. I'll give you
> an immutable branch with the x86 bits when the stuff has been reviewed.

Sure, I only queued it because you gave Acked-by for 05/50 and this is 
an obvious dependency.  I would like to get things in as they are ready 
(whenever it makes sense), so if you want to include those two in the 
x86 tree for 6.8, that would work for me.

Paolo

