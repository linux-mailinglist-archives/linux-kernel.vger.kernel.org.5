Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411717D8926
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjJZTra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:47:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8B1B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:47:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC2BC433C8;
        Thu, 26 Oct 2023 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698349646;
        bh=MwQPMIMfLju9W8L1OJ77trHSmgP8n3dFt7oafLKIjcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f79Ub/QXHvbOpsyTgVsPLPEgk02zke2reNzB4gPQt5q6pa0UfY43C0nd0arO7R3LG
         hLBQmH6xxGvLomWF+pog7DJlmdJPM5iGxBUXxUB13TofYU9s4eK12b2MBD/OBBevXH
         BnKpTBhJa6rHfYYkqMFYfxRFgwnGOlz7Dg70dxNYrVdNJR8pz4qQdz+x5+gankkzDQ
         9dMza4OxnIb86ls0kqc4o40M8ybupA/0Fn96xyLZ1ex0zWU5ggJwUPaku8gzZ0oUxG
         6JWJtMLD9OgL9ihX3ZhTlo1UFLGbp4WMd9u35XcZEFGqaOu7iallY3WGUO7zh6N72S
         oc8UA6sXGE8/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA3064035D; Thu, 26 Oct 2023 16:47:23 -0300 (-03)
Date:   Thu, 26 Oct 2023 16:47:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to
 rlimit__increase_nofile
Message-ID: <ZTrCS5Z3PZAmfPdV@kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023033144.1011896-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 23, 2023 at 03:31:44AM +0000, Yang Jihong escreveu:
> evsel__increase_rlimit() helper does nothing with evsel, and description
> of the functionality is inaccurate, rename it and move to util/rlimit.c.
 
> By the way, fix a checkppatch warning about misplaced license tag:
 
>   WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>   #160: FILE: tools/perf/util/rlimit.h:3:
>   /* SPDX-License-Identifier: LGPL-2.1 */
 
> No functional change.

Please run 'perf test' before sending patches upstream, I'm checking if
what is in perf-tools-next/perf-tools-next is building and I noticed
this:

⬢[acme@toolbox perf-tools-next]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 14: 'import perf' in python                                         :
--- start ---
test child forked, pid 2912462
python usage test: "echo "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
test child finished with -1
---- end ----
'import perf' in python: FAILED!
⬢[acme@toolbox perf-tools-next]$

The following patch cures it, Namhyung, can you please fold it and force
push perf-tools-next/perf-tools-next or let me know if you prefer that I
submit a patch fixing this separately.

- Arnaldo

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 26e1c8d973ea0b95..593b660ec75e24e1 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -40,6 +40,7 @@ util/rwsem.c
 util/hashmap.c
 util/perf_regs.c
 util/fncache.c
+util/rlimit.c
 util/perf-regs-arch/perf_regs_aarch64.c
 util/perf-regs-arch/perf_regs_arm.c
 util/perf-regs-arch/perf_regs_csky.c
