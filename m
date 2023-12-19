Return-Path: <linux-kernel+bounces-4788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF1818210
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533081F23FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AA8832;
	Tue, 19 Dec 2023 07:15:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF5C12A;
	Tue, 19 Dec 2023 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SvSd70JD4z1wnwC;
	Tue, 19 Dec 2023 15:15:07 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D22A1A0190;
	Tue, 19 Dec 2023 15:15:20 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:15:19 +0800
Message-ID: <0678b8d2-698b-4fd1-d447-25e8fda919ec@huawei.com>
Date: Tue, 19 Dec 2023 15:15:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [RESEND PATCH] ipc/mqueue: fix potential sleeping issue in
 mqueue_flush_file
To: Jan Kara <jack@suse.cz>
CC: <gregkh@linuxfoundation.org>, <brauner@kernel.org>, <dchinner@redhat.com>,
	<jlayton@kernel.org>, <riel@surriel.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20231218030624.2490456-1-shaozhengchao@huawei.com>
 <20231218130800.2xmoadpjivejn2l5@quack3>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20231218130800.2xmoadpjivejn2l5@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2023/12/18 21:08, Jan Kara wrote:
> [CCed some networking people & netdev list since this is closely related to
> networking]
> 
> On Mon 18-12-23 11:06:24, Zhengchao Shao wrote:
>> I analyze the potential sleeping issue of the following processes:
>> Thread A                                Thread B
>> ...                                     netlink_create  //create sock
>> do_mq_notify                            ...
>>    sock = netlink_getsockbyfilp          ...     //hold sock
>>    info->notify_sock = sock;             ...
>> ...                                     netlink_sendmsg
>> ...                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
>> ...                                       netlink_unicast
>> ...                                         sk = netlink_getsockbyportid
>> ...                                         netlink_sendskb
>> ...                                           __netlink_sendskb
>> ...                                             skb_queue_tail //put skb to sk_receive_queue
>> mqueue_flush_file
>>    spin_lock
>>    remove_notification
>>      netlink_sendskb
>>        sock_put  //put sock
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
>> When the mqueue executes flush, the sleeping bug will occur. Use mutex
>> lock instead of spin lock in mqueue_flush_file.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
Hi Jan Kara:
> I guess you are not getting answers because ipc/mqueue.c has no clear
> maintainer and at least I know nothing about mqueue and only very little
> about netlink which is also involved here. Do I get it right this was
Thank you for your advice. I'll cc the maintainer in the network
field in v2.
> spotted by some checker, not really causing problems in the wild?
This is an issue with syzkaller running on the 5.10 kernel, and it
happened only once. And I analyze the mainline tree code, and there's
the same issue.
> 
> Another question (and this is why I've involved the networking people): Is
> it really possible that we end up calling sk_free() from under
> mqueue_flush_file() - at the time this is called we are closing the file
> but it is not closed yet which means the socket inode is pretty much alive
> which I'd *think* means there is still somebody holding socket reference
> and thus sock_put() will not drop the last socket reference... Am I missing
> something?
Sorry, I forgot to add the netlink release process. The following figure
shows a better explanation of how the issue occurred.

Thread A                                Thread B
...                                     netlink_create  //ref = 1
do_mq_notify                            ...
   sock = netlink_getsockbyfilp          ...     //hold sock, ref = 2
   info->notify_sock = sock;             ...
...                                     netlink_sendmsg
...                                       skb = netlink_alloc_large_skb 
//skb->head is vmalloced
...                                       netlink_unicast
...                                         sk = netlink_getsockbyportid 
//hold sock, ref = 3
...                                         netlink_sendskb
...                                           __netlink_sendskb
...                                             skb_queue_tail //put skb 
to sk_receive_queue
...					      sock_put // ref = 2
...					...
...					netlink_release
...					  deferred_put_nlk_sk //ref = 1
...					
mqueue_flush_file
   spin_lock
   remove_notification
     netlink_sendskb
       sock_put  //put sock, ref = 0
         sk_free
           ...
           __sk_destruct
             netlink_sock_destruct
               skb_queue_purge  //get skb from sk_receive_queue
                 ...
                 __skb_queue_purge_reason
                   kfree_skb_reason
                     __kfree_skb
                     ...
                     skb_release_all
                       skb_release_head_state
                         netlink_skb_destructor
                           vfree(skb->head)  //sleeping while holding 
spinlock

Isn't that a little clearer?

Thank you.

Zhengchao Shao
> 
> 								Honza
> 
>> ---
>>   ipc/mqueue.c | 48 ++++++++++++++++++++++++------------------------
>>   1 file changed, 24 insertions(+), 24 deletions(-)
>>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 5eea4dc0509e..f6f92e3f82e4 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -118,9 +118,9 @@ struct posix_msg_tree_node {
>>    * Solution: use _release and _acquire barriers.
>>    *
>>    * 3) There is intentionally no barrier when setting current->state
>> - *    to TASK_INTERRUPTIBLE: spin_unlock(&info->lock) provides the
>> + *    to TASK_INTERRUPTIBLE: mutex_unlock(&info->lock) provides the
>>    *    release memory barrier, and the wakeup is triggered when holding
>> - *    info->lock, i.e. spin_lock(&info->lock) provided a pairing
>> + *    info->lock, i.e. mutex_lock(&info->lock) provided a pairing
>>    *    acquire memory barrier.
>>    */
>>   
>> @@ -132,7 +132,7 @@ struct ext_wait_queue {		/* queue of sleeping tasks */
>>   };
>>   
>>   struct mqueue_inode_info {
>> -	spinlock_t lock;
>> +	struct mutex lock;
>>   	struct inode vfs_inode;
>>   	wait_queue_head_t wait_q;
>>   
>> @@ -312,7 +312,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
>>   		inode->i_size = FILENT_SIZE;
>>   		/* mqueue specific info */
>>   		info = MQUEUE_I(inode);
>> -		spin_lock_init(&info->lock);
>> +		mutex_init(&info->lock);
>>   		init_waitqueue_head(&info->wait_q);
>>   		INIT_LIST_HEAD(&info->e_wait_q[0].list);
>>   		INIT_LIST_HEAD(&info->e_wait_q[1].list);
>> @@ -523,11 +523,11 @@ static void mqueue_evict_inode(struct inode *inode)
>>   
>>   	ipc_ns = get_ns_from_inode(inode);
>>   	info = MQUEUE_I(inode);
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   	while ((msg = msg_get(info)) != NULL)
>>   		list_add_tail(&msg->m_list, &tmp_msg);
>>   	kfree(info->node_cache);
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   
>>   	list_for_each_entry_safe(msg, nmsg, &tmp_msg, m_list) {
>>   		list_del(&msg->m_list);
>> @@ -640,7 +640,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
>>   	char buffer[FILENT_SIZE];
>>   	ssize_t ret;
>>   
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   	snprintf(buffer, sizeof(buffer),
>>   			"QSIZE:%-10lu NOTIFY:%-5d SIGNO:%-5d NOTIFY_PID:%-6d\n",
>>   			info->qsize,
>> @@ -649,7 +649,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
>>   			 info->notify.sigev_notify == SIGEV_SIGNAL) ?
>>   				info->notify.sigev_signo : 0,
>>   			pid_vnr(info->notify_owner));
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   	buffer[sizeof(buffer)-1] = '\0';
>>   
>>   	ret = simple_read_from_buffer(u_data, count, off, buffer,
>> @@ -665,11 +665,11 @@ static int mqueue_flush_file(struct file *filp, fl_owner_t id)
>>   {
>>   	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
>>   
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   	if (task_tgid(current) == info->notify_owner)
>>   		remove_notification(info);
>>   
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   	return 0;
>>   }
>>   
>> @@ -680,13 +680,13 @@ static __poll_t mqueue_poll_file(struct file *filp, struct poll_table_struct *po
>>   
>>   	poll_wait(filp, &info->wait_q, poll_tab);
>>   
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   	if (info->attr.mq_curmsgs)
>>   		retval = EPOLLIN | EPOLLRDNORM;
>>   
>>   	if (info->attr.mq_curmsgs < info->attr.mq_maxmsg)
>>   		retval |= EPOLLOUT | EPOLLWRNORM;
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   
>>   	return retval;
>>   }
>> @@ -724,7 +724,7 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
>>   		/* memory barrier not required, we hold info->lock */
>>   		__set_current_state(TASK_INTERRUPTIBLE);
>>   
>> -		spin_unlock(&info->lock);
>> +		mutex_unlock(&info->lock);
>>   		time = schedule_hrtimeout_range_clock(timeout, 0,
>>   			HRTIMER_MODE_ABS, CLOCK_REALTIME);
>>   
>> @@ -734,7 +734,7 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
>>   			retval = 0;
>>   			goto out;
>>   		}
>> -		spin_lock(&info->lock);
>> +		mutex_lock(&info->lock);
>>   
>>   		/* we hold info->lock, so no memory barrier required */
>>   		if (READ_ONCE(ewp->state) == STATE_READY) {
>> @@ -752,7 +752,7 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
>>   	}
>>   	list_del(&ewp->list);
>>   out_unlock:
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   out:
>>   	return retval;
>>   }
>> @@ -1125,7 +1125,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>>   	if (!info->node_cache)
>>   		new_leaf = kmalloc(sizeof(*new_leaf), GFP_KERNEL);
>>   
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   
>>   	if (!info->node_cache && new_leaf) {
>>   		/* Save our speculative allocation into the cache */
>> @@ -1166,7 +1166,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>>   		simple_inode_init_ts(inode);
>>   	}
>>   out_unlock:
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   	wake_up_q(&wake_q);
>>   out_free:
>>   	if (ret)
>> @@ -1230,7 +1230,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>   	if (!info->node_cache)
>>   		new_leaf = kmalloc(sizeof(*new_leaf), GFP_KERNEL);
>>   
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   
>>   	if (!info->node_cache && new_leaf) {
>>   		/* Save our speculative allocation into the cache */
>> @@ -1242,7 +1242,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>   
>>   	if (info->attr.mq_curmsgs == 0) {
>>   		if (f.file->f_flags & O_NONBLOCK) {
>> -			spin_unlock(&info->lock);
>> +			mutex_unlock(&info->lock);
>>   			ret = -EAGAIN;
>>   		} else {
>>   			wait.task = current;
>> @@ -1261,7 +1261,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>>   
>>   		/* There is now free space in queue. */
>>   		pipelined_receive(&wake_q, info);
>> -		spin_unlock(&info->lock);
>> +		mutex_unlock(&info->lock);
>>   		wake_up_q(&wake_q);
>>   		ret = 0;
>>   	}
>> @@ -1391,7 +1391,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
>>   	info = MQUEUE_I(inode);
>>   
>>   	ret = 0;
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   	if (notification == NULL) {
>>   		if (info->notify_owner == task_tgid(current)) {
>>   			remove_notification(info);
>> @@ -1424,7 +1424,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
>>   		info->notify_user_ns = get_user_ns(current_user_ns());
>>   		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
>>   	}
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   out_fput:
>>   	fdput(f);
>>   out:
>> @@ -1470,7 +1470,7 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
>>   	inode = file_inode(f.file);
>>   	info = MQUEUE_I(inode);
>>   
>> -	spin_lock(&info->lock);
>> +	mutex_lock(&info->lock);
>>   
>>   	if (old) {
>>   		*old = info->attr;
>> @@ -1488,7 +1488,7 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
>>   		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
>>   	}
>>   
>> -	spin_unlock(&info->lock);
>> +	mutex_unlock(&info->lock);
>>   	fdput(f);
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>

