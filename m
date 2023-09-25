Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7637ADE41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjIYR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjIYR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:59:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5BF116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:59:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814a1f7378so13064947276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695664755; x=1696269555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJxWlaeFBUFVn/06/FuoJQSIZxw1VsUpvNdiZ9TEXR0=;
        b=K2GuvHK6v/YkGbwG2AZvXmDpeBFy3OCEYjMOcr1O4z8G5s431r6T2LUa0ddmqYGNYo
         fhGWYDVwkbgdtp4y8NiZOzHm4+XUsfALwVnm25qD9Ksss8VK1oxRjUHOPpH9UIjZ8/4a
         kJJg0gZasUYp351tbLqA3D8+TRG9Mj9ZC73U1ph1tVcWgrqoKKsOlVWzT1XNPpokkQ13
         X0QRcMqaceztqS5P+k/BAl5srKMsy+0eJFB/+7/RNO0YIB9JnaQAovmMrdXyxSn4cdrQ
         K5uIPtasEd8F+cwa0NLlLlDDTQy0PiejsEqXKuord2cL1uU5GPuH4BcAnburJwFiUv2t
         70Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664755; x=1696269555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJxWlaeFBUFVn/06/FuoJQSIZxw1VsUpvNdiZ9TEXR0=;
        b=rLDulBmXuW7bt8tKfDkokf+bSEdeirxc5M+59n8R84u/1jLPnQInjhbUXaRAebQwuZ
         uXjaonA3/kQ2wTg022R+Sk0wa8OHvy72SveOVZ5Gv5GCjr3Wg6Umag0mT+ESWreHcJMP
         cDZ4b6b63mMzshpDshiChl0X8rU+5XeiLvthmfbPKLRsqp1S0spbA7TH/HejVVOom7/Y
         ZrfI/2YFT+vheeLFrkAzxuLgt5JG/yea/4SNCR1Dd2SjvkcsNfkgoNDbcDfMu2g0pGnp
         t8Wr84qDtrR98IQgMptsOm2X1X4VmsUkxxRa4ajJuTkOGiF2qe0QNKSeKOQA8XLo+X1B
         myeg==
X-Gm-Message-State: AOJu0YwiA692yHX+RY4R5cboqlWAhTSKqqyMyP469zqVASlY0gWzclRY
        WtU1AfG3W3q1WtQHoOyv/NXzrH0LkY0=
X-Google-Smtp-Source: AGHT+IH4oHWHjPU4qeRFiwMM3DfMXR7RMPPIiB7V1ljnzhFTLibjRDbxvxFjVb3qCnTElG+68BBBsArlJEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1347:b0:d81:57ba:4d7a with SMTP id
 g7-20020a056902134700b00d8157ba4d7amr6034ybu.6.1695664754923; Mon, 25 Sep
 2023 10:59:14 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:59:13 -0700
In-Reply-To: <20230925173448.3518223-2-mizhang@google.com>
Mime-Version: 1.0
References: <20230925173448.3518223-1-mizhang@google.com> <20230925173448.3518223-2-mizhang@google.com>
Message-ID: <ZRHKcW6hvujNIYS5@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Synthesize at most one PMI per VM-exit
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>, Roman Kagan <rkagan@amazon.de>,
        Kan Liang <kan.liang@intel.com>,
        Dapeng1 Mi <dapeng1.mi@intel.com>
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

On Mon, Sep 25, 2023, Mingwei Zhang wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> When the irq_work callback, kvm_pmi_trigger_fn(), is invoked during a
> VM-exit that also invokes __kvm_perf_overflow() as a result of
> instruction emulation, kvm_pmu_deliver_pmi() will be called twice
> before the next VM-entry.
> 
> That shouldn't be a problem. The local APIC is supposed to
> automatically set the mask flag in LVTPC when it handles a PMI, so the
> second PMI should be inhibited. However, KVM's local APIC emulation
> fails to set the mask flag in LVTPC when it handles a PMI, so two PMIs
> are delivered via the local APIC. In the common case, where LVTPC is
> configured to deliver an NMI, the first NMI is vectored through the
> guest IDT, and the second one is held pending. When the NMI handler
> returns, the second NMI is vectored through the IDT. For Linux guests,
> this results in the "dazed and confused" spurious NMI message.
> 
> Though the obvious fix is to set the mask flag in LVTPC when handling
> a PMI, KVM's logic around synthesizing a PMI is unnecessarily
> convoluted.

Unless Jim outright objects, I strongly prefer placing this patch second, with
the above two paragraphs replaced with my suggestion (or something similar):

  Calling kvm_pmu_deliver_pmi() twice is unlikely to be problematic now that
  KVM sets the LVTPC mask bit when delivering a PMI.  But using IRQ work to
  trigger the PMI is still broken, albeit very theoretically.

  E.g. if the self-IPI to trigger IRQ work is be delayed long enough for the
  vCPU to be migrated to a different pCPU, then it's possible for
  kvm_pmi_trigger_fn() to race with the kvm_pmu_deliver_pmi() from
  KVM_REQ_PMI and still generate two PMIs.

  KVM could set the mask bit using an atomic operation, but that'd just be
  piling on unnecessary code to workaround what is effectively a hack.  The
  *only* reason KVM uses IRQ work is to ensure the PMI is treated as a wake
  event, e.g. if the vCPU just executed HLT.

I understand Jim's desire for the patch to be more obviously valuable, but the
people that need convincing are already convinced that the patch is worth taking.

> Remove the irq_work callback for synthesizing a PMI, and all of the
> logic for invoking it. Instead, to prevent a vcpu from leaving C0 with
> a PMI pending, add a check for KVM_REQ_PMI to kvm_vcpu_has_events().
> 
> Fixes: 9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Tested-by: Mingwei Zhang <mizhang@google.com>
> Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Needs your SoB
