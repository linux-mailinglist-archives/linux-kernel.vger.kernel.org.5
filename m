Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159D811559
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442046AbjLMO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442071AbjLMOz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B1DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702479365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=seLSmd4NaxAGKV9tJbzWfT8nVms62NbVrReJ4pEC1u4=;
        b=KEqEmJj4XjOLl50lZ/YtQ2WdTMP+XfYP/wrNbSpCTfceP7y/0AhzqbN8aLL9BYJc2UHip8
        8tLnUBSd8G85NT9omOzG1Drp88c7blgmrXVR54J/qMZXD+5+HGqF1qAjDoxkBrWOOyPa2T
        f+PJUvb5oPqFYw3xKQpr8QbxSltHX/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-ZSxqZL_JPsm3i3X75yMQ2Q-1; Wed, 13 Dec 2023 09:56:03 -0500
X-MC-Unique: ZSxqZL_JPsm3i3X75yMQ2Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3335231c733so3221300f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479358; x=1703084158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seLSmd4NaxAGKV9tJbzWfT8nVms62NbVrReJ4pEC1u4=;
        b=C/nduSMr4A7+XddJ7Hxr1riZ9LYLgRkDhnCBs8ikpmMs6uU1y5OskRmT/iCTTVzF1J
         gXpnbPa6ctnwemdMTfXRrGqnNstaLyQYMCx11nTrx2luOmcnH+8k3wb7L4LSZbt63tWv
         QPOF6p9z9jRjK8eLMz7QdiOJTegjjcJ44IislXohzYgC+9zGtC2kp4tA6DMAjokdj7Bu
         ms7nx6zdnfB59io1umgxhvMiFat5JSmFeKlERIsLksLh9dHWa9rHhh/Gcd7LjxmqzsPA
         SHjNBDi5Z1t4zymqjYW/9uUQLBpDw3zx7n1h+7bZo12HubOXEaYeXBzzIt3V+cGAlYGy
         5xdw==
X-Gm-Message-State: AOJu0Yx9HrKYrzQ5N4y0gWzPIoAJiWwPbi+vJAc1U0bQGKvMLwLDUKW3
        E8nkonjmIHFE+G6oIRQ08r+KGnQqnRxjWrVjHK8X7MtWOb0/nwQX1VOB+fCvsCmvXBOKm7cPRoJ
        6aVWLKS8P9/OFpQBdDjYUHiJW
X-Received: by 2002:a5d:5643:0:b0:336:4196:b861 with SMTP id j3-20020a5d5643000000b003364196b861mr509841wrw.11.1702479358494;
        Wed, 13 Dec 2023 06:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx9WUns+c31gzuLj/TybdHPWHND+pSU+GNTIKZApMqfbmTpuviAuYQQ6FI/50xHfhicnxj1A==
X-Received: by 2002:a5d:5643:0:b0:336:4196:b861 with SMTP id j3-20020a5d5643000000b003364196b861mr509819wrw.11.1702479358176;
        Wed, 13 Dec 2023 06:55:58 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb44000000b003362d0eefd3sm4125363wrs.20.2023.12.13.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:55:57 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:55:57 +0100
From:   Maxime Ripard <mripard@redhat.com>
To:     Donald Robson <donald.robson@imgtec.com>, nm@ti.com,
        vigneshr@ti.com, kristo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, frank.binns@imgtec.com,
        matt.coster@imgtec.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com
Subject: Re: [PATCH v2 0/2] Enable PowerVR driver for TI AM62x
Message-ID: <zq3qtz7rherh2fp2yoe6ail5yvyfkfi46i7fqcbecdagflyj4x@htcfxyhunewx>
References: <cover.1701773390.git.donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p53zjzgmum7iorxr"
Content-Disposition: inline
In-Reply-To: <cover.1701773390.git.donald.robson@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p53zjzgmum7iorxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth, Tero, Vignesh,

On Tue, Dec 05, 2023 at 11:39:31AM +0000, Donald Robson wrote:
> These patches enable the new open source PowerVR driver for TI AM62x SoCs,
> currently the only one supported.
>=20
> Changes since v1:
> - Added patch 1 for arm64 defconfig (requested by Nishanth Menon)
>=20
> Donald Robson (1):
>   arm64: defconfig: enable DRM_POWERVR
>=20
> Sarah Walker (1):
>   arm64: dts: ti: k3-am62-main: Add GPU device node

Any chance we can get that in 6.8?

Since the driver will reach 6.8 as well, it would be a bit of a bummer
to not have it enabled anywhere.

Maxime

--p53zjzgmum7iorxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXnF/QAKCRDj7w1vZxhR
xVqrAQD6EdMWC9m6qFxV3KiMi4/C/MPkTHRdno81R57dNuGj3wD/fwGlEnklNRir
py8Ke+Q/cAOVgLS+I3Yt6fBTOsjxIgM=
=LdLH
-----END PGP SIGNATURE-----

--p53zjzgmum7iorxr--

