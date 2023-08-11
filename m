Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC297784EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjHKBcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHKBb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:31:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926F2D4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:31:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691717516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M794NsiIVH7fC7DsaiqRd+31wUdGmjA7c++PEgDz3kQ=;
        b=xz1ucWhJez+Eg1YYjkBLuzQG3x7/jyUadSmp9VqWLDQvnK41YEQGcfqFQN+pHq99N8Mnbq
        BV93XR+PcBtSlNGyjmGv1zFuCWqbJCPf6ASwWOVw/UuPpLiWvnRvnwEsCj6hkwWOBnNgC3
        v+z3rB/LoPGaUvBjPf/I93SeEO+cYOAeEwM6fEf9gWH7+UwPyJG1tsoOondhfD7eLM5ceP
        0SOCMqE4UtchYQenhX786UonErBk09Oqiyhy/jDsuiXRc44qkC3RR2ub3LePhB9fa10njO
        /3/1vARTvMonfNANRmmIzbQGeuxkvW+pNu4luJoUImt9GWwN0+zdB6LQXqeMdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691717516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M794NsiIVH7fC7DsaiqRd+31wUdGmjA7c++PEgDz3kQ=;
        b=M2sVJJqs7tPX0aosfXcxmyBsdG03AL+MdaniDDj7t6LPhXLkIhxtzjNZ/WzBtPbt+Y15HK
        /j3Nk5u9KGtqhAAQ==
To:     Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
In-Reply-To: <87h6p6ideo.ffs@tglx>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
 <20230810210511.GH212435@hirez.programming.kicks-ass.net>
 <ZNVbc7qy8k49Dwhi@araj-mobl.amr.corp.intel.com>
 <20230810222957.GJ212435@hirez.programming.kicks-ass.net>
 <ZNVsk2a19PuNoeSo@araj-mobl.amr.corp.intel.com> <87h6p6ideo.ffs@tglx>
Date:   Fri, 11 Aug 2023 03:31:56 +0200
Message-ID: <87cyzuictv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11 2023 at 03:19, Thomas Gleixner wrote:

> On Thu, Aug 10 2023 at 16:02, Ashok Raj wrote:
>> On Fri, Aug 11, 2023 at 12:29:57AM +0200, Peter Zijlstra wrote:
>>> 
>>> Yeah, not placing constraints on who is online at all. Also, if both
>>> siblings are offline, then onlining will re-load ucode anyway, no?
>>
>> We need one thread in a core online,  because a MCE can happen and we don't
>> want those running something stale.
>
> Nonsense. This is a constraint at boot time. But afterwards it does not
> matter at all. That's what Peter is talking about.

And worse. It does not matter whether one thread of a core is online or
not in the case of a broadcast MCE during a microcode update simply
because that's game over.

Thanks,

        tglx
