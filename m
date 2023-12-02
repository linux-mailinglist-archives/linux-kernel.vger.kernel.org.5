Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC6801F01
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjLBW1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:27:06 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB64107;
        Sat,  2 Dec 2023 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NjbNFGRIsxm13NIq7QOlU0+7el0vqRk7wXDZtiulYNM=; b=Q66e2ozhslYFy6IZJBTKhUwLJD
        tUSedC7mVh5eeVXeJAW6cZJ3vDKnxWvy4q3BAanpfHjn8wGd2PlIuBQuYYB2WuffAqVmM81q8Bs4P
        QkNm9qT+mX8OzUw05W8kcWAOdjd23IDKPgXHC9y/Umuln0Z1DHUTR4cfjrlbRQc6dMEyU6DPTyp2O
        +V0yKhIDBxMfYGKOflC47npu6f4e7VRU0sGsjL+oWvImoAdz4hBbc0rVl+Ezb6eSftIPTPEsGNZF+
        hbsz2exqEUt2pgsT+p/eLnlIT0ROABgloY7FuIQQdiFW2riTh7hWpAIf0jpk4BdMepKByyb5Ajjkt
        NTE5TF1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r9YS2-006OsI-1h;
        Sat, 02 Dec 2023 22:27:06 +0000
Date:   Sat, 2 Dec 2023 22:27:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] pstore: inode: Use cleanup.h for struct
 pstore_private
Message-ID: <20231202222706.GT38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212217.243710-5-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 01:22:15PM -0800, Kees Cook wrote:

>  static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
>  {
> @@ -338,9 +339,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  {
>  	struct dentry		*dentry;
>  	struct inode		*inode __free(iput) = NULL;
> -	int			rc = 0;
>  	char			name[PSTORE_NAMELEN];
> -	struct pstore_private	*private, *pos;
> +	struct pstore_private	*private __free(pstore_private) = NULL, *pos;
>  	size_t			size = record->size + record->ecc_notice_size;
>  
>  	if (WARN_ON(!inode_is_locked(d_inode(root))))
> @@ -356,7 +356,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  			return -EEXIST;
>  	}
>  
> -	rc = -ENOMEM;
>  	inode = pstore_get_inode(root->d_sb);
>  	if (!inode)
>  		return -ENOMEM;
> @@ -373,7 +372,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  
>  	dentry = d_alloc_name(root, name);
>  	if (!dentry)
> -		goto fail_private;
> +		return -ENOMEM;
>  
>  	private->dentry = dentry;
>  	private->record = record;
> @@ -386,13 +385,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  
>  	d_add(dentry, no_free_ptr(inode));
>  
> -	list_add(&private->list, &records_list);
> +	list_add(&(no_free_ptr(private))->list, &records_list);

That's really brittle.  It critically depends upon having no failure
exits past the assignment to ->i_private; once you've done that,
you have transferred the ownership of that thing to the inode
(look at your ->evict_inode()).  But you can't say
        inode->i_private = no_free_ptr(private);
since you are using private past that point.
