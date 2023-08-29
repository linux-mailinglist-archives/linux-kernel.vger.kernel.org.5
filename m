Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FA78C4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjH2NFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjH2NE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF699
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D48C62059
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C54BC433C7;
        Tue, 29 Aug 2023 13:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693314295;
        bh=zU4/7GSvfNmFXABhQ59KUyf/rZM5DOBimhtP9OKd4zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b800/ojVPZAdqcUE6aEx7exghdNZHbZAkuOXp384cw/Y+CoxW9sEfRmVYThfBTAcF
         wlNHLePa8NtUFkx46evviB8kmdI8/TJ+N/xwHAsi5sEnPrO+Ua8TkCkD4cDWbpdzMT
         NxCkKOTHquV2H2Zc4ncSTdDMnabtQ0pdh/1KxQdyoNsiwVN9qY1XswjO9D57Fbeugh
         tnJLwWzjVrJi+7mYncKz51RZ/DAXkOulLzXYuwv2lWCZEPpCTrJqJuEZbCZkvrYUqW
         rtEjUOy8MSSLVzRNhWMkILczrtRzt7VsAPTVO7cMgBXuRgDt+gCWqUsQtaQzMIjXds
         q55QoTKyd/caw==
Date:   Tue, 29 Aug 2023 15:04:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 03/10] cpuidle: Report illegal tick stopped while polling
Message-ID: <ZO3s9GvSJ8zt9kGC@lothringen>
References: <20230811170049.308866-1-frederic@kernel.org>
 <20230811170049.308866-4-frederic@kernel.org>
 <CAJZ5v0jUnOC4gABpmg3pX0KWXvYcYEzsHcjY1LqH8qzJ94QsvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jUnOC4gABpmg3pX0KWXvYcYEzsHcjY1LqH8qzJ94QsvQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:37:55PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 11, 2023 at 7:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > poll_idle() can't be called while the tick is stopped because it enables
> > interrupts and only polls on TIF_NEED_RESCHED, which doesn't tell if an
> > interrupt queues a timer that would require a tick re-programming.
> >
> > There is no point anyway to poll with the tick stopped so add a check
> > to make sure it never happens.
> 
> I'd rather update governors so they never use polling states when the
> tick has been stopped and then add the WARN_ON().

Sounds good, let's put this one aside.

In the meantime feel free to pick up those you acked and see fit in your
queue.

Thanks!
