Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122FE80310D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjLDK6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjLDK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:57:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1AC0;
        Mon,  4 Dec 2023 02:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Rgr+/K/w178VZ6/C4ZZl3geFP4puFUQtC1oJjlaIDGs=;
        t=1701687469; x=1702897069; b=VTaVjTkAksCfU224mQZzERayeFXqC+IE+t1SAuhzW4p9k1o
        MsIqTvPBYtdfqShFRE9w4KX7q9K1QZpvLgAaXeMw3Qn/fEVMgbjpBrnTe2svKjy27R8/zqvU6qUrG
        eSXXvVaKwCetuoMmjx3xVzFLZatUeCgi2uEly4EbIrlL2TzKHpf1EWAxV5+QdDr6LnFQFJFzrNYjy
        G1woqh2IKmjg86QbHyP6bzf5Je9nGgfJDKRNLZIGUAW5Bxq9DEjaIPIHfOwzwXVPxsPox8HgqOSyC
        FA6ufEMqLDxb9i+2tbjbMA9VlkVIlWRfGwHqzSjEs/8q7XZ6FUqb3AEgrbGvaZkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1rA6e1-0000000Exe4-30ad;
        Mon, 04 Dec 2023 11:57:46 +0100
Message-ID: <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
Subject: Re: Thinkpad P17 keep hanging in ipv6_addrconf addrconf_verify_work
 / netlink in 6.4 and 6.6
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marc MERLIN <marc@merlins.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ilw@linux.intel.com
Cc:     "Paul E. McKenney" <paulmck@kernel.org>
Date:   Mon, 04 Dec 2023 11:57:44 +0100
In-Reply-To: <20231204073515.GA9208@merlins.org>
References: <20231202171326.GB24486@merlins.org>
         <20231204004003.GB29484@merlins.org> <20231204073515.GA9208@merlins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-12-03 at 23:35 -0800, Marc MERLIN wrote:
> So, I thought that maybe my custom built kernel had options that somehow
> made P17 unhappy, and went to a stock debian kernel.
> It's not really looking better with that kernel unfortunately :-/
>=20
> Still seems unhappy with networking, first wireless and then ethtool.
> Adding wireless lists to Cc just in case

Well clearly something is not unlocking the RTNL, but digging through
the below I only found places that want to acquire the RTNL and wait
forever on it (including wireless), but none that actually got stuck
while having it acquired already.


Actually ... no that's wrong.

I can:

> > [  363.945427] INFO: task powertop:6279 blocked for more than 120 secon=
ds.
> > [  363.945446]       Tainted: G     U             6.6.3-amd64-preempt-s=
ysrq-20220227 #4
> > [  363.945452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> > [  363.945456] task:powertop        state:D stack:0     pid:6279  ppid:=
6267   flags:0x00004002
> > [  363.945468] Call Trace:
> > [  363.945473]  <TASK>
> > [  363.945481]  __schedule+0xba0/0xc05
> > [  363.945497]  schedule+0x95/0xce
> > [  363.945504]  schedule_preempt_disabled+0x15/0x22
> > [  363.945511]  __mutex_lock.constprop.0+0x18b/0x291
> > [  363.945520]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > [  363.945531]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c9599226ac=
d0eeb7de577b7]

this is trying to acquire the RTNL, by looking at the code

> > [  363.945566]  __rpm_callback+0x7a/0xe7
> > [  363.945578]  rpm_callback+0x35/0x64
> > [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > [  363.945592]  rpm_resume+0x342/0x44a
> > [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> > [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> > [  363.945624]  dev_ethtool+0x15a/0x24e7

but this already holds it

So looks like bug in the 'igc' driver wrt. runtime PM locking.

johannes

