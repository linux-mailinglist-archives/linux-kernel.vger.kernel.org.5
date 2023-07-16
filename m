Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F6755053
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGPS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGPS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:26:58 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A71B1;
        Sun, 16 Jul 2023 11:26:57 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7653bd3ff2fso440987885a.3;
        Sun, 16 Jul 2023 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689532016; x=1692124016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDqz3XcpEmdsooDL2d6f33d1gtHOlfBuBe0GKeda5W0=;
        b=cUWS7VhzpjWbASia4mJb9n5nAuciY/ehbBPP+tRDGeDiOaAHYM5x54329SMnBU+84x
         sAVXiSUQuJep7Yqrq9EsgtgaSUA5sFOR+4cLwI+MEMsW97bclgxl61YgoGNgyHeYU8ux
         N1azxv+QGXHymVDqLxRLMiEBgcc7kkApt82Aezf2dg5fcgqaDnjsUkcQOOsJarlb+eMp
         Z9UeXXPklXWdqkPGEqN/JKrCrZpNiMk1yJelulvxMFUE9yH9uWqhI8NyFDeTzkBVrMdi
         RHYFUm5QdlOa8eDZhIbUzFvK7acX5BPWVm34RY6BPPeMGYtdsxX2jsYIQpLP76VelDCu
         YuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689532016; x=1692124016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDqz3XcpEmdsooDL2d6f33d1gtHOlfBuBe0GKeda5W0=;
        b=iJiMZsjhf0oN+zgdt8MoUItNBzSQMtX2dktFAiNP27L7+yaKd8Q+Ciknw43MvfuRuu
         gT4X6PgpowUhVeDwWDhx4hwKW7eXgAx0Rv6iZ2t7751GUb5S6aumvTI93hEItvpAgTDk
         XLRT5umollqEYsfuWYdS9Fqa2pKNLzZvQhMmhjMdMo64UZSJfOhCPoLyXZsMjVvgD2cR
         E0q1A0vyQJ0Z/pxQqoIevFWYyj5ufW+aKvp4l7mzwNPWsnkodHsR/oG7UhK0IuStImV5
         7jrxMgsDgRmlhERj1MtzPlLyg57DNXSL/FEV6Z4/K2nyBQQ2Z0Lb2FJgVUSzWkYVKAmQ
         z7TQ==
X-Gm-Message-State: ABy/qLaGpuC+CZX/T1PFR+IP6Z5JHhTFmyxzKGezruOzGWXiHmIa6RvI
        torhZvGKzcuagvDnExbEHyskJY6O0Daw033b830=
X-Google-Smtp-Source: APBJJlEbnYgGblba7Wm8fEcJ9Beo7PgjUjM/te51xDatO+GcHzCqctWU8WYDI+2v8enW0eqL6ltziK1sqt+YenIwd7Y=
X-Received: by 2002:a05:620a:2801:b0:75b:23a1:362e with SMTP id
 f1-20020a05620a280100b0075b23a1362emr15843797qkp.63.1689532016157; Sun, 16
 Jul 2023 11:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230710032730.2049748-1-chengzhihao1@huawei.com>
In-Reply-To: <20230710032730.2049748-1-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Jul 2023 21:26:45 +0300
Message-ID: <CAOQ4uxg3_SGyOvy7gSQ_1=V9Zr1PxZyLUpHMK=nN+mr0do8cvg@mail.gmail.com>
Subject: Re: [PATCH 5.15] ovl: fix null pointer dereference in ovl_get_acl_rcu()
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 6:29=E2=80=AFAM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> [ Upstream commit f4e19e595cc2e76a8a58413eb19d3d9c51328b53 ]
>
> Following process:
>          P1                     P2
>  path_openat
>   link_path_walk
>    may_lookup
>     inode_permission(rcu)
>      ovl_permission
>       acl_permission_check
>        check_acl
>         get_cached_acl_rcu
>          ovl_get_inode_acl
>           realinode =3D ovl_inode_real(ovl_inode)
>                               drop_cache
>                                __dentry_kill(ovl_dentry)
>                                 iput(ovl_inode)
>                                  ovl_destroy_inode(ovl_inode)
>                                   dput(oi->__upperdentry)
>                                    dentry_kill(upperdentry)
>                                     dentry_unlink_inode
>                                      upperdentry->d_inode =3D NULL
>             ovl_inode_upper
>              upperdentry =3D ovl_i_dentry_upper(ovl_inode)
>              d_inode(upperdentry) // returns NULL
>           IS_POSIXACL(realinode) // NULL pointer dereference
> , will trigger an null pointer dereference at realinode:
>   [  205.472797] BUG: kernel NULL pointer dereference, address:
>                  0000000000000028
>   [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
>                  6.3.0-12064-g2edfa098e750-dirty #1216
>   [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
>   [  205.489584] Call Trace:
>   [  205.489812]  <TASK>
>   [  205.490014]  ovl_get_inode_acl+0x26/0x30
>   [  205.490466]  get_cached_acl_rcu+0x61/0xa0
>   [  205.490908]  generic_permission+0x1bf/0x4e0
>   [  205.491447]  ovl_permission+0x79/0x1b0
>   [  205.491917]  inode_permission+0x15e/0x2c0
>   [  205.492425]  link_path_walk+0x115/0x550
>   [  205.493311]  path_lookupat.isra.0+0xb2/0x200
>   [  205.493803]  filename_lookup+0xda/0x240
>   [  205.495747]  vfs_fstatat+0x7b/0xb0
>
> Fetch a reproducer in [Link].
>
> Use the helper ovl_i_path_realinode() to get realinode and then do
> non-nullptr checking.
>
> There are some changes from upstream commit:
> 1. Corrusponds to do_ovl_get_acl() in 5.15 is ovl_get_acl()
> 2. ovl_i_path_real is not imported in 5.15, we can get realinode by
>    ovl_inode_real
> 3. CONFIG_FS_POSIX_ACL checking is dropped in commit
>    ded536561a3674327dfa4bb389085705cae22b8a ("ovl: improve ovl_get_acl()
>    if POSIX ACL support is off"), we still keep it in 5.15.

Zhihao,

Can you please provide also the backport for 6.1.

Basically, the same as this one without the CONFIG_FS_POSIX_ACL check.

Thanks,
Amir.

>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217404
> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
> Cc: <stable@vger.kernel.org> # v5.15
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/inode.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index d41f0c8e0e2a..65e5e6eb761a 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -453,7 +453,15 @@ struct posix_acl *ovl_get_acl(struct inode *inode, i=
nt type, bool rcu)
>         const struct cred *old_cred;
>         struct posix_acl *acl;
>
> -       if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
> +       if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
> +               return NULL;
> +
> +       if (!realinode) {
> +               WARN_ON(!rcu);
> +               return ERR_PTR(-ECHILD);
> +       }
> +
> +       if (!IS_POSIXACL(realinode))
>                 return NULL;
>
>         if (rcu)
> --
> 2.39.2
>
