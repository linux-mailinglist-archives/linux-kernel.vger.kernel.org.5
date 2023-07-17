Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72447570B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGQXyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:54:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321A91
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:54:14 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-401d1d967beso142431cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689638054; x=1692230054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3jAfeK1TboEapIapoxRTzROdPFxCqeB8GfaLFzRyWo=;
        b=3gaop0MsrObpCuLYGnTyArZ2CGnoMsQaKXXRnHdTAY86IOXFCY/AMb8eBeWDzQDYYt
         q+BXzVZ9BHEaHjkwj0fDMJfBnAzAKV2C4j0pzqeBDCSL4g6iFK3aJp/nIua+EVu3jDRB
         Jkjif6sPNULgL5T/b1wRRcFgI6l+u90arfcvIx9JutOBPf+iF/N631Y3LRIN7aEQmVRw
         1Kk8kRDqyfJmSMwoxs7RlBJhdPw80Nzvu0Ug+/u1QiXDIfqsQt0ytC5r9FMUXV2xdWYd
         7GsdA8HxKNhtAVO17OcCkd3B99Prr5pkAp18oxkqTflHCCmui/GI46lq/NT2ZykA+Vet
         uEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689638054; x=1692230054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3jAfeK1TboEapIapoxRTzROdPFxCqeB8GfaLFzRyWo=;
        b=GsG+yBx9bQVQrmLb7FB9HKkUCVbmcCplUE+rJbhY5Klqvkv13gEob1LnHHdGnXpEhr
         E7vy2TGy9cVt0Krpl0tLj1M8aOXYppgYHlZMrMPAm/dnWVHmIjUYXwqDF929t3QXPNz2
         fZxihtEZyr66mX40A1UH/hQ0to+Rw0ekHLBzoAT3kU+awT5CoiLs+rGIFP2FmG68BRSc
         9L1E6IIlil89k/33FP6CUZMg72O1/23koXCOzwB0UBBON7bJ1UZGq4TyAHabMxcY9AgL
         4JbvCwrDDGcDKGuVkMZXdl5hB0UJNh+43C5PhOKwA7lndb5SDs6UmFk2sdDWkWlqaZsN
         yWTg==
X-Gm-Message-State: ABy/qLaT7jJ6PYnkIuzRauWiDcAS5N5kUmw0e54Btfjmz1S4awJ/lOXt
        I14Ch86N2FHoBZ/AkGyq/qenbzJbmDihVZG91mbhlw==
X-Google-Smtp-Source: APBJJlGNEFS+X2UGYRBHYYlFepf8nUahnFcsaO6KQp3gAz3I89PT5DeYE6k/X0DxNLKoUyjOl42CZofV0dXpydIMYyw=
X-Received: by 2002:ac8:5714:0:b0:403:a43d:bd7d with SMTP id
 20-20020ac85714000000b00403a43dbd7dmr120416qtw.4.1689638053953; Mon, 17 Jul
 2023 16:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
In-Reply-To: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 17 Jul 2023 16:54:00 -0700
Message-ID: <CABXOdTf2bJMekRR9f4zyBNDEY5Uuogin-dy9HOEvWhaEW0-Qtg@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Emergency sync filesystem on EC panic
To:     Rob Barnes <robbarnes@google.com>
Cc:     pmalani@chromium.org, chrome-platform@lists.linux.dev,
        briannorris@chromium.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Makes sense.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

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
