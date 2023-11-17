Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C27EF3B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjKQN2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQN2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:28:52 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFED5101
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:28:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 39D486732D; Fri, 17 Nov 2023 14:28:46 +0100 (CET)
Date:   Fri, 17 Nov 2023 14:28:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <20231117132846.GB7867@lst.de>
References: <20231115185439.2616073-1-yzhong@purestorage.com> <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com> <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com> <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:52:01PM -0500, Keith Busch wrote:
> 
> Yes, in section 5.16.1.6, "Commands Supported and Effects":
> 
>   This log page is used to describe the commands that the controller
>   supports and the effects of those commands on the state of the NVM
>   subsystem.
> 
> Oddly enough, Figure 202 says the scope of the log page is "Controller"
> rather than "Subsystem". Sounds like ECN potential. You can memcmp the
> effects log from each controller for a sanity check if you think some
> subsystem controllers messed that up.

If we really want to be 111% sure we could read the effects for all
controllers and do a logical OR of them, but I think the reason for the
per-controller scope is that for odd subsystems where different
controllers don't actually access the same namespaces these flags
could be different, i.e. one that only does KV, one that does ZNS,
one that does NVM and one that is just an administrative controller.

