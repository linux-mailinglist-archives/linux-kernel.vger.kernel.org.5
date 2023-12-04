Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AEE802E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjLDI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjLDI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:57:24 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC441AA;
        Mon,  4 Dec 2023 00:57:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0801F20003;
        Mon,  4 Dec 2023 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701680241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=as+mUhZT9eKzCHaYz+7jVrwGQR55Ba1FhGnt3+3ZvD4=;
        b=aLnlFZs512kyZLhaL3DHgbAlUoXp2N1gGvZOufQmRNHTCa1fqpyXM3bgzNhyNY6XOknKXD
        0YIFWli7WoqNp21U/ur77cwQn0WrPrE2ul8xSNcXOYKdvXkZiLBgj4gLgLLyKxaFfkwoi6
        Biu07W/nk84JjvHjEQxkR5c2SHnUG+VEJ/EZuwLHz0UJBZwMkUt+vEz9xUd99SO+lEpVE3
        lL8BRWhMmAdrq8m17DWn9z22TOh9wmar5itZ4oRodqvowGvCgO36lMDmfGA6TOMJQHGk+W
        6AgW4MSJ5n66bER0fVws5s4uWFIbabBzPbiersoxoBEKNw8oIRRL0N1zEYEecg==
Date:   Mon, 4 Dec 2023 09:57:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     alex.aring@gmail.com, stefan@datenfreihafen.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harperchen1110@gmail.com
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in
 ieee802154_hdr_push_sechdr
Message-ID: <20231204095718.40ccb1ee@xps-13>
In-Reply-To: <tencent_1C04CA8D66ADC45608D89687B4020B2A8706@qq.com>
References: <tencent_1C04CA8D66ADC45608D89687B4020B2A8706@qq.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

zhang_shurong@foxmail.com wrote on Sat,  2 Dec 2023 22:58:52 +0800:

> The syzkaller reported an issue:

Subject should start with [PATCH wpan]

>=20
> BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/hea=
der_ops.c:54 [inline]
> BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee80215=
4/header_ops.c:108
>  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
>  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
>  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
>  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
>  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
>  sock_sendmsg_nosec net/socket.c:725 [inline]
>  sock_sendmsg net/socket.c:748 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
>  __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
>  __compat_sys_sendmsg net/compat.c:346 [inline]
>  __do_compat_sys_sendmsg net/compat.c:353 [inline]
>  __se_compat_sys_sendmsg net/compat.c:350 [inline]
>=20
> We found hdr->key_id_mode is uninitialized in mac802154_set_header_securi=
ty()
> which indicates hdr.fc.security_enabled should be 0. However, it is set t=
o be cb->secen before.
> Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains uni=
nit-value issue.

I am not too deeply involved in the security header but for me it feels
like your patch does the opposite of what's needed. We should maybe
initialize hdr->key_id_mode based on the value in cb->secen, no? (maybe
Alexander will have a better understanding than I have).

> Since mac802154_set_header_security() sets hdr.fc.security_enabled based =
on the variables
> ieee802154_sub_if_data *sdata and ieee802154_mac_cb *cb in a collaborativ=
e manner.
> Therefore, we should not set security_enabled prior to mac802154_set_head=
er_security().
>=20
> Fixed it by removing the line that sets the hdr.fc.security_enabled.
>=20
> Syzkaller don't provide repro, and I provide a syz repro like:
> r0 =3D syz_init_net_socket$802154_dgram(0x24, 0x2, 0x0)
> setsockopt$WPAN_SECURITY(r0, 0x0, 0x1, &(0x7f0000000000)=3D0x2, 0x4)
> setsockopt$WPAN_SECURITY(r0, 0x0, 0x1, &(0x7f0000000080), 0x4)
> sendmsg$802154_dgram(r0, &(0x7f0000000100)=3D{&(0x7f0000000040)=3D{0x24, =
@short}, 0x14, &(0x7f00000000c0)=3D{0x0}}, 0x0)
>=20
> Fixes: 32edc40ae65c ("ieee802154: change _cb handling slightly")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---

This is a resend, a message in a shortlog to express why is welcome. If
it's a ping, then no need to resend.

>  net/mac802154/iface.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index c0e2da5072be..c99b6e40a5db 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -368,7 +368,6 @@ static int ieee802154_header_create(struct sk_buff *s=
kb,
> =20
>  	memset(&hdr.fc, 0, sizeof(hdr.fc));
>  	hdr.fc.type =3D cb->type;
> -	hdr.fc.security_enabled =3D cb->secen;
>  	hdr.fc.ack_request =3D cb->ackreq;
>  	hdr.seq =3D atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
> =20


Thanks,
Miqu=C3=A8l
