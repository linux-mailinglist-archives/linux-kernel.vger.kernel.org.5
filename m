Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E97A2703
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjIOTOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjIOTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:14:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83BE210A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:14:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694805266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rApaMJWzLfsSlXraIlDQUJyr3iLwzD00Wf6q05UQ0mU=;
        b=VhiEl6OnF7EIHZJ0155JYnZKmWWPicROKgPOGKFsPdTtv9NbdGHV8VraP4Mca4lP7phW2N
        CZZZBV6m5/Zz2JxbJkyLiAehLcg3EAcFt2KHLXHddKDutmId0xLaKuARM9DP6wt/PZSuP7
        ANfnpr288k3QwRzKXizWXESSpthW1mT6PP+vDQs/42g3AfnU4zCDPOsJXkvDcGu3BEqc43
        mih695uKck/ev/CrIfdNNipokd9r4vvkeYp+raKqmHhFzEZlrDD0OvzYEW+NyFM4hVj9EE
        hZ3MwbPLOJJiSz//MgIqhvD6yWnWThoO3yqiTPqJp73Bwj6zNJlbIF6xMmNrIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694805266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rApaMJWzLfsSlXraIlDQUJyr3iLwzD00Wf6q05UQ0mU=;
        b=zrklfkJaPaJbPwJMIOjo273uhLqrzHOFJz+YrfnWxTkKGqSo+SXcSSBLom1XvIN987uKZh
        p4o167PLO7Iz4NBg==
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Initialize evtstrm
 after finalizing cpucaps
In-Reply-To: <20230907133410.3817800-1-mark.rutland@arm.com>
References: <20230907133410.3817800-1-mark.rutland@arm.com>
Date:   Fri, 15 Sep 2023 21:14:25 +0200
Message-ID: <87y1h7z1ta.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07 2023 at 14:34, Mark Rutland wrote:

> We attempt to initialize each CPU's arch_timer event stream in
> arch_timer_evtstrm_enable(), which we call from the
> arch_timer_starting_cpu() cpu hotplug callback which is registered early
> in boot. As this is registered before we initialize the system cpucaps,
> the test for ARM64_HAS_ECV will always be false for CPUs present at boot
> time, and will only be taken into account for CPUs onlined late
> (including those which are hotplugged out and in again).
>
> Due to this, CPUs present and boot time may not use the intended divider
> and scale factor to generate the event stream, and may differ from other
> CPUs.
>
> Correct this by only initializing the event stream after cpucaps have been
> finalized, registering a separate CPU hotplug callback for the event stream
> configuration. Since the caps must be finalized by this point, use
> spus_have_final_cap() to verify this.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
