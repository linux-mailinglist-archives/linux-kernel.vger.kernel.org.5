Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4647F7049
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345201AbjKXJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:45:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D40D68;
        Fri, 24 Nov 2023 01:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q04QX2XORVuRYVk3Q76mtdjHo7RHw4z3tLXdjxXDBbU=; b=e7f94pez0o4pH8GJtdQLvvrb/K
        QM8zbbzp0e70Ta9FPV+Fp6nlHm5hidpLRSEWjY2Mj9MGUPqRzVZF7tUFAWvcR3yKAruCCzq9M6eKh
        /hah733yG5gALgRdgiS6k3GWt7OvJXCxmq++mgZQZTDDPEmiLsb/wTaxeLQ2MjbWHBqhG/U/OhFmW
        Kpcv+ZsQMOHe4CmmpMEq/zriijNfnO0gkNRq9b9JiPvjqyKT9kNpSn4OFQwR0Bdi+bdAsvnY7W2C9
        xO2NuEbfh1YqpB7j4A19BbCBe8ApTiFZSCGczimyIVbMmhYSmNSAy97E+cl8MhWyOVczkvZOKTd5o
        /AXqbm/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6SkB-008R1y-43; Fri, 24 Nov 2023 09:45:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7155D3002BE; Fri, 24 Nov 2023 10:45:02 +0100 (CET)
Date:   Fri, 24 Nov 2023 10:45:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao.gao@intel.com, rick.p.edgecombe@intel.com,
        mlevitsk@redhat.com, john.allen@amd.com
Subject: Re: [PATCH v7 03/26] x86/fpu/xstate: Add CET supervisor mode state
 support
Message-ID: <20231124094502.GL3818@noisy.programming.kicks-ass.net>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
 <20231124055330.138870-4-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124055330.138870-4-weijiang.yang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:53:07AM -0500, Yang Weijiang wrote:

> Note, in KVM case, guest CET supervisor state i.e., IA32_PL{0,1,2}_MSRs,
> are preserved after VM-Exit until host/guest fpstates are swapped, but
> since host supervisor shadow stack is disabled, the preserved MSRs won't
> hurt host.

Just to be clear, with FRED all this changes, right? Then we get more
VMCS fields for SSS state.
