Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB30771D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjHGJmU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjHGJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:42:18 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C910F8;
        Mon,  7 Aug 2023 02:42:14 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-563393b63dbso657006eaf.1;
        Mon, 07 Aug 2023 02:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401333; x=1692006133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK5JqTcazrnzFQkUb1pgAiTMlQXrShoQJmEX5JHWXhU=;
        b=XnL/SLnMWBUN5v2QyGqXqhwRRxj6MV1hXN507LD3uoBl7EG8ntdwP7HBfZTtACdipp
         bAhIYHEDZ3t4Re5D1G8bh2afJX2yGnNEvtlQIhA2yYlk8AeLKoQMjPORnZj8zlOTOYaj
         mrgGfRpQepxkNNYGkqYdCfgcoMAl/qK/i+8t8++aWFLv5SpTNiYzkXRSpxl/wkXBGXjr
         FzpEeRVlOTASCPMRMY6UeVk0CEqb36Fz0+hFEDN6hPoJgn5ae7bvzXHwm0kol/GHU0tN
         ZKbG2l41kSx0mmxdA8KR2Jds4MWLyGYTuElasS2a9h6MYt+ky/nyyxT1VdA+CppTisjp
         AadQ==
X-Gm-Message-State: ABy/qLZg+S/QRZv5TNQLXONPvnRitOrat8ozaJlGqyCly1AWTUvu6q32
        bCqraUg2ZvQ+XYMGn766ug9ahXB3fRaNyu5joS0=
X-Google-Smtp-Source: APBJJlEb7O2dGAF/f7fTBx/HAisyhbmiTj3PawRftJoMI15JdDVqSBYI20CfGwr14y35bjypNJI9KK+xc439zbfSIBc=
X-Received: by 2002:a4a:cf14:0:b0:569:a08a:d9c5 with SMTP id
 l20-20020a4acf14000000b00569a08ad9c5mr19679264oos.0.1691401333651; Mon, 07
 Aug 2023 02:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230807083356.19222-2-vbabka@suse.cz>
In-Reply-To: <20230807083356.19222-2-vbabka@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 11:41:58 +0200
Message-ID: <CAJZ5v0g_OjHSdM_oi515KQUrFZvZH4hNgCy4xknosQC+81GYhw@mail.gmail.com>
Subject: Re: [PATCH for 6.5 regression] PM: hibernate: fix resume_store()
 return value when hibernation not available
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, gregkh@linuxfoundation.org, hch@lst.de,
        joern@lazybastard.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, loic.poulain@linaro.org,
        miquel.raynal@bootlin.com, regressions@lists.linux.dev,
        richard@nod.at, snitzer@kernel.org, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 10:34 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On a laptop with hibernation set up but not actively used, and with
> secure boot and lockdown enabled kernel, 6.5-rc1 gets stuck on boot with
> the following repeated messages:
>
>   A start job is running for Resume from hibernation using device /dev/system/swap (24s / no limit)
>   lockdown_is_locked_down: 25311154 callbacks suppressed
>   Lockdown: systemd-hiberna: hibernation is restricted; see man kernel_lockdown.7
>   ...
>
> Checking the resume code leads to commit cc89c63e2fe3 ("PM: hibernate:
> move finding the resume device out of software_resume") which
> inadvertently changed the return value from resume_store() to 0 when
> !hibernation_available(). This apparently translates to userspace
> write() returning 0 as in number of bytes written, and userspace looping
> indefinitely in the attempt to write the intended value.
>
> Fix this by returning the full number of bytes that were to be written,
> as that's what was done before the commit.
>
> Fixes: cc89c63e2fe3 ("PM: hibernate: move finding the resume device out of software_resume")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Resend with review/ack tags added and not buried in the thread.
> Link: https://lore.kernel.org/all/2cfa5f55-1d68-8a4f-d049-13f42e0d1484@suse.cz/
>
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e1b4bfa938dd..2b4a946a6ff5 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1166,7 +1166,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>         int error;
>
>         if (!hibernation_available())
> -               return 0;
> +               return n;
>
>         if (len && buf[len-1] == '\n')
>                 len--;
> --

Applied as 6.5-rc material, thanks!
