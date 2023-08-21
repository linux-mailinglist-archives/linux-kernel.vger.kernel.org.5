Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D5782E54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjHUQX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjHUQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5A211F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16861637E1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDE4C433C8;
        Mon, 21 Aug 2023 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692635019;
        bh=wy/hATjJpLN/hdBFtferCjdg7QYh8ITV/KbyY2Fnfok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odovd64E72Tmof4zCCrdG3sOQEV55zZXxCiwFLRe9LNjDV6iyeNg0AfiJgZ3BRx01
         hl0LaGO/1MeGRi3Ty2PWKJOWAzgAd999lT/co/PuJIswQamZfjt+EiQGKGk+q04chO
         ug/1uRw+7zNHa68B/xMqn6P3qO0wu6Eh878EgE5dQDkU0W4uvCzyaaqkTIRuEIkAlE
         qNnG3x8fxHRYKp1MOcH+XRjqD43M/F0Uss11J66Yhsi666n6t4ZGYRYNQkHphhAnTr
         QC/PUGTbiJ35qw/6iAfeXiNYEzWm0iadmC5pfGThaKRckPjp4z/Swip5tl0Ed4n4ZF
         cYCUN1xkjx06A==
Date:   Mon, 21 Aug 2023 09:23:37 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
Message-ID: <20230821162337.imzjf3golstkrrgd@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:34:38AM +0100, Andrew Cooper wrote:
> On 21/08/2023 2:19 am, Josh Poimboeuf wrote:
> > The IBPB_BRTYPE and SBPB CPUID bits aren't set by HW.
> 
> "Current hardware".
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index c381770bcbf1..dd7472121142 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -3676,12 +3676,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
> >  			return 1;
> >  
> > -		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
> > +		if (boot_cpu_has(X86_FEATURE_IBPB) && data == PRED_CMD_IBPB)
> > +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> > +		else if (boot_cpu_has(X86_FEATURE_SBPB) && data == PRED_CMD_SBPB)
> > +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_SBPB);
> > +		else if (data)
> >  			return 1;
> 
> SBPB | IBPB is an explicitly permitted combination, but will be rejected
> by this logic.

Ah yes, I see that now:

  If software writes PRED_CMD with both bits 0 and 7 set to 1, the
  processor performs an IBPB operation.

-- 
Josh
