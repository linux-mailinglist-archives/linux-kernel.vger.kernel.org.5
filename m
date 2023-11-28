Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3981A7FAED3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjK1ACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK1ACj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:02:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316C101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:02:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7ACC433C7;
        Tue, 28 Nov 2023 00:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701129766;
        bh=kbCPp2lWWjq4WvbabMGvx/QlyuZYXp3j11Zn5CDHNEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IiwE/ir7YW0GNrk0Gs3G4UBdma1XsA6zp0cKKTe23GN92X0pJKAFzChzAIltKYKtU
         gEHgPiT95q/30bhy159lZiFrBlSUYu2kHe+X0kRBYP540ZcDEgv8ITEunYdNuwmb11
         MeAPQaaPXv/TU+/YcI5k8j94AXiAqqExoyY4z7dkKUlx89ehBl2QNGd4CtoRW1W+CV
         QFM3DLv/iOvo5k7O7CzRIIUQlsY0XA+aETKaVk8EuDzYpFNVzvpd/0b7HREPA/1ivO
         w+WNX707s5Eih4Acs1JbOk+AuEghdGMykkMV7t+fNt2Wu5JRib697AaxHtEudq5uaN
         88n/ZADK+UG5w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c9a5d2e77bso17151561fa.2;
        Mon, 27 Nov 2023 16:02:46 -0800 (PST)
X-Gm-Message-State: AOJu0YyuJNI16og8rFbLGKZ1SIE5tLh92dpNPicNCBfbdvUIuwBbvvVP
        b8q7CDQC4SSTdh6baq+eUQ6m0zmK/5am1V03jAQ=
X-Google-Smtp-Source: AGHT+IEdb55rf4b4OyEvw0Vn4Kv1WyxFZB1FFEKH7Jkl77N9YUWrfkDu4s+Ti2CAhLc+d4YOilVzupYjTMGTEz3fu7Y=
X-Received: by 2002:a2e:2244:0:b0:2c9:a137:5d6d with SMTP id
 i65-20020a2e2244000000b002c9a1375d6dmr3407942lji.15.1701129764385; Mon, 27
 Nov 2023 16:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com> <20231124075953.1932764-2-yukuai1@huaweicloud.com>
In-Reply-To: <20231124075953.1932764-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Nov 2023 16:02:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5mjvpMmEN5g_-ADQgJKZ1=QyNxxSw-7kq-W2jww09Aag@mail.gmail.com>
Message-ID: <CAPhsuW5mjvpMmEN5g_-ADQgJKZ1=QyNxxSw-7kq-W2jww09Aag@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] md: fix missing flush of sync_work
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yukuai3@huawei.com, xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:00=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit ac619781967b ("md: use separate work_struct for md_start_sync()")
> use a new sync_work to replace del_work, however, stop_sync_thread() and
> __md_stop_writes() was trying to wait for sync_thread to be done, hence
> they should switch to use sync_work as well.
>
> Noted that md_start_sync() from sync_work will grab 'reconfig_mutex',
> hence other contex can't held the same lock to flush work, and this will
> be fixed in later patches.
>
> Fixes: ac619781967b ("md: use separate work_struct for md_start_sync()")

This fix should go via md-fixes branch. Please send it separately.

Thanks,
Song

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 09686d8db983..1701e2fb219f 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4865,7 +4865,7 @@ static void stop_sync_thread(struct mddev *mddev)
>                 return;
>         }
>
> -       if (work_pending(&mddev->del_work))
> +       if (work_pending(&mddev->sync_work))
>                 flush_workqueue(md_misc_wq);
>
>         set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> @@ -6273,7 +6273,7 @@ static void md_clean(struct mddev *mddev)
>  static void __md_stop_writes(struct mddev *mddev)
>  {
>         set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       if (work_pending(&mddev->del_work))
> +       if (work_pending(&mddev->sync_work))
>                 flush_workqueue(md_misc_wq);
>         if (mddev->sync_thread) {
>                 set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> --
> 2.39.2
>
