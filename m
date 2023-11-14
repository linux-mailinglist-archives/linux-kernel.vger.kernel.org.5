Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8887EA9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjKNElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNElW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:41:22 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA42198;
        Mon, 13 Nov 2023 20:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=O76q8kXtMpRQfEz4vWxJaQRBpseXEFxko6RxuL68OhA=; b=Gi21ZqN1N2i+WUUvrObWDFXRKc
        j2hzEMwLd09wJ3aha5hMBJECaqQhp2Ti5i+j/2696xXY5dKjhhAQ9Gek7oURbIvMYdcQsJkcAI7Cz
        kQUb56A4Fm85qumyHF1uUx1+Wc/RI0+trV90BWAP/Fi6X35iS6toG0msjEkAes40FIB+mzgG24Nmc
        N7RBfWoAbrkdq7TeyuIdIr9BgC288r6U9/cXBRsEhA4DB6L+m+mozKPjoAWdEvbwe7LJwwrQw5iqH
        wC5cra1gMILp4at/A8kh2qY01tthkGpp1yNkqDcaFhU3kOxPxf+N90zMC2PxlSRuvXpNpsUDa85Av
        VfncpiiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r2lEc-00FX05-1G;
        Tue, 14 Nov 2023 04:41:10 +0000
Date:   Tue, 14 Nov 2023 04:41:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
        autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
Message-ID: <20231114044110.GR1957730@ZenIV>
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:25:35PM +0800, Ian Kent wrote:
> >         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> > +       if (!root_inode)
> > +               goto fail;
> 
> Yes, I think this is the only thing it could be.
> 
> There's one small problem though, it leaks the dentry info. ino,
> allocated just above. I think this should goto label fail_ino instead.
> 
> Note that once the root dentry is allocated then the ino struct will
> be freed when the dentry is freed so ino doesn't need to be freed.

There's a simpler solution:

        root_inode = autofs_get_inode(s, S_IFDIR | 0755);
	if (root_inode) {
		root_inode->i_uid = ctx->uid;
		root_inode->i_gid = ctx->gid;
	}
        root = d_make_root(root_inode);
        if (!root)
                goto fail_ino;

d_make_root(NULL) will quietly return NULL, which is all you
need.  FWIW, I would probably bring the rest of initialization
        root_inode->i_fop = &autofs_root_operations;
        root_inode->i_op = &autofs_dir_inode_operations;
in there as well.

Incidentally, why bother with separate fail_dput thing?  Shove it
into ->s_root and return ret - autofs_kill_sb() will take care
of dropping it...

How about the following:
static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
{
	struct autofs_fs_context *ctx = fc->fs_private;
	struct autofs_sb_info *sbi = s->s_fs_info;
	struct inode *root_inode;
	struct autofs_info *ino;

	pr_debug("starting up, sbi = %p\n", sbi);

	sbi->sb = s;
	s->s_blocksize = 1024;
	s->s_blocksize_bits = 10;
	s->s_magic = AUTOFS_SUPER_MAGIC;
	s->s_op = &autofs_sops;
	s->s_d_op = &autofs_dentry_operations;
	s->s_time_gran = 1;

	/*
	 * Get the root inode and dentry, but defer checking for errors.
	 */
	ino = autofs_new_ino(sbi);
	if (!ino)
		return -ENOMEM;

	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
	if (root_inode) {
		root_inode->i_uid = ctx->uid;
		root_inode->i_gid = ctx->gid;
		root_inode->i_fop = &autofs_root_operations;
		root_inode->i_op = &autofs_dir_inode_operations;
	}
	s->s_root = d_make_root(root_inode);
	if (unlikely(!s->s_root)) {
		autofs_free_ino(ino);
		return -ENOMEM;
	}
	s->s_root->d_fsdata = ino;

	if (ctx->pgrp_set) {
		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
		if (!sbi->oz_pgrp) {
			int ret = invalf(fc, "Could not find process group %d",
				     ctx->pgrp);
			return ret;
		}
	} else {
		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
	}

	if (autofs_type_trigger(sbi->type))
		managed_dentry_set_managed(s->s_root);

	pr_debug("pipe fd = %d, pgrp = %u\n",
		 sbi->pipefd, pid_nr(sbi->oz_pgrp));

	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
	return 0;
}

No gotos, no labels to keep track of...
