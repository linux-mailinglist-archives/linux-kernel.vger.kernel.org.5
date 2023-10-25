Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151EB7D6C67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjJYMw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjJYMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:52:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40998C1;
        Wed, 25 Oct 2023 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3F/VPYVxQQPlC4GYJcoGjOrbvtpKw8aYmzGOYzcFJ6I=; b=Z+9W82UB7PDtFMMIASUBUdniRI
        zeJjphb3sY9S6RUftogueBqGQfkT4HJG6YiO1PJGBcmwx6UF4INYZnXlgeC3RP6q9MW8+UiTlLTr7
        oODKzTBxeA9W4BirqqZ511zD4K8ZM7U0A3MmvUVroCoZlA3hTOshf+bvov12MiyfuJbhHFiRCFCPt
        PJo9orqWMBTUZaiJV1cKUUNJXTFDp2Jx8JTb74wHVVkdkWvD1l5l9v0rNJUkrrLmPSOa9mKMXphxz
        VcsV6mQwMyoeD485EilrTCuYebFzPrsagcBMHpTNmgSGl6utFNUc3DXlJIzzyF3YdpqYg+3EUE9bG
        n7MAtCgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvdMW-00GLXG-09;
        Wed, 25 Oct 2023 12:51:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77DD130047C; Wed, 25 Oct 2023 14:51:51 +0200 (CEST)
Date:   Wed, 25 Oct 2023 14:51:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for
 computing the capacity
Message-ID: <20231025125151.GF31201@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-6-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:25:39PM +0200, Vincent Guittot wrote:
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In such
> case, it needs the frequency for this compute capacity.
> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
>  drivers/base/arch_topology.c   |  15 +++-
>  drivers/cpufreq/cppc_cpufreq.c | 141 ++++++---------------------------
>  include/acpi/cppc_acpi.h       |   2 +
>  4 files changed, 133 insertions(+), 118 deletions(-)

Perhaps split this patch into code movement and actual change for ease
of review? As in, I'm having trouble finding the actual changes ;-)
