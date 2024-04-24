Return-Path: <linux-kernel+bounces-157141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A58B0D58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A5B2829C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2615EFBC;
	Wed, 24 Apr 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PN7hgq7t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DE15E802
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970567; cv=none; b=WAv8SZuDtC46jgN7svk9hvorNnJpJLS53usp5a2V09Xmj8D8rc50v1OMJDefGE6HSLY5oWNfj1m3pfhu02rrhqDIe/ce4BJesoDU5ip5bPAwSgs1u1JhqNpBnJunpPl8tI0S0jH56kA/4NPNZ9n5go3ApYPj34XUyTXGmdXX6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970567; c=relaxed/simple;
	bh=r/bsG+DahccY41ogyHB98lQZDw4WLzeIB6IRxnU5Iu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a61movllivYjWR0tn0RvNo3aOK2mK+6jidlyDhHAWWpU42P3lcyEfc6T7X55L2fKH6EpZjWVuKO9ZjLq2348p6mBpQxXGoHCfO1HnUV/uo9Nz0OHlfQ6vOYNm8c8xyVDH31bUuQbLHbiP14zNxlGUdp85R6Nv16Oqf61Mguoa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PN7hgq7t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so48658925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713970564; x=1714575364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+odfKIGSy18T3DcDdkmUycI8heuMSJ2q7o06nJf9qrc=;
        b=PN7hgq7tjmwIoaK32SrPpf9JI8upIPMz1X17buhMznmmOj2BP2UtqVUfWF2Xu+fk7B
         Y2NbmQUG7Q8exwehTab7/pDALy9dml3JC/AU+9iSfxweoaBzhis3dJCwjo9yLbTl9+3i
         uSSRnNtQFQXKp09+qGLbsxggguTXEjqu9dw/XXmzEbFe6bRQgedMQlozNozqEKukNs8F
         08B2825Fi+wOrSlIfLpQtPMCuuovGM/QwgbJ84BMOJlWg7zGiUfwY5Yx/Tqd9+wrHhAi
         vSg5si8VykdyqjumSk8lWjzjpSr2eTlb8XqDIaN2FCLjZAtAk1DX5OTfQSzEGI+8QhXR
         qEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970564; x=1714575364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+odfKIGSy18T3DcDdkmUycI8heuMSJ2q7o06nJf9qrc=;
        b=QfpqZkZLN7rryJbflwGEY78QGzWnYJLTizYIFM0Fv51O+2QQpZ3hyuA0uXQilKGwds
         Pj8xXkwNdDaGNyc7xHliu2hwA1m1deC/DziQz8odua9F/f9ZTPN96ZSvHZx34PXl95rE
         hT5b5bIh+72HW4agPzWcfvZnau83f+8h/3Go2ZTwkShms60HfDZBODj6l60nfmQ+KTfW
         lTH1olENsYs04nwRQTGDGOadm2r5Gk+ScWwBKVNXmerQ6Mzv7VhnULxbdmliYoB/teFx
         UH6ODSk32EztTrrVnrJijZVSIzeAzlbkESuy90gGRMCCYsaS3TR1F48mrQDxu8HbziUD
         SFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3T0B/dMfOyCdhbSlelWnMplmhyUg5Tu2UdRJ7vjG1RyVnIz2M7NzA+u5Zji3f2V4QRWBIhARAmc4Ub99Zwj1XYhObsvjM9jf4lv4r
X-Gm-Message-State: AOJu0YwYwyezJxwNhiO5uiBAZGTunDHFAoYjDZmjs9wXgWVc+AasevvP
	pGRKhog8ja6IUpWcCw3m31FboB0npijReSpr2EM3qCZDxj8WzPS5zjOfVOlg3SA=
X-Google-Smtp-Source: AGHT+IEaYo53TqZJYopBLHdHK0tVDo70MrJ3tDzgWV/fvnuFTB4b7aoeWM4Uy8iIZd0mOtysPisPkw==
X-Received: by 2002:a05:6a20:979a:b0:1aa:a421:4239 with SMTP id hx26-20020a056a20979a00b001aaa4214239mr2575550pzc.15.1713970564438;
        Wed, 24 Apr 2024 07:56:04 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id j17-20020aa783d1000000b006ecf00c1dd5sm11524186pfn.120.2024.04.24.07.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:56:03 -0700 (PDT)
Message-ID: <34ba3b5c-638c-4622-8bcb-a2ef74b22f69@bytedance.com>
Date: Wed, 24 Apr 2024 22:55:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] cachefiles: fix slab-use-after-free in
 cachefiles_ondemand_get_fd()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Hou Tao <houtao1@huawei.com>, zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-4-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-4-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> We got the following issue in a fuzz test of randomly issuing the restore
> command:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in cachefiles_ondemand_daemon_read+0x609/0xab0
> Write of size 4 at addr ffff888109164a80 by task ondemand-04-dae/4962
> 
> CPU: 11 PID: 4962 Comm: ondemand-04-dae Not tainted 6.8.0-rc7-dirty #542
> Call Trace:
>   kasan_report+0x94/0xc0
>   cachefiles_ondemand_daemon_read+0x609/0xab0
>   vfs_read+0x169/0xb50
>   ksys_read+0xf5/0x1e0
> 
> Allocated by task 626:
>   __kmalloc+0x1df/0x4b0
>   cachefiles_ondemand_send_req+0x24d/0x690
>   cachefiles_create_tmpfile+0x249/0xb30
>   cachefiles_create_file+0x6f/0x140
>   cachefiles_look_up_object+0x29c/0xa60
>   cachefiles_lookup_cookie+0x37d/0xca0
>   fscache_cookie_state_machine+0x43c/0x1230
>   [...]
> 
> Freed by task 626:
>   kfree+0xf1/0x2c0
>   cachefiles_ondemand_send_req+0x568/0x690
>   cachefiles_create_tmpfile+0x249/0xb30
>   cachefiles_create_file+0x6f/0x140
>   cachefiles_look_up_object+0x29c/0xa60
>   cachefiles_lookup_cookie+0x37d/0xca0
>   fscache_cookie_state_machine+0x43c/0x1230
>   [...]
> ==================================================================
> 
> Following is the process that triggers the issue:
> 
>       mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>   cachefiles_ondemand_init_object
>    cachefiles_ondemand_send_req
>     REQ_A = kzalloc(sizeof(*req) + data_len)
>     wait_for_completion(&REQ_A->done)
> 
>              cachefiles_daemon_read
>               cachefiles_ondemand_daemon_read
>                REQ_A = cachefiles_ondemand_select_req
>                cachefiles_ondemand_get_fd
>                copy_to_user(_buffer, msg, n)
>              process_open_req(REQ_A)
>                                    ------ restore ------
>                                    cachefiles_ondemand_restore
>                                    xas_for_each(&xas, req, ULONG_MAX)
>                                     xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> 
>                                    cachefiles_daemon_read
>                                     cachefiles_ondemand_daemon_read
>                                      REQ_A = cachefiles_ondemand_select_req
> 
>               write(devfd, ("copen %u,%llu", msg->msg_id, size));
>               cachefiles_ondemand_copen
>                xa_erase(&cache->reqs, id)
>                complete(&REQ_A->done)
>     kfree(REQ_A)
>                                      cachefiles_ondemand_get_fd(REQ_A)
>                                       fd = get_unused_fd_flags
>                                       file = anon_inode_getfile
>                                       fd_install(fd, file)
>                                       load = (void *)REQ_A->msg.data;
>                                       load->fd = fd;
>                                       // load UAF !!!
> 
> This issue is caused by issuing a restore command when the daemon is still
> alive, which results in a request being processed multiple times thus
> triggering a UAF. So to avoid this problem, add an additional reference
> count to cachefiles_req, which is held while waiting and reading, and then
> released when the waiting and reading is over.

Hi Baokun,
Thank you for catching this issue. Shall we fix this by following steps:
cachefiles_ondemand_fd_release()
     xas_for_each(req)
         if req is not CACHEFILES_OP_READ
             flush

cachefiles_ondemand_restore()
     xas_for_each(req)
         if req is not CACHEFILES_REQ_NEW && op is (OPEN or CLOSE)
             reset req to CACHEFILES_REQ_NEW

By implementing these steps:
1. In real daemon failover case： only pending read reqs will be
reserved. cachefiles_ondemand_select_req will reopen the object by
processing READ req.
2. In daemon alive case： Only read reqs will be reset to
CACHEFILES_REQ_NEW.


> 
> Note that since there is only one reference count for waiting, we need to
> avoid the same request being completed multiple times, so we can only
> complete the request if it is successfully removed from the xarray.
> 
> Fixes: e73fa11a356c ("cachefiles: add restore command to recover inflight ondemand read requests")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/cachefiles/internal.h |  1 +
>   fs/cachefiles/ondemand.c | 44 ++++++++++++++++++++++------------------
>   2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index d33169f0018b..7745b8abc3aa 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -138,6 +138,7 @@ static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
>   struct cachefiles_req {
>   	struct cachefiles_object *object;
>   	struct completion done;
> +	refcount_t ref;
>   	int error;
>   	struct cachefiles_msg msg;
>   };
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index fd49728d8bae..56d12fe4bf73 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -4,6 +4,12 @@
>   #include <linux/uio.h>
>   #include "internal.h"
>   
> +static inline void cachefiles_req_put(struct cachefiles_req *req)
> +{
> +	if (refcount_dec_and_test(&req->ref))
> +		kfree(req);
> +}
> +
>   static int cachefiles_ondemand_fd_release(struct inode *inode,
>   					  struct file *file)
>   {
> @@ -299,7 +305,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   {
>   	struct cachefiles_req *req;
>   	struct cachefiles_msg *msg;
> -	unsigned long id = 0;
>   	size_t n;
>   	int ret = 0;
>   	XA_STATE(xas, &cache->reqs, cache->req_id_next);
> @@ -330,41 +335,39 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
>   	cache->req_id_next = xas.xa_index + 1;
> +	refcount_inc(&req->ref);
>   	xa_unlock(&cache->reqs);
>   
> -	id = xas.xa_index;
> -
>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>   		ret = cachefiles_ondemand_get_fd(req);
>   		if (ret) {
>   			cachefiles_ondemand_set_object_close(req->object);
> -			goto error;
> +			goto out;
>   		}
>   	}
>   
> -	msg->msg_id = id;
> +	msg->msg_id = xas.xa_index;
>   	msg->object_id = req->object->ondemand->ondemand_id;
>   
>   	if (copy_to_user(_buffer, msg, n) != 0) {
>   		ret = -EFAULT;
>   		if (msg->opcode == CACHEFILES_OP_OPEN)
>   			close_fd(((struct cachefiles_open *)msg->data)->fd);
> -		goto error;
>   	}
> -
> -	/* CLOSE request has no reply */
> -	if (msg->opcode == CACHEFILES_OP_CLOSE) {
> -		xa_erase(&cache->reqs, id);
> -		complete(&req->done);
> +out:
> +	/* Remove error request and CLOSE request has no reply */
> +	if (ret || msg->opcode == CACHEFILES_OP_CLOSE) {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			req->error = ret;
> +			complete(&req->done);
> +			xas_store(&xas, NULL);
> +		}
> +		xas_unlock(&xas);
>   	}
> -
> -	return n;
> -
> -error:
> -	xa_erase(&cache->reqs, id);
> -	req->error = ret;
> -	complete(&req->done);
> -	return ret;
> +	cachefiles_req_put(req);
> +	return ret ? ret : n;
>   }
>   
>   typedef int (*init_req_fn)(struct cachefiles_req *req, void *private);
> @@ -394,6 +397,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		goto out;
>   	}
>   
> +	refcount_set(&req->ref, 1);
>   	req->object = object;
>   	init_completion(&req->done);
>   	req->msg.opcode = opcode;
> @@ -455,7 +459,7 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   	wake_up_all(&cache->daemon_pollwq);
>   	wait_for_completion(&req->done);
>   	ret = req->error;
> -	kfree(req);
> +	cachefiles_req_put(req);
>   	return ret;
>   out:
>   	/* Reset the object to close state in error handling path.

