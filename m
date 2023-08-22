Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACF78369A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjHVANs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHVANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849AE183;
        Mon, 21 Aug 2023 17:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22CB06118C;
        Tue, 22 Aug 2023 00:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84744C433C9;
        Tue, 22 Aug 2023 00:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692663224;
        bh=UgIRYlWtSKpqnjptiM7s42UW4jmXBHfTeWMP0B00iOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cXmi2q0YNU7rbEqeBrJOygt9wEmm1bQVvsIgYIPBym4VBpwkFcDrHfSUpHZJXNHAu
         wiDiZUsZXREhkHZ1VcdBfmFUqpWLQKUznHmHuzRI80z1Z+nL9Ijr41Q7860kv8K4Vk
         8CEd9nNYIFcFKu9ydNxXIMn9lutCRq2Hg4J/in+fheo96yKHkYqews8jOUPNeon5jX
         ZHX8TFuGp6Qi3CjsKYY4qaP+bFmPSp2IB8sYEkNzT5n57l4nGMARMzvrQQwyBqT3xC
         FADVdN5MOnsbW01vYPgBk5WylMinMb+wsAA7m6zunqFXjKQrVRC8gMRLT7BAztuxhx
         qkmbyrd+FnuTw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5008d16cc36so169345e87.2;
        Mon, 21 Aug 2023 17:13:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLVEyy6A+ZdiKTSsfkQMX10wIIdXWjT8qev18H84jlFNHwIehs
        DnhGEzCrR1huyiKfi326H8QihiLRaF/EMetM39s=
X-Google-Smtp-Source: AGHT+IG6OV3TVgYLr1gSHUxBYslXaZ8HboBlWExAqfnDD4H94PY8OT4HjFPFD2ta5g1sJjrkW8Kw+AEdufWtwMAqB8A=
X-Received: by 2002:ac2:4ad1:0:b0:500:7f51:d129 with SMTP id
 m17-20020ac24ad1000000b005007f51d129mr3063396lfp.34.1692663222515; Mon, 21
 Aug 2023 17:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com> <20230803132751.2741652-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230803132751.2741652-4-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Aug 2023 17:13:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Q6Mf=GqRcGbMrrU_4gPvyOdJz2ZkEKZVOT=mfeQtpjg@mail.gmail.com>
Message-ID: <CAPhsuW6Q6Mf=GqRcGbMrrU_4gPvyOdJz2ZkEKZVOT=mfeQtpjg@mail.gmail.com>
Subject: Re: [PATCH -next 3/7] md: don't rely on 'mddev->pers' to be set in mddev_suspend()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 6:30=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Now that active io is initialized when mddev is allocated, it's safe to
> call mddev_suspend() before 'mddev->pers' is set.
>
> This also prevent null-ptr-def in some cases that caller doesn't
> guarantee 'mddev->pers' to be set.

This description is a little confusing (to me at least). Please revise it.

Other than that, the set looks good to me.

Thanks,
Song

>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 897e94a9e47d..f14f2f0a9484 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -448,7 +448,7 @@ void mddev_suspend(struct mddev *mddev)
>         set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
>         percpu_ref_kill(&mddev->active_io);
>
> -       if (mddev->pers->prepare_suspend)
> +       if (mddev->pers && mddev->pers->prepare_suspend)
>                 mddev->pers->prepare_suspend(mddev);
>
>         wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io))=
;
> --
> 2.39.2
>
