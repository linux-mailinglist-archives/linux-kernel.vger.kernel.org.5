Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52A576346A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjGZK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjGZK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234B69B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A9261A53
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A2AC433C7;
        Wed, 26 Jul 2023 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690369152;
        bh=cXAxx7ipjEHqiG8r+x+mmfq9j1I34+FnlTDvkbY9rY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HieFCXUnKbJKN5LX3RCnbwkevAuET9VNV05FEz2C+Y3XH5XL9VLieZyPmeX/yqazU
         /S9m/QHRXPw1WuXirTu421waNapnZ7tN+fN1yzA/+qp3HNH0T4HCxtSPULgtWxtL7J
         UQmZk9y+2IAGbGrWp7btvoNO6zaLteuhPp/YW8iAEDrm0OSRU0/SGNXCq73Wf72RDy
         Uw53VkWHUUyZo1lC7OxX/j9bD5EPHiM8D5TKH8s1s1fjhijuIT8nXe4QwEWTyYtM5G
         yk9rdSv7chQmGcnxmpvHwX4EUEfLCp//NnAyebHRfwA3JpOmo01HZpovM4SvaLBzY+
         wQw8qeaqHnlyg==
Date:   Wed, 26 Jul 2023 12:59:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <ZMD8fP36By1KYgkk@localhost.localdomain>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jul 25, 2023 at 04:27:56PM +0200, Rafael J. Wysocki a écrit :
> On Tue, Jul 25, 2023 at 3:07 PM Anna-Maria Behnsen
> I'll let Frederic respond to the above, but from my perspective it all
> just means that the idle governors in use today are not perfect.
> 
> However, they will never be perfect, because they only have a little
> time to make a decision, so it's a matter of balancing that with
> precision.

So, even without considering Anna-Maria's patchset, sparing
the next timer lookup if we already know we won't stop it would show
quite a benefit because that lookup involves locking and quite some
overhead walking through all levels.

Thanks.
