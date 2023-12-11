Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAE80DB08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbjLKTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbjLKTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:43:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54AD0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:43:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689E6C433C8;
        Mon, 11 Dec 2023 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702323787;
        bh=P9nO0lI0Oyoyv1jHeWoc7C5Rh/xtPh/b1M+xSJ63B6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ejO1qmcDqnwmNWyow7QSq3OnuYlDX6RYwsIUXBjw9XzxO8ETyk48R5Y83g2rWMLoE
         FsIA7khIRJmQoP2anZeYhhwWuZUomjkJcJ+MB9SLY1JbRpEpgqGkf109l46uWe4RGI
         i0HLGHAq8tIg2u0giF87VpwMLS0rtNWw5Z1D3m9s=
Date:   Mon, 11 Dec 2023 11:43:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs/proc: show correct device and inode numbers in
 /proc/pid/maps
Message-Id: <20231211114306.08211860253a77c69bab2a87@linux-foundation.org>
In-Reply-To: <20231211193048.580691-1-avagin@google.com>
References: <20231211193048.580691-1-avagin@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 11:30:47 -0800 Andrei Vagin <avagin@google.com> wrote:

> Device and inode numbers in /proc/pid/maps have to match numbers returned by
> statx for the same files.
> 
> /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> an issue. If a mapped file is on a stackable file system (e.g.,
> overlayfs), vma->vm_file is a backing file whose f_inode is on the
> underlying filesystem. To show correct numbers, we need to get a user
> file and shows its numbers. The same trick is used to show file paths in
> /proc/pid/maps.
> 
> But it isn't the end of this story. A file system can manipulate inode numbers
> within the getattr callback (e.g., ovl_getattr), so vfs_getattr must be used to
> get correct numbers.

Al, could you please comment on this?

Thanks.

> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -273,9 +273,23 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
>  	const char *name = NULL;
>  
>  	if (file) {
> -		struct inode *inode = file_inode(vma->vm_file);
> -		dev = inode->i_sb->s_dev;
> -		ino = inode->i_ino;
> +		const struct path *path;
> +		struct kstat stat;
> +
> +		path = file_user_path(file);
> +		/*
> +		 * A file system can manipulate inode numbers within the
> +		 * getattr callback (e.g. ovl_getattr).
> +		 */
> +		if (!vfs_getattr_nosec(path, &stat, STATX_INO, AT_STATX_DONT_SYNC)) {
> +			dev = stat.dev;
> +			ino = stat.ino;
> +		} else {
> +			struct inode *inode = d_backing_inode(path->dentry);
> +
> +			dev = inode->i_sb->s_dev;
> +			ino = inode->i_ino;
> +		}
>  		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
>  	}
>  
> -- 
> 2.43.0.472.g3155946c3a-goog
