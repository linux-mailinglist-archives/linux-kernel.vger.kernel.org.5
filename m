Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AAC7F45DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjKVMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344019AbjKVMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:22:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD62D47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:20:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137CFC433C9;
        Wed, 22 Nov 2023 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700655640;
        bh=shRm6TT5lP3owC5SoqOCvq7GBAZYeAO4PDux6pprpqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IscDCzdRfv6pkcajcRW/OztWdnR8DCPOWxJvzBcXZTjXNsGG6M/kZSt6TCgtlJpcN
         pYuJDz+849khGK/6ZaATVINws4d9zSt6BMCUff06swG2NKiFgkGyse4/PJbDnlF/Dg
         XymCNgPqTtSuKhtq8b+0uANvKzxC0PU46sROUEMameWEbHWOzieVEqeH97iXdFwAaQ
         HDc4c1yKeTzkH+qQwE4bYA2lEPKtYZbu934Ew3cgXKO1813NobMMUCNVlrU+B+MGQ6
         aj7bmW//DMkeYmPdDV6UsZqmZH9XUAa0PekdhkXP1d7VCZ+4ZB9BpBbfGTIAk2Pz/a
         ac/M0faJphr5g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D4EE40094; Wed, 22 Nov 2023 09:20:37 -0300 (-03)
Date:   Wed, 22 Nov 2023 09:20:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
Message-ID: <ZV3yFe7+wUNWwkVc@kernel.org>
References: <20231122022805.511839-1-irogers@google.com>
 <ZV3xe1qVCiz5bkLP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV3xe1qVCiz5bkLP@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 22, 2023 at 09:18:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 21, 2023 at 06:28:05PM -0800, Ian Rogers escreveu:
> > The necessary files for generating sysreg-defs.h need adding to the
> > perf tool MANIFEST that lists the files for packaging the perf tool
> > source code. Fix for the following:
> > 
> > ```
> > $ make perf-tar-src-pkg
> > $ tar xvf perf-6.7.0-rc2.tar
> > $ cd perf-6.7.0-rc2
> > $ make -C tools/perf

And I detected this while doing these tests on
perf-tools/tmp.perf-tools:

[acme@toolbox perf-tools]$ git log --oneline -1 ; time make -C tools/perf build-test
4dbc034e08146c48 (HEAD -> perf-tools) tools/perf: Update tools's copy of mips syscall table
make: Entering directory '/home/acme/git/perf-tools/tools/perf'
egrep: warning: egrep is obsolescent; using grep -E
- tarpkg: ./tests/perf-targz-src-pkg .
make[1]: *** [tests/make:348: tarpkg] Error 2
make: *** [Makefile:103: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools/tools/perf'

real	0m7.498s
user	0m12.059s
sys	0m5.491s
⬢[acme@toolbox perf-tools]$

> > Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Namhyung, I'm testing this together with your headers sync series + what
> is in perf-tools/tmp.perf-tools, will report results soon.
> 
> - Arnaldo
> 
> > ---
> > Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/MANIFEST | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
> > index 1da7f4b91b4f..dc42de1785ce 100644
> > --- a/tools/perf/MANIFEST
> > +++ b/tools/perf/MANIFEST
> > @@ -1,3 +1,5 @@
> > +arch/arm64/tools/gen-sysreg.awk
> > +arch/arm64/tools/sysreg
> >  tools/perf
> >  tools/arch
> >  tools/scripts
> > -- 
> > 2.43.0.rc1.413.gea7ed67945-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
