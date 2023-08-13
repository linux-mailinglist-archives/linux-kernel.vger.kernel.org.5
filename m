Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB377A9AD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjHMQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHMQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9AC35BC;
        Sun, 13 Aug 2023 09:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC45F63C6F;
        Sun, 13 Aug 2023 16:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E149C433CB;
        Sun, 13 Aug 2023 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943255;
        bh=A8rtalkaPUp0X1lMS7FHkQvW3kE/qLjRYzEHtmgMgUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j4ry2pHT86rbgwvRJzBOYt8EXrQjmzMO80yQJvtESgn1PLhHlnKsTj5LmyUQsxscb
         eTE9M5ZiiZfEyLVr4BRi7BduZHOJMfn/Uv84cHt4eSkPBcsDRetlQlKwYpid6oJviO
         iY1mXQAmCA7BOrU8QNLK3Mp7hZfsadvnHXfJ+Ew8CSC1dPJXFKao5BaTAwWhG4JkV1
         zlBKmQnyTMxxrukXAHhGGs6dm2oFnfNxWLPjyk3Tn70iSrZI+okcErU/rjSCobIuZ8
         tCzN5aNFs0Sx3OC5AYgsr854NhQ3dz1CLdYOvZx/mCy7j7GJLEUf+r4eQCpkOujzxg
         cXDUMA8HJ8jsw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe934c4decso4558021e87.1;
        Sun, 13 Aug 2023 09:14:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy9fGn8QK3GijQcA1TyWjU9nHfEy5QYNrI2OjnSSu4p4IcSUl3k
        im2gSrkCJZpOi4W4lCSJnFRfg+KIQ6DwZLraTJI=
X-Google-Smtp-Source: AGHT+IHTeTCSKFcc+GdE6ZGTrn5bs2PaS8meGz6jW+td0H8D4mGoDWdfpCabhJ07+7vD5tgU2wn87Qo0H7YTBfFv45c=
X-Received: by 2002:ac2:55ab:0:b0:4f8:7568:e948 with SMTP id
 y11-20020ac255ab000000b004f87568e948mr4287013lfg.51.1691943253215; Sun, 13
 Aug 2023 09:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com>
 <d8fde5d9-3ac5-0945-dc8e-315092a67528@huaweicloud.com> <CAPhsuW6UnqTowo0CZVZXcb_Z=OjV5xFwYqD1O6FO3CLqiKx2DQ@mail.gmail.com>
 <52ddb065-e778-53d0-9679-7a6879e8a8e9@huaweicloud.com>
In-Reply-To: <52ddb065-e778-53d0-9679-7a6879e8a8e9@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 20:13:59 +0400
X-Gmail-Original-Message-ID: <CAPhsuW5HjcV1UM_XcRrgj8EHj2CJe9YvFga=YJoB3Q+2N=DO8w@mail.gmail.com>
Message-ID: <CAPhsuW5HjcV1UM_XcRrgj8EHj2CJe9YvFga=YJoB3Q+2N=DO8w@mail.gmail.com>
Subject: Re: [PATCH v2] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 5:08=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/07/29 18:49, Song Liu =E5=86=99=E9=81=93:
> > On Mon, Jul 24, 2023 at 10:12=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> =E5=9C=A8 2023/07/22 15:53, Zhang Shurong =E5=86=99=E9=81=93:
> >>> If rddev->raid_disk is greater than mddev->raid_disks, there will be
> >>> an out-of-bounds in raid1_remove_disk(). We have already found
> >>> similar reports as follows:
> >>>
> >>> 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> >>> 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_d=
isk")
> >>>
> >>> Fix this bug by checking whether the "number" variable is
> >>> valid.
> >>
> >> LGTM
> >>
> >> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> >>> ---
> >>> Changes in v2:
> >>>    - Using conf->raid_disks instead of mddev->raid_disks.
> >>>
> >>>    drivers/md/raid1.c | 4 ++++
> >>>    1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>> index dd25832eb045..80aeee63dfb7 100644
> >>> --- a/drivers/md/raid1.c
> >>> +++ b/drivers/md/raid1.c
> >>> @@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mdd=
ev, struct md_rdev *rdev)
> >>>        struct r1conf *conf =3D mddev->private;
> >>>        int err =3D 0;
> >>>        int number =3D rdev->raid_disk;
> >>> +
> >>> +     if (unlikely(number >=3D conf->raid_disks))
> >>> +             goto abort;
> >
> > We need err =3D -EINVAL here.
>
> I think return 0 is right here, so that caller can remove this rdev
> from array successfully, this only need to return error for the case
> -EBUSY.

Ah, that's right. Applied to md-next.

Thanks,
Song
