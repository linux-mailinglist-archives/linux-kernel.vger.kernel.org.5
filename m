Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97C764242
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGZWrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGZWrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:47:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329E2688
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:47:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a5ac8717c6so309273b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690411636; x=1691016436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xoVzDbg4QJJlZpH6pADqAgk1bifVbv9msMXiT6Ftqyg=;
        b=EWEsMMcWdRfjhkRETn2Fg5iRp74k76IqLbnD1ABoucuILbPiVlARs7uqlF7Wkqhfdc
         wb4cBJ0wnzMNDMYCfinX6jNy9kMOEnoEH2VxRNfOHjOUtucc2Wjz1nR0L+Z9v1bwSr4q
         fSfkxBTH5ud0BSTf91h2Y9G1EzIl5yIsU/ZJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690411636; x=1691016436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoVzDbg4QJJlZpH6pADqAgk1bifVbv9msMXiT6Ftqyg=;
        b=EPlLtgTv9HwGgzMYnv92JOpx7LnObwSQy+by1yldmVtfvKftJCtDXUVRA7N4MpoaGs
         rk1M75IP3h9FT3RTalhaLVUD615RYxvwQvMn6Qh8Ew8KboWwa5+WlXvg++l50W0nmM/g
         9inOYetFXsugQ0bY6A6ARgAXuMiZbX9M+klljmrUs5mRRegYf8Ia7/MzilNYrXfVuMfE
         4ZijbTCmkLZNWgh4tBbzsotrGSN40auuz77Der0tqkLVn31hJFRSClvTctrnNHg+uydo
         nklRkABPGGhwTNLM1mZ7HpC5FSg3G+Rb5+EqzVAFH9DLokBipMVdOkwo10bDFkF02Z37
         1lSQ==
X-Gm-Message-State: ABy/qLZRVv+3CpQBAHHECKd8NSK6Jfo1h8rO5wX4nwbpkBjk1/l1J5xW
        QqMfjusFpHRIqwTUOC/aCSWRtA==
X-Google-Smtp-Source: APBJJlFS3E55fpKbp3GEF1mEIQ8Je8ae3v9AuBRfz+Zh5xLYEzfnHYrZ9eMsMDsFaS5Kl2AxzE27WQ==
X-Received: by 2002:a05:6808:1789:b0:38e:a824:27d3 with SMTP id bg9-20020a056808178900b0038ea82427d3mr1187398oib.27.1690411635834;
        Wed, 26 Jul 2023 15:47:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d7-20020a637347000000b00563df2ba23bsm22649pgn.50.2023.07.26.15.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:47:15 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:47:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] orangefs: replace strncpy with strscpy
Message-ID: <202307261545.E6827CBAD2@keescook>
References: <20230725-fs-orangefs-remove-deprecated-strncpy-v1-1-f15f635cf820@google.com>
 <202307251452.66CB968@keescook>
 <CAFhGd8qRyq=Fz++1SHxhLkj5Z6UkE97a-UobuUq2hfEwE=K=0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qRyq=Fz++1SHxhLkj5Z6UkE97a-UobuUq2hfEwE=K=0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:29:10PM -0700, Justin Stitt wrote:
> On Tue, Jul 25, 2023 at 3:01 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 09:30:30PM +0000, justinstitt@google.com wrote:
> > > This patch aims to eliminate `strncpy` usage across the orangefs
> > > tree.
> > >
> > > `strncpy` is deprecated for use on NUL-terminated destination strings
> > > [1].
> > >
> > > A suitable replacement is `strscpy` [2].
> > >
> > > Using the `strscpy` api over `strncpy` has a slight wrinkle in the use
> > > cases presented within orangefs. There is frequent usage of `...LEN - 1`
> > > which is no longer required since `strscpy` will guarantee
> > > NUL-termination on its `dest` argument. As per `strscpy`s implementation
> > > in `linux/lib/string.c`
> > >
> > > |       /* Hit buffer length without finding a NUL; force NUL-termination. */
> > > |       if (res)
> > > |               dest[res-1] = '\0';
> > >
> > > There are some hopes that someday the `strncpy` api could be ripped out
> > > due to the vast number of suitable replacements (strscpy, strscpy_pad,
> > > strtomem, strtomem_pad, strlcpy) [1].
> > >
> > > [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> > > [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> > >
> > > ---
> > >
> > >
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > >  fs/orangefs/dcache.c |  4 ++--
> > >  fs/orangefs/namei.c  | 30 +++++++++++++++---------------
> > >  fs/orangefs/super.c  | 14 +++++++-------
> > >  3 files changed, 24 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
> > > index 8bbe9486e3a6..96ed9900f7a9 100644
> > > --- a/fs/orangefs/dcache.c
> > > +++ b/fs/orangefs/dcache.c
> > > @@ -33,9 +33,9 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
> > >
> > >       new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
> > >       new_op->upcall.req.lookup.parent_refn = parent->refn;
> > > -     strncpy(new_op->upcall.req.lookup.d_name,
> > > +     strscpy(new_op->upcall.req.lookup.d_name,
> > >               dentry->d_name.name,
> > > -             ORANGEFS_NAME_MAX - 1);
> > > +             ORANGEFS_NAME_MAX);
> >
> > Looking where new_op comes from, I see that it was already zero-filled,
> > so this isn't also fixing a latent bug. (But I wanted to double-check.)
> >
> > >
> > >       gossip_debug(GOSSIP_DCACHE_DEBUG,
> > >                    "%s:%s:%d interrupt flag [%d]\n",
> > > diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> > > index 77518e248cf7..503d07769bb4 100644
> > > --- a/fs/orangefs/namei.c
> > > +++ b/fs/orangefs/namei.c
> > > @@ -41,8 +41,8 @@ static int orangefs_create(struct mnt_idmap *idmap,
> > >       fill_default_sys_attrs(new_op->upcall.req.create.attributes,
> > >                              ORANGEFS_TYPE_METAFILE, mode);
> > >
> > > -     strncpy(new_op->upcall.req.create.d_name,
> > > -             dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> > > +     strscpy(new_op->upcall.req.create.d_name,
> > > +             dentry->d_name.name, ORANGEFS_NAME_MAX);
> > >
> > >       ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
> > >
> > > @@ -137,8 +137,8 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
> > >                    &parent->refn.khandle);
> > >       new_op->upcall.req.lookup.parent_refn = parent->refn;
> > >
> > > -     strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> > > -             ORANGEFS_NAME_MAX - 1);
> > > +     strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> > > +             ORANGEFS_NAME_MAX);
> > >
> > >       gossip_debug(GOSSIP_NAME_DEBUG,
> > >                    "%s: doing lookup on %s under %pU,%d\n",
> > > @@ -192,8 +192,8 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
> > >               return -ENOMEM;
> > >
> > >       new_op->upcall.req.remove.parent_refn = parent->refn;
> > > -     strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> > > -             ORANGEFS_NAME_MAX - 1);
> > > +     strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> > > +             ORANGEFS_NAME_MAX);
> > >
> > >       ret = service_operation(new_op, "orangefs_unlink",
> > >                               get_interruptible_flag(inode));
> > > @@ -247,10 +247,10 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
> > >                              ORANGEFS_TYPE_SYMLINK,
> > >                              mode);
> > >
> > > -     strncpy(new_op->upcall.req.sym.entry_name,
> > > +     strscpy(new_op->upcall.req.sym.entry_name,
> > >               dentry->d_name.name,
> > > -             ORANGEFS_NAME_MAX - 1);
> > > -     strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX - 1);
> > > +             ORANGEFS_NAME_MAX);
> > > +     strscpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX);
> > >
> > >       ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
> > >
> > > @@ -324,8 +324,8 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > >       fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
> > >                             ORANGEFS_TYPE_DIRECTORY, mode);
> > >
> > > -     strncpy(new_op->upcall.req.mkdir.d_name,
> > > -             dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> > > +     strscpy(new_op->upcall.req.mkdir.d_name,
> > > +             dentry->d_name.name, ORANGEFS_NAME_MAX);
> > >
> > >       ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
> > >
> > > @@ -405,12 +405,12 @@ static int orangefs_rename(struct mnt_idmap *idmap,
> > >       new_op->upcall.req.rename.old_parent_refn = ORANGEFS_I(old_dir)->refn;
> > >       new_op->upcall.req.rename.new_parent_refn = ORANGEFS_I(new_dir)->refn;
> > >
> > > -     strncpy(new_op->upcall.req.rename.d_old_name,
> > > +     strscpy(new_op->upcall.req.rename.d_old_name,
> > >               old_dentry->d_name.name,
> > > -             ORANGEFS_NAME_MAX - 1);
> > > -     strncpy(new_op->upcall.req.rename.d_new_name,
> > > +             ORANGEFS_NAME_MAX);
> > > +     strscpy(new_op->upcall.req.rename.d_new_name,
> > >               new_dentry->d_name.name,
> > > -             ORANGEFS_NAME_MAX - 1);
> > > +             ORANGEFS_NAME_MAX);
> > >
> > >       ret = service_operation(new_op,
> > >                               "orangefs_rename",
> > > diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> > > index 5254256a224d..b4af98b5a216 100644
> > > --- a/fs/orangefs/super.c
> > > +++ b/fs/orangefs/super.c
> > > @@ -253,7 +253,7 @@ int orangefs_remount(struct orangefs_sb_info_s *orangefs_sb)
> > >       new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
> > >       if (!new_op)
> > >               return -ENOMEM;
> > > -     strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> > > +     strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> > >               orangefs_sb->devname,
> > >               ORANGEFS_MAX_SERVER_ADDR_LEN);
> >
> > Was this a bug? (I think unreachable, both are
> > ORANGEFS_MAX_SERVER_ADDR_LEN long, but devname would already be
> > NUL-terminated.)
> >
> > Also, I wonder if all of these could be converted to:
> >
> >         strscpy(dest, source, sizeof(dest))
> >
> 
> I wonder if this idiom is a bit awkward in this context due to `dest`
> being quite a long series of struct accesses.
> For reference:
> | strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> |                 orangefs_sb->devname,
> |                 sizeof(new_op->upcall.req.fs_mount.orangefs_config_server));
> 
> The resolution would be creating a temp variable for the purposes of
> avoiding this long pattern. But that would mean it should probably be
> done for all instances like this.
> 
> Is it worth it? Or is the long-winded sizeof(dest) OK?

I wouldn't add a variable. For this, let's skip the use of sizeof(). I
think in the future we might be able to do some kind of treewide change
to fix all of these.

> 
> 
> > Which (I think) would be a no-op change, and seems like a more robust
> > code style.
> 
> >
> > >
> > > @@ -400,8 +400,8 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
> > >               return -ENOMEM;
> > >       op->upcall.req.fs_umount.id = id;
> > >       op->upcall.req.fs_umount.fs_id = fs_id;
> > > -     strncpy(op->upcall.req.fs_umount.orangefs_config_server,
> > > -         devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> > > +     strscpy(op->upcall.req.fs_umount.orangefs_config_server,
> > > +         devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
> > >       r = service_operation(op, "orangefs_fs_umount", 0);
> > >       /* Not much to do about an error here. */
> > >       if (r)
> > > @@ -494,9 +494,9 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
> > >       if (!new_op)
> > >               return ERR_PTR(-ENOMEM);
> > >
> > > -     strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> > > +     strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> > >               devname,
> > > -             ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> > > +             ORANGEFS_MAX_SERVER_ADDR_LEN);
> > >
> > >       gossip_debug(GOSSIP_SUPER_DEBUG,
> > >                    "Attempting ORANGEFS Mount via host %s\n",
> > > @@ -543,9 +543,9 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
> > >        * on successful mount, store the devname and data
> > >        * used
> > >        */
> > > -     strncpy(ORANGEFS_SB(sb)->devname,
> > > +     strscpy(ORANGEFS_SB(sb)->devname,
> > >               devname,
> > > -             ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> > > +             ORANGEFS_MAX_SERVER_ADDR_LEN);
> > >
> > >       /* mount_pending must be cleared */
> > >       ORANGEFS_SB(sb)->mount_pending = 0;
> > >
> > > ---
> > > base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
> > > change-id: 20230725-fs-orangefs-remove-deprecated-strncpy-ae0d40124620
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
> >
> > --
> > Kees Cook
> 
> 
> 
> -- 
> Justin

-- 
Kees Cook
