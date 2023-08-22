Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3D784AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjHVTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHVTnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202FE10F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B286362E74
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7489C433C8;
        Tue, 22 Aug 2023 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692733396;
        bh=DUuG0P0MSkK9+4aNXYx5VuJ6d8t1sM3PXwUrQ9yjyqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DaD5nV08LW6J+ijTq93X4/pS1reqnxpUfCDl8A4BbCqgErd5X56tVpwHhNxKnlQqP
         j01bKJceoY1pc35BtG8ddDP2+fmHgOz/IJzElpq/p1oji/sT0JC0H/KV/vwEpHS/aC
         06EDC/3ZsFit9RiC7efZrgRsJ6yMq5rCs/RwMqueLWUhWCUo5p7S0QTfvH26re0ePs
         BA6kW1uZVZRKo6Ty+XQKdz/xNXu11pLCbscohIbZ95jGW/a+XGmLAbgIz3VJfeZSX7
         0Kn0HSSq53z1tn6Hb2CIhOhanuGNStFQnc5NvQTFbSUWybBo1SAhFC8o9i9+JlYwJw
         C2uvGJpbkAZxg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5291640722; Tue, 22 Aug 2023 16:43:13 -0300 (-03)
Date:   Tue, 22 Aug 2023 16:43:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Guilherme Amadio <amadio@gentoo.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf tools: Options being passed to clang when building the BPF
 part of skels
Message-ID: <ZOUP0fyC3B5tuVp2@kernel.org>
References: <ZOSrDGujou8WwS5r@kernel.org>
 <ZOUFQc-IIw3kbHsY@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOUFQc-IIw3kbHsY@gentoo.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 22, 2023 at 08:58:09PM +0200, Guilherme Amadio escreveu:
> On Tue, Aug 22, 2023 at 09:33:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > 	On gentoo I'm noticing this:

> > clang-16clang-16: : clang-16error: : error: clang-16clang-16: clang-16clang-16clang-16: clang-16error: clang-16: : ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]: : : clang-16error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]error: error: : 
> > error: 
> > error: error: error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]
> > 
> > ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]

> > ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]

> > And while just doing:
> > 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a5dd1ba..7726b57 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1101,7 +1101,7 @@ else
> >  endif

> >  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
> > -	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> > +	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror -Wno-option-ignored $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> >  	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@

> >  $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)

> > "Fixes" it, I'm curious as where is that we're setting up the options
> > that are being passed to clang at:

> > tools/perf/Makefile.perf

> > $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
> >         $(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> >           -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@

> > Perhaps it is plain just using CFLAGS? I.e. maybe the native build
> > CFLAGS is being passed to the BPF target clang calls?

> > Ideas?

> In the patches I sent previously, I had a commit to address this. In

I tried the one that introduced CLANG_OPTIONS and checked WERROR= to set
Werror, read more further down this message.

I think we need to have it but for this problem I want to have finer
grained control on what goes into the CFLAGS for CLANG _when building
BPF bytecode_.

> summary, the extra flags you see are hardening flags added by default.
> Have also a look at /usr/include/gentoo/fortify.h. I suppose other 

> distributions may add such flags as well. It's a pity the hardening
> flags are added indiscriminately to all target architectures, but just

Oh, I see, so we need to overcome that in the perf Makefiles by
_removing_ those unsupported options for the BPF target, something like
what is done in tools/perf/util/setup.py, because some of the options
may not be supported for one version of clang but be supported in a
newer one :-\

> making the compiler not error out should be enough to work around the
> issue. In my patch, I put -Werror under the control of the WERROR build
> option and disabled it when configuring perf in the ebuild. Since other

Right, so it is the one I saw.

> warnings may be triggered in the future, having an easy way to disable
> -Werror when building the package would be nice to have, otherwise when

Right, I'll apply that patch, I tested it, it just didn't some the
problem at hand, i.e. after applying it one has to use WERROR=0.

- Arnaldo

> a new compiler comes out users may hit build failures, since we are a
> source based distribution.
> 
> Best regards,
> -Guilherme
