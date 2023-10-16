Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A627CB698
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjJPWdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:33:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216EA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:33:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso51094635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697495600; x=1698100400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEASVEa3xi3QC1ChcRbE9e1Ja+eNEBuwXUOWgyClOv0=;
        b=A79KbSJfJII8qbFYfCcimsRH8WhFiTY3HpiIiQ/SUYO2JBTC4Lw1Hrzs573QCIPljy
         B3JG74tSa3eWWzaN07oECGLGNFKgnWr0l+Q+hlwq2Pzro7mE3lR/8bLCSalnofu8XsYP
         ZjEWcxDDl9uQzJQ/Rqyn/4Uy7khvLkTJdwvaeV8O/gOaJmv8XsItV5ZSHVxGWku2roxn
         fDaAC13Yv6MQICSL00ojYDJ1NAhJ9wKDWonV3tOiecw/suDIhhmc2SkmyWw2sc61NzT/
         GeanZy7G1CrWauE/rJ8qHZzU7SeuZeRqjYKirvQ6gVVRyWTtLwxFO4Agaly2vpKwiXXf
         Y+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697495600; x=1698100400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEASVEa3xi3QC1ChcRbE9e1Ja+eNEBuwXUOWgyClOv0=;
        b=Mfej+LSGabhpRw1lCNjYotrdtwzedmYVF6H1uzOHYzRMgMqLg5F9C0PnhtK+7AOji/
         jWRCBcL+rsshoBVx++eIY0cjTrti3brETIn1xLdiL2F202kUROIaorLjsNTC+aaYaJaV
         aXyjJi1sI7DUCNU4NLLXtPjqc5jSgfHrQOM3TO6ksPob8MKXc741myHfH9g9z7M+3bZK
         VowRK35GO8B9mQpCbuD0oBBhs/Mq+223BV39IPdOGj/olFTt3/CN0laJyml1lJTNOvGM
         38k+6D1wmEgLPjmwogqpaO98KrdlwUpsSRQDpsIAx3ci1br2gP6Unuad4abcSUe4kQvi
         K9gg==
X-Gm-Message-State: AOJu0YxCWcIY6wV/Wo7bbk/HQrt/+YITduzcNnZgny3rV2LSNHOkvbCB
        XGaQfKNKTrDACA25IselhEw=
X-Google-Smtp-Source: AGHT+IFS9hBW8JM6qGbZVtTffTQx6Bw/7qad6dDtVwVkuq4kNxQK0kNtVG3k8rVaec5Bgg0ktvqu2w==
X-Received: by 2002:a05:600c:5252:b0:406:8496:bd8b with SMTP id fc18-20020a05600c525200b004068496bd8bmr378559wmb.9.1697495599649;
        Mon, 16 Oct 2023 15:33:19 -0700 (PDT)
Received: from nz ([2a00:23c8:a613:101:729c:d1ff:fe4f:94a3])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003fc0505be19sm238602wmq.37.2023.10.16.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 15:33:19 -0700 (PDT)
Date:   Mon, 16 Oct 2023 23:33:18 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org
Subject: Re: [RESEND PATCH] uapi: increase MAX_ARG_STRLEN from 128K to 6M
Message-ID: <20231016233318.2b41ae06@nz>
In-Reply-To: <202310161439.BEA904AEE8@keescook>
References: <20231016212507.131902-1-slyich@gmail.com>
        <202310161439.BEA904AEE8@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 14:50:05 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Oct 16, 2023 at 10:25:07PM +0100, Sergei Trofimovich wrote:
> > Before the change linux allowed individual execve() arguments or
> > environment variable entries to be only as big as 32 pages.
> > 
> > Histroically before b6a2fea3931 "mm: variable length argument support"
> > MAX_ARG_STRLEN used to be full allowed size `argv[] + envp[]`.
> > 
> > When full limit was abandoned individual parameters were still limited
> > by a safe limit of 128K.
> > 
> > Nowadays' linux allows `argv[]+envp[]` to be as laerge as 6MB (3/4
> > `_STK_LIM`).  
> 
> See bprm_stack_limits() for the details, but yes, 3/4 _STK_LIM tends to
> be the max, unless the rlim_stack is set smaller.
> 
> > Some build systems like `autoconf` use a single environment variable
> > to pass `CFLAGS` environment variable around. It's not a bug problem
> > if the argument list is short.
> > 
> > But some packaging systems prefer installing each package into
> > individual directory. As a result that requires quite long string of
> > parameters like:
> > 
> >     CFLAGS="-I/path/to/pkg1 -I/path/to/pkg2 ..."
> > 
> > This can easily overflow 128K and does happen for `NixOS` and `nixpkgs`
> > repositories on a regular basis.  
> 
> That's ... alarming. What are you doing currently to work around this?

We usually try to stay under the threshold. When the problem arises due
to organic growth of inputs over time we either suffer build failures
without any reasonable workarounds or if the change was recent and
inflated command line options we revert the change and add hacks into
other places (like patching `gcc` directly to apply the
transformations).

Longer term it would be nice for `gcc` to allow unbounded output via
response files, but it will take some time to sort out as current flags
rewriting expands all flags and response files into a single huge
variable and hits the 128K limit:

    https://gcc.gnu.org/pipermail/gcc/2023-October/242641.html

Medium term dropping kernel's arbitrary small limit (this change) sounds
like the simplest solution.

> > 
> > Similar pattern is exhibited by `gcc` which converts it's input command
> > line into a single environment variable (https://gcc.gnu.org/PR111527):
> > 
> >   $ big_100k_var=$(printf "%0*d" 100000 0)
> > 
> >   # this works: 200KB of options for `printf` external command
> >   $ $(which printf) "%s %s" $big_100k_var $big_100k_var >/dev/null; echo $?
> >   0
> > 
> >   # this fails: 200KB of options for `gcc`, fails in `cc1`
> >   $ touch a.c; gcc -c a.c -DA=$big_100k_var -DB=$big_100k_var
> >   gcc: fatal error: cannot execute 'cc1': execv: Argument list too long
> >   compilation terminated.
> > 
> > I would say this 128KB limitation is arbitrary.
> > The change raises the limit of `MAX_ARG_STRLEN` from 32 pakes (128K
> > n `x86_64`) to the maximum limit of stack allowed by Linux today.
> > 
> > It has a minor chance of overflowing userspace programs that use
> > `MAX_ARG_STRLEN` to allocate the strings on stack. It should not be a
> > big problem as such programs are already are at risk of overflowing
> > stack.
> > 
> > Tested as:
> >     $ V=$(printf "%*d" 1000000 0) ls
> > 
> > Before the change it failed with `ls: Argument list too long`. After the
> > change `ls` executes as expected.
> > 
> > WDYT of abandoning the limit and allow user to fill entire environment
> > with a single command or a single variable?  
> 
> Changing this value shouldn't risk any vma collisions, since exec is
> still checking the utilization before starting the actual process
> replacement steps (see bprm->argmin).
> 
> It does seem pathological to set this to the full 6MB, though, since
> that would _immediately_ get rejected by execve() with an -E2BIG, but
> ultimately, there isn't really any specific limit to the length of
> individual strings as long as the entire space is less than
> bprm->argmin.
> 
> Perhaps MAX_ARG_STRLEN should be removed entirely and the kernel can
> just use bprm->argmin? I haven't really looked at that to see if it's
> sane, though. It just feels like MAX_ARG_STRLEN isn't a meaningful
> limit.

Removing the limit entirely in favour of 'bprm->argmin' sounds good.
I'll try to make it so and will send v2.

What should be the fate of userspace-exported `MAX_ARG_STRLEN` value in
that case? Should it stay `(PAGE_SIZE * 32)`? Should it be removed
entirely? (a chance of user space build failures).

If we are to remove it entirely what should be the reasonable limit in
kernel for other subsystems that still use it?

    fs/binfmt_elf.c: len = strnlen_user((void __user *)p, MAX_ARG_STRLEN);
    fs/binfmt_elf_fdpic.c: len = strnlen_user(p, MAX_ARG_STRLEN);
    fs/binfmt_flat.c: len = strnlen_user(p, MAX_ARG_STRLEN);
    kernel/auditsc.c: len_full = strnlen_user(p, MAX_ARG_STRLEN) - 1;

Keeping it at an "arbitrary" 6MB limit looked safe :)

> -Kees
> 
> > 
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Eric Biederman <ebiederm@xmission.com>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: linux-mm@kvack.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
> > ---
> >  include/uapi/linux/binfmts.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> > index c6f9450efc12..4e828515a22e 100644
> > --- a/include/uapi/linux/binfmts.h
> > +++ b/include/uapi/linux/binfmts.h
> > @@ -8,11 +8,11 @@ struct pt_regs;
> >  
> >  /*
> >   * These are the maximum length and maximum number of strings passed to the
> > - * execve() system call.  MAX_ARG_STRLEN is essentially random but serves to
> > - * prevent the kernel from being unduly impacted by misaddressed pointers.
> > + * execve() system call.  MAX_ARG_STRLEN is as large as Linux allows new
> > + * stack to grow.  Currently it's `_STK_LIM / 4 * 3 = 6MB` (see fs/exec.c).
> >   * MAX_ARG_STRINGS is chosen to fit in a signed 32-bit integer.
> >   */
> > -#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
> > +#define MAX_ARG_STRLEN (6 * 1024 * 1024)
> >  #define MAX_ARG_STRINGS 0x7FFFFFFF
> >  
> >  /* sizeof(linux_binprm->buf) */
> > -- 
> > 2.42.0
> >   
> 
> -- 
> Kees Cook


-- 

  Sergei
