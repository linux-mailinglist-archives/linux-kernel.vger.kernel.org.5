Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E55F758364
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjGRRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGRRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:22:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C6FD;
        Tue, 18 Jul 2023 10:22:40 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b74310566cso93628721fa.2;
        Tue, 18 Jul 2023 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689700959; x=1692292959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShSHl+im1nbx7LmGJnqqFW1rmMFnTlSsCgSMYiB20zI=;
        b=V3IGj5hpdWbWT1Fq8OiAk7azeBPn28e/HbXXerIOQijGn+AG+TNeMksk4cUpkmGz34
         o/pE3T2sc/33HHwd2sGoM53f4/6Aoz2zXh0LpsXTCF3XtN6iQND83pg23uAUXiXyVdY6
         4KrxAlSHzWSb4CHp8ZyI+/2YATfDoHQPqrl3IJ+95w8Xp9fuQePHRvNDSGLH1U+BBu3u
         EaCv9eh/zGbJyOt6MMS0D4kce5oSzIB+pUYW5EHgMJcYfpqvSj5c1xUIUpKNEp0AryJY
         W3g/ZcpW1l3wwRnmnm6IR6g0HlNIhXkIekGmEQa6Tee09Rp/TP6J9qSJDpJwkYDzaRDF
         s2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700959; x=1692292959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShSHl+im1nbx7LmGJnqqFW1rmMFnTlSsCgSMYiB20zI=;
        b=M+pEwW4NTQBU+HMDtIiKDRMVQwhz9SKL05yPfrSkS6CIIp/01uIoPQCsb4RaEHf3Jv
         dQ5pL4IUq1u6i2VLVdd0Vw+JyidwCYssg5uXiHZtqcPa7ToMA1XN+Zi4+GQRR9uBQGbO
         3PZfhNNmn2yVQQkh6gkEwcoaSN2ms0BCOoEwA66fsQsSqtnRRU1Ucpr+Z22qRri4bYJQ
         yUReQmB1rcnQj2f0TXB6K7whPugsCcVQxA44sw8DsOBVdP/GmUiwaJsO8lIKURaQPT7S
         4M4uGLCYZV3UjDaaVw8PHuPMNbphWfegHNWMAkASJqeNDOSlKInWJ+/FLvVrXsJj/Zze
         HP1g==
X-Gm-Message-State: ABy/qLY+CAer+SqJnyqvftf6YHOL8RJddJHLhGmVRztGAnUanXaP0rQ1
        88puxsxVK5DlPB/am3WqLvoWJveodxaJE6y+EMmyEa2x
X-Google-Smtp-Source: APBJJlEyzzOFIRE3d+O+hSrFB8jyF/a31wWBmUxwATsv190BbPkZl6SWuAZweVdLGtjuvb6ue/rUrTLfxh+iisjIlwo=
X-Received: by 2002:a2e:83c9:0:b0:2b6:a057:8098 with SMTP id
 s9-20020a2e83c9000000b002b6a0578098mr10795381ljh.0.1689700958527; Tue, 18 Jul
 2023 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230718034337.23502-1-jlee@suse.com>
In-Reply-To: <20230718034337.23502-1-jlee@suse.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Jul 2023 10:22:26 -0700
Message-ID: <CABBYNZJ97UMyZ7yX1YAGbuU4XwNDdoFewKNwbd=51_L9aNrrCQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-bluetooth@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Yi,

On Mon, Jul 17, 2023 at 8:43=E2=80=AFPM Lee, Chun-Yi <joeyli.kernel@gmail.c=
om> wrote:
>
> This change is used to relieve CVE-2020-26555. The description of the
> CVE:
>
> Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> the BD_ADDR of the peer device to complete pairing without knowledge
> of the PIN. [1]

Btw, it is probably worth mentioning that in BR/EDR the key generation
is actually handled in the controller, below HCI.

> The detail of this attack is in IEEE paper:
> BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
> [2]
>
> It's a reflection attack. Base on the paper, attacker can induce the
> attacked target to generate null link key (zero key) without PIN code.
>
> We can ignore null link key in the handler of "Link Key Notification
> event" to relieve the attack. A similar implementation also shows in
> btstack project. [3]

Perhaps we could clarify this statement by stating that if we ignore
the link key it means the stack will not consider the device is bonded
and will not persist the link key, that said the controller will still
consider it as paired, so I perhaps we should go one step forward and
disconnect if we detect such a key is being used.

> v2:
> - Used Link: tag instead of Closes:
> - Used bt_dev_dbg instead of BT_DBG
> - Added Fixes: tag
>
> Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the mana=
gement interface")
> Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2020-26555 [1]
> Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#autho=
rs [2]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 =
[3]
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 95816a938cea..ff0c331f53d6 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev=
 *hdev, void *data,
>         bool persistent;
>         u8 pin_len =3D 0;
>
> +       /* Ignore NULL link key against CVE-2020-26555 */
> +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pM=
R", &ev->bdaddr);
> +               return;
> +       }
> +
>         bt_dev_dbg(hdev, "");
>
>         hci_dev_lock(hdev);
> --
> 2.35.3
>


--=20
Luiz Augusto von Dentz
