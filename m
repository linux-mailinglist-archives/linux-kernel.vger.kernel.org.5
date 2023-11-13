Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2D7E9D07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKMNUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjKMNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:20:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897E1728
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:20:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55313C433CA;
        Mon, 13 Nov 2023 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699881643;
        bh=D9aqE1UhuSYJaTropKjIDnI8SkTMLSRsd5ABtfjBVXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HABgl6iqO6w1cOWdDbdIZQ8fOV79fuY43rXnmsvmd7S0FUBgESxAUY1w490+lUp6/
         oWbm+VasCTWEg/R1FRsgrZxR9rA764+wTUxXsIPxMgZw9hqBFfnk4FCKbW4AuCVJTN
         4LlQMTAl4fXUOCy1PgvwKizi5d+eTCZzTZdjikkh80rxBfmXS2csWufUrqdZczDYZG
         ARcug22KATT6oX7cMzXvJ16VOollWVx04Wel1gw7v/ANBOZ8BefRhYhGBqseG3Nqla
         3HPE3zWAWK4tLmkOCtAxwOvplZFngCPlI8mx97gx5iH4MZ4aUVPniYKUYyesNcnO+U
         WIG7N+8u1/lfQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso6614073a12.1;
        Mon, 13 Nov 2023 05:20:43 -0800 (PST)
X-Gm-Message-State: AOJu0Ywfu2W89VeotQ4dKYwan0McZ48eW+YE0RHpY3K5tXx3qj5unWV9
        qCmkpe/5LEo3NNQNpsGSqbdEkQtOTLyj5vB0NJI=
X-Google-Smtp-Source: AGHT+IGRyx0bNzA1rxQ+Z/9/jWT+ZhaFPbDC1Pr2rZ8fammqILeWI9HrrIurTu6SCC1Jh4guvhjD0aylXZw1SxpBtOQ=
X-Received: by 2002:a17:906:b1b:b0:9ae:5370:81d5 with SMTP id
 u27-20020a1709060b1b00b009ae537081d5mr4067918ejg.41.1699881641774; Mon, 13
 Nov 2023 05:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20231112165648.10537-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231112165648.10537-1-bragathemanick0908@gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 Nov 2023 13:20:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H72WXSSS-crLCGi=07x8F58j9k7B9Udk8k2MVwgptO27g@mail.gmail.com>
Message-ID: <CAL3q7H72WXSSS-crLCGi=07x8F58j9k7B9Udk8k2MVwgptO27g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: ref-verify: fix memory leaks
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 4:57=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
> In btrfs_ref_tree_mod(), when !parent 're' was allocated
> through kmalloc(). In the following code, if an error occurs,
> the execution will be redirected to 'out' or 'out_unlock' and
> the function will be exited. However, on some of the paths,
> 're' are not deallocated and may lead to memory leaks.
>
> For example : lookup_block_entry() for 'be' returns null, the
> out label will be invoked. During that flow ref and ra was
> freed but not re, which can potentially lead to memleak
>
> Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd66de4cbf532749df35f
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  fs/btrfs/ref-verify.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 95d28497de7c..50b59b3dc474 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -791,6 +791,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>                         dump_ref_action(fs_info, ra);
>                         kfree(ref);
>                         kfree(ra);
> +                       kfree(re);

Here it's fine, 're' was not yet added to the rbtree (be->roots).

>                         goto out_unlock;
>                 } else if (be->num_refs =3D=3D 0) {
>                         btrfs_err(fs_info,
> @@ -800,6 +801,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>                         dump_ref_action(fs_info, ra);
>                         kfree(ref);
>                         kfree(ra);
> +                       kfree(re);

Same here.

>                         goto out_unlock;
>                 }
>
> @@ -822,6 +824,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>                                 dump_ref_action(fs_info, ra);
>                                 kfree(ref);
>                                 kfree(ra);
> +                               kfree(re);

Here it's not ok. 're' was added to the rbtree, so you can't free it,
as later when accessing the tree, it will trigger a use-after-free
bug.

>                                 goto out_unlock;
>                         }
>                         exist->num_refs--;
> @@ -838,6 +841,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>                         dump_ref_action(fs_info, ra);
>                         kfree(ref);
>                         kfree(ra);
> +                       kfree(re);

Same here, it will lead to a use-after-free.

>                         goto out_unlock;
>                 }
>                 kfree(ref);
> @@ -849,6 +853,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>                         dump_ref_action(fs_info, ra);
>                         kfree(ref);
>                         kfree(ra);
> +                       kfree(re);

Same here, it will lead to a use-after-free.

Thanks.
>                         goto out_unlock;
>                 }
>         }
> --
> 2.34.1
>
>
