Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9149803AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjLDQwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjLDQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:52:36 -0500
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCECE;
        Mon,  4 Dec 2023 08:52:40 -0800 (PST)
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:60078 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1rACBT-0003cS-Ie by authid <merlins.org> with srv_auth_plain; Mon, 04 Dec 2023 08:52:39 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1rACBT-000K5I-Bm; Mon, 04 Dec 2023 08:52:39 -0800
Date:   Mon, 4 Dec 2023 08:52:39 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ilw@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Thinkpad P17 keep hanging in ipv6_addrconf addrconf_verify_work
 / netlink in 6.4 and 6.6
Message-ID: <20231204165239.GB9208@merlins.org>
References: <20231202171326.GB24486@merlins.org>
 <20231204004003.GB29484@merlins.org>
 <20231204073515.GA9208@merlins.org>
 <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:57:44AM +0100, Johannes Berg wrote:
> this is trying to acquire the RTNL, by looking at the code
> 
> > > [  363.945566]  __rpm_callback+0x7a/0xe7
> > > [  363.945578]  rpm_callback+0x35/0x64
> > > [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > [  363.945592]  rpm_resume+0x342/0x44a
> > > [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> > > [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> > > [  363.945624]  dev_ethtool+0x15a/0x24e7
> 
> but this already holds it
> 
> So looks like bug in the 'igc' driver wrt. runtime PM locking.

Thank you for the analysis Johannes, I appreciate it. I'm at a spot
where I have to return this laptop very soon if I can't get it working
(or will get stuck with it, it's a temp one until I get my original P73
fixed, and from the little I've seen the 3 year newer P17 with I 11th
gen (10nm) instead of I 9th gen (14nm), there isn't a huge difference
between the 2, especially as my I9 had 8 cores and the I11 only 6 cores.
So I may go back to the P73 as soon as I can get it fixed).

In the meantime, anything I can try to get around that bug and confirm
that assumption? I assume that driver isn't something I can turn off
since everything depends on it, correct?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
