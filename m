Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E870E7897DA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHZPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHZPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754C1BCD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07BD628DC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C90C433C8;
        Sat, 26 Aug 2023 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064964;
        bh=nOd4LcvmH1xPS0+oB6ZDNnnsN8ANzbX5OpiHjPc/Jx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjXnilXTtI4qZSbswA6puvgv0UWbEv9vEovo1hfLH5lNVHVlzZ9+xIDbvwGfOgTbJ
         GAmTPHEx6AtPSz4UZ/ajDGBdJ6cxnnozoxxfBk+672lSmTWJWzN+6uNvN9NuyY0N6u
         ax29iJzzNhiGE+aBjvAXxL9BgP5Nt04EnUuVOP9FummsfK4mwqPb92bYQK7ymHqnCR
         ujb6uqEdsv2FGOH4vp5Hj22T9F/DtMVCwIBEjxWZCcbzSp0HLJAW56TyFmqAId3y+N
         3/Hasp8QdhOAIcbFtJytJE6uNao/rZ9tCYkbZREsZ0tOpv6k5GGDfRZ0kV9ntBFLVn
         qOHRkWT1i3Glg==
Date:   Sat, 26 Aug 2023 08:49:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/23] KVM: x86: Add IBPB_BRTYPE support
Message-ID: <20230826154922.mdmjzwqwdgufb3y4@treble>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <79d5f5914fb42c2c62418ffbcd78f138645ded21.1692919072.git.jpoimboe@kernel.org>
 <ZOjv1Q0YgoxwElMW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOjv1Q0YgoxwElMW@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:15:49AM -0700, Sean Christopherson wrote:
> On Fri, Aug 25, 2023, Josh Poimboeuf wrote:
> > Add support for the IBPB_BRTYPE CPUID flag, which indicates that IBPB
> > includes branch type prediction flushing.
> 
> Please add:
> 
>   Note, like SRSO_NO, advertise support for IBPB_BRTYPE even if it's not
>   enumerated by in the raw CPUID, i.e. bypass the cpuid_count() in
>   __kvm_cpu_cap_mask().  Some CPUs that gained support via a uCode patch
>   don't report IBPB_BRTYPE via CPUID (the kernel forces the flag).
> 
>   Opportunistically use kvm_cpu_cap_check_and_set() for SRSS_NO instead

"SRSO_NO"

>   of manually querying host support (cpu_feature_enabled() and
>   boot_cpu_has() yield the same end result in this case).

Sounds good.

> Feel free to take this through tip if this is urgent enough to go into 6.6,
> otherwise I'll grab it for 6.7.

Ingo grabbed all the patches except for the two KVM ones, so I think
he's expecting you to take them.

> Acked-by: Sean Christopherson <seanjc@google.com>

Thanks!

-- 
Josh
