Return-Path: <linux-kernel+bounces-62761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1C85255C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB5B27E40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E68610E;
	Tue, 13 Feb 2024 00:29:38 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C495660;
	Tue, 13 Feb 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784177; cv=none; b=uGwhXtraNkZAObnAZNgi3c4/nD8R2Nt87ltFPtDjovGOCzSD3nqPxctN41IoXjgP3dbUeY6oDZ65tIl0ow9kq0Z2ZVBMNydErwjmq8FDizir7FMDFairS19vyMnh1MO3NHzsj8Guh/I6xiT2O0+J4CJsK2whjSX8f08NZEuH1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784177; c=relaxed/simple;
	bh=DdLxDUXmiPLoqyv4u8dN4wHTSmvIBPFzXDc8ayrmZ4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5laEbXhjoHstQccWCOob+g9Kx0bQHyRdnWL2d/1XtpnhyS+5T8ZaTNygIrAlcs8wKL1LrupHOr8q0dpNdGcAdq5BZD3rZdcxD8T/NiO1VgcOllphWuF5xcS+59/YLpOaGLj3f5jwDXMEykfwIpSKaxR0c9K4km/tA0SYGSi+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TYhz92DX2z9sHY;
	Tue, 13 Feb 2024 01:29:25 +0100 (CET)
Message-ID: <bbd64fd9-395b-441e-be04-39440359b035@v0yd.nl>
Date: Tue, 13 Feb 2024 01:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 __hci_acl_create_connection_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
 kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com, marcel@holtmann.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <0000000000007cea730610e083e8@google.com>
 <216c95d9-db1f-487a-bf3d-17a496422485@v0yd.nl>
 <CABBYNZKPaMLK5+HnsRWR9jwpdZWvbbai6p9XbePhMYdKSYUPPg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <CABBYNZKPaMLK5+HnsRWR9jwpdZWvbbai6p9XbePhMYdKSYUPPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYhz92DX2z9sHY

Hi Luiz,

On 09.02.24 14:36, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Fri, Feb 9, 2024 at 7:37 AM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> Hi everyone!
>>
>> On 08.02.24 16:32, syzbot wrote:
>>> syzbot has bisected this issue to:
>>>
>>> commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
>>> Author: Jonas Dreßler <verdre@v0yd.nl>
>>> Date:   Tue Feb 6 11:08:13 2024 +0000
>>>
>>>       Bluetooth: hci_conn: Only do ACL connections sequentially
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f8550180000
>>> start commit:   b1d3a0e70c38 Add linux-next specific files for 20240208
>>> git tree:       linux-next
>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=174f8550180000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=134f8550180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb693ba195662a06
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f0a39be7a2035700868
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d95147e80000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c2d8fe80000
>>>
>>> Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
>>> Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequentially")
>>>
>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>
>> Hmm, looking at the backtraces, I think the issue that the introduction of the
>> sequential connect has introduced another async case: In hci_connect_acl(), when
>> we call hci_acl_create_connection_sync(), the conn state no longer immediately
>> gets set to BT_CONNECT, but remains in BT_OPEN or BT_CLOSED until the hci_sync
>> queue actually executes __hci_acl_create_connection_sync().
> 
> Need to double check but I think we do set BT_CONNECT in case of LE
> when it is queued so which shall prevent it to be queued multiple
> times.

Nope, we set it only from within the hci_sync callback, see
hci_connect_le_sync(). IMO that makes sense, because in
hci_abort_conn_sync(), we send a  HCI_OP_CREATE_CONN_CANCEL in case
of conn->state == BT_CONNECT, and this OP we wouldn't want to send
while the command is still waiting in the queue.

> 
>> This means that now hci_connect_acl() is happy to do multiple
>> hci_acl_create_connection_sync calls, and the hci_sync machinery will happily
>> execute them right after each other. Then the newly introduced hci_abort_conn_sync()
>> in __hci_acl_create_connection_sync() calls hci_conn_del() and frees the conn
>> object, so the second time we enter __hci_acl_create_connection_sync(),
>> things blow up.
>>
>> It looks to me like in theory the hci_connect_le_sync() logic is prone to a
>> similar issue, but in practice that's prohibited because in hci_connect_le_sync()
>> we lookup whether the conn object still exists and bail out if it doesn't.
>>
>> Even for LE though I think we can queue multiple hci_connect_le_sync() calls
>> and those will happily send HCI_OP_LE_CREATE_CONN no matter what the connection
>> state actually is?
>>
>> So assuming this analysis is correct, what do we do to fix this? It seems to me
>> that
>>
>> 1) we want a BT_CONNECT_QUEUED state for connections, so that the state
>> machine covers this additional stage that we have for ACL and LE connections now.
> 
> BT_CONNECT already indicates that connection procedure is in progress.

I still think an additional state is necessary. Alternatively (and maybe
a lot nicer than the extra state) would be to add some functions to hci_sync
to check for and remove queued/ongoing commands, I'm thinking of a new

bool hci_cmd_sync_has(struct hci_dev *hdev, hci_cmd_sync_work_func_t func, void *data);
void hci_cmd_sync_cancel(struct hci_dev *hdev, hci_cmd_sync_work_func_t func, void *data);

I think if we had those, in addition to not needing the additional state,
we could also simplify the hci_abort_conn() code quite a bit and possibly
get rid of the passing of connection handles to hci_connect_le_sync().

I'll give that a try and propose a small patch tomorrow.

Cheers,
Jonas

> 
>> 2) the conn object can still disappear while the __hci_acl_create_connection_sync()
>> is queued, so we need something like the "if conn doesn't exist anymore, bail out"
>> check from hci_connect_le_sync() in __hci_acl_create_connection_sync(), too.
> 
> Btw, I'd probably clean up the connect function and create something
> like hci_connect/hci_connect_sync which takes care of the details
> internally like it was done to abort.
> 
>> That said, the current check in hci_connect_le_sync() that's using the connection
>> handle to lookup the conn does not seem great, aren't these handles re-used
>> after connections are torn down?
> 
> Well we could perhaps do a lookup by pointer to see if the connection
> hasn't been removed in the meantime, that said to force a clash on the
> handles it need to happen in between abort, which frees the handle,
> and connect, anyway the real culprit here is that we should be able to
> abort the cmd_sync callback like we do in LE:
> 
> https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_conn.c#L2943
> 
> That way we stop the connect callback to run and don't have to worry
> about handle re-use.
> 
>> Cheers,
>> Jonas
> 
> 
> 

