Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00ED80DF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbjLKXfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLKXfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:35:16 -0500
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D8CD;
        Mon, 11 Dec 2023 15:35:21 -0800 (PST)
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
        by postout1.mail.lrz.de (Postfix) with ESMTP id 4Spylm6qCGzyTp;
        Tue, 12 Dec 2023 00:35:16 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received; s=
        tu-postout21; t=1702337716; bh=hk0tuevZEoLDrYcG31rsdQ9GPMxog11sQ
        YsjOeuOlI8=; b=XT23O3A2DE9rX1e2iLgAYb42zO3ksg2FiIQsZRad0HZCTwWC0
        usp9rXYFgx2LzBIj0FHbpEZ9tghtY8gsUOpRJXyg1XOGEj1ewsA5/mZbhr9UICbS
        R1hRot9yXH014E2HSJ+E8Z54MctMgv1DYfZpwtPRlOe3md016seOEzGBCbJb5+/+
        rPFDJr1IOXVYuhEtoDNjesPywHOtmrZ2GToQB/GCMz1uQxjnHAokeR8NZyun1KMr
        mmESRYe9oUus1hWPZEKgtkB7/dIlfLdw85Jr8oUBAPjV7CQ5KbYlq+je/IaESULf
        01l+cY2MBiFO/w/aY2fHLeakCbonAP+KWLtqw==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Score: -2.881
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from postout1.mail.lrz.de ([127.0.0.1])
        by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id Cuu56KEaV5jm; Tue, 12 Dec 2023 00:35:16 +0100 (CET)
Received: from cerulean.fritz.box (unknown [IPv6:2001:a61:245c:a01:443b:cc34:8ae7:6ede])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4Spyll4BFKzyTb;
        Tue, 12 Dec 2023 00:35:15 +0100 (CET)
Date:   Tue, 12 Dec 2023 00:35:12 +0100
From:   Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Collingbourne <pcc@google.com>,
        andrey.konovalov@linux.dev,
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
Message-ID: <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
References: <20230215143306.2d563215@rorschach.local.home>
 <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home>
 <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
 <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
 <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2023 23:56, Marco Elver wrote:
> On Mon, 11 Dec 2023 at 23:48, Paul Heidekrüger <paul.heidekrueger@tum.de> wrote:
> >
> > On 11.12.2023 21:51, Andrey Konovalov wrote:
> > > On Mon, Dec 11, 2023 at 7:59 PM Paul Heidekrüger
> > > <paul.heidekrueger@tum.de> wrote:
> > > >
> > > > > Hi Paul,
> > > > >
> > > > > I've been successfully running KASAN tests with CONFIG_TRACEPOINTS
> > > > > enabled on arm64 since this patch landed.
> > > >
> > > > Interesting ...
> > > >
> > > > > What happens when you try running the tests with .kunitconfig? Does
> > > > > CONFIG_TRACEPOINTS or CONFIG_KASAN_KUNIT_TEST get disabled during
> > > > > kernel building?
> > > >
> > > > Yes, exactly, that's what's happening.
> > > >
> > > > Here's the output kunit.py is giving me. I replaced CONFIG_DEBUG_KERNEL with
> > > > CONFIG_TRACEPOINTS in my .kunitconfig. Otherwise, it's identical with the one I
> > > > posted above.
> > > >
> > > >         ➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
> > > >         Configuring KUnit Kernel ...
> > > >         Regenerating .config ...
> > > >         Populating config with:
> > > >         $ make ARCH=arm64 O=.kunit olddefconfig
> > > >         ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > > >         This is probably due to unsatisfied dependencies.
> > > >         Missing: CONFIG_KASAN_KUNIT_TEST=y, CONFIG_TRACEPOINTS=y
> > > >
> > > > Does CONFIG_TRACEPOINTS have some dependency I'm not seeing? I couldn't find a
> > > > reason why it would get disabled, but I could definitely be wrong.
> > >
> > > Does your .kunitconfig include CONFIG_TRACEPOINTS=y? I don't see it in
> > > the listing that you sent earlier.
> >
> > Yes. For the kunit.py output from my previous email, I replaced
> > CONFIG_DEBUG_KERNEL=y with CONFIG_TRACEPOINTS=y. So, the .kunitconfig I used to
> > produce the output above was:
> >
> >         CONFIG_KUNIT=y
> >         CONFIG_KUNIT_ALL_TESTS=n
> >         CONFIG_TRACEPOINTS=y
> >         CONFIG_KASAN=y
> >         CONFIG_KASAN_GENERIC=y
> >         CONFIG_KASAN_KUNIT_TEST=y
> >
> > This more or less mirrors what mm/kfence/.kunitconfig is doing, which also isn't
> > working on my side; kunit.py reports the same error.
> 
> mm/kfence/.kunitconfig does CONFIG_FTRACE=y. TRACEPOINTS is not user
> selectable. I don't think any of this has changed since the initial
> discussion above, so CONFIG_FTRACE=y is still needed.

Using CONFIG_FTRACE=y instead of CONFIG_TRACEPOINTS=y produces the same error 
for me. 

So

	CONFIG_KUNIT=y
	CONFIG_KUNIT_ALL_TESTS=n
	CONFIG_FTRACE=y
	CONFIG_KASAN=y
	CONFIG_KASAN_GENERIC=y
	CONFIG_KASAN_KUNIT_TEST=y

produces

	➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
	Configuring KUnit Kernel ...
	Regenerating .config ...
	Populating config with:
	$ make ARCH=arm64 O=.kunit olddefconfig CC=clang
	ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
	This is probably due to unsatisfied dependencies.
	Missing: CONFIG_KASAN_KUNIT_TEST=y
	
By that error message, CONFIG_FTRACE appears to be present in the generated 
config, but CONFIG_KASAN_KUNIT_TEST still isn't. Presumably, 
CONFIG_KASAN_KUNIT_TEST is missing because of an unsatisfied dependency, which 
must be CONFIG_TRACEPOINTS, unless I'm missing something ...

If I just generate an arm64 defconfig and select CONFIG_FTRACE=y, 
CONFIG_TRACEPOINTS=y shows up in my .config. So, maybe this is kunit.py-related 
then?

Andrey, you said that the tests have been working for you; are you running them 
with kunit.py?

Many thanks,
Paul

