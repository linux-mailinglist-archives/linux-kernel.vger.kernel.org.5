Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC287849CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjHVS6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjHVS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:58:16 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53653CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:58:15 -0700 (PDT)
Date:   Tue, 22 Aug 2023 20:58:09 +0200
From:   Guilherme Amadio <amadio@gentoo.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, amadio@ghostprotocols.net,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf tools: Options being passed to clang when building the BPF
 part of skels
Message-ID: <ZOUFQc-IIw3kbHsY@gentoo.org>
References: <ZOSrDGujou8WwS5r@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOSrDGujou8WwS5r@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Aug 22, 2023 at 09:33:16AM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	On gentoo I'm noticing this:
> 
> clang-16clang-16: : clang-16error: : error: clang-16clang-16: clang-16clang-16clang-16: clang-16error: clang-16: : ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]: : : clang-16error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]error: error: : 
> error: 
> error: error: error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]
> 
> ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]
> 
> ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]
> 
> And while just doing:
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a5dd1ba..7726b57 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1101,7 +1101,7 @@ else
>  endif
>  
>  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
> -	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> +	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror -Wno-option-ignored $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>  	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
>  
>  $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
> 
> 
> "Fixes" it, I'm curious as where is that we're setting up the options
> that are being passed to clang at:
> 
> tools/perf/Makefile.perf
> 
> $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
>         $(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>           -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> 
> Perhaps it is plain just using CFLAGS? I.e. maybe the native build
> CFLAGS is being passed to the BPF target clang calls?
> 
> Ideas?

In the patches I sent previously, I had a commit to address this. In
summary, the extra flags you see are hardening flags added by default.
Have also a look at /usr/include/gentoo/fortify.h. I suppose other 
distributions may add such flags as well. It's a pity the hardening
flags are added indiscriminately to all target architectures, but just
making the compiler not error out should be enough to work around the
issue. In my patch, I put -Werror under the control of the WERROR build
option and disabled it when configuring perf in the ebuild. Since other
warnings may be triggered in the future, having an easy way to disable
-Werror when building the package would be nice to have, otherwise when
a new compiler comes out users may hit build failures, since we are a
source based distribution.

Best regards,
-Guilherme



