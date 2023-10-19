Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3577CF505
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbjJSKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345273AbjJSKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:21:21 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798F11F;
        Thu, 19 Oct 2023 03:21:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71BA56000B;
        Thu, 19 Oct 2023 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697710877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2ydsXXBaNBGMFpju1QSEdkFSa9tXDTzQRBfxsG6otY=;
        b=i7n7Db79nY/VWXnDbI9SYtt/qtDyAdtROrcJASSglaQq0S4kA0BCkd9sH+O7h8PCbPWgRZ
        BpXnW+ddcdjoh8XF0Jfvl+SSKd8up7VDJ33nVsqTqeyOPogF8KIE627ydCwtKPpHU+RoBv
        KEi8ACvEKF0qNEIXM7RYM2UDSL5qcQIoLZ+yoDDivxUHAAF13DeItCECs0Og7eLXlxPt1M
        nmzbaaPynO6UmIY5CrH86Swy4LVOalHZaHWCJQA6lAPi1ILMRTfJuBZTTIeedopl1nQIIL
        7YZtXtrsK7P+/y0jfv43LjGtkmThadBK6WfQviqnJzZs4wLIqhnPfW5JF+Z6yQ==
Date:   Thu, 19 Oct 2023 12:21:14 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
In-Reply-To: <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
        <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
        <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 11:51:40 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Thu, Oct 19, 2023 at 11:05:10AM +0200, Michal Kubecek wrote:
> > On Thu, Oct 19, 2023 at 09:09:04AM +0200, Oleksij Rempel wrote:  
> > > With current kernel it is possible to set flags, but not possible to
> > > remove existing WoL flags. For example:
> > > ~$ ethtool lan2
> > > ...
> > >         Supports Wake-on: pg
> > >         Wake-on: d
> > > ...
> > > ~$ ethtool -s lan2 wol gp
> > > ~$ ethtool lan2
> > > ...
> > >         Wake-on: pg
> > > ...
> > > ~$ ethtool -s lan2 wol d
> > > ~$ ethtool lan2
> > > ...
> > >         Wake-on: pg
> > > ...
> > >   
> > 
> > How recent was the kernel where you encountered the issue? I suspect the
> > issue might be related to recent 108a36d07c01 ("ethtool: Fix mod state
> > of verbose no_mask bitset"), I'll look into it closer.  
> 
> The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
> mod state of verbose no_mask bitset"). The problem is that a "no mask"
> verbose bitset only contains bit attributes for bits to be set. This
> worked correctly before this commit because we were always updating
> a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
> verbose no_mask bitset"), that is) so that the rest was left zero
> naturally. But now the 1->0 change (old_val is true, bit not present in
> netlink nest) no longer works.

Doh I had not seen this issue! Thanks you for reporting it.
I will send the revert then and will update the fix for next merge-window.

> To fix the issue while keeping more precise modification tracking
> introduced by commit 108a36d07c01 ("ethtool: Fix mod state of verbose
> no_mask bitset"), we would have to either iterate through all possible
> bits in "no mask" case or update a temporary zero bitmap and then set
> mod by comparing it to the original (and rewrite the target if they
> differ). This is exactly what I was trying to avoid from the start but
> it wouldn't be more complicated than current code.
> 
> As we are rather late in the 6.6 cycle (rc6 out), the safest solution
> seems to be reverting commit 108a36d07c01 ("ethtool: Fix mod state of
> verbose no_mask bitset") in net tree as sending a notification even on
> a request which turns out to be no-op is not a serious problem (after
> all, this is what happens for ioctl requests most of the time and IIRC
> there are more cases where it happens for netlink requests). Then we can
> fix the change detection properly in net-next in the way proposed in
> previous paragraph (I would prefer not risking more intrusive changes at
> this stage).
