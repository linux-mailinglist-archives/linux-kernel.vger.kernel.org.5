Return-Path: <linux-kernel+bounces-31723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3C833304
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFCA284FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98220FA;
	Sat, 20 Jan 2024 06:55:03 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187B71C30;
	Sat, 20 Jan 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733702; cv=none; b=XAOc7HQ0lB28PmIOdm+GqR6Xoqgy5MXb1vj0ygbx6Hy6eXYd2XjWEn7DRBLxDFHPN86cd4l1heEtpbRuyBRo4sNuiEp0WBJyZKRSmBv6wGsmI1XgABd6pWxCYD5KpxrauNhl8XJGQXitZm4X1XGYHOdzm3jxKMtwPbFhgsH7Y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733702; c=relaxed/simple;
	bh=LAz88Di/EzubOL69oIWRn1AWo1JnOQq6BCRW+uz7HC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D9yCBqtOCkMU3vwlwrO0nV5H9mnvC66CI7KlZ8wRR86YobvSXddOjaxTXGy0j1+QGzeHUa49fJVS7nfyg9bOctZnKPwgApnwcEqm79+e3OZq9cRdYInwuTzJVbHiQuuRIzOgJ90EusObFycupv3pb/vBmkruoG4BibsxCNnyfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TH6f91xFrz1xmQc;
	Sat, 20 Jan 2024 14:54:09 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B2AE140113;
	Sat, 20 Jan 2024 14:54:57 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Jan 2024 14:54:56 +0800
Message-ID: <712009f7-8bd9-eded-c02b-53620ebd0eaf@huawei.com>
Date: Sat, 20 Jan 2024 14:54:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3] ipc/mqueue: fix potential sleeping issue in
 mqueue_flush_file
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <brauner@kernel.org>, <jlayton@kernel.org>,
	<riel@surriel.com>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
	<hdanton@sina.com>, <yuehaibing@huawei.com>
References: <20240119103703.2004155-1-shaozhengchao@huawei.com>
 <CANn89iLUW5HQQT=D2qnFho5egVxFur3ao+8akSXtMx6aEux9Sg@mail.gmail.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <CANn89iLUW5HQQT=D2qnFho5egVxFur3ao+8akSXtMx6aEux9Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/19 21:09, Eric Dumazet wrote:
> On Fri, Jan 19, 2024 at 11:27 AM Zhengchao Shao
> <shaozhengchao@huawei.com> wrote:
>>
>> I analyze the potential sleeping issue of the following processes:
>> Thread A                                Thread B
>> ...                                     netlink_create  //ref = 1
>> do_mq_notify                            ...
>>    sock = netlink_getsockbyfilp          ...     //ref = 2
>>    info->notify_sock = sock;             ...
>> ...                                     netlink_sendmsg
>> ...                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
>> ...                                       netlink_unicast
>> ...                                         sk = netlink_getsockbyportid //ref = 3
>> ...                                         netlink_sendskb
>> ...                                           __netlink_sendskb
>> ...                                             skb_queue_tail //put skb to sk_receive_queue
>> ...                                         sock_put //ref = 2
>> ...                                     ...
>> ...                                     netlink_release
>> ...                                       deferred_put_nlk_sk //ref = 1
>> mqueue_flush_file
>>    spin_lock
>>    remove_notification
>>      netlink_sendskb
>>        sock_put  //ref = 0
>>          sk_free
>>            ...
>>            __sk_destruct
>>              netlink_sock_destruct
>>                skb_queue_purge  //get skb from sk_receive_queue
>>                  ...
>>                  __skb_queue_purge_reason
>>                    kfree_skb_reason
>>                      __kfree_skb
>>                      ...
>>                      skb_release_all
>>                        skb_release_head_state
>>                          netlink_skb_destructor
>>                            vfree(skb->head)  //sleeping while holding spinlock
>>
>> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
>> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
>> When the mqueue executes flush, the sleeping bug will occur. Put sock
>> after releasing the spinlock.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
Hi Eric:
> I think netlink started to use vmalloc() from commit c05cdb1b864f
> ("netlink: allow large data transfers from user-space")
> 
   Thank you for your review. Yes, you are right. Sorry for my mistake.
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v3: Put sock after releasing the spinlock.
>> v2: CCed some networking maintainer & netdev list
>> ---
>>   ipc/mqueue.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 5eea4dc0509e..4832343b7049 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -664,12 +664,23 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
>>   static int mqueue_flush_file(struct file *filp, fl_owner_t id)
>>   {
>>          struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
>> +       struct sock *sk = NULL;
>>
>>          spin_lock(&info->lock);
>> -       if (task_tgid(current) == info->notify_owner)
>> -               remove_notification(info);
>> +       if (task_tgid(current) == info->notify_owner) {
>> +               if (info->notify_owner != NULL &&
>> +                   info->notify.sigev_notify == SIGEV_THREAD) {
>> +                       sk = info->notify_sock;
>> +                       sock_hold(sk);
>> +               }
>>
>> +               remove_notification(info);
>> +       }
>>          spin_unlock(&info->lock);
>> +
>> +       if (sk)
>> +               sock_put(sk);
>> +
>>          return 0;
>>   }
>>
> 
> 
> Note that we could instead call vfree_atomic() from netlink_skb_destructor()
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 4ed8ffd58ff375f3fa9f262e6f3b4d1a1aaf2731..9c962347cf859f16fc76e4d8a2fd22cdb3d142d6
> 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -374,7 +374,7 @@ static void netlink_skb_destructor(struct sk_buff *skb)
>          if (is_vmalloc_addr(skb->head)) {
>                  if (!skb->cloned ||
>                      !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
> -                       vfree(skb->head);
> +                       vfree_atomic(skb->head);
> 
>                  skb->head = NULL;
>          }
> 
OK, I will send v4 after verification.
> These big skbs are quite rare IMO, and we also could attempt
> high-order allocations
> in netlink_alloc_large_skb(), using kvmalloc() instead of vmalloc()
> (next week when net-next opens)
> 
It looks good to me. I would like to do it if you want...
Thank you.

Zhengchao Shao

