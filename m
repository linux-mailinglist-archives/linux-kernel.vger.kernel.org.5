Return-Path: <linux-kernel+bounces-30065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BE8318A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DC31F23A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5D24201;
	Thu, 18 Jan 2024 11:47:30 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A933241E7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578449; cv=none; b=uAeAFhZCw6hziZf9BcKLf6tI9Fn2vGhuq+foaYjWKLjvrdXNgKZjr0/B124Ck1uEn74Mf0pUCjJgFaDx+acEPbiHHk3TPEDCiJ2OLy5H00UQX5LZsXqb7uAhzvhepxO5j9oQRDxsbnYrlkz6xVU0ZYxG6wnQl5Xji/u03I3Yfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578449; c=relaxed/simple;
	bh=4AZLLLj6En0qd1g7HVU8YDlmftcG2SxF4s3d6xqbXkk=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=jvrQp1wQzhxNX/58FcZbLswmXyV+YkiUnvwqLs7fjgwCN3woRZV9fWycOZrWzvFWT3BV/9wh4itXuHkf2njWA488dDGUYccSk5IrpPubw+ziQXCQZo0pPOOJ51Wn9sxBvtC9CusyiuUxVsOjhGHhfzqzbL2YHRDXelgrkQ5nMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (10.75.12.45) with ESMTP
	id 65A90FA1000003BF; Thu, 18 Jan 2024 19:46:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 28741731457794
X-SMAIL-UIID: 9A0FB41A7E02475087B772CEB43C0DD1-20240118-194644-1
From: Hillf Danton <hdanton@sina.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Manfred Spraul <manfred@colorfullife.com>,
	jack@suse.cz
Subject: Re: [PATCH v2] ipc/mqueue: fix potential sleeping issue in mqueue_flush_file
Date: Thu, 18 Jan 2024 19:46:31 +0800
Message-Id: <20240118114631.1490-1-hdanton@sina.com>
In-Reply-To: <fee3ec1c-5af6-aad2-c0d0-843de59494a7@huawei.com>
References: <20231220021208.2634523-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2023/12/20 10:12, Zhengchao Shao wrote:
> I analyze the potential sleeping issue of the following processes:
> Thread A                                Thread B
> ...                                     netlink_create  //ref = 1
> do_mq_notify                            ...
>    sock = netlink_getsockbyfilp          ...     //ref = 2
>    info->notify_sock = sock;             ...
> ...                                     netlink_sendmsg
> ...                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
> ...                                       netlink_unicast
> ...                                         sk = netlink_getsockbyportid //ref = 3
> ...                                         netlink_sendskb
> ...                                           __netlink_sendskb
> ...                                             skb_queue_tail //put skb to sk_receive_queue
> ...                                         sock_put //ref = 2
> ...                                     ...
> ...                                     netlink_release
> ...                                       deferred_put_nlk_sk //ref = 1
> mqueue_flush_file
>    spin_lock
>    remove_notification
>      netlink_sendskb
>        sock_put  //ref = 0
>          sk_free
>            ...
>            __sk_destruct
>              netlink_sock_destruct
>                skb_queue_purge  //get skb from sk_receive_queue
>                  ...
>                  __skb_queue_purge_reason
>                    kfree_skb_reason
>                      __kfree_skb
>                      ...
>                      skb_release_all
>                        skb_release_head_state
>                          netlink_skb_destructor
>                            vfree(skb->head)  //sleeping while holding spinlock
> 
> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
> When the mqueue executes flush, the sleeping bug will occur. Use mutex
> lock instead of spin lock in mqueue_flush_file.

It makes no sense to replace spinlock with mutex just for putting sock.

Only for thoughts.

--- x/ipc/mqueue.c
+++ y/ipc/mqueue.c
@@ -663,12 +663,17 @@ static ssize_t mqueue_read_file(struct f
 static int mqueue_flush_file(struct file *filp, fl_owner_t id)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
+	struct sock *sk = NULL;
 
 	spin_lock(&info->lock);
-	if (task_tgid(current) == info->notify_owner)
+	if (task_tgid(current) == info->notify_owner) {
+		sk = info->notify_sock;
+		sock_hold(sk);
 		remove_notification(info);
-
+	}
 	spin_unlock(&info->lock);
+	if (sk)
+		sock_put(sk);
 	return 0;
 }
 

