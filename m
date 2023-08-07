Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A351771F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjHGLI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHGLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657DB3;
        Mon,  7 Aug 2023 04:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D456174C;
        Mon,  7 Aug 2023 11:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC366C433C8;
        Mon,  7 Aug 2023 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691406489;
        bh=hdXUL/3D92Z9yQpqL5wt/vJLONqXakCcF546+DOh+4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bqTc+RgIYDzXvN/ub1XcWMo75DJ473j6Le/czK/fcaloPVJ0mkaEJJsgVVKkZYoOL
         p6iSlOJxz1bloA/USJIUET+SyQ3pd049jLEnWIjHZzhQLwLWeBTw1MtQhS0tXGbGqL
         UF8KYn/EFViz3h/Kp6oa068ofm5bUsgq1QeIUMNen4Q6GmkHMz4A31vQgjgg8Ncyxh
         Qch7XTyieVT0fX3uZXiWqtP7owdtTa5zZBRBlIg76RJwYy0b5b/ba6AZGYrnfgf+Xd
         QkuhNkwf2sDNSwcgn2zFoveyBoCF2qNKxtfg3Hz77vsdrDUHWYfdAVv09u2hc618Vq
         gslGUGqmNFhCQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qSy5m-002ncO-Bw;
        Mon, 07 Aug 2023 12:08:06 +0100
MIME-Version: 1.0
Date:   Mon, 07 Aug 2023 12:08:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
In-Reply-To: <ZNDNY_JfUxXm2vR5@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
 <a030019c7c5887d54b97054ed7d9af12@kernel.org>
 <ZNDNY_JfUxXm2vR5@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7a295fcb4ff02542ff6835a77182fce8@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, dianders@chromium.org, catalin.marinas@arm.com, will@kernel.org, sumit.garg@linaro.org, daniel.thompson@linaro.org, linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com, wens@csie.org, ardb@kernel.org, swboyd@chromium.org, peterz@infradead.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kgdb-bugreport@lists.sourceforge.net, msys.mizuma@gmail.com, rafael.j.wysocki@intel.com, lecopzer.chen@mediatek.com, liwei391@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-07 11:54, Mark Rutland wrote:
> On Mon, Aug 07, 2023 at 11:47:04AM +0100, Marc Zyngier wrote:
>> On 2023-08-07 11:28, Mark Rutland wrote:
>> > On Thu, Jun 01, 2023 at 02:31:51PM -0700, Douglas Anderson wrote:
>> > > From: Sumit Garg <sumit.garg@linaro.org>
>> > >
>> > > Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
>> > > IPI is backed by an NMI (or pseudo NMI) then this will let us debug
>> > > even hard locked CPUs. When the debug IPI isn't backed by an NMI then
>> > > this won't really have any huge benefit but it will still work.
>> > >
>> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> > > ---
>> > >
>> > > Changes in v9:
>> > > - Remove fallback for when debug IPI isn't available.
>> > > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by
>> > > NMI.
>> > >
>> > >  arch/arm64/kernel/ipi_debug.c |  5 +++++
>> > >  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
>> > >  2 files changed, 19 insertions(+)
>> >
>> > This looks fine to me, but I'd feel a bit happier if we had separate
>> > SGIs for
>> > the backtrace and the KGDB callback as they're logically unrelated.
>> 
>> Well, we're a bit stuck here.
>> 
>> We have exactly *one* spare SGI with GICv3, as we lose 8 of them
>> to the secure side. One possibility would be to mux some of the
>> lesser used IPIs onto two SGIs (one with standard priority, and
>> one with NMI priority).
> 
> Understood; Doug and I suggested two options for that:
> 
> 1) Unify/mux the IPI_CPU_STOP and IPI_CPU_CRASH_STOP IPIs
> 
>    The only *intended* difference between the two is that 
> IPI_CPU_CRASH_STOP
>    calls crash_save_cpu() before trying to stop the CPU, but the
>    implementations have diverged significantly for unrelated reasons.
> 
> 2) Remove IPI_WAKEUP
> 
>    We only use IPI_WAKEUP for the ACPI parking protocol, and we could 
> reuse
>    another IPI (e.g. IPI_RESCHEDULE) to achieve the same thing witout a
>    dedicated IPI.

Sure. My concern is that we're papering over the fundamental problem,
which is that IPIs are limited resource, and that we're bound to pile
more stuff on them.

I'm all for reclaiming the ones that can be merged, but we may 
ultimately
need a real fix for this.

         M.
-- 
Jazz is not dead. It just smells funny...
