Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411680D29F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjLKQpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjLKQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:45:18 -0500
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 08:45:20 PST
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B5D2;
        Mon, 11 Dec 2023 08:45:20 -0800 (PST)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4SpnV85qdXzyVM;
        Mon, 11 Dec 2023 17:37:52 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received; s=tu-postout21; t=1702312671; bh=I
        QZ37jqHjRiCVAog/SxFby9In37jtg4+0rtjT7Qm7bQ=; b=mlVfJUG6uMk6HCn0w
        GE8s0S6afNDFSYXDag/1mnxPJU83BIHAt5ccF6i6+x4q+kPHXTfqbpKUI9Ps+DAF
        7D8eu4qS/ue6gZ+7mSqzxmc2IjIlsroDoEui4w3/8jgYSWMiAGjcFqJnh/DPmCFp
        Q7CQReOfLxA6F1jgf5NtgCYPReIDWM0YfYvjGSgEGEnhblaq/CUnk9ORGvG5I7F0
        kwCPNTX2zDiMKPtA3/f7awuim9OgqtxoQ7x9Fp6M++kSsdq2glcx6ocd8eQ8FnQx
        Nkhv+Ky1mpE0itBEcrGbXhyyAWvWyBF7TMZjun8sFCHHOrMNirXCaG80D1y6x/K9
        eW/BA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.883
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id qxvPLSwCoF-F; Mon, 11 Dec 2023 17:37:51 +0100 (CET)
Received: from Monitor.dos.cit.tum.de (Monitor.dos.cit.tum.de [IPv6:2a09:80c0:38::165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4SpnV65Z38zyTN;
        Mon, 11 Dec 2023 17:37:50 +0100 (CET)
Date:   Mon, 11 Dec 2023 17:37:38 +0100
From:   Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
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
Message-ID: <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home>
 <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505095805.759153de@gandalf.local.home>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 05.05.2023 09:58, Steven Rostedt wrote:
> On Mon, 1 May 2023 15:02:37 -0700
> Peter Collingbourne <pcc@google.com> wrote:
> 
> > > > "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> > > > really should just be for the function tracing infrastructure, and
> > > > perhaps not even include trace events :-/ But at the time it was
> > > > created, it was for all the "tracers" (this was added before trace
> > > > events).  
> > >
> > > It would be great to see this cleaned up. I found this aspect of how
> > > tracing works rather confusing.
> > >
> > > So do you think it makes sense for the KASAN tests to "select TRACING"
> > > for now if the code depends on the trace event infrastructure?  
> > 
> > Any thoughts? It looks like someone else got tripped up by this:
> > https://reviews.llvm.org/D144057
> 
> Yeah, it really does need to get cleaned up, but unfortunately it's not
> going to be a trivial change. We need to make sure it's done in a way that
> an old .config still keeps the same things enabled with the new config
> settings. That takes some trickery in the dependency.
> 
> I'll add this to my todo list, hopefully it doesn't fall into the abyss
> portion of that list :-p
> 
> -- Steve

Just adding to Peter's concern re: CONFIG_KASAN_KUNIT_TEST's dependency on 
CONFIG_TRACEPOINTS.

I'm having no luck running the KASan KUnit tests on arm64 with the following 
.kunitconfig on v6.6.0:

	CONFIG_KUNIT=y
	CONFIG_KUNIT_ALL_TESTS=n
	CONFIG_DEBUG_KERNEL=y
	CONFIG_KASAN=y
	CINFIG_KASAN_GENERIC=y
	CONFIG_KASAN_KUNIT_TEST=y

CONFIG_TRACEPOINTS, which CONFIG_KASAN_TEST relies on since the patch this 
thread is based on, isn't defined for arm64, AFAICT.

If I comment out the dependency on CONFIG_TRACEPOINTS, the tests appear to run, 
but KUnit isn't picking up the KASan output.

If I revert the patch, the above .kunitconfig appears to work fine on arm64 and 
the tests pass.

The above .kunitconfig works as intended on X86, no changes necessary. 

Am I missing something?

Many thanks,
Paul

