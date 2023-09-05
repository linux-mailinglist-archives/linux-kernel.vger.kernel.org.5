Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1922792A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjIEQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354427AbjIELdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:33:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300C1AB;
        Tue,  5 Sep 2023 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWNhs2e9Iv9jGKbo5U2PTlv5NZNmT2NXwZm8hZV7Q6s=; b=G681dMzCokaHbIlui9IjVKc1JA
        aJHOIv3WiTnfz05QmGqsRr62yPSWeK5yM3efZ2x+/lTmdZ9/RnGTJbfBJbF5SJs0rgHoT+j5S6PKF
        CdX+dgI/ISTEGbHoM0xmbWGnqHLkTXIfqD1IfqTd18u0XUnuPzs0O6umFGbE4j0xE1bl1p9lB47Es
        ImgZy3PCPD4l7j/ITGOgRPfER5qAAoty2z4e6QgXkpfXSyxD9X1IFgj3VjwVM0qolb7koHosPemUH
        19pxfPkS+gPBAOclUl9szYjGvD/U/Fpt2W/K6dWpsIm/LQRBA0C+QmZtyM9FV70E3j/dLXVI8cI4T
        aaaImgew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdUIt-0008VJ-2E;
        Tue, 05 Sep 2023 11:33:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4EB0300687; Tue,  5 Sep 2023 13:33:08 +0200 (CEST)
Date:   Tue, 5 Sep 2023 13:33:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 4/4] energy_model: use a fixed reference frequency
Message-ID: <20230905113308.GF28319@noisy.programming.kicks-ass.net>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-5-vincent.guittot@linaro.org>
 <cd795543-53db-ed14-e9dd-b5738a4f3b9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd795543-53db-ed14-e9dd-b5738a4f3b9d@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:05:30PM +0200, Pierre Gondois wrote:
> Hello Vincent,
> I tried the patch-set on a platform using cppc_cpufreq and that has boosting
> frequencies,
> 
> 1-
> On such platform, the CPU capacity comes from the CPPC highest_frequency
> field. The CPU capacity is set to the capacity of the boosting frequency.
> This behaviour is different from DT platforms where the CPU capacity is
> updated whenever the boosting mode is enabled (it seems).
> 
> Wouldn't it be better to have CPU max capacities set to their boosting
> capacity as for CPPC base platforms ? It seems the max frequency is always
> available somehow for all the cpufreq drivers with boosting available, i.e.
> acpi-cpufreq, amd-pstate, cppc_cpufreq.

So on Intel we don't use the max (turbo) boost value, but typically end
up picking the 4-core turbo value or something. There's a comment in
arch/x86/kernel/cpu/aperfmperf.c.

Per that comment it probably makes sense to be able to differentiate
between a mobile device and a server, or perhaps we can (ab)use the EAS
enable knob for this distinction?

That is, I'm not sure it makes sense to always pick the highest boost
freqency for ARM64 servers, very much analogous to  how we don't do that
on Intel.
