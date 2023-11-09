Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDFB7E6B13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjKINOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjKINOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:14:32 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC14D30C4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:14:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw14L0V_1699535659;
Received: from 30.27.116.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw14L0V_1699535659)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 21:14:21 +0800
Message-ID: <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
Date:   Thu, 9 Nov 2023 21:14:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To:     WoZ1zh1 <wozizhi@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
References: <20231109194821.1719430-1-wozizhi@huawei.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231109194821.1719430-1-wozizhi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/11/10 03:48, WoZ1zh1 wrote:
> Because variables "die" and "copied" only appear in case
> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
> case. Also, call "kfree(copied)" earlier to avoid double free in the
> "error_out" branch. Some cleanups, no logic changes.
> 
> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>

Please help use your real name here...

> ---
>   fs/erofs/inode.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index b8ad05b4509d..a388c93eec34 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	erofs_blk_t blkaddr, nblks = 0;
>   	void *kaddr;
>   	struct erofs_inode_compact *dic;
> -	struct erofs_inode_extended *die, *copied = NULL;
>   	unsigned int ifmt;
>   	int err;
>   
> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   
>   	switch (erofs_inode_version(ifmt)) {
>   	case EROFS_INODE_LAYOUT_EXTENDED:
> +		struct erofs_inode_extended *die, *copied = NULL;

Thanks for the patch, but in my own opinion:

1) It doesn't simplify the code

2) We'd like to avoid defining variables like this (in the
    switch block), and I even don't think this patch can compile.

3) The logic itself is also broken...

Thanks,
Gao Xiang

> +
>   		vi->inode_isize = sizeof(struct erofs_inode_extended);
>   		/* check if the extended inode acrosses block boundary */
>   		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
> @@ -98,6 +99,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   			inode->i_rdev = 0;
>   			break;
>   		default:
> +			kfree(copied);
>   			goto bogusimode;
>   		}
>   		i_uid_write(inode, le32_to_cpu(die->i_uid));
> @@ -117,7 +119,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   			/* fill chunked inode summary info */
>   			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
>   		kfree(copied);
> -		copied = NULL;
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
>   		vi->inode_isize = sizeof(struct erofs_inode_compact);
> @@ -197,7 +198,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	err = -EFSCORRUPTED;
>   err_out:
>   	DBG_BUGON(1);
> -	kfree(copied);
>   	erofs_put_metabuf(buf);
>   	return ERR_PTR(err);
>   }
