Return-Path: <linux-kernel+bounces-70140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C944F8593E2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E79DB215F1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1BA34;
	Sun, 18 Feb 2024 01:40:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4185EBB
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708220415; cv=none; b=uCtGH7vdZGtSIcAofwuwknWsvoFMdy5RrbpmPSTyRTL6xFxmrzHnfEn1xX2oro0SSIhHXselDgCVT5/Ae+Ck9jsO9XF3VgXV/Msndorx3NB+Euysb34iRDIK67+CYXH1Wn4GbTFwJI/HR5cHf6gnq3/Gg6XirJu/0sFLLmiapi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708220415; c=relaxed/simple;
	bh=WNQbxKVFpHm9Lmd2Xka8K18EGXlXYe/WvQMzH4jHjUM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PpDJrbGa3jnOSOk5vciR9ROVhwKXNR8jVDT8WxmKVneo6TCyHVh6itxXZgRIWyD4aPHISIl7VrwlVHp2+M2pt2DZ/vwQBtsGh7uBGC15mHwxjt6RUFyjI8UcSMXaoj/8uwJ5cDgW/KKY2Z3xh+YbssWeDkh+ZlazkKsO8CX9LFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcpG41X3cz1gydy;
	Sun, 18 Feb 2024 09:38:04 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DBFE11400CC;
	Sun, 18 Feb 2024 09:40:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 09:40:08 +0800
Subject: Re: [PATCH 2/2] ubifs: fix function pointer cast warnings
To: Arnd Bergmann <arnd@kernel.org>, Richard Weinberger <richard@nod.at>,
	Nathan Chancellor <nathan@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240213095412.453787-1-arnd@kernel.org>
 <20240213095412.453787-2-arnd@kernel.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0921a996-c579-5760-a6ff-dbd9b9eca057@huawei.com>
Date: Sun, 18 Feb 2024 09:40:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240213095412.453787-2-arnd@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/2/13 17:54, Arnd Bergmann Ð´µÀ:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> ubifs has a number of callback functions for ubifs_lpt_scan_nolock() using
> two different prototypes, either passing a struct scan_data or
> a struct ubifs_lp_stats, but the caller expects a void pointer instead.
> 
> clang-16 now warns about this:
> 
> fs/ubifs/find.c:170:9: error: cast from 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, struct scan_data *)' to 'ubifs_lpt_scan_callback' (aka 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>    170 |                                     (ubifs_lpt_scan_callback)scan_for_dirty_cb,
>        |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ubifs/find.c:449:9: error: cast from 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, struct scan_data *)' to 'ubifs_lpt_scan_callback' (aka 'int (*)(struct ubifs_info *, const struct ubifs_lprops *, int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>    449 |                                     (ubifs_lpt_scan_callback)scan_for_free_cb,
>        |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Change all of these callback functions to actually take the void * argument
> that is passed by their caller.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/ubifs/find.c   | 23 ++++++++++++-----------
>   fs/ubifs/lprops.c |  6 +++---
>   2 files changed, 15 insertions(+), 14 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
> index 1cb79b167a4f..6ebf3c04ac5f 100644
> --- a/fs/ubifs/find.c
> +++ b/fs/ubifs/find.c
> @@ -82,8 +82,9 @@ static int valuable(struct ubifs_info *c, const struct ubifs_lprops *lprops)
>    */
>   static int scan_for_dirty_cb(struct ubifs_info *c,
>   			     const struct ubifs_lprops *lprops, int in_tree,
> -			     struct scan_data *data)
> +			     void *arg)
>   {
> +	struct scan_data *data = arg;
>   	int ret = LPT_SCAN_CONTINUE;
>   
>   	/* Exclude LEBs that are currently in use */
> @@ -166,8 +167,7 @@ static const struct ubifs_lprops *scan_for_dirty(struct ubifs_info *c,
>   	data.pick_free = pick_free;
>   	data.lnum = -1;
>   	data.exclude_index = exclude_index;
> -	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
> -				    (ubifs_lpt_scan_callback)scan_for_dirty_cb,
> +	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum, scan_for_dirty_cb,
>   				    &data);
>   	if (err)
>   		return ERR_PTR(err);
> @@ -349,8 +349,9 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
>    */
>   static int scan_for_free_cb(struct ubifs_info *c,
>   			    const struct ubifs_lprops *lprops, int in_tree,
> -			    struct scan_data *data)
> +			    void *arg)
>   {
> +	struct scan_data *data = arg;
>   	int ret = LPT_SCAN_CONTINUE;
>   
>   	/* Exclude LEBs that are currently in use */
> @@ -446,7 +447,7 @@ const struct ubifs_lprops *do_find_free_space(struct ubifs_info *c,
>   	data.pick_free = pick_free;
>   	data.lnum = -1;
>   	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
> -				    (ubifs_lpt_scan_callback)scan_for_free_cb,
> +				    scan_for_free_cb,
>   				    &data);
>   	if (err)
>   		return ERR_PTR(err);
> @@ -589,8 +590,9 @@ int ubifs_find_free_space(struct ubifs_info *c, int min_space, int *offs,
>    */
>   static int scan_for_idx_cb(struct ubifs_info *c,
>   			   const struct ubifs_lprops *lprops, int in_tree,
> -			   struct scan_data *data)
> +			   void *arg)
>   {
> +	struct scan_data *data = arg;
>   	int ret = LPT_SCAN_CONTINUE;
>   
>   	/* Exclude LEBs that are currently in use */
> @@ -625,8 +627,7 @@ static const struct ubifs_lprops *scan_for_leb_for_idx(struct ubifs_info *c)
>   	int err;
>   
>   	data.lnum = -1;
> -	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
> -				    (ubifs_lpt_scan_callback)scan_for_idx_cb,
> +	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum, scan_for_idx_cb,
>   				    &data);
>   	if (err)
>   		return ERR_PTR(err);
> @@ -781,8 +782,9 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
>    */
>   static int scan_dirty_idx_cb(struct ubifs_info *c,
>   			   const struct ubifs_lprops *lprops, int in_tree,
> -			   struct scan_data *data)
> +			   void *arg)
>   {
> +	struct scan_data *data = arg;
>   	int ret = LPT_SCAN_CONTINUE;
>   
>   	/* Exclude LEBs that are currently in use */
> @@ -841,8 +843,7 @@ static int find_dirty_idx_leb(struct ubifs_info *c)
>   	if (c->pnodes_have >= c->pnode_cnt)
>   		/* All pnodes are in memory, so skip scan */
>   		return -ENOSPC;
> -	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum,
> -				    (ubifs_lpt_scan_callback)scan_dirty_idx_cb,
> +	err = ubifs_lpt_scan_nolock(c, -1, c->lscan_lnum, scan_dirty_idx_cb,
>   				    &data);
>   	if (err)
>   		return err;
> diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
> index 6d6cd85c2b4c..a11c3dab7e16 100644
> --- a/fs/ubifs/lprops.c
> +++ b/fs/ubifs/lprops.c
> @@ -1014,8 +1014,9 @@ void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
>    */
>   static int scan_check_cb(struct ubifs_info *c,
>   			 const struct ubifs_lprops *lp, int in_tree,
> -			 struct ubifs_lp_stats *lst)
> +			 void *arg)
>   {
> +	struct ubifs_lp_stats *lst = arg;
>   	struct ubifs_scan_leb *sleb;
>   	struct ubifs_scan_node *snod;
>   	int cat, lnum = lp->lnum, is_idx = 0, used = 0, free, dirty, ret;
> @@ -1269,8 +1270,7 @@ int dbg_check_lprops(struct ubifs_info *c)
>   
>   	memset(&lst, 0, sizeof(struct ubifs_lp_stats));
>   	err = ubifs_lpt_scan_nolock(c, c->main_first, c->leb_cnt - 1,
> -				    (ubifs_lpt_scan_callback)scan_check_cb,
> -				    &lst);
> +				    scan_check_cb, &lst);
>   	if (err && err != -ENOSPC)
>   		goto out;
>   
> 


