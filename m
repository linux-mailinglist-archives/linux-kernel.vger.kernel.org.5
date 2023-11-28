Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C397FC149
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbjK1RiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345467AbjK1RiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:38:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C858F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:38:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595FFC433C8;
        Tue, 28 Nov 2023 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701193091;
        bh=RNOf8IUGxxmeyuakZPDZPc9mbJAGG9faA4v5329Ernw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bz4SkCebOTVMTP6Qa7rIp0+bVTQpj0o9TlcZB74as2jAGtg3bYSAUF7Xbs9XhxoJf
         i3H5zpbjrNdQ0Z9wMVcezaM/z7GU0TOr0qLMPnsQHNFvlCAYh21X/M/GwZDZ2cMuNS
         ywI6hyORJRnNNuxwrqFV/iY/q6YIFxsVh636iQ8iMZiOr/H/fHWb2yBdMuXvHDJOaI
         bUg+40VS2I1a6IlJhSAD/b2Qa312hcR4XAFBnd6vJV5JxOcGhl68xRcr9OrasJeocY
         hWqHXmTy+C5hSwokkLdo9b29Af/tfyOqn+D3oAYRsNuJJB+Eilv9ooTrdP7wvKVtgl
         CDs1Pb8P4o1vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EDFA40094; Tue, 28 Nov 2023 14:38:09 -0300 (-03)
Date:   Tue, 28 Nov 2023 14:38:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 04/53] perf mmap: Lazily initialize zstd streams
Message-ID: <ZWYlgPwGmAEUKIsE@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-5-irogers@google.com>
 <ZWURZvDA2L4Mr3HR@kernel.org>
 <ZWYf+Sy6JKd7CYlN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYf+Sy6JKd7CYlN@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 28, 2023 at 02:14:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 27, 2023 at 07:00:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Nov 02, 2023 at 10:56:46AM -0700, Ian Rogers escreveu:
> > > Zstd streams create dictionaries that can require significant RAM,
> > > especially when there is one per-CPU. Tools like perf record won't use
> > > the streams without the -z option, and so the creation of the streams
> > > is pure overhead. Switch to creating the streams on first use.

> > > Signed-off-by: Ian Rogers <irogers@google.com>

> > Thanks, applied to perf-tools-next.

> Trying to fix this now:
> 
>   6    20.59 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?

So the problem was really the one above, that got fixed with the patch
below, that is what 'man size_t' documents on my fedora:38 system.

- Arnaldo

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 9eb6eb5bf038ce54..b29109cd36095c4f 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -3,7 +3,8 @@
 #define PERF_COMPRESS_H
 
 #include <stdbool.h>
-#include <stdlib.h>
+#include <stddef.h>
+#include <sys/types.h>
 #ifdef HAVE_ZSTD_SUPPORT
 #include <zstd.h>
 #endif

>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
>       CC      /tmp/build/perf/util/zstd.o
>       CC      /tmp/build/perf/util/cap.o
>       CXX     /tmp/build/perf/util/demangle-cxx.o
>       CC      /tmp/build/perf/util/demangle-ocaml.o
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>       CC      /tmp/build/perf/util/demangle-java.o
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>    7    21.14 alpine:edge                   : FAIL gcc version 13.1.1 20230722 (Alpine 13.1.1_git20230722)
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     make[3]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: util] Error 2
>       CC      /tmp/build/perf/util/cap.o
>       CXX     /tmp/build/perf/util/demangle-cxx.o
>       CC      /tmp/build/perf/util/demangle-ocaml.o
>       CC      /tmp/build/perf/util/demangle-java.o
>     In file included from util/zstd.c:5:
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           | ^~~~~~~
>           | size_t
>     util/zstd.c:31:9: error: conflicting types for 'zstd_compress_stream_to_records'; have 'ssize_t(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'long int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        31 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     /git/perf-6.6.0-rc1/tools/perf/util/compress.h:34:9: note: previous declaration of 'zstd_compress_stream_to_records' with type 'int(struct zstd_data *, void *, size_t,  void *, size_t,  size_t,  size_t (*)(void *, size_t))' {aka 'int(struct zstd_data *, void *, long unsigned int,  void *, long unsigned int,  long unsigned int,  long unsigned int (*)(void *, long unsigned int))'}
>        34 | ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

-- 
