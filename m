Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD37626F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGYWi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjGYWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:37:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191F55BA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:30:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d0e009433c4so3434199276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690324161; x=1690928961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR9Rsw7mOBovSF23sZH22jr/PNQU7PsjHK4/ezfBy1A=;
        b=vctBl8iNibEMT6RyK1mIMkzlSYEoOHled58OOFPA53jFJwOkeQ1vr/6bXyqbSUsFAF
         rGQaLfX9x1Td7IYxqBP+5kTi6Uh1jRalUAxPnvmE75juxDlqyYrToK9XrfMxSBDjvpAm
         GAmhcy2h9o3BCqvGTo5QB37O844WWjY+mcjH8bviG1li2UjDxEV576kiIQpE99JNfeVb
         Tlh42BzUVIW6+VHghz4J1P0GJS+NoHkHX1MF6JEsvaZUSoJ0YlChN0+60ACpg/xpAvhC
         9mWjGQtMFL5O4i/UQp7cI/ioCMv21B2ouDX1Y4GGYESFcim6L6h+U1bSxyHae3gX+jrb
         GD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324161; x=1690928961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR9Rsw7mOBovSF23sZH22jr/PNQU7PsjHK4/ezfBy1A=;
        b=g3Pt/CWswLHmMUQY6DD4ksoodBPsGOU7MS0C3qh0Nzy9ZmAtw60D92MbsHO9dXK6Mp
         3HsVRMBaXpNymTCmw99deuk+Tezi9SWhmCn+fNcebhzcaTagWyuo2y0Bbs1Os07fAueK
         0j+AbVPXZjc2G0tbK5t4kMwubGEGSwn+I3fwoJo2U/HmnrxHQgVu8mCgDwC+OIinVa17
         I3MEFKhVmMW/s01AYgG0H5LoVY2IbqwI2vmZmZqtygnxw+Ei5AkJo4/402PpN2m5O6ww
         PsZHmjOPLKej184lK13UGTtHhe/6//u4QGyPyD9lLXkvBGyJdxzHAHrXQx+1bYoKnbFa
         tWzQ==
X-Gm-Message-State: ABy/qLZH+rK8Rj/AIj9Vna2Dzc3NeubxTHXq5rQTtGKW5wolsjtPHZkz
        ArBZxyoluT23xhmNXfhI3jidNLy3UaX80VdGHabckA==
X-Google-Smtp-Source: APBJJlEdPf+ZZiDTPLEUsJhdKbzvKrqvNO39weDJ1KxGr3Wx0WJe0Kyn7gPmdNao8H0M7sd5pakWAY3jt3Aq+y/oxew=
X-Received: by 2002:a25:d08b:0:b0:d0f:972b:637 with SMTP id
 h133-20020a25d08b000000b00d0f972b0637mr310497ybg.20.1690324160747; Tue, 25
 Jul 2023 15:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230725-fs-orangefs-remove-deprecated-strncpy-v1-1-f15f635cf820@google.com>
 <202307251452.66CB968@keescook>
In-Reply-To: <202307251452.66CB968@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 25 Jul 2023 15:29:10 -0700
Message-ID: <CAFhGd8qRyq=Fz++1SHxhLkj5Z6UkE97a-UobuUq2hfEwE=K=0w@mail.gmail.com>
Subject: Re: [PATCH] orangefs: replace strncpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 3:01=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jul 25, 2023 at 09:30:30PM +0000, justinstitt@google.com wrote:
> > This patch aims to eliminate `strncpy` usage across the orangefs
> > tree.
> >
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1].
> >
> > A suitable replacement is `strscpy` [2].
> >
> > Using the `strscpy` api over `strncpy` has a slight wrinkle in the use
> > cases presented within orangefs. There is frequent usage of `...LEN - 1=
`
> > which is no longer required since `strscpy` will guarantee
> > NUL-termination on its `dest` argument. As per `strscpy`s implementatio=
n
> > in `linux/lib/string.c`
> >
> > |       /* Hit buffer length without finding a NUL; force NUL-terminati=
on. */
> > |       if (res)
> > |               dest[res-1] =3D '\0';
> >
> > There are some hopes that someday the `strncpy` api could be ripped out
> > due to the vast number of suitable replacements (strscpy, strscpy_pad,
> > strtomem, strtomem_pad, strlcpy) [1].
> >
> > [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-=
nul-terminated-strings
> > [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> >
> > ---
> >
> >
> > Link: https://github.com/KSPP/linux/issues/90
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  fs/orangefs/dcache.c |  4 ++--
> >  fs/orangefs/namei.c  | 30 +++++++++++++++---------------
> >  fs/orangefs/super.c  | 14 +++++++-------
> >  3 files changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
> > index 8bbe9486e3a6..96ed9900f7a9 100644
> > --- a/fs/orangefs/dcache.c
> > +++ b/fs/orangefs/dcache.c
> > @@ -33,9 +33,9 @@ static int orangefs_revalidate_lookup(struct dentry *=
dentry)
> >
> >       new_op->upcall.req.lookup.sym_follow =3D ORANGEFS_LOOKUP_LINK_NO_=
FOLLOW;
> >       new_op->upcall.req.lookup.parent_refn =3D parent->refn;
> > -     strncpy(new_op->upcall.req.lookup.d_name,
> > +     strscpy(new_op->upcall.req.lookup.d_name,
> >               dentry->d_name.name,
> > -             ORANGEFS_NAME_MAX - 1);
> > +             ORANGEFS_NAME_MAX);
>
> Looking where new_op comes from, I see that it was already zero-filled,
> so this isn't also fixing a latent bug. (But I wanted to double-check.)
>
> >
> >       gossip_debug(GOSSIP_DCACHE_DEBUG,
> >                    "%s:%s:%d interrupt flag [%d]\n",
> > diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> > index 77518e248cf7..503d07769bb4 100644
> > --- a/fs/orangefs/namei.c
> > +++ b/fs/orangefs/namei.c
> > @@ -41,8 +41,8 @@ static int orangefs_create(struct mnt_idmap *idmap,
> >       fill_default_sys_attrs(new_op->upcall.req.create.attributes,
> >                              ORANGEFS_TYPE_METAFILE, mode);
> >
> > -     strncpy(new_op->upcall.req.create.d_name,
> > -             dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> > +     strscpy(new_op->upcall.req.create.d_name,
> > +             dentry->d_name.name, ORANGEFS_NAME_MAX);
> >
> >       ret =3D service_operation(new_op, __func__, get_interruptible_fla=
g(dir));
> >
> > @@ -137,8 +137,8 @@ static struct dentry *orangefs_lookup(struct inode =
*dir, struct dentry *dentry,
> >                    &parent->refn.khandle);
> >       new_op->upcall.req.lookup.parent_refn =3D parent->refn;
> >
> > -     strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> > -             ORANGEFS_NAME_MAX - 1);
> > +     strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> > +             ORANGEFS_NAME_MAX);
> >
> >       gossip_debug(GOSSIP_NAME_DEBUG,
> >                    "%s: doing lookup on %s under %pU,%d\n",
> > @@ -192,8 +192,8 @@ static int orangefs_unlink(struct inode *dir, struc=
t dentry *dentry)
> >               return -ENOMEM;
> >
> >       new_op->upcall.req.remove.parent_refn =3D parent->refn;
> > -     strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> > -             ORANGEFS_NAME_MAX - 1);
> > +     strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> > +             ORANGEFS_NAME_MAX);
> >
> >       ret =3D service_operation(new_op, "orangefs_unlink",
> >                               get_interruptible_flag(inode));
> > @@ -247,10 +247,10 @@ static int orangefs_symlink(struct mnt_idmap *idm=
ap,
> >                              ORANGEFS_TYPE_SYMLINK,
> >                              mode);
> >
> > -     strncpy(new_op->upcall.req.sym.entry_name,
> > +     strscpy(new_op->upcall.req.sym.entry_name,
> >               dentry->d_name.name,
> > -             ORANGEFS_NAME_MAX - 1);
> > -     strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX=
 - 1);
> > +             ORANGEFS_NAME_MAX);
> > +     strscpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX=
);
> >
> >       ret =3D service_operation(new_op, __func__, get_interruptible_fla=
g(dir));
> >
> > @@ -324,8 +324,8 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, =
struct inode *dir,
> >       fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
> >                             ORANGEFS_TYPE_DIRECTORY, mode);
> >
> > -     strncpy(new_op->upcall.req.mkdir.d_name,
> > -             dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> > +     strscpy(new_op->upcall.req.mkdir.d_name,
> > +             dentry->d_name.name, ORANGEFS_NAME_MAX);
> >
> >       ret =3D service_operation(new_op, __func__, get_interruptible_fla=
g(dir));
> >
> > @@ -405,12 +405,12 @@ static int orangefs_rename(struct mnt_idmap *idma=
p,
> >       new_op->upcall.req.rename.old_parent_refn =3D ORANGEFS_I(old_dir)=
->refn;
> >       new_op->upcall.req.rename.new_parent_refn =3D ORANGEFS_I(new_dir)=
->refn;
> >
> > -     strncpy(new_op->upcall.req.rename.d_old_name,
> > +     strscpy(new_op->upcall.req.rename.d_old_name,
> >               old_dentry->d_name.name,
> > -             ORANGEFS_NAME_MAX - 1);
> > -     strncpy(new_op->upcall.req.rename.d_new_name,
> > +             ORANGEFS_NAME_MAX);
> > +     strscpy(new_op->upcall.req.rename.d_new_name,
> >               new_dentry->d_name.name,
> > -             ORANGEFS_NAME_MAX - 1);
> > +             ORANGEFS_NAME_MAX);
> >
> >       ret =3D service_operation(new_op,
> >                               "orangefs_rename",
> > diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> > index 5254256a224d..b4af98b5a216 100644
> > --- a/fs/orangefs/super.c
> > +++ b/fs/orangefs/super.c
> > @@ -253,7 +253,7 @@ int orangefs_remount(struct orangefs_sb_info_s *ora=
ngefs_sb)
> >       new_op =3D op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
> >       if (!new_op)
> >               return -ENOMEM;
> > -     strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> > +     strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> >               orangefs_sb->devname,
> >               ORANGEFS_MAX_SERVER_ADDR_LEN);
>
> Was this a bug? (I think unreachable, both are
> ORANGEFS_MAX_SERVER_ADDR_LEN long, but devname would already be
> NUL-terminated.)
>
> Also, I wonder if all of these could be converted to:
>
>         strscpy(dest, source, sizeof(dest))
>

I wonder if this idiom is a bit awkward in this context due to `dest`
being quite a long series of struct accesses.
For reference:
| strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
|                 orangefs_sb->devname,
|                 sizeof(new_op->upcall.req.fs_mount.orangefs_config_server=
));

The resolution would be creating a temp variable for the purposes of
avoiding this long pattern. But that would mean it should probably be
done for all instances like this.

Is it worth it? Or is the long-winded sizeof(dest) OK?


> Which (I think) would be a no-op change, and seems like a more robust
> code style.

>
> >
> > @@ -400,8 +400,8 @@ static int orangefs_unmount(int id, __s32 fs_id, co=
nst char *devname)
> >               return -ENOMEM;
> >       op->upcall.req.fs_umount.id =3D id;
> >       op->upcall.req.fs_umount.fs_id =3D fs_id;
> > -     strncpy(op->upcall.req.fs_umount.orangefs_config_server,
> > -         devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> > +     strscpy(op->upcall.req.fs_umount.orangefs_config_server,
> > +         devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
> >       r =3D service_operation(op, "orangefs_fs_umount", 0);
> >       /* Not much to do about an error here. */
> >       if (r)
> > @@ -494,9 +494,9 @@ struct dentry *orangefs_mount(struct file_system_ty=
pe *fst,
> >       if (!new_op)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> > +     strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> >               devname,
> > -             ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> > +             ORANGEFS_MAX_SERVER_ADDR_LEN);
> >
> >       gossip_debug(GOSSIP_SUPER_DEBUG,
> >                    "Attempting ORANGEFS Mount via host %s\n",
> > @@ -543,9 +543,9 @@ struct dentry *orangefs_mount(struct file_system_ty=
pe *fst,
> >        * on successful mount, store the devname and data
> >        * used
> >        */
> > -     strncpy(ORANGEFS_SB(sb)->devname,
> > +     strscpy(ORANGEFS_SB(sb)->devname,
> >               devname,
> > -             ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> > +             ORANGEFS_MAX_SERVER_ADDR_LEN);
> >
> >       /* mount_pending must be cleared */
> >       ORANGEFS_SB(sb)->mount_pending =3D 0;
> >
> > ---
> > base-commit: 0b5547c51827e053cc754db47d3ec3e6c2c451d2
> > change-id: 20230725-fs-orangefs-remove-deprecated-strncpy-ae0d40124620
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>
> --
> Kees Cook



--=20
Justin
