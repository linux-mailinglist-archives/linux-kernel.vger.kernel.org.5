Return-Path: <linux-kernel+bounces-116605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E188A102
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0840C1F350C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9F146019;
	Mon, 25 Mar 2024 09:00:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26716F8E8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349351; cv=none; b=Wp1JO765jfjv1JcCX/HAQKq2cYOmXBTtKcg7wZqz9ZnSkWFmndL13sXHDjH7BB6oG0K2pF5faJQjaMOYoTA9J9ndxUyz1Yq8br+jiCc/vGdEH2n+3+mhCgMYaRjemgeSQ725UNDIEDSC9A+MDwtJtC8wSLUR+jHcui+ig93JHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349351; c=relaxed/simple;
	bh=TeOSL4Rj1ykh59xYfD2MxrPhy5wl9vMdEG822QkBnq4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uyXKu1TPOoUpkk7RFnBMIsmReg/lVYr/IjmfCgTcWzsXDQ9u2foZB8ue2rUTKz7Hc9QETD8H0s6IYWvKQa3fKgtZOkcm9cP4b1ATy5X9zc7NA6HawOP6Df2/y935Nqgr9WJ2tJRJRyxEF1W/c9Y6IDyJsd6Y0NChQcvQ4OLQXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V33PH1hKQz2BgYx;
	Mon, 25 Mar 2024 14:46:27 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D9E57140156;
	Mon, 25 Mar 2024 14:49:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 14:49:03 +0800
Subject: Re: [PATCH] ubifs: fix incorrect UBIFS_DFS_DIR_LEN macro definition
To: ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>, <ada@thorsis.com>,
	<error27@gmail.com>, <Artem.Bityutskiy@nokia.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20240324120333.3837837-1-wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f14013a4-80f1-4796-9f68-92a032dfdb13@huawei.com>
Date: Mon, 25 Mar 2024 14:49:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240324120333.3837837-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/24 20:03, ZhaoLong Wang Ð´µÀ:
> The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
> debugfs directory name, is incorrectly calculated. The current formula is
> (3 + 1 + 2*2 + 1), which assumes that both UBI device number and volume ID
> are limited to 2 characters. However, UBI device number ranges from 0 to
> 37 (2 characters), and volume ID ranges from 0 to 127 (up to 3 characters).
> 
> This incorrect definition leads to a buffer overflow issue when the device
> number is 31 and volume ID is 127, causing the dbg_debugfs_init_fs() function
> to return prematurely without creating debugfs directory in the stable branch
> linux-5.10.y.
> 
> A previous attempt to fix this issue in commit be076fdf8369 ("ubifs: fix
> snprintf() checking") by modifying the snprintf return value check range is
> insufficient. It avoids the premature function return but does not address
> the root cause of the problem. If the buffer length is inadequate, snprintf
> will truncate the output string, resulting in incorrect directory names
> during filesystem debugging.
> 

I don't think 'snprintf' ever truncated the output string in 
dbg_debugfs_init_fs(), even before be076fdf8369 ("ubifs: fix snprintf() 
checking"). The 'UBIFS_DFS_DIR_LEN' contains trailing zero byte 
according to the comments, but actually all callers treat it as real 
string length without '\0' terminated(eg. dbg_debugfs_init_fs, 
ubifs_sysfs_register).
So there are no actual problems here. The only problem is that the 
comment of 'UBIFS_DFS_DIR_LEN' is not consistent with its' usage, the 
simpliest way is modifying comments. If you still want to cleanup the 
code, please remove the wrong fixing tags.
> The proper solution is to correct the UBIFS_DFS_DIR_LEN macro definition to
> (3 + 1 + 2 + 3 + 1), accommodating the maximum lengths of both UBI device
> number and volume ID, plus the separators and null terminator.
> 
> Additionally, the original equality check for snprintf return value strictly
> adheres to the function definition. Although it may seem rigid, it is a good
> programming practice to prevent introducing subtle bugs.
> 
> This patch makes the following changes:
> 
> 1. Corrects the UBIFS_DFS_DIR_LEN macro definition to (3 + 1 + 2 + 3 + 1).
> 2. Updates the snprintf calls to use UBIFS_DFS_DIR_LEN instead of
>      UBIFS_DFS_DIR_LEN + 1.
> 3. Modifies the error checks to compare against UBIFS_DFS_DIR_LEN using >=
>      instead of >.
> 4. Removes the redundant UBIFS_DFS_DIR_LEN definition in ubifs.h.
> 5. Updates the relevant comments to reflect the correct maximum length
>      calculation.
> 
> With these changes, the buffer overflow issue is thoroughly resolved, and the
> code is made more robust and maintainable.
> 
> Fixes: be076fdf8369 ("ubifs: fix snprintf() checking")
> Fixes: ae380ce04731 ("UBIFS: lessen the size of debugging info data structure")
> Fixes: 2a734bb8d502 ("UBI: use debugfs for the extra checks knobs")
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/debug.c | 4 ++--
>   drivers/mtd/ubi/ubi.h   | 2 +-
>   fs/ubifs/debug.c        | 4 ++--
>   fs/ubifs/debug.h        | 9 +++++----
>   fs/ubifs/ubifs.h        | 7 -------
>   5 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index d57f52bd2ff3..9ec3b8b6a0aa 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -598,9 +598,9 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
>   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>   		return 0;
>   
> -	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
> +	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN, UBI_DFS_DIR_NAME,
>   		     ubi->ubi_num);
> -	if (n > UBI_DFS_DIR_LEN) {
> +	if (n >= UBI_DFS_DIR_LEN) {
>   		/* The array size is too small */
>   		return -EINVAL;
>   	}
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index 32009a24869e..da4e53ef5b0a 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -420,7 +420,7 @@ struct ubi_debug_info {
>   	unsigned int power_cut_min;
>   	unsigned int power_cut_max;
>   	unsigned int emulate_failures;
> -	char dfs_dir_name[UBI_DFS_DIR_LEN + 1];
> +	char dfs_dir_name[UBI_DFS_DIR_LEN];
>   	struct dentry *dfs_dir;
>   	struct dentry *dfs_chk_gen;
>   	struct dentry *dfs_chk_io;
> diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> index ac77ac1fd73e..d91cec93d968 100644
> --- a/fs/ubifs/debug.c
> +++ b/fs/ubifs/debug.c
> @@ -2827,9 +2827,9 @@ void dbg_debugfs_init_fs(struct ubifs_info *c)
>   	const char *fname;
>   	struct ubifs_debug_info *d = c->dbg;
>   
> -	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
> +	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN, UBIFS_DFS_DIR_NAME,
>   		     c->vi.ubi_num, c->vi.vol_id);
> -	if (n > UBIFS_DFS_DIR_LEN) {
> +	if (n >= UBIFS_DFS_DIR_LEN) {
>   		/* The array size is too small */
>   		return;
>   	}
> diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
> index ed966108da80..bbcb2bf41f83 100644
> --- a/fs/ubifs/debug.h
> +++ b/fs/ubifs/debug.h
> @@ -18,11 +18,12 @@ typedef int (*dbg_znode_callback)(struct ubifs_info *c,
>   				  struct ubifs_znode *znode, void *priv);
>   
>   /*
> - * The UBIFS debugfs directory name pattern and maximum name length (3 for "ubi"
> - * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
> + * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
> + * + 1 for "_" and 2 for UBI device numbers and 3 for volume number and 1 for
> + * the trailing zero byte.
>    */
>   #define UBIFS_DFS_DIR_NAME "ubi%d_%d"
> -#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
> +#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2 + 3 + 1)
>   
>   /**
>    * ubifs_debug_info - per-FS debugging information.
> @@ -103,7 +104,7 @@ struct ubifs_debug_info {
>   	unsigned int chk_fs:1;
>   	unsigned int tst_rcvry:1;
>   
> -	char dfs_dir_name[UBIFS_DFS_DIR_LEN + 1];
> +	char dfs_dir_name[UBIFS_DFS_DIR_LEN];
>   	struct dentry *dfs_dir;
>   	struct dentry *dfs_dump_lprops;
>   	struct dentry *dfs_dump_budg;

If you want to clean up code, modifying sysfs related 
code(ubifs_sysfs_register) is needed too.
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 1f3ea879d93a..7b6be3fb4f62 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -157,13 +157,6 @@
>   #define UBIFS_HMAC_ARR_SZ 0
>   #endif
>   
> -/*
> - * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
> - * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
> - */
> -#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
> -#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
> -
>   /*
>    * Lockdep classes for UBIFS inode @ui_mutex.
>    */
> 


