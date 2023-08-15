Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411377CFED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjHOQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbjHOQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:10:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B059127
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lyIJZEK3v3Bzn1FJlGjrVWh3y3Wd90z/ztLe9q3wyt0=; b=EOkXzL/pHcBHdBh5/w1gk/PVA1
        +ZUI2UM2GYg+GU4prnYnR8FFjCLPF+//AqykEZUAqtxc84d63YtSV5TrXmoeZqx7QJqE/kJvpAFtE
        ERQKU45rA+2gHCDtNB+YgwzMyLEi/FIv/62+Fh5T66zNKpvIBn3SoSnM16qWdaYlZrMw/8LsnL/J3
        7a3aoSwioEOXYfEPwOkbGs3sS0QcxLgQPruV6Y47+nE+c992iK5TtWutB0guNkEy1C5xk+Eaypz0l
        TTJLzoM9m4VZpRHddf0Dk4E6Stw7WLuegWgMjG4ATffF7+iPdoMu8GXew0LMsI22XrXSOnZ0/jR31
        YMHoOPPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVwd1-00BwMk-2g;
        Tue, 15 Aug 2023 16:10:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C768300137;
        Tue, 15 Aug 2023 18:10:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2929820307345; Tue, 15 Aug 2023 18:10:43 +0200 (CEST)
Date:   Tue, 15 Aug 2023 18:10:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 00/10] timers/cpuidle: Fixes and cleanups
Message-ID: <20230815161043.GL212435@hirez.programming.kicks-ass.net>
References: <20230811170049.308866-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811170049.308866-1-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:00:39PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> The first part of the series is cpuidle callback fixes against timers,
> some of which haven't been Signed by Peter yet.
> 
> Another part is removing the overhead of useless TIF_NR_POLLING clearing.

So I've again forgotten why we don't simply set TIF_NEED_RESCHED if we
need the timer re-programmed. That is by far the simplest fix.

I'm sure we talked about it, but this was a long time ago and I can't
remember :/

Anyway, the patches look good, except I think there's a whole bunch of
architectures that still need fixing. In particular since loongson
'borrowed' the whole lot from MIPS, they need an identical fix. But I'm
sure there's more architectures affected.


