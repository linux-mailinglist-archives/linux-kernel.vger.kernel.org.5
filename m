Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F97F3378
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjKUQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKUQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:17:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC3192
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:17:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380C5C433C8;
        Tue, 21 Nov 2023 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700583468;
        bh=7cSOHL2IJoGFmC5GmmnLkiU+EjKX6ahpFKVxkXiUgDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eq0EG04J1DXAqs3vJIZolU3NEyJeIwWevtTYBz0vO9D8e+gpCDdFKNLg3ZQaXt1dr
         SUFtUIqUTHZZTvoNwnAQxhZ3OD154gKT5HOL2+WX+CY+0vS02Fax6pvI3xhTUBGLyH
         Vj7FQ0pLr4NFqUI3iEZANxlliV/pCkMEFWMTWB06xpl9LYw1pxN65HTpuaLtjcfT/g
         6IN4DkHuduC10RllAeKNp6uOrKjgrITWq3hcDxVfMQkwU9oympZZtm1EclJMgk+fHB
         q2xUUmPD/FUH8eOOV3MZ7OioLmdFA7AoRg8HJDqeqDjLwagkiXPCOFeDgQFZ8G5wIS
         AVP9zbvflfT7w==
Date:   Tue, 21 Nov 2023 16:17:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 07/34] perf/arm: optimize opencoded atomic find_bit() API
Message-ID: <20231121161742.GA2151@willie-the-truck>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-8-yury.norov@gmail.com>
 <20231121155344.GB1938@willie-the-truck>
 <ZVzXzbbQq2QEYtgs@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzXzbbQq2QEYtgs@yury-ThinkPad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:16:13AM -0800, Yury Norov wrote:
> On Tue, Nov 21, 2023 at 03:53:44PM +0000, Will Deacon wrote:
> > On Sat, Nov 18, 2023 at 07:50:38AM -0800, Yury Norov wrote:
> > > Switch subsystem to use atomic find_bit() or atomic iterators as
> > > appropriate.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  drivers/perf/arm-cci.c        | 23 +++++------------------
> > >  drivers/perf/arm-ccn.c        | 10 ++--------
> > >  drivers/perf/arm_dmc620_pmu.c |  9 ++-------
> > >  drivers/perf/arm_pmuv3.c      |  8 ++------
> > >  4 files changed, 11 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> > > index 61de861eaf91..70fbf9d09d37 100644
> > > --- a/drivers/perf/arm-cci.c
> > > +++ b/drivers/perf/arm-cci.c
> > > @@ -320,12 +320,8 @@ static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
> > >  		return CCI400_PMU_CYCLE_CNTR_IDX;
> > >  	}
> > >  
> > > -	for (idx = CCI400_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
> > > -		if (!test_and_set_bit(idx, hw->used_mask))
> > > -			return idx;
> > > -
> > > -	/* No counters available */
> > > -	return -EAGAIN;
> > > +	idx = find_and_set_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1);
> > 
> > CCI400_PMU_CNTR0_IDX is defined as 1, so isn't this wrong?
> 
> You're right. Will fix in v2
>  
> > [...]
> > 
> > > diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> > > index 30cea6859574..e41c84dabc3e 100644
> > > --- a/drivers/perf/arm_dmc620_pmu.c
> > > +++ b/drivers/perf/arm_dmc620_pmu.c
> > > @@ -303,13 +303,8 @@ static int dmc620_get_event_idx(struct perf_event *event)
> > >  		end_idx = DMC620_PMU_MAX_COUNTERS;
> > >  	}
> > >  
> > > -	for (idx = start_idx; idx < end_idx; ++idx) {
> > > -		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
> > > -			return idx;
> > > -	}
> > > -
> > > -	/* The counters are all in use. */
> > > -	return -EAGAIN;
> > > +	idx = find_and_set_next_bit(dmc620_pmu->used_mask, end_idx, start_idx);
> > 
> > It might just be me, but I'd find this a tonne easier to read if you swapped
> > the last two arguments around so that the offset came before the limit in
> > the new function.
> 
> I personally agree, but we already have find_next_*_bit(addr, nbits, offset)
> functions, and having atomic versions of the same with different order
> of arguments will make it even more messy...

Urgh, and there's loads of them too :(

Will
