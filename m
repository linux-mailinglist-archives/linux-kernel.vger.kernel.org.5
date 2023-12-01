Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643EF800625
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377900AbjLAIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjLAIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:47:48 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2710D8;
        Fri,  1 Dec 2023 00:47:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40859dee28cso16685475e9.0;
        Fri, 01 Dec 2023 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701420473; x=1702025273; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=um+WQAjtb46WWAxOPIIxKEpMZp6pmTWg/qcTtD7pJEU=;
        b=lRqLwsP8RptJr79W225a6IsOA/QRM8UV13WqR5pR8mpDZk0IkMo7An9GVMyM1JoBXi
         fTFYDTj1V5ccd67shlHhW8aFWp8RFWzrnib6u8181T38iFlq8nqyhbOSBakWnEmZ3y7o
         C8ls5W950SvWQ8NyCTX4SGk9oaSuE7vLFbBBiSI2XkorOER9VmY+GHRUjk+xo91c36wt
         GkFu2sEBz40T+zMWPYAqIncju6T6eV2tXKZ8W9cyjjxfeL9q0QdJswphHl2935Zdc+Yf
         XGMtu0uZYvyyGkkx5RD97Ft6qOAx3zI66EB+KgWL1gwZAV4ZuK06pRZ6Xgr4eVciswW2
         CUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420473; x=1702025273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=um+WQAjtb46WWAxOPIIxKEpMZp6pmTWg/qcTtD7pJEU=;
        b=gyn3a4rNr+vrfZn4wA7rebm/Pz+SAAeaT7m0LOaj8Q8U4/rcrbPfCrRw2I0XhBFoHL
         0NTCuoqLNtS/ZB/FPuCAgKAJ2q9gBrjqY20G4H5OTf2GiZ0pE5+5VeVSYr2uOIqYvxWD
         P33/rhQzLjDyurR7oHHb7Vp3Uq+tDBLkOfxiXNHM3aF0LewF7alJN9yvFzEKiajKUzoD
         56MKgH0Gtib5bJBDlCchZb63PmxNjOalch2fn+luA2KManolr7Ei2m3dAR1H85w8JOWc
         FSIjNw+dZOs6phcNmvkIEYre621xM5BepHCA1tYEfIK1leOGL+9mENYMuJJ8LxuZRwV2
         P56g==
X-Gm-Message-State: AOJu0Yx1MOlXbtKxni5/PG6IH8Lygk3RG7ymuL5cAE0mu32ysX9jpKZl
        7dtEFEoIQTlgnn1bkpP4dpY=
X-Google-Smtp-Source: AGHT+IHz+XL20XZN/MJL8ZWBytWAn3PW2/Uc6A3bRW3vV5o1xscB/pPpcUpEmPpf6nMKSOzPWEztZA==
X-Received: by 2002:a05:600c:20b:b0:40b:5e22:976 with SMTP id 11-20020a05600c020b00b0040b5e220976mr358765wmi.101.1701420472791;
        Fri, 01 Dec 2023 00:47:52 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b004090798d29csm4737778wmb.15.2023.12.01.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:47:52 -0800 (PST)
Message-ID: <0d3b2bce9b2f139e3338bd5dfc41a7923617b716.camel@gmail.com>
Subject: Re: [PATCH 05/12] iio: adc: ad9467: don't ignore error codes
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Fri, 01 Dec 2023 09:47:51 +0100
In-Reply-To: <CAMknhBG6Ji2JwPvmBQQkReTf2ocfypOpbVBHK1s27=myeQERTg@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
         <CAMknhBG6Ji2JwPvmBQQkReTf2ocfypOpbVBHK1s27=myeQERTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 15:44 -0600, David Lechner wrote:
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Make sure functions that return errors are not ignored.
> >=20
> > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/ad9467.c | 25 ++++++++++++++++---------
> > =C2=A01 file changed, 16 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 368ea57be117..04474dbfa631 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -6,6 +6,7 @@
> > =C2=A0 */
> >=20
> > =C2=A0#include <linux/module.h>
> > +#include <linux/mutex.h>
>=20
> This looks like an unrelated change (should probably be in a separate com=
mit).

Indeed it is...=20

>=20
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/slab.h>

