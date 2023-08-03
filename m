Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5076E3AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHCIyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHCIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:54:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BEE43;
        Thu,  3 Aug 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G3dKS3PiyfTeGk+/L0aBzxktIOdUDrPMrl0WarMpWQQ=; b=Ia1vVio9qPQGTgm9A1rXOwAQvs
        JdHxuflT57Mix99Tv3LruwRbE1jHPxlrI8ly2lXKqTgSNyxtnpLW4OPMI/YrbOz4lRyygGp0OCzCf
        nuvOxZTE9hDXtjw/ML1v6wXGIlLP1/7jjMj/mPPR1iRNP3JhRfd/AlVuev525ENSTuBpoLUZND7cW
        5PGXEbXG51yAdInstMTyFNCb01j+rWx7jEZsVrUTO7j1cwIKfeFS9yEvnnPGZY8yn/9FMlzve1fc4
        dEcYOYqlRu3pr6SYW2qyA59vDs0RnkWYDBFHumuwSO5Gt7Z1yc/MTJt8hLJPUwWYcUGypRkIUW6St
        GEDPh6jw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRU5X-00GgiW-2u;
        Thu, 03 Aug 2023 08:53:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59B6F30007E;
        Thu,  3 Aug 2023 10:53:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38DA5202F3A1A; Thu,  3 Aug 2023 10:53:42 +0200 (CEST)
Date:   Thu, 3 Aug 2023 10:53:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch
 event struct
Message-ID: <20230803085342.GG212435@hirez.programming.kicks-ass.net>
References: <20230803083352.1585-1-zegao@tencent.com>
 <20230803083352.1585-4-zegao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803083352.1585-4-zegao@tencent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:33:50AM -0400, Ze Gao wrote:
> Report prioritiy and prev_state in 'short' to save some buffer
> space. And also reorder the fields so that we take struct
> alignment into consideration to make the record compact.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Ze Gao <zegao@tencent.com>

I am really getting fed up with this. This again doesn't list any
reasons on why this is a sane thing to do.

Please review past discussions and collate the various things mentioned
into this Changelog.
