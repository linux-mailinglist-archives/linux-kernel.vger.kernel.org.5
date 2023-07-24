Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28A7600E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGXVJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGXVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04E1BC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8743961263
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898A0C433C8;
        Mon, 24 Jul 2023 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690232947;
        bh=AxIobRBY2/FxVQu3cP3nLe9fjgkFu7v5YoBCsJlOszA=;
        h=Date:From:To:Cc:Subject:From;
        b=lB3gRgm7k6xhfX0uIm09ccs+nQ1AtwJpE5kTUsJ6XdDBhD/h5y+Ij/aSdKb3Ca98Z
         HUa1JfJj3JRmG92ARdqtfiyAe4sXl38KfcmaGmgEono4jbUCxnbqidG3Z7JiMD5JN8
         QbsVOmHlgY/ZR8QjWpl0evV0A8Z+tVdZMUrdI5ixD7t/pF/KZePdrF3LtOTX+8EN0W
         qtdvyEaRgS4JPpTxx1HagP4g53+RguYhwfkl+3xgCzCsA4sVnTL1xJYghg5+uvHbeK
         8tplp6dqxc/1LbLCGg4CvnwdFZQcmspG/BUjRbZ7yDwwOUt/1L+BWLn+lv6fxKwGpb
         kG04dLc142h3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B203140516; Mon, 24 Jul 2023 18:09:04 -0300 (-03)
Date:   Mon, 24 Jul 2023 18:09:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf dlfilter: Initialize addr_location before passing
 it to thread__find_symbol_fb()
Message-ID: <ZL7ocEWxjRtWR80T@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As thread__find_symbol_fb() will end up calling thread__find_map() and
it in turn will call these on uninitialized memory:

        maps__zput(al->maps);
        map__zput(al->map);
        thread__zput(al->thread);

Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dlfilter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 	if (!thread)
 		return -1;
 
+	addr_location__init(&al);
 	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
 
 	al_to_d_al(&al, &d_al);
-- 
2.37.1

