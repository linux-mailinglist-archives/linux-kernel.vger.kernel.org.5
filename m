Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2322E791216
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349321AbjIDH2G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbjIDH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:28:04 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2EC7;
        Mon,  4 Sep 2023 00:28:01 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58cbdf3eecaso10372247b3.0;
        Mon, 04 Sep 2023 00:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812480; x=1694417280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk7cz1JPGvo6NDX2t2vcHO0NvdY/bHCgp/ObJ6ZQiVg=;
        b=O/OrsVhyzw2VMouAKFQFdkZ+5mZaVN9QXSFIa4uQS7Y73+Hn0QyWdBPq2zr42sALBi
         UXvh0gBb4hMhQmyaASLQAO19QoCWuy1qUJRETCeGtelArSymyI6aRWcG/qVMqPL7w7lH
         8bG7YE69KDkwM927HicBUkKImMuoqd3hR6bW5Bvn9Qz+8v8lze+ipgityEXPhsjVQsTi
         kqqCLk6C7ECPw+y75vLmBScO+VCU094+zwmKMv5CzJJVH7ZnkPRc2+gJnGtS1EUidQkZ
         tO9/SskJ0ITRpmK03sfDILBsOQj6xkyhPLy7htS7ZreUzMsszPcG/BVkaAlCG2GkWrQ5
         xl4Q==
X-Gm-Message-State: AOJu0YyZCqXC+6xjMZr90yzzrZOhgTiAc4Z6QSLmET4OfHcXoi1wiP/s
        j6aFH4RPm63g9Q7IZsgHX3YR5b+BE4DiKw==
X-Google-Smtp-Source: AGHT+IFbqj7vzZSekCyg930BtsB+P61kkVAIIp7rOgsXjFv3uEUqsLj7JUXExc8slIkaku7cIU05dQ==
X-Received: by 2002:a0d:e801:0:b0:586:9f6c:41a0 with SMTP id r1-20020a0de801000000b005869f6c41a0mr10068124ywe.14.1693812480431;
        Mon, 04 Sep 2023 00:28:00 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id g191-20020a8152c8000000b0058fb9863fe7sm2474354ywb.103.2023.09.04.00.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:28:00 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d7225259f52so967512276.0;
        Mon, 04 Sep 2023 00:28:00 -0700 (PDT)
X-Received: by 2002:a25:26cd:0:b0:d7a:feb4:90f0 with SMTP id
 m196-20020a2526cd000000b00d7afeb490f0mr10360870ybm.32.1693812479852; Mon, 04
 Sep 2023 00:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org> <20230901164111.RFT.15.Iaf638a1d4c8b3c307a6192efabb4cbb06b195f15@changeid>
In-Reply-To: <20230901164111.RFT.15.Iaf638a1d4c8b3c307a6192efabb4cbb06b195f15@changeid>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 09:27:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOB7d-KE3F7aeZvVimNuy_U30uk=PND7=tWmPzCd7_eg@mail.gmail.com>
Message-ID: <CAMuHMdWOB7d-KE3F7aeZvVimNuy_U30uk=PND7=tWmPzCd7_eg@mail.gmail.com>
Subject: Re: [RFT PATCH 15/15] drm/renesas/shmobile: Call drm_helper_force_disable_all()
 at shutdown/remove time
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        biju.das.jz@bp.renesas.com, daniel@ffwll.ch,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, paul@crapouillou.net,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Sat, Sep 2, 2023 at 1:42 AM Douglas Anderson <dianders@chromium.org> wrote:
> Based on grepping through the source code, this driver appears to be
> missing a call to drm_atomic_helper_shutdown(), or in this case the
> non-atomic equivalent drm_helper_force_disable_all(), at system
> shutdown time and at driver remove time. This is important because
> drm_helper_force_disable_all() will cause panels to get disabled
> cleanly which may be important for their power sequencing. Future
> changes will remove any custom powering off in individual panel
> drivers so the DRM drivers need to start getting this right.
>
> The fact that we should call drm_atomic_helper_shutdown(), or in this
> case the non-atomic equivalent drm_helper_force_disable_all(), in the
> case of OS shutdown/restart comes straight out of the kernel doc
> "driver instance overview" in drm_drv.c.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for your patch!

> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
> @@ -179,12 +180,20 @@ static int shmob_drm_remove(struct platform_device *pdev)
>
>         drm_dev_unregister(ddev);
>         drm_kms_helper_poll_fini(ddev);
> +       drm_helper_force_disable_all(ddev);

After "[PATCH v3 36/41] drm: renesas: shmobile: Atomic conversion part
1"[1], this function will already call drm_atomic_helper_shutdown()...

>         free_irq(sdev->irq, ddev);
>         drm_dev_put(ddev);
>
>         return 0;
>  }
>
> +static void shmob_drm_shutdown(struct platform_device *pdev)
> +{
> +       struct shmob_drm_device *sdev = platform_get_drvdata(pdev);
> +
> +       drm_helper_force_disable_all(sdev->ddev);

... and this should be replaced by a call to drm_atomic_helper_shutdown().

[1] https://lore.kernel.org/dri-devel/fd7a6702490bd431f314d6591551bb39e77e3304.1692178020.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
