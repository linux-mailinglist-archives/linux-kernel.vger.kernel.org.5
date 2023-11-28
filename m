Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486B7FC692
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbjK1U6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbjK1U6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:58:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00B1735
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C3C433C7;
        Tue, 28 Nov 2023 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205089;
        bh=UX5C2qgBjiUo8YBuIWLh8l0BZcz0KqX1PVlM2d6g/Hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oV48eUKntnEzVvcv9ghdk4dk2660mtkgGC0Rq09ovnIQzNbwC5LzvTjX/pzHoS/w3
         lLE7UZJsygtUY9+gFwrkTl/tIUufnO5J+XaoPSeACsp5uhGSjr3NZlsIcqT6IMqBMt
         mUdIRT8gLBx/KVa/AsVZ5XPeuU4n/mlHj24sCUS3EfVqaO+1fYX0ZHIekyUhVvl1rw
         yJSvsUyC6LHCwm9kfTJPE/ezpij/gexK4CA3CSIK2r4EyQMTDlPD7Ff11jVcLUm388
         Kf/Ejt8CDzUL0EfvfRoTI7fZgHwjeouX3YFeY+AbNe63iOFcohuGQRLioe/DbznTix
         OpVa7ZM6cd+3Q==
Date:   Tue, 28 Nov 2023 12:58:08 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20231128125808.7a5f0028@kernel.org>
In-Reply-To: <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
        <20230607094922.43106896@kernel.org>
        <20230607171153.GA109456@thinkpad>
        <20230607104350.03a51711@kernel.org>
        <20230608123720.GC5672@thinkpad>
        <20231117070602.GA10361@thinkpad>
        <20231117162638.7cdb3e7d@kernel.org>
        <20231127060439.GA2505@thinkpad>
        <20231127084639.6be47207@kernel.org>
        <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 22:35:50 +0200 Dmitry Baryshkov wrote:
> Also, please excuse me if this was already answered, just for my understanding:
> - If we limit functionality to just networking channels which are used
> to pass IP data between host and EP, will that be accepted?

That's too hard to enforce. We have 200+ drivers, we can't carefully
review every single line of code to make sure you stick to the "just
networking" promise you make us. Plus the next guy will come and tell
us "but you let the company X do it".

> - If we were to implement the PCIe networking card running Linux (e.g.
> using Freescale PowerQUICC or Cavium Octeon chips), would you also be
> opposed to implementing the EP side of the link as the netdev?

Yes.

It's very tempting to reuse existing code, written for traffic to build
a control channel. This becomes painful because:
 - the lifetime rules for interfaces to configure vs to pass traffic 
   are different, which inevitably leads to bugs in common code,
 - the use cases are different, which leads to hacks / abuse,
   and then it's a lot harder for us to refactor and optimize core 
   code / data structures,
 - IDK how "channel to talk to FW" fits with the normal IP stack...

The "FW channel netdevs" exist for decades now, and are very popular
with middle box SDKs, I know. Your choices are:
 - keep the code out of tree,
 - use a generic interface with a strong standard definition, like
   virtio, and expect that no customizations will be allowed.
