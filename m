Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E47CF929
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjJSMkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjJSMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA9A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697719188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wajlyLgkFhoViHX5JghcqO7IxybGxLAVgdga1pit+WU=;
        b=UjEE+3Wo1fo80rw1q4joChn/Uq+d5RIhseYmflzDxhqnw0nI1FOnA+RpSA2zRkLTmMADo6
        Y10DqVNpagRNmw5bCKmtUmoC85yR82MOspbk2AqT5auTmz1qPqb7BBsFW15BdvoCnvEw/3
        lE8HekZ8vkuieHMiObAULlqJQQ5bfsA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-SMlt6tGmPMW9PVBUWaY5Sg-1; Thu, 19 Oct 2023 08:39:47 -0400
X-MC-Unique: SMlt6tGmPMW9PVBUWaY5Sg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7e706287bso2597781a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697719186; x=1698323986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wajlyLgkFhoViHX5JghcqO7IxybGxLAVgdga1pit+WU=;
        b=NYaVfACjhEII+zxfsbiE5z4naGa6DMir6bvjx6+KI1i331E6q7cBcucku/eESDTfmn
         2YX8ROg/m67XeDqPd+G1JwLruPxyIQoe8iLUuLWiwcOjzYSoTR1n4wJnCa0oWDcd2YTG
         UcU71temWJ5OIbaMV52s62a2cL/GP72I7uQR9RYcqcN0cRqGGmPMvs2BvZxxjGUBJYJo
         MkQ80A8Dw6IWMLZU0CUW4eeurzMjUrTfJLweJYlDs47GOSXp0t9OHBtPuHLNZ80EnAAI
         oM3joAZXVPmwb0acC5yAy9nUetpCSYSTDMrydM6OTmRThK2pLiZYNnDpmp6/RJizaD5A
         Q+pQ==
X-Gm-Message-State: AOJu0YwtXm1kzwjdz9bFRiWxc5Qf5Jbofw5BO3Kwc4NcbVxNif+Ybfpa
        jmlb6OYtiTxhgDO5ipqwlvNAxA/m+ibfjjzyUToEuqIpUz5XTafA6bW7D8f+jV6PglVnfMIRvla
        HrS0YZLI1FAjRHXyF6YE9g3TnQF8GAGdshfhhT4X4
X-Received: by 2002:a17:90a:fb94:b0:27d:273:93ba with SMTP id cp20-20020a17090afb9400b0027d027393bamr1868219pjb.30.1697719186297;
        Thu, 19 Oct 2023 05:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVdGDMGhkg4ynXhmdI3cD0qA35dihSow/Nh0jr1avoEi3bp5OG4QQKS3CZciO164PRncmuRsk5cbTwNOQFt4A=
X-Received: by 2002:a17:90a:fb94:b0:27d:273:93ba with SMTP id
 cp20-20020a17090afb9400b0027d027393bamr1868194pjb.30.1697719185860; Thu, 19
 Oct 2023 05:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
 <20231018013359.GB3902@templeofstupid.com>
In-Reply-To: <20231018013359.GB3902@templeofstupid.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 19 Oct 2023 14:39:34 +0200
Message-ID: <CAOssrKdH5x7YAnK4P8+5O8V934XtbH9JBSvctyM-pSmDMCq8yQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: share lookup state between submount and its parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 3:34=E2=80=AFAM Krister Johansen
<kjlx@templeofstupid.com> wrote:
>
> Fuse submounts do not perform a lookup for the nodeid that they inherit
> from their parent.  Instead, the code decrements the nlookup on the
> submount's fuse_inode when it is instantiated, and no forget is
> performed when a submount root is evicted.
>
> Trouble arises when the submount's parent is evicted despite the
> submount itself being in use.  In this author's case, the submount was
> in a container and deatched from the initial mount namespace via a
> MNT_DEATCH operation.  When memory pressure triggered the shrinker, the
> inode from the parent was evicted, which triggered enough forgets to
> render the submount's nodeid invalid.
>
> Since submounts should still function, even if their parent goes away,
> solve this problem by sharing refcounted state between the parent and
> its submount.  When all of the references on this shared state reach
> zero, it's safe to forget the final lookup of the fuse nodeid.
>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Cc: stable@vger.kernel.org
> Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts"=
)
> ---
>  fs/fuse/fuse_i.h | 20 +++++++++++
>  fs/fuse/inode.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 105 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 405252bb51f2..0d1659c5016b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -63,6 +63,24 @@ struct fuse_forget_link {
>         struct fuse_forget_link *next;
>  };
>
> +/* Submount lookup tracking */
> +struct fuse_submount_lookup {
> +       /** Refcount */
> +       refcount_t count;
> +
> +       /** Unique ID, which identifies the inode between userspace
> +        * and kernel */
> +       u64 nodeid;
> +
> +       /** Number of lookups on this inode */
> +       u64 nlookup;

sl->nlookup will always be one.  So that can just be implicit and this
field can just go away.

> +
> +       /** The request used for sending the FORGET message */
> +       struct fuse_forget_link *forget;
> +
> +       struct rcu_head rcu;

RCU would be needed if any fields could be accessed from RCU protected
code.  But AFAICS there's no such access, so this shouldn't be needed.
  Am I missing something?

> +};
> +
>  /** FUSE inode */
>  struct fuse_inode {
>         /** Inode data */
> @@ -158,6 +176,8 @@ struct fuse_inode {
>          */
>         struct fuse_inode_dax *dax;
>  #endif
> +       /** Submount specific lookup tracking */
> +       struct fuse_submount_lookup *submount_lookup;
>  };
>
>  /** FUSE inode state bits */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 444418e240c8..dc1499e2074f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -68,6 +68,24 @@ struct fuse_forget_link *fuse_alloc_forget(void)
>         return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUN=
T);
>  }
>
> +static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
> +{
> +       struct fuse_submount_lookup *sl;
> +
> +       sl =3D kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_AC=
COUNT);
> +       if (!sl)
> +               return NULL;
> +       sl->forget =3D fuse_alloc_forget();
> +       if (!sl->forget)
> +               goto out_free;
> +
> +       return sl;
> +
> +out_free:
> +       kfree(sl);
> +       return NULL;
> +}
> +
>  static struct inode *fuse_alloc_inode(struct super_block *sb)
>  {
>         struct fuse_inode *fi;
> @@ -113,9 +131,24 @@ static void fuse_free_inode(struct inode *inode)
>         kmem_cache_free(fuse_inode_cachep, fi);
>  }
>
> +static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
> +                                        struct fuse_submount_lookup *sl)
> +{
> +       if (!refcount_dec_and_test(&sl->count))
> +               return;
> +
> +       if (sl->nlookup) {
> +               fuse_queue_forget(fc, sl->forget, sl->nodeid, sl->nlookup=
);
> +               sl->forget =3D NULL;
> +       }
> +       kfree(sl->forget);
> +       kfree_rcu(sl, rcu);
> +}
> +
>  static void fuse_evict_inode(struct inode *inode)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_submount_lookup *sl =3D NULL;
>
>         /* Will write inode on close/munmap and in all other dirtiers */
>         WARN_ON(inode->i_state & I_DIRTY_INODE);
> @@ -132,6 +165,15 @@ static void fuse_evict_inode(struct inode *inode)
>                                           fi->nlookup);
>                         fi->forget =3D NULL;
>                 }
> +
> +               spin_lock(&fi->lock);
> +               if (fi->submount_lookup) {
> +                       sl =3D fi->submount_lookup;
> +                       fi->submount_lookup =3D NULL;
> +               }
> +               spin_unlock(&fi->lock);

I don't think locking is needed.  Eviction happens only once and at
that point nobody else should be touching the inode.

> +               if (sl)
> +                       fuse_cleanup_submount_lookup(fc, sl);
>         }
>         if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
>                 WARN_ON(!list_empty(&fi->write_files));
> @@ -332,6 +374,14 @@ void fuse_change_attributes(struct inode *inode, str=
uct fuse_attr *attr,
>                 fuse_dax_dontcache(inode, attr->flags);
>  }
>
> +static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
> +                                     u64 nodeid)
> +{
> +       sl->nodeid =3D nodeid;
> +       sl->nlookup =3D 1;
> +       refcount_set(&sl->count, 1);
> +}
> +
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
>                             struct fuse_conn *fc)
>  {
> @@ -395,12 +445,22 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>          */
>         if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
>             S_ISDIR(attr->mode)) {
> +               struct fuse_inode *fi;
> +
>                 inode =3D new_inode(sb);
>                 if (!inode)
>                         return NULL;
>
>                 fuse_init_inode(inode, attr, fc);
> -               get_fuse_inode(inode)->nodeid =3D nodeid;
> +               fi =3D get_fuse_inode(inode);
> +               fi->nodeid =3D nodeid;
> +               fi->submount_lookup =3D fuse_alloc_submount_lookup();
> +               if (!fi->submount_lookup) {
> +                       iput(inode);
> +                       return NULL;
> +               }
> +               /* Sets nlookup =3D 1 on fi->submount_lookup->nlookup */
> +               fuse_init_submount_lookup(fi->submount_lookup, nodeid);
>                 inode->i_flags |=3D S_AUTOMOUNT;
>                 goto done;
>         }
> @@ -423,11 +483,11 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>                 iput(inode);
>                 goto retry;
>         }
> -done:
>         fi =3D get_fuse_inode(inode);
>         spin_lock(&fi->lock);
>         fi->nlookup++;
>         spin_unlock(&fi->lock);
> +done:
>         fuse_change_attributes(inode, attr, NULL, attr_valid, attr_versio=
n);
>
>         return inode;
> @@ -1465,6 +1525,8 @@ static int fuse_fill_super_submount(struct super_bl=
ock *sb,
>         struct super_block *parent_sb =3D parent_fi->inode.i_sb;
>         struct fuse_attr root_attr;
>         struct inode *root;
> +       struct fuse_submount_lookup *sl;
> +       struct fuse_inode *fi;
>
>         fuse_sb_defaults(sb);
>         fm->sb =3D sb;
> @@ -1487,12 +1549,32 @@ static int fuse_fill_super_submount(struct super_=
block *sb,
>          * its nlookup should not be incremented.  fuse_iget() does
>          * that, though, so undo it here.
>          */
> -       get_fuse_inode(root)->nlookup--;
> +       fi =3D get_fuse_inode(root);
> +       fi->nlookup--;
> +
>         sb->s_d_op =3D &fuse_dentry_operations;
>         sb->s_root =3D d_make_root(root);
>         if (!sb->s_root)
>                 return -ENOMEM;
>
> +       /*
> +        * Grab the parent's submount_lookup pointer and take a
> +        * reference on the shared nlookup from the parent.  This is to
> +        * prevent the last forget for this nodeid from getting
> +        * triggered until all users have finished with it.
> +        */
> +       spin_lock(&parent_fi->lock);

Root has just been allocated, no locking needed.

> +       sl =3D parent_fi->submount_lookup;
> +       if (sl) {

WARN_ON(!sl);

Thanks,
Miklos

