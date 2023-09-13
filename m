Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5C79EB4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbjIMOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:42:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8001C91;
        Wed, 13 Sep 2023 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=78e/zywheKAkHCXsMGqm/WMh0+p3InU4SR7PCIbHTG8=;
        t=1694616144; x=1695825744; b=Uf7KXfSoydcBBTVWdJYApQXm4dUud6XHE4sqWYQJ3XV3tHW
        iVYc4xxuBbBk65Cy6Yp8UdSS9XVJGlVlDr2S7NWrX8yfbvXYNu75YENVH2QkQofNk2B1xndczsWQV
        9sWcjwSg46svbJevzg1N59Bc2eUCbNREFlEaoRPBNPcr6ehRSheIIooBW/IUVsv/1yT0QkRHqET2l
        mn7pNlcCczTK/a/IsobOxl8TRCDvnloGM+TKjPyngQz5Y+tNky/V2ovaUDUrr0YpvsdqOuUqzbsiH
        xEVku0gq+PpXTvFh2iTYbPrkrAWOATNK3TJmkVnsHUF7p2Df0VPQS8zQGlHXVyMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgR3z-00F2Np-0G;
        Wed, 13 Sep 2023 16:41:55 +0200
Message-ID: <6b1c6996da5d215371e164b54e8854541dee0ded.camel@sipsolutions.net>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heyi Guo <guoheyi@linux.alibaba.com>, netdev@vger.kernel.org
Date:   Wed, 13 Sep 2023 16:41:53 +0200
In-Reply-To: <e0717628-e436-4091-8b2e-2f4dcb646ec8@roeck-us.net>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
         <YuK78Jiy12BJG/Tp@slm.duckdns.org>
         <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
         <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
         <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
         <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
         <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
         <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
         <e0717628-e436-4091-8b2e-2f4dcb646ec8@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> This patch results in the attached lockdep splat when running the
> ast2600-evb emulation in qemu with aspeed_g5_defconfig and lock debugging
> enabled. Reverting this patch fixes the problem.

Umm ... That's only true if you think the problem is the lockdep splat,
rather than the actual potential deadlock?!

> [    9.809960] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    9.810053] WARNING: possible circular locking dependency detected
> [    9.810196] 6.6.0-rc1-00004-g6faca50f629f #1 Tainted: G               =
  N

I don't have this exact tree, but on 6.6-rc1,

> [    9.810327] ------------------------------------------------------
> [    9.810406] ip/357 is trying to acquire lock:
> [    9.810501] 83af6c40 ((work_completion)(&(&dev->state_queue)->work)){+=
.+.}-{0:0}, at: __flush_work+0x40/0x550
> [    9.811052]=20
> [    9.811052] but task is already holding lock:
> [    9.811133] 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0=
x124/0x514
> [    9.811264]=20
> [    9.811264] which lock already depends on the new lock.
> [    9.811264]=20
> [    9.811361]=20
> [    9.811361] the existing dependency chain (in reverse order) is:
> [    9.811466]=20
> [    9.811466] -> #1 (rtnl_mutex){+.+.}-{3:3}:
> [    9.811616]        lock_acquire+0xfc/0x368
> [    9.811717]        __mutex_lock+0x90/0xf00
> [    9.811782]        mutex_lock_nested+0x24/0x2c
> [    9.811845]        ftgmac100_reset+0x1c/0x1dc


This does indeed take the RTNL:

static void ftgmac100_reset(struct ftgmac100 *priv)
{
        struct net_device *netdev =3D priv->netdev;
        int err;

        netdev_dbg(netdev, "Resetting NIC...\n");

        /* Lock the world */
        rtnl_lock();

and is called from

> [    9.811907]        ftgmac100_adjust_link+0xc0/0x13c
> [    9.811972]        phy_link_change+0x30/0x5c
> [    9.812035]        phy_check_link_status+0x9c/0x11c
> [    9.812100]        phy_state_machine+0x1c0/0x2c0

this work (phy_state_machine is the function), which

> [    9.812405] -> #0 ((work_completion)(&(&dev->state_queue)->work)){+.+.=
}-{0:0}:
> [    9.812531]        check_prev_add+0x128/0x15ec
> [    9.812594]        __lock_acquire+0x16ec/0x20cc
> [    9.812656]        lock_acquire+0xfc/0x368
> [    9.812712]        __flush_work+0x70/0x550
> [    9.812769]        __cancel_work_timer+0x1e4/0x264
> [    9.812833]        phy_stop+0x78/0x128

is cancelled by phy_stop() in phy_stop_machine():

void phy_stop_machine(struct phy_device *phydev)
{
        cancel_delayed_work_sync(&phydev->state_queue);

but of course that's called by the driver under RTNL:

> [    9.812889]        ftgmac100_stop+0x5c/0xac
> [    9.812949]        __dev_close_many+0xb8/0x140

(__dev_close_many requires RTNL)


So you have a potential deadlock in this driver. Yes, workqueue items
and RTNL are basically incompatible. Don't do that. Now this bug was
_probably_ added by commit 1baf2e50e48f ("drivers/net/ftgmac100: fix
DHCP potential failure with systemd") which added a call to
ftgmac100_reset() in ftgmac100_adjust_link() which is the thing called
from the PHY state machine in the first place.

Should that be reverted? I don't know ... maybe it can be fixed
differently.


But anyway ... as far as lockdep/workqueue stuff is concerned I'd
definitely call it a win rather than a bug! Yay for making lockdep
useful - it found a deadlock situation for you! :-) No need to blame
lockdep for that :P

johannes
