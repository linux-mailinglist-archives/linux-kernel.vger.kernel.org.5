Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660DC766F08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjG1OJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1OJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BB35A8;
        Fri, 28 Jul 2023 07:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477326214B;
        Fri, 28 Jul 2023 14:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCC2C433C8;
        Fri, 28 Jul 2023 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690553374;
        bh=KLjExLhXnoctgt1F9lPT4E5ymQFk/shVtkceDCu/DEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1etBMMWEBHJC08coP28YOQwC8VVdJesVcfvy18HnTq4G3U1ROuBFX3sNmyhnlKTl
         wzoA/DYjJ9eVCXjIoEXKzN04peXut9x/9jSSA7B5xCwZsMzPTHo90weaB40QoBvyld
         uQk112OiQI6MIxJprD1k1RhOn5ktNfrkPrD8vBnsS3PjIaVFvXg9U+vWyl4e81df8f
         flm6vvxxn/AdxotNwvTgG3a4NQ9YzWxOBMIojxnRRBZOG+Vez+N0ASvKC0jf5k5S3U
         u28l5ip/GchiYuL7gT1qqst1buMHlNuF6xlr1ijT4wdC3CrUJvKzQob07kx4kyawIR
         MHlq42gPSy/bA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37CD740096; Fri, 28 Jul 2023 11:09:32 -0300 (-03)
Date:   Fri, 28 Jul 2023 11:09:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf build: Update build rule for generated files
Message-ID: <ZMPMHNjX2IxsLbAe@kernel.org>
References: <20230728022447.1323563-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728022447.1323563-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 27, 2023 at 07:24:46PM -0700, Namhyung Kim escreveu:
> The bison and flex generate C files from the source (.y and .l)
> files.  When O= option is used, they are saved in a separate directory
> but the default build rule assumes the .C files are in the source
> directory.  So it might read invalid file if there are generated files
> from an old version.  The same is true for the pmu-events files.
> 
> For example, the following command would cause a build failure:
> 
>   $ git checkout v6.3
>   $ make -C tools/perf  # build in the same directory
> 
>   $ git checkout v6.5-rc2
>   $ mkdir build  # create a build directory
>   $ make -C tools/perf O=build  # build in a different directory but it
>                                 # refers files in the source directory
> 
> Let's update the build rule to specify those cases explicitly to depend
> on the files in the output directory.
> 
> Note that it's not a complete fix and it needs the next patch for the
> include path too.

Applied, testing it on the container builds.

- Arnaldo
 
> Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/Makefile.build  | 10 ++++++++++
>  tools/perf/pmu-events/Build |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 89430338a3d9..fac42486a8cf 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -117,6 +117,16 @@ $(OUTPUT)%.s: %.c FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_s_c)
>  
> +# bison and flex files are generated in the OUTPUT directory
> +# so it needs a separate rule to depend on them properly
> +$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,$(host)cc_o_c)
> +
> +$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,$(host)cc_o_c)
> +
>  # Gather build data:
>  #   obj-y        - list of build objects
>  #   subdir-y     - list of directories to nest
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 150765f2baee..1d18bb89402e 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -35,3 +35,9 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
>  endif
> +
> +# pmu-events.c file is generated in the OUTPUT directory so it needs a
> +# separate rule to depend on it properly
> +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,cc_o_c)
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 

-- 

- Arnaldo
