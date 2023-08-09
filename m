Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4B776254
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHIOXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjHIOXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:23:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04BDE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YCzp2X/WfYiCqh+EX1R3WdoKCA2GK4xS3lcXZ8xjKxM=; b=jwIQauff3k9YP3RStytJYaF47n
        D5247tFWUeC0+fjcFOdf3rhR9lq5/anpoLnbzsyGzgjUC/xbXuBLX2tit1pG2H9EiHC34833vgTY3
        zvOMZOr2zNkqfH+SfKdbBEGAR52/ah7wfKXQBav/IG3rAxewm84A06BlZ29i3zJ0xcPRmigQqak2l
        315fazhW7jk78OQV9aEQRlAacPuiJYbHzEv66EbBjeifDqSp4MtSjGn4crpegwoDz0wc3xwhKYGoW
        cp3SsrCFROtaj3Bj5T5v79pCO8rNfmx0LrJP4VRX1NcwGX9tVU0wmRmS2dDJWa4pRMz5HrcVE0y2r
        iV31ek0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTk5P-005hGX-2L;
        Wed, 09 Aug 2023 14:22:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E14830003A;
        Wed,  9 Aug 2023 16:22:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CCAE201D1379; Wed,  9 Aug 2023 16:22:55 +0200 (CEST)
Date:   Wed, 9 Aug 2023 16:22:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Message-ID: <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
 <20230809142031.jkj4pa2mhccrdmmd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809142031.jkj4pa2mhccrdmmd@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:20:31AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 09:12:30AM +0200, Peter Zijlstra wrote:
> > +++ b/tools/objtool/check.c
> > @@ -455,7 +455,12 @@ static int decode_instructions(struct ob
> >  				return -1;
> >  			}
> >  
> > -			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
> > +			/*
> > +			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
> > +			 * another instruction and objtool doesn't grok that. Skip validating them.
> > +			 */
> > +			if (!strcmp(func->name, "zen_return_thunk") ||
> > +			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
> 
> Hm, speaking of renaming they should probably be called
> retbleed_return_thunk() and srso_return_thunk().

Yes, clearly naming is better in daylight. Let me regex that.
