Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD487E7EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjKJRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344979AbjKJRqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:46:16 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE8D6F87;
        Thu,  9 Nov 2023 22:24:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C23515675E;
        Fri, 10 Nov 2023 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1699596008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=pGAPimGotaSJcRtKrDnmSbjkSfOKuNnfaSzdhYkcmXo=;
        b=g1QU7QP1VD0oscW8sjske7Ntfl7CbqIKOn2vcAlWA7LvoLMyKLBWvFM78k60qh24GHqB6z
        xDYhNMyfSIQNLZTYhtWgffN1s5eXTUXft9oQaqoiF/fa0PBzGfv7P5VdkaxDbpXPmRWH7F
        XFhLYYaB6djHz19uz9nGKwJ4PTz6ofeimGtx0/Qi3i0s0UTFD2PN8Tl1MqJtGW/W1u1f0h
        zl983JV/CU/QvPATxM18yZp2hMoXRcMBbjHevmOpq7SxYLTqIeO7XHDZaNaBkpntoMNaY1
        CSpFzdnKyldZZJPAOgo5grDfxTWvp+zqqY7SnT+UDrrUgF8CQnFzST+zSIxUbA==
Message-ID: <d12f0909623088f1f66ab57b1868dee2e0fb6387.camel@lexina.in>
Subject: Re: [PATCH] firmware: meson-sm: change sprintf to scnprintf
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     David Laight <David.Laight@ACULAB.COM>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date:   Fri, 10 Nov 2023 09:00:06 +0300
In-Reply-To: <bd3a9ca738444c99855c6aabe318e351@AcuMS.aculab.com>
References: <20231109085029.2079176-1-adeep@lexina.in>
         <bd3a9ca738444c99855c6aabe318e351@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, 2023-11-09 at 17:59 +0000, David Laight wrote:
> From: Viacheslav Bocharov
> > Sent: 09 November 2023 08:50
> >=20
> > Update sprintf in serial_show frunction to scnprintf command to
> > prevent sysfs buffer overflow (buffer always is PAGE_SIZE bytes).
>=20
> Isn't the correct function sysfs_emit() ?
Good catch. There's always something new to find)



> In any case that particular example can't possibly overflow.
Practically in this example, I agree. But nevertheless, ideologically,=C2=
=A0
a pointer to the buffer is passed to the function, but its size is not=C2=
=A0
passed. This may cause an overflow error when making changes in the=C2=A0
code.=C2=A0Yes, the lengths of %12phN and PAGE_SIZE are very different at=
=C2=A0
the moment.=C2=A0But what happens if both of these numbers change=C2=A0
unpredictably in future changes?


> 	David
>=20
> >=20
> > Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> > ---
> >  drivers/firmware/meson/meson_sm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson=
/meson_sm.c
> > index ed60f1103053..c1c694b485ee 100644
> > --- a/drivers/firmware/meson/meson_sm.c
> > +++ b/drivers/firmware/meson/meson_sm.c
> > @@ -265,7 +265,7 @@ static ssize_t serial_show(struct device *dev, stru=
ct device_attribute *attr,
> >  		return ret;
> >  	}
> >=20
> > -	ret =3D sprintf(buf, "%12phN\n", &id_buf[SM_CHIP_ID_OFFSET]);
> > +	ret =3D scnprintf(buf, PAGE_SIZE, "%12phN\n", &id_buf[SM_CHIP_ID_OFFS=
ET]);
> >=20
> >  	kfree(id_buf);
> >=20
> > --
> > 2.34.1
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

