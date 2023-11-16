Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C27EE6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjKPS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKPS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:27:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88011A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:26:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-280cc5f3fdcso892996a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700159216; x=1700764016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ryv7O7n+GCzs6Fr4SKSqmKTxgqUPHr5PV33Ybnp7npk=;
        b=Slh+eTSdagDiBtU28Js3FC0N5BysKpZq8sKzI2WbqNuCLAExohIQqOqQF/Sz6mBgg+
         jkXwq8A/OC//9MbEbqP2dheNNvdN2FbeBsQFu4n3wm+do1Rio4HAlkuCluQNLMJnL1u8
         GiNwMobngoYKKu7Gh4w/fXYh7Lifkyarny6Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159216; x=1700764016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ryv7O7n+GCzs6Fr4SKSqmKTxgqUPHr5PV33Ybnp7npk=;
        b=bAjauHlp00gbKTQVg9kUyMERWcbeKzTEDs6ZzEEqt7w2dWPkx3wouLElnVz1icYMxF
         iseUo3JvYE5rem5C48+p1xzlWuSoS1K7mY8WnUHoKSuzxtL93e3nlg3ONCIJnHcFKNK7
         U3WmIPodAXbDBnaW+MSj+NMgq0Fe7etQMz6PTfrQH3IPd+qeDElzeqt8TlrsDH7YKP3N
         RTB63wY0n+lMzCP5dEkgrmG1TxN6o4WZL+EWZziTvlhoWDm5dEiv+DY/vV1+lWcoGfQA
         ldK53umxoUaYW5dGRVtcEZnYSXqAz6jsJpKkqdhgFmFNkibm2Qotq/CEwh3+D1jPKQjP
         eX9g==
X-Gm-Message-State: AOJu0YzWsNYxSDYQCiVqQt04GMZM0QfRC32M2qTCu/HUSfQw2b5vlvmy
        rs5u/Gh4YHdOF73BJB9+UYF9jg==
X-Google-Smtp-Source: AGHT+IHAgz6D04wSTUtxFQ/+pV7DvqhYbB4ucCOzSI+UsoyqYbzNG79z0FTVHTIWqtYeVVIQkxDXCQ==
X-Received: by 2002:a17:90b:33c3:b0:27f:bd9e:5a19 with SMTP id lk3-20020a17090b33c300b0027fbd9e5a19mr14077505pjb.25.1700159216203;
        Thu, 16 Nov 2023 10:26:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a7f8100b0027d0c3507fcsm1849274pjl.9.2023.11.16.10.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:26:55 -0800 (PST)
Date:   Thu, 16 Nov 2023 10:26:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Ronald Monthero <debug.penguin32@gmail.com>, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <202311161022.6B34F00641@keescook>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <202311160612.C38BF44@keescook>
 <202311160631.5ACFB84B7C@keescook>
 <2910678.e9J7NaK4W3@oscar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2910678.e9J7NaK4W3@oscar>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 05:48:20PM +0100, Anders Larsen wrote:
> On 2023-11-16 15:58 Kees Cook wrote:
> >         if ((de->di_status & QNX4_FILE_LINK) == QNX4_FILE_LINK) {
> >                 lnk = (struct qnx4_link_info *) de;
> > 
> > It seems that entries may be either struct qnx4_inode_entry or struct
> > qnx4_link_info but it's not captured in a union.
> > 
> > This needs to be fixed by not lying to the compiler about what is there.
> > 
> > How about this?
> 
> > diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> > index 8d72221735d7..3cd20065bcfa 100644
> > --- a/fs/qnx4/namei.c
> > +++ b/fs/qnx4/namei.c
> > @@ -26,31 +26,39 @@
> >  static int qnx4_match(int len, const char *name,
> >  		      struct buffer_head *bh, unsigned long *offset)
> >  {
> > -	struct qnx4_inode_entry *de;
> > -	int namelen, thislen;
> > +	union qnx4_dir_entry *de;
> > +	char *entry_fname;
> > +	int entry_len, entry_max_len;
> > 
> >  	if (bh == NULL) {
> >  		printk(KERN_WARNING "qnx4: matching unassigned buffer !
> \n");
> >  		return 0;
> >  	}
> > -	de = (struct qnx4_inode_entry *) (bh->b_data + *offset);
> > +	de = (union qnx4_dir_entry *) (bh->b_data + *offset);
> >  	*offset += QNX4_DIR_ENTRY_SIZE;
> > -	if ((de->di_status & QNX4_FILE_LINK) != 0) {
> > -		namelen = QNX4_NAME_MAX;
> > -	} else {
> > -		namelen = QNX4_SHORT_NAME_MAX;
> > -	}
> > -	thislen = strlen( de->di_fname );
> > -	if ( thislen > namelen )
> > -		thislen = namelen;
> > -	if (len != thislen) {
> > +
> > +	switch (de->inode.di_status) {
> > +	case QNX4_FILE_LINK:
> > +		entry_fname = de->link.dl_fname;
> > +		entry_max_len = sizeof(de->link.dl_fname);
> > +		break;
> > +	case QNX4_FILE_USED:
> > +		entry_fname = de->inode.di_fname;
> > +		entry_max_len = sizeof(de->inode.di_fname);
> > +		break;
> > +	default:
> >  		return 0;
> >  	}
> 
> The switch won't work since the _status field is a bit-field, so we should 
> rather reuse the similar union-logic already present in fs/qnx4/dir.c

Ah, okay, LINK and USED might both be there. And perfect, yes, it looks
like the union qnx4_directory_entry in fs/qnx4/dir.c would be perfect.

-Kees

> > -	if (strncmp(name, de->di_fname, len) == 0) {
> > -		if ((de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) !
> = 0) {
> > -			return 1;
> > -		}
> > -	}
> > +
> > +	/* Directory entry may not be %NUL-terminated. */
> > +	entry_len = strnlen(entry_fname, entry_max_len);
> > +
> > +	if (len != entry_len)
> > +		return 0;
> > +
> > +	if (strncmp(name, entry_fname, len) == 0)
> > +		return 1;
> > +
> >  	return 0;
> >  }
> > 
> > diff --git a/include/uapi/linux/qnx4_fs.h b/include/uapi/linux/qnx4_fs.h
> > index 31487325d265..e033dbe1e009 100644
> > --- a/include/uapi/linux/qnx4_fs.h
> > +++ b/include/uapi/linux/qnx4_fs.h
> > @@ -68,6 +68,13 @@ struct qnx4_link_info {
> >  	__u8		dl_status;
> >  };
> > 
> > +union qnx4_dir_entry {
> > +	struct qnx4_inode_entry inode;
> > +	struct qnx4_link_info link;
> > +};
> > +_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
> > +	       offsetof(struct qnx4_link_info, dl_status));
> > +
> >  struct qnx4_xblk {
> >  	__le32		xblk_next_xblk;
> >  	__le32		xblk_prev_xblk;
> 
> 
> 
> 

-- 
Kees Cook
