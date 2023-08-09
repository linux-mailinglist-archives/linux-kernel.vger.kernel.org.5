Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7777620D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjHIOG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjHIOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:06:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B21FCC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pQzZAGdDiQWGg3B5mribQRObU+QUamrVuy5hZ32w/pw=; b=bqMBkZg8nAv28jDqoy3G4FASd3
        9buEoW7okjPXHMhNKzvgaQbcKFEgxrIbVs8c7hDBQMfD5mCD/NOKwP/qiQl2T+oIFFnhaxVrpvrH6
        KIQhA9004lKlCtk/zWytJ0/T5ysPsDLBi7SWYkS8AsA/4TMW48IPUFsOFD3o3pTnC7w6cxLze/tCV
        QRF2KvdPd9J6pnX7EFd4zthysvT/lWkRz0R8i5mpExJGvzmpPoaSP7ss8Nxa/odQSjJ2kUcntXA5L
        5uvz1iIpEmvbL0SKHCJsfUrACQW4b4tpv+OylQrsXdE2uYfC2ZvslyOCnm/DATJJFE0bx3L5q7e1J
        B7FTiB1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTjpl-006b0G-5g; Wed, 09 Aug 2023 14:06:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEAAE30003A;
        Wed,  9 Aug 2023 16:06:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C091B2023C23F; Wed,  9 Aug 2023 16:06:44 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:06:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Message-ID: <20230809140644.GP212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.922634286@infradead.org>
 <20230809135004.2xy76kqpptfqxsp5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809135004.2xy76kqpptfqxsp5@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:50:04AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 09:12:25AM +0200, Peter Zijlstra wrote:
> > With the difference being that UNTRAIN_RET_VM uses
> > X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.
> > 
> > This cures VMEXIT doing potentially unret+IBPB or double IBPB.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/nospec-branch.h |   11 +++++++++++
> >  arch/x86/kernel/cpu/bugs.c           |   17 ++++++++++++++++-
> >  arch/x86/kvm/svm/vmenter.S           |    7 ++-----
> >  3 files changed, 29 insertions(+), 6 deletions(-)
> > 
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -299,6 +299,17 @@
> >  #endif
> >  .endm
> >  
> > +.macro UNTRAIN_RET_VM
> > +#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
> > +	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
> 
> Maybe can be simplified?
> 

See patches 9 and 10 :-)
