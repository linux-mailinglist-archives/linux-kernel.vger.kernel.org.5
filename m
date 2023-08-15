Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F113177D659
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjHOWpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbjHOWoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:44:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B72111
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aEc08LpWcouwamuaKximq0m+mTxuNWTdiAQErNU9BfY=; b=cb/LL/Kr8++KweoqDPeU1qy69p
        PKu6UBTvmz2EKCIcsBsMV8D97I7fo6krM0fnmpWqwIsIpnQGtEMas+An7MXx9Um9vfTd5bFngtDPE
        aJbjc+clEzEmD7WTbMpuqHs12ixSz9sKAL1t30hwsMC+jtlV8KxYFivq7T24FAx9QGV1yw1kmLEEE
        0pQPciwCpdggFRafF/X3LWNerjoeSg0VyoojEE6Qo4A49HNCnlhEQJsAk5sgyhU71EcZA4pQFGhCk
        7YqMQCDS+p/O1H5QA5fOLDv7v37zzY7jA/gW+vvf3eCxTDBrJ0gSv7ytvwMIXW0iw7DXWzsWeRYrl
        3aMKIGpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW2lv-00AxRM-U8; Tue, 15 Aug 2023 22:44:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9438E300137;
        Wed, 16 Aug 2023 00:44:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 873AD2C16E135; Wed, 16 Aug 2023 00:44:19 +0200 (CEST)
Date:   Wed, 16 Aug 2023 00:44:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230815224419.GF971582@hirez.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <78fc3de7-9e7c-3fd0-e7d3-c94a3cc1df02@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78fc3de7-9e7c-3fd0-e7d3-c94a3cc1df02@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:49:16PM +0300, Nikolay Borisov wrote:
> 
> 
> On 14.08.23 г. 14:44 ч., Peter Zijlstra wrote:
> > Instead of making increasingly complicated ALTERNATIVE_n()
> > implementations, use a nested alternative expression.
> > 
> > The only difference between:
> > 
> >    ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)
> > 
> > and
> > 
> >    ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
> >                newinst2, flag2)
> > 
> > is that the outer alternative can add additional padding when the
> > inner alternative is the shorter one, which then results in
> > alt_instr::instrlen being inconsistent.
> > 
> > However, this is easily remedied since the alt_instr entries will be
> > consecutive and it is trivial to compute the max(alt_instr::instrlen)
> > at runtime while patching.
> > 
> > Specifically, after this patch the ALTERNATIVE_2 macro, after CPP
> > expansion (and manual layout), looks like this:
> > 
> >    .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
> >     140:
> > 
> >       140: \oldinstr ;
> >       141: .skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90 ;
> >       142: .pushsection .altinstructions,"a" ;
> > 	  altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f ;
> > 	  .popsection ; .pushsection .altinstr_replacement,"ax" ;
> >       143: \newinstr1 ;
> >       144: .popsection ; ;
> > 
> >     141: .skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90 ;
> >     142: .pushsection .altinstructions,"a" ;
> > 	altinstr_entry 140b,143f,\ft_flags2,142b-140b,144f-143f ;
> > 	.popsection ;
> > 	.pushsection .altinstr_replacement,"ax" ;
> >     143: \newinstr2 ;
> >     144: .popsection ;
> >    .endm
> > 
> > The only label that is ambiguous is 140, however they all reference
> > the same spot, so that doesn't matter.
> > 
> > NOTE: obviously only @oldinstr may be an alternative; making @newinstr
> > an alternative would mean patching .altinstr_replacement which very
> > likely isn't what is intended, also the labels will be confused in
> > that case.
> > 
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Ps. I feel very "enlightened" knowing that GAS uses -1 to represent true ...

Ah, but only sometimes ;-)
