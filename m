Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7547F63FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjKWQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKWQde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:33:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FB101
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:33:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA81BC433C9;
        Thu, 23 Nov 2023 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700757220;
        bh=n7DmIwyKviz3tCYFqOWllhkhDR0sRAl71s0NV7Z8TSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R7VaRNNjSmeiNuEbAFBbpvbkeXmdRSpGKBuWoeJ52+3oR0uw+WcHeIK+So/SzcQ18
         vAOeLiQ8BbUTAXJQTYB3uoMJtKRDOY7A8tsZv0a9KMd//dADSFgSItDyURsNt6FXEU
         44G1Et2Qt1sCC8KQtPxve3TWAuEjLo687RuRHJ458JIIF3lbV5rDv3T6los1GaK9yJ
         jw7bqYPxHXQBmUZDahyeKog8ipWzXRUvA8hvrRhXYadDN8dv/kck6KsuEtLmp0hdUF
         9Qad8xaSdUNSSnt5ozJaLza9b+9yaaAY7VGyC9ViFXBP3dpIJ0hKh0zFIvy/mooee4
         CuSAbogATqWug==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a002562bd8bso208451166b.0;
        Thu, 23 Nov 2023 08:33:40 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8ULzQQyu/qw+edWEYuGOu7OCSDyBoL6fBUN5F8dUAPgCibNsq
        OzkeLD/wS8hM9S97s4jpqdgEIoYt5gBhpYt+6KI=
X-Google-Smtp-Source: AGHT+IFNBm/qnHh7lZZlKjONcUKxD3A6RWxnkmHMl1h90xW+Xe4zWIvvcAUyqHPK7aU2vVbs3BZ/trx5xR8IyBeT3S4=
X-Received: by 2002:a17:906:100e:b0:9f2:8220:3f57 with SMTP id
 14-20020a170906100e00b009f282203f57mr2347284ejm.8.1700757219251; Thu, 23 Nov
 2023 08:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com> <20231123-josef-generic-163-v2-5-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-5-ed1a79a8e51e@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 23 Nov 2023 16:33:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5yRnxZQzvSoD0H6fWz2dmToxeE7v1v7gFt1Vstc6Q33w@mail.gmail.com>
Message-ID: <CAL3q7H5yRnxZQzvSoD0H6fWz2dmToxeE7v1v7gFt1Vstc6Q33w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] btrfs: reflow btrfs_free_tree_block
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 3:48=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Reflow btrfs_free_tree_block() so that there is one level of indentation
> needed.
>
> This patch has no functional changes.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent-tree.c | 97 +++++++++++++++++++++++++-------------------=
------
>  1 file changed, 49 insertions(+), 48 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 4044102271e9..093aaf7aeb3a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3426,6 +3426,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_ref generic_ref =3D { 0 };
> +       struct btrfs_block_group *cache;

While at it, can we rename 'cache' to something like 'bg'?

The cache name comes from the times where the structure was named
btrfs_block_group_cache, and having it named cache is always
confusing.

Nevertheless, the change looks fine to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>         int ret;
>
>         btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
> @@ -3439,64 +3440,64 @@ void btrfs_free_tree_block(struct btrfs_trans_han=
dle *trans,
>                 BUG_ON(ret); /* -ENOMEM */
>         }
>
> -       if (last_ref && btrfs_header_generation(buf) =3D=3D trans->transi=
d) {
> -               struct btrfs_block_group *cache;
> -               bool must_pin =3D false;
> -
> -               if (root_id !=3D BTRFS_TREE_LOG_OBJECTID) {
> -                       ret =3D check_ref_cleanup(trans, buf->start);
> -                       if (!ret)
> -                               goto out;
> -               }
> +       if (!last_ref)
> +               return;
>
> -               cache =3D btrfs_lookup_block_group(fs_info, buf->start);
> +       if (btrfs_header_generation(buf) !=3D trans->transid)
> +               goto out;
>
> -               if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> -                       pin_down_extent(trans, cache, buf->start, buf->le=
n, 1);
> -                       btrfs_put_block_group(cache);
> +       if (root_id !=3D BTRFS_TREE_LOG_OBJECTID) {
> +               ret =3D check_ref_cleanup(trans, buf->start);
> +               if (!ret)
>                         goto out;
> -               }
> +       }
>
> -               /*
> -                * If there are tree mod log users we may have recorded m=
od log
> -                * operations for this node.  If we re-allocate this node=
 we
> -                * could replay operations on this node that happened whe=
n it
> -                * existed in a completely different root.  For example i=
f it
> -                * was part of root A, then was reallocated to root B, an=
d we
> -                * are doing a btrfs_old_search_slot(root b), we could re=
play
> -                * operations that happened when the block was part of ro=
ot A,
> -                * giving us an inconsistent view of the btree.
> -                *
> -                * We are safe from races here because at this point no o=
ther
> -                * node or root points to this extent buffer, so if after=
 this
> -                * check a new tree mod log user joins we will not have a=
n
> -                * existing log of operations on this node that we have t=
o
> -                * contend with.
> -                */
> -               if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags=
))
> -                       must_pin =3D true;
> +       cache =3D btrfs_lookup_block_group(fs_info, buf->start);
>
> -               if (must_pin || btrfs_is_zoned(fs_info)) {
> -                       pin_down_extent(trans, cache, buf->start, buf->le=
n, 1);
> -                       btrfs_put_block_group(cache);
> -                       goto out;
> -               }
> +       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +               pin_down_extent(trans, cache, buf->start, buf->len, 1);
> +               btrfs_put_block_group(cache);
> +               goto out;
> +       }
>
> -               WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
> +       /*
> +        * If there are tree mod log users we may have recorded mod log
> +        * operations for this node.  If we re-allocate this node we
> +        * could replay operations on this node that happened when it
> +        * existed in a completely different root.  For example if it
> +        * was part of root A, then was reallocated to root B, and we
> +        * are doing a btrfs_old_search_slot(root b), we could replay
> +        * operations that happened when the block was part of root A,
> +        * giving us an inconsistent view of the btree.
> +        *
> +        * We are safe from races here because at this point no other
> +        * node or root points to this extent buffer, so if after this
> +        * check a new tree mod log user joins we will not have an
> +        * existing log of operations on this node that we have to
> +        * contend with.
> +        */
>
> -               btrfs_add_free_space(cache, buf->start, buf->len);
> -               btrfs_free_reserved_bytes(cache, buf->len, 0);
> +       if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
> +                    || btrfs_is_zoned(fs_info)) {
> +               pin_down_extent(trans, cache, buf->start, buf->len, 1);
>                 btrfs_put_block_group(cache);
> -               trace_btrfs_reserved_extent_free(fs_info, buf->start, buf=
->len);
> +               goto out;
>         }
> +
> +       WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
> +
> +       btrfs_add_free_space(cache, buf->start, buf->len);
> +       btrfs_free_reserved_bytes(cache, buf->len, 0);
> +       btrfs_put_block_group(cache);
> +       trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
> +
>  out:
> -       if (last_ref) {
> -               /*
> -                * Deleting the buffer, clear the corrupt flag since it d=
oesn't
> -                * matter anymore.
> -                */
> -               clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
> -       }
> +
> +       /*
> +        * Deleting the buffer, clear the corrupt flag since it doesn't
> +        * matter anymore.
> +        */
> +       clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
>  }
>
>  /* Can return -ENOMEM */
>
> --
> 2.41.0
>
>
