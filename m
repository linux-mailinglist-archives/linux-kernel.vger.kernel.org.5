Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1E57784D8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHKBTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKBTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:19:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B426C9F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:19:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691716768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8i9RhZJXNQ+97wt0EEEQZqaoOrJYHB5GVOfsfLI4eI=;
        b=kfXrZpkZCWsNUJn/abep7wR/b2QkE5n3ODPd1LDUcJFX5ftnKkeAFBkfWJv9kZ3iHmFxoO
        mD/AV+zFpc01fIFMdz6KPToT5/3bVW4AUygcCAILXUpoTq91XeFOlofGBoizv0ewXEcFFK
        DpANrfLanxQun22td3wl0LgAmfQFTC0x2K12m6QrsXzwtHRgPPqC0KLYhQx3zE3+rGI+Np
        ntbXTPdUGZsw6BKfRjeFK84DxsnHZG5GrjTYwV9ErR7wOla8wUsQwj17v+NFjANwruJ5/f
        +scz2wyd1SttV6810iD/olx2tZgXxlE1xTuPmSThhueA7hWaWtjTSPH+dh21+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691716768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8i9RhZJXNQ+97wt0EEEQZqaoOrJYHB5GVOfsfLI4eI=;
        b=c5tPeEXnXNdUeGiuZ5zpBJr/l4W7nnbNRHbZ+ZbZBScnpSszgZm1IGgBWijUVOs+LLb7b5
        /ghjhg9YvTt713DQ==
To:     Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
In-Reply-To: <ZNVsk2a19PuNoeSo@araj-mobl.amr.corp.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
 <20230810210511.GH212435@hirez.programming.kicks-ass.net>
 <ZNVbc7qy8k49Dwhi@araj-mobl.amr.corp.intel.com>
 <20230810222957.GJ212435@hirez.programming.kicks-ass.net>
 <ZNVsk2a19PuNoeSo@araj-mobl.amr.corp.intel.com>
Date:   Fri, 11 Aug 2023 03:19:27 +0200
Message-ID: <87h6p6ideo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2023 at 16:02, Ashok Raj wrote:
> On Fri, Aug 11, 2023 at 12:29:57AM +0200, Peter Zijlstra wrote:
>> 
>> Yeah, not placing constraints on who is online at all. Also, if both
>> siblings are offline, then onlining will re-load ucode anyway, no?
>
> We need one thread in a core online,  because a MCE can happen and we don't
> want those running something stale.

Nonsense. This is a constraint at boot time. But afterwards it does not
matter at all. That's what Peter is talking about.


