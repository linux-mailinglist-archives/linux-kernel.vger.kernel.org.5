Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A4180DE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbjLKWsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjLKWsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:48:21 -0500
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C38187;
        Mon, 11 Dec 2023 14:48:05 -0800 (PST)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4SpxjG5tDvzyTl;
        Mon, 11 Dec 2023 23:48:02 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received; s=
        tu-postout21; t=1702334882; bh=Lyi9Y87z52dsNVzPku4bbN/tUE2KjXbNI
        DCbU7BhnmU=; b=MZQYpE9qpYGWkW9PZljSYvvd3CVqIuFNXTIVmfPyKzZACNgTx
        PptgPSIyoiXHyf3tOlHvrzhaW5B3N4TznJlvgPVgDfOIr5xbLNArick89XfZWxfB
        AtUGh5CEB0ZeN3WcfkFh9nJXColDrXIeP22d6THk+gs13FgsUYaautEet7HpIHH9
        PDEtAM/ZLueCMz8lbzNMuRjppVeGgv8c0CREyYAjhx3x1yFCg0k1Khh4eBERjhkl
        CtQAtIVVjQfGBjnxdfnzEvzYBbTfA1R0mSTZJwy+Fs8nxCsjpxi7xE+ABKXhpY9g
        nJOFukKNMODZ0wch69wX+Wns0iXIT5wfVwj1g==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.881
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id RXtrqxiiQ05L; Mon, 11 Dec 2023 23:48:02 +0100 (CET)
Received: from cerulean.fritz.box (unknown [IPv6:2001:a61:245c:a01:443b:cc34:8ae7:6ede])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4SpxjF04PnzyTZ;
        Mon, 11 Dec 2023 23:48:00 +0100 (CET)
Date:   Mon, 11 Dec 2023 23:47:57 +0100
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
Message-ID: <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
References: <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home>
 <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home>
 <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2023 21:51, Andrey Konovalov wrote:
> On Mon, Dec 11, 2023 at 7:59 PM Paul Heidekrüger
> <paul.heidekrueger@tum.de> wrote:
> >
> > > Hi Paul,
> > >
> > > I've been successfully running KASAN tests with CONFIG_TRACEPOINTS
> > > enabled on arm64 since this patch landed.
> >
> > Interesting ...
> >
> > > What happens when you try running the tests with .kunitconfig? Does
> > > CONFIG_TRACEPOINTS or CONFIG_KASAN_KUNIT_TEST get disabled during
> > > kernel building?
> >
> > Yes, exactly, that's what's happening.
> >
> > Here's the output kunit.py is giving me. I replaced CONFIG_DEBUG_KERNEL with
> > CONFIG_TRACEPOINTS in my .kunitconfig. Otherwise, it's identical with the one I
> > posted above.
> >
> >         ➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
> >         Configuring KUnit Kernel ...
> >         Regenerating .config ...
> >         Populating config with:
> >         $ make ARCH=arm64 O=.kunit olddefconfig
> >         ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >         This is probably due to unsatisfied dependencies.
> >         Missing: CONFIG_KASAN_KUNIT_TEST=y, CONFIG_TRACEPOINTS=y
> >
> > Does CONFIG_TRACEPOINTS have some dependency I'm not seeing? I couldn't find a
> > reason why it would get disabled, but I could definitely be wrong.
> 
> Does your .kunitconfig include CONFIG_TRACEPOINTS=y? I don't see it in
> the listing that you sent earlier.

Yes. For the kunit.py output from my previous email, I replaced 
CONFIG_DEBUG_KERNEL=y with CONFIG_TRACEPOINTS=y. So, the .kunitconfig I used to 
produce the output above was:
	
	CONFIG_KUNIT=y
	CONFIG_KUNIT_ALL_TESTS=n
	CONFIG_TRACEPOINTS=y
	CONFIG_KASAN=y
	CONFIG_KASAN_GENERIC=y
	CONFIG_KASAN_KUNIT_TEST=y

This more or less mirrors what mm/kfence/.kunitconfig is doing, which also isn't 
working on my side; kunit.py reports the same error.

Many thanks,
Paul
