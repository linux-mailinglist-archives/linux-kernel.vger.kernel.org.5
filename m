Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF0753092
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjGNE3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGNE3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:29:42 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE62736
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:29:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnKDHcR_1689308975;
Received: from 30.97.49.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnKDHcR_1689308975)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 12:29:36 +0800
Message-ID: <8a896983-ec76-d705-b4af-b34ffe529a81@linux.alibaba.com>
Date:   Fri, 14 Jul 2023 12:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: deprecate superblock checksum feature
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, pratikshinde320@gmail.com
References: <20230714033832.111740-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230714033832.111740-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/14 11:38, Jingbo Xu wrote:
> Later we're going to introduce fs-verity based verification for the
> whole image.  Make the superblock checksum feature deprecated.

I'd suggest that


"Later we're going to try the self-contained image verification.
  The current superblock checksum feature has quite limited
  functionality, instead, merkle trees can provide better protection
  for image integrity.

  Since the superblock checksum is a compatible feature, just
  deprecate now. "
   

> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/Kconfig |  1 -
>   fs/erofs/super.c | 44 +++++---------------------------------------
>   2 files changed, 5 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index f259d92c9720..ebcb1f6a426a 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -4,7 +4,6 @@ config EROFS_FS
>   	tristate "EROFS filesystem support"
>   	depends on BLOCK
>   	select FS_IOMAP
> -	select LIBCRC32C
>   	help
>   	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
>   	  file system with modern designs (e.g. no buffer heads, inline
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9d6a3c6158bd..bb6a966ac4d4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -8,7 +8,6 @@
>   #include <linux/statfs.h>
>   #include <linux/parser.h>
>   #include <linux/seq_file.h>
> -#include <linux/crc32c.h>
>   #include <linux/fs_context.h>
>   #include <linux/fs_parser.h>
>   #include <linux/dax.h>
> @@ -51,33 +50,6 @@ void _erofs_info(struct super_block *sb, const char *function,
>   	va_end(args);
>   }
>   
> -static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
> -{
> -	size_t len = 1 << EROFS_SB(sb)->blkszbits;
> -	struct erofs_super_block *dsb;
> -	u32 expected_crc, crc;
> -
> -	if (len > EROFS_SUPER_OFFSET)
> -		len -= EROFS_SUPER_OFFSET;
> -
> -	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET, len, GFP_KERNEL);
> -	if (!dsb)
> -		return -ENOMEM;
> -
> -	expected_crc = le32_to_cpu(dsb->checksum);
> -	dsb->checksum = 0;
> -	/* to allow for x86 boot sectors and other oddities. */
> -	crc = crc32c(~0, dsb, len);
> -	kfree(dsb);
> -
> -	if (crc != expected_crc) {
> -		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
> -			  crc, expected_crc);
> -		return -EBADMSG;
> -	}
> -	return 0;
> -}
> -
>   static void erofs_inode_init_once(void *ptr)
>   {
>   	struct erofs_inode *vi = ptr;
> @@ -113,15 +85,16 @@ static void erofs_free_inode(struct inode *inode)
>   static bool check_layout_compatibility(struct super_block *sb,
>   				       struct erofs_super_block *dsb)
>   {
> -	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   
> -	EROFS_SB(sb)->feature_incompat = feature;
> +	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
> +	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
>   
>   	/* check if current kernel meets all mandatory requirements */
> -	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
> +	if (sbi->feature_incompat & (~EROFS_ALL_FEATURE_INCOMPAT)) {
>   		erofs_err(sb,
>   			  "unidentified incompatible feature %x, please upgrade kernel version",
> -			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
> +			   sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
>   		return false;
>   	}
>   	return true;
> @@ -365,13 +338,6 @@ static int erofs_read_superblock(struct super_block *sb)
>   		goto out;
>   	}
>   
> -	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
> -	if (erofs_sb_has_sb_chksum(sbi)) {
> -		ret = erofs_superblock_csum_verify(sb, data);
> -		if (ret)
> -			goto out;
> -	}
> -
>   	ret = -EINVAL;
>   	if (!check_layout_compatibility(sb, dsb))
>   		goto out;
