Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFE7790DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjHKNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHKNgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42475ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB4AF63165
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECDEC433C7;
        Fri, 11 Aug 2023 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691760981;
        bh=TndOhnijhe9cPJ5sc5ae3GLTNORQ4i9aL/8sGgxw9mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVNMsGTGsC/5B/Rl8M+0wrPn8aOCH+f6e6n4QKBN/kTNP+s5lbp9xLuURFG+TKx8M
         zotEFoCkQXTHeFO4pWbdmuMl1PIDIlDWUTMp5y7iaQ5aExBAHSLFhEkSVUr9wJGrLD
         BG3/kjlduPMxOJC+SoBE8zg0cQcXijQhDOZgrOvru9ZdZQZddKAINKI6cFZuuzCGhL
         EXZ5ra6diRknuirIRmEDtqC3x3vXI+YlD3ulyKhLrbwNuiiOcYyuQeybIGaVxg+bKQ
         Wc+Zux1s6wH8PVLD2g28HBLLXn8q3O8YtxDp4/8pc5llqb14mIrBJHlUzM2IrJAr1I
         DVjFBs77GtNaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62086404DF; Fri, 11 Aug 2023 10:36:18 -0300 (-03)
Date:   Fri, 11 Aug 2023 10:36:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build: Remove -Wno-unused-but-set-variable from
 the flex flags when building with clang < 13.0.0
Message-ID: <ZNY5Urywoz8trfEy@kernel.org>
References: <ZNUSWr52jUnVaaa/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUSWr52jUnVaaa/@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 10, 2023 at 01:37:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
> it to avoid:
> 
>   error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>   make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
>   make[4]: *** Waiting for unfinished jobs....
> 
> Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Need to do that also for the flex flags:

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index a9051ab2d52ac926..9699e31ff4c04925 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -302,11 +302,6 @@ else
   flex_flags := -w
 endif
 
-CFLAGS_parse-events-flex.o  += $(flex_flags)
-CFLAGS_pmu-flex.o           += $(flex_flags)
-CFLAGS_expr-flex.o          += $(flex_flags)
-CFLAGS_bpf-filter-flex.o    += $(flex_flags)
-
 # Some newer clang and gcc version complain about this
 # util/parse-events-bison.c:1317:9: error: variable 'parse_events_nerrs' set but not used [-Werror,-Wunused-but-set-variable]
 #  int yynerrs = 0;
@@ -318,6 +313,7 @@ ifeq ($(CC_NO_CLANG), 0)
   CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
   ifeq ($(call version-lt3,$(CLANG_VERSION),13.0.0),1)
     bison_flags := $(subst -Wno-unused-but-set-variable,,$(bison_flags))
+    flex_flags := $(subst -Wno-unused-but-set-variable,,$(flex_flags))
   endif
 endif
 
@@ -333,6 +329,11 @@ ifeq ($(BISON_LT_381),1)
   bison_flags += -DYYNOMEM=YYABORT
 endif
 
+CFLAGS_parse-events-flex.o  += $(flex_flags)
+CFLAGS_pmu-flex.o           += $(flex_flags)
+CFLAGS_expr-flex.o          += $(flex_flags)
+CFLAGS_bpf-filter-flex.o    += $(flex_flags)
+
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)

> ---
>  tools/perf/util/Build | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index d487aec0b458a0d9..a9051ab2d52ac926 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -1,3 +1,4 @@
> +include $(srctree)/tools/scripts/Makefile.include
>  include $(srctree)/tools/scripts/utilities.mak
>  
>  perf-y += arm64-frame-pointer-unwind-support.o
> @@ -311,6 +312,15 @@ CFLAGS_bpf-filter-flex.o    += $(flex_flags)
>  #  int yynerrs = 0;
>  
>  bison_flags := -DYYENABLE_NLS=0 -Wno-unused-but-set-variable
> +
> +# Old clangs don't grok -Wno-unused-but-set-variable, remove it
> +ifeq ($(CC_NO_CLANG), 0)
> +  CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
> +  ifeq ($(call version-lt3,$(CLANG_VERSION),13.0.0),1)
> +    bison_flags := $(subst -Wno-unused-but-set-variable,,$(bison_flags))
> +  endif
> +endif
> +
>  BISON_GE_382 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 382)
>  ifeq ($(BISON_GE_382),1)
>    bison_flags += -Wno-switch-enum
> -- 
> 2.37.1
> 

-- 

- Arnaldo
