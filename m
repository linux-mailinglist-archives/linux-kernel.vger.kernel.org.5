Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D240792B53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjIEQvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354547AbjIEMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:31:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504EE1A8;
        Tue,  5 Sep 2023 05:31:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a410316a2so1448770b3a.0;
        Tue, 05 Sep 2023 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693917110; x=1694521910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dW96Ep6tAlYqLl+EhUsJM6oCycz537s8rOvwpx/HVWc=;
        b=Dr6E0MuroJj/9xMGR1YOG5F8NspVgptIQIBWZ3zqTUhfiPlaxlvcDxQhtbpmme8zoy
         d17XP6zeWihQds9Eo62jmY7pLXzAFtxES1325D3kR9uQW3u+pZrBHhZg8x5D3riOJW9r
         a2A/tM9u41mfQqaXwDeMXGV2NN1vp7EvJVGL2Nf8XXpsIwhiYkrYLy+qryGolQ7k/Hmg
         Fs9UxmfiQ+kgXoQ3U704g/cOrw3WcUzH0Zeai8rawCdNZHfbPPCORMJcs1yYhbSghtrV
         o9Uhoau99mTTzh2R2zGRuIShh4QU2IC5BYIcCWFWnBBaBX4muZb+tyYzL7jBidPcuKQR
         J4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693917110; x=1694521910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW96Ep6tAlYqLl+EhUsJM6oCycz537s8rOvwpx/HVWc=;
        b=jl+yuxPBcruHXTEbLQ1rNJbAswiNkKiNZYkwdNUI0GWv1bYhV55I5dnH/pwjrN8qB/
         qSK90MVr/3qGEfClvFm5rNqINUvQCgud2AdTTpd3GkTIWMOJNUfH4SIw8yfbd2ZEVTr0
         xUNJjgmroq/Hljp9iwIjFHOClpAcr31a40kwtpYrJrEuaQ+3sCI2+MowzRPDfo+DWvHG
         KUjPlNwm+LOm3ptFEVOOJhNTcZ3YuepLDRWFsJd4nlTOMgxhSnstjMMEyiUjCKckcYRO
         hsCwYoUCf2CPSflp1L9QVSHAw8sQq2g6ZaXZeQs+wIWuapKXs4ObaNv60L/UeYhUe5SP
         yefQ==
X-Gm-Message-State: AOJu0YzuhhaD6gaFk1+ALSnjTmPr9G2UXPofWiw3Vt4Y8tUanUwvRfVy
        NBWbo/+fmNCG58rxkz9DaX0=
X-Google-Smtp-Source: AGHT+IEmGWFsqNhyKrtj4OHuD6dAwlJv8WS7VZO8yRe+T2bB0Zs9oKYINFiRl0Eyfapnb0s+9vzqPw==
X-Received: by 2002:a05:6a20:157:b0:12f:c61e:7cac with SMTP id 23-20020a056a20015700b0012fc61e7cacmr10167664pzs.31.1693917109387;
        Tue, 05 Sep 2023 05:31:49 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b0068bda522245sm9005966pfe.155.2023.09.05.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 05:31:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B3C5581A82FF; Tue,  5 Sep 2023 19:31:45 +0700 (WIB)
Date:   Tue, 5 Sep 2023 19:31:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergio Callegari <sergio.callegari@gmail.com>,
        netdev@vger.kernel.org
Cc:     Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
Message-ID: <ZPcfsd_QcJwQq0dK@debian.me>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nH/2YECNnxQNvcbH"
Content-Disposition: inline
In-Reply-To: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nH/2YECNnxQNvcbH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 01:02:22PM +0200, Sergio Callegari wrote:
> Hi, reporting here as the issue I am seeing is cross distro and relevant =
to
> recent kernels. Hope this is appropriate.
>=20
> I have a USB hub with AX88179A ethernet. I was able to use it regularly,
> until something changed in recent kernels to have this interface supported
> by the cdc_ncm driver. After this change it is not possible anymore to wo=
rk
> with a manually set MAC address.

Exactly on what version range?

>=20
> More details:
>=20
> - before the kernel changes, the interface was supported by a dedicated
> kernel driver. The driver had glitches but was more or less working. The
> main issue was that after some usage the driver stopped working. Could fix
> these glitches with the driver at
> https://github.com/nothingstopsme/AX88179_178A_Linux_Driver

Did you mean that you use out-of-tree module?

>=20
> - after the kernel changes, loading the ax88179_178a.ko does not create a
> network device anymore. The interface can be used with the cdc_ncm driver,
> however it is not possible anymore to use a manually set MAC address.
>=20
> When you manually set a MAC this appears to be accepted (e.g. ip link
> reports it correctly), but the card does not receive data anymore. For
> instance, trying to connect to a DHCP server, you see that the server
> receives the request, makes an offer, but the offer is never received by =
the
> network card.
>=20

How is the reproducer?

> This may be the same issue reported here: https://discussion.fedoraprojec=
t.org/t/ax88179-178a-network-fails-to-start-usb-to-eth/77687
> where the user says he cannot use the adapter when Network Manager is
> configured to employ a randomized MAC address.
>=20

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--nH/2YECNnxQNvcbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPcfrQAKCRD2uYlJVVFO
o4t4AQCq6e+cB3g8wF3hG3znVE6qwGatCPbWsaRhJsdexMHdLwEA5VL908vv2rdx
W+LDNhRjkNQ0ysX7pN4mOhe2wGNaQA8=
=W4x3
-----END PGP SIGNATURE-----

--nH/2YECNnxQNvcbH--
