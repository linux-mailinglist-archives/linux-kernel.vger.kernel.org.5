Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117317B69C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjJCNEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJCNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:04:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98567A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:03:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c1c66876aso156847666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696338238; x=1696943038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEu1TDkTkvdCEua0yJX36scpXCe+7MsXep5BnaoLcfI=;
        b=Vt0AQjUbEXyJ63ef7Ts7VmYh8E1mUrGiiiASvdoRPTFzokNS0RSGrJAL1b1LCNi1hr
         9rZytjzEHh1ZewYjMORtCuD+XrS5afrPlis05o9cdAXsA+S3F0YW5KOppBU0TzUyASMR
         +n6LshHluqHGp2N4SWEn2+rWFg3zycvbV7VDexoMEtG3U38HEn89vOHTPalrtE18lJhz
         OANsEcamvQZy7YDB78Zpudi7a4gu4Tu/lHY4s6lW/GfOetrX/Rp+VAhS411toqgsFoMq
         PaeElnKgMvBanvu7X7B00NqRht47iy7w9tiJbkGI+I5yALUZCJCpdP7BxsIMtpmSmwaO
         lGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338238; x=1696943038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEu1TDkTkvdCEua0yJX36scpXCe+7MsXep5BnaoLcfI=;
        b=rzLdrbTOmn/vRGnJln6PKMdCDEw1ZClhKucdow2A48BRB7voYw5nKHadSukLSZuvc2
         F9KQs0VTxHl+cS+6mmvYE3yfZoF/0QcLbfL65+R/5kCfQO3YpIEHC4NHdz6pNCyg2VDV
         B+pzs2TCMte7EkDL/IRAsriTF2sjC+tZPN3NXQs2mb0XMwYqw6zjuvVsd9VfUj5jLWY6
         GPHia9t6HVL2VsuO4WN2jgzFS2BvYxXbptlpwdgsReWLQbdTN7qeJRTT5r11Gkcfy34K
         YWI/Vsh4LdLUIyuuJ6+xQ0xxXInMn9gvy1KWnTiO/Zus7gTylMukMFlQAXZyHeplAavE
         XCJQ==
X-Gm-Message-State: AOJu0YxlT2GBBw+gscgvPqjja7i9sYs1hcZn2F379X3OrXZf7KUr+n8I
        c3ez09gkbPr3HflFlbF78Q==
X-Google-Smtp-Source: AGHT+IFUAhWvvaCibuEHcOrIsliSc9nk/shcOmLSO84X0xcRU9DcfrmMhLzbe6rVQ50Kn6PMhqjMNA==
X-Received: by 2002:a17:906:8a7a:b0:9ae:3d75:4c83 with SMTP id hy26-20020a1709068a7a00b009ae3d754c83mr12831836ejc.0.1696338237366;
        Tue, 03 Oct 2023 06:03:57 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id fx13-20020a170906b74d00b009920a690cd9sm1045205ejb.59.2023.10.03.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:03:56 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:03:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Message-ID: <8b1297a4-00f0-431a-8fff-4ce2745adfab@p183>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <ZRrBwwf4nUiTju8Z@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRrBwwf4nUiTju8Z@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:12:35PM +0200, Ingo Molnar wrote:
> 
> * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Here is how it works:
> > 
> > * fault and fill the stack from rsp with int3 down until rlimit allows,
> > * fill upwards with int3 too, overwrite libc stuff, argv, envp,
> > * try to exec int3 on each page and catch it with either SIGSEGV or
> >   SIGTRAP handler.
> > 
> > Note: trying to execute _every_ int3 takes 30-40 seconds even on fast
> > machine, so only 1 int3 per page is tried.
> > 
> > Tested on F37 kernel and on custom kernel which did
> > 
> > 	vm_flags |= VM_EXEC;
> > 
> > to stack VMA.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  tools/testing/selftests/x86/Makefile   |    3 
> >  tools/testing/selftests/x86/nx_stack.c |  167 +++++++++++++++++++++++++++++++++
> >  2 files changed, 170 insertions(+)
> 
> Ok, that's a good idea, but could the test case please output something
> human-readable that indicates whether the test was a success or not?
> 
> A typical testcase output is like:
> 
>   kepler:~/tip/tools/testing/selftests/x86> ./sigaltstack_32 
>   [RUN]	Test an alternate signal stack of sufficient size.
> 	Raise SIGALRM. It is expected to be delivered.
>   [OK]	SIGALRM signal delivered.
> 
> Or:
> 
>   kepler:~/tip/tools/testing/selftests/x86> ./test_vsyscall_64 
>   ...
>   [OK]	vsyscalls are emulated (1 instructions in vsyscall page)
>   ...
> 
> ... where the 'OK' denotes success of a test.
> 
> The nx_stack testcase only outputs:
> 
>   stack min 00007fffd75b5000
>   stack max 00007fffd7db5000
> 
> ... with only the exit code denoting success/failure.

The way Unix Founding Fathers intented! :-)
OK, I'll add something.
