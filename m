Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFF7EED3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbjKQIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjKQIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:10:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00F130
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:10:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r3tvT-0005ZF-4D; Fri, 17 Nov 2023 09:10:07 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r3tvO-009d5q-RY; Fri, 17 Nov 2023 09:10:02 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r3tvO-002Tie-O0; Fri, 17 Nov 2023 09:10:02 +0100
Date:   Fri, 17 Nov 2023 09:10:02 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ziqi Zhao <astrajoan@yahoo.com>
Cc:     ivan.orlov0322@gmail.com, edumazet@google.com,
        syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
        socketcan@hartkopp.net, bridge@lists.linux-foundation.org,
        nikolay@nvidia.com,
        syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
        roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com,
        arnd@arndb.de, syzkaller-bugs@googlegroups.com,
        mudongliangabcd@gmail.com, linux-can@vger.kernel.org,
        mkl@pengutronix.de, skhan@linuxfoundation.org, robin@protonic.nl,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        kernel@pengutronix.de, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
Message-ID: <20231117081002.GA590719@pengutronix.de>
References: <20230704064710.3189-1-astrajoan@yahoo.com>
 <20230721162226.8639-1-astrajoan@yahoo.com>
 <20230807044634.GA5736@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230807044634.GA5736@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:46:34AM +0200, Oleksij Rempel wrote:
> On Fri, Jul 21, 2023 at 09:22:26AM -0700, Ziqi Zhao wrote:
> > The following 3 locks would race against each other, causing the
> > deadlock situation in the Syzbot bug report:
> > 
> > - j1939_socks_lock
> > - active_session_list_lock
> > - sk_session_queue_lock
> > 
> > A reasonable fix is to change j1939_socks_lock to an rwlock, since in
> > the rare situations where a write lock is required for the linked list
> > that j1939_socks_lock is protecting, the code does not attempt to
> > acquire any more locks. This would break the circular lock dependency,
> > where, for example, the current thread already locks j1939_socks_lock
> > and attempts to acquire sk_session_queue_lock, and at the same time,
> > another thread attempts to acquire j1939_socks_lock while holding
> > sk_session_queue_lock.
> > 
> > NOTE: This patch along does not fix the unregister_netdevice bug
> > reported by Syzbot; instead, it solves a deadlock situation to prepare
> > for one or more further patches to actually fix the Syzbot bug, which
> > appears to be a reference counting problem within the j1939 codebase.
> > 
> > Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
> > Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
