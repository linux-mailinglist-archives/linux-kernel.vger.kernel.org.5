Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A297E07DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKCR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88ED51
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699034213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNA+l67MoVWS7ypovgLkbj2YKf092k4D0KUV2U937nY=;
        b=a8EQfVIO+TH44JzkaomBGdCdGdbUpUZT2FQgXFJ4aVweoa4h5iMiCGHNB4EKr3v/bUHjkx
        QWWjaewcgQYVi/zOris6X/LoP6JXOj5qmFgjdUE+jR/G2fNudngxRARblNJ6h3s4OSYppJ
        liC77EQpM48XuAZIvlCN0hc4ItsiW2w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-s6xaQ2r1PMecJgTgVwWOqg-1; Fri, 03 Nov 2023 13:56:52 -0400
X-MC-Unique: s6xaQ2r1PMecJgTgVwWOqg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c45a6a8832so36792766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 10:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034211; x=1699639011;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNA+l67MoVWS7ypovgLkbj2YKf092k4D0KUV2U937nY=;
        b=N1TTvtk2JwrIzvchIGpHpw8Hr6muMhfSqBRWerwpqahFxxhkbE4VD6Wq8Unt4KfVPH
         izC71wZGk1V9D8zs1SIAfk7m7Jnj64jKtJohIA9bjUSIcA9pUxCDZUWNB/sRgQcn3OAZ
         pirYPPyG2SjdTcGHq16JUoD6DU62G9A1LNEo7a6a4+lIy1mYsYzPNhgad1FSDghTG7yH
         zC69WwkCaVNz3VU2rzyHN4y46z4GKO+HiXOQlaM+bMpF2nPeTJP06wniUdCTJquIWAyi
         yxNLuK1jB1cO1+yFGVGryk99meOzq1uPYgnJHQ4jnAtb1lyAlbbiSl5dtq3jtm/gwfdT
         9H3g==
X-Gm-Message-State: AOJu0YxLZQ36GrF/H9oq7Tqx5OCmkdsv5x7nR3jphJTjBUzC5wC9Y6GR
        1NgHmI2+67pYGeAeXMN2rMqCSBSC3F5f9dwvYtU+FsEF94AujgizmBsmD6ASY1+XhJrUiRcY0QP
        TCqDQgr3qxdM1LURch4qVzf8g7sMWYYL8mZw=
X-Received: by 2002:a17:907:2d8c:b0:9cb:798f:91e8 with SMTP id gt12-20020a1709072d8c00b009cb798f91e8mr17329265ejc.6.1699034211249;
        Fri, 03 Nov 2023 10:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3vkbGmPpckSaE6mrMUhLK8LvUlwALiiWNoGPaTKQmCcqHXM/6/sDT4acWiauny2WdVyHAQ==
X-Received: by 2002:a17:907:2d8c:b0:9cb:798f:91e8 with SMTP id gt12-20020a1709072d8c00b009cb798f91e8mr17329255ejc.6.1699034210885;
        Fri, 03 Nov 2023 10:56:50 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709066d1500b009b9aa8fffdasm1129657ejr.131.2023.11.03.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:56:50 -0700 (PDT)
Message-ID: <437ec6fa34af1ccfadee2d62770e52d99ebf75c3.camel@redhat.com>
Subject: Re: [PATCH] fs/nilfs2: copy userspace-array safely
From:   Philipp Stanner <pstanner@redhat.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Date:   Fri, 03 Nov 2023 18:56:49 +0100
In-Reply-To: <CAKFNMok9WTV5uX3BBfr8eYiuJXvUY6TuYW=tQYvBzdCUYsxcwA@mail.gmail.com>
References: <20231102183751.47413-1-pstanner@redhat.com>
         <CAKFNMok9WTV5uX3BBfr8eYiuJXvUY6TuYW=tQYvBzdCUYsxcwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-04 at 02:44 +0900, Ryusuke Konishi wrote:
> On Fri, Nov 3, 2023 at 3:38=E2=80=AFAM Philipp Stanner wrote:
> >=20
> > ioctl.c utilizes memdup_user() to copy a userspace array. This is
> > done
> > without an overflow-check.
> >=20
> > Use the new wrapper memdup_array_user() to copy the array more
> > safely.
> >=20
> > Suggested-by: Dave Airlie <airlied@redhat.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > Linus recently merged this new wrapper for Kernel v6.7
>=20
> The following overflow check is performed just before the usage of
> memdup_user():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nsegs > UINT_MAX / sizeof(=
__u64))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out;
>=20
> This was introduced by commit 1ecd3c7ea76488 ("nilfs2: avoid
> overflowing segment numbers in nilfs_ioctl_clean_segments()") to
> avoid
> overflowing nsegs * sizeof(__u64) in the subsequent call to
> memdup_user().
>=20
> I learned about memdup_array_user() this time, and it seems to check
> for overflow when multiplying two size_t arguments (i.e. the number
> of
> elements and size of the array to be copied).
>=20
> Since size_t is 32-bit or 64-bit depending on the architecture, I
> think the overflow check that memdup_array_user() does
> is included in the above upper limit check by UINT_MAX.
>=20
> So, for security reasons, I don't think this change is necessary.=C2=A0
> (Am
> I missing something?)

No, I think you are right. My commit message was very generic =E2=80=93 it'=
s
more about unifying array-duplication.
I should rephrase it.

>=20
> In terms of cleanup, I think the clarification this patch brings is
> good, but in that case, I'm concerned about the duplication of
> overflow checks.

Alright, so would you prefer a patch that uses memdup_array_user() and,
consequently, removes the preceding check?

Regards,
P.

>=20
> Thanks,
> Ryusuke Konishi
>=20
> > ---
> > =C2=A0fs/nilfs2/ioctl.c | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> > index 40ffade49f38..6a9dceebb18d 100644
> > --- a/fs/nilfs2/ioctl.c
> > +++ b/fs/nilfs2/ioctl.c
> > @@ -877,11 +877,11 @@ static int nilfs_ioctl_clean_segments(struct
> > inode *inode, struct file *filp,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * argv[4] points to se=
gment numbers this ioctl cleans.=C2=A0 We
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * use kmalloc() for its buf=
fer because memory used for the
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * segment numbers is enough=
 small.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * use kmalloc() for its buf=
fer because the memory used for
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * segment numbers is small =
enough.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbufs[4] =3D memdup_user((void __=
user *)(unsigned
> > long)argv[4].v_base,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nsegs * sizeof(__u64));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbufs[4] =3D memdup_array_user((v=
oid __user *)(unsigned
> > long)argv[4].v_base,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nsegs, s=
izeof(__u64));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(kbufs[4])) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(kbufs[4]);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > --
> > 2.41.0
> >=20
>=20

