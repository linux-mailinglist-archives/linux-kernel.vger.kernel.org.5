Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3103A767E47
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjG2KpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG2KpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239068F;
        Sat, 29 Jul 2023 03:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB62C60B75;
        Sat, 29 Jul 2023 10:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F91C433C7;
        Sat, 29 Jul 2023 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690627503;
        bh=QKrBqbolOOxaTiWGKT2BMxkYZZvn5TZqjT8KkvNIpMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DgFa1ZUUCoB3uXmxgqMIsCn4DNQLTYwZ9Hna06Khvpbx7Y3wJDWjdEnjto1Ep9X4i
         n6XBlRZfFrQKUB/ujZbD7s5A1iJ3/GCPukISXKtrIhWtEQ7VbXejZ7C9RABRtGQMvQ
         085Av922ZQCrR6j/VxP0CAqVZ92QEQ12erN+QM1QoSUMasJtbobwr1wOKs9hYX0H+6
         Hpxg2PGl39tyfQWEp5J61tVrUXLFjcgIkDY+1g+pYCEMgW8CU4MS39AJmEwiWGmkM9
         bl6BrjEB387/Pt4t4en7zmugIBRfoZ1c524+XtOUe5ldG7iq3h06dbYVBuTrH1lBQB
         nKbOiNd/2qnKw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b962c226ceso43611701fa.3;
        Sat, 29 Jul 2023 03:45:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLY23KJBA6knnGjbkVo3wP6aE8qkykmRbNEknwEzFnlNWihg3tcG
        GED3ciOoPY6zMC+AKeIyYie0IOfw7IZPZ4Z7lgQ=
X-Google-Smtp-Source: APBJJlE9ctJmYgNQK6Eq4nB5LJW1M5eJ/AG1pFpCz15UuA27LV8NHAJLReCyqwADLFXSvaE8lLjtr/j9SpHS+HQArcc=
X-Received: by 2002:a2e:96cd:0:b0:2b9:d266:85ac with SMTP id
 d13-20020a2e96cd000000b002b9d26685acmr2333016ljj.48.1690627501117; Sat, 29
 Jul 2023 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230708091727.1417894-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230708091727.1417894-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 29 Jul 2023 18:44:48 +0800
X-Gmail-Original-Message-ID: <CAPhsuW4P9t6fhAg5EFvTVkf3WLQy0=NTpZ-+1fcYBn3uyn9bng@mail.gmail.com>
Message-ID: <CAPhsuW4P9t6fhAg5EFvTVkf3WLQy0=NTpZ-+1fcYBn3uyn9bng@mail.gmail.com>
Subject: Re: [PATCH -next v3] md/raid5-cache: fix a deadlock in r5l_exit_log()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, axboe@kernel.dk, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 5:19=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit b13015af94cf ("md/raid5-cache: Clear conf->log after finishing
> work") introduce a new problem:
>
> // caller hold reconfig_mutex
> r5l_exit_log
>  flush_work(&log->disable_writeback_work)
>                         r5c_disable_writeback_async
>                          wait_event
>                           /*
>                            * conf->log is not NULL, and mddev_trylock()
>                            * will fail, wait_event() can never pass.
>                            */
>  conf->log =3D NULL
>
> Fix this problem by setting 'config->log' to NULL before wake_up() as it
> used to be, so that wait_event() from r5c_disable_writeback_async() can
> exist. In the meantime, move forward md_unregister_thread() so that
> null-ptr-deref this commit fixed can still be fixed.
>
> Fixes: b13015af94cf ("md/raid5-cache: Clear conf->log after finishing wor=
k")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next. Thanks!

Song

> ---
>
> Changes in v3:
>  - Use a different solution.
>
>  drivers/md/raid5-cache.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 47ba7d9e81e1..2eac4a50d99b 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -3168,12 +3168,15 @@ void r5l_exit_log(struct r5conf *conf)
>  {
>         struct r5l_log *log =3D conf->log;
>
> -       /* Ensure disable_writeback_work wakes up and exits */
> -       wake_up(&conf->mddev->sb_wait);
> -       flush_work(&log->disable_writeback_work);
>         md_unregister_thread(&log->reclaim_thread);
>
> +       /*
> +        * 'reconfig_mutex' is held by caller, set 'confg->log' to NULL t=
o
> +        * ensure disable_writeback_work wakes up and exits.
> +        */
>         conf->log =3D NULL;
> +       wake_up(&conf->mddev->sb_wait);
> +       flush_work(&log->disable_writeback_work);
>
>         mempool_exit(&log->meta_pool);
>         bioset_exit(&log->bs);
> --
> 2.39.2
>
