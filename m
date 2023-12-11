Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3E80DA18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjLKS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjLKS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:59:17 -0500
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD920B4;
        Mon, 11 Dec 2023 10:59:21 -0800 (PST)
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
        by postout1.mail.lrz.de (Postfix) with ESMTP id 4SprdL22mNzyTc;
        Mon, 11 Dec 2023 19:59:18 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received; s=
        tu-postout21; t=1702321156; bh=wzxkPiBTm3s8ZGp87MxJnVY/QY6RAgQlb
        fQjTK03dlg=; b=OD+eLULtQirJNVgNfxfD5We9/CnESR3bql7En7h6xjEkCVHqJ
        /VnNO/xymw6jV9CfXtOQyeeqS22wLqXgnd0Mq+Zm9Ur9sABCAwx0YxqyuXyQvbkU
        xnIClFKRbPMemo/qb8gb8lN9Ll65aFOCsWRgtrIAF1/0IBT89rB6gC4T6PZbMYph
        AeHr1LiiRx3Hk4ieM3JCyf727JUcWNSvr6G8Rhxo2oLzKBO4qThwZjRa/kz+6vtm
        zhOKYbsv2NIgrXkIwyTJY7NT7e5eJ0oK7GAGnRpFMrN51gNd57G8spCj4GjZldHF
        sIW2SInC3qweh6Larylr9jRDyDS2GnKuyHzMw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Score: -2.881
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from postout1.mail.lrz.de ([127.0.0.1])
        by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id fmaQedN7hfuU; Mon, 11 Dec 2023 19:59:16 +0100 (CET)
Received: from Monitor.dos.cit.tum.de (Monitor.dos.cit.tum.de [IPv6:2a09:80c0:38::165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4SprdH6P1fzySj;
        Mon, 11 Dec 2023 19:59:15 +0100 (CET)
Date:   Mon, 11 Dec 2023 19:59:10 +0100
From:   Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Collingbourne <pcc@google.com>,
        Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
Message-ID: <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
References: <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home>
 <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home>
 <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey!

On 11.12.2023 18:50, Andrey Konovalov wrote:
> On Mon, Dec 11, 2023 at 5:37 PM Paul Heidekrüger
> <paul.heidekrueger@tum.de> wrote:
> >
> > Hi all!
> >
> > On 05.05.2023 09:58, Steven Rostedt wrote:
> > > On Mon, 1 May 2023 15:02:37 -0700
> > > Peter Collingbourne <pcc@google.com> wrote:
> > >
> > > > > > "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> > > > > > really should just be for the function tracing infrastructure, and
> > > > > > perhaps not even include trace events :-/ But at the time it was
> > > > > > created, it was for all the "tracers" (this was added before trace
> > > > > > events).
> > > > >
> > > > > It would be great to see this cleaned up. I found this aspect of how
> > > > > tracing works rather confusing.
> > > > >
> > > > > So do you think it makes sense for the KASAN tests to "select TRACING"
> > > > > for now if the code depends on the trace event infrastructure?
> > > >
> > > > Any thoughts? It looks like someone else got tripped up by this:
> > > > https://reviews.llvm.org/D144057
> > >
> > > Yeah, it really does need to get cleaned up, but unfortunately it's not
> > > going to be a trivial change. We need to make sure it's done in a way that
> > > an old .config still keeps the same things enabled with the new config
> > > settings. That takes some trickery in the dependency.
> > >
> > > I'll add this to my todo list, hopefully it doesn't fall into the abyss
> > > portion of that list :-p
> > >
> > > -- Steve
> >
> > Just adding to Peter's concern re: CONFIG_KASAN_KUNIT_TEST's dependency on
> > CONFIG_TRACEPOINTS.
> >
> > I'm having no luck running the KASan KUnit tests on arm64 with the following
> > .kunitconfig on v6.6.0:
> >
> >         CONFIG_KUNIT=y
> >         CONFIG_KUNIT_ALL_TESTS=n
> >         CONFIG_DEBUG_KERNEL=y
> >         CONFIG_KASAN=y
> >         CINFIG_KASAN_GENERIC=y
> >         CONFIG_KASAN_KUNIT_TEST=y
> >
> > CONFIG_TRACEPOINTS, which CONFIG_KASAN_TEST relies on since the patch this
> > thread is based on, isn't defined for arm64, AFAICT.
> >
> > If I comment out the dependency on CONFIG_TRACEPOINTS, the tests appear to run,
> > but KUnit isn't picking up the KASan output.
> >
> > If I revert the patch, the above .kunitconfig appears to work fine on arm64 and
> > the tests pass.
> >
> > The above .kunitconfig works as intended on X86, no changes necessary.
> >
> > Am I missing something?
> 
> Hi Paul,
> 
> I've been successfully running KASAN tests with CONFIG_TRACEPOINTS
> enabled on arm64 since this patch landed.

Interesting ... 

> What happens when you try running the tests with .kunitconfig? Does
> CONFIG_TRACEPOINTS or CONFIG_KASAN_KUNIT_TEST get disabled during
> kernel building? 

Yes, exactly, that's what's happening.

Here's the output kunit.py is giving me. I replaced CONFIG_DEBUG_KERNEL with 
CONFIG_TRACEPOINTS in my .kunitconfig. Otherwise, it's identical with the one I 
posted above.

	➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
	Configuring KUnit Kernel ...
	Regenerating .config ...
	Populating config with:
	$ make ARCH=arm64 O=.kunit olddefconfig
	ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
	This is probably due to unsatisfied dependencies.
	Missing: CONFIG_KASAN_KUNIT_TEST=y, CONFIG_TRACEPOINTS=y

Does CONFIG_TRACEPOINTS have some dependency I'm not seeing? I couldn't find a 
reason why it would get disabled, but I could definitely be wrong.

> Or tests just don't get executed?
> 
> Thanks!

Many thanks,
Paul
