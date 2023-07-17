Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92117570A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGQXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGQXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:48:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F99D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:48:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e55517de3so2708a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689637713; x=1692229713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDZgTVBOtrhe4zyB3l0viMZQTIRr5Hbt8Gnmm5i7wY8=;
        b=bqzqjgWXG+sKHODPCAsrIzOXoVhSTwy8eIidM58WKz1RRXy8oGdhAx0HlptaSQD8ty
         JbQHOOJKm5IPoMTeVUVID8ijeDdlZkOgB9W4u/PhoyWEyzsMJreZbh/mh49nUd+TX/Nf
         AMwRVEJ8iiw/TwSvjVph4FV3V04JpMM3ABpmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689637713; x=1692229713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDZgTVBOtrhe4zyB3l0viMZQTIRr5Hbt8Gnmm5i7wY8=;
        b=Cv0kp8MxBwwBPWqleiG+aBR/O/9vDOp4FEza0j9eUJcEcbeXatQFVm9rQQVopDEOKt
         0Ej1zGp9qvPFybshU0w9C2yjy1TLp82f8LdAl3wLsC/ZwG3AL2xNMQPyAuri3tePi7d8
         FsuOq3Oz9iCCzJHxexuwIsQJ9UegJhdbQk1hlQr+oyboZf1kmcT4tl89UAwD2a9YxAOj
         Jfsy8tzMTHKVBg4BJ5V7hvhjN9D7NROok/+jNl3bhT6sz/w3ULBfPK+UP0X3kZTeyp5M
         I+RSxz8axWUrViIXd/aghO7unEB0vHBY5t0eRZ3CQXfpudVtj9IsD0mC63SLkqpj1CkT
         HFiA==
X-Gm-Message-State: ABy/qLbcV549NpTFqQ0ewEIpmn9Y29z5Mkz2hhNRVEl/Y+UEu6f0P3PT
        lkyGJxtu8W7Urm4ufkmuKLkke1DyJMrN/oDzUH6oJg==
X-Google-Smtp-Source: APBJJlEW0AuUoRSE12bDJI1szQtbH+aXfUR7lmKm6/mPXsKEazqqnhOeC+Y4OCTm/0MBaiMdRDEDhVSet3qKHiXgQoQ=
X-Received: by 2002:a50:9fa3:0:b0:51d:e2d4:3d43 with SMTP id
 c32-20020a509fa3000000b0051de2d43d43mr22758edf.7.1689637712765; Mon, 17 Jul
 2023 16:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
In-Reply-To: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
From:   Benson Leung <bleung@chromium.org>
Date:   Mon, 17 Jul 2023 16:48:19 -0700
Message-ID: <CANLzEku3vL3EKmFhN7YYdjqP=O3p4sNxtHPji2Yv8s_EMAcvRg@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Emergency sync filesystem on EC panic
To:     Rob Barnes <robbarnes@google.com>
Cc:     pmalani@chromium.org, chrome-platform@lists.linux.dev,
        briannorris@chromium.org, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jul 17, 2023 at 4:29=E2=80=AFPM Rob Barnes <robbarnes@google.com> w=
rote:
>
> Perform an emergency filesystem sync when an EC panic is reported. An
> emergency sync actually performs two syncs internally in case some
> inodes or pages are temporarily locked.
>
> hw_protection_shutdown is replaced for a few reasons. It is unnecessary
> because the EC will force reset either way. hw_protection_shutdown does
> not reliably sync filesystem before shutting down. emergency_sync is not
> synchronous so hw_protection_shutdown may interrupt emergency_sync.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>
>  drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 500a61b093e47..9652fc073c2a4 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -327,8 +327,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle devic=
e, u32 value, void *data)
>                 dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown =
is imminent!");
>                 blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, =
ec_dev);
>                 kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char=
 **)env);
> -               /* Begin orderly shutdown. Force shutdown after 1 second.=
 */
> -               hw_protection_shutdown("CrOS EC Panic", 1000);
> +               /* Force sync the filesystem before EC resets */
> +               emergency_sync();
>                 /* Do not query for other events after a panic is reporte=
d */
>                 return;
>         }
> --
> 2.41.0.255.g8b1d071c50-goog
>


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
