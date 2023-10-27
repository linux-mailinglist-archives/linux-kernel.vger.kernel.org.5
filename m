Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBF7DA217
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbjJ0UzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0UzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:55:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2C106
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:55:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9bc9e6a89so22701715ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698440113; x=1699044913; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ONx5P+u41AFQig13/rFYqh/7sU4tfrNPS3sVnIzMbM=;
        b=sjbmNdFup6m/yOleW7YhMzcMHGCh0XF3bh/pnNIueqkred6vJWp4yJ5fkSuD3Tc0xc
         HP+msDVgqOBIws+uLCHC3JyuAnbKTPsvmkh9C3O8gnmSXz7el8UHd147tk+DkYGHTcha
         dRJAtKsw7D5N7lGld6PgpbTwtcOqrN7k3+CD5Uzd6+cSnefZO0UwU91SL9DSQUUZYiKg
         Qt4f87eDbMVvvarucmXBW0QFcbOoWmjNZcHbnzz+XiUa7/184adM/3nSANpcAPrglaCj
         jrJDqk7aLHUNgpM2CRhQ8bZUM60yqVDlEPlw3f+6wdBducEHbEX1xAdv7h6Lv+6gdfHd
         TcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698440113; x=1699044913;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ONx5P+u41AFQig13/rFYqh/7sU4tfrNPS3sVnIzMbM=;
        b=FLEC5RaWOHutorI7vKo50RN0B/EXaC6utISWpTbfCl2v6L6Zo7kjczBrAbPeFgZUOI
         aNg58Nn+rHka6Ur3srxS5fbsDcV3vovrIgrp2iMDXZrxVpaMHRfMzHlumMkeMJ48Vl9j
         3wqG+0w5QSIJMcVZOAmPOV9EX7drarqgZJSp+2NwC+S3ssbCYGR+Ah16rcumnTsZ7axH
         iLFg9rMVvqBxz0aSIO67lEHtg8ofpKjqfBE73IKRDLqxyKKpuPFaZG8cegmYpgvgyvRh
         bMIqoy615+Ea9nAzsvmruFoi0jn4xGnVe+li/1FJZZ1yb8KPx3c7ZvriFxqSFR2Egme2
         uFxw==
X-Gm-Message-State: AOJu0YyZL6u8sNsBcUbu/si3TM1kA/IyaCLNLkyK+hAau1nyqTPFB9Je
        1Qw1PaC05hMQVrmPTU9vp6qX1F2MgZ8=
X-Google-Smtp-Source: AGHT+IHRWdgGJSXOxv6UW7flVpbOejAdc9Fw9CL7CXJgWEYcb6xxsyK//crY2ta23k8rS/UOu2shny/XOxQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ed4d:b0:1ca:220:ce4f with SMTP id
 y13-20020a170902ed4d00b001ca0220ce4fmr67727plb.4.1698440113667; Fri, 27 Oct
 2023 13:55:13 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:55:11 -0700
In-Reply-To: <20231023234000.2499267-7-seanjc@google.com>
Mime-Version: 1.0
References: <20231023234000.2499267-1-seanjc@google.com> <20231023234000.2499267-7-seanjc@google.com>
Message-ID: <ZTwjrxDodKVMK3PI@google.com>
Subject: Re: [PATCH 6/6] KVM: x86/pmu: Track emulated counter events instead
 of previous counter
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

On Mon, Oct 23, 2023, Sean Christopherson wrote:
> @@ -226,13 +226,19 @@ static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
>  
>  static void pmc_pause_counter(struct kvm_pmc *pmc)
>  {
> -	u64 counter = pmc->counter;
> +	/*
> +	 * Accumulate emulated events, even if the PMC was already paused, e.g.
> +	 * if KVM emulated an event after a WRMSR, but before reprogramming, or
> +	 * if KVM couldn't create a perf event.
> +	 */
> +	u64 counter = pmc->counter + pmc->emulated_counter;
>  
> -	if (!pmc->perf_event || pmc->is_paused)
> -		return;
> +	pmc->emulated_counter = 0;

As pointed by Mingwei, who _very_ patiently explained to me what is broken, the
snapshot used to detect overflow due to emulated_counter events needs to be taken
_after_ pausing the perf event, i.e. the count from the perf event needs to be
excluded.  If overflow happens from pmc->counter => pmc->counter + pmc->perf_event,
then hardware (via perf) will detect overflow.  I.e. KVM is only responsible for
detecting overflow solely due to emulated_counter.  Include the count from the
perf event can lead to KVM generating multiple overflow events, where architecturally
only one should occur.

>  	/* update counter, reset event value to avoid redundant accumulation */
> -	counter += perf_event_pause(pmc->perf_event, true);
> +	if (pmc->perf_event && !pmc->is_paused)
> +		counter += perf_event_pause(pmc->perf_event, true);
> +
>  	pmc->counter = counter & pmc_bitmask(pmc);
>  	pmc->is_paused = true;
>  }
