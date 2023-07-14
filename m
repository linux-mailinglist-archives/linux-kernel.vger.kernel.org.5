Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E137544CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjGNWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGNWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:02:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C71BF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fgAY7veGGJCbRAMMbGZOc0grcKb2j7RyXFUpzppk3bI=; b=bUUx3olRZMph1mbYBULy3tcBGa
        yVuwnMLkusxKRB5aElHF9v8LE4c5B1NsUQP1H4CVV8ydwGJBFAo7T//lx2WyIcElM5/DfM/FEZgSw
        3GsErSOjrNHZHOKjE9y5BNn2kRA5LYVAVCT084KHQWN+fETr/h3/mtrK3xBKtLIU33Wofk2Hic9Vg
        z6A14nxA2a+tWcVM22LKs+46IFDOdJTIOK7Mokb8WpWJeJXLwgt+nY/gZFFRxwDIv+QLfZ98BWESN
        bfzKin4y3lx2Faw7Yu0loNW2LyGSsUEgzvZNBPpkgVXFKg9BrLZDYVdvc6Mxkvg+g+usjZA51BLB2
        1gFtjF+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKQrk-006OfH-2c;
        Fri, 14 Jul 2023 22:02:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FC593001FD;
        Sat, 15 Jul 2023 00:02:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29DFE245CA115; Sat, 15 Jul 2023 00:02:20 +0200 (CEST)
Date:   Sat, 15 Jul 2023 00:02:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bruno Goncalves <bgoncalv@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230714220220.GC3273303@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
 <b672c500-5f2f-d60c-84da-80269b8b420f@linux.intel.com>
 <20230714211109.GC3275140@hirez.programming.kicks-ass.net>
 <6ce7c4d8-3320-7712-a562-a43224c2602b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce7c4d8-3320-7712-a562-a43224c2602b@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:47:24PM -0700, Arjan van de Ven wrote:

> > I still don't know why this needs to be in intel_idle.
> 
> we can do a seperate idle driver; it'll still be x86 specific (since
> idle really is arch specific)...  and then the umwait parts of this
> will be Intel specific.. as well any future idle methods ..  and I'm
> not sure the AMD folks would even want it used .... at which point it
> ends up Intel specific fully and we now have 2 Intel idle drivers.  I
> don't see how that makes sense.

intel-idle is huge, the last thing it needs is yet another little driver
hidding inside it.

Creating a new simple and small x86-guest cpuidle driver seems, well,
simpler.

And the whole umwait / mwaitx thing really isn't that hard, this is all
indirect functions anyway. All that thing needs to do is amortize the
VMEXIT cost.
