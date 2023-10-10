Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98377BF027
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379245AbjJJBUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378034AbjJJBUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:20:10 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448491
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:20:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vtqdwwn_1696900805;
Received: from 30.221.128.182(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vtqdwwn_1696900805)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 09:20:06 +0800
Message-ID: <7dfa521c-ee4c-60b2-bdd8-95b956183f3b@linux.alibaba.com>
Date:   Tue, 10 Oct 2023 09:20:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] fs: ocfs2: Check status values
Content-Language: en-US
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Joel Becker <jlbec@evilplan.org>,
        Mark Fasheh <mark@fasheh.com>, akpm <akpm@linux-foundation.org>
Cc:     Kurt Hackel <kurt.hackel@oracle.com>, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231009141111.149858-1-artem.chernyshev@red-soft.ru>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20231009141111.149858-1-artem.chernyshev@red-soft.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 10:11 PM, Artem Chernyshev wrote:
> Test return values before overwriting.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/namei.c       | 8 ++++++++
>  fs/ocfs2/quota_local.c | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 5cd6d7771cea..836c4279a979 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -1597,6 +1597,10 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
>  	if (update_dot_dot) {
>  		status = ocfs2_update_entry(old_inode, handle,
>  					    &old_inode_dot_dot_res, new_dir);
> +		if (status < 0) {
> +			mlog_errno(status);
> +			goto bail;
> +		}
>  		drop_nlink(old_dir);
>  		if (new_inode) {
>  			drop_nlink(new_inode);
> @@ -1636,6 +1640,10 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
>  							 INODE_CACHE(old_dir),
>  							 old_dir_bh,
>  							 OCFS2_JOURNAL_ACCESS_WRITE);
> +			if (status < 0) {
> +				mlog_errno(status);
> +				goto bail;
> +			}
>  			fe = (struct ocfs2_dinode *) old_dir_bh->b_data;
>  			ocfs2_set_links_count(fe, old_dir->i_nlink);
>  			ocfs2_journal_dirty(handle, old_dir_bh);
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index dfaae1e52412..e09842fc9d4d 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -1240,6 +1240,10 @@ int ocfs2_create_local_dquot(struct dquot *dquot)
>  				     &od->dq_local_phys_blk,
>  				     &pcount,
>  				     NULL);
> +	if (status < 0) {
> +		mlog_errno(status);
> +		goto out;
> +	}
>  
>  	/* Initialize dquot structure on disk */
>  	status = ocfs2_local_write_dquot(dquot);
