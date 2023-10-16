Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC67CB353
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjJPT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:29:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BB83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:29:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a528c2c8bso6073785276.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697484581; x=1698089381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=seMm4HAU4kH1aXY34tP5ERB19bSSV6xKGKiVG35yCqU=;
        b=JW2xc4HDT6fFTHNxgwmX61oyIyaMn5FyLFh0cX687oGB3wAQu3SSBG4vv+smInNNX5
         eydmSZ4pwTxfhJPw0mmns52UIFIay3IkTPa8nObOo60gLRZKzv4H9d3eDwj+BId3y3AN
         1kJULDmROaKQeIl2blEJESTgFBR+n20USQGCbZLZifnDDZ0S/1ha7tR5nQW4fIWoGwpQ
         H7ZohUubdT+dATIJrvzo7Cl8VY8W/eEVVn5yloCudZG13KeGNXgMJYYmNVZR6/MbGGNC
         LT+LQRl9FFmI6iCdc4Agtv8Xg1v3UUD3CG1pApMitf5wOd+SxE8OS7hjFYmfiRcTW4hu
         m7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697484581; x=1698089381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seMm4HAU4kH1aXY34tP5ERB19bSSV6xKGKiVG35yCqU=;
        b=mvM/tyx9pn0T0Oh7xpgwSp/+LOuediJRJaCGxGfGp8rwvYUFtyfBFltkuzkbSF9Jlv
         IwTgf8i8utpdEuAup92goiXCxubnY52WXRtW6mG9915S5DVuHsz5rn/T5kvX45nDEqE5
         qffKTNNmDNtBDIlX548DCO6U9c1qPEBjDbZJoum+ZqD3U2M6z8Z9z2mcypIrMMCGOuF5
         6UBmkatzJnTcUiUQncSiEKEvHl2nZ3C+4PNYoGuzixoXoDqObe5YxIHK5GC8LbEsK2YS
         gzjfViLnzctFv3ubxHNiPjLZ/0k3Ht3QMhlBYq71K/qBl+R+3iC60svuUV700qXfPPi+
         AqVw==
X-Gm-Message-State: AOJu0YxGGMgbWxvGSLeacHTRpfHsWqWYPv08GjfP8fyuv1CmVvDCghEu
        EcAwFKngdb9Fu/xpDS/VLyRYriQ/FwY=
X-Google-Smtp-Source: AGHT+IG+AuXCfIGptcsq6mHXF8Q90CwRcQgThIsPKpTHBWSIj3Nnzu2vxBGKWMUUYK9YwK34EeZ4ITsboCI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b081:0:b0:d74:93a1:70a2 with SMTP id
 f1-20020a25b081000000b00d7493a170a2mr265ybj.5.1697484581296; Mon, 16 Oct 2023
 12:29:41 -0700 (PDT)
Date:   Mon, 16 Oct 2023 12:29:39 -0700
In-Reply-To: <ZS0bLvcC46tHjM/G@gmail.com>
Mime-Version: 1.0
References: <20231015202523.189168-1-ubizjak@gmail.com> <20231015202523.189168-3-ubizjak@gmail.com>
 <ZS0bLvcC46tHjM/G@gmail.com>
Message-ID: <ZS2PIzzffqflnVoY@google.com>
Subject: Re: [PATCH -tip 3/3] x86/percpu: *NOT FOR MERGE* Implement
 arch_raw_cpu_ptr() with RDGSBASE
From:   Sean Christopherson <seanjc@google.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
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

On Mon, Oct 16, 2023, Ingo Molnar wrote:
> 
> * Uros Bizjak <ubizjak@gmail.com> wrote:
> 
> > Sean says:
> > The instructions are guarded by a CR4 bit, the ucode cost just to check
> > CR4.FSGSBASE is probably non-trivial."
> 
> BTW., a side note regarding the very last paragraph and the CR4 bit ucode 
> cost, given that SMAP is CR4 controlled too:
> 
>  #define X86_CR4_FSGSBASE_BIT    16 /* enable RDWRFSGS support */
>  #define X86_CR4_FSGSBASE        _BITUL(X86_CR4_FSGSBASE_BIT)
>  ...
>  #define X86_CR4_SMAP_BIT        21 /* enable SMAP support */
>  #define X86_CR4_SMAP            _BITUL(X86_CR4_SMAP_BIT)
> 
> And this modifies the behavior of STAC/CLAC, of which we have ~300 
> instances in a defconfig kernel image:
> 
>   kepler:~/tip> objdump -wdr vmlinux | grep -w 'stac' x | wc  -l
>   119
> 
>   kepler:~/tip> objdump -wdr vmlinux | grep -w 'clac' x | wc  -l
>   188
> 
> Are we certain that ucode on modern x86 CPUs check CR4 for every affected 
> instruction?

Not certain at all.  I agree the CR4.FSGSBASE thing could be a complete non-issue
and was just me speculating.

> Could they perhaps use something faster, such as internal microcode-patching
> (is that a thing?), to turn support for certain instructions on/off when the
> relevant CR4 bit is modified, without having to genuinely access CR4 for
> every instruction executed?

I don't know the exact details, but Intel's VMRESUME ucode flow uses some form of
magic to skip consistency checks that aren't relevant for the current (or target)
mode, *without* using conditional branches.  So it's definitely possible/probable
that similar magic is used to expedite things like CPL and CR4 checks.
