Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16D17A0002
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjINJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjINJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1ACF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:29:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F06C433C8;
        Thu, 14 Sep 2023 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694683783;
        bh=gUaeuzg5Lsnt+jFoiVND+TSHnUACWUT2IpD58sScFbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MT9Pe9pS7XbHKPDTCmHX6UzV/a1wI1T+Gu9msNwrIS51ZxJO+KUvVYBNosdvU+39n
         DVe5RoCMo5uPViwUp67fFicn00HDLPoszDuWrhKlLoUSegXOfIl4MJmUYeADmKWk9X
         oDklVNTpNf6Fa23UP9u64nEvAeCzwBesxiPgRf5mr2uMXe7DQ86pNzuCH81/QviHvm
         GXYla8PNCFR/+3+JuS1Q5PP8K5pwfe942NAshMgs3Zfu+eBVZ3eDlSr6j5m2Wedean
         UJhiO9z/R8sigqOLLihhn72+7KzMaZCYFsaaPDUeohQmGETtLGpybX/x9CI8c8ysEi
         kCew1BCEApsAg==
Date:   Thu, 14 Sep 2023 11:29:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] tick/nohz: Don't shutdown the lowres tick from itself
Message-ID: <ZQLShD1ujiuqLiJI@lothringen>
References: <20230912104406.312185-1-frederic@kernel.org>
 <20230912104406.312185-4-frederic@kernel.org>
 <CAEXW_YTwzK9jkUdMUPY0t++yYvwSHx1EZiPX6NiSt7hPhHZbpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTwzK9jkUdMUPY0t++yYvwSHx1EZiPX6NiSt7hPhHZbpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:17:21PM -0400, Joel Fernandes wrote:
> On Tue, Sep 12, 2023 at 6:44 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > In lowres dynticks mode, just like in highres dynticks mode, when there
> > is no tick to program in the future, the tick eventually gets
> > deactivated either:
> >
> > * From the idle loop if in idle mode.
> > * From the IRQ exit if in full dynticks mode.
> >
> > Therefore there is no need to deactivate it from the tick itself. This
> > just just brings more overhead in the idle tick path for no reason.
> >
> > Fixes: 62c1256d5447 ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> If on some weird hardware, say  ts->next_tick = KTIME_MAX but a
> spurious timer interrupt went off and tick_nohz_handler() did get
> called (yeah weird hypothetical situation), then in
> tick_nohz_stop_tick() we might early return from:
> 
> /* Skip reprogram of event if its not changed */
> if (ts->tick_stopped && (expires == ts->next_tick))
> 
> without no "eventual" reprogramming.
> 
> Maybe we should also reprogram with KTIME_MAX in such a situation?
> Then we can get rid of it from tick_nohz_handler() for the common case
> as you are doing.
> 
> So for weird hardware, with this patch we are not doing an extra
> tick_program_event(KTIME_MAX, 1); like Nick was doing. That makes me a
> tad bit nervous.

So when a tick happens, ts->next_tick is reset to 0 (in tick_sched_handle()).
This way if a timer interrupt fires too early, and that includes also timer
interrupts when next_tick is KTIME_MAX, the timer is always reprogrammed upon
the next idle loop iteration. So this shouldn't happen.

Thanks.
