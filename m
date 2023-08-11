Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE57792B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjHKPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjHKPR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D530DD;
        Fri, 11 Aug 2023 08:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72BB46747F;
        Fri, 11 Aug 2023 15:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9247C433C9;
        Fri, 11 Aug 2023 15:17:20 +0000 (UTC)
Date:   Fri, 11 Aug 2023 11:17:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Atul Pant <quic_atulpant@quicinc.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ashayj@quicinc.com,
        quic_rgottimu@quicinc.com, quic_shashim@quicinc.com
Subject: Re: Prevent RT-throttling for idle-injection threads
Message-ID: <20230811111719.17f9965a@gandalf.local.home>
In-Reply-To: <20230808112523.2788452-1-quic_atulpant@quicinc.com>
References: <20230808112523.2788452-1-quic_atulpant@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Aug 2023 16:55:23 +0530
Atul Pant <quic_atulpant@quicinc.com> wrote:

> Hi all,
> We are trying to implement a solution for thermal mitigation by using
> idle injection on CPUs. However we face some limitations with the current
> idle-inject framework. As per our need, we want to start injecting idle
> cycles on a CPU for indefinite time (until the temperature/power of the
> CPU falls below a threshold). This will help to keep the hot CPUs in the
> sleep state until we see improvement in temperature/power. If we set the
> idle duration to a large value or have an idle-injection ratio of 100%,
> then the idle-inject RT thread suffers from RT throttling. This results
> in the CPU exiting from the sleep state and consuming some power.
> 
> The above situation can be avoided, if we can prevent RT throttling on
> the injected CPU. With the currently available sysctl parameters,
> sched_rt_runtime_us and sched_rt_period_us, we can prevent RT throttling
> by either setting sched_rt_runtime_us equal to sched_rt_period_us or,
> setting sched_rt_runtime_us to -1. Since these parameters are system
> wide, so it will affect the RT tasks on non idle-injected CPUs as well.
> To overcome this, will it be feasible to have these two parameters on a
> per CPU basis? This will allow to selectively disable RT throttling on
> idle-injected CPUs.

I wonder if the deadline scheduler that Daniel is working on would help in this case?

-- Steve

