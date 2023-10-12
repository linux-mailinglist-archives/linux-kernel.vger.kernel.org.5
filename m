Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C347C7586
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442107AbjJLR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442059AbjJLR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:59:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5ABB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:59:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso12873785e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133586; x=1697738386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPbC/iHdlRJ3Q6/Kraji8ZOEZVrzyhL0x3ERwg+kQjg=;
        b=P71F1ckiQJjD8rhOWBdJZ3YhCdeEjWkhDTPDMQh7bEKX2wmUCRvSzs3mRxTdnLJjuB
         0ZyUQWIAbXDilSzgzZzRgLv937E0b9Fk9OkNGVGdmNzAL4je7yHSfMrXNeMVVcSkYx1d
         zyGwABbRulzWkcFEmUpTsIwymNnN54xwxmHmAdoe3vsmYK0nfebzhwPWk7fYGkTc0msB
         lVGa8ObRnizxa2FCgE+xldFt/R8fkLfhgbFKgGX9XL8PVsONcu3Cxszp/KT8YhbyfIyK
         LSd3ghmhkOcMkfQKy245pM9c5KeQhpP5mMjBB1abeO3MNhrwM30jVH8keADeNEJtKiLB
         eUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133586; x=1697738386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPbC/iHdlRJ3Q6/Kraji8ZOEZVrzyhL0x3ERwg+kQjg=;
        b=nUZ4VvOyaNdOw7Z72nxSV8PVUOA2yM101DNYL/wKRZFKQmr3TKvVQY9dJUTuOEHXD0
         WGh+qWEJKrbGsOA5Ro1zjqWBITerJY9LTNHAoX0RKtDVLmcGRfoaTdUpg2vPAtOefNah
         PZtdDrA6DL998L3sKGXiucOndm29VLvSG88nANF6o0FEfZj6sb7iLEmty44yjeKzLdNS
         XuxBBjDhIfjfN/LJ3+U8a0I9AIMZHLpRH0EMdw35GnEEiqZJeE+hBUleJ8MfzxgvejAU
         wGhSttOJdv1aYmopHbAE8OBWqDEECPOkiUsOg7QBBKUdw1bpfVEgUGrEHi1kF5uiPleY
         e+XQ==
X-Gm-Message-State: AOJu0Yy4tt+C4HTDfuYy13FrS1P703ek5TrUzsDkNAubGT9MFTXPtP0F
        5vClwreyLxTzmHg7rF8sWzs=
X-Google-Smtp-Source: AGHT+IE88OZcqOmD27e08AKTc9COHaUl8/L44Tw9bseCUxYDpg9gPQMUe4RadNwyBxJBOA23zgGQ9w==
X-Received: by 2002:a05:600c:20b:b0:404:fc52:a3c6 with SMTP id 11-20020a05600c020b00b00404fc52a3c6mr22722566wmi.25.1697133586100;
        Thu, 12 Oct 2023 10:59:46 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c21c300b004053a6b8c41sm432527wmj.12.2023.10.12.10.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:59:45 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 19:59:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Message-ID: <ZSg0D0bRlzXdqZRS@gmail.com>
References: <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
 <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
 <20231012013507.jrqnm35p7az6atov@treble>
 <ZSeP4vwQ9k/v63Cy@gmail.com>
 <20231012160801.blc2t37gfqhlah5h@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012160801.blc2t37gfqhlah5h@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Thu, Oct 12, 2023 at 08:19:14AM +0200, Ingo Molnar wrote:
> > 
> > * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > 
> > > Though, another problem is that .text has a crazy amount of padding
> > > which makes it always the same size, due to the SRSO alias mitigation
> > > alignment linker magic.  We should fix that somehow.
> > 
> > We could emit a non-aligned end-of-text symbol (we might have it already),
> > and have a script or small .c program in scripts/ or tools/ that looks
> > at vmlinux and displays a user-friendly and accurate list of text and
> > data sizes in the kernel?
> > 
> > And since objtool is technically an 'object files tool', and it already
> > looks at sections & symbols, it could also grow a:
> > 
> > 	objtool size <objfile>
> > 
> > command that does the sane thing ... I'd definitely start using that, instead of 'size'.
> > 
> > /me runs :-)
> 
> Yeah, that's actually not a bad idea.
> 
> I had been thinking a "simple" script would be fine, but I'm realizing
> the scope of this thing could grow over time.  In which case a script is
> less than ideal.  And objtool already has the ability to do this pretty
> easily.

Yeah, and speed actually matters here: I have scripts that generate object 
comparisons between commits, and every second of runtime counts - and a 
script would be slower and more fragile for something like allmodconfig 
builds or larger disto configs.

BTW., maybe the right objtool subcommand would be 'objtool sections', with 
an 'objtool sections size' sub-sub-command. Because I think this discussion 
shows that it would be good to have a bit of visibility into the sanity of 
our sections setup, with 'objtool sections check' for example doing a 
sanity check on whether there's anything extra in the text section that 
shouldn't be there? Or so ...

Thanks,

	Ingo
