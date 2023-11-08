Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512757E5F41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjKHUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:35:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8C1B5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:35:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4BAC433C7;
        Wed,  8 Nov 2023 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699475756;
        bh=+CD9AbZ4jMDm7Yo89gDkeadsLWWywpjmbOxL3BWffsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgWJ1Wy7TmTzDHZvGEdo/A0OqXy47Z22cx8/cgq/yDYWe/gTp85l/Z5RmMaCLRRjA
         ZtGNv91i5paaMsZ5+Z2x75WMDGcpp+lDeiUIo7mhLVelGcqcSPnCBbhFRfSfqe0pkn
         /M38p0VkMiVCXeJfngodaUAjsSD4md2mFLwOX+AbsQxfblWgnDlmsLQX3QCa+gdklJ
         KLIRd86/7f7/hkKtop1clJZyc1FvKUfu3vSnSHu3BAXoEObfgXB7agXePAfuEBCx3M
         KBOf3pj7YEU1yR1znAGJrjFuSbgGnObW52T8chi3+iOi+FRGDLQJkmkyYZYi+MYwqu
         neNC7Zh+a9IiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C32914035D; Wed,  8 Nov 2023 17:35:53 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:35:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf build: Add loading python binding check to
 python.so build
Message-ID: <ZUvxKXu4+KZeE8pX@kernel.org>
References: <20231030111438.1357962-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030111438.1357962-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 30, 2023 at 11:14:37AM +0000, Yang Jihong escreveu:
> Add loading python binding check to python.so build so that problem can be
> detected in advance in the build phase instead of being left to `perf test`
> phase.
> 
> In normal scenarios, the original build is not affected:
> 
>   $ cd tools/perf
>   $ rm -rf /tmp/perf; mkdir /tmp/perf; make O=/tmp/perf
>   $ echo $?
>   0
>   $ cd /tmp/perf
>   $ ./perf test python
>    19: 'import perf' in python                    : Ok
> 
> Create an error scenario, for example, delete util/rlimit.c from
> util/python-ext-sources:

This will make _all_ perf builds incur the cost of this :-\

I do it with an alias because I notice it is unfortunately common for
people to send pull requests without running 'perf test' before, but
with this in place the 'make -C tools/perf build' will be made slower
for no reason :-\

I picked the second patch, thanks.

- Arnaldo
 
>   $ cd tools/perf
>   $ sed -i 's@util/rlimit.c@#util/rlimit.c@g' util/python-ext-sources
>   $ grep rlimit util/python-ext-sources
>   #util/rlimit.c
>   $ rm -rf /tmp/perf; mkdir /tmp/perf; make JOBS=1 O=/tmp/perf
>   <SNIP>
>     GEN     /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so
>   Error: Load python binding failed. See /tmp/perf/python_ext_build/lib//build.log for more details
>   make[2]: *** [Makefile.perf:644: /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so] Error 1
>   make[1]: *** [Makefile.perf:242: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>   $ cat /tmp/perf/python_ext_build/lib//build.log
>   Traceback (most recent call last):
>     File "<string>", line 1, in <module>
>   ImportError: /tmp/perf/python_ext_build/lib/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/Makefile.perf | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d80dcaa5a1e3..a2449c4890ad 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -645,7 +645,13 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_
>          CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  --quiet build_ext; \
> -	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> +	$(PYTHON_WORD) -c 'import sys; sys.path.insert(0, "$(PYTHON_EXTBUILD_LIB)"); import perf' 2>$(PYTHON_EXTBUILD_LIB)/build.log; \
> +	if [ $$? -ne 0 ]; then \
> +		echo "Error: Load python binding failed. See $(PYTHON_EXTBUILD_LIB)/build.log for more details"; \
> +		exit 1; \
> +	else \
> +		cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> +	fi
>  
>  python_perf_target:
>  	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
> -- 
> 2.34.1
> 

-- 

- Arnaldo
