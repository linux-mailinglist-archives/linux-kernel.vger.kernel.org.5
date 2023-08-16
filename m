Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFF77ED08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbjHPW0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346885AbjHPWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:25:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2581B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:25:43 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6887c55999aso1808759b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692224743; x=1692829543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/nvOfm2IHa8qd34Vr3L4gXJVYEcuL8LeF4EihusksQ=;
        b=veb1brBgyucQ4nd5xpDlx8YFM6NsMMoCuJ2+FbLmZn6qaU5hi0RBaM1pLa1G4sfjf7
         jbZWow6GK/0tgQSapfsH1QAMM55d/HZTS1gEPaaW1Ffm+LJcwGcUpnxx86CxJq9PAGvE
         awLcD2vI5nJgVpOitZDcMBYAM24zfv10ZUwFeWmr9AOtVcOFMrmwsOMaNtx5wsagL5dl
         brfmajkMARTL3BcQidu2HfZa7XyAl6wFxfWTV3aWxagpF5ga/akjOiBxQXxFh60iW8iJ
         lUbrwTsavzSP98mWB2c7KTeQv+rgAJadbRX/XDUzkSDibJWnxG1ZNhSU5pNPbBfZ9NQZ
         s3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224743; x=1692829543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/nvOfm2IHa8qd34Vr3L4gXJVYEcuL8LeF4EihusksQ=;
        b=X7dvkk7JVj+wQ4ETzy6oHp6igxYzIK01Tqf8INfobGGaRvEq6jYX6dOemJb+r0XSt2
         6tyZaBDLqgX7uYs1janXbnD8lmuQyy2J8ezmI0zms05uPuGylYWZSqJlVkJNVhwbtN3d
         /UeQf3Go64EHisAX7yXGkBWCsIQzabO9WJ0dahajBZxRQ/8Ryg+bzDHrv+SWUNpvcsan
         hcALMeEGxvVPt+OAbMCDnATfbRp057kwuX4t9ZsVtcDxfYS//3kx297KlJp5p70isf3d
         B+mu87GB6FGeTlLogIxZ51Q1ISvgBeMjQkRX3XCBMUhFEvGJJ11sT7VdON+E/tjllvhA
         te+A==
X-Gm-Message-State: AOJu0YyanyxUAjINDPsuXQjDwABXtLVugb4Pg/8e4TkizbtbLsONbkl2
        ygmJ9FXZCfRhVKhlgf+7W+YF63VPlYU=
X-Google-Smtp-Source: AGHT+IFa9PZ62sECu8cthHE3iQeobMe1F3rchpz89myrvVrd6R0lfn1gFbOFZOzFka7RMDuuRIPSQR/9Hbk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1393:b0:682:140c:2459 with SMTP id
 t19-20020a056a00139300b00682140c2459mr1500308pfg.0.1692224743379; Wed, 16 Aug
 2023 15:25:43 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:25:41 -0700
In-Reply-To: <20230719144131.29052-1-binbin.wu@linux.intel.com>
Mime-Version: 1.0
References: <20230719144131.29052-1-binbin.wu@linux.intel.com>
Message-ID: <ZN1M5RvuARP1YMfp@google.com>
Subject: Re: [PATCH v10 0/9] Linear Address Masking (LAM) KVM Enabling
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        David.Laight@aculab.com, robert.hu@linux.intel.com,
        guang.zeng@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023, Binbin Wu wrote:
> Binbin Wu (7):
>   KVM: x86/mmu: Use GENMASK_ULL() to define __PT_BASE_ADDR_MASK
>   KVM: x86: Add & use kvm_vcpu_is_legal_cr3() to check CR3's legality
>   KVM: x86: Use KVM-governed feature framework to track "LAM enabled"
>   KVM: x86: Virtualize CR3.LAM_{U48,U57}
>   KVM: x86: Introduce get_untagged_addr() in kvm_x86_ops and call it in
>     emulator
>   KVM: VMX: Implement and wire get_untagged_addr() for LAM
>   KVM: x86: Untag address for vmexit handlers when LAM applicable
> 
> Robert Hoo (2):
>   KVM: x86: Virtualize CR4.LAM_SUP
>   KVM: x86: Expose LAM feature to userspace VMM

Looks good, just needs a bit of re-organination.  Same goes for the LASS series.

For the next version, can you (or Zeng) send a single series for LAM and LASS?
They're both pretty much ready to go, i.e. I don't expect one to hold up the other
at this point, and posting a single series will reduce the probability of me
screwing up a conflict resolution or missing a dependency when applying.

Lastly, a question: is there a pressing need to get LAM/LASS support merged _now_?
E.g. are there are there any publicly available CPUs that support LAM and/or LASS?

If not, I'll wait until v6.7 to grab these, e.g. so that you don't have to rush
madly to turn around the next version, and so that I'm not trying to squeeze too
much stuff in just before the merge window.
