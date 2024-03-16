Return-Path: <linux-kernel+bounces-105012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3557D87D79A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E71F1C2148D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C731847;
	Sat, 16 Mar 2024 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gt61AtIx"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF1634;
	Sat, 16 Mar 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710549616; cv=none; b=UuXDuiBTPDPCt7TqWwb5bGmnkGM34ryrsbkHzn3Swruzs96TE1HTMYcDvoWcU3M8n3dvU4Xh8EfjVHpWTKQXy6jDukhtKvueCXfB30IqQsLtimXHzSQW+iDZQ0hLjAKcX39P6Mobs4E+4IrXsI5na1N2VSdqPokLrTccEyIo8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710549616; c=relaxed/simple;
	bh=1R7HCPgSkrcPPvyRuSGjC/CcyxD0sZhqXsEJ2j6Za8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iei6siVbArY7cq1CI7hbikOkZ/V8My9I47qBTy1ufwuf/NHc7Uue+47KUv8ccFMX5DkRlvoK66e991tZ4pd5jreKZmGZAcYBvdcDT69hUBIdR0e7MMPC3divCteekbLmE8v/TrwoPh2NkZfeZB4ARl3uI27xzojzSKDaSZVZYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gt61AtIx; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710549614; x=1742085614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=694n8E9/WPaSdUEhoCwKF5D57XcPi+Eu8sDwgxlQJNQ=;
  b=gt61AtIxXymu5rmerT50NsjWBtGAw2Tuye3gUraF+kJtZmdLvNxOUyQS
   /VXZjK6ZUZyT6c6lX02pIrLO5ms/bngMRGpUxAGPlcs+b2qbsOGCnrPUI
   6a3bciNW+9cAL6SsuYFsJK/aLU0+jRyIkIvQd93V9enoMdyQQH/y7d93S
   g=;
X-IronPort-AV: E=Sophos;i="6.07,129,1708387200"; 
   d="scan'208";a="280485267"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 00:40:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:23882]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.246:2525] with esmtp (Farcaster)
 id 5f7c01b0-6abb-4bda-bcf3-761bb5a45404; Sat, 16 Mar 2024 00:40:11 +0000 (UTC)
X-Farcaster-Flow-ID: 5f7c01b0-6abb-4bda-bcf3-761bb5a45404
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 16 Mar 2024 00:40:10 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Sat, 16 Mar 2024 00:40:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <linux@weissschuh.net>
CC: <davem@davemloft.net>, <dmitry.torokhov@gmail.com>,
	<ebiederm@xmission.com>, <edumazet@google.com>, <j.granados@samsung.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] net: always initialize sysctl ownership
Date: Fri, 15 Mar 2024 17:39:58 -0700
Message-ID: <20240316003958.65385-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net>
References: <20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Thomas Weißschuh <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 17:20:31 +0100
> The sysctl core does not initialize these fields when the set_ownership
> callback is present.
> So always do it in the callback.

Could you add few more words here to explain what the problem is
like commit 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default
values of i_uid/i_gid on /proc/sys inodes.").

BTW, it seems that we can change the value even if the uid/gid is
invalid unlike the issue mentioned in 5ec27ec735ba.

So, the problem is just the invalid uid/gid exposed to userspace
or am I missing something ?

---8<---
[root@localhost ~]# unshare --user --keep-caps
[nobody@localhost ~]$ id
uid=65534(nobody) gid=65534(nobody) groups=65534(nobody)
[nobody@localhost ~]$ unshare --net --keep-caps
[nobody@localhost ~]$ stat /proc/sys/net/core/somaxconn
  File: /proc/sys/net/core/somaxconn
  Size: 0         	Blocks: 0          IO Block: 1024   regular empty file
Device: 13h/19d	Inode: 3726        Links: 1
Access: (0644/-rw-r--r--)  Uid: (65534/  nobody)   Gid: (65534/  nobody)
Access: 2024-03-16 00:28:51.937789000 +0000
Modify: 2024-03-16 00:28:51.937789000 +0000
Change: 2024-03-16 00:28:51.937789000 +0000
 Birth: -
[nobody@localhost ~]$ cat /proc/sys/net/core/somaxconn
4096
[nobody@localhost ~]$ echo 2048 > /proc/sys/net/core/somaxconn
[nobody@localhost ~]$ cat /proc/sys/net/core/somaxconn
2048
---8<---


> 
> Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container's owner")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/sysctl_net.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> index 051ed5f6fc93..03e320ddacc9 100644
> --- a/net/sysctl_net.c
> +++ b/net/sysctl_net.c
> @@ -62,12 +62,10 @@ static void net_ctl_set_ownership(struct ctl_table_header *head,
>  	kgid_t ns_root_gid;
>  
>  	ns_root_uid = make_kuid(net->user_ns, 0);
> -	if (uid_valid(ns_root_uid))
> -		*uid = ns_root_uid;
> +	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
>  
>  	ns_root_gid = make_kgid(net->user_ns, 0);
> -	if (gid_valid(ns_root_gid))
> -		*gid = ns_root_gid;
> +	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
>  }

How about setting the default in proc_sys_make_inode() instead ?
because the default value configured by new_inode() is not
appropriate for procfs, IIUC.

Thanks!

>  
>  static struct ctl_table_root net_sysctl_root = {
> 
> ---
> base-commit: e5eb28f6d1afebed4bb7d740a797d0390bd3a357
> change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>

