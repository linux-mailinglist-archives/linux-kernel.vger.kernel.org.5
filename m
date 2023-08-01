Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B976C0A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHAXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjHAXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:06:56 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448CE61
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1690931209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCsXTkWd83UdZWTfx5quyYOY5T2cbHKXnCD1pgeT7bc=;
        b=BPJZGg5VP2hij7Duv4yBx2gU97QokDgbhjIKXoT8tJ1ZnCEqdfmWtHYOSsLLcFQJbRJJA7
        LNDPat5/SGpsAyQubg+Mu3XMVkSvl8wyD4cHEFwWVG5oPWK7aviwYIB2cOevJu73YIarUr
        4lchAbebfgdBOJKDHvyIKRB7GmBjEog=
Message-ID: <c809220b8f10c6c9a3d05bbbd416fbb27d654d2d.camel@crapouillou.net>
Subject: Re: [PATCH] virtio: Remove PM #ifdef guards to fix i2c driver
From:   Paul Cercueil <paul@crapouillou.net>
To:     Arnd Bergmann <arnd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Feng Liu <feliu@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 01:06:47 +0200
In-Reply-To: <20230801105846.3708252-1-arnd@kernel.org>
References: <20230801105846.3708252-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 01 ao=C3=BBt 2023 =C3=A0 12:58 +0200, Arnd Bergmann a =C3=A9crit=
=C2=A0:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> A cleanup in the virtio i2c caused a build failure:
>=20
> drivers/i2c/busses/i2c-virtio.c:270:10: error: 'struct virtio_driver'
> has no member named 'freeze'
> drivers/i2c/busses/i2c-virtio.c:271:10: error: 'struct virtio_driver'
> has no member named 'restore'
>=20
> Change the structure definition to allow this cleanup to
> be applied everywhere.
>=20
> Fixes: 73d546c76235b ("i2c: virtio: Remove #ifdef guards for PM
> related functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I didn't realize it was merged already.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0include/linux/virtio.h | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 0f3b9017dff40..9b94e2c9bbb81 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -218,10 +218,8 @@ struct virtio_driver {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*scan)(struct virti=
o_device *dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*remove)(struct vir=
tio_device *dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*config_changed)(st=
ruct virtio_device *dev);
> -#ifdef CONFIG_PM
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*freeze)(struct virt=
io_device *dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*restore)(struct vir=
tio_device *dev);
> -#endif
> =C2=A0};
> =C2=A0
> =C2=A0static inline struct virtio_driver *drv_to_virtio(struct
> device_driver *drv)

