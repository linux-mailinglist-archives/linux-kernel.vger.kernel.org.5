Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4C7C9805
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 07:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjJOFax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 01:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjJOFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 01:30:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD7DA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:30:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d1373f631so2752529a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697347848; x=1697952648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLFFx35+FDPU1X4QnV4H6rgeG5+69MFoPAh1zMLpawY=;
        b=jjh1bUtZCqSSVbKx5mHhEAwRS+fXloNEgnLXkg4yuoKkLO1pU94NLGr7MZfYEasgOw
         6Y2oo2KXWomn8ddCTqB9IMvWai+s8qfAo5LppOHNTl5avphxgBMj/rVubfo0MScM5lcq
         dlobRQeexkIBKwP5eTgktDyDXjuVw2cJEv5eCqsZdmUgM81TWA2XIj6it/16S7z1MaG3
         X5yX+zpK3XgXXSw1c4WjX0M6PAmen93NfTnbGJC8fUnVZT4eB6Vj3TMfDwaZ5qv52ac2
         DPMOqyoVJNCDpJHJNj9mlPYX9eD+J3D9Eo4MyucJxZzTEAE/hyZE7SnxR5jc+8E/+bs/
         +fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697347848; x=1697952648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLFFx35+FDPU1X4QnV4H6rgeG5+69MFoPAh1zMLpawY=;
        b=KyM9ly2p9IjIKpmjY0MvnaNB7/YBbr3E84mX0wtY6m+kAOY9meUROX3Y/XAKbN4oJr
         4gDdWd4AcjBmeIZUFohqopCT75+ipUa+5fVsIntkcNaDvzxC1ACHdsotFK0Dl9dK74F1
         5zOqWH0yKU+D89lIoFAa9F93+0xgoKH9VTTnPZ7LnAjDtGGBLCG6LFBHF1kJmID+BkQY
         s8/DO7U7jptPk7Khf/5PyhYvewJmBq1tjhE4VfBz2nJnmzvOoSF9AMMCxD9febLbzC/g
         PQkpEiiwtOggqze90T1kiviEOjPQu3j39eQ+FuJccJLzUP9nzFR/Y+0pQJ7oxOCpL+eJ
         vePQ==
X-Gm-Message-State: AOJu0YyWBWy1QuDIwZMTNXvHMwseGqmT1QVyxOlAAPY/EOqipQeMuXOG
        l6lcT1M8Di9tIBywNaiOHM0rKGYLk10FZKuFI0plLg==
X-Google-Smtp-Source: AGHT+IEGNn9JNLeHj6G5Vu8adg2hRO+htnOQSB07F4lMRZHxUrP+UIoq3m2+XWGodIp7TA5CkaQr4kXSsk1ccOH8A7I=
X-Received: by 2002:a17:90a:31b:b0:27d:54b9:c3d4 with SMTP id
 27-20020a17090a031b00b0027d54b9c3d4mr3561688pje.1.1697347848156; Sat, 14 Oct
 2023 22:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231015051538.2344565-1-badhri@google.com>
In-Reply-To: <20231015051538.2344565-1-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Sat, 14 Oct 2023 22:30:11 -0700
Message-ID: <CAPTae5Lz+QVfXxRb4+anaQau=SXkNHMN9YWwTZ2A_Jt5VnAjtQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Add additional checks for contaminant
To:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this version. Forgot to run checkpatch. Sending in v2.

Regards,
Badhri

On Sat, Oct 14, 2023 at 10:15=E2=80=AFPM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> When transitioning from SNK_DEBOUNCED to unattached, its worthwhile to
> check for contaminant to mitigate wakeups.
>
> ```
> [81334.219571] Start toggling
> [81334.228220] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disc=
onnected]
> [81334.305147] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, conn=
ected]
> [81334.305162] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [81334.305187] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 17=
0 ms [rev3 NONE_AMS]
> [81334.475515] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170=
 ms]
> [81334.486480] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0,=
 disconnected]
> [81334.486495] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS=
]
> [81334.486515] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 =
ms [rev3 NONE_AMS]
> [81334.506621] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 m=
s]
> [81334.506640] Start toggling
> [81334.516972] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disc=
onnected]
> [81334.592759] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, conn=
ected]
> [81334.592773] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [81334.592792] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 17=
0 ms [rev3 NONE_AMS]
> [81334.762940] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170=
 ms]
> [81334.773557] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0,=
 disconnected]
> [81334.773570] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS=
]
> [81334.773588] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 =
ms [rev3 NONE_AMS]
> [81334.793672] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 m=
s]
> [81334.793681] Start toggling
> [81334.801840] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disc=
onnected]
> [81334.878655] CC1: 0 -> 0, CC2: 0 -> 3 [state TOGGLING, polarity 0, conn=
ected]
> [81334.878672] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [81334.878696] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 17=
0 ms [rev3 NONE_AMS]
> [81335.048968] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170=
 ms]
> [81335.060684] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_DEBOUNCED, polarity 0,=
 disconnected]
> [81335.060754] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS=
]
> [81335.060775] pending state change SNK_DEBOUNCED -> SNK_UNATTACHED @ 20 =
ms [rev3 NONE_AMS]
> [81335.080884] state change SNK_DEBOUNCED -> SNK_UNATTACHED [delayed 20 m=
s]
> [81335.080900] Start toggling
> ```
>
> Cc: stable@vger.kernel.org
> Fixes: 00bdc7e4e0f56 ("usb: typec: tcpm: Add callbacks to mitigate wakeup=
s due to contaminant")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 6e843c511b85..3634f9092a84 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3903,7 +3903,9 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                 port->potential_contaminant =3D ((port->enter_state =3D=
=3D SRC_ATTACH_WAIT &&
>                                                 port->state =3D=3D SRC_UN=
ATTACHED) ||
>                                                (port->enter_state =3D=3D =
SNK_ATTACH_WAIT &&
> -                                               port->state =3D=3D SNK_UN=
ATTACHED));
> +                                               port->state =3D=3D SNK_UN=
ATTACHED) ||
> +                                              (port->enter_state =3D=3D =
SNK_DEBOUNCED &&
> +                                               port->state =3D=3D SNK_UN=
ATTACHED));
>
>         port->enter_state =3D port->state;
>         switch (port->state) {
>
> base-commit: 1034cc423f1b4a7a9a56d310ca980fcd2753e11d
> --
> 2.42.0.655.g421f12c284-goog
>
