Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7E7D0AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376493AbjJTIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376458AbjJTIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:40:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D979D46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:40:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso9788045e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697791211; x=1698396011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyWHa/QB8NjRGYd7Kdth0egvi9lD9HQW7X6C8NUiI8w=;
        b=R6Q9CvowKhcmQWW1f2rva1p1n7DN2FMihksDL7sAFzNUe9N4p318YE0L8GeXhZscMJ
         c0MZdOtzCr+NiOUcbo1QusvUM3k40bdiqTEjn8fOVmZOY8AW3FKn+1fNItDHuDFz9aEg
         gFW5QbmdAznI6XpAGeM+eyYDw0IkyBPwcK0GVGnQfcVZYEAboxhmPdbMbmXUk0YTduiN
         HVyp3ALN8aywww0upNGlEmKDZxuKV06gl7wqFVbmJZnYpHYBKNYUxSGdXZgGk7nB0QMS
         BFVlC7Xq8pInPMZKBwW4tBJZB/KRH5egPWGLgph4jh/Vnnq0Wk3eSrB6nO+6s5AarIuz
         BJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697791211; x=1698396011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyWHa/QB8NjRGYd7Kdth0egvi9lD9HQW7X6C8NUiI8w=;
        b=EwG6w3KJ7z4y8xmAovQ6n+o/NH4BlXpIzCy2ib/M/TTq4cVu5t2ykqbGRlxuxDOCdy
         40oJDubzJtL66y/kXVOW6gf8eAabmhu401MyxPYvMsiOoGR0Z06jdhdak0BKS/Slzevp
         3v66dYmGB0vv/iin+XKgna8G0KuBoD3JDSqRDCXF1xAHXELShV+ir2sUZ+D42pTlparb
         tp7TWFnZNjAme3Qvfd+iiCtBekfp0H1ZE84ePVYEVRdgW/cG2x0bUfO98ircqLU7jjy3
         KCIXUdlua3XZl2ZNpJr1l+EOhJDjsOUtpT3/Y/vuXVef6jK/JwLPXEiUHd2AMzVwY9fP
         wXlg==
X-Gm-Message-State: AOJu0Yx1hlFFc5KEEgRZJMMcQ7WrEkwnFTY8IOLEMfCJS6Q8GcTnTiDQ
        5+/VkKJiDN+j5seAs9Qnpzlb+w==
X-Google-Smtp-Source: AGHT+IGe62Ste2VstOvjYH0ZAedP5PLzGr5YmyGE8u3E0mTEelJwHqktcfhkfiSIxhwAUpDgwHnIjQ==
X-Received: by 2002:a05:600c:b4d:b0:408:33ba:569a with SMTP id k13-20020a05600c0b4d00b0040833ba569amr4301728wmr.8.1697791210584;
        Fri, 20 Oct 2023 01:40:10 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b00405bbfd5d16sm1635616wmq.7.2023.10.20.01.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:40:10 -0700 (PDT)
Date:   Fri, 20 Oct 2023 09:40:06 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v2 11/11] arm64: ptdump: Add support for guest stage-2
 pagetables dumping
Message-ID: <ZTI85i0PmI_6doz1@google.com>
References: <20231019144032.2943044-1-sebastianene@google.com>
 <20231019144032.2943044-13-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019144032.2943044-13-sebastianene@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:40:33PM +0000, Sebastian Ene wrote:
> Register a debugfs file on guest creation to be able to view their
> second translation tables with ptdump. This assumes that the host is in
> control of the guest stage-2 and has direct access to the pagetables.

What about pKVM? The walker you wrote for the host stage-2 should be
reusable in that case?

> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/include/asm/ptdump.h | 21 +++++++--
>  arch/arm64/kvm/mmu.c            |  3 ++
>  arch/arm64/mm/ptdump.c          | 84 +++++++++++++++++++++++++++++++++
>  arch/arm64/mm/ptdump_debugfs.c  |  5 +-
>  4 files changed, 108 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 35b883524462..be86244d532b 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -5,6 +5,8 @@
>  #ifndef __ASM_PTDUMP_H
>  #define __ASM_PTDUMP_H
>  
> +#include <asm/kvm_pgtable.h>
> +
>  #ifdef CONFIG_PTDUMP_CORE
>  
>  #include <linux/mm_types.h>
> @@ -30,14 +32,27 @@ struct ptdump_info {
>  void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
>  #ifdef CONFIG_PTDUMP_DEBUGFS
>  #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
> -void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
> +				       const char *name);
>  #else
> -static inline void ptdump_debugfs_register(struct ptdump_info *info,
> -					   const char *name) { }
> +static inline struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
> +						     const char *name)
> +{
> +	return NULL;
> +}
>  #endif
>  void ptdump_check_wx(void);
>  #endif /* CONFIG_PTDUMP_CORE */
>  
> +#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
> +void ptdump_register_guest_stage2(struct kvm_pgtable *pgt, void *lock);
> +void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt);
> +#else
> +static inline void ptdump_register_guest_stage2(struct kvm_pgtable *pgt,
> +						void *lock) { }
> +static inline void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt) { }
> +#endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */

I believe this should be compatible with VHE as well, that option should be
renamed.

> +
>  #ifdef CONFIG_DEBUG_WX
>  #define debug_checkwx()	ptdump_check_wx()
>  #else
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 482280fe22d7..e47988dba34d 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -11,6 +11,7 @@
>  #include <linux/sched/signal.h>
>  #include <trace/events/kvm.h>
>  #include <asm/pgalloc.h>
> +#include <asm/ptdump.h>
>  #include <asm/cacheflush.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_mmu.h>
> @@ -908,6 +909,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
>  	if (err)
>  		goto out_free_pgtable;
>  
> +	ptdump_register_guest_stage2(pgt, &kvm->mmu_lock);
>  	mmu->last_vcpu_ran = alloc_percpu(typeof(*mmu->last_vcpu_ran));
>  	if (!mmu->last_vcpu_ran) {
>  		err = -ENOMEM;
> @@ -1021,6 +1023,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>  	write_unlock(&kvm->mmu_lock);
>  
>  	if (pgt) {
> +		ptdump_unregister_guest_stage2(pgt);
>  		kvm_pgtable_stage2_destroy(pgt);
>  		kfree(pgt);
>  	}
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 4687840dcb69..facfb15468f5 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -26,6 +26,7 @@
>  #include <asm/ptdump.h>
>  #include <asm/kvm_pkvm.h>
>  #include <asm/kvm_pgtable.h>
> +#include <asm/kvm_host.h>
>  
>  
>  enum address_markers_idx {
> @@ -543,6 +544,22 @@ void ptdump_check_wx(void)
>  #ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
>  static struct ptdump_info stage2_kernel_ptdump_info;
>  
> +#define GUEST_NAME_LEN	(32U)
> +
> +struct ptdump_registered_guest {
> +	struct list_head		reg_list;
> +	struct ptdump_info		info;
> +	struct mm_struct		mem;
> +	struct kvm_pgtable_snapshot	snapshot;
> +	struct dentry			*dentry;
> +	rwlock_t			*lock;
> +	char				reg_name[GUEST_NAME_LEN];
> +};
> +
> +static LIST_HEAD(ptdump_guest_list);
> +static DEFINE_MUTEX(ptdump_list_lock);
> +static u16 guest_no;

This is not robust enough: If 1 VM starts then 65535 others which are killed.
guest_no overflows. The next number is 0 which is already taken.

Linux has and ID allocation to solve this problem, but I don't think this is
necessary anyway. This should simply reuse the struct kvm->debugfs_dentry.

Also probably most of the informations contained in ptdump_registered_guest can
be found in struct kvm. The debugfs should then probably simply take struct kvm
for the private argument.

> +
>  static phys_addr_t ptdump_host_pa(void *addr)
>  {
>  	return __pa(addr);
> @@ -740,6 +757,73 @@ static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>  
>  	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
>  }

[...]
