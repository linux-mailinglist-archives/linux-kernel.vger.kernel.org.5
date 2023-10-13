Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10BB7C83BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJMKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjJMKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:52:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234DC83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:52:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so22666395e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697194330; x=1697799130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQlLAZN0159rZz2dBKBST54MAz5ZF7KDyTuMyKf/LPQ=;
        b=bDXxbNv0xJvQY6z9JXwmZ8jIn2ZJikRLKYSj+9AiInQokleP9LqS1oI3NLerDaO6Zr
         jOVWFvu8o6pd2RtENXzgkbGpJ0GS5099Gu5aU1VXP9eqIyeT8b1DofwYaXqePXbuj96R
         zKu8taNIPRhv/1GKkVZSrI4ze0zoR5S/DGvBOx0ieWBSoOIIsQO7yF/lwqoN0gtACT6N
         clO7iCjanja0uMbhhcPqv2PGINq8JrnQaZekduce2T2KlwdgpWAU0i0ivjRpUTeoiQLY
         sa2hb4A4qJVsKyJyjqFuxMjOwzgUdQ0cnM84NdwxC9PcC6B5KQAo+um15MMFW6+OpVBm
         u3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194330; x=1697799130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQlLAZN0159rZz2dBKBST54MAz5ZF7KDyTuMyKf/LPQ=;
        b=HW/cMhrZxg5rSyauZpm6oZE00xLKsDCp+9HwF67ZeoiFSRe6OPq9nz80tW04a0B7X2
         5BY0whPa6KkLX81mWvFcH1n8mEOd1An+oNKa4F2cpjKG7y+9alThGSsnrxvA9NfgEoi2
         Fs474jxprkxi5EQXBLLeQDS6MvM2iXZLoH+g6aj5+ppxL06LIQCJ0lpmxwN3Z4q1cvU+
         6/RF80YUUnKNf0lZAQFCCcmwEKumtpHDKd+DGGmA18/Dxk8NPz7I3WEKgIETKMFH8gwa
         M5b4aVNUkjAtBbx9Z2ltBidFrmNBiuP+N2DOlVCemzs2Q4uWKabCjuI79Vk8lwl+LFJ8
         Lmyw==
X-Gm-Message-State: AOJu0YwcVCJvRtl7SVCvx0NBWI9T6oDtv2ymQFwywvmCls3HCKV3LtiR
        mwRQ88MWL8Cuz3qBx2lyulAniPA0Bkw=
X-Google-Smtp-Source: AGHT+IFyVPLURo6YHHwxcHWr5K6awgnvCVByk7EMfPcv1tNmijWLy51nhQTKhZTn7YHKXKUlxEyPYw==
X-Received: by 2002:a7b:ce98:0:b0:3fc:dd9:91fd with SMTP id q24-20020a7bce98000000b003fc0dd991fdmr22678767wmj.40.1697194330349;
        Fri, 13 Oct 2023 03:52:10 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm20811007wry.75.2023.10.13.03.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:52:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 13 Oct 2023 12:52:07 +0200
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
Message-ID: <ZSkhV/mwN9psjt/X@gmail.com>
References: <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4afyYK0-wAOo3oJDapX0iyu86m5+vVn9c35gk8fd6iwRQ@mail.gmail.com>
 <CAHk-=wiLyA0g3BvQ_nsF2PWi-FDtcNS5+4-ai1FX-xFzTBeTzg@mail.gmail.com>
 <ZScjptMn3fDmMFdg@gmail.com>
 <9b71932a-d410-4b92-b605-d6acc5d35069@zytor.com>
 <20231012013507.jrqnm35p7az6atov@treble>
 <ZSeP4vwQ9k/v63Cy@gmail.com>
 <20231012160801.blc2t37gfqhlah5h@treble>
 <ZSg0D0bRlzXdqZRS@gmail.com>
 <20231012213038.pnq6eds53dbqxstj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012213038.pnq6eds53dbqxstj@treble>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> Right now my preference would be to leave the existing interface as-is,
> and then graft optional subcommands on top.  If no subcommand is
> specified then it would default to the "run" subcommand.  It's a little
> funky, but it would work well for the common case, where ~99% of the
> functionality lives.  And it doesn't break existing setups and
> backports.
> 
> For example:
> 
>   # current interface (no changes)
>   objtool --mcount --orc --retpoline --uaccess vmlinux.o
> 
>   # same, with optional explicit "run" subcommand
>   objtool run --mcount --orc --retpoline --uaccess vmlinux.o
> 
>   # new "size" subcommand
>   obtool size [options] vmlinux.o.before vmlinux.o.after

Yeah, sounds good!

Thanks,

	Ingo
