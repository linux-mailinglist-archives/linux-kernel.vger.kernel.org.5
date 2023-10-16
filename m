Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF67CAB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjJPOaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJPOaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:30:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65E9C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/JtpSz8CEkmRWnZdqd1OQD4JeY2o/nJxZnD6jFtD5k=; b=LrTFuBbdE5IjuU1lZ/JnjiSAOK
        vAifrVSR8wcZtnJ3q8249rp+3LjtarQIJvV1EJwPZMMuKyXz95KOH4/Cic8L8Fr5iOw/814PXQKVB
        Mnh3DAEDMscwj+00gC1w4wDa1OqNj+Fq/Lw8EVCd2YWoc2kJHbpeS9JFvjSAiD6QmdR6yIIueE0Up
        suCBe6lp5qxZkX+E5UJIZJCRoc4oy5uaYFWhV5B2epDO3j+m7hVydzduAxckPofRg59aXuAKhTsqj
        NvjkBgPgC4Fo5+1RSFqD8OK4rbMn38W+0HHlPaLE2bh7P2kNfQSKpemB8/pGIz2Wpmj+qZsLOR/go
        jL0P7fZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsOb3-0066HR-18;
        Mon, 16 Oct 2023 14:29:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 740E9300513; Mon, 16 Oct 2023 16:29:30 +0200 (CEST)
Date:   Mon, 16 Oct 2023 16:29:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Subject: Re: [PATCH v2 3/4] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Message-ID: <20231016142930.GE33217@noisy.programming.kicks-ass.net>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016123933.17284-4-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:39:32PM +0200, Juergen Gross wrote:
> Instead of stacking alternative and paravirt patching, use the new
> ALT_FLAG_CALL flag to switch those mixed calls to pure alternative
> handling.
> 
> This eliminates the need to be careful regarding the sequence of
> alternative and paravirt patching.
> 
> For call depth tracking callthunks_setup() needs to be adapted to patch
> calls at alternative patching sites instead of paravirt calls.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

I cannot help but feel this would've been better as two patches, one
introducing ALT_NOT_XEN and then a second with the rest.

Regardless,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
