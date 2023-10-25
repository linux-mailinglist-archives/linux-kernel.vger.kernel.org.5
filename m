Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC07D615A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJYF6W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 01:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYF6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:58:21 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEB7AC;
        Tue, 24 Oct 2023 22:58:17 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-27d3c886671so4634592a91.3;
        Tue, 24 Oct 2023 22:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213496; x=1698818296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V05i2ECvWgChxk8nStR6mE0WuTD+NL192RARRKjFwM4=;
        b=KdKhdXrJbHwks4dDUY5wugqHfzHx2H2YrHU5uE132pdi8CdmzT8dqlXklw/jdwbkI1
         bwhP9Vyaic8cFgJghFxDCrSz+lEYgXwHtXeKVDz9HDQ1+rGTwHVaM3OpqQSrpQCPmB72
         O95BiQyRmns8yxrVSGXbsz3skrx65ZqvZs5EZ3SRI08s1OO6q7Awhc7NkV/4QGa+IDWy
         sZ0XdaWSIDSr1PxEw6jMM88L0bLStscDFDJNY24KYQ8Vic8z4/tJ40mSEK62SNl4qB+Y
         v9nhQFkFPP52a3XL4dVKRuZQyyg8Sw86wpYFymYZ0EqTHhK2lNNSiIPDbUevKSmQ8sC/
         puHg==
X-Gm-Message-State: AOJu0YwAijsFzLkYRbTwFILNVE2F780e15PyxkA/ocSfA3UHdIweBuW9
        UYS7uYzx9QOuUNe6PiUZe9Btt9SDlYUtJbqS3vo=
X-Google-Smtp-Source: AGHT+IG+vHgzKghvsoVyNwhQEBIST83HNK3dp1eKEgC/ffGx+TKBO/S/DFDh2BcIfu5GbvxcbPLsGTgjzwQGyyDK7Gc=
X-Received: by 2002:a17:90a:4b0f:b0:27d:ed83:fdff with SMTP id
 g15-20020a17090a4b0f00b0027ded83fdffmr478973pjh.16.1698213496543; Tue, 24 Oct
 2023 22:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012091128.GL6307@noisy.programming.kicks-ass.net>
 <CAM9d7cgcFCidNamZm+O-89N-Jf4EYF263f1GbxYf0xEbkwwE6Q@mail.gmail.com> <CADzB+2mu98v9EUsA1Y-wVDSrXT2kznKi87Tb6QdN5y4mMFNsyg@mail.gmail.com>
In-Reply-To: <CADzB+2mu98v9EUsA1Y-wVDSrXT2kznKi87Tb6QdN5y4mMFNsyg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Oct 2023 22:58:05 -0700
Message-ID: <CAM9d7ciTKe4O-23j10wC8DUbX_cmNewbLwZq99kMh_1ZA+5e0w@mail.gmail.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
To:     Jason Merrill <jason@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 24, 2023 at 8:07 PM Jason Merrill <jason@redhat.com> wrote:
>
> On Thu, Oct 12, 2023 at 12:44 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Thu, Oct 12, 2023 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> > > This can generate instructions like below.
>> > >
>> > >     ...
>> > >     0x123456:  mov    0x18(%rdi), %rcx
>> > >     0x12345a:  mov    0x10(%rcx), %rax     <=== sample
>> > >     0x12345e:  test   %rax, %rax
>> > >     0x123461:  je     <...>
>> > >     ...
>> > >
>> > > And imagine we have a sample at 0x12345a.  Then it cannot find a
>> > > variable for %rcx since DWARF didn't generate one (it only knows about
>> > > 'bar').  Without compiler support, all it can do is to track the code
>> > > execution in each instruction and propagate the type info in each
>> > > register and stack location by following the memory access.
>> >
>> > Right, this has more or less been the 'excuse' for why doing this has
>> > been 'difficult' for the past 10+ years :/
>>
>> I'm sure I missed some cases, but I managed to make it work on
>> usual cases.  We can improve it by handling it more cases and
>> instructions but it'd be great if we have a better support from the
>> toolchains.
>
>
> How helpful would it be for the compiler to generate an unnamed DW_TAG_variable for the temporary in %rcx?

That'd be fantastic, and that's exactly what I'm asking. :)

>
>>
>> > > Actually I found a discussion in the DWARF mailing list to support
>> > > "inverted location lists" and it seems a perfect fit for this project.
>> > > It'd be great if new DWARF would provide a way to lookup variable and
>> > > type info using a concrete location info (like a register number).
>> > >
>> > >   https://lists.dwarfstd.org/pipermail/dwarf-discuss/2023-June/002278.html
>> >
>> > Stephane was going to talk to tools people about this over 10 years ago
>> > :-)
>>
>> Hope that they would make some progress.
>
>
> This seems expensive in debug info size for a lookup optimization; better IMO to construct the reverse lookup table from the existing information, as it sounds like you are doing.  Though it would be good to cache that table between runs, and ideally share it with other interested tools.

Probably.  Then it still needs a standard way to express such data.
Maybe we can have an option to generate the table.

Thanks,
Namhyung
