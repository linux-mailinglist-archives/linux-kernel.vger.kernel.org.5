Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35580ECBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376513AbjLLNEA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 08:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLND6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:03:58 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893C7B3;
        Tue, 12 Dec 2023 05:04:04 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5907e590360so220473eaf.0;
        Tue, 12 Dec 2023 05:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386244; x=1702991044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zlCPTSk6JdN6595sPJPnN+KjNdsVVraWML48xr0EUg=;
        b=OIfXr3F2S6HNnSJjVC02GFGZT46aLMwjCDD2Bo3Ad+jF7uiEmLOh4Dg2Tmk/Qoilj4
         mkuVZvJzNUQ9/VD2btsZnPMvzBuJ3jcP7zIDOAHbXPPW9wj8CErW5l7SPtvH4Y436YE3
         TbW1lIyVSXaiWi4NDJY/f8mNHGP9KuEC/DQdRV0ee0iaBzjk8w/PxicJovk/RV77MIwt
         Yatx0587W89eviBcghTWkg7ZlXCVAMHevv5A1RihgrfUkUA/hR5uaupIIWeEq6lObdqQ
         bra6M/2IGt9blgkBvIE+7oUtVhnzin4SpJ6e3KWSuCriDw9BaoeYshTMv+jSkaB8UmDx
         8Nbw==
X-Gm-Message-State: AOJu0YyLmEo1m0MTuvGZ/tGFm+F4xDMaRhKkyKWttMtl0trEXN4Gu1q0
        YY91iUTWNReZqLubxkBojr3N0a5BP5jLTVIqq7OfbDJ1yEI=
X-Google-Smtp-Source: AGHT+IGHKSRwC7w0Pqpkxwxhr4hPN9Fyc5P2OWkS0+6K2iUEG88BT1M8zq/bChC78Qo0Q7PAR8XvMk6mRNWiJQh0vbI=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr10067925ooq.1.1702386243642; Tue, 12 Dec
 2023 05:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20231116005609.1583858-1-zhanghongchen@loongson.cn>
In-Reply-To: <20231116005609.1583858-1-zhanghongchen@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 14:03:52 +0100
Message-ID: <CAJZ5v0gTcntizfqKMa0YxHbOhNsLf=nAEoOBf2f9fFt-uzzgsg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: use acquire/release ordering when
 compress/decompress image
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bojan Smojver <bojan@rexursive.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        stable@vger.kernel.org, Weihao Li <liweihao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 1:56 AM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> When we test S4(suspend to disk) on LoongArch 3A6000 platform, the
> test case sometimes fails. The dmesg log shows the following error:
>         Invalid LZO compressed length
> After we dig into the code, we find out that:
> When compress/decompress the image, the synchronization operation
> between the control thread and the compress/decompress/crc thread
> uses relaxed ordering interface, which is unreliable, and the
> following situation may occur:
> CPU 0                                   CPU 1
> save_image_lzo                          lzo_compress_threadfn
>                                           atomic_set(&d->stop, 1);
>   atomic_read(&data[thr].stop)
>   data[thr].cmp = data[thr].cmp_len;
>                                           WRITE data[thr].cmp_len
> Then CPU0 get a old cmp_len and write to disk. When cpu resume from S4,
> wrong cmp_len is loaded.
>
> To maintain data consistency between two threads, we should use the
> acquire/release ordering interface. So we change atomic_read/atomic_set
> to atomic_read_acquire/atomic_set_release.
>
> Fixes: 081a9d043c98 ("PM / Hibernate: Improve performance of LZO/plain hibernation, checksum image")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Weihao Li <liweihao@loongson.cn>

I was about to apply this patch when I noticed the S-o-b confusion.

Either a From: header pointing to Weihao Li <liweihao@loongson.cn> is
missing and the Hongchen Zhang <zhanghongchen@loongson.cn> sign-off
means that the patch is sent on behalf of Weihao Li, or you both
worked on the patch together and a Co-developed-by: tag pointing to
Weihao Li <liweihao@loongson.cn> is missing.

Which of the above is the case?

> ---
> v1 -> v2:
>         1. add Cc: stable@vger.kernel.org in commit log
>         2. add Fixes: line in commit log
> ---
>  kernel/power/swap.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index a2cb0babb5ec..d44f5937f1e5 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -606,11 +606,11 @@ static int crc32_threadfn(void *data)
>         unsigned i;
>
>         while (1) {
> -               wait_event(d->go, atomic_read(&d->ready) ||
> +               wait_event(d->go, atomic_read_acquire(&d->ready) ||
>                                   kthread_should_stop());
>                 if (kthread_should_stop()) {
>                         d->thr = NULL;
> -                       atomic_set(&d->stop, 1);
> +                       atomic_set_release(&d->stop, 1);
>                         wake_up(&d->done);
>                         break;
>                 }
> @@ -619,7 +619,7 @@ static int crc32_threadfn(void *data)
>                 for (i = 0; i < d->run_threads; i++)
>                         *d->crc32 = crc32_le(*d->crc32,
>                                              d->unc[i], *d->unc_len[i]);
> -               atomic_set(&d->stop, 1);
> +               atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
>         return 0;
> @@ -649,12 +649,12 @@ static int lzo_compress_threadfn(void *data)
>         struct cmp_data *d = data;
>
>         while (1) {
> -               wait_event(d->go, atomic_read(&d->ready) ||
> +               wait_event(d->go, atomic_read_acquire(&d->ready) ||
>                                   kthread_should_stop());
>                 if (kthread_should_stop()) {
>                         d->thr = NULL;
>                         d->ret = -1;
> -                       atomic_set(&d->stop, 1);
> +                       atomic_set_release(&d->stop, 1);
>                         wake_up(&d->done);
>                         break;
>                 }
> @@ -663,7 +663,7 @@ static int lzo_compress_threadfn(void *data)
>                 d->ret = lzo1x_1_compress(d->unc, d->unc_len,
>                                           d->cmp + LZO_HEADER, &d->cmp_len,
>                                           d->wrk);
> -               atomic_set(&d->stop, 1);
> +               atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
>         return 0;
> @@ -798,7 +798,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>
>                         data[thr].unc_len = off;
>
> -                       atomic_set(&data[thr].ready, 1);
> +                       atomic_set_release(&data[thr].ready, 1);
>                         wake_up(&data[thr].go);
>                 }
>
> @@ -806,12 +806,12 @@ static int save_image_lzo(struct swap_map_handle *handle,
>                         break;
>
>                 crc->run_threads = thr;
> -               atomic_set(&crc->ready, 1);
> +               atomic_set_release(&crc->ready, 1);
>                 wake_up(&crc->go);
>
>                 for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
>                         wait_event(data[thr].done,
> -                                  atomic_read(&data[thr].stop));
> +                               atomic_read_acquire(&data[thr].stop));
>                         atomic_set(&data[thr].stop, 0);
>
>                         ret = data[thr].ret;
> @@ -850,7 +850,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>                         }
>                 }
>
> -               wait_event(crc->done, atomic_read(&crc->stop));
> +               wait_event(crc->done, atomic_read_acquire(&crc->stop));
>                 atomic_set(&crc->stop, 0);
>         }
>
> @@ -1132,12 +1132,12 @@ static int lzo_decompress_threadfn(void *data)
>         struct dec_data *d = data;
>
>         while (1) {
> -               wait_event(d->go, atomic_read(&d->ready) ||
> +               wait_event(d->go, atomic_read_acquire(&d->ready) ||
>                                   kthread_should_stop());
>                 if (kthread_should_stop()) {
>                         d->thr = NULL;
>                         d->ret = -1;
> -                       atomic_set(&d->stop, 1);
> +                       atomic_set_release(&d->stop, 1);
>                         wake_up(&d->done);
>                         break;
>                 }
> @@ -1150,7 +1150,7 @@ static int lzo_decompress_threadfn(void *data)
>                         flush_icache_range((unsigned long)d->unc,
>                                            (unsigned long)d->unc + d->unc_len);
>
> -               atomic_set(&d->stop, 1);
> +               atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
>         return 0;
> @@ -1335,7 +1335,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>                 }
>
>                 if (crc->run_threads) {
> -                       wait_event(crc->done, atomic_read(&crc->stop));
> +                       wait_event(crc->done, atomic_read_acquire(&crc->stop));
>                         atomic_set(&crc->stop, 0);
>                         crc->run_threads = 0;
>                 }
> @@ -1371,7 +1371,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>                                         pg = 0;
>                         }
>
> -                       atomic_set(&data[thr].ready, 1);
> +                       atomic_set_release(&data[thr].ready, 1);
>                         wake_up(&data[thr].go);
>                 }
>
> @@ -1390,7 +1390,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>
>                 for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
>                         wait_event(data[thr].done,
> -                                  atomic_read(&data[thr].stop));
> +                               atomic_read_acquire(&data[thr].stop));
>                         atomic_set(&data[thr].stop, 0);
>
>                         ret = data[thr].ret;
> @@ -1421,7 +1421,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
>                                 ret = snapshot_write_next(snapshot);
>                                 if (ret <= 0) {
>                                         crc->run_threads = thr + 1;
> -                                       atomic_set(&crc->ready, 1);
> +                                       atomic_set_release(&crc->ready, 1);
>                                         wake_up(&crc->go);
>                                         goto out_finish;
>                                 }
> @@ -1429,13 +1429,13 @@ static int load_image_lzo(struct swap_map_handle *handle,
>                 }
>
>                 crc->run_threads = thr;
> -               atomic_set(&crc->ready, 1);
> +               atomic_set_release(&crc->ready, 1);
>                 wake_up(&crc->go);
>         }
>
>  out_finish:
>         if (crc->run_threads) {
> -               wait_event(crc->done, atomic_read(&crc->stop));
> +               wait_event(crc->done, atomic_read_acquire(&crc->stop));
>                 atomic_set(&crc->stop, 0);
>         }
>         stop = ktime_get();
> --
> 2.33.0
>
