Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12B7A4360
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbjIRHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjIRHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:46:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C651BDA;
        Mon, 18 Sep 2023 00:43:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf55a81eeaso29332635ad.0;
        Mon, 18 Sep 2023 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695022998; x=1695627798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ1AMQXZDD2nNPL5JTNkWkTCq0W5XECwYQbbG++9SbE=;
        b=c+3KG6PQ827cI9OFfFD1cQW1dQe1950LtCOc3INe1KTcs2JHpifZvfY9rtQQvjU80e
         Wi/4spaol4G8Tf66iptIW9BRucQp5xox90BNdvKGJOCZ58eshW/O45wXv1ZfiQIH8Zrj
         35wtyHilP4X441stXEkAl+0ApOBB0Wx6Pv1NaYz0t5MfnCp1uPJfcDsJ90QJ+sLks1IS
         oBO7/hJtl/xkB2Yru1+nV5kO/BXOl7BfUmj8h0usKN2qBoNXnTKwwDB+I0u5HGo+vTzw
         NwkshyNjZ1ZsTMYTcallp3qzbyqzncDvh1VQh7nn5bO0EdU7E3dGCIxzSV19FEbfCsnQ
         MwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022998; x=1695627798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ1AMQXZDD2nNPL5JTNkWkTCq0W5XECwYQbbG++9SbE=;
        b=va4P0awMIeHyW4yXxYJX/4j+jl6gdK3PE2X1naJrZISdapFTrLtR1jOretufEfPVT5
         WKEO5VrfgT7N8XUSRDPhKJxt2hCpv5FGxScL1SsrzGpvjRYjujHmSdNzGfj0NNWTSaPO
         //Idg1kLZTN8XKZBuugbihcseE3yw9PHsDQ9q2F7BNt+L7E5dsNOAlXqjcI0DAOwdZTw
         JaaHIFjlCU8CHtvUhwDvT4e41YrZ5bGkDx6S9cCF7vNiBnI8kI2rNEPGdI4Cti0gdOBx
         djLYU83+VJ1kb8wqz3zL5IQouZSa6sBkvCCu0rVoA+m0JZ2VA2CQjlg0bn8Tc6dBmn9Q
         v23w==
X-Gm-Message-State: AOJu0YxbFNa7JF+kn14xI1vcncDc8iBOmgPN53c8iN8RyHaHkmOcqLiz
        X52/qki1x3i+iLXF1UgGgbkxkBz2ONA=
X-Google-Smtp-Source: AGHT+IEDBCQpmQ+p16mUQkVOKVVZMktRIQbt/FZb0PKGH+dOGeDuATfVTdispUnZpIH+lvgx9iWqzg==
X-Received: by 2002:a17:902:6548:b0:1c4:2b87:76f0 with SMTP id d8-20020a170902654800b001c42b8776f0mr6726454pln.47.1695022997683;
        Mon, 18 Sep 2023 00:43:17 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001c420afa03bsm6653203pla.109.2023.09.18.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:43:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7784A80253C9; Mon, 18 Sep 2023 14:43:14 +0700 (WIB)
Date:   Mon, 18 Sep 2023 14:43:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <ZQf_kmZZYGFJFZMp@debian.me>
References: <20230918131521.155e9e63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2HGzqmuLZ58rv3ET"
Content-Disposition: inline
In-Reply-To: <20230918131521.155e9e63@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2HGzqmuLZ58rv3ET
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 01:15:21PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the net-next tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> Documentation/driver-api/dpll.rst:427: ERROR: Error in "code-block" direc=
tive:
> maximum 1 argument(s) allowed, 18 supplied.
>=20
> .. code-block:: c
>         static const struct dpll_device_ops dpll_ops =3D {
>                 .lock_status_get =3D ptp_ocp_dpll_lock_status_get,
>                 .mode_get =3D ptp_ocp_dpll_mode_get,
>                 .mode_supported =3D ptp_ocp_dpll_mode_supported,
>         };
>=20
>         static const struct dpll_pin_ops dpll_pins_ops =3D {
>                 .frequency_get =3D ptp_ocp_dpll_frequency_get,
>                 .frequency_set =3D ptp_ocp_dpll_frequency_set,
>                 .direction_get =3D ptp_ocp_dpll_direction_get,
>                 .direction_set =3D ptp_ocp_dpll_direction_set,
>                 .state_on_dpll_get =3D ptp_ocp_dpll_state_get,
>         };
> Documentation/driver-api/dpll.rst:444: ERROR: Error in "code-block" direc=
tive:
> maximum 1 argument(s) allowed, 21 supplied.
>=20
> .. code-block:: c
>         clkid =3D pci_get_dsn(pdev);
>         bp->dpll =3D dpll_device_get(clkid, 0, THIS_MODULE);
>         if (IS_ERR(bp->dpll)) {
>                 err =3D PTR_ERR(bp->dpll);
>                 dev_err(&pdev->dev, "dpll_device_alloc failed\n");
>                 goto out;
>         }
>=20
>         err =3D dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, =
bp);
>         if (err)
>                 goto out;
>=20
>         for (i =3D 0; i < OCP_SMA_NUM; i++) {
>                 bp->sma[i].dpll_pin =3D dpll_pin_get(clkid, i, THIS_MODUL=
E, &bp->sma[i].dpll_prop);
>                 if (IS_ERR(bp->sma[i].dpll_pin)) {
>                         err =3D PTR_ERR(bp->dpll);
>                         goto out_dpll;
>                 }
>=20
>                 err =3D dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, =
&dpll_pins_ops,
>                                         &bp->sma[i]);
>                 if (err) {
>                         dpll_pin_put(bp->sma[i].dpll_pin);
>                         goto out_dpll;
>                 }
>         }
> Documentation/driver-api/dpll.rst:474: ERROR: Error in "code-block" direc=
tive:
> maximum 1 argument(s) allowed, 12 supplied.
>=20
> .. code-block:: c
>         while (i) {
>                 --i;
>                 dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_=
pins_ops, &bp->sma[i]);
>                 dpll_pin_put(bp->sma[i].dpll_pin);
>         }
>         dpll_device_put(bp->dpll);
>=20
>=20
> Introduced by commit
>=20
>   dbb291f19393 ("dpll: documentation on DPLL subsystem interface")
>=20

Oops, I forgot to review dpll series. Will fix.

Thanks for the report!

--=20
An old man doll... just what I always wanted! - Clara

--2HGzqmuLZ58rv3ET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQf/kQAKCRD2uYlJVVFO
owpFAQDeSFN9OdEsaDy/jOpQeC1tlHJPmMMw0OSh6ecH4jsgnwD/Wz8SwPC9Njxd
c/6VShwmyFiw0/K6EV85jAIXC7PqMgQ=
=u2w5
-----END PGP SIGNATURE-----

--2HGzqmuLZ58rv3ET--
