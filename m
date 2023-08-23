Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE978624E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbjHWV0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbjHWV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:26:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93E10C8;
        Wed, 23 Aug 2023 14:26:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9a2033978so93815691fa.0;
        Wed, 23 Aug 2023 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825972; x=1693430772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtJ4BazJKt0H8Pz2RJm+/XKVDtvLLo8OsuL3hKBCgjQ=;
        b=MCuOFWO7PBQYxr0PXzvvzuV94jxNt8mUqLi0xpCBaBXpKzyqTOXAUwMbq9g36ad+6a
         dQSY8DYBK2UtU6fUoq3kG4b+S6X/f0oCC+RFVG+Fzm36rH3Opkc6+kGmMhLJBaml3tVp
         wtZy0sze3iGeCZLW+yzMREbMnHSb3hSyuL/45eu9OKPDThOmkTixrnArHaJVHvfxbZ0D
         rBssNRSJarkgo2vUteR1FH1qenqdWuN8baowJsPTvF7cHBPAKHYO3N4462r2flVVZcB1
         iHxSK2NFatSgtM+JNEAC3vobN/dk0FiGcZ3aBdB02BhHlDOW/KhWEr7LUcFDxaVbnTRm
         hiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825972; x=1693430772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtJ4BazJKt0H8Pz2RJm+/XKVDtvLLo8OsuL3hKBCgjQ=;
        b=GXSaT3R1tJW3KB5t+0xe3BRdymST5L81MZQmv/oA76iFiznu1ZeF/+n+SesgbZKCN+
         nZ5D2cbRN0EsjWtrYN2ucIr9FzpqA5IqX+/W9oV5WZzRjx3xIdqcHuW99yabS+VxickJ
         VMoOhsvEss8bg6wYtUyuAsXzbaWs4cHkKf1UomNdhOSrWCgv9wCmDH9qA1ck1LUwQ232
         3oVoHrOyR+0cwGZ9mWfVdXuKPlJCRVnUOrDrLX4ilQeyBZWmUfs5hbj+SVYeT9PNA3By
         TwpgLsVgXzTHJSfhYehjuBawF1HIK2i5XLkNaAj7JT7DXDRY+FN1InPLaJCcRuqrlpF7
         YSww==
X-Gm-Message-State: AOJu0YzyyugbjOcHn2qIdeXZU38jH5AGTyQA+G47fGDxeN/1a+Yqg95c
        fd0AfUIVynr5pmdz404ki3de0zo0Ea6qk3C7nKNtcibbfnI=
X-Google-Smtp-Source: AGHT+IF0MhtlqrdzQJReYV+kCOTvxOaRdk1O0QCqF18I+VXuMNJ+/PABBCw7Vlso/VOR3ryTojmaljfAUacNE+/MprY=
X-Received: by 2002:a2e:9495:0:b0:2bc:d6d8:8ab5 with SMTP id
 c21-20020a2e9495000000b002bcd6d88ab5mr3706936ljh.24.1692825972306; Wed, 23
 Aug 2023 14:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230823125214.5910-1-by2239112@buaa.edu.cn>
In-Reply-To: <20230823125214.5910-1-by2239112@buaa.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Aug 2023 14:26:00 -0700
Message-ID: <CABBYNZKQi+Ma3spkJcn-FrhojsMCVxQqhW_Mhp5Z42u8_f2vBw@mail.gmail.com>
Subject: Re: [PATCH] net: bluetooth: fix consistent connection failure caused
 by the loss of HCI_Connection_Complete event
To:     Xin-Yu Liu <by2239112@buaa.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, baijiaju@buaa.edu.cn,
        sy2239101@buaa.edu.cn, linux-bluetooth@vger.kernel.org,
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

Hi,

On Wed, Aug 23, 2023 at 5:52=E2=80=AFAM Xin-Yu Liu <by2239112@buaa.edu.cn> =
wrote:
>
> During a connection attempt, if the HCI_Connection_Complete event
> is lost and not received by the Host, it will result in
> a connection failure.
>
> In that process, the hci_conn, the handle of which is still
> HCI_CONN_HANDLE_UNSET, will not be removed from the conn_hash
> as it would during a regular disconnection opration.
> Consequently, when an ACL connection is initiated for the same device,
> the hci_conn is found in hash_conn based on "ba", with its state remainin=
g
> BT_CONNECT. Then the Host will send an HCI_Create_Connection_Cancel
> command, which will result in subsequent Bluetooth connections
> for the same device consistently failing.
>
> In order to solve the potential bug, if the hci_conn's state is
> BT_CONNECT and handle is HCI_CONN_HANDLE_UNSET, remove this hci_conn
> from conn_hash. This adjustment could potentially help ensure that the
> specific conn is cleaned up at the appropriate times, then the subsequent
> connection for the same device will no longer experience failures.
>
> Signed-off-by: Xin-Yu Liu <by2239112@buaa.edu.cn>
> ---
>  net/bluetooth/hci_conn.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 76222565e..219c62579 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2886,6 +2886,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reaso=
n)
>                 } else if (conn->type =3D=3D ACL_LINK) {
>                         if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
>                                 break;
> +                       if (conn->state =3D=3D HCI_CONN_HANDLE_UNSET) {
> +                               hci_conn_cleanup(conn);
> +                               break;
> +                       }

This won't apply upstream if you are wondering why CI hasn't managed
to pick it up, this should be fixed by the following line if
connection cannot be aborted:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/net/bluetooth/hci_sync.c?id=3Dc452805643ff9762626f2c87c2640ab7c7099e=
b8#n5432

>                         r =3D hci_send_cmd(conn->hdev,
>                                          HCI_OP_CREATE_CONN_CANCEL,
>                                          6, &conn->dst);
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
