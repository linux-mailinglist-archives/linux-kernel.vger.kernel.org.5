Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7E7943E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbjIFTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjIFTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:45:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060110F1;
        Wed,  6 Sep 2023 12:45:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so4100311fa.3;
        Wed, 06 Sep 2023 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694029532; x=1694634332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EWfKzxH9bObeNTifZsGxnjJXh7o1qAKHe7PuTYfwgc=;
        b=E+kkgtt7GghMzs//G1nCqJtPMaUd3z10X4oYm3IXB0aw5dOtYGSvT731gBK6Ix3iTf
         dETwwL5e+WyN9Tu/qspEw0NLJ9v9EYbTzfd0Z78nML85y4SqUTYApIQfybtypxYcwhmg
         UkofdKsJqoAXEmg2zt7u3dpqcgoW1pTk7Mtny/p0uaXQdGDWRZgRQz0WPKLH4K1AmzTK
         Hqr6B3hS2vF9tMUBN6D6xpWBTUpZQGBnE9YNNDKH7UWkVklnAkkJ8jEyM452632tsGIS
         Ymrv2yNCid2vaW7D32SHjj2RIS2uGQvFm9XWelIe048KlEIOj5wNkOdFEmoBI1PRXkry
         82wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694029532; x=1694634332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EWfKzxH9bObeNTifZsGxnjJXh7o1qAKHe7PuTYfwgc=;
        b=a/9yOpIt/zL4iWaeU2hcKYmWpDAN8k91N2+eZdjJfBdE9d6osGerxXc88i8NHgQO+r
         Y8jULssrAyvZBxeMIGjukqSPjgQPePmOlXse4hq6B4PGynVRmxZs1OKewB203/uTiiqg
         Fv2iJH98ICyDU/iKx8tzWDSVCusD8fKuoxXU2IyGCTWERVKqjpvpZs82/1uB+8rCDHH5
         WI5TSdahrjnZshylJYc+duYaIhk38RJ6B107LwK3j9vurUX0Ts3IgPVonKXCWpubPKmT
         WP2zJN4nQmyL5UTOVTJMPjC/23ETxuG7NkE0+4ysdU7Kt6Iwfey8pHjlBIopKZFO9MBS
         RUCg==
X-Gm-Message-State: AOJu0YwNC16mnnT2McCP7b54rRwaHARTNp3q3fX9s07quvlgbDJOnZH3
        p4LZROucaFwjqE2QMG/XCJNJ61+JtaNlXVTM9gU=
X-Google-Smtp-Source: AGHT+IGvovUimrsYedN5z7pQmj2DISLbDQOjfR5HJI9YLA35Sj3zuORllMgRMC5RHn0b43U+2867GhU8hKzotNjBEMg=
X-Received: by 2002:a2e:9e45:0:b0:2bb:9781:1a4c with SMTP id
 g5-20020a2e9e45000000b002bb97811a4cmr2768653ljk.27.1694029531976; Wed, 06 Sep
 2023 12:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230906034754.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
In-Reply-To: <20230906034754.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Sep 2023 12:45:19 -0700
Message-ID: <CABBYNZLrS9niE6vVayLf0b==wxprsfkz123n7O84wqhr3v5bLQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Avoid redundant authentication
To:     Ying Hsu <yinghsu@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ying,

On Tue, Sep 5, 2023 at 8:48=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wrot=
e:
>
> While executing the Android 13 CTS Verifier Secure Server test on a
> ChromeOS device, it was observed that the Bluetooth host initiates
> authentication for an RFCOMM connection after SSP completes.
> When this happens, some Intel Bluetooth controllers, like AC9560, would
> disconnect with "Connection Rejected due to Security Reasons (0x0e)".
>
> Historically, BlueZ did not mandate this authentication while an
> authenticated combination key was already in use for the connection.
> This behavior was changed since commit 7b5a9241b780
> ("Bluetooth: Introduce requirements for security level 4").
> So, this patch addresses the aforementioned disconnection issue by
> restoring the previous behavior.
>
> Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> ---
> Tested CTS Verifier 13 Secure Server test on a chromebook with AC9560.
>
>  net/bluetooth/hci_conn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9d5057cef30a..27c0a3080631 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2420,10 +2420,11 @@ int hci_conn_security(struct hci_conn *conn, __u8=
 sec_level, __u8 auth_type,
>                 goto encrypt;
>
>         /* An authenticated combination key has sufficient security for
> -          security level 3. */
> +        * security level 3 or lower.
> +        */
>         if ((conn->key_type =3D=3D HCI_LK_AUTH_COMBINATION_P192 ||
>              conn->key_type =3D=3D HCI_LK_AUTH_COMBINATION_P256) &&
> -           sec_level =3D=3D BT_SECURITY_HIGH)
> +           sec_level <=3D BT_SECURITY_HIGH)
>                 goto encrypt;
>
>         /* An unauthenticated combination key has sufficient security for
> --
> 2.42.0.283.g2d96d420d3-goog

How about we do something like:

https://gist.github.com/Vudentz/be49a40789ec713f9441face9bd642cc

That way we cover similar situations for other security levels.

--=20
Luiz Augusto von Dentz
