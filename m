Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8AF75B511
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGTQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGTQ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:57:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0392
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:57:01 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-799a451ca9cso430805241.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689872220; x=1690477020;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZCX9yhI7AbKGy/HnG34aNNVUXchyn5dmI5801hBoFs=;
        b=OFmwChsRfRqH9lASmE0v54HU6kpsRwivRWRyqB44btzy+zNV0jDMcoAocZMcp1FND+
         cTyrMgIW3CLI8mL3wxSoWtBJ+tZl36pkDUnxy25Zov3bibz2ZRjelm2iUOHZ77rpItZh
         UTDrKqVkVnHFItLO2tlUgwvou+HqhGBpvx8dEl3TpunBsGcTJKgzd2/burDS9oRfzK1r
         ZoJRsjyKq+9MGqnwF/bALJxj6p/0RlAhxpa11+oAP43beOBRwV1f17nUgrNQOCy+qgnD
         n9DGWXgd+4FDzMQi6Gqmz2rokhcWpYWXbzn8xMZj3GGenjzAcFNrG8KEk3e90QgjWF8e
         iMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689872220; x=1690477020;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZCX9yhI7AbKGy/HnG34aNNVUXchyn5dmI5801hBoFs=;
        b=OEAxcRFRm1UbfMGEq3xFZqy2rhER0ZheEOtXvh2sIOg4YucAqQvizUBlr+MYHirzPk
         6uGYyCL5xXZLF4qgi8jwLEMN7ESxdm6Oqzl3E5xnD3o2wTbjKcpUd2Dxz6nBguPG+b3B
         U4/9CQS9O5+mroQC7uyq6PI1iu746hHPSowDTXRBf8eQKJyHki1Ze0zk52gkQZPJZmAe
         GIZkvXMaFC5CNXVz01VlO8XKjCBn28sBtFynaBhrE4Ukm9p2tLhCTcjWdviIy4wcylAt
         ABCCzn/EKIDcFjyQ6ErMeFXCk0k+s8MCehJAFzvq7EdO8rj/T9OvNFsjqfrbtcPITYHD
         ruHg==
X-Gm-Message-State: ABy/qLbMA6PD71TkwE34JVAo595RkHM7j50oSR6VoV5doc+GyKmLJHA/
        JfrL/9rMyN7tNCWoq5MUHDKjDQ==
X-Google-Smtp-Source: APBJJlEsYqZ49Ny+WkiZxWE5TyzQv98GOGbTZwiNitn54WzBknEBplR1bvLxwQOCYwqiC5hsOLi/Kw==
X-Received: by 2002:a67:b604:0:b0:43d:6660:581b with SMTP id d4-20020a67b604000000b0043d6660581bmr2252078vsm.5.1689872220064;
        Thu, 20 Jul 2023 09:57:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w136-20020a81498e000000b0056974f4019esm319055ywa.6.2023.07.20.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:56:59 -0700 (PDT)
Date:   Thu, 20 Jul 2023 09:56:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Oleksandr Tymoshenko <ovt@google.com>
cc:     Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] shmem: add support for user extended attributes
In-Reply-To: <20230720065430.2178136-1-ovt@google.com>
Message-ID: <9b8d38f0-fd22-3f98-d070-16baf976ecb5@google.com>
References: <20230720065430.2178136-1-ovt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023, Oleksandr Tymoshenko wrote:

> User extended attributes are not enabled in tmpfs because
> the size of the value is not limited and the memory allocated
> for it is not counted against any limit. Malicious
> non-privileged user can exhaust kernel memory by creating
> user.* extended attribute with very large value.
> 
> There are still situations when enabling suport for extended
> user attributes on tmpfs is required and the attack vector
> is not applicable, for instance batch jobs with trusted binaries.
> 
> This patch introduces two mount options to enable/disable
> support for user.* extended attributes on tmpfs:
> 
> user_xattr    enable support for user extended aatributes
> nouser_xattr  disable support for user extended attributes
> 
> The default behavior of the filesystem is not changed.
> 
> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>

Thanks, but no.

This is not something we want mount options for:
we just want to limit the memory usage of tmpfs user xattrs.

I've had the patch to do that limiting (taking it out of the inode
space already limited by nr_inodes) in my test tree for 2.5 years now:
waiting to reach the top of the heap to pull together and submit.

Your sending this patch does help to raise the priority for my
sending that patch: thank you; but I cannot promise when that will be.

(And the way mm/shmem.c is conflicted between vfs and mm trees
is rather discouraging development there at the moment: I'm hoping
it can be mostly wrested back into the mm tree in the next cycle.)

Hugh

> ---
>  Documentation/filesystems/tmpfs.rst | 12 ++++++++
>  include/linux/shmem_fs.h            |  1 +
>  mm/shmem.c                          | 45 +++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index f18f46be5c0c..5700ba72d095 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -215,6 +215,16 @@ will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>  
>  
> +tmpfs, when compiled with CONFIG_TMPFS_XATTR, does not support
> +Extended User Attributes for security reasons. The support can be
> +enabled/disabled by two mount options:
> +
> +============  ===========================================
> +user_xattr    Enable support for Extended User Attributes
> +nouser_xattr  Disable upport for Extended User Attributes
> +============  ===========================================
> +
> +
>  :Author:
>     Christoph Rohland <cr@sap.com>, 1.12.01
>  :Updated:
> @@ -223,3 +233,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by root.
>     KOSAKI Motohiro, 16 Mar 2010
>  :Updated:
>     Chris Down, 13 July 2020
> +:Updated:
> +   Oleksandr Tymoshenko, 19 July 2023
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 9029abd29b1c..f06d18b9041c 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -53,6 +53,7 @@ struct shmem_sb_info {
>  	spinlock_t shrinklist_lock;   /* Protects shrinklist */
>  	struct list_head shrinklist;  /* List of shinkable inodes */
>  	unsigned long shrinklist_len; /* Length of shrinklist */
> +	bool user_xattr;	      /* user.* xattrs are allowed */
>  };
>  
>  static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2f2e0e618072..4f7d46d65494 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -85,6 +85,7 @@ static struct vfsmount *shm_mnt;
>  
>  #define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
>  #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
> +#define TMPFS_USER_XATTR_INDEX 1
>  
>  /* Pretend that each entry is of this size in directory's i_size */
>  #define BOGO_DIRENT_SIZE 20
> @@ -116,11 +117,13 @@ struct shmem_options {
>  	int huge;
>  	int seen;
>  	bool noswap;
> +	bool user_xattr;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
>  #define SHMEM_SEEN_INUMS 8
>  #define SHMEM_SEEN_NOSWAP 16
> +#define SHMEM_SEEN_USER_XATTR 32
>  };
>  
>  #ifdef CONFIG_TMPFS
> @@ -3447,6 +3450,16 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
>  				   const char *name, void *buffer, size_t size)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> +
> +	switch (handler->flags) {
> +	case TMPFS_USER_XATTR_INDEX:
> +		if (!sbinfo->user_xattr)
> +			return -EOPNOTSUPP;
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	name = xattr_full_name(handler, name);
>  	return simple_xattr_get(&info->xattrs, name, buffer, size);
> @@ -3459,8 +3472,18 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
>  				   size_t size, int flags)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  	int err;
>  
> +	switch (handler->flags) {
> +	case TMPFS_USER_XATTR_INDEX:
> +		if (!sbinfo->user_xattr)
> +			return -EOPNOTSUPP;
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	name = xattr_full_name(handler, name);
>  	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
>  	if (!err) {
> @@ -3482,9 +3505,17 @@ static const struct xattr_handler shmem_trusted_xattr_handler = {
>  	.set = shmem_xattr_handler_set,
>  };
>  
> +static const struct xattr_handler shmem_user_xattr_handler = {
> +	.prefix = XATTR_USER_PREFIX,
> +	.flags = TMPFS_USER_XATTR_INDEX,
> +	.get = shmem_xattr_handler_get,
> +	.set = shmem_xattr_handler_set,
> +};
> +
>  static const struct xattr_handler *shmem_xattr_handlers[] = {
>  	&shmem_security_xattr_handler,
>  	&shmem_trusted_xattr_handler,
> +	&shmem_user_xattr_handler,
>  	NULL
>  };
>  
> @@ -3604,6 +3635,8 @@ enum shmem_param {
>  	Opt_inode32,
>  	Opt_inode64,
>  	Opt_noswap,
> +	Opt_user_xattr,
> +	Opt_nouser_xattr,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -3626,6 +3659,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_flag  ("inode32",	Opt_inode32),
>  	fsparam_flag  ("inode64",	Opt_inode64),
>  	fsparam_flag  ("noswap",	Opt_noswap),
> +	fsparam_flag  ("user_xattr",	Opt_user_xattr),
> +	fsparam_flag  ("nouser_xattr",	Opt_nouser_xattr),
>  	{}
>  };
>  
> @@ -3717,6 +3752,14 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->noswap = true;
>  		ctx->seen |= SHMEM_SEEN_NOSWAP;
>  		break;
> +	case Opt_user_xattr:
> +		ctx->user_xattr = true;
> +		ctx->seen |= SHMEM_SEEN_USER_XATTR;
> +		break;
> +	case Opt_nouser_xattr:
> +		ctx->user_xattr = false;
> +		ctx->seen |= SHMEM_SEEN_USER_XATTR;
> +		break;
>  	}
>  	return 0;
>  
> @@ -3834,6 +3877,8 @@ static int shmem_reconfigure(struct fs_context *fc)
>  		sbinfo->max_inodes  = ctx->inodes;
>  		sbinfo->free_inodes = ctx->inodes - inodes;
>  	}
> +	if (ctx->seen & SHMEM_SEEN_USER_XATTR)
> +		sbinfo->user_xattr = ctx->user_xattr;
>  
>  	/*
>  	 * Preserve previous mempolicy unless mpol remount option was specified.
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
> 
