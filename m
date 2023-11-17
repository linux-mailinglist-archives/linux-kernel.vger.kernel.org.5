Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD857EF654
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjKQQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:38:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABAA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:38:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5364FC433C7;
        Fri, 17 Nov 2023 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700239102;
        bh=3MM1YohxYnrQgmM0ptEo/aF7UCmmakmOqrWmEGOq100=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VI8dahV4Mt0aY7x/ngOvr+2O7q+DqJZgFPITlqGN6kga6t4ypIugxms7RHZOhxEv1
         JkDYnVg2PVDJyIUEv2y/Ii0A8sqySjXpSII87E+YfOhcKCMM0vlaF1lUGVFGWmXtrU
         PcDpF0ZJrghl4yYSN30/cNQjnW25ejKQDt/j8d0vctLksqV1wKj7VyzgwIgRQW70wR
         K/DUNX+GHW1ueSkLasPnQVMvJbsKAUM+MvCC/9yr7CehEEkJQEgcZr0Gu9FmZegk9E
         +ZS9hlCxcpv30PbAfASky84LZCztOoFsfg3eWzlJl2qLlPMhY11MRdrSL4DzIYqcwl
         O0gtb5ivexILg==
Date:   Fri, 17 Nov 2023 09:38:19 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk>
 <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
 <20231117132846.GB7867@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117132846.GB7867@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 02:28:46PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 15, 2023 at 10:52:01PM -0500, Keith Busch wrote:
> > 
> > Yes, in section 5.16.1.6, "Commands Supported and Effects":
> > 
> >   This log page is used to describe the commands that the controller
> >   supports and the effects of those commands on the state of the NVM
> >   subsystem.
> > 
> > Oddly enough, Figure 202 says the scope of the log page is "Controller"
> > rather than "Subsystem". Sounds like ECN potential. You can memcmp the
> > effects log from each controller for a sanity check if you think some
> > subsystem controllers messed that up.
> 
> If we really want to be 111% sure we could read the effects for all
> controllers and do a logical OR of them, but I think the reason for the
> per-controller scope is that for odd subsystems where different
> controllers don't actually access the same namespaces these flags
> could be different, i.e. one that only does KV, one that does ZNS,
> one that does NVM and one that is just an administrative controller.

The effects log is per-CSI so different command sets won't create
conflicts.

Namespaces that are not shared don't really matter here because this
problem is unique to mulitpath.

It doesn't make sense for effects logs to be different per-controller
for the same shared namespace. The spec doesn't seem to explicitly
prevent that, but hints that all hosts should be seeing the same thing
no matter which controller they're connected to:

"
  If the namespace is attached to multiple controllers, the host(s)
  associated with those controllers should coordinate their commands to
  meet the Command Submission and Execution requirements
"

That couldn't be a reliable suggestion if the hosts observe diverging
effects. For the controllers that a host does see, though, I agree we
should use the most cautious effects reported with logical OR of them.
