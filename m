Return-Path: <linux-kernel+bounces-30677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FFB8322E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C1285F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAB1373;
	Fri, 19 Jan 2024 01:18:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F8EC7;
	Fri, 19 Jan 2024 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627128; cv=none; b=BeTwCem5/C+vZBZNZ6eo7jAylUDKIt/1uKffWtRjkTGEq6ch8AFP6Rrv6SN/S+0AM4n01kv10u4EFjHFHFfpggyvXbMAMC03gVEx0J8feacj0tiYP53czIe5jtEYXhBkytRFODrc3ibQIMZAOIVulwcqustVrZFL/MoT1TtyJEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627128; c=relaxed/simple;
	bh=ugkaUFaRo4cOIwX2UnpOfwNOVxesUGkcT5tyQhm4MA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JV4/HYbOd869tuwLipSfAsRj9x97eByFnQjT6En6jbEsmGCe0bl3CUzb5AzUC636qUmZc8PQSdI+Bw13vrtrQaJlG49Pdnh+VjasacTar83RvlNM/NdjUgwoXNzivHKHqkgdt/9vzKvoIBQXrpdl3I9+sGZaf5dvJKT0puMA2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TGMCn5c5vzvV9l;
	Fri, 19 Jan 2024 09:17:09 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 373FF1402DE;
	Fri, 19 Jan 2024 09:18:36 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 09:18:35 +0800
Message-ID: <4a41a867-ccfc-09e1-ebaa-9f0825bd153a@huawei.com>
Date: Fri, 19 Jan 2024 09:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] ipc/mqueue: fix potential sleeping issue in
 mqueue_flush_file
To: Hillf Danton <hdanton@sina.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>,
	<jack@suse.cz>
References: <20231220021208.2634523-1-shaozhengchao@huawei.com>
 <20240118114631.1490-1-hdanton@sina.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20240118114631.1490-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/1/18 19:46, Hillf Danton wrote:
> On 2023/12/20 10:12, Zhengchao Shao wrote:
>> I analyze the potential sleeping issue of the following processes:
>> Thread A                                Thread B
>> ...                                     netlink_create  //ref = 1
>> do_mq_notify                            ...
>>     sock = netlink_getsockbyfilp          ...     //ref = 2
>>     info->notify_sock = sock;             ...
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
>>     spin_lock
>>     remove_notification
>>       netlink_sendskb
>>         sock_put  //ref = 0
>>           sk_free
>>             ...
>>             __sk_destruct
>>               netlink_sock_destruct
>>                 skb_queue_purge  //get skb from sk_receive_queue
>>                   ...
>>                   __skb_queue_purge_reason
>>                     kfree_skb_reason
>>                       __kfree_skb
>>                       ...
>>                       skb_release_all
>>                         skb_release_head_state
>>                           netlink_skb_destructor
>>                             vfree(skb->head)  //sleeping while holding spinlock
>>
>> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
>> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
>> When the mqueue executes flush, the sleeping bug will occur. Use mutex
>> lock instead of spin lock in mqueue_flush_file.
> 
> It makes no sense to replace spinlock with mutex just for putting sock.
> 
> Only for thoughts.
> 
> --- x/ipc/mqueue.c
> +++ y/ipc/mqueue.c
> @@ -663,12 +663,17 @@ static ssize_t mqueue_read_file(struct f
>   static int mqueue_flush_file(struct file *filp, fl_owner_t id)
>   {
>   	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
> +	struct sock *sk = NULL;
>   
>   	spin_lock(&info->lock);
> -	if (task_tgid(current) == info->notify_owner)
> +	if (task_tgid(current) == info->notify_owner) {
> +		sk = info->notify_sock;
> +		sock_hold(sk);
>   		remove_notification(info);
> -
> +	}
>   	spin_unlock(&info->lock);
> +	if (sk)
> +		sock_put(sk);
>   	return 0;
>   }
>   

Hi Hillf:
	Thank you for your review. Your changes are more concise and
clear. I will send V3.

Zhengchao Shao

