Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53A97EE377
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbjKPO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjKPO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:58:44 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D893
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:58:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso841111b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700146720; x=1700751520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1A1kbRe0EqpzNlHO8ETKahZUcPej3tPyJDaCd+sxobo=;
        b=RJ34yMS7kb6vtpRCJ5bcjplMFnH5O1lEKp7lKmDXna9pjqKJk8fC1FDUIW4G+Zdq4u
         k8DetfXOIK69riY4ImMwvCn5X64BwUyqayMTPKBPsP2qppwGi3aGWABz/e3Y1FAB5XJm
         gUQxEcE55ytjScuerMxjYOLHCQpSpRGPoFVNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146720; x=1700751520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A1kbRe0EqpzNlHO8ETKahZUcPej3tPyJDaCd+sxobo=;
        b=TzV1w7T8zhhUDvjh2jkMYBnE9O5BCez1qVwIATq5KIdZxEsn0DR5rh0nvivU6KBn6L
         YSyKE++EcJSWht36VQQS0DXOvqdJ0rtl+uE6trA08XcCS3dmDMwHIB9ZnSEvHcIwC0P/
         RwoGeIaDsSSgkcUEcDIR2Ua8Qk96mc4v16vCSBQukOVzaGcJqCkM3WersgMEMdFoPS34
         UZJ9I3W/5raLN4iciRYJyqOY7ZxDZp7gJZgT2A364+FOlI/8hTxjr3H7BpqlfMNq4UvA
         ctzwdEGrwkunjSZDTGIAbR+2+w0pl/bi9PV96ew1rsGtoVGMZR6kvtBlizHb4YihyhiJ
         613g==
X-Gm-Message-State: AOJu0YzgmM/y5Pe9+RFuAnalqaaV/74y8aSzeY6byoVqECyiw6M/hmn0
        urONkLKxUPi9SNWzJpqYVSIiEcjcNWIheXdEciugMg==
X-Google-Smtp-Source: AGHT+IEdmru+wY5lT+XOkjlm1I/VVxPC/GmyRA5uhEFdRfb1D3sfK88YRN2EGiwV7szXh9E0gBRkvg==
X-Received: by 2002:a05:6a00:1da0:b0:6bf:50df:2df5 with SMTP id z32-20020a056a001da000b006bf50df2df5mr20221097pfw.13.1700146720314;
        Thu, 16 Nov 2023 06:58:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006c34015a8f2sm4756291pfi.146.2023.11.16.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:58:39 -0800 (PST)
Date:   Thu, 16 Nov 2023 06:58:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     al@alarsen.net, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <202311160631.5ACFB84B7C@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <202311160612.C38BF44@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311160612.C38BF44@keescook>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 06:29:59AM -0800, Kees Cook wrote:
> On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> > qnx4 dir name length can vary to be of maximum size
> > QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> > 'link info' entry is stored and the status byte is set.
> > So to avoid buffer overflow check di_fname length
> > fetched from (struct qnx4_inode_entry *)
> > before use in strlen to avoid buffer overflow.
> > 
> > panic context
> > [ 4849.636861] detected buffer overflow in strlen
> > [ 4849.636897] ------------[ cut here ]------------
> > [ 4849.636902] kernel BUG at lib/string.c:1165!
> > [ 4849.636917] invalid opcode: 0000 [#2] SMP PTI
> > ..
> > [ 4849.637047] Call Trace:
> > [ 4849.637053]  <TASK>
> > [ 4849.637059]  ? show_trace_log_lvl+0x1d6/0x2ea
> > [ 4849.637075]  ? show_trace_log_lvl+0x1d6/0x2ea
> > [ 4849.637095]  ? qnx4_find_entry.cold+0xc/0x18 [qnx4]
> > [ 4849.637111]  ? show_regs.part.0+0x23/0x29
> > [ 4849.637123]  ? __die_body.cold+0x8/0xd
> > [ 4849.637135]  ? __die+0x2b/0x37
> > [ 4849.637147]  ? die+0x30/0x60
> > [ 4849.637161]  ? do_trap+0xbe/0x100
> > [ 4849.637171]  ? do_error_trap+0x6f/0xb0
> > [ 4849.637180]  ? fortify_panic+0x13/0x15
> > [ 4849.637192]  ? exc_invalid_op+0x53/0x70
> > [ 4849.637203]  ? fortify_panic+0x13/0x15
> > [ 4849.637215]  ? asm_exc_invalid_op+0x1b/0x20
> > [ 4849.637228]  ? fortify_panic+0x13/0x15
> > [ 4849.637240]  ? fortify_panic+0x13/0x15
> > [ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
> > [ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]
> > [ 4849.637275]  __lookup_slow+0x85/0x150
> > [ 4849.637291]  walk_component+0x145/0x1c0
> > [ 4849.637304]  ? path_init+0x2c0/0x3f0
> > [ 4849.637316]  path_lookupat+0x6e/0x1c0
> > [ 4849.637330]  filename_lookup+0xcf/0x1d0
> > [ 4849.637341]  ? __check_object_size+0x1d/0x30
> > [ 4849.637354]  ? strncpy_from_user+0x44/0x150
> > [ 4849.637365]  ? getname_flags.part.0+0x4c/0x1b0
> > [ 4849.637375]  user_path_at_empty+0x3f/0x60
> > [ 4849.637383]  vfs_statx+0x7a/0x130
> > [ 4849.637393]  do_statx+0x45/0x80
> > ..
> > 
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  fs/qnx4/namei.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > index 8d72221735d7..825b891a52b3 100644
> > --- a/fs/qnx4/namei.c
> > +++ b/fs/qnx4/namei.c
> > @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
> >  	} else {
> >  		namelen = QNX4_SHORT_NAME_MAX;
> >  	}
> > +
> > +	/** qnx4 dir name length can vary, check the di_fname
> > +	 * fetched from (struct qnx4_inode_entry *) before use in
> > +	 * strlen to avoid panic due to buffer overflow"
> > +	 */
> 
> Style nit: this comment should start with just "/*" alone, like:
> 
> 	/*
> 	 * qnx4 dir name ...
> 
> > +	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
> > +		return -ENAMETOOLONG;
> >  	thislen = strlen( de->di_fname );
> 
> de->di_fname is:
> 
> struct qnx4_inode_entry {
>         char            di_fname[QNX4_SHORT_NAME_MAX];
> 	...
> 
> #define QNX4_SHORT_NAME_MAX     16
> #define QNX4_NAME_MAX           48
> 
> It's always going to have a max of QNX4_SHORT_NAME_MAX. Is any of this
> code correct if namelen ends up being QNX4_NAME_MAX? It'll be reading
> past the end of di_fname.
> 
> Is bh->b_data actually struct qnx4_inode_entry ?

Ah-ha, it looks like it's _not_:

        if (!(bh = qnx4_find_entry(len, dir, name, &de, &ino)))
                goto out;
        /* The entry is linked, let's get the real info */
        if ((de->di_status & QNX4_FILE_LINK) == QNX4_FILE_LINK) {
                lnk = (struct qnx4_link_info *) de;

It seems that entries may be either struct qnx4_inode_entry or struct
qnx4_link_info but it's not captured in a union.

This needs to be fixed by not lying to the compiler about what is there.

How about this?


diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..3cd20065bcfa 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -26,31 +26,39 @@
 static int qnx4_match(int len, const char *name,
 		      struct buffer_head *bh, unsigned long *offset)
 {
-	struct qnx4_inode_entry *de;
-	int namelen, thislen;
+	union qnx4_dir_entry *de;
+	char *entry_fname;
+	int entry_len, entry_max_len;
 
 	if (bh == NULL) {
 		printk(KERN_WARNING "qnx4: matching unassigned buffer !\n");
 		return 0;
 	}
-	de = (struct qnx4_inode_entry *) (bh->b_data + *offset);
+	de = (union qnx4_dir_entry *) (bh->b_data + *offset);
 	*offset += QNX4_DIR_ENTRY_SIZE;
-	if ((de->di_status & QNX4_FILE_LINK) != 0) {
-		namelen = QNX4_NAME_MAX;
-	} else {
-		namelen = QNX4_SHORT_NAME_MAX;
-	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
-	if (len != thislen) {
+
+	switch (de->inode.di_status) {
+	case QNX4_FILE_LINK:
+		entry_fname = de->link.dl_fname;
+		entry_max_len = sizeof(de->link.dl_fname);
+		break;
+	case QNX4_FILE_USED:
+		entry_fname = de->inode.di_fname;
+		entry_max_len = sizeof(de->inode.di_fname);
+		break;
+	default:
 		return 0;
 	}
-	if (strncmp(name, de->di_fname, len) == 0) {
-		if ((de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) != 0) {
-			return 1;
-		}
-	}
+
+	/* Directory entry may not be %NUL-terminated. */
+	entry_len = strnlen(entry_fname, entry_max_len);
+
+	if (len != entry_len)
+		return 0;
+
+	if (strncmp(name, entry_fname, len) == 0)
+		return 1;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/qnx4_fs.h b/include/uapi/linux/qnx4_fs.h
index 31487325d265..e033dbe1e009 100644
--- a/include/uapi/linux/qnx4_fs.h
+++ b/include/uapi/linux/qnx4_fs.h
@@ -68,6 +68,13 @@ struct qnx4_link_info {
 	__u8		dl_status;
 };
 
+union qnx4_dir_entry {
+	struct qnx4_inode_entry inode;
+	struct qnx4_link_info link;
+};
+_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
+	       offsetof(struct qnx4_link_info, dl_status));
+
 struct qnx4_xblk {
 	__le32		xblk_next_xblk;
 	__le32		xblk_prev_xblk;


-- 
Kees Cook
