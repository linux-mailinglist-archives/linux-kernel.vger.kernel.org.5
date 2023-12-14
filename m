Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DA812F70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444189AbjLNLvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444306AbjLNLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:51:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F7188;
        Thu, 14 Dec 2023 03:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702554699; x=1734090699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYKmxaSZ3lHYWl59qq8UbtDfw7ikggP9hgTyywd2sfM=;
  b=GeQQ5clzF/97fOvYNFP48vI7Y4gM3GOCDMsGVnmtJ6RawPEhjHx6eiqQ
   Kr2KQSVnHSALu+ih8ewpZa2eTXodDKsd2keF8X76uMbhdGRT513cmU2px
   eInEkGBjIvKNwv1ImQxDxTC7FGBJH9knF6BZlF56Vkb5VeqmBTu0gYRbE
   XoX8RjxSa3FDX6DqHO3NwhUepN+/LiHouTgABSEAuryGj8qAEgNhtWIb/
   OAXoWEK/qCriaNFXPFTI4O9LV6wda8iAiToh1jEg5iNCROl6hfZ0th9Lg
   njoF9f1JsqEIaokBzhsYMuadcShm+FIxpc33vBFY0+YTXW4+sna97CjfL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375263552"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="375263552"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:51:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777874627"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="777874627"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.207])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:51:37 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] minixfs: use offset_in_page()
Date:   Thu, 14 Dec 2023 12:51:35 +0100
Message-ID: <7914003.lOV4Wx5bFT@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
References: <20231213000656.GI1674809@ZenIV>
 <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 13 December 2023 01:08:46 CET Al Viro wrote:
> It's cheaper and more idiomatic than subtracting page_address()
> of the corresponding page...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/minix/dir.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Well, I know this code since the changes to fs/sysv and fs/ext2 ;)
Therefore, FWIW...

Reviewed-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

Fabio

> diff --git a/fs/minix/dir.c b/fs/minix/dir.c
> index 62c313fc9a49..34a5d17f0796 100644
> --- a/fs/minix/dir.c
> +++ b/fs/minix/dir.c
> @@ -268,7 +268,7 @@ int minix_add_link(struct dentry *dentry, struct inode
> *inode) return -EINVAL;
> 
>  got_it:
> -	pos = page_offset(page) + p - (char *)page_address(page);
> +	pos = page_offset(page) + offset_in_page(p);
>  	err = minix_prepare_chunk(page, pos, sbi->s_dirsize);
>  	if (err)
>  		goto out_unlock;
> @@ -296,8 +296,7 @@ int minix_add_link(struct dentry *dentry, struct inode
> *inode) int minix_delete_entry(struct minix_dir_entry *de, struct page
> *page) {
>  	struct inode *inode = page->mapping->host;
> -	char *kaddr = page_address(page);
> -	loff_t pos = page_offset(page) + (char*)de - kaddr;
> +	loff_t pos = page_offset(page) + offset_in_page(de);
>  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
>  	unsigned len = sbi->s_dirsize;
>  	int err;
> @@ -421,8 +420,7 @@ int minix_set_link(struct minix_dir_entry *de, struct
> page *page, {
>  	struct inode *dir = page->mapping->host;
>  	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
> -	loff_t pos = page_offset(page) +
> -			(char *)de-(char*)page_address(page);
> +	loff_t pos = page_offset(page) + offset_in_page(de);
>  	int err;
> 
>  	lock_page(page);




