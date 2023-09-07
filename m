Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD466797373
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbjIGPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjIGPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9E199;
        Thu,  7 Sep 2023 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kJOi6MUn+Vldg3NHHX2a3mAlkndJSdjyJyfTtx+pnrE=; b=PTA5yew4pQ4352Q/YhXHFzTra/
        3Kobfh90G+9NrYKS2Q1PqgAO0RlzyS/DqtB5QhU1CEMlGhkpef6JZw5PUEPUEdXEAiWMyTY/yQbSl
        Rq4NZU3DYt5BXu7xj5DpB04SVIuBXEBd8zgsKfEzOmzcmGzL98+mKTU87h4XLfBLfwpM9I3bJqVqo
        /Z7phzhDhxT9pGEJxuw1Un4tP5pkg1SROjdguGpA106fn/eKz8RME9SK4OWWJGTwsLiL1kn/aiIvz
        mgA6Izz+uUaxPfDtbzhNNe6TM6uzO3D32W17GNgXVO9ezM1nUY2I3FQC40MErRSqsSxhyWCynfUzj
        Xbf5X4Uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeF1j-00B8NG-S7; Thu, 07 Sep 2023 13:26:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86F64300687; Thu,  7 Sep 2023 15:26:31 +0200 (CEST)
Date:   Thu, 7 Sep 2023 15:26:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230907132631.GF10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:18:50PM +0100, Qais Yousef wrote:

> This is probably controversial statement. But I am not in favour of util_est.
> I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
> default instead. But I will need to do a separate investigation on that.

I think util_est makes perfect sense, where PELT has to fundamentally
decay non-running / non-runnable tasks in order to provide a temporal
average, DVFS might be best served with a termporal max filter.


