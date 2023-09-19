Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4397A5C38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjISIOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjISINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:13:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3CFFB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:13:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695111220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMN7mNtgI6/V9AqGcVuDSuGP8F5czBGCJW3I64yqozc=;
        b=udo0Fkd8NNGs9Ba5V4C03Mz61u+jZd6WLTmPE4sKd5SjTxJVoOW4hTt1T3Je9HXNba8UUu
        t6tC4BHV+yNLHL2wiQGoC5K0CMPupRZ6bOOaUoTYGCPNAXPpnz61e96XFFkfMefPAOIffb
        kirOgsiPGEyolM/4aP8G7J6OH1gLyx3RUVFJ6fIeE4Q4T/wv0SJwGhtYgR47VqgMCoS4yL
        2yJ3dAXzLmX/F/79DI0JSIDK0KcUMcr8CGiRCcwrWvuYySJCqN8zmHSZVyJ6xmAYcPl+Mn
        UqeKfyIPEopug8UFGX+MktNm9inqAK/LoyGepIMjxdTgGocz2RgRgUS+UWDUAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695111220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMN7mNtgI6/V9AqGcVuDSuGP8F5czBGCJW3I64yqozc=;
        b=C3HRybh7lrPRO/xAahoa5tBYRsZHMBB1FgzCS2xefTq6J9rA1O3URcnAFu1JNn4WbQSzww
        YgyvCCa5DsT9jwCQ==
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
In-Reply-To: <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
 <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
 <20230915115428.GD6721@noisy.programming.kicks-ass.net>
 <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
 <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com>
Date:   Tue, 19 Sep 2023 10:13:39 +0200
Message-ID: <87y1h2wpfw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 09:24, K Prateek Nayak wrote:
> If possible, can you please elaborate on the "software perspective". Say
> CPUID leaf 0x1f reports multiple tile, would the data access latency or
> cache to cache latency see a noticeable difference?
>
> I would like to understand what the characteristics of a "Tile" are and
> whether they are similar to AMD's CCX instances discoverable by AMD's
> extended CPUID leaf 0x80000026. That way, in future, when the generic
> topology is used by other subsystems, the data from "TOPO_TILE_DOMAIN"
> can be used generically for both Intel and AMD.

I'm not convinced that this is possible. The meaning of these elements
is unfortunately not cast in stone, so the association of e.g. cache
boundaries is not necessarily static accross a larger range of CPU
generations..

We really need to differentiate performance characteristic, hardware
feature scope, power management scope etc. and create abstractions which
are actually useful for kernel facilities and user space.

From a performance perspective it's irrelevant whether the scope is TILE
or whatever. The information needed is the hierarchy, the performance
characteristics of a segment in the hierarchy and the costs for cross
segment access and cross segment migration.

For hardware features like perf the information needed is what the scope
of a particular resource is. Again it's not necessarily useful to know
what particular domain type it is.

Powermanagement does not care about the particual type either. It needs
to know which scopes affect c-states, clock speeds ... to give the
scheduler informtion of how to steer workloads in the most efficient way.

Thanks,

        tglx
