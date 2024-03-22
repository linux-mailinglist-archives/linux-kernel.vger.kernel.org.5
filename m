Return-Path: <linux-kernel+bounces-112059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD2A8874B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F12283BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B84D8174F;
	Fri, 22 Mar 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="borZRU/G"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23680629;
	Fri, 22 Mar 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145277; cv=none; b=WNcD/eH7wEXoU1Jv95hBdJzohyn5tXIFG9No/jJXYmbfh5VGxzW5sQTHlfBLT9xi6b8d2qoC+JyJWVs54+tcRQHvJ5hlPy9Vrr3TcxygIj46eyM5wmS6aS+k1Vl18A4SLSenPrEeDDdJy3WB22vb+Qeej5DRxfT3dwxVZto9P9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145277; c=relaxed/simple;
	bh=6hrbMTOU1EYyulynZyTwGilqoefgMexug9LPZylnaWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMKyV54M8MmPBLvxgN8mkjmo87J49qrD2hlWT+4V3kXCEVf7+z1tFycHIIQDtUzPnHhKTJJLoEvB9PrwmVG5WxfGE1t5rDWFh7MzGISM3bbk3dmjoT8NgADqQ6dLSlJ/G7p07gPfS2mQqPSYuGvl6RwtA9HGlaGLyw6HUN0WFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=borZRU/G; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711145272; x=1742681272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/WOCoJGg/LvM9qqN1EvQhSNHgEtToPxH0fvwMToOoI=;
  b=borZRU/GF7TZu7uxHo6uS6nBDZG1DkpLAK6YnfAgNHENLrSABMOSCIBn
   waPvSrn1+sOxT6FjK9ax2NgZzAFrIngAqhrakzwy+ofgbxgLVFz3nH7vc
   uX4r6wdtOhai/WUTNBhR9uX4BlmXofZdiQt3DoWwQb40GtmMvYZ7A7X8c
   0=;
X-IronPort-AV: E=Sophos;i="6.07,147,1708387200"; 
   d="scan'208";a="75530079"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 22:07:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:49113]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.55:2525] with esmtp (Farcaster)
 id d4817f84-8b84-4d23-be95-419932aa795a; Fri, 22 Mar 2024 22:07:50 +0000 (UTC)
X-Farcaster-Flow-ID: d4817f84-8b84-4d23-be95-419932aa795a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 22:07:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 22:07:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <linux@weissschuh.net>
CC: <davem@davemloft.net>, <dmitry.torokhov@gmail.com>,
	<ebiederm@xmission.com>, <edumazet@google.com>, <j.granados@samsung.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<mcgrof@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] fs/proc/proc_sysctl.c: always initialize i_uid/i_gid
Date: Fri, 22 Mar 2024 15:07:36 -0700
Message-ID: <20240322220736.77465-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240322-sysctl-net-ownership-v2-1-a8b4a3306542@weissschuh.net>
References: <20240322-sysctl-net-ownership-v2-1-a8b4a3306542@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Thomas Weißschuh" <linux@weissschuh.net>
Date: Fri, 22 Mar 2024 20:51:11 +0100
> Commit e79c6a4fc923 ("net: make net namespace sysctls belong to container's owner")
> added default values for i_uid/i_gid.

The commit that added the default is 5ec27ec735ba ("fs/proc/proc_sysctl.c:
fix the default values of i_uid/i_gid on /proc/sys inodes.")


> These however are only used when ctl_table_root->set_ownership is not
> implemented.
> But the callbacks themselves could fail to compute i_uid/i_gid and they
> all need to have the same fallback logic for this case.
> 
> This is unnecessary code duplication and prone to errors.
> For example net_ctl_set_ownership() missed the fallback.
> 
> Instead always initialize i_uid/i_gid inside the sysfs core so
> set_ownership() can safely skip setting them.
> 
> Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container's owner")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Move the fallback logic to the sysctl core
> - Link to v1: https://lore.kernel.org/r/20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net
> ---
>  fs/proc/proc_sysctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 37cde0efee57..9e34ab9c21e4 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -479,12 +479,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  			make_empty_dir_inode(inode);
>  	}
>  
> +	inode->i_uid = GLOBAL_ROOT_UID;
> +	inode->i_gid = GLOBAL_ROOT_GID;
>  	if (root->set_ownership)
>  		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
> -	else {
> -		inode->i_uid = GLOBAL_ROOT_UID;
> -		inode->i_gid = GLOBAL_ROOT_GID;
> -	}
>  
>  	return inode;
>  }
> 
> ---
> base-commit: ff9c18e435b042596c9d48badac7488e3fa76a55
> change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>

