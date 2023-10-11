Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FEC7C591B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjJKQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjJKQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:28:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517091
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:28:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5410C433C7;
        Wed, 11 Oct 2023 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697041725;
        bh=eLVqglcIaYXm0eePP87XMceGaZzYZyMwAu+YaWboENI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIrAbucaf0W+q5nNMsuaZdHR6B9UV+EryXYG41J9kWM9IIivmSwx9/L3XxF5n+jmC
         gliSY1yjBukF1PJSgYPTE66KzIY1it1+xQ/CdPvVL8YExPeSNG8OimghZnU9/BwGMO
         TQdJ8i9tQ9B/rkEHRsyedWjiEV+/7DpaekA16nC8cjJW4f5vrGMMWxoHyCda0S+2hC
         +e4MP8xJC8oGXEgv2dWkrBjt0DKHKYxiCWhN1817aqcx3/AZ9F6jnWkaIcGOjpbItx
         IPKQ7NlDdYzws7lKBkokkI6fU3IiSrF/dAt/W9chBFz1E+w+2FmsGKy3jdKlqzOy3e
         yf3umg9aO6Daw==
Date:   Wed, 11 Oct 2023 09:28:43 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231011162843.grv6kixw4ides6uw@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011074142.GK14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:41:42AM +0200, Peter Zijlstra wrote:
> > +++ b/tools/objtool/check.c
> > @@ -1610,6 +1610,15 @@ static int add_jump_destinations(struct objtool_file *file)
> >  			return -1;
> >  		}
> >  
> > +		/*
> > +		 * Since retpolines are in the same section as the return
> > +		 * thunk, they might not use a relocation when branching to it.
> > +		 */
> > +		if (jump_dest->sym && jump_dest->sym->return_thunk) {
> > +			add_return_call(file, insn, true);
> > +			continue;
> > +		}
> 
> *urgh*... I mean, yes, that obviously works, but should we not also have
> the retpoline thingy for consistency? That case makes less sense though
> :/

Consistency with what?  The extra section seems pointless but maybe I'm
missing something.

-- 
Josh
