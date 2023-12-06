Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F770807C55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379685AbjLFXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377561AbjLFXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:31:55 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55354B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:32:02 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d0c4af46cdso2215265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701905522; x=1702510322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3g9WdfqqfwTN8EG7bwCQdbSX4Tlm9Xey4HM7ERn8Nw=;
        b=O2LjTPF7M95Ess2Uru2Nm2E8JgY63k/2JEynVsQoajdwP52mQOPLoZuGDOtLDvtN8N
         HKNamiVaQlv1dWUoitbZmdWlcQ3ENc/No8aGFzjHctv9ZCOASuLnKBc5TJrwp9Yf78ku
         j7gqK6UCELW4fK3s4syj2ynYCPJyT7qwUi5kc31570tL39X+Klg1VWeEC0KBausTZqdR
         jOqQhi8WBZZ4iilVxoaDipRouxg+5FXU0qOWFZGTVi+V6A1nWk8HpAXsf+y6AoXt3QRh
         WDCK4MAObTaXQACyg5ZVzjtEpkVMgLpBIYAM36CQo4cT9FK7WadOqr+9jYG4wjvWpqp9
         bCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905522; x=1702510322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3g9WdfqqfwTN8EG7bwCQdbSX4Tlm9Xey4HM7ERn8Nw=;
        b=rx6osqpungOjnldrZa870H8vDeWT899dKG8pXjGQkWigvP+GdW1TEehJ425+PXEvdK
         bHEKOE676fOzMQLIRUXnNGek+2SXun4+bv4xADxwmKnY3D9AXLghrchA7yupuHJLBPo5
         e53GkJ1Qk2GHHVqoZ4zZhws/4g3n/tNr7NR657+sl3XiHjsSjR3lUGiXxEojEA1MGu/W
         7GDs/gi1sqaMgjIHg0ws1rz9ye3x2r33JK3HHqjOgioH9qGZz1m1vhP8tm540fu861Zz
         0laVvH3IH5iX/407hbSw+u87J1zYi4nldkQZrrkcCQ0RcisUu9jm+/4RVwV+KeSSzATu
         TpWw==
X-Gm-Message-State: AOJu0YxUml7WbRofNFSh4UjuhJkassecAjf6pTpkiCv5WvmEvwWQnnxj
        SyL3kNcEgUi9OCa8JM1/s+fEIi4Ve7w=
X-Google-Smtp-Source: AGHT+IHoP2NZCWhBmYB7HjbnCtmNvpNaWitEIYHTnKuBHjFrpikywb64Nq1cupyzyHHdZCE9akDojsrT0Vc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80d:b0:1d0:c2be:3d9d with SMTP id
 u13-20020a170902e80d00b001d0c2be3d9dmr22049plg.7.1701905520546; Wed, 06 Dec
 2023 15:32:00 -0800 (PST)
Date:   Wed, 6 Dec 2023 15:31:58 -0800
In-Reply-To: <20231204093731.574465649@infradead.org>
Mime-Version: 1.0
References: <20231204093702.989848513@infradead.org> <20231204093731.574465649@infradead.org>
Message-ID: <ZXEEbrI7K6XGr2dN@google.com>
Subject: Re: [PATCH 03/11] objtool: Convert ANNOTATE_RETPOLINE_SAFE to ANNOTATE
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023, Peter Zijlstra wrote:
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -193,12 +193,7 @@
>   * objtool the subsequent indirect jump/call is vouched safe for retpoline
>   * builds.
>   */
> -.macro ANNOTATE_RETPOLINE_SAFE
> -.Lhere_\@:
> -	.pushsection .discard.retpoline_safe
> -	.long .Lhere_\@
> -	.popsection
> -.endm
> +#define ANNOTATE_RETPOLINE_SAFE	ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
>  
>  /*
>   * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
> @@ -317,11 +312,7 @@
>  
>  #else /* __ASSEMBLY__ */
>  
> -#define ANNOTATE_RETPOLINE_SAFE					\
> -	"999:\n\t"						\
> -	".pushsection .discard.retpoline_safe\n\t"		\
> -	".long 999b\n\t"					\
> -	".popsection\n\t"
> +#define ANNOTATE_RETPOLINE_SAFE ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)

This fails for some of my builds that end up with CONFIG_OBJTOOl=n.  Adding a
stub for ASM_ANNOTATE() gets me past that:

@@ -156,6 +171,7 @@
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ANNOTATE_NOENDBR
+#define ASM_ANNOTATE(x)
 #define ASM_REACHABLE
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL

but then I run into other issues:

arch/x86/kernel/relocate_kernel_32.S: Assembler messages:
arch/x86/kernel/relocate_kernel_32.S:96: Error: Parameter named `type' does not exist for macro `annotate'
arch/x86/kernel/relocate_kernel_32.S:166: Error: Parameter named `type' does not exist for macro `annotate'
arch/x86/kernel/relocate_kernel_32.S:174: Error: Parameter named `type' does not exist for macro `annotate'
arch/x86/kernel/relocate_kernel_32.S:200: Error: Parameter named `type' does not exist for macro `annotate'
arch/x86/kernel/relocate_kernel_32.S:220: Error: Parameter named `type' does not exist for macro `annotate'
arch/x86/kernel/relocate_kernel_32.S:285: Error: Parameter named `type' does not exist for macro `annotate'
