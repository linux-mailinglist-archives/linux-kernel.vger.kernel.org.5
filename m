Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36E7BDB78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjJIMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346584AbjJIMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:20:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4962E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:20:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so2630358f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696854033; x=1697458833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKWZi6QnIBU7uXjbmmPObtDt+WtLjjfCoWB7xA9XZY4=;
        b=Ej7FOSsfV58sjoAVX8PE0X0IbUeHZ/2rYF6h9Y6mFul66pSyGZE7hHu11uMwJvFOqr
         f5mRbwen/z4BeF4ZGLZ9Zp5lUp9OP2JRrgMthidFK9pxuGGDxPTAVtYn+4YNX3dl1C+o
         lAbmCj+iKeubv4sCQBur/TvL0vRt242S74GxO5nzrU3BbSJlH/ZXtP18PHyjeUX7Uahk
         MFijd/2/ay1cAwm/UZA8Jbied2JYvAdFwUdu7A7IfolzBay9F29koUCdJTYe3/2zKOg6
         /8Nk+hdkd6Ng6Qlg1M75Mt9HH3948N+ZeBok+DojUPBHrSGhB8O5ROTNJL7G29pVUTaz
         EaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696854033; x=1697458833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKWZi6QnIBU7uXjbmmPObtDt+WtLjjfCoWB7xA9XZY4=;
        b=sc0klSr1eVdt/n66knWomxsmCvb/jLSb0jaX87wBZC0X/oJdFFYlCxGx8ad/DcIM9W
         RJth9V0IT4mEZ/EOpCOlLLddoiUg1MgV7BlcLvZm5sZDgl8gpu/HpcQQ4bAEfkprHhAa
         wvEjZ7rt3G3syYTOxSAADqmx2FWP4EXZJqvAXOPOiUhMuQ9LuXxOZcZNhhyN1/Pm/ugb
         5yrDSP72dakLlwnn4CQHZLRSGqfc8aqk9Aoy4ZYUIDC63XG/okcn7QSmZOGkxDksfYqL
         EM5/T7OVZGgX6vSDgufMihCqyp2db7RkqeH+xQ++fUa/UOirXh1087BHClizbV+S9Ux6
         kDVw==
X-Gm-Message-State: AOJu0YziDg2yq8Nn6lcT0jmdRkVt+5n1WXgYuCN1nxEV7KN5rTi3+dJe
        GkOeWsRgBxr7kF9wMoiz1Es=
X-Google-Smtp-Source: AGHT+IGd2bEZsj+OBiKcjr46KOUx/5V5MDKl7dvtob5+nFIQtsnO+/AGAxscvbQPqZtDtLto1m2lPQ==
X-Received: by 2002:a5d:6048:0:b0:320:6d6:315b with SMTP id j8-20020a5d6048000000b0032006d6315bmr10835863wrt.29.1696854032974;
        Mon, 09 Oct 2023 05:20:32 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id n6-20020adffe06000000b003140f47224csm9521281wrr.15.2023.10.09.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 05:20:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 14:20:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Message-ID: <ZSPwDle/yk9tQHSD@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
 <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com>
 <ZSPpW3zLTn7IohOJ@gmail.com>
 <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bjnro3CFQLY=qR0S5M0WY3NkrVUW-JUk4nB4mV7xhWNg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Mon, Oct 9, 2023 at 1:51 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index ecb256954351..1edf4a5b93ca 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
> > > >
> > > >  config USE_X86_SEG_SUPPORT
> > > >     def_bool y
> > > > -   depends on CC_HAS_NAMED_AS && SMP
> > > > +   depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > > > +   depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > >
> > > So I'd rather express this as a Kconfig quirk line, and explain each quirk.
> > >
> > > Something like:
> > >
> > >       depends on CC_HAS_NAMED_AS
> > >       depends on SMP
> > >       #
> > >       # -fsanitize=kernel-address (KASAN) is at the moment incompatible
> > >       # with named address spaces - see GCC bug #12345.
> > >       #
> > >       depends on !KASAN
> > >
> > > ... or so.
> >
> > BTW., while this OK for testing, this is too heavy handed for release
> > purposes, so please only disable the KASAN instrumentation for the affected
> > percpu accessors.
> >
> > See the various __no_sanitize* attributes available.
> 
> These attributes are for function declarations. The percpu casts can
> not be implemented with separate static inline functions. Also,
> __no_sanitize_address is mutually exclusive with __always_inline.

Sigh - I guess the Kconfig toggle is the only solution then?

Thanks,

	Ingo
