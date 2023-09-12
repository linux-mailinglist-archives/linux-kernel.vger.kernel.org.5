Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551ED79D391
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjILO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjILO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:28:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE7110;
        Tue, 12 Sep 2023 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gk/9rYB7/an+iLUFV0aLbLxXVYBQ+i5HvJgnM5j31Ck=; b=Fyh3eDhp+bMke+9/vqft1ssk0u
        K26AKRckbeIkVO6fwlvCUaguX+jW9DTHl9KN5PvnMoIW9yRNl/+OK2496aleokV1T5ZtsU5fmOD0B
        Zr2J0fVLnb+oRoid8vba39T9Xl8js/gtSTQeRLLb0gP8wJD1PaLIem9aVMy6WsjczwtvzH1XOwkBh
        HaiXrQeJU9uJ23G1TlqWDBj7Oby5rpqQa88e6Xky/nossK7i99FUhKhypBj6Y6rHinDvXThtPGEDM
        Z6I0/uG8zv54kLWPtxSnWM90o2+NxHtkqvkwY4mXAy99Jp+6c3T3Z95JkirS6H8FidEmfn7y8LLpr
        mLiMrZuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg4NJ-00843H-Ki; Tue, 12 Sep 2023 14:28:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47E57300348; Tue, 12 Sep 2023 16:28:21 +0200 (CEST)
Date:   Tue, 12 Sep 2023 16:28:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Chris Redpath <Chris.Redpath@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230912142821.GA22166@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
 <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
 <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
 <20230907201609.GC14243@noisy.programming.kicks-ass.net>
 <f1b1b663-3a12-9e5d-932b-b3ffb5f02e14@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b1b663-3a12-9e5d-932b-b3ffb5f02e14@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:51:52PM +0100, Lukasz Luba wrote:

> You can see the util signal of that 'CrRendererMain' task and those
> utilization drops in time, which I was referring to. When the util
> drops below some threshold, the task might 'fit' into smaller CPU,
> which could be prevented automatically byt maintaining the util est
> for longer (but not for all).

Right, so right at those util_est dips it has some small activations.
It's like a poll loop or something instead of a full block waiting for
things to happen.

And yeah, that'll destroy util_est in a hurry :/

> I do like your idea that Util EST might be per-task. I'm going to
> check this, because that might help to get rid of the overutilized state
> which is probably because small tasks are also 'bigger' for longer.
> 
> If this util est have chance to fly upstream, I could send an RFC if
> you don't mind.

The biggest stumbling block I see is the user interface; some generic
QoS hints based thing that allows us to do random things -- like tune
the above might do, dunno.

