Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3E7F6B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKXEUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjKXEUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:20:53 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D400F10D9;
        Thu, 23 Nov 2023 20:20:59 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E8B4219C8;
        Thu, 23 Nov 2023 15:28:12 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CEB9B13AAD;
        Thu, 23 Nov 2023 11:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id C2kuMgA9X2U+ZgAAn2gu4w
        (envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 11:52:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1DC1DA07D9; Thu, 23 Nov 2023 10:22:51 +0100 (CET)
Date:   Thu, 23 Nov 2023 10:22:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] udf_rename(): only access the child content on
 cross-directory rename
Message-ID: <20231123092251.pjeqi2hyrpmn24wi@quack3>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
 <20231122193652.419091-3-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122193652.419091-3-viro@zeniv.linux.org.uk>
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: 1E8B4219C8
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-11-23 19:36:46, Al Viro wrote:
> We can't really afford locking the source on same-directory rename;
> currently vfs_rename() tries to do that, but it will have to be
> changed.  The logics in udf_rename() is lazy and goes looking for
> ".." in source even in same-directory case.  It's not hard to get
> rid of that, leaving that behaviour only for cross-directory case;
> that VFS can get locks safely (and will keep doing that after the
> coming changes).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/namei.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 3508ac484da3..fac806a7a8d4 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -766,7 +766,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	struct inode *old_inode = d_inode(old_dentry);
>  	struct inode *new_inode = d_inode(new_dentry);
>  	struct udf_fileident_iter oiter, niter, diriter;
> -	bool has_diriter = false;
> +	bool has_diriter = false, is_dir = false;
>  	int retval;
>  	struct kernel_lb_addr tloc;
>  
> @@ -789,6 +789,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			if (!empty_dir(new_inode))
>  				goto out_oiter;
>  		}
> +		is_dir = true;
> +	}
> +	if (is_dir && old_dir != new_dir) {
>  		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
>  					       &diriter);
>  		if (retval == -ENOENT) {
> @@ -878,7 +881,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			       udf_dir_entry_len(&diriter.fi));
>  		udf_fiiter_write_fi(&diriter, NULL);
>  		udf_fiiter_release(&diriter);
> +	}
>  
> +	if (is_dir) {
>  		inode_dec_link_count(old_dir);
>  		if (new_inode)
>  			inode_dec_link_count(new_inode);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
