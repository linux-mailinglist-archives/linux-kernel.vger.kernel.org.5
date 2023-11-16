Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF157EDA7B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjKPDwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPDwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691DF196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:52:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B67C433C7;
        Thu, 16 Nov 2023 03:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700106729;
        bh=x/tld0bG24HZD0l3o5Zu81h7Zw9qVdRfNBu7baYafKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgW6pXb5S11/zVv3dFiPaQPNAQ7LQzEx0aSYl1R5/drSvRjxLu1sVWMos2Bk23hbh
         keeTI203WmYd4+Jd35/G7T4vuAt9zGhMfUVgCroU/W3rDKDmipf0FJJPUOnic3DDxd
         ZyGukv+jU28gNLtaPRelAnF+cVyUEaDNGg7jEx/DFzbVdJUPHDbzyN9cJmDRPhNj8X
         eyIfYhlJZZYs2Q3wXuNjo8Dzq+sqsiwulXJHo8jT/wBnGNt2ep60uTSwViuYbHMyIO
         PKlBN7xspTwuRoe2dwDdwot81CUjXCjXdrB/Z7kzjn3UDkLaGfW+EZqU+7x1zNAstp
         YC12tJ/2xW7ww==
Date:   Wed, 15 Nov 2023 22:52:01 -0500
From:   Keith Busch <kbusch@kernel.org>
To:     Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:44:04PM -0800, Yuanyuan Zhong wrote:
> On Wed, Nov 15, 2023 at 11:55 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> > > On Wed, Nov 15, 2023 at 11:02 AM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > Do you mean something like this? If not, can you please elaborate
> > > "when we need"?
> > > -               struct nvme_effects_log *cel = xa_load(&ctrl->cels, ns->head->ids.csi);
> > > +               struct nvme_effects_log *cel = (ns->head->ids.csi == NVME_CSI_NVM) ?
> > > +                       ctrl->effects : xa_load(&ctrl->cels, ns->head->ids.csi);
> > > Will it be good to change ctrl->effects to ctrl->effects[3] for
> > > already defined CSI?
> >
> > I suggest either re-assign the cached head->effects to one from a still
> > live controller when current path is removed, or move the saved effects
> > to the subsystem instead of the controller. All controllers in the
> > subsystem should be reporting the same effects log anyway, so
> Is it specified in spec that all controllers in the subsystem
> should be reporting the same effects log?

Yes, in section 5.16.1.6, "Commands Supported and Effects":

  This log page is used to describe the commands that the controller
  supports and the effects of those commands on the state of the NVM
  subsystem.

Oddly enough, Figure 202 says the scope of the log page is "Controller"
rather than "Subsystem". Sounds like ECN potential. You can memcmp the
effects log from each controller for a sanity check if you think some
subsystem controllers messed that up.
