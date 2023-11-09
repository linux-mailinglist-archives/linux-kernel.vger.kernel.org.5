Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789A17E6D28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjKIPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjKIPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:19:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD023590
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:19:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9aeb4962so1161059276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699543168; x=1700147968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QjzZFTKwtqihTElGETV0lGXwGv/SmVMdX4dMdC65J4=;
        b=dvAIUcMhHIaGvWt0rsUlMOCZdIIDxtBfsRkNzduYREEXP992FRywvpr8nYvea3II6l
         gio3WiRugyAgFOFF0VEWYa6Pe/+K/ORKHVdlxKIzSYdf98m6Oej+RhWYkmUnO1YXh7Us
         Y6T9MxT7K/5k6eJ7hVYRFYlmRZ+Yq7Udfmu3S43oexF6xdg/8MytxkLUnM5ZucmrePRH
         BtTTAajC/zVrsHorXwWYvDUWqRO5E81JLqN8PeWu1rRbrdHv+NpLjnFj4329wM0yKcvN
         avtTnje+dCwrTeDrISJTlen9MFTG3ylIuMBuz9u6k0/Z7FUdtCkRNFYj3AricjnmA64b
         qkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543168; x=1700147968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QjzZFTKwtqihTElGETV0lGXwGv/SmVMdX4dMdC65J4=;
        b=ImVR1Em8DqOZ86c5Xh17bkQgNH2HKm7+rlwARKkSu4j64yUIlNklSaPrU0ZaUKlWBe
         d+2PosqQWmgqcAe/zsAK3XJxY2b4gcAt+25nbNPamn34RaDe5Ww2dMon2yWQvBt5turM
         PTePoauhlZY9xnBicmvIHDanHTmqLAF2xyRQ95Fu5O6CrTM1xwH41TxyP8pbQM2Q+Snw
         40g4aOxKSz3Q+nIt2YsrpT5l+DD/QuCyxHGwpZ1QzhY/TdWQBJCiRZtSwj43/SOOu0Cv
         Zxc0wILLy2qES8dZRZruMjqi4m0nXDeS/7SJf11Wg1jEW3hRRDIreDmdcSlGoaWsIEkG
         GcVQ==
X-Gm-Message-State: AOJu0YzO/HIr+OXgWvU4yYlLxEsW5IfyM7ngavlD0B7DofgGqcFIIvy7
        igFHOW8csEjxYgu4kXmZJC90tikd4lo=
X-Google-Smtp-Source: AGHT+IFh+izpVorNeAJ+xXhgLFVgmpeiu54AerfQ3mePVz8cGOCzFvnLT3CiLUQbuUHCrqtWmx0At58umfs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2fd2:0:b0:d7e:7a8a:2159 with SMTP id
 v201-20020a252fd2000000b00d7e7a8a2159mr125775ybv.5.1699543167922; Thu, 09 Nov
 2023 07:19:27 -0800 (PST)
Date:   Thu, 9 Nov 2023 07:19:26 -0800
In-Reply-To: <fa25f3eb-eb9a-4d83-8fdf-f133c60484da@linux.intel.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com> <20231108003135.546002-13-seanjc@google.com>
 <fa25f3eb-eb9a-4d83-8fdf-f133c60484da@linux.intel.com>
Message-ID: <ZUz4ftgXQnOL_sHJ@google.com>
Subject: Re: [PATCH v7 12/19] KVM: selftests: Test consistency of CPUID with
 num of fixed counters
From:   Sean Christopherson <seanjc@google.com>
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023, Dapeng Mi wrote:
> 
> On 11/8/2023 8:31 AM, Sean Christopherson wrote:
> > From: Jinrong Liang <cloudliang@tencent.com>
> > 
> > Extend the PMU counters test to verify KVM emulation of fixed counters in
> > addition to general purpose counters.  Fixed counters add an extra wrinkle
> > in the form of an extra supported bitmask.  Thus quoth the SDM:
> > 
> >    fixed-function performance counter 'i' is supported if ECX[i] || (EDX[4:0] > i)
> > 
> > Test that KVM handles a counter being available through either method.
> > 
> > Co-developed-by: Like Xu <likexu@tencent.com>
> > Signed-off-by: Like Xu <likexu@tencent.com>
> > Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> > Co-developed-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   .../selftests/kvm/x86_64/pmu_counters_test.c  | 60 ++++++++++++++++++-
> >   1 file changed, 57 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> > index 6f2d3a64a118..8c934e261f2d 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> > @@ -285,13 +285,19 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
> >   	       expect_gp ? "#GP" : "no fault", msr, vector)			\
> >   static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters,
> > -				 uint8_t nr_counters)
> > +				 uint8_t nr_counters, uint32_t or_mask)
> 
> 
> 'or_mask' doesn't show a clear meaning, "counters_bitmap" may be a better
> name.

I don't love "or_mask" either, but I like "counters_bitmap" far less, as it doesn't
provide any hint as to the polarity or behavior.  Readers that aren't familiar with
the kludgy enumeration of PMCs in CPUID won't already know that it's a mask that's
OR-d in, e.g. counters_bitmap could be a replacement, it could be an AND-mask, it
could be something entirely unrelated.  I opted for a name that describe the behavior
because I don't see a way to succintly capture the (IMO) weird enumeration.
