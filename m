Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABAB7F84FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKXT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjKXT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A61985
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700855882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybZHlf/mJ5/agtbykqICZuSlViY9e9I6Dg/UHiB8cLQ=;
        b=erN7nkvweqNrlLQB6ypKGRvL/GBd73AthtFjModZoWPm122byudHBSBVv2LV0bvMwdGMUy
        Q6y8CN6SCcn+LvL+0YguzXCyRCmYErJNExzQP5lgduRwuQaPsoIezzUqS8giNRgOfU1h87
        WYw2dqFynwJqhHskP5CH6rCBFiu5iT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-UO0m5vkXNr-M-vmDPfxr6Q-1; Fri,
 24 Nov 2023 14:57:58 -0500
X-MC-Unique: UO0m5vkXNr-M-vmDPfxr6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26F051C0515B;
        Fri, 24 Nov 2023 19:57:58 +0000 (UTC)
Received: from Diego (unknown [10.39.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B15F2026D68;
        Fri, 24 Nov 2023 19:57:55 +0000 (UTC)
Date:   Fri, 24 Nov 2023 20:57:52 +0100 (CET)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Nick Forrington <nick.forrington@arm.com>
cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
In-Reply-To: <20231102162225.50028-1-nick.forrington@arm.com>
Message-ID: <alpine.LRH.2.20.2311242037260.11297@Diego>
References: <20231102162225.50028-1-nick.forrington@arm.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023, Nick Forrington wrote:
> The current use of atomics can lead to test failures, as tests (such as
> tests/shell/record.sh) search for samples with "test_loop" as the
> top-most stack frame, but find frames related to the atomic operation
> (e.g. __aarch64_ldadd4_relax).
> 
> This change simply removes the "count" variable, as it is not necessary.

Hello.

I believe that it was there to prevent the compiler to optimize the loop
out or some reason like that. Hopefully, it will work even without that
on all architectures with all compilers that are used for building perf...

I also think that the tests should be designed in a more robust way, so
that they aren't directly dependent on exact stack frames, e.g. let's look
at the "inet_pton" testcase...

The inet_pton test result check algorithm is designed to rely on exact
stacktrace, without a possibility to specify something like "we want this
and that in the stack trace, but otherwise, it does not matter which
wrappers are aroung". Then there must be the following code to adjust
the expected output exactly per architecture:

    echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
    echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
    case "$(uname -m)" in
      s390x)
        eventattr='call-graph=dwarf,max-stack=4'
        echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
        echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
      ;;
      ppc64|ppc64le)
        eventattr='max-stack=4'
        echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
        echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
        echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
      ;;
      *)
        eventattr='max-stack=3'
        echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
      ;;
    esac

Of course, since it relies on libc version, then we need patches, such as
    1f85d016768f ("perf test record+probe_libc_inet_pton: Fix call chain match on x86_64")
    311693ce81c9 ("perf test record+probe_libc_inet_pton: Fix call chain match on s390")
    fb710ddee75f ("perf test record_probe_libc_inet_pton: Fix test on s/390 where 'text_to_binary_address' now appears on the backtrace")
    ...
which break the test when used with older libc...

I think that a better design of such test is either probing some program
of ourselves that has predictable and stable function call sequence or
be more robust in checking the stack trace.

Thoughts?

Michael

> 
> Fixes: 1962ab6f6e0b ("perf test workload thloop: Make count increments atomic")
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>  tools/perf/tests/workloads/thloop.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index af05269c2eb8..457b29f91c3e 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -7,7 +7,6 @@
>  #include "../tests.h"
>  
>  static volatile sig_atomic_t done;
> -static volatile unsigned count;
>  
>  /* We want to check this symbol in perf report */
>  noinline void test_loop(void);
> @@ -19,8 +18,7 @@ static void sighandler(int sig __maybe_unused)
>  
>  noinline void test_loop(void)
>  {
> -	while (!done)
> -		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
> +	while (!done);
>  }
>  
>  static void *thfunc(void *arg)
> -- 
> 2.42.0
> 
> 
> 

