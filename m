Return-Path: <linux-kernel+bounces-31172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD06C832A16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A3E1F2352E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280BC524CF;
	Fri, 19 Jan 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSsmsqkN"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207E51C4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669758; cv=none; b=VXJL4P1HgbUy0d/2F4pFPMVBPhdcS8y18oW04k9Hl4+yHfzhxSYOPYOx58Y/9LX+hu8kgp0eLtcBaXF6r1KoKWMfpXjlzHeZm621xZDiUf9+Oll8b/5dsUytYwl4crDtgDECj9V42a3gUiQUm4Kq/2XWvIVoQxQSw3k7J82zN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669758; c=relaxed/simple;
	bh=qkPlfZks2P9Vh3T9iswpuiEjh3iO6aPo6+dZEDRfXCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1hX8KRUjFhGbBPbtPhH9nVZdhA+wOAz9k8k6FQQIM2IDTt1pp24kcgJ5uaAbd2FZXEq01PURE7qN4ciDbMjbmcisFQLd1yL/3DORAGQJF4dEQBmO1U/RXA3o9xzs6zdViLtQ+CwGf0gQkBtQsISYMk9EcG3a1PGXWlC/knowz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSsmsqkN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso12763a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705669755; x=1706274555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig+jnJeNqQVWhFRm1hJm+CXzplL3yHV27d75fFwP10c=;
        b=XSsmsqkNc5lp4ZdM/0dme+sOjV5URuBh1ygcHXEEVtGYMEm3y92PBot1yRYvZD3t3f
         J6ecEHKrUkQ1YnCQ6EAmfBH/SSfvu9C4uXVXkwIEpPw6VKV50/OjKD38OiZwAxGJctIO
         skMGyFxm8zn/n/LP7NQkNsugImntbC4acU34xeyBFyJmzH1qBzxzZXCt5ViyIUomgkNT
         p+Zuwk9vAKfRECj8WXkNx/KwYpYNmfvWJt1tkEYSqlBk/SwQbz/g+qtLnz5ThygsEAoU
         2VAOaQbJMvlryC0cJSGecbdfKJX+xno8eIw2zH1jHEjJndP5VsmViX9+MLFQmgCUR2xb
         qMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705669755; x=1706274555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig+jnJeNqQVWhFRm1hJm+CXzplL3yHV27d75fFwP10c=;
        b=k0FlA/208hsUDOSWm5mXL+DoxaNEDqbx8UMHlh7WK4mwgOCRUzZ6TKWC1MYD9klgca
         PN9a8uwUTwZGXLJSlrmNWMUzzHc+njmY2U/xWN48wQOf7i6qrkU4Q2jJ6cnI+DhWxsuC
         BjLBDNSUf41/Xk8nlfmO4/ugEF1emAAE4MqfzEwSxVDLyJq7/sG1IyMU2TXB44vjTc89
         qNBbbCyx1jmTxe6ySqk8pjO97FQIPQt5TYGoHPHS0t+zbZF3G3qacE6WD8orE8voiZ6g
         a+a03Ui5BhLIZf+TEaTKC+lsWylh4ZrtRAXsyN6tpK8yAIXgjLb938PAEde+QbAMDydn
         k1QA==
X-Gm-Message-State: AOJu0YwaM8jqROcxgZvz23ryy5PnrGSO6J3SiIizZXpX9Ow5aAVns82x
	MF5F89QMpRPNUjeLVEusj8X0DbIQdE01FEYa5IlPjBBL5zw83Dd9JUpxp7o5Ea/Ij6w3XPlsNtq
	Pp7PSVaPE2P1z1RQOtwjm5RdudR0ii2acGVDZ
X-Google-Smtp-Source: AGHT+IF6d0dS5dvuUOQ5Omzry3Ygv9J0sIvDhZYFOttx9ZanEETUVTeIBFbfzUz5eGho2VAvZ3FdAal3lomFmDLSK+I=
X-Received: by 2002:a05:6402:1c11:b0:55a:4959:4978 with SMTP id
 ck17-20020a0564021c1100b0055a49594978mr125024edb.7.1705669754755; Fri, 19 Jan
 2024 05:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119103703.2004155-1-shaozhengchao@huawei.com>
In-Reply-To: <20240119103703.2004155-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Jan 2024 14:09:01 +0100
Message-ID: <CANn89iLUW5HQQT=D2qnFho5egVxFur3ao+8akSXtMx6aEux9Sg@mail.gmail.com>
Subject: Re: [PATCH v3] ipc/mqueue: fix potential sleeping issue in mqueue_flush_file
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, brauner@kernel.org, 
	jlayton@kernel.org, riel@surriel.com, jack@suse.cz, viro@zeniv.linux.org.uk, 
	hdanton@sina.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:27=E2=80=AFAM Zhengchao Shao
<shaozhengchao@huawei.com> wrote:
>
> I analyze the potential sleeping issue of the following processes:
> Thread A                                Thread B
> ...                                     netlink_create  //ref =3D 1
> do_mq_notify                            ...
>   sock =3D netlink_getsockbyfilp          ...     //ref =3D 2
>   info->notify_sock =3D sock;             ...
> ...                                     netlink_sendmsg
> ...                                       skb =3D netlink_alloc_large_skb=
  //skb->head is vmalloced
> ...                                       netlink_unicast
> ...                                         sk =3D netlink_getsockbyporti=
d //ref =3D 3
> ...                                         netlink_sendskb
> ...                                           __netlink_sendskb
> ...                                             skb_queue_tail //put skb =
to sk_receive_queue
> ...                                         sock_put //ref =3D 2
> ...                                     ...
> ...                                     netlink_release
> ...                                       deferred_put_nlk_sk //ref =3D 1
> mqueue_flush_file
>   spin_lock
>   remove_notification
>     netlink_sendskb
>       sock_put  //ref =3D 0
>         sk_free
>           ...
>           __sk_destruct
>             netlink_sock_destruct
>               skb_queue_purge  //get skb from sk_receive_queue
>                 ...
>                 __skb_queue_purge_reason
>                   kfree_skb_reason
>                     __kfree_skb
>                     ...
>                     skb_release_all
>                       skb_release_head_state
>                         netlink_skb_destructor
>                           vfree(skb->head)  //sleeping while holding spin=
lock
>
> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
> When the mqueue executes flush, the sleeping bug will occur. Put sock
> after releasing the spinlock.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I think netlink started to use vmalloc() from commit c05cdb1b864f
("netlink: allow large data transfers from user-space")

> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v3: Put sock after releasing the spinlock.
> v2: CCed some networking maintainer & netdev list
> ---
>  ipc/mqueue.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 5eea4dc0509e..4832343b7049 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -664,12 +664,23 @@ static ssize_t mqueue_read_file(struct file *filp, =
char __user *u_data,
>  static int mqueue_flush_file(struct file *filp, fl_owner_t id)
>  {
>         struct mqueue_inode_info *info =3D MQUEUE_I(file_inode(filp));
> +       struct sock *sk =3D NULL;
>
>         spin_lock(&info->lock);
> -       if (task_tgid(current) =3D=3D info->notify_owner)
> -               remove_notification(info);
> +       if (task_tgid(current) =3D=3D info->notify_owner) {
> +               if (info->notify_owner !=3D NULL &&
> +                   info->notify.sigev_notify =3D=3D SIGEV_THREAD) {
> +                       sk =3D info->notify_sock;
> +                       sock_hold(sk);
> +               }
>
> +               remove_notification(info);
> +       }
>         spin_unlock(&info->lock);
> +
> +       if (sk)
> +               sock_put(sk);
> +
>         return 0;
>  }
>


Note that we could instead call vfree_atomic() from netlink_skb_destructor(=
)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4ed8ffd58ff375f3fa9f262e6f3b4d1a1aaf2731..9c962347cf859f16fc76e4d8a2f=
d22cdb3d142d6
100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -374,7 +374,7 @@ static void netlink_skb_destructor(struct sk_buff *skb)
        if (is_vmalloc_addr(skb->head)) {
                if (!skb->cloned ||
                    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
-                       vfree(skb->head);
+                       vfree_atomic(skb->head);

                skb->head =3D NULL;
        }

These big skbs are quite rare IMO, and we also could attempt
high-order allocations
in netlink_alloc_large_skb(), using kvmalloc() instead of vmalloc()
(next week when net-next opens)

