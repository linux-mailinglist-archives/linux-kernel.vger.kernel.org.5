Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23C97C79B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443034AbjJLWdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:33:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E7AEA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:33:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5079a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697150015; x=1697754815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgiii5Cu8IvXXLpwG+bpTpFG66DYnixIeo0dAtyx7SU=;
        b=HAylIh5BkzCAscRxpDJSBrXbc0OZEl9G+NXGRmKYpLrwmHDB5Yh01zEXAxtvKhk11L
         PzjzGeeZhv8Ge4qofMcmNEa7x4+fkLuoyv0RaiOC/+QyFLbqyppXXoeX0EuoruuXMmoE
         Sq+QIfaagkj0qJPClFOKy3/qsC3dP8ArBdrE1BXNBBktzA9YrRKJEy8AyKGxOT0t5gpp
         53/tHZlcYHm7plP2KBc20bxgnY7n2cTcY2fGmcsCCTCfFXD2oJUESMtkOuVwFzRlTIab
         9pCX2t9nNWQl3CmCh4UST258hBvCUOynSI0dAD+W4eyBr/1wsep63ay1CAwp/DEfEP9t
         gL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697150015; x=1697754815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cgiii5Cu8IvXXLpwG+bpTpFG66DYnixIeo0dAtyx7SU=;
        b=xAs2qQxZzJ+sTwbI33TtuU8Mu2CW0oBpkxXkt1cECJmjvSfJ3UWUmrMqoKQ11H03QM
         M7pIv/AEJadV8h26N1zmyHojuclULTodPAv/usAXTySWg9XeSQoZZn5zap3oJlID+QGh
         oxEUzChyInNugEWbNxE4yJsyOx5I6bmm35uiVUBWXmioPLrhGoh7fF4163Z0C6sMgiJH
         5B8h+YX6uXm4iTprcoZ5HKq4QWwJItZ98RFdVG6AzKHsv8ZwQlAuv2SW5pLCrP8lkOWn
         ilDjI4QXxlLrxWOyGMue6mabwhFVLOW8KPgQADH+gWOgP1jXJ0Jot3j8QdL9uHngiDZt
         93bA==
X-Gm-Message-State: AOJu0Yz+xpIr7EWGJCVM+xFGOU5F5aYkowWtOkQLZRDCcQlrOQtgUM6l
        69Ut2JT8Y/mkvI+SF4B0duLBUIH9Ys5anp6cJZOCTA==
X-Google-Smtp-Source: AGHT+IG8cr/hUnVIGfE1E+m2akLBdaH9uGZ6EgMPafMZWioeg1BhztGE8ogPNo2+AIidJQ6f2HV0twOo4xlK8oj7AM0=
X-Received: by 2002:a50:d084:0:b0:538:2941:ad10 with SMTP id
 v4-20020a50d084000000b005382941ad10mr22140edd.5.1697150015162; Thu, 12 Oct
 2023 15:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231005002249.554877-1-jefferymiller@google.com>
In-Reply-To: <20231005002249.554877-1-jefferymiller@google.com>
From:   Jeffery Miller <jefferymiller@google.com>
Date:   Thu, 12 Oct 2023 17:33:23 -0500
Message-ID: <CAAzPG9NRkdExq39ZRE8VjjrZoV_otJnAbUrAm__gRVkNT-z4Fg@mail.gmail.com>
Subject: Re: [PATCH v2] Input: psmouse - fix fast_reconnect function for PS/2 mode
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Andrew Duggan <andrew@duggan.us>,
        Andrew Duggan <aduggan@synaptics.com>, loic.poulain@linaro.org,
        linux@leemhuis.info, benjamin.tissoires@redhat.com
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

On Wed, Oct 4, 2023 at 7:23=E2=80=AFPM Jeffery Miller <jefferymiller@google=
.com> wrote:
>
>  drivers/input/mouse/elantech.c  | 1 +
>  drivers/input/mouse/synaptics.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantec=
h.c
> index 2118b2075f43..4e38229404b4 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -2114,6 +2114,7 @@ static int elantech_setup_ps2(struct psmouse *psmou=
se,
>         psmouse->protocol_handler =3D elantech_process_byte;
>         psmouse->disconnect =3D elantech_disconnect;
>         psmouse->reconnect =3D elantech_reconnect;
> +       psmouse->fast_reconnect =3D NULL;
>         psmouse->pktsize =3D info->hw_version > 1 ? 6 : 4;
>
>         return 0;
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index ada299ec5bba..cefc74b3b34b 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1623,6 +1623,7 @@ static int synaptics_init_ps2(struct psmouse *psmou=
se,
>         psmouse->set_rate =3D synaptics_set_rate;
>         psmouse->disconnect =3D synaptics_disconnect;
>         psmouse->reconnect =3D synaptics_reconnect;
> +       psmouse->fast_reconnect =3D NULL;
>         psmouse->cleanup =3D synaptics_reset;
>         /* Synaptics can usually stay in sync without extra help */
>         psmouse->resync_time =3D 0;
> --
> 2.42.0.582.g8ccd20d70d-goog
>

This fast_reconnect function pointer being left over has been here since co=
mmit
8eb92e5c9133 ("Input: psmouse - add support for SMBus companions")

It is only recently noticed due to 92e24e0e57f7 ("Input: psmouse - add
delay when deactivating for SMBus mode") which is in the v6.6 rc
branches.

Shouldn't it be OK to merge regardless of a future refactor of
8eb92e5c9133 ("Input: psmouse - add support for SMBus companions")
as described in https://lore.kernel.org/all/ZR1yUFJ8a9Zt606N@penguin/?

This is a v2 from the previous submission at
https://lore.kernel.org/all/20231004005729.3943515-1-jefferymiller@google.c=
om/

Thanks,
Jeff
