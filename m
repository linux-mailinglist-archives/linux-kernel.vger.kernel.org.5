Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478A77DC297
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjJ3Wo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3Wo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B598E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698705818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVen+98WnwQurJDGWUrJb3G/4jC7KQVwkhzvb2b+SJw=;
        b=TWVS+PuWEfmEZgOKUlq/0x/Xx5BG6mc7y3Wa0bZajna7T6PrsEITrFtGCs8yLw4bRMWRYb
        6JgE+o9untUn4BhsznRPxdrENGnEfV9RAgoQDBKWMn66CoJy/KjKvEhK9pilcUn8nri7YY
        Dvi4bDI1QVTqcHw6KP90YpcPINBEx7U=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-vmGVDVhuPrmaC9huxvZnlQ-1; Mon, 30 Oct 2023 18:43:37 -0400
X-MC-Unique: vmGVDVhuPrmaC9huxvZnlQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc23aa0096so24095435ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698705516; x=1699310316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVen+98WnwQurJDGWUrJb3G/4jC7KQVwkhzvb2b+SJw=;
        b=sbu8G7y/WCjzmUj30gxEE1Ga7IeunyQ+rhEviIAwCMzMsQCdpPl+qDEcWAzfSwdQEr
         NS4EhLYO2/lOHWnAgQV66oJ/VcnQuSIU3m67UmUjnE96ZfA4XqqcNZfrOFyOq9iln8t4
         d9m61Y6O/tbTPxGUa+kuv2z7ilwkjUbyYdGs3X21Si+QosMqQ/fXNhLtYm5N8C0HLSd+
         0MxgW/ttBFfuO92Upi7SEH6wFdYNtfKTrgsQo6WmUTjjIHaGW+C4TUw4Wj5hv7aefYDl
         WSFd7TQUlOYZWy6UhgmrcRjh/n7wyBsxqvJbuwIreiI2MHloTvZ9OEAib8IqvaQzH+3f
         VBgw==
X-Gm-Message-State: AOJu0YykUwU6lbq4WzG7sf3ur6K93BOrPuWf+LJ2RhvtF0ZxSp7PNXqG
        NHzcf40I6KPTSQj854djdnIbstPSvjNi6sckFoi2m6blXHBTOxumf5n1KQO27N6Tp5PQNPU0xeG
        4KEK54aGu1Zo5s38ah9jlkcZ+QU+oWLjCuddRysLF
X-Received: by 2002:a17:903:2448:b0:1c9:b2c1:13a3 with SMTP id l8-20020a170903244800b001c9b2c113a3mr9944347pls.49.1698705516009;
        Mon, 30 Oct 2023 15:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrq6wv4fAKDM89bR7AcFO6+rXEiZBdcum9FGjplZFEeTMyDffvE1uHbFQRJVOR54meCmmTMypGBZ3ZfVNBW9k=
X-Received: by 2002:a17:903:2448:b0:1c9:b2c1:13a3 with SMTP id
 l8-20020a170903244800b001c9b2c113a3mr9944338pls.49.1698705515709; Mon, 30 Oct
 2023 15:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <VI1P193MB0752B3C3E2DF69C56BF5D6D199A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752B3C3E2DF69C56BF5D6D199A2A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 30 Oct 2023 23:38:24 +0100
Message-ID: <CAHc6FU41DktH6+Hxsv3kYSiXenjoLJ58P6+mO9Yjhex5M0=aVA@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     rpeterso@redhat.com, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Juntong,

On Sun, Oct 29, 2023 at 10:11=E2=80=AFPM Juntong Deng <juntong.deng@outlook=
.com> wrote:
> In gfs2_put_super(), whether withdrawn or not, the quota should
> be cleaned up by gfs2_quota_cleanup() and wait for all quota to
> be deallocated.
>
> Otherwise struct gfs2_sbd has been freed before gfs2_qd_dealloc
> (rcu callback) is completed, resulting in use-after-free.
>
> Also, gfs2_destroy_threads() and gfs2_quota_cleanup() have
> already been called in gfs2_make_fs_ro(), so there is no need to
> call them again subsequently, whether withdrawn or not.
>
> Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D29c47e9e51895928698c
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  fs/gfs2/super.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index a4b3655c5361..d21c04a22d73 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -602,13 +602,15 @@ static void gfs2_put_super(struct super_block *sb)
>         }
>         spin_unlock(&sdp->sd_jindex_spin);
>
> -       if (!sb_rdonly(sb)) {
> +       if (!sb_rdonly(sb))
>                 gfs2_make_fs_ro(sdp);
> -       }
> -       if (gfs2_withdrawn(sdp)) {
> -               gfs2_destroy_threads(sdp);
> +       else {
> +               if (gfs2_withdrawn(sdp))
> +                       gfs2_destroy_threads(sdp);
> +
>                 gfs2_quota_cleanup(sdp);
>         }
> +
>         WARN_ON(gfs2_withdrawing(sdp));
>
>         /*  At this point, we're through modifying the disk  */
> --
> 2.39.2

thanks for this fix, I've merged it.

Andreas

