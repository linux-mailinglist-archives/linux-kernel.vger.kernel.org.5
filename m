Return-Path: <linux-kernel+bounces-59316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1784F547
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA16B1F24C43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A7374F7;
	Fri,  9 Feb 2024 12:37:20 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174528DD3;
	Fri,  9 Feb 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482240; cv=none; b=L41mXjcog2p/7uzvSqa6kEWNKz8krzL+7+PSbGNNc8JK2+tr5Ihv+kfr9xaEKkvQoBipR1BC1owA8Gib9lw5qnGqh3bvfFjQx9+4F7O36Wvq+LXyRbs56NcE6zxUsNd+f9DLdEg4rO9Z+UnZIKzgjrPa+VA7TxDDduQmXS+PgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482240; c=relaxed/simple;
	bh=VNK68ZcMYzwD13qMNJ6bgFbcgemY4GsDe2xDQ6kje9c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=Jg5WS+Ica32Dbj1gJL/Gz50btpWTliV2VMNsfHaG6WG6p63n6UykwVua/DUm3JeD1449dsua8m+47pkhLBhJOG8IL/q4WS8jieR2jvNcC3KBuzedHvE5mWvEF77Lau282gvtdup2tN2ZppUx7qRpveXpaJ75eLL8mzFK/wScAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TWYJg4YCcz9sWY;
	Fri,  9 Feb 2024 13:37:07 +0100 (CET)
Message-ID: <216c95d9-db1f-487a-bf3d-17a496422485@v0yd.nl>
Date: Fri, 9 Feb 2024 13:37:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 __hci_acl_create_connection_sync
To: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
 kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <0000000000007cea730610e083e8@google.com>
Content-Language: en-US
Cc: verdre@v0yd.nl
In-Reply-To: <0000000000007cea730610e083e8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi everyone!

On 08.02.24 16:32, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
> Author: Jonas Dreßler <verdre@v0yd.nl>
> Date:   Tue Feb 6 11:08:13 2024 +0000
> 
>      Bluetooth: hci_conn: Only do ACL connections sequentially
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f8550180000
> start commit:   b1d3a0e70c38 Add linux-next specific files for 20240208
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=174f8550180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=134f8550180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb693ba195662a06
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f0a39be7a2035700868
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d95147e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c2d8fe80000
> 
> Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
> Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequentially")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hmm, looking at the backtraces, I think the issue that the introduction of the
sequential connect has introduced another async case: In hci_connect_acl(), when
we call hci_acl_create_connection_sync(), the conn state no longer immediately
gets set to BT_CONNECT, but remains in BT_OPEN or BT_CLOSED until the hci_sync
queue actually executes __hci_acl_create_connection_sync().

This means that now hci_connect_acl() is happy to do multiple
hci_acl_create_connection_sync calls, and the hci_sync machinery will happily
execute them right after each other. Then the newly introduced hci_abort_conn_sync()
in __hci_acl_create_connection_sync() calls hci_conn_del() and frees the conn
object, so the second time we enter __hci_acl_create_connection_sync(),
things blow up.

It looks to me like in theory the hci_connect_le_sync() logic is prone to a
similar issue, but in practice that's prohibited because in hci_connect_le_sync()
we lookup whether the conn object still exists and bail out if it doesn't.

Even for LE though I think we can queue multiple hci_connect_le_sync() calls
and those will happily send HCI_OP_LE_CREATE_CONN no matter what the connection
state actually is?

So assuming this analysis is correct, what do we do to fix this? It seems to me
that

1) we want a BT_CONNECT_QUEUED state for connections, so that the state
machine covers this additional stage that we have for ACL and LE connections now.

2) the conn object can still disappear while the __hci_acl_create_connection_sync()
is queued, so we need something like the "if conn doesn't exist anymore, bail out"
check from hci_connect_le_sync() in __hci_acl_create_connection_sync(), too.

That said, the current check in hci_connect_le_sync() that's using the connection
handle to lookup the conn does not seem great, aren't these handles re-used
after connections are torn down?

Cheers,
Jonas

