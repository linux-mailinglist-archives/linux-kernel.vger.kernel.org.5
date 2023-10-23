Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961EA7D3A05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjJWOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjJWOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:46:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208591FDD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:45:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40837124e1cso110775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698072343; x=1698677143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuPb49Nb7aOChMQEH9g60s/ZbKYpeY4nlEVZ7HXBAiA=;
        b=CYLNIaQNhE2DkcrwXUkdgVf3ZtN7Rv/bUKj/guuKB15zmVpWTqKYuYMKnQe1rL9uX3
         RXInqhcjHcgfZsiRh5yVFDNSJAu4lWExB6vRaUx/vOxFxkZ+syTs6Sw9uUixztBcc7fA
         xUcusAlVS7roKkIvFjbgeT29XgWgfKKRyj4tDLhry8DjgA49Q9OKTKfA0ZTmgym+Qj2/
         8yaUMgDxTCCFCYLx3skrVPPnQMNfGeai/1sNoTwps+jhS8p/RwV/sQzkNQFfumCipkFw
         v6DvVW5K0PeLU5CnTch/IlgycbMeUMCU5xMIbV8/JkVsKcSAruSK+UordbslkioKXhCA
         J4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072343; x=1698677143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuPb49Nb7aOChMQEH9g60s/ZbKYpeY4nlEVZ7HXBAiA=;
        b=RaiILuglQURuLpMtenbh/R6qRzFeHjZklAtHXgsE+kJ0FS9+/l98WtEAJcTsqxSuiz
         YG8T7QjhQhdMCZVhz41kzUZeJLyeMFg7uQgoBvqSDYROTL8N4va4j3HSFdqnxoyflUfJ
         D+vFmWTjga14T0Kcsc/c12VN8paiYhdY77Kp8BQIdyAzcstP1RV1fLgEiKKduKNmzlIT
         ZP/r2OEq4SGMfA7cuHTnGtYgzwiVjZV2oDoHEwKQEEBcHu5OnKd+x8NpfwS+yfZL8EZv
         lcMUrYcoEbJ3tkJbrF5MP4vHTMYHhDPtiBmHN/u49mRxiswZnGvNMqC75LqYVov6XrOV
         HgZQ==
X-Gm-Message-State: AOJu0Yw+Hn8Tlo0NI4wEjLdB8K4Cg5BLuKpthhmTFbuGnoJ/g9nzUVgg
        8mXJsV3tj98+u6tOkqh6vsIPXA==
X-Google-Smtp-Source: AGHT+IHqwhVuneopgxfquyjAU4kAvXwPMoACOMfUTgtwjupQH4aGGKknxjAFoNKlkarZI9e6tEFHlg==
X-Received: by 2002:a05:600c:3b97:b0:408:3725:b96a with SMTP id n23-20020a05600c3b9700b004083725b96amr275253wms.0.1698072343243;
        Mon, 23 Oct 2023 07:45:43 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b003232f167df5sm7888468wrx.108.2023.10.23.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:45:42 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:45:41 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v2 11/11] arm64: ptdump: Add support for guest stage-2
 pagetables dumping
Message-ID: <ZTaHFQotXvRWad3Y@google.com>
References: <20231019144032.2943044-1-sebastianene@google.com>
 <20231019144032.2943044-13-sebastianene@google.com>
 <ZTI85i0PmI_6doz1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTI85i0PmI_6doz1@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:40:06AM +0100, Vincent Donnefort wrote:
> On Thu, Oct 19, 2023 at 02:40:33PM +0000, Sebastian Ene wrote:
> > Register a debugfs file on guest creation to be able to view their
> > second translation tables with ptdump. This assumes that the host is in
> > control of the guest stage-2 and has direct access to the pagetables.
> 
> What about pKVM? The walker you wrote for the host stage-2 should be
> reusable in that case?
> 

Yes, when pKVM will be ready upstream the walker which duplicates the
pagetables for the host will be re-used for the guests. We will have to
add a separate HVC for this which receives as an argument the guest
vmid.

> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/include/asm/ptdump.h | 21 +++++++--
> >  arch/arm64/kvm/mmu.c            |  3 ++
> >  arch/arm64/mm/ptdump.c          | 84 +++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/ptdump_debugfs.c  |  5 +-
> >  4 files changed, 108 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> > index 35b883524462..be86244d532b 100644
> > --- a/arch/arm64/include/asm/ptdump.h
> > +++ b/arch/arm64/include/asm/ptdump.h
> > @@ -5,6 +5,8 @@
> >  #ifndef __ASM_PTDUMP_H
> >  #define __ASM_PTDUMP_H
> >  
> > +#include <asm/kvm_pgtable.h>
> > +
> >  #ifdef CONFIG_PTDUMP_CORE
> >  
> >  #include <linux/mm_types.h>
> > @@ -30,14 +32,27 @@ struct ptdump_info {
> >  void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
> >  #ifdef CONFIG_PTDUMP_DEBUGFS
> >  #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
> > -void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> > +struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
> > +				       const char *name);
> >  #else
> > -static inline void ptdump_debugfs_register(struct ptdump_info *info,
> > -					   const char *name) { }
> > +static inline struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
> > +						     const char *name)
> > +{
> > +	return NULL;
> > +}
> >  #endif
> >  void ptdump_check_wx(void);
> >  #endif /* CONFIG_PTDUMP_CORE */
> >  
> > +#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
> > +void ptdump_register_guest_stage2(struct kvm_pgtable *pgt, void *lock);
> > +void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt);
> > +#else
> > +static inline void ptdump_register_guest_stage2(struct kvm_pgtable *pgt,
> > +						void *lock) { }
> > +static inline void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt) { }
> > +#endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
> 
> I believe this should be compatible with VHE as well, that option should be
> renamed.
> 

Good point, I will rename this.

> > +
> >  #ifdef CONFIG_DEBUG_WX
> >  #define debug_checkwx()	ptdump_check_wx()
> >  #else
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 482280fe22d7..e47988dba34d 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <trace/events/kvm.h>
> >  #include <asm/pgalloc.h>
> > +#include <asm/ptdump.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/kvm_arm.h>
> >  #include <asm/kvm_mmu.h>
> > @@ -908,6 +909,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
> >  	if (err)
> >  		goto out_free_pgtable;
> >  
> > +	ptdump_register_guest_stage2(pgt, &kvm->mmu_lock);
> >  	mmu->last_vcpu_ran = alloc_percpu(typeof(*mmu->last_vcpu_ran));
> >  	if (!mmu->last_vcpu_ran) {
> >  		err = -ENOMEM;
> > @@ -1021,6 +1023,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
> >  	write_unlock(&kvm->mmu_lock);
> >  
> >  	if (pgt) {
> > +		ptdump_unregister_guest_stage2(pgt);
> >  		kvm_pgtable_stage2_destroy(pgt);
> >  		kfree(pgt);
> >  	}
> > diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> > index 4687840dcb69..facfb15468f5 100644
> > --- a/arch/arm64/mm/ptdump.c
> > +++ b/arch/arm64/mm/ptdump.c
> > @@ -26,6 +26,7 @@
> >  #include <asm/ptdump.h>
> >  #include <asm/kvm_pkvm.h>
> >  #include <asm/kvm_pgtable.h>
> > +#include <asm/kvm_host.h>
> >  
> >  
> >  enum address_markers_idx {
> > @@ -543,6 +544,22 @@ void ptdump_check_wx(void)
> >  #ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
> >  static struct ptdump_info stage2_kernel_ptdump_info;
> >  
> > +#define GUEST_NAME_LEN	(32U)
> > +
> > +struct ptdump_registered_guest {
> > +	struct list_head		reg_list;
> > +	struct ptdump_info		info;
> > +	struct mm_struct		mem;
> > +	struct kvm_pgtable_snapshot	snapshot;
> > +	struct dentry			*dentry;
> > +	rwlock_t			*lock;
> > +	char				reg_name[GUEST_NAME_LEN];
> > +};
> > +
> > +static LIST_HEAD(ptdump_guest_list);
> > +static DEFINE_MUTEX(ptdump_list_lock);
> > +static u16 guest_no;
> 
> This is not robust enough: If 1 VM starts then 65535 others which are killed.
> guest_no overflows. The next number is 0 which is already taken.
>

Yes, I guess this should be improved. In the case you described we won't
register any debugfs file because of the name clash.

> Linux has and ID allocation to solve this problem, but I don't think this is
> necessary anyway. This should simply reuse the struct kvm->debugfs_dentry.
> 
> Also probably most of the informations contained in ptdump_registered_guest can
> be found in struct kvm. The debugfs should then probably simply take struct kvm
> for the private argument.
>

I would prefer to keep it as a separate struct here as it gives some
flexibility if we need to extend it for guests pKVM support. I think we
can drop the struct mm_struct from here.

Thanks,
Sebastian

> > +
> >  static phys_addr_t ptdump_host_pa(void *addr)
> >  {
> >  	return __pa(addr);
> > @@ -740,6 +757,73 @@ static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
> >  
> >  	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
> >  }
> 
> [...]
