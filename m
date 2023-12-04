Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3EB803A99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjLDQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:43:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8999B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:43:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98168C433C8;
        Mon,  4 Dec 2023 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701708197;
        bh=V1mySgUnMOQnDd2cfqMCPNmlYJkptWErl3Ep+QPr+jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfI4RaXSCgrisms7dzOtmSTKBnyjNFvVG8yGYptKwmhvyhEMWzt2DKdqIPf2suEYr
         ewLN21bwOqvfVP2/g5MTRXiHsr9pafzqDYiH7yhYMHdeIZjHnTV1CY24Ln4rHkdHka
         3p0rHkF94o7Qyad+nPmDNLDFK+MiH9Wh5hNsTjKyy5SzNOn3IJ12j5tM7jrV0+kEDJ
         BUiPXJAhCzWEkZhV0VOFPmThXVTMRA/GX/C7SYHbHxnQgLYGp5Qxrcj8t9o3xAirbq
         OohmweG7pUkOSm2XsX+nt9X/HIV2E3xWy7MOqNXAx1N8rpOSve74Kr/mdC8x8JRJ4F
         GcWqMza3Sbq+Q==
Date:   Mon, 4 Dec 2023 08:46:39 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] pinctrl: Add lock to ensure the state atomization
Message-ID: <wmpsnz3lhqsqglwkbr5ohrywqeufrjmtobhnprvf4o6iarc5x6@6jeuqck4n2nc>
References: <20231201152931.31161-1-quic_aiquny@quicinc.com>
 <6jlui5h7d2rs37sdvvwmii55mwhm5dzfo2m62hwt53mkx4z32a@aw5kcghe4bik>
 <4d85fda9-6e00-4bb4-b8a8-85c5e66635bf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d85fda9-6e00-4bb4-b8a8-85c5e66635bf@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:57:42PM +0800, Aiqun(Maria) Yu wrote:
> On 12/2/2023 4:39 AM, Bjorn Andersson wrote:
> > On Fri, Dec 01, 2023 at 11:29:31PM +0800, Maria Yu wrote:
> > > Currently pinctrl_select_state is an export symbol and don't have
> > > effective re-entrance protect design. And possible of pinctrl state
> > > changed during pinctrl_commit_state handling. Add per pinctrl lock to
> > > ensure the old state and new state transition atomization.
> > > Move dev error print message right before old_state pinctrl_select_state
> > > and out of lock protection to avoid console related driver call
> > > pinctrl_select_state recursively.
> > 
> > I'm uncertain about the validity of having client code call this api in
> > a racy manner. I'm likely just missing something here... It would be
> > nice if this scenario was described in a little bit more detail.
> Hi Bjorn,
> 
> we've got a customer dump that the real racy happened, and the system
> frequently have printk message like:
>   "not freeing pin xx (xxx) as part of deactivating group xxx - it is
> already used for some other setting".
> Finally the system crashed after the flood log.
> 

Sounds like we have a valid issue, but let's make sure that we
describe the problem on its technical grounds in the commit that is
upstreamed - if nothing else, so that others can determine if the
solution matches their bug reports.

> We've inform the customer to check their own client code which called this
> api, to have proper lock to avoid racy of per dev pinctrl_select_state call
> from customer driver end.
> For example:
> LOCK;
> pinctrl_select_state();

Placing a lock inside pinctrl_select_state() will not make this whole
sequence atomic, so if the client driver needs to know that the state
remains from here until the "other hardware behaviors" below, something
more is needed.

Perhaps I'm misunderstanding what you're saying though?

> gpio pulling;
> udelay();
> check state;
> other hardware behaviors;
> UNLOCK;
> 
> While it is still unnecessary the volatile re-load of p->state for the
> interation and so I upstream a patch like link[2].
> 
> while during the merge discussion, upstream maintainer suggest to have the
> lock issue fixed, instead of only READ_ONCE for the interation.
> I think it is also make sense since although current in-tree driver have
> take care of each pinctrl_select_state call, since it is a export symbole
> and we've see the similar issue continuously (a year back ago also we've
> seen similar issue before[3]).
> 

I think you're correcting a real problem, in that two contexts calling
pinctrl_select_state() seems to be able to cause non-deterministic
results. But is the motivation "pinctrl_select_state() is an
EXPORT_SYMBOL, so let's make it thread safe", or is the motivation
"during async probing of devices it's possible to end up in
pinctrl_select_state() from multiple contexts simultaneously, so make it
thread safe"?

> The whole serials discussion can be found link here:
> [1] https://lore.kernel.org/lkml/e011b3e9-7c09-4214-8e9c-90e12c38bbaa@quicinc.com/
> [2]
> https://lore.kernel.org/lkml/20231115102824.23727-1-quic_aiquny@quicinc.com/
> [3]
> https://lore.kernel.org/lkml/20221027065408.36977-1-quic_aiquny@quicinc.com/
> 
> > 
> > The recursive error print sounds like a distinct problem of its own,
> > that warrants being introduced in a patch of its own. But as with the
> > other part, I'm not able to spot a code path in the upstream kernel
> > where this hppens, so please properly describe the scenario where
> > touching the console would result back in another pinctrl_select_state().
> For this part, I am thinking about a spin lock is introduced and have the
> error log out of the lock will be safer.
> The current patch disable irq during the lock, and some console driver rely
> on interrupt to get tx dma/fifo ready.

Logging outside the region with interrupts disabled make total sense,
I'm definitely in favor of this.

> Also console driver will be a pinctrl client, so avoid unnecessary recursive
> in theory.

I don't think a console driver should pinctrl_select_state() from its
tx path, that's why I'm asking.

But perhaps I'm missing some scenario, if so please describe this in the
commit message.

> Just incase some out of tree concole driver was able to use the
> pinctrl_select_state in console write related APIs as well.

If there is a valid usage pattern I think we should consider that, but
we do not care about out-of-tree drivers misusing/abusing framework
APIs.

Regards,
Bjorn
