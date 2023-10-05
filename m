Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D17BA5A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbjJEQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbjJEQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:28 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609683FE;
        Thu,  5 Oct 2023 01:03:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DEF1240003;
        Thu,  5 Oct 2023 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696493032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWCgRkBzHmBU9mQHZ8RJ874KCeFsXDwO/MzoGa06zI0=;
        b=Da52x2X7h83zz1KiOdWz2Pa0Gw4mtWUrpO2eSl+yCaWEPo2LglKwUD97DR3QT10zroCNc8
        gyeLF/Rvz1MVi3QzLlOzUrB/wkP3YNy9l1u7k3Eyw6W0TLRGot9mao9nkb0SH+rIoGKB79
        g48JfG63T3U2TLujyTp2JqQZGa0c01WZQOtAcvwyvAWgBfkQSS5v+NyhpMeLn7cs8SVuaS
        lV5863/HmFRj5nHhMEnc4uMAyfxd6yYG8oHa5B+qci8AtvBPtsC5e8YIvPxAsRLV5sixir
        yfgEIVKYTfrVHZ46ZgNHumO8Ts0MShZSQrT7+my2w19Ei/640thGY6e3z1lRIQ==
Date:   Thu, 5 Oct 2023 10:03:49 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/1] ethtool: Fix mod state of verbose no_mask
 bitset
Message-ID: <20231005100349.113f3bf1@kmaincent-XPS-13-7390>
In-Reply-To: <ZR1HYg2ElUjy2aud@kernel.org>
References: <20231003085653.3104411-1-kory.maincent@bootlin.com>
        <ZR1HYg2ElUjy2aud@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

Thank for your review.

On Wed, 4 Oct 2023 13:07:14 +0200
Simon Horman <horms@kernel.org> wrote:

> On Tue, Oct 03, 2023 at 10:56:52AM +0200, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
>
> > @@ -448,8 +450,11 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned
> > int nbits, }
> > =20
> >  	no_mask =3D tb[ETHTOOL_A_BITSET_NOMASK];
> > -	if (no_mask)
> > -		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
> > +	if (no_mask) {
> > +		tmp =3D kcalloc(nbits, sizeof(u32), GFP_KERNEL);
> > +		memcpy(tmp, bitmap, nbits); =20
>=20
> Hi K=C3=B6ry,
>=20
> I'm no expert on etnhl bitmaps. But the above doesn't seem correct to me.
> Given that sizeof(u32) =3D=3D 4:
>=20
> * The allocation is for nbits * 4 bytes
> * The copy is for its for nbits bytes
> * I believe that bitmap contains space for the value followed by a mask.
>   So it seems to me the size of bitmap, in words, is
>   DIV_ROUND_UP(nbits, 32) * 2
>   And in bytes: DIV_ROUND_UP(nbits, 32) * 16
>   But perhaps only half is needed if only the value part of tmp is used.
>=20
> If I'm on the right track here I'd suggest helpers might be in order.

You are right I should use the same alloc as ethnl_update_bitset with tmp
instead of bitmap32:

        u32 small_bitmap32[ETHNL_SMALL_BITMAP_WORDS];                     =
=20
        u32 *bitmap32 =3D small_bitmap32;=20
        if (nbits > ETHNL_SMALL_BITMAP_BITS) {                            =
=20
                unsigned int dst_words =3D DIV_ROUND_UP(nbits, 32);        =
 =20
                                                                          =
=20
                bitmap32 =3D kmalloc_array(dst_words, sizeof(u32), GFP_KERN=
EL);
                if (!bitmap32)                                            =
=20
                        return -ENOMEM;                                   =
=20
        }  =20

But I am still wondering if it needs to be double as you said for the size =
of
the value followed by the mask. Not sure about it, as ethnl_update_bitset d=
oes
not do it.=20

Regards,
