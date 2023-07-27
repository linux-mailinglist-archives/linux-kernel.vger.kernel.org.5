Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125F7655A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjG0ONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjG0ONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155C2682
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 818E561E8A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B29C433C7;
        Thu, 27 Jul 2023 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690467194;
        bh=/o7KIWnvlUjtTt9p21Ded+WRgEfi2pgmoiqanzTo+Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwgnQP2vkt9HnJxpxFBVk8HwIX61Sl8WLMvRvxiTe3T6LdD4SNKSfkhII7Z+R/Cd8
         a7lpMeLlCIq+UFZDASEIvK8tuTtW307JjPeDJK2TcbOv0d2YyZvQScAcDRVvMvjGtu
         YoLTU8hiOHGa34rwulW0skAwY2JgPrOsIysMhbKwt5E1+e7sNnqWGfQs3nu27bBWa7
         ZjPOEkIUC10c66WRPbESxhew/k6M32VLgXlBuOxQitFtkGURLYiiosMKlHEwauY2BC
         YSDrKMXL8p//XksC54aX4AjcWKLYgVApNh41PZBJunDUmvdv/Hy2qIs5g0TRtjSSgj
         g0HJqocrt1gmA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACC6840516; Thu, 27 Jul 2023 11:13:11 -0300 (-03)
Date:   Thu, 27 Jul 2023 11:13:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
Message-ID: <ZMJ7d7BUeva82rMm@kernel.org>
References: <ZL7ocEWxjRtWR80T@kernel.org>
 <CAP-5=fVy8cYrYH5EmdrJo0+q0CHj=chTxWYkieLi6LwTSjFCAQ@mail.gmail.com>
 <ZL7tv45K3zKqkHhZ@kernel.org>
 <d81c192a-49e1-b02a-b6e7-6c44927f041d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d81c192a-49e1-b02a-b6e7-6c44927f041d@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 25, 2023 at 02:51:58PM +0300, Adrian Hunter escreveu:
> On 25/07/23 00:31, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jul 24, 2023 at 02:16:05PM -0700, Ian Rogers escreveu:
> >> On Mon, Jul 24, 2023 at 2:09 PM Arnaldo Carvalho de Melo
> >> <acme@kernel.org> wrote:
> >>>
> >>> As thread__find_symbol_fb() will end up calling thread__find_map() and
> >>> it in turn will call these on uninitialized memory:
> >>>
> >>>         maps__zput(al->maps);
> >>>         map__zput(al->map);
> >>>         thread__zput(al->thread);
> >>
> >> Normally there would be a addr_location__exit. It looks here like most
> >> values are copied in al_to_d_al, which copies reference counted values
> >> without doing appropriate gets. Perhaps add the gets in al_to_d_al and
> >> add the exit to make it clear there can't be addr_location related
> >> leaks here.

Or just make al_to_d_al use strdups for the strings it gets from
reference counter structs.

That or make the caller of ->resolve_address() provide a initialized
addr_location that it then exits.

- Arnaldo

> > I'll do that as well and add the addr_location__exit() then send a V2.
> 
> The data is not valid outside the context of ->filter_event() or
> ->filter_event_early(), so the reference counts should not be changed.
> That probably needs to be made clearer in the documentation.


 
> > 
> > - Arnaldo
> >  
> >> Thanks,
> >> Ian
> >>
> >>> Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
> >>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >>> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> >>> Cc: Ian Rogers <irogers@google.com>
> >>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>> Cc: Kajol Jain <kjain@linux.ibm.com>
> >>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> >>> Cc: Namhyung Kim <namhyung@kernel.org>
> >>> Link: https://lore.kernel.org/lkml/
> >>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>> ---
> >>>  tools/perf/util/dlfilter.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> >>> index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
> >>> --- a/tools/perf/util/dlfilter.c
> >>> +++ b/tools/perf/util/dlfilter.c
> >>> @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
> >>>         if (!thread)
> >>>                 return -1;
> >>>
> >>> +       addr_location__init(&al);
> >>>         thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
> >>>
> >>>         al_to_d_al(&al, &d_al);
> >>> --
> >>> 2.37.1
> >>>
> > 
> 

-- 

- Arnaldo
