Return-Path: <linux-kernel+bounces-29615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2E8310D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910DC1C213C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6863B5;
	Thu, 18 Jan 2024 01:20:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E533E9;
	Thu, 18 Jan 2024 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540816; cv=none; b=CwvdPrbCfiC9Z7ELPt8QsVofRIlCtL4dLaEqnATuypLv5nkfvbF/C9Q0ryKY3AwttfcjWfm7PltQmpakWNWYl/5I4S68RSLv6p/njPSZa3jjLEV8/3uzezPmy9ppnHN/HFykbb0szkHV/IKvYQb9RpBXHU+Dte+kXqe8fNCtiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540816; c=relaxed/simple;
	bh=+Zr7iuLKpMQpf31VQHuEgphHHxAFqLklbztE2/fII4Q=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:CC:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy; b=bZXajsB3yZywho0ro9hb5ozyx6qGu8aHzUOr/uuYk46qY45L+40Y5/yjaWNf3yDTRjbgUjl0Wh5ydf/5QVxP0ATQ52tQV6zU+Ebart4xThB9JhIqvMxjm5b/SD089Qp8Q6QZ3UYr8tTpo2PwCtFFhrqJ0NDRwz/mpAKbXmvJ5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TFlJg6PYkzsWDJ;
	Thu, 18 Jan 2024 09:19:15 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 631981404F7;
	Thu, 18 Jan 2024 09:20:10 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 09:20:09 +0800
Message-ID: <401bea75-c28c-da6d-7b41-3c1e01160dff@huawei.com>
Date: Thu, 18 Jan 2024 09:20:09 +0800
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
From: shaozhengchao <shaozhengchao@huawei.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <brauner@kernel.org>, <dchinner@redhat.com>,
	<jlayton@kernel.org>, <jack@suse.cz>, <riel@surriel.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231220021208.2634523-1-shaozhengchao@huawei.com>
 <fee3ec1c-5af6-aad2-c0d0-843de59494a7@huawei.com>
In-Reply-To: <fee3ec1c-5af6-aad2-c0d0-843de59494a7@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)

++ping

Does anyone have ideas with this patch?

On 2024/1/2 9:09, shaozhengchao wrote:
> +ping
> 
> Does anyone have ideas with this patch?
> 
> On 2023/12/20 10:12, Zhengchao Shao wrote:
>> I analyze the potential sleeping issue of the following processes:
>> Thread A                                Thread B
>> ...                                     netlink_create  //ref = 1
>> do_mq_notify                            ...
>>    sock = netlink_getsockbyfilp          ...     //ref = 2
>>    info->notify_sock = sock;             ...
>> ...                                     netlink_sendmsg
>> ...                                       skb = 
>> netlink_alloc_large_skb  //skb->head is vmalloced
>> ...                                       netlink_unicast
>> ...                                         sk = 
>> netlink_getsockbyportid //ref = 3
>> ...                                         netlink_sendskb
>> ...                                           __netlink_sendskb
>> ...                                             skb_queue_tail //put 
>> skb to sk_receive_queue
>> ...                                         sock_put //ref = 2
>> ...                                     ...
>> ...                                     netlink_release
>> ...                                       deferred_put_nlk_sk //ref = 1
>> mqueue_flush_file
>>    spin_lock
>>    remove_notification
>>      netlink_sendskb
>>        sock_put  //ref = 0
>>          sk_free
>>            ...
>>            __sk_destruct
>>              netlink_sock_destruct
>>                skb_queue_purge  //get skb from sk_receive_queue
>>                  ...
>>                  __skb_queue_purge_reason
>>                    kfree_skb_reason
>>                      __kfree_skb
>>                      ...
>>                      skb_release_all
>>                        skb_release_head_state
>>                          netlink_skb_destructor
>>                            vfree(skb->head)  //sleeping while holding 
>> spinlock
>>
>> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
>> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
>> When the mqueue executes flush, the sleeping bug will occur. Use mutex
>> lock instead of spin lock in mqueue_flush_file.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: CCed some networking maintainer & netdev list
>> ---
>>   ipc/mqueue.c | 48 ++++++++++++++++++++++++------------------------
>>   1 file changed, 24 insertions(+), 24 deletions(-)
>>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 5eea4dc0509e..f6f92e3f82e4 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -118,9 +118,9 @@ struct posix_msg_tree_node {
>>    * Solution: use _release and _acquire barriers.
>>    *
>>    * 3) There is intentionally no barrier when setting current->state
>> - *    to TASK_INTERRUPTIBLE: spin_unlock(&info->lock) provides the
>> + *    to TASK_INTERRUPTIBLE: mutex_unlock(&info->lock) provides the
>>    *    release memory barrier, and the wakeup is triggered when holding
>> - *    info->lock, i.e. spin_lock(&info->lock) provided a pairing
>> + *    info->lock, i.e. mutex_lock(&info->lock) provided a pairing
>>    *    acquire memory barrier.
>>    */
>> @@ -132,7 +132,7 @@ struct ext_wait_queue {        /* queue of 
>> sleeping tasks */
>>   };
>>   struct mqueue_inode_info {
>> -    spinlock_t lock;
>> +    struct mutex lock;
>>       struct inode vfs_inode;
>>       wait_queue_head_t wait_q;
>> @@ -312,7 +312,7 @@ static struct inode *mqueue_get_inode(struct 
>> super_block *sb,
>>           inode->i_size = FILENT_SIZE;
>>           /* mqueue specific info */
>>           info = MQUEUE_I(inode);
>> -        spin_lock_init(&info->lock);
>> +        mutex_init(&info->lock);
>>           init_waitqueue_head(&info->wait_q);
>>           INIT_LIST_HEAD(&info->e_wait_q[0].list);
>>           INIT_LIST_HEAD(&info->e_wait_q[1].list);
>> @@ -523,11 +523,11 @@ static void mqueue_evict_inode(struct inode *inode)
>>       ipc_ns = get_ns_from_inode(inode);
>>       info = MQUEUE_I(inode);
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       while ((msg = msg_get(info)) != NULL)
>>           list_add_tail(&msg->m_list, &tmp_msg);
>>       kfree(info->node_cache);
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>       list_for_each_entry_safe(msg, nmsg, &tmp_msg, m_list) {
>>           list_del(&msg->m_list);
>> @@ -640,7 +640,7 @@ static ssize_t mqueue_read_file(struct file *filp, 
>> char __user *u_data,
>>       char buffer[FILENT_SIZE];
>>       ssize_t ret;
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       snprintf(buffer, sizeof(buffer),
>>               "QSIZE:%-10lu NOTIFY:%-5d SIGNO:%-5d NOTIFY_PID:%-6d\n",
>>               info->qsize,
>> @@ -649,7 +649,7 @@ static ssize_t mqueue_read_file(struct file *filp, 
>> char __user *u_data,
>>                info->notify.sigev_notify == SIGEV_SIGNAL) ?
>>                   info->notify.sigev_signo : 0,
>>               pid_vnr(info->notify_owner));
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>       buffer[sizeof(buffer)-1] = '\0';
>>       ret = simple_read_from_buffer(u_data, count, off, buffer,
>> @@ -665,11 +665,11 @@ static int mqueue_flush_file(struct file *filp, 
>> fl_owner_t id)
>>   {
>>       struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       if (task_tgid(current) == info->notify_owner)
>>           remove_notification(info);
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>       return 0;
>>   }
>> @@ -680,13 +680,13 @@ static __poll_t mqueue_poll_file(struct file 
>> *filp, struct poll_table_struct *po
>>       poll_wait(filp, &info->wait_q, poll_tab);
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       if (info->attr.mq_curmsgs)
>>           retval = EPOLLIN | EPOLLRDNORM;
>>       if (info->attr.mq_curmsgs < info->attr.mq_maxmsg)
>>           retval |= EPOLLOUT | EPOLLWRNORM;
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>       return retval;
>>   }
>> @@ -724,7 +724,7 @@ static int wq_sleep(struct mqueue_inode_info 
>> *info, int sr,
>>           /* memory barrier not required, we hold info->lock */
>>           __set_current_state(TASK_INTERRUPTIBLE);
>> -        spin_unlock(&info->lock);
>> +        mutex_unlock(&info->lock);
>>           time = schedule_hrtimeout_range_clock(timeout, 0,
>>               HRTIMER_MODE_ABS, CLOCK_REALTIME);
>> @@ -734,7 +734,7 @@ static int wq_sleep(struct mqueue_inode_info 
>> *info, int sr,
>>               retval = 0;
>>               goto out;
>>           }
>> -        spin_lock(&info->lock);
>> +        mutex_lock(&info->lock);
>>           /* we hold info->lock, so no memory barrier required */
>>           if (READ_ONCE(ewp->state) == STATE_READY) {
>> @@ -752,7 +752,7 @@ static int wq_sleep(struct mqueue_inode_info 
>> *info, int sr,
>>       }
>>       list_del(&ewp->list);
>>   out_unlock:
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>   out:
>>       return retval;
>>   }
>> @@ -1125,7 +1125,7 @@ static int do_mq_timedsend(mqd_t mqdes, const 
>> char __user *u_msg_ptr,
>>       if (!info->node_cache)
>>           new_leaf = kmalloc(sizeof(*new_leaf), GFP_KERNEL);
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       if (!info->node_cache && new_leaf) {
>>           /* Save our speculative allocation into the cache */
>> @@ -1166,7 +1166,7 @@ static int do_mq_timedsend(mqd_t mqdes, const 
>> char __user *u_msg_ptr,
>>           simple_inode_init_ts(inode);
>>       }
>>   out_unlock:
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>       wake_up_q(&wake_q);
>>   out_free:
>>       if (ret)
>> @@ -1230,7 +1230,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char 
>> __user *u_msg_ptr,
>>       if (!info->node_cache)
>>           new_leaf = kmalloc(sizeof(*new_leaf), GFP_KERNEL);
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       if (!info->node_cache && new_leaf) {
>>           /* Save our speculative allocation into the cache */
>> @@ -1242,7 +1242,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char 
>> __user *u_msg_ptr,
>>       if (info->attr.mq_curmsgs == 0) {
>>           if (f.file->f_flags & O_NONBLOCK) {
>> -            spin_unlock(&info->lock);
>> +            mutex_unlock(&info->lock);
>>               ret = -EAGAIN;
>>           } else {
>>               wait.task = current;
>> @@ -1261,7 +1261,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char 
>> __user *u_msg_ptr,
>>           /* There is now free space in queue. */
>>           pipelined_receive(&wake_q, info);
>> -        spin_unlock(&info->lock);
>> +        mutex_unlock(&info->lock);
>>           wake_up_q(&wake_q);
>>           ret = 0;
>>       }
>> @@ -1391,7 +1391,7 @@ static int do_mq_notify(mqd_t mqdes, const 
>> struct sigevent *notification)
>>       info = MQUEUE_I(inode);
>>       ret = 0;
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       if (notification == NULL) {
>>           if (info->notify_owner == task_tgid(current)) {
>>               remove_notification(info);
>> @@ -1424,7 +1424,7 @@ static int do_mq_notify(mqd_t mqdes, const 
>> struct sigevent *notification)
>>           info->notify_user_ns = get_user_ns(current_user_ns());
>>           inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
>>       }
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>   out_fput:
>>       fdput(f);
>>   out:
>> @@ -1470,7 +1470,7 @@ static int do_mq_getsetattr(int mqdes, struct 
>> mq_attr *new, struct mq_attr *old)
>>       inode = file_inode(f.file);
>>       info = MQUEUE_I(inode);
>> -    spin_lock(&info->lock);
>> +    mutex_lock(&info->lock);
>>       if (old) {
>>           *old = info->attr;
>> @@ -1488,7 +1488,7 @@ static int do_mq_getsetattr(int mqdes, struct 
>> mq_attr *new, struct mq_attr *old)
>>           inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
>>       }
>> -    spin_unlock(&info->lock);
>> +    mutex_unlock(&info->lock);
>>       fdput(f);
>>       return 0;
>>   }
> 

