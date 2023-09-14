Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609827A07D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbjINOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbjINOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:48:40 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C271FF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:48:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d8020510203so1079327276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702915; x=1695307715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUYUUcKK8QIRi4jzfoCbdFZqC8jpz9v+DGkqYkTCKiE=;
        b=qzZXTSP/H1dgKZBImj0w0hZN9z6TRn4NjBCKI5RMuauYVkHKyWpyc5VTi6FKJ/mL/R
         Jt4rOPagv/aTr+Ky7idJDWd3EzSnc0T0a3BeGJCiJld4azl2mSbe/7pLCMY1tWyoIj5L
         ZFjSRaC4DEATtjPBpqoD2/kkB8OXrYB9F34gxlqQ8mc3cgIAuxe09g5M+EjwqXGUlBSg
         DsBX3zD6nnCypdMkkUe4YXeamnpnTIZfBgFZ647sDy8/hu+g5NOwqqIXAK7vsMi8oEcK
         ynePAYAQIx+5lMTosdgCGqQ+8N296wg08/cZNdyNf/gdp6cyNv2Yqlfzdyeg3OvFZnhK
         9nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702915; x=1695307715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUYUUcKK8QIRi4jzfoCbdFZqC8jpz9v+DGkqYkTCKiE=;
        b=c3hHzv6QgxshWwKDNcfMuJCjB8mxBntbB+VT4mcG7pcceZcvLg3cWyBbq68e70gcIi
         hSSsLrtWORh8zsGBajo/oCsnQjx6uFLD3iiXGmHg2bt/OH2jHIItEs8IXNkqTaTrfkQN
         UKuDkYe6O+/cRCqm2gDrDJmFlDlHP4rpkqfMiwKZoiPX/M50M6rf3lg2tOGfBTjOQAfT
         R0v2kzpsx8sMz4WNCf511lHA5aqUQeIoaM3yYyNAK8084CRZq6Q4jHjfX8WqzchmFBXM
         G3QRzrZTPE5xtRRX3EfvccJsHJ3g0i071sK9n7lkkhLJ1mYXboF3WaYCmMD+f3V3p9Ic
         jDAQ==
X-Gm-Message-State: AOJu0YywxTtRO0AEnkdJEClYSzNGowvquoNTOb/4mrgE1t6ggTRzm/zj
        7DM02FipxFdAFM/+q6qLNCABA5bSFB0BVoUvRFuAKJSsur5oiNBGgTg=
X-Google-Smtp-Source: AGHT+IHJ46jgV826KS9t3iEt1dkAYozAolIUN+1cb3oJy/z1tknl44gY4K4XfR2oL46qHBrv4cjD4I345hIaS1I34rE=
X-Received: by 2002:a25:348e:0:b0:d7a:c37c:e86e with SMTP id
 b136-20020a25348e000000b00d7ac37ce86emr6094246yba.6.1694702914978; Thu, 14
 Sep 2023 07:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230913112921.553019-1-ulf.hansson@linaro.org>
In-Reply-To: <20230913112921.553019-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:47:59 +0200
Message-ID: <CAPDyKFoU0AUy9hTmqpj5FtPZojre+7nbfKZNftjSecwxgM0-TA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Fix error propagation for some ioctl commands
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 13:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Userspace has currently no way of checking the internal R1 response error
> bits for some commands. This is a problem for some commands, like RPMB for
> example. Typically, we may detect that the busy completion has successfully
> ended, while in fact the card did not complete the requested operation.
>
> To fix the problem, let's always poll with CMD13 for these commands and
> during the polling, let's also aggregate the R1 response bits. Before
> completing the ioctl request, let's propagate the R1 response bits too.
>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Co-developed-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This one is now applied for fixes and has a stable tag added to it.
Please let me know if there is anyone has objections to this.

Kind regards
Uffe


> ---
>
> Changes in v2:
>         - Updated Christian's email.
>         - Updated the commit message.
>         - Initialize mmc_blk_busy_data struct directly.
>
> ---
>  drivers/mmc/core/block.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b5b414a71e0b..3a8f27c3e310 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -179,6 +179,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                                struct mmc_queue *mq);
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>  static int mmc_spi_err_check(struct mmc_card *card);
> +static int mmc_blk_busy_cb(void *cb_data, bool *busy);
>
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -470,7 +471,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         struct mmc_data data = {};
>         struct mmc_request mrq = {};
>         struct scatterlist sg;
> -       bool r1b_resp, use_r1b_resp = false;
> +       bool r1b_resp;
>         unsigned int busy_timeout_ms;
>         int err;
>         unsigned int target_part;
> @@ -551,8 +552,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
>         r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
>         if (r1b_resp)
> -               use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
> -                                                   busy_timeout_ms);
> +               mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
>
>         mmc_wait_for_req(card->host, &mrq);
>         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> @@ -605,19 +605,28 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
>
> -       /* No need to poll when using HW busy detection. */
> -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> -               return 0;
> -
>         if (mmc_host_is_spi(card->host)) {
>                 if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
>                         return mmc_spi_err_check(card);
>                 return err;
>         }
> -       /* Ensure RPMB/R1B command has completed by polling with CMD13. */
> -       if (idata->rpmb || r1b_resp)
> -               err = mmc_poll_for_busy(card, busy_timeout_ms, false,
> -                                       MMC_BUSY_IO);
> +
> +       /*
> +        * Ensure RPMB, writes and R1B responses are completed by polling with
> +        * CMD13. Note that, usually we don't need to poll when using HW busy
> +        * detection, but here it's needed since some commands may indicate the
> +        * error through the R1 status bits.
> +        */
> +       if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
> +               struct mmc_blk_busy_data cb_data = {
> +                       .card = card,
> +               };
> +
> +               err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
> +                                         &mmc_blk_busy_cb, &cb_data);
> +
> +               idata->ic.response[0] = cb_data.status;
> +       }
>
>         return err;
>  }
> --
> 2.34.1
>
