Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389B77D067
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbjHOQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjHOQxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:53:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9651984;
        Tue, 15 Aug 2023 09:53:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so87901661fa.0;
        Tue, 15 Aug 2023 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692118397; x=1692723197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJTj/I0uHYyISgDOM6CuNzxTxa4SmVbPXSct4dIDw20=;
        b=TxInavKu/jtz0ghv29PCqSlwFp3Mb+sL0CapQF89F7Ivx4rsXkvW9bEaXeYH32SQTh
         dGPBXRy0R7Dm9SVd+d1XFcCwCSc+OOBzjy3DhlHhaMAqgCO3Ubzg7c4LGHPzo5+SAICX
         yh2zuXhJrgbAXLk/dQsh+hLbKnU22NunhgJDBFhKV7FMzse8/l9Yx9VXAOvkUKepEXwU
         KZb24jCYp2hD64pOPNTFqnskSKoAzx7CNDwQnkzeRyxlglyO3pW3vpKqsGGNpDBf9azj
         n6jmIvcuXhVvVW0a3hXW2LPs/MpJ4z3kKDx9GAiDzPK7798yWlfdyNNeWpMCgs86JrmG
         4+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118397; x=1692723197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJTj/I0uHYyISgDOM6CuNzxTxa4SmVbPXSct4dIDw20=;
        b=X++KzkHpPQ2BXLmIwPjYuVjjN5R9VL6u12GHSObGKwliCnjCVtS2x6owLdnfmK4E6P
         /XXTrRYNc0UorPDWNNZjwdlIVMYFoazH1hmYbtPPuQ7uTOgjrGYBqQ3QnS+Ln2e8uumK
         sHiFz2anSl5lcOpgaJpxzPSbSneSXGAWUD9Mrs22ixS11AAJIAsQ/LSx8+WCs2+QLSwF
         uJjI5MczFKkAJFkr+xKd6HOSQOEZki3nsoLuUo7bgN8QWHZhZQ2nXIWOHYxjMq+Bt+9z
         sLgz4m3X8cb6xhVYYvs9Osj6sQ/3e3BkU9ShQQVMsL07r3dyKhqvVq3pTByB6dukmz6X
         AIUA==
X-Gm-Message-State: AOJu0YySS9nkUAJJnYAX9UDYo7A8qC8k+ERVjfvSI56pMKW9o8xauihS
        m735oECbG7I6T8RK3efqcL4=
X-Google-Smtp-Source: AGHT+IFIdy+dvZKFQvMzbrC1SdmO+br09gSgXhianTukGrK9SzaSW3zQsUyaPgEUW9NmYYtL8dHL9Q==
X-Received: by 2002:a2e:8850:0:b0:2bb:97af:f37a with SMTP id z16-20020a2e8850000000b002bb97aff37amr46872ljj.28.1692118396682;
        Tue, 15 Aug 2023 09:53:16 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id h19-20020a2e3a13000000b002b9358f5088sm3061577lja.53.2023.08.15.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:53:15 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:55:45 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] iio: adc: mcp3911: fix indentation
Message-ID: <ZNuuER3V8etxeu3o@gmail.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-4-marcus.folkesson@gmail.com>
 <ZNuShXfOoaLk8Ua1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cGhbK82yr79eRYx0"
Content-Disposition: inline
In-Reply-To: <ZNuShXfOoaLk8Ua1@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cGhbK82yr79eRYx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 05:58:13PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 14, 2023 at 02:10:08PM +0200, Marcus Folkesson wrote:
> > The file does not make use of indentation properly.
>=20
> > Fix that.
>=20
> I'm not sure this is anyhow a fix. Yet you may refer to the checkpatch
> if it complains.
>=20
> ...
>=20
> This kind of change is preferred to be the last in the series or closer
> to the end where no more code changed.

Checkpatch did never complain about the formatting, but I got a few comments
during the review process about the formatting, so I went
through the whole file to fix it once for all.

I do not think that it has to be the last patch in the series.
All following patches has proper indentation.
Pretty much the same as the simplification of spi->dev I think.

If there is no strong opinions about it I think I will leave it as is.

>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20


Best regards,
Marcus Folkesson

--cGhbK82yr79eRYx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTbrgwACgkQiIBOb1ld
UjKw2xAAhnkULWSQ9t4UQe4Hk4nECO3nBUZ0iYUUK5cZ1P78R0J1vHogYd4WMNHU
uBSmKhhjoSBwiRjVYlp6WMdiEsXPt0S7923hYeME780Ryev6ZkciWwx0d379kERj
JZ29HeFSucr5ybvpg95wEIBYCRzyJCmhut7hBmodLxtrDynh0/Bi/7ek4oTWS+Se
rqAbYeIw6qNjrfUFhQHWNy5uPvvloA0V3riARuJ4+vilmZmbf3uBFRm957QjYfTV
TJCliKPvJ1+03Y6rXNAO+utaCyDKgcxtFcNEG5vIZvVV5FSipMbZSQRWN5tkfSmc
66TgUkdD8ql2cV77S5xTnKBDvGjVYnD/YhKpO2progUCOqXxSfDgwFJmKLKe1E00
+OyFXwr6aR5ZBtxwt+u3Pz1UsQ6pGNWS7QNb7oZPFvm/UbMRn2tWWkPr4xHJ16dl
VCZtY3LqST3PrBHoSQY/ilpiBqxobYX+f6mxwWSYUERO/vIVbt69Z2jhIK1O/sow
kdJln/Jo68/VPvSIvwwQI5CFPn3Rpfy/CggMQ0HHFpOafVJhJgtUaIEY8aoUp4Ci
Ykpmz8N63NsX3uyFVcHInU21Gxs8KhyQqqkw93hRh8HYDEqYpqHtsh+7x3Jrav3R
Njwkq9/4w4Zf12r4lhvH1OnSkDCIkCNg2CQ9Aw/eftT1es1Ar0c=
=zlnr
-----END PGP SIGNATURE-----

--cGhbK82yr79eRYx0--
