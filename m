Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C7777901
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjHJNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:02:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A602691
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wyn7xRMIPnfCMl/9EnypSLvyJ+97kCNC26SaBpa02q8=; b=URIyCn/i9pIh+CGtqdvj6DhIaX
        Wjv3gXd5Z9w84N6Y+9wPXG8eO+Oa1ODTGdIZI1fMVZUKCbOjJ1ZYoxH7HNrm29k7lk278W3yMaOg/
        vL/5YF4dQZ1SQGD9H1x/6rZri/sVy4SO1A9pduCKJ1PBSFiZZzuuBlPPrG0fYJ58fTQTZgQtnbuZD
        m8TwXxoG2jue0pYHozFlrnewuV/oruQNZQ9/Cr2TIxZCslVmiTun19zGqFvwYIZrDLCnMlsk6GD5g
        qlQDJXQoiRCkgnMNr4Q2iYYine6bEHZonpRLviNadcbkpaO+jJ6g1at/SxhznP9dXWpbmRf8y5aNv
        rPXM8xTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qU5J8-006Vsf-1j;
        Thu, 10 Aug 2023 13:02:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F4F830003A;
        Thu, 10 Aug 2023 15:02:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1345D2077633F; Thu, 10 Aug 2023 15:02:30 +0200 (CEST)
Date:   Thu, 10 Aug 2023 15:02:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Message-ID: <20230810130229.GA212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
 <20230809142031.jkj4pa2mhccrdmmd@treble>
 <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
 <c4c1c9b8-9ced-7282-718e-48e14375e9f1@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c1c9b8-9ced-7282-718e-48e14375e9f1@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:06:17PM +0100, Andrew.Cooper3@citrix.com wrote:
> On 09/08/2023 3:22 pm, Peter Zijlstra wrote:
> > On Wed, Aug 09, 2023 at 10:20:31AM -0400, Josh Poimboeuf wrote:
> >> On Wed, Aug 09, 2023 at 09:12:30AM +0200, Peter Zijlstra wrote:
> >>> +++ b/tools/objtool/check.c
> >>> @@ -455,7 +455,12 @@ static int decode_instructions(struct ob
> >>>  				return -1;
> >>>  			}
> >>>  
> >>> -			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
> >>> +			/*
> >>> +			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
> >>> +			 * another instruction and objtool doesn't grok that. Skip validating them.
> >>> +			 */
> >>> +			if (!strcmp(func->name, "zen_return_thunk") ||
> >>> +			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
> >> Hm, speaking of renaming they should probably be called
> >> retbleed_return_thunk() and srso_return_thunk().
> > Yes, clearly naming is better in daylight. Let me regex that.
> 
> btc_*, not retbleed_*.
> 
> That way it matches the terminology you'll find in the AMD whitepaper
> about what's going on, and there's already an entirely different issue
> called Retbleed.

So BTC as a whole is the fact that AMD predicts the type of an
instruction and then picks a predictor to predict the target of that
instruction, no?

The retbleed issue is that BTC is used to trick the thing into thinking
the RET is not a return but an indirect branch (type confusion) and then
pick the BTB predictor for a target, which got trained to point at
targer of choice.

The SRSO thing employs the same type confusion to train the RSB/RAP and
have RET, now correctly predicted to be a RET and using said RSB/RAP, to
jump to target of choice.

So in that regards, I don't think BTC is a good name for the thing.
