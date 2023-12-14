Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A40812FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572902AbjLNMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572910AbjLNMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:07:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CD0BD;
        Thu, 14 Dec 2023 04:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702555627; x=1734091627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Q+luyd4pSCUnS9q7QWXSG0Qvk/mCCFyLh+qA2EsHcU=;
  b=O0qtsOQfQ3LgETCj7VfHIwGRVWL5g/7r1biQ64m69HLT5XhwBWhKwYCi
   6wtdYVsoKvFyNy+nzi0T0ig9giM/Oz6PObEnVB2ZbhsKk5fhPM9xSdXVT
   AL9xa2Dv9grNoUL2li4RgDFtzXcRCPhJPnRUvfUDaSwpX7RyknBeNu1c6
   9Oxjs6G+yqh3Sc12q09uMHb5m0DKCj1jlns7OFmVPYZn1V91i5IVRGeXT
   v9QCGhI6jAezZU0SJ7hGGS8TL4egV90WEhpqydl00ponPh4LSkyBJochE
   PQLTnMm53Yvk4HcR56wxw42bOTyVl4V7kMA1HAaf2QMErar6vfYqWrcCs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="385523791"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="385523791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 04:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947553760"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="947553760"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.7.207])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 04:07:01 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] minixfs: switch to kmap_local_page()
Date:   Thu, 14 Dec 2023 13:06:57 +0100
Message-ID: <5180693.aeNJFYEL58@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231213000849.2748576-4-viro@zeniv.linux.org.uk>
References: <20231213000656.GI1674809@ZenIV>
 <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
 <20231213000849.2748576-4-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 13 December 2023 01:08:49 CET Al Viro wrote:
> Again, a counterpart of Fabio's fs/sysv patch
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/minix/dir.c   | 27 +++++++++++++--------------
>  fs/minix/minix.h |  5 -----
>  fs/minix/namei.c |  6 +++---
>  3 files changed, 16 insertions(+), 22 deletions(-)

Reviewed-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>

> diff --git a/fs/minix/dir.c b/fs/minix/dir.c
> index ccb6c47fd7fe..a224cf222570 100644
> --- a/fs/minix/dir.c
> +++ b/fs/minix/dir.c
> @@ -70,9 +70,8 @@ static void *dir_get_page(struct inode *dir, unsigned long
> n, struct page **p) struct page *page = read_mapping_page(mapping, n,
> NULL);
>  	if (IS_ERR(page))
>  		return ERR_CAST(page);
> -	kmap(page);
>  	*p = page;
> -	return page_address(page);
> +	return kmap_local_page(page);
>  }
> 
>  static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
> @@ -123,13 +122,13 @@ static int minix_readdir(struct file *file, struct
> dir_context *ctx) unsigned l = strnlen(name, sbi->s_namelen);
>  				if (!dir_emit(ctx, name, l,
>  					      inumber, DT_UNKNOWN)) {
> -					dir_put_page(page);
> +					unmap_and_put_page(page, p);
>  					return 0;
>  				}
>  			}
>  			ctx->pos += chunk_size;
>  		}
> -		dir_put_page(page);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -189,7 +188,7 @@ minix_dirent *minix_find_entry(struct dentry *dentry,
> struct page **res_page) if (namecompare(namelen, sbi->s_namelen, name,
> namx))
>  				goto found;
>  		}
> -		dir_put_page(page);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	return NULL;
> 
> @@ -255,7 +254,7 @@ int minix_add_link(struct dentry *dentry, struct inode
> *inode) goto out_unlock;
>  		}
>  		unlock_page(page);
> -		dir_put_page(page);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	BUG();
>  	return -EINVAL;
> @@ -278,7 +277,7 @@ int minix_add_link(struct dentry *dentry, struct inode
> *inode) mark_inode_dirty(dir);
>  	err = minix_handle_dirsync(dir);
>  out_put:
> -	dir_put_page(page);
> +	unmap_and_put_page(page, kaddr);
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -324,7 +323,7 @@ int minix_make_empty(struct inode *inode, struct inode
> *dir) goto fail;
>  	}
> 
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	memset(kaddr, 0, PAGE_SIZE);
> 
>  	if (sbi->s_version == MINIX_V3) {
> @@ -344,7 +343,7 @@ int minix_make_empty(struct inode *inode, struct inode
> *dir) de->inode = dir->i_ino;
>  		strcpy(de->name, "..");
>  	}
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
> 
>  	dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
>  	err = minix_handle_dirsync(inode);
> @@ -361,11 +360,11 @@ int minix_empty_dir(struct inode * inode)
>  	struct page *page = NULL;
>  	unsigned long i, npages = dir_pages(inode);
>  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
> -	char *name;
> +	char *name, *kaddr;
>  	__u32 inumber;
> 
>  	for (i = 0; i < npages; i++) {
> -		char *p, *kaddr, *limit;
> +		char *p, *limit;
> 
>  		kaddr = dir_get_page(inode, i, &page);
>  		if (IS_ERR(kaddr))
> @@ -396,12 +395,12 @@ int minix_empty_dir(struct inode * inode)
>  					goto not_empty;
>  			}
>  		}
> -		dir_put_page(page);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	return 1;
> 
>  not_empty:
> -	dir_put_page(page);
> +	unmap_and_put_page(page, kaddr);
>  	return 0;
>  }
> 
> @@ -455,7 +454,7 @@ ino_t minix_inode_by_name(struct dentry *dentry)
>  			res = ((minix3_dirent *) de)->inode;
>  		else
>  			res = de->inode;
> -		dir_put_page(page);
> +		unmap_and_put_page(page, de);
>  	}
>  	return res;
>  }
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index cb42b6cf7909..d493507c064f 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -64,11 +64,6 @@ extern int V2_minix_get_block(struct inode *, long,
> struct buffer_head *, int); extern unsigned V1_minix_blocks(loff_t, struct
> super_block *);
>  extern unsigned V2_minix_blocks(loff_t, struct super_block *);
> 
> -static inline void dir_put_page(struct page *page)
> -{
> -	kunmap(page);
> -	put_page(page);
> -}
>  extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct
> page**); extern int minix_add_link(struct dentry*, struct inode*);
>  extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
> diff --git a/fs/minix/namei.c b/fs/minix/namei.c
> index 20923a15e30a..d6031acc34f0 100644
> --- a/fs/minix/namei.c
> +++ b/fs/minix/namei.c
> @@ -149,7 +149,7 @@ static int minix_unlink(struct inode * dir, struct
> dentry *dentry) if (!de)
>  		return -ENOENT;
>  	err = minix_delete_entry(de, page);
> -	dir_put_page(page);
> +	unmap_and_put_page(page, de);
> 
>  	if (err)
>  		return err;
> @@ -242,9 +242,9 @@ static int minix_rename(struct mnt_idmap *idmap,
>  	}
>  out_dir:
>  	if (dir_de)
> -		dir_put_page(dir_page);
> +		unmap_and_put_page(dir_page, dir_de);
>  out_old:
> -	dir_put_page(old_page);
> +	unmap_and_put_page(old_page, old_de);
>  out:
>  	return err;
>  }




