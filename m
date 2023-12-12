Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7A80E749
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbjLLJTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbjLLJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:19:44 -0500
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B50FE;
        Tue, 12 Dec 2023 01:19:49 -0800 (PST)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4SqCkB4ZNdzyTl;
        Tue, 12 Dec 2023 10:19:46 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received; s=
        tu-postout21; t=1702372786; bh=WVqZLzbRiMUVOMOUzl6GSebSesNYA4TdD
        tY3d47tqa4=; b=icWpRiDQ+Dkbt+mbfo6bx1CaHVlYa5iIVdt+nEteVMvyk5htn
        ORZz4sgz+cJyVTstEOFDiKVgqoXEOZYjVsGNY1btar+2KLWGtlmxULK/NPPYZ8cf
        6NeuW01lhF9UQ7/Zusoo+1ahqV6ePZjLUNWb5kyJbZXAwkPvOmu+AjXUAZn+N99O
        eDlzA2ZQzcRM5NgucQA1PGPUXlL7OfbfWQ71C7vKH7w0pNuNilSOmGh8IPtS+Ne4
        SxSeNqMQA8EPgqiMUX+NvuVH6zZkjheMDThKsRCh15KZUGgOWGsUdpfPzWIUu+rk
        csqLkCQQb8xXf0kc3YCiAzWN7zLjAZF/sT/Hg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.881
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id U88J6q2Jd8Lb; Tue, 12 Dec 2023 10:19:46 +0100 (CET)
Received: from cerulean.fritz.box (unknown [IPv6:2001:a61:245c:a01:443b:cc34:8ae7:6ede])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4SqCk90XN5zyTm;
        Tue, 12 Dec 2023 10:19:45 +0100 (CET)
Date:   Tue, 12 Dec 2023 10:19:41 +0100
From:   Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>,
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
Message-ID: <rgndtm3sawyzdh76oofoqp22jyqdb25sd4326k2heevjmxum7f@wfgwvdf4iuyi>
References: <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home>
 <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
 <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
 <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
 <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
 <CA+fCnZf5kxWUWCzK8EKgUuq_E2rYv5aw=SqZMDb93+=7vSUp+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZf5kxWUWCzK8EKgUuq_E2rYv5aw=SqZMDb93+=7vSUp+w@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2023 00:37, Andrey Konovalov wrote:
> On Tue, Dec 12, 2023 at 12:35 AM Paul Heidekrüger
> <paul.heidekrueger@tum.de> wrote:
> >
> > Using CONFIG_FTRACE=y instead of CONFIG_TRACEPOINTS=y produces the same error
> > for me.
> >
> > So
> >
> >         CONFIG_KUNIT=y
> >         CONFIG_KUNIT_ALL_TESTS=n
> >         CONFIG_FTRACE=y
> >         CONFIG_KASAN=y
> >         CONFIG_KASAN_GENERIC=y
> >         CONFIG_KASAN_KUNIT_TEST=y
> >
> > produces
> >
> >         ➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
> >         Configuring KUnit Kernel ...
> >         Regenerating .config ...
> >         Populating config with:
> >         $ make ARCH=arm64 O=.kunit olddefconfig CC=clang
> >         ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >         This is probably due to unsatisfied dependencies.
> >         Missing: CONFIG_KASAN_KUNIT_TEST=y
> >
> > By that error message, CONFIG_FTRACE appears to be present in the generated
> > config, but CONFIG_KASAN_KUNIT_TEST still isn't. Presumably,
> > CONFIG_KASAN_KUNIT_TEST is missing because of an unsatisfied dependency, which
> > must be CONFIG_TRACEPOINTS, unless I'm missing something ...
> >
> > If I just generate an arm64 defconfig and select CONFIG_FTRACE=y,
> > CONFIG_TRACEPOINTS=y shows up in my .config. So, maybe this is kunit.py-related
> > then?
> >
> > Andrey, you said that the tests have been working for you; are you running them
> > with kunit.py?
> 
> No, I just run the kernel built with a config file that I put together
> based on defconfig.

Ah. I believe I've figured it out.

When I add CONFIG_STACK_TRACER=y in addition to CONFIG_FTRACE=y, it works.

CONFIG_STACK_TRACER selects CONFIG_FUNCTION_TRACER, CONFIG_FUNCTION_TRACER 
selects CONFIG_GENERIC_TRACER, CONFIG_GENERIC_TRACER selects CONFIG_TRACING, and 
CONFIG_TRACING selects CONFIG_TRACEPOINTS. 

CONFIG_BLK_DEV_IO_TRACE=y also works instead of CONFIG_STACK_TRACER=y, as it 
directly selects CONFIG_TRACEPOINTS. 

CONFIG_FTRACE=y on its own does not appear suffice for kunit.py on arm64.

I believe the reason my .kunitconfig as well as the existing 
mm/kfence/.kunitconfig work on X86 is because CONFIG_TRACEPOINTS=y is present in 
an X86 defconfig.

Does this make sense?

Would you welcome a patch addressing this for the existing 
mm/kfence/.kunitconfig?

I would also like to submit a patch for an mm/kasan/.kunitconfig. Do you think 
that would be helpful too?

FWICT, kernel/kcsan/.kunitconfig might also be affected since 
CONFIG_KCSAN_KUNIT_TEST also depends on CONFIG_TRACEPOITNS, but I would have to 
test that. That could be a third patch.

What do you think?

Many thanks,
Paul

