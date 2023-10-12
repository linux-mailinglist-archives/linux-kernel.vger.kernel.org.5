Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541D57C6945
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjJLJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjJLJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:17:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A6CA;
        Thu, 12 Oct 2023 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SY5yqmx7UFQ27nMH5z2Z6G4quyyShMn+b9u4K2hwCUk=; b=Kuw8PvSmEOCGiEh1bcE5c93zOf
        UfMqN9elE915IiKRRyJatxJw8k66yVw8f6StP7tcTqF8Gxk957xNQ+xH9QRVvlkjW6PEkTf5/+/7b
        Oq0aeMRXXwlo1UoyY8qUo5kTQniVMMjjBKB9dmKVt6Ro7dADusdPGIoTBvvdu5pcli2Ij6KZbv/jH
        AYkZHhJtd8sDKci0/Kj9OwuLH2kYm0ltifRtcPkzAIeJ5PxAox8Zvbfm3xhh9A9HlqkX1I6qcdGkN
        wBS2lnFMKio5saaCjl0JbBdZifa31gUptVONJxMgyMeoHmqUKyEencbuaSS6ZhzFlI+Iw+D1jV2aZ
        ja5cOr/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqrn6-001hMl-2e;
        Thu, 12 Oct 2023 09:17:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E353830036C; Thu, 12 Oct 2023 11:15:37 +0200 (CEST)
Date:   Thu, 12 Oct 2023 11:15:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
Message-ID: <20231012091537.GM6307@noisy.programming.kicks-ass.net>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:50:23PM -0700, Namhyung Kim wrote:

> Actually there's a performance issue about getting disassembly from the
> objdump for kernel.  On my system, GNU objdump was really slower than the
> one from LLVM for some reason so I had to pass the following option for
> each perf report and perf annotate.
> 
>     $ sudo perf report --objdump=llvm-objdump ...
> 
>     # To save it in the config file and drop the command line option
>     $ sudo perf config annotate.objdump=llvm-objdump
> 
> Even with this change, still the most processing time was spent on the
> objdump to get the disassembly.  It'd be nice if we can get the result
> without using objdump at all.

So the kernel has an instruction decoder, all we need is something that
can pretty print the result. IIRC Masami had an early version of that
somewhere.

With those bits, and some basic ELF parsing (find in objtool for
instance) you can implement most of objdump yourself.
