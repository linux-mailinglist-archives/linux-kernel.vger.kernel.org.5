Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A835577E88E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbjHPSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbjHPSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:18:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DD103
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:18:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589c6dc8670so68666047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692209885; x=1692814685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXxRBaG/7C39q8QfOMzFIFN6H9+oI0/uBJAQeq/h5EU=;
        b=EhJJXHdcvgHtnujhZgueOVU/VQ3e+vzCz+M0sQ57t7BnkxNY0orB+Ks8ipsA3PTnr4
         cW4RsOsPo5UYW7XZC7Fk8sld7eVXNfJA2T1CqQ/FyV99HTkJmyVdIchZC9qt+iEK7U5g
         lLkAWJvvG5ftl2hZ6/Mgf3FcFsFSMwVdqGk5tKliMDrE56o8ydWTFkXo41zX1iAeEhXQ
         rx9YWbwcF1C1bnoH44o9e+PaeonlqZgYNWUpJIlsLGMg6ulDctjSxtrYg9Yd7MFox8wr
         2V2z2MlVhMCAzygnTDcQtO+jP01QYV7clGfnyOcNT6HMj3gsdesQ2cNZpdQ74RqZmqoI
         cKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209885; x=1692814685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXxRBaG/7C39q8QfOMzFIFN6H9+oI0/uBJAQeq/h5EU=;
        b=Oqkkyaz103EwwMMElsoK3xUu0ejEyrhsyYy4j4FUfI9nkiqfHOTfWqnHHOFEVSjYpF
         c9BJXdU8MiYcOBH+Xkqzda30dDYARlGZYCAxklQAXA+5ETGeMuzf2PfhpWy9hviR0Aiv
         BGlLMB8iHV78PsLcX1i1143LX+nOmr1y4eWzp+myxmozVriYD/iWK4qM5QchbkqJq3FM
         po1YdWng7NH3v1DBKFM+5Mwzohj3fdXqRgsKdDAXSUtA/3K5q+McqQxHcpPs2jnPW6vo
         bNknF6Y7yW0/4Mnw/1hxQhFwuF+ci+0Jx2aP6Sg+45TBC9xLhi0F3vDZJh0MWmGr96gZ
         iiew==
X-Gm-Message-State: AOJu0Yzpy1E5a2g9ZpgeutZRfKd/gjb8mjj69gCHzQdz+LaGRpOaQh80
        uq3t+axVMeXDVLiqqftoulVQ4Sz3tzU=
X-Google-Smtp-Source: AGHT+IGZdHb3EZF4FCzIDthUinhJRSp/dZ+DvqXJPXfoBQOkqbbRHsJzpmudvn8DOxLk9KkbOL0+8AuDMT8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e70c:0:b0:584:61df:9b1b with SMTP id
 x12-20020a81e70c000000b0058461df9b1bmr36464ywl.2.1692209885016; Wed, 16 Aug
 2023 11:18:05 -0700 (PDT)
Date:   Wed, 16 Aug 2023 11:18:03 -0700
In-Reply-To: <20230808085056.14644-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230808085056.14644-1-yan.y.zhao@intel.com>
Message-ID: <ZN0S28lkbo6+D7aF@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: .change_pte() optimization in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
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

On Tue, Aug 08, 2023, Yan Zhao wrote:
> This series optmizes KVM mmu notifier.change_pte() handler in x86 TDP MMU
> (i.e. kvm_tdp_mmu_set_spte_gfn()) by removing old dead code and prefetching
> notified new PFN into SPTEs directly in the handler.
> 
> As in [1], .change_pte() has been dead code on x86 for 10+ years.
> Patch 1 drops the dead code in x86 TDP MMU to save cpu cycles and prepare
> for optimization in TDP MMU in patch 2.

If we're going to officially kill the long-dead attempt at optimizing KSM, I'd
strongly prefer to rip out .change_pte() entirely, i.e. kill it off in all
architectures and remove it from mmu_notifiers.  The only reason I haven't proposed
such patches is because I didn't want to it to backfire and lead to someone trying
to resurrect the optimizations for KSM.

> Patch 2 optimizes TDP MMU's .change_pte() handler to prefetch SPTEs in the
> handler directly with PFN info contained in .change_pte() to avoid that
> each vCPU write that triggers .change_pte() must undergo twice VMExits and
> TDP page faults.

IMO, prefaulting guest memory as writable is better handled by userspace, e.g. by
using QEMU's prealloc option.  It's more coarse grained, but at a minimum it's
sufficient for improving guest boot time, e.g. by preallocating memory below 4GiB.

And we can do even better, e.g. by providing a KVM ioctl() to allow userspace to
prefault memory not just into the primary MMU, but also into KVM's MMU.  Such an
ioctl() is basically manadatory for TDX, we just need to morph the support being
added by TDX into a generic ioctl()[*]

Prefaulting guest memory as writable into the primary MMU should be able to achieve
far better performance than hooking .change_pte(), as it will avoid the mmu_notifier
invalidation, e.g. won't trigger taking mmu_lock for write and the resulting remote
TLB flush(es).  And a KVM ioctl() to prefault into KVM's MMU should eliminate page
fault VM-Exits entirely.

Explicit prefaulting isn't perfect, but IMO the value added by prefetching in
.change_pte() isn't enough to justify carrying the hook and the code in KVM.

[*] https://lore.kernel.org/all/ZMFYhkSPE6Zbp8Ea@google.com
