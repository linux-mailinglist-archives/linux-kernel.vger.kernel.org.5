Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03EF791F71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbjIDWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjIDWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:10:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1959C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xahJMTjgPcQA+Fj2QnICgP77BNL3/8o+OA1c8sYTjv8=; b=cuItqygV6XF0oYfJ4TFHzRzbfn
        Svx5rirG2yw/eXov4zG+rNOCmnMK2L/71ekWM8x+wnID3Lq6c4EhHDd0amUwuCxeBeUrQGCUNL0ja
        29dji72jaP6LyHfK4m2H77xJqaJIlSxAZDZ+FE65Om1a4Kn+Y7FkUNvNgxV/XR7kCkAj3OlzznfyO
        Mui63fu6EA2yBQEt4NiDa5G2xui/1LpqMDj78/Sl6TCBjUuEl0VpxKDCCNJrdHoShJXKd1AfsDLOc
        MF0HlcpCorVkUU7vsRWoH3K/hdYrxbOtr5eT1H9nwAZfy68NMZskRemT1iaK8yoUhJgFC0X5ioeYV
        phlHDGFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdHll-002qQ5-8w; Mon, 04 Sep 2023 22:10:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E62A8300642; Tue,  5 Sep 2023 00:10:04 +0200 (CEST)
Date:   Tue, 5 Sep 2023 00:10:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        ndesaulniers@google.com, Nathan Lynch <nathanl@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Dynamically build powerpc topology
Message-ID: <20230904221004.GB2568@noisy.programming.kicks-ass.net>
References: <20230830122614.73067-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830122614.73067-1-srikar@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:56:14PM +0530, Srikar Dronamraju wrote:
> Currently there are four powerpc specific sched topologies.  These are
> all statically defined.  However not all these topologies are used by
> all powerpc systems.
> 
> To avoid unnecessary degenerations by the scheduler , masks and flags
> are compared. However if the sched topologies are build dynamically then
> the code is simpler and there are greater chances of avoiding
> degenerations.
> 
> Even x86 builds its sched topologies dynamically and new changes are
> very similar to the way x86 is building its topologies.

You're not stating it explicitly, but you're doing this as a performance
optimization, right? The x86 thing didn't particularly care about
avoiding degenerate topologies -- it's just that the fixed tables method
grew unwieldy due to combinatorics.

And how does this patch relate to the other series touching this?

  powerpc/smp: Shared processor sched optimizations

