Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E457C899B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjJMQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJMQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:04:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C7FF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:04:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27d10ef87caso1894493a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697213093; x=1697817893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADc+BeDNpPzla2tCfp6/O/BMhR8EnDpGynEOWTUgWb8=;
        b=gxm26gU4AUd54mmMxn/0KxpyCzlPKtW4pmThbi2fgl6sxzH1iQW7Z89EFXyJskB01A
         J+Dh7icAWML1mszE/kYY9Cyn0N3c6PeSAo0XWwwdYyaDMkut9tRS+SxEnqgdAcw3bJ30
         1zau014ut4E36eDXgXawVX/wRRyWbe9ozn8drAz1w3t81aLkrVnlyKWEAD4VlnmgGh1o
         pfdeDNpj477+RdcU086FTEg7poBqrZ7UwmlnaqEdiy0siNVDropCFYn926f6iujgTpEe
         vDCXms9EowmxBBFTauKIJip7ALDd66qEKzKzUecT9aWRCVZY9rIeNoeHvxM7pWQDbXa9
         XtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213093; x=1697817893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADc+BeDNpPzla2tCfp6/O/BMhR8EnDpGynEOWTUgWb8=;
        b=syHDV2mhmLWcRNPGWmK4XRbXg/3+GRiIkVuOKxvl/yoUQKWXEiFkRd/c1Y0mj7SSJo
         C3ypb2XB5+DwHrPj93wdJ8FLwA1UZ2Un4GtElsk+KIX2nA9PC+dHKSV6ubPerqZPP2J9
         Z96VOO46rHa6oXu8+pjhtw/JTud4qFmpq0epQshBHPrN7nS4Gvv9D3U/8FCr7NxNqnfg
         E1jhMk3zvEnxyfUH+f7imydJdlaj4uzUOuMq3wAB4kukrJNXJAuuU2liDr4hQjjiwTYF
         cCdcmAhKCvYBoy2PP9b08QWFClJxREagdlc0Mgpm8PFf/950Gh7DK28JKeSK3X8K6lew
         Dv+w==
X-Gm-Message-State: AOJu0Yw2piWOlAr2suiOsTPGoJQgLXN1Y4TLGJ2Vv9hu01t0nLQMhaf4
        smBQPuaBEWpVjKyGXV4Y6WaTldiKxhI=
X-Google-Smtp-Source: AGHT+IEcsPOvRyLvVS8jZmnRvkncSdtTLsQZ1Gen7Urn6MH5MesInY1HJFiwTH23pF9G2/PTTFsjYQsoenY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ab47:b0:1ca:1a30:cf34 with SMTP id
 ij7-20020a170902ab4700b001ca1a30cf34mr14339plb.11.1697213093615; Fri, 13 Oct
 2023 09:04:53 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:04:51 -0700
In-Reply-To: <20231011204150.51166-1-ubizjak@gmail.com>
Mime-Version: 1.0
References: <20231011204150.51166-1-ubizjak@gmail.com>
Message-ID: <ZSlqo-k2htjN1gPh@google.com>
Subject: Re: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Wed, Oct 11, 2023, Uros Bizjak wrote:
> Additionaly, the patch introduces 'rdgsbase' alternative for CPUs with
> X86_FEATURE_FSGSBASE. The rdgsbase instruction *probably* will end up
> only decoding in the first decoder etc. But we're talking single-cycle
> kind of effects, and the rdgsbase case should be much better from
> a cache perspective and might use fewer memory pipeline resources to
> offset the fact that it uses an unusual front end decoder resource...

The switch to RDGSBASE should be a separate patch, and should come with actual
performance numbers.  

A significant percentage of data accesses in Intel's TDX-Module[*] use this
pattern, e.g. even global data is relative to GS.base in the module due its rather
odd and restricted environment.  Back in the early days of TDX, the module used
RD{FS,GS}BASE instead of prefixes to get pointers to per-CPU and global data
structures in the TDX-Module.  It's been a few years so I forget the exact numbers,
but at the time a single transition between guest and host would have something
like ~100 reads of FS.base or GS.base.  Switching from RD{FS,GS}BASE to prefixed
accesses reduced the latency for a guest<->host transition through the TDX-Module
by several thousand cycles, as every RD{FS,GS}BASE had a latency of ~18 cycles
(again, going off 3+ year old memories).

The TDX-Module code is pretty much a pathological worth case scenario, but I
suspect its usage is very similar to most usage of raw_cpu_ptr(), e.g. get a
pointer to some data structure and then do multiple reads/writes from/to that
data structure.

The other wrinkle with RD{FS,FS}GSBASE is that they are trivially easy to emulate.
If a hypervisor/VMM is advertising FSGSBASE even when it's not supported by
hardware, e.g. to migrate VMs to older hardware, then every RDGSBASE will end up
taking a few thousand cycles (#UD -> VM-Exit -> emulate).  I would be surprised
if any hypervisor actually does this as it would be easier/smarter to simply not
advertise FSGSBASE if migrating to older hardware might be necessary, e.g. KVM
doesn't support emulating RD{FS,GS}BASE.  But at the same time, the whole reason
I stumbled on the TDX-Module's sub-optimal RD{FS,GS}BASE usage was because I had
hacked KVM to emulate RD{FS,GS}BASE so that I could do KVM TDX development on older
hardware.  I.e. it's not impossible that this code could run on hardware where
RDGSBASE is emulated in software.

[*] https://www.intel.com/content/www/us/en/download/738875/intel-trust-domain-extension-intel-tdx-module.html
