Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5987CDB06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjJRLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJRLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:55:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13AD111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:55:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF67C433C7;
        Wed, 18 Oct 2023 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697630106;
        bh=kouUTomVRzr7+i4EflHX4+HRDMLMZ32DMLiuSrpZcr4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tlWAylwoWt9UwBsG6597itkE7ntW1+/H7s9JPrA3jTSumJNKZiz2ZrGbxjxRcUDoq
         rLE85Z0hQNvClI0CTM/s/mQKQmRQR4aUxflm8V01W77qvbiT06Uaax8kRiot22Gsih
         wVgE4Urw7D92iNwUUMzNvU2K58b1suqibPJ76hzYTnDoR0O3fXCk2FIcciFFw18ABK
         VhkBJVfjHCEh2HV1KGzyS0k0cWLeHbxQnQmjCoG88xuZQjC+7Pi729swy5WEdKYFAA
         xpkaQZGAfFscaRKbUds18xIiCroZcfr//M5wP/7msxi8ubKHEjl0Ekd6Fz0oqgNnsi
         d/HSQJSVJbxsQ==
Message-ID: <d727d2c860f28c5c1206b4ec2be058b87d787e4f.camel@kernel.org>
Subject: Re: [PATCH] fat: fix mtime handing in __fat_write_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Klara Modin <klarasmodin@gmail.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 18 Oct 2023 07:55:04 -0400
In-Reply-To: <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
References: <20231018-amtime-v1-1-e066bae97285@kernel.org>
         <CABq1_vhoWrKuDkdogeHufnPn68k9RLsRiZM6H8fp-zoTwnvd_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for the bug report and testing! Do you mind if we add your
Tested-by: for this patch?

Thanks!
Jeff

On Wed, 2023-10-18 at 13:44 +0200, Klara Modin wrote:
> I can confirm that this patch fixes the issue, thanks!
>
> Den ons 18 okt. 2023 kl 13:15 skrev Jeff Layton <jlayton@kernel.org>:
> >=20
> > Klara reported seeing mangled mtimes when dealing with FAT. Fix the
> > braino in the FAT conversion to the new timestamp accessors.
> >=20
> > Fixes: e57260ae3226 (fat: convert to new timestamp accessors)
> > Reported-by: Klara Modin <klarasmodin@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This patch fixes the bug that Klara reported late yesterday. The issue
> > is a bad by-hand conversion of __fat_write_inode to the new timestamp
> > accessor functions.
> >=20
> > Christian, this patch should probably be squashed into e57260ae3226.
> >=20
> > Thanks!
> > Jeff
> > ---
> >  fs/fat/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> > index aa87f323fd44..1fac3dabf130 100644
> > --- a/fs/fat/inode.c
> > +++ b/fs/fat/inode.c
> > @@ -888,9 +888,9 @@ static int __fat_write_inode(struct inode *inode, i=
nt wait)
> >                 raw_entry->size =3D cpu_to_le32(inode->i_size);
> >         raw_entry->attr =3D fat_make_attrs(inode);
> >         fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
> > +       mtime =3D inode_get_mtime(inode);
> >         fat_time_unix2fat(sbi, &mtime, &raw_entry->time,
> >                           &raw_entry->date, NULL);
> > -       inode_set_mtime_to_ts(inode, mtime);
> >         if (sbi->options.isvfat) {
> >                 struct timespec64 ts =3D inode_get_atime(inode);
> >                 __le16 atime;
> >=20
> > ---
> > base-commit: fea0e8fc7829dc85f82c8a1a8249630f6fb85553
> > change-id: 20231018-amtime-24d2effcc9a9
> >=20
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
