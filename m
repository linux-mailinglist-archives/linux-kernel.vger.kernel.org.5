Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA897542C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjGNSou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbjGNSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:44:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBA2D73;
        Fri, 14 Jul 2023 11:44:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b703c900e3so34370531fa.1;
        Fri, 14 Jul 2023 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689360281; x=1691952281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiTiOlt1XJQdn9IJyzeR6Oi5H77aLqIo6gLSmte40zI=;
        b=p9AAAy3rgXf65E73pctjyNfEgeN4qk6ux4LaxWDYTVUvmSODWPIFotDGeL3oG128jQ
         OeV3xi63nQF5pj+karbgcpObwLP2pws8c6xHXI+8xvQcg+ArUMxjzZA4Letr2Rdyv2BR
         +leYH0cFIrYys62GIKQ1gcoGawmTrxmhO6Gy3JjzDzzTVG+6FX46snBBD81IiVhRPMw7
         kfscja15OANNaq797N3w6iAPk7G+uthHM157uBP87vK8XUYjbfbO4AbVr5J9hDwmkYws
         /8L72/5alvUgmD+lGlwyZnt8sl3rjR9m+Mx+4NY1PUmvj4yTYawIHncNxRGCCXNK8fTk
         FDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360281; x=1691952281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiTiOlt1XJQdn9IJyzeR6Oi5H77aLqIo6gLSmte40zI=;
        b=X05VmJ1rnvRdeQ1w1jMHTjunTvU2lmyPl+fvmZTLaQZegmv9oxS31Kp7uu+qFoSv0S
         dlRKfEP9T71tQViJuGUoHYINx35/HSeV/fSia7g2YfPnfbMfK9+UZR0KkryyQsEirX9b
         /2RoyxoO4r6caieGNy9QdCS8KED1ELEogMLty30gfKrHqguhegfeeILVvxFiNLyyV2k7
         wsIYFpQvWF/ndaZ0CXza0JyOU3KjmFBZOPYvxAxsGGtXT6pJKohDyokSEk6qWwWCrmNE
         3/Y62kMUEouOS8U6nTBPt1MYxI7v5sGHXMICh1NmLrajuc41VTWcYCGb/93u1QeKiE/x
         a/rA==
X-Gm-Message-State: ABy/qLZzzldR0lx3jjyywLQRvZzXCSgu8st3U5iOHwQhzH8eTgMMr5f2
        YYNa7ICpG3w09wz0yjHYB0qayJb9iquaCWxSJdVBN0Jp
X-Google-Smtp-Source: APBJJlGm/SFvX7efyWMjRgZsQu1iLJu0IQhWMc7tF1WRs2avL8T1CSpVqxAtVKE6x3OdW3Uoq/5YS90f27oxEWOoutE=
X-Received: by 2002:a05:651c:120c:b0:2b7:344c:a039 with SMTP id
 i12-20020a05651c120c00b002b7344ca039mr4202216lja.33.1689360280585; Fri, 14
 Jul 2023 11:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714161210.20969-1-jlee@suse.com>
In-Reply-To: <20230714161210.20969-1-jlee@suse.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Jul 2023 11:44:28 -0700
Message-ID: <CABBYNZJ46Lt-Y4OjT7AqXczaGyGoRTzEA0gpG4Z+91GugHwsNw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Ignore NULL link key
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
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

On Fri, Jul 14, 2023 at 9:14=E2=80=AFAM Lee, Chun-Yi <joeyli.kernel@gmail.c=
om> wrote:
>
> This change is used to relieve CVE-2020-26555. The description of the
> CVE:
>
> Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> the BD_ADDR of the peer device to complete pairing without knowledge
> of the PIN. [1]
>
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
>
> Closes: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2020-26555 [=
1]
> Closes: https://ieeexplore.ieee.org/abstract/document/9474325/authors#aut=
hors [2]
> Closes: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L372=
2 [3]

Shouldn't the last 2 be using Link: instead?

> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 95816a938cea..e81b8d6c13ba 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci_dev=
 *hdev, void *data,
>         bool persistent;
>         u8 pin_len =3D 0;
>
> +       /* Ignore NULL link key against CVE-2020-26555 */
> +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> +               BT_DBG("Ignore NULL link key (ZERO KEY) for %pMR", &ev->b=
daddr);

Please use bt_dev_dbg instead.

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
