Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCD4760133
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjGXVbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGXVbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D604126
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3473A613FB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33180C433C8;
        Mon, 24 Jul 2023 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690234306;
        bh=oVrARm9sjHDyoZlQt1WFVM+lgYGoBKFl4n2gzx4SfKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAECDxhsLTsI9EsnIhD+XQ29fDK4m/pMwAHBPFG0s1wgK2EmhI78hJgqBMXOggcwp
         aHe2SSTGCUhRwLccl6EIt+xxnGPtq4ziTFPrXDMkQTi2aC85ph70f9X08P8Y+5m2Yl
         VLLrZCcpZZz8GIv9Ku7qdu1tLm2ROdZzoIumGEBCRCaN8QUhskh0TsDjbZ9jtvnCeq
         ONHYOqEQLQ65FnD99L8VSZqtQCSxlyqDN0TJyyP7ApVbb0alY0XKphASEHf6O6fEdv
         GFwapOtBVdjGLkp9xZ0uQMpZ0HoJHbmgMMaLutcK9eHL8MdixWmpKK31CClikHCE1p
         0ztVKhaO8iNDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0DD6540516; Mon, 24 Jul 2023 18:31:44 -0300 (-03)
Date:   Mon, 24 Jul 2023 18:31:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
Message-ID: <ZL7tv45K3zKqkHhZ@kernel.org>
References: <ZL7ocEWxjRtWR80T@kernel.org>
 <CAP-5=fVy8cYrYH5EmdrJo0+q0CHj=chTxWYkieLi6LwTSjFCAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVy8cYrYH5EmdrJo0+q0CHj=chTxWYkieLi6LwTSjFCAQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 24, 2023 at 02:16:05PM -0700, Ian Rogers escreveu:
> On Mon, Jul 24, 2023 at 2:09 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > As thread__find_symbol_fb() will end up calling thread__find_map() and
> > it in turn will call these on uninitialized memory:
> >
> >         maps__zput(al->maps);
> >         map__zput(al->map);
> >         thread__zput(al->thread);
> 
> Normally there would be a addr_location__exit. It looks here like most
> values are copied in al_to_d_al, which copies reference counted values
> without doing appropriate gets. Perhaps add the gets in al_to_d_al and
> add the exit to make it clear there can't be addr_location related
> leaks here.

I'll do that as well and add the addr_location__exit() then send a V2.

- Arnaldo
 
> Thanks,
> Ian
> 
> > Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kajol Jain <kjain@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/dlfilter.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> > index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
> > --- a/tools/perf/util/dlfilter.c
> > +++ b/tools/perf/util/dlfilter.c
> > @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
> >         if (!thread)
> >                 return -1;
> >
> > +       addr_location__init(&al);
> >         thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
> >
> >         al_to_d_al(&al, &d_al);
> > --
> > 2.37.1
> >

-- 

- Arnaldo
