Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA579B43D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbjIKWVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 18:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbjIKPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:13:02 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598BE12E;
        Mon, 11 Sep 2023 08:12:57 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3a9e89fa553so446789b6e.1;
        Mon, 11 Sep 2023 08:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445176; x=1695049976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6swvSmT5NqK26Yyzy+9kC9qqap1tUl1p63s40e6jnbA=;
        b=bVD+HYuqqY53rQc1ZfxKQTb0WEuKRmRecMBkXkAL4kY5rFhOxri3ZYYgG++L8k688B
         WfkGRXtt+wHNoJDzFL6ahqt3c5ZiyWt+r6AI6nK+rKcCBOG1JgG1zPM9J4xQS/RwHlAH
         SVz6Iea/5j16bOWpTgHNIOXydSipZkk5rDT7gOFqaj94mQR3TVuKEnp0PltZf4gvLZbO
         xpmR6XCMrvQ3NviWVKOeX4/ROc6b6Pvz0fk/g+lXlP1ASujfi+/yAmj7oo9zzvuOOB6Z
         zcdBtxFeD848aF48794/UUOHrMR4E5UVh/xsAeftgFgkusz8OWxYW36dCBLxFXy+hOlL
         hnFQ==
X-Gm-Message-State: AOJu0YwckDqrEhq4RUI2AFBX1HS8Sd4/EZNHyUrs2cd0jbID2mComAaj
        wHjQ7z6cSqFSc6xHD/fW4Rqw/vYKxe4R+i5cYgG9n9q/
X-Google-Smtp-Source: AGHT+IGNI5zcUadWDNtHZLwpSfhsnFZ6gYzXkoEsS4X00Bv8iWhvgl1gTNm5aAPU2QFPb91pnBGcMsp1J5LyEqnW6ow=
X-Received: by 2002:a05:6808:221d:b0:3a3:37dd:e052 with SMTP id
 bd29-20020a056808221d00b003a337dde052mr11704505oib.5.1694445176645; Mon, 11
 Sep 2023 08:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230907095521.14053-1-Julia.Lawall@inria.fr> <20230907095521.14053-9-Julia.Lawall@inria.fr>
In-Reply-To: <20230907095521.14053-9-Julia.Lawall@inria.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Sep 2023 17:12:45 +0200
Message-ID: <CAJZ5v0i46Ybd3KWQ-ogmbTRoTW=w1nDEg4KpVfo8x0ZFf3qOeg@mail.gmail.com>
Subject: Re: [PATCH 08/11] thermal/of: add missing of_node_put
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 7, 2023 at 11:56 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> for_each_child_of_node performs an of_node_get on each
> iteration, so a break out of the loop requires an
> of_node_put.
>
> This was done using the Coccinelle semantic patch
> iterators/for_each_child.cocci
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/thermal/thermal_of.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -u -p a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -37,8 +37,10 @@ static int of_find_trip_id(struct device
>          */
>         for_each_child_of_node(trips, t) {
>
> -               if (t == trip)
> +               if (t == trip) {
> +                       of_node_put(t);
>                         goto out;
> +               }
>                 i++;
>         }
>
> @@ -401,8 +403,10 @@ static int thermal_of_for_each_cooling_m
>
>         for_each_child_of_node(cm_np, child) {
>                 ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
> -               if (ret)
> +               if (ret) {
> +                       of_node_put(child);
>                         break;
> +               }
>         }
>
>         of_node_put(cm_np);
>

Applied as 6.6-rc material, thanks!
