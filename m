Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB09F7EC7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKOP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjKOP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:57:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C3A2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:57:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A48C433C7;
        Wed, 15 Nov 2023 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700063865;
        bh=bs8jJhi9NjZvhbt3lOoxsn0RaQ6GU0zuz33zw7GNIFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kk4dOkdituq8WX4i20BJeGMebva2citeKL0dKBRnThQr9wftZjliVqB+L3wCbY2iw
         e+KdUNVrIwDxX8UnxcmKon4k8xWWqbHFCeIOUN0eLKq0azgnNh9NSvYwk5kHVIHUsv
         QpRcxPYMC0TnFeHQngIU6teVp3/1AG7+PNHAqlnN+roRUWmU9ZTaAk2dElGKDIVBbX
         LMKCyjE5hvO/lXn328rEA7XM5DmSPJdmH/KEu1o/XBzBND/eJKH27Zxqlwj6t0EgqN
         hjyqxQ9iqGrYJ29OdIa+E/hycxOlt3Siei1kvi6rt7r6jWr42TaJlNxrGx7j5PRxep
         nc0dZrubLr1vg==
Date:   Wed, 15 Nov 2023 10:57:44 -0500
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer
 reprogram
Message-ID: <ZVTqeKYHdCZdVNDU@localhost.localdomain>
References: <20231115151325.6262-1-frederic@kernel.org>
 <20231115151325.6262-3-frederic@kernel.org>
 <20231115155232.GD8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115155232.GD8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Nov 15, 2023 at 04:52:32PM +0100, Peter Zijlstra a écrit :
> On Wed, Nov 15, 2023 at 10:13:23AM -0500, Frederic Weisbecker wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > intel_idle_irq() re-enables IRQs very early. As a result, an interrupt
> > may fire before mwait() is eventually called. If such an interrupt queues
> > a timer, it may go unnoticed until mwait returns and the idle loop
> > handles the tick re-evaluation. And monitoring TIF_NEED_RESCHED doesn't
> > help because a local timer enqueue doesn't set that flag.
> > 
> > The issue is mitigated by the fact that this idle handler is only invoked
> > for shallow C-states when, presumably, the next tick is supposed to be
> > close enough. There may still be rare cases though when the next tick
> > is far away and the selected C-state is shallow, resulting in a timer
> > getting ignored for a while.
> > 
> > Fix this with using sti_mwait() whose IRQ-reenablement only triggers
> > upon calling mwait(), dealing with the race while keeping the interrupt
> > latency within acceptable bounds.
> > 
> > Fixes: c227233ad64c (intel_idle: enable interrupts before C1 on Xeons)
> > Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> 
> Feel free to change to normal SOB, I'm assuming it actually compiles and
> works by now :-)

Not sure, I might have tested it at some point ;-)

Thanks!
