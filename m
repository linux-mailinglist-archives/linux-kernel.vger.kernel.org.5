Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99F77FF802
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbjK3RRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjK3RRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:17:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19BE1993
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:17:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE85C433C7;
        Thu, 30 Nov 2023 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701364654;
        bh=ov/IfYsQplFcmSodemtHJLL3XrICMOvduLqoUc5oKMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1Tdc1Co+ALyIJcaK0n5iLj9dtr3U4+7LMseLqWxHJrzFLYBMZdyFto7Hmh8fxgBf
         tp1m9x0GX4CjL6ffboSceynAn25RSEbvYf+E1B0WPQ0OF8keoKmr0sRd289lmcEfac
         xQEwrD/gzhS6xTs4+VAek+JXsA6lWku3It8r/p0J73d8mLzCmJX6KKFpZTx34EkfvB
         on+SkCGKBudNboM42YQj74+9OZE4CukTQO5BIg5I2Kf6D+JKGM5UY9mPbDZdiSoV0Z
         iT7nXMDoK9K+JMELInXtjfk7227phdAeaBPvXGagjljcFXldgpHErKMDqrocd42Fdb
         eDiLXQgb5zPlw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DC2840094; Thu, 30 Nov 2023 14:17:31 -0300 (-03)
Date:   Thu, 30 Nov 2023 14:17:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v5 02/50] libperf: Lazily allocate/size mmap event copy
Message-ID: <ZWjDq/CayuP6XtvW@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-3-irogers@google.com>
 <ZWiK/9JJjOElTTq7@kernel.org>
 <ZWiaB+ygpN+46JAm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWiaB+ygpN+46JAm@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 30, 2023 at 11:19:51AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 30, 2023 at 10:15:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Nov 27, 2023 at 02:08:14PM -0800, Ian Rogers escreveu:
> > >  void perf_mmap__munmap(struct perf_mmap *map)
> > >  {
> > > -	if (map && map->base != NULL) {
> > > +	if (!map)
> > > +		return;
> > > +
> > > +	free(map->event_copy);
> > > +	map->event_copy = NULL;
> > 
> > I´m converting this to:
> > 
> > 	zfree(&map->event_copy);
> > 
> > Hopefully we'll find some tool to flag these before submitting patches,
> > does clang-tidy do these kinds of things?
> > 
> > Also, applied:
> > 
> >  b4 am -P2,4-7 -ctsl --cc-trailers 20231127220902.1315692-1-irogers@google.com
> > 
> > The ones that Namhyung acked and that applied cleanly in order.
> > 
> > The first one, as Namhyung noted, is already merged.
> 
> I'll fix this later:
> 
> [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.5/perf/perf-6.6.0-rc1.tar.xz
> [perfbuilder@five ~]$ time dm
>    1    16.97 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-20) (GCC)
>     In file included from fs/fs.c:19:
>     fs/../io.h:94:46: error: unknown type name '__u64'
>      static inline int io__get_hex(struct io *io, __u64 *hex)

Added the following patch to just before your patches.

https://lore.kernel.org/all/ZWjDPL+IzPPsuC3X@kernel.org/T/#u

tldr; missing linux/types.h for __u64 in api/io.h.

- Arnaldo
