Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8307F6083
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbjKWNkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345589AbjKWNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:40:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D510EC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:40:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BDDC433C8;
        Thu, 23 Nov 2023 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700746829;
        bh=4/3MFKcSnNzFxXpwdTahwPqZj1DbgJoJ7bLgc5su8HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0pEvxvwR7cPb6GEgqdMm3JUCtR3QEhvZZ62nN9kkwaFO0hoPEXeWh8O11XgxoUXC
         LJNFXhV9g13IanBMELMe/9XENgNAYOkf/gWR1HCpN6yrW7QL0qAo0ytrJJnE+3JkLj
         w2eO3eN4zLXCIT2HqPaYW+bGLkIgnyuCE6npWxS1d9iI5vAJkhoNDKZynfeejpoD7q
         Am+/UYj9YEZiT6qesCZ+GSmA6/HAi8R8J+qKzYVodPag6MDfd/n5+nniihQ+jxWSPo
         s69Llhy++rs+NdjnVyLssmEltR1eJ+tKpzf3MsiqCqFdIGArRRxhtle6MNXv0LFovx
         y30es4PLZDpXg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EDCD940094; Thu, 23 Nov 2023 10:40:25 -0300 (-03)
Date:   Thu, 23 Nov 2023 10:40:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 18/52] perf report: Add 'type' sort key
Message-ID: <ZV9WSdshxv9MZTb0@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-19-namhyung@kernel.org>
 <ZVzvFen/214ylf32@kernel.org>
 <CAM9d7cijprv2fOM_jwYbrV0jbhno2ZQDCT3SExG=Ot=b2mANmw@mail.gmail.com>
 <ZV5cZe8dxv/GzdGa@kernel.org>
 <CAM9d7ci+rgyGmLmosNpA4Bk1u8sfwYCLVwN4grky5y4g2Weu3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ci+rgyGmLmosNpA4Bk1u8sfwYCLVwN4grky5y4g2Weu3g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 22, 2023 at 01:13:04PM -0800, Namhyung Kim escreveu:
> On Wed, Nov 22, 2023 at 11:54 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, Nov 22, 2023 at 10:49:13AM -0800, Namhyung Kim escreveu:
> > > On Tue, Nov 21, 2023 at 9:55 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > ⬢[acme@toolbox perf-tools-next]$ perf report -s type
> > > > perf: Segmentation fault

> > > Right, the 'type' sort key was added here but unfortunately
> > > it's not ready for prime time yet.  It also needs the next patch
> > > 19/52 ("perf report: Support data type profiling") to fully enable
> > > the feature.  Do you think it's better to squash into here?

> > I haven't checked if squashing would be a good idea, but if you think
> > its the right granularity, then do it, as long as we can test features
> > in various ways as they are getting added, as I did, using a random
> > perf.data file.
 
> I still think it's better to split the change as it's logically separate.

The smaller the patches, the better, I'd say in general.

> But it's prematurely exposed then maybe needs some protection.

Yeah, that is what I felt like it needed, make it more robust by
checking if the used fields were properly initialized, etc.

- Arnaldo
