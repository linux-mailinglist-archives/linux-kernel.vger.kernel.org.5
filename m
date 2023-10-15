Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE577C9781
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 03:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjJOBJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 21:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOBJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 21:09:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D702CC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wpEBV3ZXvydjwFev3aVNa54tKUWvontWZ31bLdJ6e7k=; b=HSQaENVybdB3kaju22e48mvd6B
        r/0yZJxA2n2vZdE/rWiILO5Lyukvtf27353NZQ2HP56kn2KDIyiy07ZBufTcnCNoQJ0wUK0rSflrs
        B05mhpogl7lE/avKgkkmvH6U5MWALyFd95TSQhnDf+EBqKOPJ5E0FcN8W5I1nLsYjEDSy21L8qQEL
        SMuwa1rKeBBZZyGXYhhqfj08N2tQ5OOyzASbmiY5+7LaBQCHJC2zxdbeyYODL/Yt7cnqo15ZGEw1x
        ao3gIXqJHbGt+P9A1SlADgvRx2Kc2xJS15/uNzn02+kBLbRIB9MkTI7bYX9w3KuXxd3jw4VinLRcc
        U39JcKVw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qrpdL-001Koy-1w;
        Sun, 15 Oct 2023 01:09:31 +0000
Date:   Sat, 14 Oct 2023 18:09:28 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Seamus Connor <sconnor@purestorage.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: improve item creation performance
Message-ID: <ZSs7yIvQCTVJ7cZ7@google.com>
Mail-Followup-To: Seamus Connor <sconnor@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <ZShUmLU3X5QMiWQH@google.com>
 <20231013211129.72592-1-sconnor@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013211129.72592-1-sconnor@purestorage.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:11:29PM -0700, Seamus Connor wrote:
> As the size of a directory increases item creation slows down.
> Optimizing access to s_children removes this bottleneck.
> 
> dirents are already pinned into the cache, there is no need to scan the
> s_children list looking for duplicate Items. The configfs_dirent_exists
> check is moved to a location where it is called only during subsystem
> initialization.
> 
> d_lookup will only need to call configfs_lookup in the case where the
> item in question is not pinned to dcache. The only items not pinned to
> dcache are attributes. These are placed at the front of the s_children
> list, whilst pinned items are inserted at the back. configfs_lookup
> stops scanning when it encounters the first pinned entry in s_children.
> 
> The assumption of the above optimizations is that there will be few
> attributes, but potentially many Items in a given directory.
> 
> Signed-off-by: Seamus Connor <sconnor@purestorage.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org
Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
> 
> In this revision I've added some commentary describing the changes, and
> I have removed a helper function.
> 
>  fs/configfs/configfs_internal.h |  3 +--
>  fs/configfs/dir.c               | 39 +++++++++++++++++++++++++--------
>  fs/configfs/inode.c             | 24 --------------------
>  3 files changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index c0395363eab9..b91036fd71b1 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -55,6 +55,7 @@ struct configfs_dirent {
>  #define CONFIGFS_USET_IN_MKDIR	0x0200
>  #define CONFIGFS_USET_CREATING	0x0400
>  #define CONFIGFS_NOT_PINNED	(CONFIGFS_ITEM_ATTR | CONFIGFS_ITEM_BIN_ATTR)
> +#define CONFIGFS_PINNED		(CONFIGFS_ROOT | CONFIGFS_DIR | CONFIGFS_ITEM_LINK)
>  
>  extern struct mutex configfs_symlink_mutex;
>  extern spinlock_t configfs_dirent_lock;
> @@ -73,8 +74,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
>  				void *, umode_t, int, struct configfs_fragment *);
>  extern int configfs_dirent_is_ready(struct configfs_dirent *);
>  
> -extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
> -
>  extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
>  extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
>  extern int configfs_setattr(struct user_namespace *mnt_userns,
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index d1f9d2632202..64a0eac83b90 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -207,7 +207,17 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
>  		return ERR_PTR(-ENOENT);
>  	}
>  	sd->s_frag = get_fragment(frag);
> -	list_add(&sd->s_sibling, &parent_sd->s_children);
> +
> +	/*
> +	 * configfs_lookup scans only for unpinned items. s_children is
> +	 * partitioned so that configfs_lookup can bail out early.
> +	 * CONFIGFS_PINNED and CONFIGFS_NOT_PINNED are not symmetrical.  readdir
> +	 * cursors still need to be inserted at the front of the list.
> +	 */
> +	if (sd->s_type & CONFIGFS_PINNED)
> +		list_add_tail(&sd->s_sibling, &parent_sd->s_children);
> +	else
> +		list_add(&sd->s_sibling, &parent_sd->s_children);
>  	spin_unlock(&configfs_dirent_lock);
>  
>  	return sd;
> @@ -220,10 +230,11 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
>   *
>   * called with parent inode's i_mutex held
>   */
> -static int configfs_dirent_exists(struct configfs_dirent *parent_sd,
> -				  const unsigned char *new)
> +static int configfs_dirent_exists(struct dentry *dentry)
>  {
> -	struct configfs_dirent * sd;
> +	struct configfs_dirent *parent_sd = dentry->d_parent->d_fsdata;
> +	const unsigned char *new = dentry->d_name.name;
> +	struct configfs_dirent *sd;
>  
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
>  		if (sd->s_element) {
> @@ -289,10 +300,6 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
>  
>  	BUG_ON(!item);
>  
> -	error = configfs_dirent_exists(p->d_fsdata, dentry->d_name.name);
> -	if (unlikely(error))
> -		return error;
> -
>  	error = configfs_make_dirent(p->d_fsdata, dentry, item, mode,
>  				     CONFIGFS_DIR | CONFIGFS_USET_CREATING,
>  				     frag);
> @@ -449,6 +456,18 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  
>  	spin_lock(&configfs_dirent_lock);
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> +
> +		/*
> +		 * s_children is partitioned, see configfs_new_dirent. The first
> +		 * pinned item indicates we can stop scanning.
> +		 */
> +		if (sd->s_type & CONFIGFS_PINNED)
> +			break;
> +
> +		/*
> +		 * Note: CONFIGFS_PINNED and CONFIGFS_NOT_PINNED are asymmetric.
> +		 * there may be a readdir cursor in this list
> +		 */
>  		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
>  		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
>  			struct configfs_attribute *attr = sd->s_element;
> @@ -1878,7 +1897,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
>  	if (dentry) {
>  		d_add(dentry, NULL);
>  
> -		err = configfs_attach_group(sd->s_element, &group->cg_item,
> +		err = configfs_dirent_exists(dentry);
> +		if (!err)
> +			err = configfs_attach_group(sd->s_element, &group->cg_item,
>  					    dentry, frag);
>  		if (err) {
>  			BUG_ON(d_inode(dentry));
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index b601610e9907..15964e62329d 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -218,27 +218,3 @@ void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
>  	}
>  }
>  
> -void configfs_hash_and_remove(struct dentry * dir, const char * name)
> -{
> -	struct configfs_dirent * sd;
> -	struct configfs_dirent * parent_sd = dir->d_fsdata;
> -
> -	if (d_really_is_negative(dir))
> -		/* no inode means this hasn't been made visible yet */
> -		return;
> -
> -	inode_lock(d_inode(dir));
> -	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> -		if (!sd->s_element)
> -			continue;
> -		if (!strcmp(configfs_get_name(sd), name)) {
> -			spin_lock(&configfs_dirent_lock);
> -			list_del_init(&sd->s_sibling);
> -			spin_unlock(&configfs_dirent_lock);
> -			configfs_drop_dentry(sd, dir);
> -			configfs_put(sd);
> -			break;
> -		}
> -	}
> -	inode_unlock(d_inode(dir));
> -}
> -- 
> 2.37.0
> 

-- 

"Glory is fleeting, but obscurity is forever."  
         - Napoleon Bonaparte

			http://www.jlbec.org/
			jlbec@evilplan.org
