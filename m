Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7487FA25A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjK0OSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjK0ORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:17:49 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC92D67;
        Mon, 27 Nov 2023 06:00:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5071165d5so9793101fa.0;
        Mon, 27 Nov 2023 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701093624; x=1701698424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlYKWZyV+TTt2VOK4YoEox1Gb7Ir7840a793wJdogOU=;
        b=JeLlDDOgUB03P3gNSaOgK38zUkyYh/5srcDA67PILSBlWanSjI+jYvFWmm1OQufllt
         Qc6lSWu3HoWvNxgEJBESeagu475edH45c+k2gOGqTKhdu8IJfYU/qlgMo35dPmWlTW4I
         b2POKLQR1c96qTVwlHyXq7In7C7eSIQ10naCMQBBDhRzE2ZjggJGGQcRIMqfYqOZIOaL
         800edcUaEkF1GG+Dsfmxbd9pG3AGUCkvYiY6aTNjouM75FyVhgKHD5g0A0aiJdW7Parp
         gKpp7rG9oAr+InOsLiW5/LRcAo5iyXGs6hcQiWFfM8Bft6dZMeuwoDmvp5Mt6S9+igtg
         ktPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701093624; x=1701698424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlYKWZyV+TTt2VOK4YoEox1Gb7Ir7840a793wJdogOU=;
        b=hCXvUFpSp8NH5UswOnckDnMa2nx125vRR5ZKunodmi2Msoq9tR2rqpCnmmuLqLtdSn
         0F7IrgOu8Kk7EukuJvnsoUud9u/AtEaW+296Cepmu7NoSlhmfXmkXwkjSuBCchdGtqoD
         PX3gE+8oMqJtZRG6cpx7ZhL7dXo29Ecp9RkeRDDyxDem9jCHEG5zZDN/HdeLUGuBZIFQ
         PO/YQNtT1JYt9y/rxWfTjiVE/vBfE6KBVQeI9/Xl+YXIV/cHiqZNr9oCZC859Byg2kMV
         DHnaraNWQwmoi3QIsm7b5sjo7K4MLM9GlRDULFlULWEFnSxWshU/cEQxjJ41+kDIlT1F
         8xFA==
X-Gm-Message-State: AOJu0YxtKKAa2z28q1KmT+54FTyS9J2/YDM+zZd4J1bZGfrAHVLKJ40y
        hIFknsk+4+05u3doMzWbGbMGfH9/nFf42Kqijpw=
X-Google-Smtp-Source: AGHT+IFAs7Npt05MNB30QgWkZazTU5HeLqn2FYsjYv1XgCioTymNVp2KwwXntJKfzUJXVH7Q1Gw0V0OMwcBUnCN3kkk=
X-Received: by 2002:a2e:bb0f:0:b0:2c9:9584:4e34 with SMTP id
 v15-20020a2ebb0f000000b002c995844e34mr4196814lje.2.1701093623567; Mon, 27 Nov
 2023 06:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20231127090545.117162-1-15013537245@163.com>
In-Reply-To: <20231127090545.117162-1-15013537245@163.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Nov 2023 09:00:11 -0500
Message-ID: <CABBYNZ+0CqK=iu77oZfE2oBjD3DisSAcvLRyoUqD+_C=TOs0ZQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix BR/EDR wakeup bug
To:     15013537245@163.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        "clancy.shang" <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 27, 2023 at 4:06=E2=80=AFAM <15013537245@163.com> wrote:
>
> From: "clancy.shang" <clancy.shang@quectel.com>
>
> Steam deck in suspending state, but bt controller send hci
> mode change event to host. cause Steam Deck can't into sleep.

It probably makes sense to add the btmon trace showing the issue.

> Signed-off-by: clancy.shang <clancy.shang@quectel.com>
> ---
>  net/bluetooth/hci_sync.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a15ab0b874a9..a26a58cb2c38 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3800,12 +3800,14 @@ static int hci_set_event_mask_sync(struct hci_dev=
 *hdev)
>         if (lmp_bredr_capable(hdev)) {
>                 events[4] |=3D 0x01; /* Flow Specification Complete */
>
> -               /* Don't set Disconnect Complete when suspended as that
> -                * would wakeup the host when disconnecting due to
> -                * suspend.
> +               /* Don't set Disconnect Complete and mode change when
> +                * suspended as that would wakeup the host when disconnec=
ting
> +                * due to suspend.
>                  */
> -               if (hdev->suspended)
> +               if (hdev->suspended) {
>                         events[0] &=3D 0xef;
> +                       events[2] &=3D 0xf7;
> +               }
>         } else {
>                 /* Use a different default for LE-only devices */
>                 memset(events, 0, sizeof(events));
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
