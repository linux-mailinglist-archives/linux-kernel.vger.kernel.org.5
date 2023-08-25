Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D0678906A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjHYVfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjHYVee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:34:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6775B26A2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:34:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8b2d6784so20041917b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692999271; x=1693604071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uW+8MPGUijddwROT2ezz6HlXwwfTBZUARHeJcaBKT4=;
        b=GdUFPMdDIX4jBlvL6IT8YHyeGNTFJztfMLOcD+kmJLR3WnY65my4HF/8x4MkuRnpmZ
         chcCqjvPFrCNPAARMCyJdg/sSUJZ36Myf/4+I84xI24wKfdgqXhn+QycSw4fkVpnfnlD
         MPwYti6q9f1MzK4PiJirzQUfle2fMtwRi0Z8njMDMBZyHXm0Ckpo3xNzwR60kCtGK9Ao
         LsXyD/4o4T6tdFtGMN1mAlO1IhgYCyYblrmhX/CLg6kI8R3BAnJLb5opg8XpmqBWqygW
         V4oFX/7aC5pbX90qGkRmLYoONad2GZOOod4mhu3SbK++DRks98zrWArgBrD0bagm9UDb
         3zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692999271; x=1693604071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uW+8MPGUijddwROT2ezz6HlXwwfTBZUARHeJcaBKT4=;
        b=Dujt2Awr/TYvL/CfyFxyMG6aMogh6ZjSPXqh9/3lLpQSHwhIOw7CYVj3VCFSSfT9UE
         s85JBg9X01MnAUxDbRB6UqJVU50d1BECKpHMobxnNRu/OuHPI3wwjQ8xF68P0El/b4Ca
         yAP5/G2DQv1ExDkGg9ZqBLt91Hz8PDhlGYhhIgjs7b3pjpOM9ZkP7pbNzPh3UMo0apHb
         Ci4ccJS+P0rHn3LAO+dUkFTCKZNvlmlcXZ2NVCCcGgMOQEvOn2tJNS1+P7pZ8E7QWES7
         BDerOsT4qrxVG7bEWMcH297ul/ETUbmjoOQGBEk34FeyvTDAIOvvE+t0TxGiQ1+7lWX0
         /LaQ==
X-Gm-Message-State: AOJu0YxhE4Egp302HsydAQqzkwt+IPsosf0V5NKm3D5XJJiVoRVlCeQZ
        dgINRDx+jksdMIsfyQ63E2JxsEaKWnc=
X-Google-Smtp-Source: AGHT+IHyfMF4T2u+hf5DWuEpXzp6h16L096me6C/2uDuuLXfBmilEE5u2mIK3KizllLbdizDGJFildt7sxI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b660:0:b0:573:5797:4b9e with SMTP id
 h32-20020a81b660000000b0057357974b9emr546413ywk.1.1692999271714; Fri, 25 Aug
 2023 14:34:31 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:34:30 -0700
In-Reply-To: <20230714065631.20869-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230714064656.20147-1-yan.y.zhao@intel.com> <20230714065631.20869-1-yan.y.zhao@intel.com>
Message-ID: <ZOkeZi/Xx+1inver@google.com>
Subject: Re: [PATCH v4 12/12] KVM: x86/mmu: convert kvm_zap_gfn_range() to use
 shared mmu_lock in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        robert.hoo.linux@gmail.com, yuan.yao@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023, Yan Zhao wrote:
> Convert kvm_zap_gfn_range() from holding mmu_lock for write to holding for
> read in TDP MMU and allow zapping of non-leaf SPTEs of level <= 1G.
> TLB flushes are executed/requested within tdp_mmu_zap_spte_atomic() guarded
> by RCU lock.
> 
> GFN zap can be super slow if mmu_lock is held for write when there are
> contentions. In worst cases, huge cpu cycles are spent on yielding GFN by
> GFN, i.e. the loop of "check and flush tlb -> drop rcu lock ->
> drop mmu_lock -> cpu_relax() -> take mmu_lock -> take rcu lock" are entered
> for every GFN.
> Contentions can either from concurrent zaps holding mmu_lock for write or
> from tdp_mmu_map() holding mmu_lock for read.

The lock contention should go away with a pre-check[*], correct?  That's a more
complete solution too, in that it also avoids lock contention for the shadow MMU,
which presumably suffers the same problem (I don't see anything that would prevent
it from yielding).

If we do want to zap with mmu_lock held for read, I think we should convert
kvm_tdp_mmu_zap_leafs() and all its callers to run under read, because unless I'm
missing something, the rules are the same regardless of _why_ KVM is zapping, e.g.
the zap needs to be protected by mmu_invalidate_in_progress, which ensures no other
tasks will race to install SPTEs that are supposed to be zapped.

If you post a version of this patch that converts kvm_tdp_mmu_zap_leafs(), please
post it as a standalone patch.  At a glance it doesn't have any dependencies on the
MTRR changes, and I don't want this type of changed buried at the end of a series
that is for a fairly niche setup.  This needs a lot of scrutiny to make sure zapping
under read really is safe.

[*] https://lore.kernel.org/all/20230825020733.2849862-1-seanjc@google.com

> After converting to hold mmu_lock for read, there will be less contentions
> detected and retaking mmu_lock for read is also faster. There's no need to
> flush TLB before dropping mmu_lock when there're contentions as SPTEs have
> been zapped atomically and TLBs are flushed/flush requested immediately
> within RCU lock.
> In order to reduce TLB flush count, non-leaf SPTEs not greater than 1G
> level are allowed to be zapped if their ranges are fully covered in the
> gfn zap range.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
