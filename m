Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC97781D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjHJTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbjHJTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:32:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3562713
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:32:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-564ef63a010so1762104a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691695925; x=1692300725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5BUcp4rF73339tUbdxChTzYXicpDGHwoyiHDjbgdIQ=;
        b=MUhRj4IulKry/rRZHaY3UgOWWMElBQrZl4hueG5jLdyTT2NIolBHKKjvU4Y0TzRsrV
         +wxsVbj+iSIqkXPRzCoYDK57C46cw7kTcbKwyUpB76DazMVmyYYiSy6GhVq+Dhfl6HN/
         vUgOY4RX1nzfdz3uoA+58xgi8C9eqv2Wdwhi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695925; x=1692300725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5BUcp4rF73339tUbdxChTzYXicpDGHwoyiHDjbgdIQ=;
        b=DbMAkjTIRC8MpJ1tvSnFzDB9wDsXK0KQwIwPLLbgHPYpDQSSZGrcq0e2lSSHiFwaEo
         Qu6ZAuXCNRumYB11ifxFs2+ZKzB56xHeFYaTU/BoeKbE/mkqUr9+9ljofG9iApUeo516
         +hOdGNcc0gtAxBGRXobOmP7s/Wu0G2foVnt43u1EQ/p5uUtFDvPQuEt7hamw+2JGavdA
         8mfe9lLh7SXziAndrHSgd1o8xHYW46txAmKHxtW+uHGiJn+lDYj0HjpMSikyTVRc6jxz
         tecKQrikEpVyIWjm9lhcnbBeh8C0Fm06hLwjRGhoAJ8gwr+iqP1juPA5VpcQi9VGjHp4
         S8ZQ==
X-Gm-Message-State: AOJu0Yx8o8kXHN730xW+XfbbS4yCU+iFuDJUdxrJRyFFRXbvu+ZQ299U
        OalSB/OAP6/WIs3B1IOE+1YjIg==
X-Google-Smtp-Source: AGHT+IEOUo5qUDRJcUued1hIUrxl+tnnYRC3515yaFsDbHi7mTOPBSy4Sn1t0M7Wa4EdXVSzgg3wqg==
X-Received: by 2002:a05:6a20:431b:b0:13a:dd47:c31a with SMTP id h27-20020a056a20431b00b0013add47c31amr3971923pzk.20.1691695925514;
        Thu, 10 Aug 2023 12:32:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020a637b51000000b005639da5a8e2sm1896326pgn.2.2023.08.10.12.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:32:04 -0700 (PDT)
Date:   Thu, 10 Aug 2023 12:32:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: ptrace: Restore syscall skipping and restart while
 tracing
Message-ID: <202308101209.45CF7C6F80@keescook>
References: <20230804071045.never.134-kees@kernel.org>
 <f34c11eb-89b5-48a5-bd24-c215083575a5@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34c11eb-89b5-48a5-bd24-c215083575a5@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:47:24PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 4, 2023, at 09:10, Kees Cook wrote:
> > Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
> > thread_info->abi_syscall"), the seccomp selftests "syscall_errno",
> > "syscall_faked", and "syscall_restart" have been broken. This was
> > related to two issues:
> 
> While it looks like my patch introduced both problems, it might
> be better to split your fix into two bits.

Okay, sounds good.

> > - seccomp and PTRACE depend on using the special value of "-1" for
> >   skipping syscalls. This value wasn't working because it was getting
> >   masked by __NR_SYSCALL_MASK in both PTRACE_SET_SYSCALL and
> >   get_syscall_nr().
> 
> > Explicitly test for -1 in PTRACE_SET_SYSCALL and get_syscall_nr(),
> > leaving it exposed when present, allowing tracers to skip syscalls
> > again.
> 
> This part looks good to me, at least it seems to be one of multiple
> ways of doing this, depending on how we want to encode the
> syscall skipping in the variable.
> 
> > - the syscall entry label "local_restart" is used for resuming syscalls
> >   interrupted by signals, but the updated syscall number (in scno) was
> >   not being stored in current_thread_info()->abi_syscall, causing traced
> >   syscall restarting to fail.
> >
> > Move the AEABI-only assignment of current_thread_info()->abi_syscall
> > after the "local_restart" label to allow tracers to survive syscall
> > restarting.
> 
> I'm not following exactly what you are doing here yet, but I suspect
> this part is wrong:
> 
> > diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> > index bcc4c9ec3aa4..08bd624e4c6f 100644
> > --- a/arch/arm/kernel/entry-common.S
> > +++ b/arch/arm/kernel/entry-common.S
> > @@ -246,8 +246,6 @@ ENTRY(vector_swi)
> >  	bic	scno, scno, #0xff000000		@ mask off SWI op-code
> >  	str	scno, [tsk, #TI_ABI_SYSCALL]
> >  	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
> > -#else
> > -	str	scno, [tsk, #TI_ABI_SYSCALL]
> >  #endif
> >  	/*
> >  	 * Reload the registers that may have been corrupted on entry to
> > @@ -256,6 +254,9 @@ ENTRY(vector_swi)
> >   TRACE(	ldmia	sp, {r0 - r3}		)
> > 
> >  local_restart:
> > +#if defined(CONFIG_AEABI) && !defined(CONFIG_OABI_COMPAT)
> > +	str	scno, [tsk, #TI_ABI_SYSCALL]	@ store scno for syscall restart
> > +#endif
> >  	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
> >  	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
> > 
> 
> If the local_restart code has to store the syscall number
> for an EABI-only kernel, wouldn't it have to also do this
> for a kernel with OABI-only or OABI_COMPAT support?

This is the part I wasn't sure about. Initially I was thinking it didn't
matter because it's only a problem for a seccomp tracer, but I realize
it might be exposed to a PTRACE tracer too. I was only able to test with
EABI since seccomp is disabled for OABI_COMPAT.

Anyway, syscall restart is done this way:

        movlt   scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)

Can a EABI call restart an OABI syscall? I think so?

So maybe we just need to add:

	str     scno, [tsk, #TI_ABI_SYSCALL]    @ store scno for syscall restart

after that instead of moving it like I did originally?

Let me test that...

-- 
Kees Cook
