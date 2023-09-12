Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2E79D987
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbjILT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjILT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:26:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5218D;
        Tue, 12 Sep 2023 12:26:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE84C433C7;
        Tue, 12 Sep 2023 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546808;
        bh=VKmYlBUpT/bsf1QKh+D267MgH+5GNHBssL6sD/Ma3Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHOBkBbSNmOqERjudtzSv/JeaolTlSARYp8FJBxijm+lV2WsBYmAVdLEAUeDdh9MW
         L8B4BZ/k6gYBbs8lBKUpuMFlVZ+af5a4BpoYgz0SDdKJoO0LFhGveOEE9/PoLPZlsh
         FRSwoQTg63vDWylJ1ifvXqi8njDsu+WcecfH30yNpP+B6BiwzlANAUZAVM4cFFd+2+
         u2aSA9FyhjffhisEfbGuChfzor8dOrwv0QaOOiJpjmiyqtZx/yn3vVNPkSaW8noA5h
         yhzSKqjsJZ7h5m2i+taMPdWXCt+bL/zaiHzJZPBLuTALgrZCC9Ufeod9mFp1TmMaI9
         z6p3w6xfUJrzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38587403F4; Tue, 12 Sep 2023 16:26:45 -0300 (-03)
Date:   Tue, 12 Sep 2023 16:26:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/7] perf pmu: Move pmu__find_core_pmu() to pmus.c
Message-ID: <ZQC7da2AM9ih8RMz@kernel.org>
References: <20230831151632.124985-1-james.clark@arm.com>
 <20230831151632.124985-6-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831151632.124985-6-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 31, 2023 at 04:16:16PM +0100, James Clark escreveu:
> pmu__find_core_pmu() more logically belongs in pmus.c because it
> iterates over all PMUs, so move it to pmus.c
> 
> At the same time rename it to perf_pmus__find_core_pmu() to match the
> naming convention in this file.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

So, this one is hitting this:

  CC      /tmp/build/perf-tools-next/util/expr.o
In file included from /var/home/acme/git/perf-tools-next/tools/include/linux/list.h:7,
                 from util/pmus.c:2:
In function ‘perf_pmus__scan_core’,
    inlined from ‘perf_pmus__find_core_pmu’ at util/pmus.c:601:16:
/var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:36:45: error: array subscript 0 is outside array bounds of ‘struct list_head[1]’ [-Werror=array-bounds]
   36 |         const typeof(((type *)0)->member) * __mptr = (ptr);     \
      |                                             ^~~~~~
/var/home/acme/git/perf-tools-next/tools/include/linux/list.h:352:9: note: in expansion of macro ‘container_of’
  352 |         container_of(ptr, type, member)
      |         ^~~~~~~~~~~~
/var/home/acme/git/perf-tools-next/tools/include/linux/list.h:404:9: note: in expansion of macro ‘list_entry’
  404 |         list_entry((pos)->member.next, typeof(*(pos)), member)
      |         ^~~~~~~~~~
/var/home/acme/git/perf-tools-next/tools/include/linux/list.h:494:20: note: in expansion of macro ‘list_next_entry’
  494 |         for (pos = list_next_entry(pos, member);                        \
      |                    ^~~~~~~~~~~~~~~
util/pmus.c:274:9: note: in expansion of macro ‘list_for_each_entry_continue’
  274 |         list_for_each_entry_continue(pmu, &core_pmus, list)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/pmus.c: In function ‘perf_pmus__find_core_pmu’:
util/pmus.c:35:18: note: at offset -128 into object ‘core_pmus’ of size 16
   35 | static LIST_HEAD(core_pmus);
      |                  ^~~~~~~~~
/var/home/acme/git/perf-tools-next/tools/include/linux/list.h:23:26: note: in definition of macro ‘LIST_HEAD’
   23 |         struct list_head name = LIST_HEAD_INIT(name)
      |                          ^~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/pmus.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools-next/ui/browsers/perf-in.o


So I applied up to 4/7

Please continue from what will be in tmp.perf-tools-next in some
jiffies.

- Arnaldo
