Return-Path: <linux-kernel+bounces-123782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0B890DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C3229E8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3B339A0;
	Thu, 28 Mar 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="djx5LAUI"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24131D68F;
	Thu, 28 Mar 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665427; cv=none; b=QL6BcG9XXLcEKx2OVY5meytW59ai0Sp6rnjfQNHjIeL/dPw0MlL6Dv1yrt8IJlJdhaxYr0Or2c76uoslVgqvJbF3Mb7UNA/MmtknUp3J6fnQOnPPVBaFayWWaaHOIwXxi4gyFuStKWoJ0QWNeFm61J6p5kI6ap7Wr1ShG9PH7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665427; c=relaxed/simple;
	bh=xQvSGwjpy1U6i/xX+phhJvt3/ov4BDw8GZ/yLMQj2dU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4O/OD3+mKo7aNTqoiHtAnvMDtKl1l6+ava/ozWl9R5PoHdhikmepfcY1M0m5jj42OMk2lJ+kvt3CZaUizQXcJis1kGmxk6MEyTTTvGTCnlCSll0a26Qmwi5QvfMz2BP36DeVjMCUkmAZAMupGid/5hlHrHs+IY+9risyEaLRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=djx5LAUI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=acFz8ZofxmGGcr8Ugossbm6NCpv7kLhJA9jmyA4gPP0=;
	t=1711665425; x=1712875025; b=djx5LAUI7FnX5I56/ZNLZNWxFlCG0bFWh/HFUvIEYn8nM3U
	ZNzAiYoz645+29heGeoeiaYBpeNkFTBhPTwwaL1pi8YJxz/kx8c0fQAFXgCTJzDhROVCB+QJe5NNj
	s0UDHFax7KqW3RdEKKjGZUMzhAEghnwlw7Wnf/UQRQYlxx3lo27OkZ9lJZDnvGEbj1vZqr9BzJO3y
	YFmlO6+ZFoXbgddGTsrlknQRgJsohG59/VDVu7cLE7EOBWtcLFa3XhZyhJT8Hrxmd9tE8i5iADxhc
	3YG1GNC+F1dfNr7arbV0CvuGcQBs2aR1R/bSZekCxv+o5AWM4+hlo/H3L9myLJ3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpyMo-00000001QZ0-2sTv;
	Thu, 28 Mar 2024 23:37:02 +0100
Message-ID: <a67ce10d440ecaf8313e4f35832305f71d2f921c.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_open
From: Johannes Berg <johannes@sipsolutions.net>
To: syzbot <syzbot+7526b1c2ce0b9a92e9a6@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Date: Thu, 28 Mar 2024 23:37:01 +0100
In-Reply-To: <000000000000b146890614a58da4@google.com>
References: <000000000000b146890614a58da4@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 07:52 -0700, syzbot wrote:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-05204-g237bb5f7f7f5 #0 Not tainted
> ------------------------------------------------------
> syz-executor.0/7478 is trying to acquire lock:
> ffff888077110768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/n=
et/cfg80211.h:5951 [inline]
> ffff888077110768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_open+0xe7/=
0x200 net/mac80211/iface.c:449
>=20
> but task is already holding lock:
> ffff888064974d20 (team->team_lock_key#17){+.+.}-{3:3}, at: team_add_slave=
+0xad/0x2750 drivers/net/team/team.c:1973
>=20
> which lock already depends on the new lock.

Hmm.

> the existing dependency chain (in reverse order) is:
>=20
> -> #1 (team->team_lock_key#17){+.+.}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2995
>        team_device_event+0x161/0x5b0 drivers/net/team/team.c:3021
>        notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
>        call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
>        call_netdevice_notifiers net/core/dev.c:2002 [inline]
>        dev_close_many+0x33c/0x4c0 net/core/dev.c:1543
>        unregister_netdevice_many_notify+0x544/0x16d0 net/core/dev.c:11071
>        macvlan_device_event+0x7bc/0x850 drivers/net/macvlan.c:1828
>        notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
>        call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
>        call_netdevice_notifiers net/core/dev.c:2002 [inline]
>        unregister_netdevice_many_notify+0xd96/0x16d0 net/core/dev.c:11096
>        unregister_netdevice_many net/core/dev.c:11154 [inline]
>        unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11033
>        unregister_netdevice include/linux/netdevice.h:3115 [inline]
>        _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1206
>        ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2242
>        ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:202
>        rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
>        cfg80211_remove_virtual_intf+0x230/0x3f0 net/wireless/util.c:2847

So this was the interface being removed via nl80211 (why do we even do
that? rtnetlink can do that too ...)

I guess it was a team port, since team_port_get_rtnl() must've been non-
NULL for this netdev. That acquires the team->lock mutex, but we hold
the wiphy mutex around unregister_netdevice().

> -> #0 (&rdev->wiphy.mtx){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        wiphy_lock include/net/cfg80211.h:5951 [inline]
>        ieee80211_open+0xe7/0x200 net/mac80211/iface.c:449
>        __dev_open+0x2d3/0x450 net/core/dev.c:1430
>        dev_open+0xae/0x1b0 net/core/dev.c:1466
>        team_port_add drivers/net/team/team.c:1214 [inline]
>        team_add_slave+0x9b3/0x2750 drivers/net/team/team.c:1974
>        do_set_master net/core/rtnetlink.c:2685 [inline]
>        do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2891
>        __rtnl_newlink net/core/rtnetlink.c:3680 [inline]
>        rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3727
>        rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595

I guess this was actually adding it as a team slave/port, which acquired
the team->lock mutex, but do_open acquires the wiphy lock.

We _don't_ hold the wiphy mutex around dev_close() when invoked in this
path (see nl80211_del_interface), but regardless of how we delete the
interface, we will hold wiphy mutex around the unregister.

Thing is, I'm not sure I see a good way to avoid that? Maybe we could
defer the unregister, and just set the ieee80211_ptr to NULL to make it
effectively dead for wireless in the meantime. Not sure.

However, as far as I can tell it's not actually possible for the
deadlock to happen, because _both_ paths will necessarily be holding the
RTNL around them - from nl80211 (nl80211_del_interface has
NL80211_FLAG_NEED_RTNL) and rtnetlink_rcv_msg() respectively.

So ultimately, we're both holding the mutex for internal reasons, but
given the outer RTNL, I don't see how this would really deadlock.

Given that, I'm inclined to ignore this, although it'd be nice to
silence lockdep about it somehow I guess?

johannes

