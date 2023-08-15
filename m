Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19A077D5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjHOWaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbjHOWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:30:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A81FF0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:30:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so11527967276.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692138610; x=1692743410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sZ2KVcNcsekfiyOLDchFCWiNwVhcB+6K151wSFXsRU=;
        b=Sdk8hg1CZo0UZyPRUXVdkK75UBWBJbL5ssV4qfSNcJ0yLv5eoBjQS4ikTylrgvjRg5
         fAMh6d0O8KCRFHTNCYjLyKwda9Worh9IOHwLdjyjr43jpwYw1T/I0j2MIMowNRlDO5I8
         seJUbGeGRi1534R52LzEYYDDd5ijl0Ycakp7SKP7ACJxBKwO5q+1sd6EI3OyWGK24CgX
         jnL6doBdY30gIbx8RPMUELSJ79bpzsOBy12TJfrWjd52P0gtLnjQyB6B7osJCqozOqtW
         mlUSNNG5Lq0KPPvS7OkMRg41GasfSw3x8Ne19ql/oMstCF4KKqyTw1HO8U30XcK6asyE
         9NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138610; x=1692743410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sZ2KVcNcsekfiyOLDchFCWiNwVhcB+6K151wSFXsRU=;
        b=SgBETWlvrm9foETH9B+v2rZfF5K0ugJaePWS+Wm5e09MM0U77O9xWYhenKcgyQyJS0
         dfIk74gSXJI4UM+YtAqy2ofDn/IIMlyRO7wEYTPmI0G6IE7+3TOMqS7UFl9qLDpbjb31
         CJARR8seZeKnx8Iwo6L++mR0jNeB+R7l7FTUENNV36PjX/Uy5qcZlBbb0N6V1tg7cc7u
         dgt1jEo3Yb6A0sKmrtqHFjzeblfBUNOlcT16zSpIfwAulhgfC4GMMnCKzdtbio+Xe5uB
         Di19zpUxnJVLoxIvYqC23LqTa1Ja1pyo2k6mRg/vGc0V/0TIxCgt0WxtfSGAwIjSfzki
         hX7g==
X-Gm-Message-State: AOJu0YyuSoT7t1S6umdaKA7c9bi0PG/3QpmoP7pcdSiS52f60WQ18SOi
        6v3yDEu2gCRDdlpXrTIO6IEqJPuEYVM=
X-Google-Smtp-Source: AGHT+IG84S1z3EOk6278E7swEnxMzcYiiiMN3uMBAf/Zzr7Ij9WLl4fIHdZlEc+ZYkT7nZQXafm39o4AAu0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:24cc:0:b0:d10:a33d:36b6 with SMTP id
 k195-20020a2524cc000000b00d10a33d36b6mr55769ybk.0.1692138610358; Tue, 15 Aug
 2023 15:30:10 -0700 (PDT)
Date:   Tue, 15 Aug 2023 15:30:08 -0700
In-Reply-To: <20230811045127.3308641-6-rananta@google.com>
Mime-Version: 1.0
References: <20230811045127.3308641-1-rananta@google.com> <20230811045127.3308641-6-rananta@google.com>
Message-ID: <ZNv8cCzI9fMWkGWT@google.com>
Subject: Re: [PATCH v9 05/14] KVM: Allow range-based TLB invalidation from
 common code
From:   Sean Christopherson <seanjc@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023, Raghavendra Rao Ananta wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index ec169f5c7dce2..00f7bda9202f2 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -278,16 +278,14 @@ static inline bool kvm_available_flush_remote_tlbs_range(void)
>  	return kvm_x86_ops.flush_remote_tlbs_range;
>  }
>  
> -void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn,
> -				 gfn_t nr_pages)
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_pages)
>  {
>  	int ret = -EOPNOTSUPP;
>  
>  	if (kvm_x86_ops.flush_remote_tlbs_range)
> -		ret = static_call(kvm_x86_flush_remote_tlbs_range)(kvm, start_gfn,
> -								   nr_pages);
> -	if (ret)
> -		kvm_flush_remote_tlbs(kvm);
> +		ret = static_call(kvm_x86_flush_remote_tlbs_range)(kvm, gfn, nr_pages);
> +
> +	return ret;

Please write this as

	if (kvm_x86_ops.flush_remote_tlbs_range)
		return static_call(kvm_x86_flush_remote_tlbs_range)(kvm, gfn, nr_pages);

	return -EOPNOTSUPP;

or alternatively

	if (!kvm_x86_ops.flush_remote_tlbs_range)
		return -EOPNOTSUPP;

	return static_call(kvm_x86_flush_remote_tlbs_range)(kvm, gfn, nr_pages);

Hmm, I'll throw my official vote for the second version.

The local "ret" is unnecessary and is suprisingly dangerous.  I screwed up the
conflict resolution when cherry-picking my CONFIG_HYPERV change to see what the
conflict looked like and ended up with a double flush:

	int ret = -EOPNOTSUPP;

	if (kvm_x86_ops.flush_remote_tlbs_range)
		ret = static_call(kvm_x86_flush_remote_tlbs_range)(kvm, gfn, nr_pages);

	if (ret)
		kvm_flush_remote_tlbs(kvm);

	return ret;

Dropping "ret" makes it much harder to get trigger happy when resolving conflicts.

No need for a new version to fix the above, assuming Marc/Oliver is ok doing
fixup when applying.

Nit aside, looks good for x86, and I know of no conflicts, so take 'er away!

Acked-by: Sean Christopherson <seanjc@google.com>
