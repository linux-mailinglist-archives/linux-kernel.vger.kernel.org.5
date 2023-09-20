Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3E7A7642
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjITIrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjITIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0394
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695199618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14VM4X1q7LDh2tjcesU2z1sSQLPjnF+BKTQYi/I+DZ8=;
        b=EOYkS4Fkd4S8ndG572pTnkIWIkCA1gluOoQmofcRBgzScrXO2Uo/wq1ciw+UOJlsOSSipO
        3NZpLZYRVSqFKkjD+X2apdKnmvSZuZBiHgHMMo9LGyiC4Ks95KD7+nMoW+BgVBrW4zegMM
        wA1KQxAhN54cfTGBWD+kMU5HLvybjws=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-aQPWEdtqMQuKyUd2VL68Iw-1; Wed, 20 Sep 2023 04:46:56 -0400
X-MC-Unique: aQPWEdtqMQuKyUd2VL68Iw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-690c2fec489so1602651b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695199615; x=1695804415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14VM4X1q7LDh2tjcesU2z1sSQLPjnF+BKTQYi/I+DZ8=;
        b=Q2UiG15YD7k1omwAJBM4kHuPiOPd7WlGqvUF6r4cFlBlQuH7x8UI1XzZw0siddFdqI
         YZBc7Ka8CJj9ySzD3gUKOD2XFNwtZQmsCFbO9IV8nj9/2bRjBIe3a2pYRrH+njqSGRlB
         P6zC9fMfnpzlYovvXud1XRctMLekhtdEeyETS/RLkaWSydCk0EQk6KyicwsYx6d4ackE
         0uMa+92EIxXZd4yUUaiClm0Xw1MBzDA1BdwordrUav7IGYf0hfA/JwEnlxpY7uBWBGCS
         2S6gy8CH3/K6pOHWflErEiwGejP9bPba1nkZ/yWJMXF2t5lf85x32ntqX2IxXdthrjSd
         QQ1Q==
X-Gm-Message-State: AOJu0YwvvqtlOVfa645sJ9O5+ERZSyfADpiKKovmGxg8DnywTJaADMiA
        WpAPh+968hOH9Y0f85Hg6qNh02UvLkQ9wHVC0wb7DA4ldDDNmS/zVxS/BVfyBxicTpSIkYsDMGb
        1OXJAOAlsD2s4RfEPxu5WC0ou/Hhtk8g7gMzJwUb1
X-Received: by 2002:a05:6a20:7f9d:b0:13d:df16:cf29 with SMTP id d29-20020a056a207f9d00b0013ddf16cf29mr2570689pzj.15.1695199614998;
        Wed, 20 Sep 2023 01:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQli6HeenG+HwcwmKNeEDbJ29I1E4luWIpovCpMd3Ahw3uOsfer9qoclzc94KX8UwaBMSafHxbTeav+Z1H7aY=
X-Received: by 2002:a05:6a20:7f9d:b0:13d:df16:cf29 with SMTP id
 d29-20020a056a207f9d00b0013ddf16cf29mr2570673pzj.15.1695199614768; Wed, 20
 Sep 2023 01:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com> <20230828020021.2489641-3-yukuai1@huaweicloud.com>
In-Reply-To: <20230828020021.2489641-3-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 20 Sep 2023 16:46:42 +0800
Message-ID: <CALTww29iHX_GHogGFEfzdaDjohBr8ycfiz2=E_ru4JYvmrTYdA@mail.gmail.com>
Subject: Re: [PATCH -next v2 02/28] md: use 'mddev->suspended' for is_md_suspended()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> 'pers->prepare_suspend' is introduced to prevent a deadlock for raid456,
> this change prepares to clean this up in later patches while refactoring
> mddev_suspend(). Specifically allow reshape to make progress while
> waiting for 'active_io' to be 0.

Hi Kuai

From my side, I can't understand the comments. The change has
relationship with pers->prepare_suspend? And why this change can
affect reshape? If this change indeed can affect these two things, can
you explain more?

>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 2 +-
>  drivers/md/md.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9d8dff9d923c..7fa311a14317 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -355,7 +355,7 @@ static DEFINE_SPINLOCK(all_mddevs_lock);
>   */
>  static bool is_suspended(struct mddev *mddev, struct bio *bio)
>  {
> -       if (is_md_suspended(mddev))
> +       if (is_md_suspended(mddev) || percpu_ref_is_dying(&mddev->active_=
io))

If we use mddev->suspended to judge if the raid is suspended, it
should be enough? Because mddev->suspended must be true when active_io
is dying.

Best Regards
Xiao
>                 return true;
>         if (bio_data_dir(bio) !=3D WRITE)
>                 return false;
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index b628c292506e..fb3b123f16dd 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -584,7 +584,7 @@ static inline bool md_is_rdwr(struct mddev *mddev)
>
>  static inline bool is_md_suspended(struct mddev *mddev)
>  {
> -       return percpu_ref_is_dying(&mddev->active_io);
> +       return READ_ONCE(mddev->suspended);
>  }
>
>  static inline int __must_check mddev_lock(struct mddev *mddev)
> --
> 2.39.2
>

