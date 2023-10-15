Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BE7C99AD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJOPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOPKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:10:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03DDC1;
        Sun, 15 Oct 2023 08:10:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F21C433C8;
        Sun, 15 Oct 2023 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697382602;
        bh=1kAFRzKp03CHX8VTzkP3LzHdDTSohAeq3KRbJ19F8XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9a7bfLlqAOzv4bPpkFMX95llHrA/Wqp7jdP+kRKGX3ZnvTN1wcgUf5ZFtZhCimR+
         9s9ll+q5mcyGa4If3hUatTD/HJCeUdqPnzybQ+v0WPtj/YNadQ8NrlKC9Mkt7GG1U0
         SJ4P58fqzXaz9edHqiozVL/xLAxqm5c1aXFRq/Nhl4bGQqQddAQzwmC/hQiLuyRf6C
         DTGLfge2UopEHyhD9ryondt/Kyp17RdHcT3Rr8/K3fsT05H/vUltCHkSvOxvZS7rzn
         61VgbhJxT8uVomRVXwdHVf0fb2ON1SoI3HZo4FeNGYW81ykrJAmnUrfja+AKoXg3Vz
         kTHjl1UolNDoQ==
Date:   Sun, 15 Oct 2023 11:09:55 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: set_thread_area.2: csky architecture undocumented
Message-ID: <ZSwAw+UyrIknsE5S@gmail.com>
References: <014e670b-2a11-3deb-4e7e-bfe9defd8597@gmail.com>
 <c669c780-f6e8-bd2a-e6ec-0a5960b7d7d8@gmail.com>
 <CAJF2gTQPai9k6XqqStbvk0waF+tmMQm9PMMZe3T8m6ioAjdTFA@mail.gmail.com>
 <ZSsiSlJC5sHAyUk-@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSsiSlJC5sHAyUk-@debian>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 01:20:42AM +0200, Alejandro Colomar wrote:
> Hi Guo,
> 
> On Tue, Nov 24, 2020 at 08:07:07PM +0800, Guo Ren wrote:
> 
> Huh, 3 years already!  I've had this in my head for all this time; just
> didn't find the energy to act on it.
> 
> > Thx Michael & Alejandro,
> > 
> > Yes, the man page has no csky's.
> 
> I've applied a patch to add initial documentation for it:
> <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/commit/?h=contrib&id=a63979eb24aaf73f4be5799cc9579f84a3874b7d>
> 
> > 
> > C-SKY have abiv1 and abiv2
> > For abiv1: There is no register for tls saving, We use trap 3 to got
> > tls and use set_thread_area to init ti->tp_value.
> > For abiv2: The r31 is the tls register. We could directly read r31 to
> > got r31 and use set_thread_area to init reg->tls value.
> > 
> > In glibc:
> > # ifdef __CSKYABIV2__
> > /* Define r31 as thread pointer register.  */
> > #  define READ_THREAD_POINTER() \
> >         mov r0, r31;
> > # else
> > #  define READ_THREAD_POINTER() \
> >         trap 3;
> > # endif
> > 
> > /* Code to initially initialize the thread pointer.  This might need
> >    special attention since 'errno' is not yet available and if the
> >    operation can cause a failure 'errno' must not be touched.  */
> > # define TLS_INIT_TP(tcbp) \
> >   ({ INTERNAL_SYSCALL_DECL (err);                                       \
> >      long result_var;                                                   \
> >      result_var = INTERNAL_SYSCALL (set_thread_area, err, 1,            \
> >                     (char *) (tcbp) + TLS_TCB_OFFSET);                  \
> >      INTERNAL_SYSCALL_ERROR_P (result_var, err)                         \
> >        ? "unknown error" : NULL; })
> > 
> > In kernel:
> > SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> > {
> >         struct thread_info *ti = task_thread_info(current);
> >         struct pt_regs *reg = current_pt_regs();
> > 
> >         reg->tls = addr;
> >         ti->tp_value = addr;
> > 
> >         return 0;
> > }
> > 
> > Any comments are welcome :)
> 
> I'm sorry, but I have little understanding of this syscall, and that
> shounds like gibberish to me :)
> 
> Feel free to send a patch to improve the documentation for csky.
Yeah, I've sent a patch for it; please review:
https://lore.kernel.org/linux-csky/20231015150732.1991997-1-guoren@kernel.org/

> 
> Cheers,
> Alex
> 
> > 
> > 
> > On Tue, Nov 24, 2020 at 5:51 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > On 11/23/20 10:31 PM, Alejandro Colomar (man-pages) wrote:
> > > > Hi Michael,
> > > >
> > > > SYNOPSIS
> > > >        #include <linux/unistd.h>
> > > >
> > > >        #if defined __i386__ || defined __x86_64__
> > > >        # include <asm/ldt.h>
> > > >
> > > >        int get_thread_area(struct user_desc *u_info);
> > > >        int set_thread_area(struct user_desc *u_info);
> > > >
> > > >        #elif defined __m68k__
> > > >
> > > >        int get_thread_area(void);
> > > >        int set_thread_area(unsigned long tp);
> > > >
> > > >        #elif defined __mips__
> > > >
> > > >        int set_thread_area(unsigned long addr);
> > > >
> > > >        #endif
> > > >
> > > >        Note: There are no glibc wrappers for these system  calls;  see
> > > >        NOTES.
> > > >
> > > >
> > > > $ grep -rn 'SYSCALL_DEFINE.*et_thread_area'
> > > > arch/csky/kernel/syscall.c:6:
> > > > SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> > > > arch/mips/kernel/syscall.c:86:
> > > > SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> > > > arch/x86/kernel/tls.c:191:
> > > > SYSCALL_DEFINE1(set_thread_area, struct user_desc __user *, u_info)
> > > > arch/x86/kernel/tls.c:243:
> > > > SYSCALL_DEFINE1(get_thread_area, struct user_desc __user *, u_info)
> > > > arch/x86/um/tls_32.c:277:
> > > > SYSCALL_DEFINE1(set_thread_area, struct user_desc __user *, user_desc)
> > > > arch/x86/um/tls_32.c:325:
> > > > SYSCALL_DEFINE1(get_thread_area, struct user_desc __user *, user_desc)
> > > >
> > > >
> > > > See kernel commit 4859bfca11c7d63d55175bcd85a75d6cee4b7184
> > > >
> > > >
> > > > I'd change
> > > > -      #elif defined __mips__
> > > > +      #elif defined(__mips__ || __csky__)
> > > >
> > > > and then change the rest of the text to add csky when appropriate.
> > > > Am I correct?
> > >
> > > AFAICT, you are correct. I think the reason that csky is missing is
> > > that the architecture was added after this manual pages was added.
> > >
> > > Thanks,
> > >
> > > Michael
> > >
> > >
> > > --
> > > Michael Kerrisk
> > > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > > Linux/UNIX System Programming Training: http://man7.org/training/
> > 
> > 
> > 
> > --
> > Best Regards
> >  Guo Ren
> > 
> > ML: https://lore.kernel.org/linux-csky/
> 
> -- 
> <https://www.alejandro-colomar.es/>


