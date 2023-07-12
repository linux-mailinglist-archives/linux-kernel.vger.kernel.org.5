Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4377511D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGLUaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjGLUaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:30:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33861FF0;
        Wed, 12 Jul 2023 13:30:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b734aea34aso29655251fa.0;
        Wed, 12 Jul 2023 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689193800; x=1691785800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s70gQ0p4s2qzcV/Ayy30mLAMppe9wZRLcW8gZS36XQ4=;
        b=VGyrHSG2b6tsuaeeeX3cEkZDJjwhWJ79ynnf7/uO9xh85WreVk2ZLFUbn61p2Esnaj
         GwWXQHA7TBJcJ3VZK7WXnMJKgFiL9gxAnLxFAlPyuCkDORGoBETsRHrPsSgNq9BxVMHZ
         kfO5zYVlbC+BsQRmPTwkMnUup5iSGgm5ic8agWPBozbzg4deB4GlZ0+rRlp+0wyb7D/y
         Vm1zckpAHA8Nxz50P9//W5BAY0IWE4RqR6Xdplywxy7uIaZx0v7Fok6wGm0Jb+AEOkdS
         IKB7+BjXAzYk4G0o2nhTX43SZD7ZdFgbPtB8Xurbz//bTNE/HYDD9eSJY3ovxD0kkGBQ
         dFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689193800; x=1691785800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s70gQ0p4s2qzcV/Ayy30mLAMppe9wZRLcW8gZS36XQ4=;
        b=Rt7h6u+epsZy/f4aEGHJgx6+BXwZsfs7DUaF6RUE7RD0FTVkn6Hy29wIW4aKW4noIC
         FucAhJ7/Wu0tY+KhEEULOXA9MbdlNhdEBsqp/wiRpyEHHAetRVIyHm1crckYLxd5W0IB
         NBkArqwtN0ynz/0WYOE5IRnJZhD1S2Z2rvweNtXEFxxcHNWE4b0akY9c9kgsAFZ+nXPM
         NlvdCoGmPWpTXnOlYaHy0aEv+/9CW+uhZkCtOoror23+rJ5HWe1eaxPRaI+xdFaGEO8c
         4T3p4gythREjwDg29xny7MSYVMpvIhZOXBzKyawFUDlQ9zu6ZUX1L4RyuMwz1qvfHeUo
         6JOQ==
X-Gm-Message-State: ABy/qLbMwrZSSGfE5h2ch48t2c79TASN91FcXAm2cnAp5NP22x0S7RV/
        jIp8E2G79/ENpqAGo/6C0LnL3RJROwsOrLeOKEY=
X-Google-Smtp-Source: APBJJlFYkpPdO34bvP5tNhj7U8Ffuy0IpHxP0w2CAJJ8BbRYn1IKHjOg+YHDbZpWvTYoJumFrusISnmM8jxqNNSqGtA=
X-Received: by 2002:a2e:7a0e:0:b0:2b6:d631:a1a0 with SMTP id
 v14-20020a2e7a0e000000b002b6d631a1a0mr17564926ljc.12.1689193799496; Wed, 12
 Jul 2023 13:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230712130218.376-1-chris.lu@mediatek.com>
In-Reply-To: <20230712130218.376-1-chris.lu@mediatek.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Jul 2023 13:29:47 -0700
Message-ID: <CABBYNZLoJtUpAR-yKpq9a1NCTjhdgWMNSdwGd7f9jtFR0LuEAA@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btmtk: Fix null pointer when processing coredump
To:     Chris Lu <chris.lu@mediatek.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Aaron Hou <aaron.hou@mediatek.com>,
        Steve Lee <steve.lee@mediatek.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
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

Hi Chris,

On Wed, Jul 12, 2023 at 6:03=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> There may be a potential null pointer risk if offset value is
> less than 0 when doing memcmp in btmtk_process_coredump().
> Check offset is valid before doing memcmp.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

You should probably include the Fixes tag of the patch that introduced
the problem.

> ---
> v2: fix typo
> v3: fix bot checking error
> v4: reduce variable 'offset' declaration in v3
> ---
>  drivers/bluetooth/btmtk.c | 12 ++++++------
>  drivers/bluetooth/btmtk.h |  1 +
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 786f775196ae..9cc789272ab7 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -395,12 +395,12 @@ int btmtk_process_coredump(struct hci_dev *hdev, st=
ruct sk_buff *skb)
>
>                 /* Mediatek coredump data would be more than MTK_COREDUMP=
_NUM */
>                 if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
> -                   skb->len > sizeof(MTK_COREDUMP_END) &&
> -                   !memcmp((char *)&skb->data[skb->len - sizeof(MTK_CORE=
DUMP_END)],
> -                           MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - =
1)) {
> -                       bt_dev_info(hdev, "Mediatek coredump end");
> -                       hci_devcd_complete(hdev);
> -               }
> +                   skb->len > MTK_COREDUMP_END_LEN)
> +                       if (!memcmp((char *)&skb->data[skb->len - MTK_COR=
EDUMP_END_LEN],
> +                           MTK_COREDUMP_END, MTK_COREDUMP_END_LEN - 1)) =
{
> +                               bt_dev_info(hdev, "Mediatek coredump end"=
);
> +                               hci_devcd_complete(hdev);
> +                       }
>
>                 break;
>         }
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 68309dfe076a..56f5502baadf 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -24,6 +24,7 @@
>
>  #define MTK_COREDUMP_SIZE              (1024 * 1000)
>  #define MTK_COREDUMP_END               "coredump end"
> +#define MTK_COREDUMP_END_LEN           (sizeof(MTK_COREDUMP_END))
>  #define MTK_COREDUMP_NUM               255
>
>  enum {
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
