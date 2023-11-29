Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679337FCC61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376722AbjK2Bhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2Bhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:37:52 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA995F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:37:54 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-28568b43a46so7723524a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701221874; x=1701826674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3pV9yESQinSfKng7uB+2h0DCvDB7gn9Dz1a35V3RxA=;
        b=xP8rX2PNzYuv9SlfA9Ywaia9P6fH9CfYhCedYgoZAy08+q98eBCdKav3F/MT+WQu/+
         6UU5kJsAO6MmA5AaFSsH7zhkLuDED1lbwcGZpryuGtaILbLojq5PV6kC+E3+idZ45lTp
         oZnf+/8qcoG+945itl+A7KUIyIc35rBHb2UZd49nBcO4KqLUEAAOLZ3FUYt7VgSqASQ/
         5o+qpkR/F77Qvv+UDYooM2AU3u4GzsPJf8Z+NO8GNbdy0CrGuYMpMrDVGqLFAv1+quIJ
         KmKjdS9pb/0f1loNOyy9KBOIrLFIT/REAw5vlWU0a4k9KMINxVHwpukXVX7CVbJxpjQy
         k0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701221874; x=1701826674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3pV9yESQinSfKng7uB+2h0DCvDB7gn9Dz1a35V3RxA=;
        b=OFa+EiDWo9L/FwqbxRG0JPetu+gLN4VCDuZX0zHGUZ1vryfdLF0xXg8eNjIfxMKpG9
         vvsXY6jijQ/+aYcaJHwCduGI74qUqCDPITSFCy2PuPF4d85DP/QOCtxPRjNQ/twePnsv
         zVeUi9GXhg0/cR4E5JbbIVMY5DlhhQkMmFqySrvwlAea/4sFECIdEAn+YbsNdLIJiFem
         z+EdScMbUCW9Q7LcOuOLhMoBMPPOZI2hK4RduVw1ry6qLyLIjYfRPPPwIN9Zg13qInjn
         nfRyuTK1OJeP1pYCcKSqpM4RL7IxRKZT2hlGv6SXFFHZpgKCVntF8tQwYtOLvpSEQ2v3
         4OBw==
X-Gm-Message-State: AOJu0YxyiaYmzg5p/tI1DfQr9OnFrSFgRY8htMJyE7fmsjY2vaNPURDo
        X3MfKwc8opAo0UnZ895tMFS9Th9f3Fs=
X-Google-Smtp-Source: AGHT+IH22wRmS9TxEtVUKAnYfx+CBdUifoiTLtxXqiUwvVEc6VCt8XMPPdkq81BxNsh++IFmUfjYjK5XvZE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4388:b0:27d:15e2:b248 with SMTP id
 in8-20020a17090b438800b0027d15e2b248mr3493889pjb.8.1701221874332; Tue, 28 Nov
 2023 17:37:54 -0800 (PST)
Date:   Tue, 28 Nov 2023 17:37:52 -0800
In-Reply-To: <20231112201205.GB9987@noisy.programming.kicks-ass.net>
Mime-Version: 1.0
References: <20231112201205.GB9987@noisy.programming.kicks-ass.net>
Message-ID: <ZWaV8H9e8ubhFgWJ@google.com>
Subject: Re: [RFC] x86/kvm/emulate: Avoid RET for fastops
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023, Peter Zijlstra wrote:
> Hi,
> 
> Inspired by the likes of ba5ca5e5e6a1 ("x86/retpoline: Don't clobber
> RFLAGS during srso_safe_ret()") I had it on my TODO to look at this,
> because the call-depth-tracking rethunk definitely also clobbers flags
> and that's a ton harder to fix.
> 
> Looking at this recently I noticed that there's really only one callsite
> (twice, the testcc thing is basically separate from the rest of the
> fastop stuff) and thus CALL+RET is totally silly, we can JMP+JMP.
> 
> The below implements this, and aside from objtool going apeshit (it
> fails to recognise the fastop JMP_NOSPEC as a jump-table and instead
> classifies it as a tail-call), it actually builds and the asm looks
> good sensible enough.
> 
> I've not yet figured out how to test this stuff, but does something like
> this look sane to you guys?

Yes?  The idea seems sound, but I haven't thought _that_ hard about whether or not
there's any possible gotchas.   I did a quick test and nothing exploded (and
usually when this code breaks, it breaks spectacularly).

> Given that rethunks are quite fat and slow, this could be sold as a
> performance optimization I suppose.
> 
> ---
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index f93e9b96927a..2cd3b5a46e7a 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -412,6 +412,17 @@ static inline void call_depth_return_thunk(void) {}
>  	"call *%[thunk_target]\n",				\
>  	X86_FEATURE_RETPOLINE_LFENCE)
>  
> +# define JMP_NOSPEC						\
> +	ALTERNATIVE_2(						\
> +	ANNOTATE_RETPOLINE_SAFE					\
> +	"jmp *%[thunk_target]\n",				\
> +	"jmp __x86_indirect_thunk_%V[thunk_target]\n",		\
> +	X86_FEATURE_RETPOLINE,					\
> +	"lfence;\n"						\
> +	ANNOTATE_RETPOLINE_SAFE					\
> +	"jmp *%[thunk_target]\n",				\
> +	X86_FEATURE_RETPOLINE_LFENCE)

There needs a 32-bit version (eww) and a CONFIG_RETPOLINE=n version. :-/
