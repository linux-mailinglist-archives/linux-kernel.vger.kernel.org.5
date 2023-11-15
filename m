Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8C7EBFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjKOJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:58:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B066C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+RCpZLfVgW742tIfwCQVho56eY7hoi5YwvR+26FGo80=; b=PrMsifeniNlJaEyoTxrdLqQcz6
        M29BkTSS6X8woYJD8DAOsgyttbZPG7BmcKwHS5gIsaOgYzEM81Iq99FDjoHLI1nSf3u/fi1PoM/am
        vWkM22rFJzpSLHWQydbnqzJyoTNcCzDrp10k6zgounCGxcZ5YYSieZyxiZbGwf8EXDJmsXYKpRP7J
        dMH5+nZ/1M+/gyFymTAzDgmtUe+L/6FBJCtQgiQOIDLZNOBrfHqHP5XZ2DrC2oABID0ZsqW2PVSAJ
        ltutgwaARWIM3FxhD+MkpRiq89LkEBG91sXCK+45jIoUiIu1NQ1ztONqpJE1pOj2M1S/qaqPKG3rI
        NpMWDwiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3Cf3-00DWTm-OZ; Wed, 15 Nov 2023 09:58:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6ADF63002BE; Wed, 15 Nov 2023 10:58:17 +0100 (CET)
Date:   Wed, 15 Nov 2023 10:58:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        irogers@google.com, adrian.hunter@intel.com
Subject: Re: [PATCH 01/13] perf: Simplify perf_event_alloc() error path
Message-ID: <20231115095817.GB3818@noisy.programming.kicks-ass.net>
References: <20231102150919.719936610@infradead.org>
 <20231102152017.847792675@infradead.org>
 <ZUTprUojg7eHoxQI@krava>
 <CAM9d7cj-Y8BwxiqDcpJj0CoPAip3cc6mr+5WQcGYeFX7esw6sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj-Y8BwxiqDcpJj0CoPAip3cc6mr+5WQcGYeFX7esw6sg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 12:50:19PM -0700, Namhyung Kim wrote:

> > > -err_pmu:
> > > -     if (is_cgroup_event(event))
> > > -             perf_detach_cgroup(event);
> > > -     if (event->destroy)
> > > -             event->destroy(event);
> > > -     module_put(pmu->module);
> 
> I'm afraid of this part.  If it failed at perf_init_event(), it might
> call event->destroy() already.  I saw you cleared event->pmu
> in the failure path.  Maybe we need the same thing for the
> event->destroy.

In that case event->destroy will not yet have been set, no?

And once it is set, we should call it.
