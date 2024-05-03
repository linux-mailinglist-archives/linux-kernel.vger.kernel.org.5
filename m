Return-Path: <linux-kernel+bounces-167688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB048BAD71
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCE91F22A33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF07153BCA;
	Fri,  3 May 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vyuk05+e"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569515357D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742118; cv=none; b=peS+AggWg+jL/WU1AaWGpR9uRR2KxJu7VkNxawz6yBhN4DrtJvUCk9u7WLD141bRUz9m9WS//c0WtXIGIsbwfyh3rWSlEi5P4IIW1vsxqp+nVqWAykYxze6w6IM7mX+0xiG59CInQgsLttVm++emsfQ+SAk2ZtKahOqhPJujc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742118; c=relaxed/simple;
	bh=HzAUgRyvVHqHcP8yFm/mihYEIdANCSWUcftDdROCFAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJxDxqRPYZJVSUeia1BV/wUci1J7TcjTw2IPvquTRhDRqDxr9tvdhVjKRcr8Jepq4AzJc/UDGp+LxN6KW6XtiJ9amQzlt7q5tk+VWKIU2ME+tvNYtEviE2AikPPBuuun2VSB5JyohDqqltgHoNpS+dZkObqXmbJerDpt88Mw8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vyuk05+e; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de45dba15feso10644309276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714742115; x=1715346915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVNII6J9Gm42hbYviigMrcoeuivG18QFbOOCKlRMXeQ=;
        b=Vyuk05+enFU2uos24b99xANyP3PO1Z8oRuhox8FTQGeIJQozkEekmCBuG9wYXEm94i
         DCqcfgNV9UPMlgNW3DJgvhVkKQ9RpYAeDLtWaTnuOEpaAipv8BZUb85+z1e+bLzdtdUT
         /CS0BfPEsqF9tm8HbStWfniR8ILAH7TlMWwkBe+D/XWyRbofNCFMgch74k/wmkEVBJKn
         ObJGTtjOXhZTxOhgviXk5JgOVjDDbibewEX0Kr2Xg1leeS9ISIj58m4kfof5M6mVSstu
         pghcSTzl6RBALGAjIJl71st9+3JFSAQ52aMaptEQJUGRn+KR+YH9x7tNoCwKqIzxXJkw
         QAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742115; x=1715346915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVNII6J9Gm42hbYviigMrcoeuivG18QFbOOCKlRMXeQ=;
        b=qKQHTjt6tFBd3kJIlqLfYr+k4Vp5fsFfQoGnNCVuZQTRg9ImCbPLqnqEp7BCpZNOw4
         WUN6GR5tyjh/pP9ctzGziLSGuRTcyoMrG6pjtuT7W0XxN9h241cCVpXi8LdS703m+AJj
         FCaAROWSWw5APnq1sY+Ivv4n2jLvyzqXPzT9U/D0XxtMmkNmXEEnvem0CCEN3fHdjoG8
         5FV7EHHgFHUDtpvctu9uBZe4AjJMQbF1e3IiKfOM1Ta1ZLKVOBvoDkPvNBeAs4mUiKy2
         BFuwJ8e99P+tnChmHxlRWZZVAYe8XdqHtxJS/XzPB2OHoNCyLehwwoDecA6CKDc/FblT
         29GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbN7CYwuF4ZnvjpHOIoyS7cehqGjgiOjMiOMAt6JEG9pvmFkKGzWiFN6L+9c0QJinRSdUYv8ku4+fRUK8nDrOPitFNrMx9zUdoaTSc
X-Gm-Message-State: AOJu0YwC53Asy6ayKPkN21c5FLQhvGnrnhUdN8u2CVPGvZHQrC4OOm23
	VMJLm2EOwAAn/KerN241ivmojJvISruAL+a+1zYug3aqaMWqFzW4mjVgjIYaJZLXTfu2ORyW5H0
	6ZE74Z1nJqbx+k8y7uFylDks2FLzyOKCV0Kzpyg==
X-Google-Smtp-Source: AGHT+IGXOR/gKN18wXYTQWIdp+V6ndvJLe8y8kJOGpPu1SyN43J40pizn8v3Qat2M6rWGFBsSuM6y83EGAGTutUjxo8=
X-Received: by 2002:a05:6902:2213:b0:de5:d1cd:b580 with SMTP id
 dm19-20020a056902221300b00de5d1cdb580mr3447075ybb.36.1714742115606; Fri, 03
 May 2024 06:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425133034.79599-1-ulf.hansson@linaro.org> <581352225de29859544b88f95ae5de89@manjaro.org>
In-Reply-To: <581352225de29859544b88f95ae5de89@manjaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 3 May 2024 15:14:40 +0200
Message-ID: <CAPDyKFranVGG+fPY2RfKARL1nr2AAuR=XAPyZgqaSLN5bBALUQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Convert to use __mmc_poll_for_busy()
 SD_APP_OP_COND too
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <avri.altman@wdc.com>, Felix Qin <xiaokeqinhealth@126.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 03:17, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Ulf,
>
> Please see my comment below.
>
> On 2024-04-25 15:30, Ulf Hansson wrote:
> > Similar to what has already been changed for eMMC and the
> > MMC_SEND_OP_COND
> > (CMD1), let's convert the SD_APP_OP_COND (ACMD41) for SD cards to use
> > the
> > common __mmc_poll_for_busy() too.
> >
> > This change means the initial delay period, that starts as 10ms will
> > now
> > increase for every loop when being busy. The total accepted timeout for
> > being busy is 1s, which is according to the SD spec.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/core/sd_ops.c | 77 +++++++++++++++++++++++++--------------
> >  1 file changed, 50 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index a59cd592f06e..3ce1ff336826 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -19,6 +19,15 @@
> >  #include "sd_ops.h"
> >  #include "mmc_ops.h"
> >
> > +#define SD_APP_OP_COND_PERIOD_US     (10 * 1000) /* 10ms */
> > +#define SD_APP_OP_COND_TIMEOUT_MS    1000 /* 1s */
> > +
> > +struct sd_app_op_cond_busy_data {
> > +     struct mmc_host *host;
> > +     u32 ocr;
> > +     struct mmc_command *cmd;
> > +};
> > +
> >  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> >  {
> >       int err;
> > @@ -115,10 +124,44 @@ int mmc_app_set_bus_width(struct mmc_card *card,
> > int width)
> >       return mmc_wait_for_app_cmd(card->host, card, &cmd);
> >  }
> >
> > +static int sd_app_op_cond_cb(void *cb_data, bool *busy)
> > +{
> > +     struct sd_app_op_cond_busy_data *data = cb_data;
> > +     struct mmc_host *host = data->host;
> > +     struct mmc_command *cmd = data->cmd;
> > +     u32 ocr = data->ocr;
> > +     int err;
>
> Minor nitpick...  An empty line should be added here, to
> separate the variable definitions from the subsequent code.

Thanks for noticing, I have fixed it when applying!

>
> Otherwise, the patch is looking to me, so please include my
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Thanks!

Kind regards
Uffe


>
> > +     *busy = false;
> > +
> > +     err = mmc_wait_for_app_cmd(host, NULL, cmd);
> > +     if (err)
> > +             return err;
> > +
> > +     /* If we're just probing, do a single pass. */
> > +     if (ocr == 0)
> > +             return 0;
> > +
> > +     /* Wait until reset completes. */
> > +     if (mmc_host_is_spi(host)) {
> > +             if (!(cmd->resp[0] & R1_SPI_IDLE))
> > +                     return 0;
> > +     } else if (cmd->resp[0] & MMC_CARD_BUSY) {
> > +             return 0;
> > +     }
> > +
> > +     *busy = true;
> > +     return 0;
> > +}
> > +
> >  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
> >  {
> >       struct mmc_command cmd = {};
> > -     int i, err = 0;
> > +     struct sd_app_op_cond_busy_data cb_data = {
> > +             .host = host,
> > +             .ocr = ocr,
> > +             .cmd = &cmd
> > +     };
> > +     int err;
> >
> >       cmd.opcode = SD_APP_OP_COND;
> >       if (mmc_host_is_spi(host))
> > @@ -127,36 +170,16 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> > u32 ocr, u32 *rocr)
> >               cmd.arg = ocr;
> >       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> >
> > -     for (i = 100; i; i--) {
> > -             err = mmc_wait_for_app_cmd(host, NULL, &cmd);
> > -             if (err)
> > -                     break;
> > -
> > -             /* if we're just probing, do a single pass */
> > -             if (ocr == 0)
> > -                     break;
> > -
> > -             /* otherwise wait until reset completes */
> > -             if (mmc_host_is_spi(host)) {
> > -                     if (!(cmd.resp[0] & R1_SPI_IDLE))
> > -                             break;
> > -             } else {
> > -                     if (cmd.resp[0] & MMC_CARD_BUSY)
> > -                             break;
> > -             }
> > -
> > -             err = -ETIMEDOUT;
> > -
> > -             mmc_delay(10);
> > -     }
> > -
> > -     if (!i)
> > -             pr_err("%s: card never left busy state\n", mmc_hostname(host));
> > +     err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
> > +                               SD_APP_OP_COND_TIMEOUT_MS, &sd_app_op_cond_cb,
> > +                               &cb_data);
> > +     if (err)
> > +             return err;
> >
> >       if (rocr && !mmc_host_is_spi(host))
> >               *rocr = cmd.resp[0];
> >
> > -     return err;
> > +     return 0;
> >  }
> >
> >  static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8
> > pcie_bits,

