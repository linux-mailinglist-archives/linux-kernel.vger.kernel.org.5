Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB57C8F06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJMV3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:29:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C12095
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4195fe5cf73so31781cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697232556; x=1697837356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbnszuC6zZy9ZUsF74yWxSFhfV0I+Nmxa40zOQ2lSHM=;
        b=IgK+mnsKu8Ft4bT9XiWU9pObZSzyJRLvAieYMC3f08hehTP9jVLMkTpG10L1paiBlK
         JkSv10u18Ix5Kq/P4422fRm9wWDW+pDCrPRZ9XsHRaTlVNHrRcSb8QhVxi/y/nJGMD5U
         UNdxHsKsCkH5Sf7EA7pd0mO2a/UACdhOjE7wJfaXI5cyMIdpBt1E9cvInLGU38j+0hxr
         jW7Z0FQre9XxK2ru6nRlUMZ+PpElyLsbOob09vzxk4ivzXtq4PECLZt6O6fxhC1aFBrn
         QpSZ/KyLCt8dKeQDAFY6yzkUStE9cEU9N1C6ry5HLETWcFATZekPscERJmpGHj76FgUM
         gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697232556; x=1697837356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbnszuC6zZy9ZUsF74yWxSFhfV0I+Nmxa40zOQ2lSHM=;
        b=tVA/3vLNKbSElXmtZj98WgouLPLGZRb2Zxgnn6OxkUI1/gtxQlymykv9H84QngVZsw
         OWtBjPhp4wtFni54F7gt+SGUHV5NGz+UHGhCFnyKMMFoypkjoYXUPOV7QbQ9DsC4BZpG
         taXil2utPpiGSu/AA65PbYmbdo+OZl1ZnnEgjCDjN3IeEdePovGQorVWTAuTHnizwoa9
         yf1/xRU4QON+DSWYQ6kiS+iu7ae3IrE3zEpf7qU8zHRIZOuxzhiP5fWjba6KWxvlQfgL
         EfVbcPUD1gpzxXHrvzlfLaConXL9AIKJiXwNTldIp7A4Wfg3r4W/r2l6RJcDpOJ9ZIjU
         +tXA==
X-Gm-Message-State: AOJu0Ywkx2Czxi2UUzEHHW0t0HKT3LrcpN4Hii3jUXuYAuRB6BJ+mFyn
        oGaoKq2s28bAm3tSYRg/efefXT8dnsGQh3umA3VmVQ==
X-Google-Smtp-Source: AGHT+IHpRGFmriEzL/KQ9RKsS2oHgCTUAzVCmj/q0lNV14br53Tcpyvzbb4wsjq5Hz1EXcDQc6RCLu7ojVHBJSnpDQs=
X-Received: by 2002:a05:622a:2c02:b0:417:9238:5a30 with SMTP id
 kk2-20020a05622a2c0200b0041792385a30mr283qtb.29.1697232556224; Fri, 13 Oct
 2023 14:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013154742.76836-1-emkan@prevas.dk>
In-Reply-To: <20231013154742.76836-1-emkan@prevas.dk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 13 Oct 2023 14:28:40 -0700
Message-ID: <CAGETcx-MP7XNUa0uObFpEDBiwjaGgTGvKu6Q-RXkrh0+hvXZvQ@mail.gmail.com>
Subject: Re: [PATCH] serial: amba-pl011: set fwnode from parent device
To:     Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 8:48=E2=80=AFAM Emil Kronborg Andersen <emkan@preva=
s.dk> wrote:
>
> After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> detection more robust"), consumer devices without their fwnode set
> printed errors like the one below:
>
> [    0.261887] uart-pl011 3f201000.serial: Failed to create device link (=
0x180) with soc:firmware:gpio
>
> To fix this, set the fwnode so fw_devlink can find and handle it
> properly.
>
> Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more =
robust")
> Signed-off-by: Emil Kronborg Andersen <emkan@prevas.dk>
> ---
>  drivers/tty/serial/amba-pl011.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 3dc9b0fcab1c..29cef84b71c0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2798,6 +2798,8 @@ static int pl011_probe(struct amba_device *dev, con=
st struct amba_id *id)
>         int portnr, ret;
>         u32 val;
>
> +       device_set_node(&dev->dev, dev_fwnode(dev->dev.parent));
> +

Can we do this at a tty/serial framework level instead of just this
driver? Also, this is the latest kernel? I feel like I fixed exactly
this (but at a framework level) several months ago.

-Saravana

>         portnr =3D pl011_find_free_port();
>         if (portnr < 0)
>                 return portnr;
> --
> 2.41.0
>
