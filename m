Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ABE7E083B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjKCSfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344848AbjKCSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DED62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699036465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DV/S7omvhbYwHDnUY6vpZhv1/f8zjD3mp2JOTCN8Wks=;
        b=L+YarWT0en3Wq2bmLPxSh2mLNI1zjqiimsc5jupgDMWOzwtMMYQguPcY/EZk4zE3+CjuoA
        zML8NtpaiYBcu9+yac1GaOA4kjPeL96Ij0FzvcWQg08Hp3J3DoFvwfUC+P6CDe6bsxL1hP
        20VtM3P+bXMr8hfu8BSbGxS7bYq5dps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-mznbR1QcNBW1Q2LUhIFg0A-1; Fri, 03 Nov 2023 14:34:24 -0400
X-MC-Unique: mznbR1QcNBW1Q2LUhIFg0A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40855a91314so15643325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 11:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699036463; x=1699641263;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV/S7omvhbYwHDnUY6vpZhv1/f8zjD3mp2JOTCN8Wks=;
        b=DMaJQLV+oIDuSXaYk/iUyQtAaRD1gbnF4MXL9AvYs74PWWEnDMDbr+4w/kZ1yh1ytK
         TdHCrorPZEiCsJGnzDjsfmBdCfLyE79WQlfSn3Cpj9utu679v8mbl/fJxojMDX+H+bLj
         y3zbgiGnXmDzIcZ7TWG+zwb9jLyaPOKJL1tzFE0j4ZI3z+/z0IM9i6+xU0WM+QPxz6lH
         NiFGs5ZoO34OhFQgGa+vRSFp9nsdGygmCcFX6OHUvZjutbG2RCGOj9dS2rvPlLZJ2D8K
         MLjwYDkf0NbxkjesMbkutpfgX4pzlTZPm/RVtTArK1Y0Dj3f4mO0B0kpQAeU/WZH3pj+
         6bqQ==
X-Gm-Message-State: AOJu0YzfOJL88CDO+xmdU34WT8vX4iUPVKzPAWV3i//p/M1LB7hXt7mU
        2/yohdH6BpgbRyMgl9k5Pk+B4Yv4c+DfvGtssNlfoHLrqcNYUknVyvHvvsAMBb4/eyu8tL34ukw
        FrS4V7xDUAmr1grmagWwBByM3
X-Received: by 2002:a05:600c:45c7:b0:408:33ba:569a with SMTP id s7-20020a05600c45c700b0040833ba569amr3931095wmo.8.1699036462913;
        Fri, 03 Nov 2023 11:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyc4iwNN/kw5lj/CPevnsornB6J2TBuuGtLonHd599AUj7KWLDowZbKt4+1pFfFurjpot9XA==
X-Received: by 2002:a05:600c:45c7:b0:408:33ba:569a with SMTP id s7-20020a05600c45c700b0040833ba569amr3931068wmo.8.1699036462450;
        Fri, 03 Nov 2023 11:34:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:a600:bc48:cd31:d01f:f468? (p200300cbc70aa600bc48cd31d01ff468.dip0.t-ipconnect.de. [2003:cb:c70a:a600:bc48:cd31:d01f:f468])
        by smtp.gmail.com with ESMTPSA id er14-20020a05600c84ce00b0040472ad9a3dsm3182989wmb.14.2023.11.03.11.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 11:34:22 -0700 (PDT)
Message-ID: <c05841de-d1d9-406b-a143-f1e3662d99b9@redhat.com>
Date:   Fri, 3 Nov 2023 19:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] KVM: s390: vsie: Fix length of facility list shadowed
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc:     Cornelia Huck <cornelia.huck@de.ibm.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Mueller <mimu@linux.vnet.ibm.com>
References: <20231103173008.630217-1-nsg@linux.ibm.com>
 <20231103173008.630217-3-nsg@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231103173008.630217-3-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.23 18:30, Nina Schoetterl-Glausch wrote:
> The length of the facility list accessed when interpretively executing
> STFLE is the same as the hosts facility list (in case of format-0)
> When shadowing, copy only those bytes.
> The memory following the facility list need not be accessible, in which
> case we'd wrongly inject a validity intercept.
> 
> Fixes: 66b630d5b7f2 ("KVM: s390: vsie: support STFLE interpretation")
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   arch/s390/include/asm/facility.h |  6 ++++++
>   arch/s390/kernel/Makefile        |  2 +-
>   arch/s390/kernel/facility.c      | 18 ++++++++++++++++++
>   arch/s390/kvm/vsie.c             | 12 +++++++++++-
>   4 files changed, 36 insertions(+), 2 deletions(-)
>   create mode 100644 arch/s390/kernel/facility.c
> 
> diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
> index 94b6919026df..796007125dff 100644
> --- a/arch/s390/include/asm/facility.h
> +++ b/arch/s390/include/asm/facility.h
> @@ -111,4 +111,10 @@ static inline void stfle(u64 *stfle_fac_list, int size)
>   	preempt_enable();
>   }
>   
> +/**
> + * stfle_size - Actual size of the facility list as specified by stfle
> + * (number of double words)
> + */
> +unsigned int stfle_size(void);
> +
>   #endif /* __ASM_FACILITY_H */
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 0df2b88cc0da..0daa81439478 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -41,7 +41,7 @@ obj-y	+= sysinfo.o lgr.o os_info.o
>   obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
>   obj-y	+= entry.o reipl.o kdebugfs.o alternative.o
>   obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
> -obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o
> +obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o facility.o
>   
>   extra-y				+= vmlinux.lds
>   
> diff --git a/arch/s390/kernel/facility.c b/arch/s390/kernel/facility.c
> new file mode 100644
> index 000000000000..c33a95a562da
> --- /dev/null
> +++ b/arch/s390/kernel/facility.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corp. 2023
> + */
> +
> +#include <asm/facility.h>
> +
> +unsigned int stfle_size(void)
> +{
> +	static unsigned int size = 0;
> +	u64 dummy;
> +
> +	if (!size) {
> +		size = __stfle_asm(&dummy, 1) + 1;
> +	}
> +	return size;
> +}
> +EXPORT_SYMBOL(stfle_size);

Possible races? Should have to use an atomic?

No access to documentation, but sounds plausible.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

