Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10B77EE570
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbjKPQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:48:29 -0500
Received: from mail.alarsen.net (joe.alarsen.net [IPv6:2a01:4f8:191:10e8:1::fe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A11A8;
        Thu, 16 Nov 2023 08:48:23 -0800 (PST)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:86d9:db0b:6743:3184])
        by joe.alarsen.net (Postfix) with ESMTPS id 18C661801F6;
        Thu, 16 Nov 2023 17:48:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1700153301; bh=KpehnglDQfPh9u5cwpz2ZhgkchMBYc60fXNfC1A1zgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Th1gqvIyxImNy5XpeD1LSc2vckGSqTuWzzFtWic4hiSwR4qgf/fbomjYAaGLLEHSK
         eItFkDdDyVOR/FSJHp+nKJLuP3de0kpaJPKslU+OmeJ7D4FI8oOa3ZPsxZpBOFjCME
         JhwjsW/ypayGSPrLsLmm61Su+5hPrA/nDSxT/thE=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTPS id 02551EE5;
        Thu, 16 Nov 2023 17:48:21 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ronald Monthero <debug.penguin32@gmail.com>, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Date:   Thu, 16 Nov 2023 17:48:20 +0100
Message-ID: <2910678.e9J7NaK4W3@oscar>
In-Reply-To: <202311160631.5ACFB84B7C@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com> <202311160612.C38BF44@keescook> <202311160631.5ACFB84B7C@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-16 15:58 Kees Cook wrote:
> On Thu, Nov 16, 2023 at 06:29:59AM -0800, Kees Cook wrote:
> > On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> > > qnx4 dir name length can vary to be of maximum size
> > > QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> > > 'link info' entry is stored and the status byte is set.
> > > So to avoid buffer overflow check di_fname length
> > > fetched from (struct qnx4_inode_entry *)
> > > before use in strlen to avoid buffer overflow.
> > > 
> > > panic context
> > > [ 4849.636861] detected buffer overflow in strlen
> > > [ 4849.636897] ------------[ cut here ]------------
> > > [ 4849.636902] kernel BUG at lib/string.c:1165!
> > > [ 4849.636917] invalid opcode: 0000 [#2] SMP PTI
> > > ..
> > > [ 4849.637047] Call Trace:
> > > [ 4849.637053]  <TASK>
> > > [ 4849.637059]  ? show_trace_log_lvl+0x1d6/0x2ea
> > > [ 4849.637075]  ? show_trace_log_lvl+0x1d6/0x2ea
> > > [ 4849.637095]  ? qnx4_find_entry.cold+0xc/0x18 [qnx4]
> > > [ 4849.637111]  ? show_regs.part.0+0x23/0x29
> > > [ 4849.637123]  ? __die_body.cold+0x8/0xd
> > > [ 4849.637135]  ? __die+0x2b/0x37
> > > [ 4849.637147]  ? die+0x30/0x60
> > > [ 4849.637161]  ? do_trap+0xbe/0x100
> > > [ 4849.637171]  ? do_error_trap+0x6f/0xb0
> > > [ 4849.637180]  ? fortify_panic+0x13/0x15
> > > [ 4849.637192]  ? exc_invalid_op+0x53/0x70
> > > [ 4849.637203]  ? fortify_panic+0x13/0x15
> > > [ 4849.637215]  ? asm_exc_invalid_op+0x1b/0x20
> > > [ 4849.637228]  ? fortify_panic+0x13/0x15
> > > [ 4849.637240]  ? fortify_panic+0x13/0x15
> > > [ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
> > > [ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]
> > > [ 4849.637275]  __lookup_slow+0x85/0x150
> > > [ 4849.637291]  walk_component+0x145/0x1c0
> > > [ 4849.637304]  ? path_init+0x2c0/0x3f0
> > > [ 4849.637316]  path_lookupat+0x6e/0x1c0
> > > [ 4849.637330]  filename_lookup+0xcf/0x1d0
> > > [ 4849.637341]  ? __check_object_size+0x1d/0x30
> > > [ 4849.637354]  ? strncpy_from_user+0x44/0x150
> > > [ 4849.637365]  ? getname_flags.part.0+0x4c/0x1b0
> > > [ 4849.637375]  user_path_at_empty+0x3f/0x60
> > > [ 4849.637383]  vfs_statx+0x7a/0x130
> > > [ 4849.637393]  do_statx+0x45/0x80
> > > ..
> > > 
> > > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > > ---
> > > 
> > >  fs/qnx4/namei.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > > index 8d72221735d7..825b891a52b3 100644
> > > --- a/fs/qnx4/namei.c
> > > +++ b/fs/qnx4/namei.c
> > > @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
> > > 
> > >  	} else {
> > >  	
> > >  		namelen = QNX4_SHORT_NAME_MAX;
> > >  	
> > >  	}
> > > 
> > > +
> > > +	/** qnx4 dir name length can vary, check the di_fname
> > > +	 * fetched from (struct qnx4_inode_entry *) before use in
> > > +	 * strlen to avoid panic due to buffer overflow"
> > > +	 */
> > 
> > Style nit: this comment should start with just "/*" alone, like:
> > 	/*
> > 	
> > 	 * qnx4 dir name ...
> > 	 
> > > +	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
> > > +		return -ENAMETOOLONG;
> > > 
> > >  	thislen = strlen( de->di_fname );
> > 
> > de->di_fname is:
> > 
> > struct qnx4_inode_entry {
> > 
> >         char            di_fname[QNX4_SHORT_NAME_MAX];
> > 	
> > 	...
> > 
> > #define QNX4_SHORT_NAME_MAX     16
> > #define QNX4_NAME_MAX           48
> > 
> > It's always going to have a max of QNX4_SHORT_NAME_MAX. Is any of this
> > code correct if namelen ends up being QNX4_NAME_MAX? It'll be reading
> > past the end of di_fname.
> > 
> > Is bh->b_data actually struct qnx4_inode_entry ?
> 
> Ah-ha, it looks like it's _not_:
> 
>         if (!(bh = qnx4_find_entry(len, dir, name, &de, &ino)))
>                 goto out;
>         /* The entry is linked, let's get the real info */
>         if ((de->di_status & QNX4_FILE_LINK) == QNX4_FILE_LINK) {
>                 lnk = (struct qnx4_link_info *) de;
> 
> It seems that entries may be either struct qnx4_inode_entry or struct
> qnx4_link_info but it's not captured in a union.
> 
> This needs to be fixed by not lying to the compiler about what is there.
> 
> How about this?

The switch won't work since the _status field is a bit-field, so we should 
rather reuse the similar union-logic already present in fs/qnx4/dir.c

> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..3cd20065bcfa 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -26,31 +26,39 @@
>  static int qnx4_match(int len, const char *name,
>  		      struct buffer_head *bh, unsigned long *offset)
>  {
> -	struct qnx4_inode_entry *de;
> -	int namelen, thislen;
> +	union qnx4_dir_entry *de;
> +	char *entry_fname;
> +	int entry_len, entry_max_len;
> 
>  	if (bh == NULL) {
>  		printk(KERN_WARNING "qnx4: matching unassigned buffer !
\n");
>  		return 0;
>  	}
> -	de = (struct qnx4_inode_entry *) (bh->b_data + *offset);
> +	de = (union qnx4_dir_entry *) (bh->b_data + *offset);
>  	*offset += QNX4_DIR_ENTRY_SIZE;
> -	if ((de->di_status & QNX4_FILE_LINK) != 0) {
> -		namelen = QNX4_NAME_MAX;
> -	} else {
> -		namelen = QNX4_SHORT_NAME_MAX;
> -	}
> -	thislen = strlen( de->di_fname );
> -	if ( thislen > namelen )
> -		thislen = namelen;
> -	if (len != thislen) {
> +
> +	switch (de->inode.di_status) {
> +	case QNX4_FILE_LINK:
> +		entry_fname = de->link.dl_fname;
> +		entry_max_len = sizeof(de->link.dl_fname);
> +		break;
> +	case QNX4_FILE_USED:
> +		entry_fname = de->inode.di_fname;
> +		entry_max_len = sizeof(de->inode.di_fname);
> +		break;
> +	default:
>  		return 0;
>  	}
> -	if (strncmp(name, de->di_fname, len) == 0) {
> -		if ((de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) !
= 0) {
> -			return 1;
> -		}
> -	}
> +
> +	/* Directory entry may not be %NUL-terminated. */
> +	entry_len = strnlen(entry_fname, entry_max_len);
> +
> +	if (len != entry_len)
> +		return 0;
> +
> +	if (strncmp(name, entry_fname, len) == 0)
> +		return 1;
> +
>  	return 0;
>  }
> 
> diff --git a/include/uapi/linux/qnx4_fs.h b/include/uapi/linux/qnx4_fs.h
> index 31487325d265..e033dbe1e009 100644
> --- a/include/uapi/linux/qnx4_fs.h
> +++ b/include/uapi/linux/qnx4_fs.h
> @@ -68,6 +68,13 @@ struct qnx4_link_info {
>  	__u8		dl_status;
>  };
> 
> +union qnx4_dir_entry {
> +	struct qnx4_inode_entry inode;
> +	struct qnx4_link_info link;
> +};
> +_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
> +	       offsetof(struct qnx4_link_info, dl_status));
> +
>  struct qnx4_xblk {
>  	__le32		xblk_next_xblk;
>  	__le32		xblk_prev_xblk;




