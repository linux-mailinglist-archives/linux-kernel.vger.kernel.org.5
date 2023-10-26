Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F97D895C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjJZUCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZUCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:02:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF9129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:02:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1EAC433C8;
        Thu, 26 Oct 2023 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698350536;
        bh=czHelUu63Qcb/7CFa/wjzYwxegwjY0q96Bz6H8eb0JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erBoNsW49lYlb649aajpNOZEeJ/Sr0WUNyesTIT7wyEepaRzs1rHUVmCZ7qoPlEN4
         bpzW8wPu41MZjB/zi8ATP2rqUVPRq1FMrTlQycxX/oKpUpDIOj3R3xOTpvu00SJzGG
         fkshws07lnwdC6MLctArf/BJDDtoVLTU8ul+4IkfhhrF6HwwGw4Un+XYWXkgpysTQy
         ce2KXymv1YFCiCD/CsUVtZVvSQfo8+cnjlvgeFGT4i/yggbs0O3lW+jjuUFX5a9zWQ
         T30nzpK3fx1xSm8OMkQJDKge2ONkty1y+Oh7YtTogeSOcdLTrjtiZffRgfk/4lDzDr
         pibzmcC3trwiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A19EC4035D; Thu, 26 Oct 2023 17:02:13 -0300 (-03)
Date:   Thu, 26 Oct 2023 17:02:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add -H short option for --hierarchy
Message-ID: <ZTrFxazbxVx5G1N7@kernel.org>
References: <20231026062615.3096537-1-namhyung@kernel.org>
 <5a153604-3e9c-4ae9-b216-64f24199efc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a153604-3e9c-4ae9-b216-64f24199efc4@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 26, 2023 at 09:46:02AM +0300, Adrian Hunter escreveu:
> On 26/10/23 09:26, Namhyung Kim wrote:
> > I found the hierarchy mode useful, but it's easy to make a typo when
> > using it.  Let's add a short option for that.

> > Also update the documentation. :)

> Perhaps it would also be possible to support bash-completions for
> long options

It works:

  # . ~acme/git/linux/tools/perf/perf-completion.sh
  # perf top --hi<TAB>
  --hide_kernel_symbols  --hide_user_symbols    --hierarchy
  #

And:

perf top --hie<ENTER>

works as it is unambiguous (so far).

What we don't have is a way to use hierachy by default, i.e. we should
have:

perf config top.hierarchy=1

and then:

perf top

would always use the hierarchy view.

tools/perf/Documentation/perf-config.txt has the options that can be
set, like:

# perf report | head -15
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 373K of event 'cycles:P'
# Event count (approx.): 205365133495
#
# Overhead  Command          Shared Object                                     Symbol
# ........  ...............  .................    ...................................
#
     3.17%  MediaDe~hine #6  libc.so.6            [.] pthread_mutex_lock@@GLIBC_2.2.5
     2.31%  swapper          [kernel.vmlinux]     [k] psi_group_change
     1.87%  MediaSu~sor #10  libc.so.6            [.] pthread_mutex_lock@@GLIBC_2.2.5
     1.84%  MediaSu~isor #7  libc.so.6            [.] pthread_mutex_lock@@GLIBC_2.2.5
#

Then:

# perf config report.sort_order=dso
# perf report | head -15
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 373K of event 'cycles:P'
# Event count (approx.): 205365133495
#
# Overhead  Shared Object                                 
# ........  ..............................................
#
    59.52%  [kernel.vmlinux]                              
    19.79%  libc.so.6                                     
     8.07%  libxul.so                                     
     5.25%  libopenh264.so.2.3.1                          
#

# cat ~/.perfconfig
# this file is auto-generated.
[report]
	sort_order = dso
[root@five ~]# perf config report.sort_order
report.sort_order=dso
#

Right now 'perf top' has only:

static int perf_top_config(const char *var, const char *value, void *cb __maybe_unused)
{
        if (!strcmp(var, "top.call-graph")) {
                var = "call-graph.record-mode";
                return perf_default_config(var, value, cb);
        }
        if (!strcmp(var, "top.children")) {
                symbol_conf.cumulate_callchain = perf_config_bool(var, value);
                return 0;
        }

        return 0;
}

This would be similar to what was done for --no-children on:

https://git.kernel.org/torvalds/c/104ac991bd821773cba6f262f97a4a752ed76dd5

$ git show --pretty=full 104ac991bd821773cba6f262f97a4a752ed76dd5 | head -5
commit 104ac991bd821773cba6f262f97a4a752ed76dd5
Author: Namhyung Kim <namhyung@kernel.org>
Commit: Jiri Olsa <jolsa@kernel.org>

    perf top: Add top.children config option

- Arnaldo
