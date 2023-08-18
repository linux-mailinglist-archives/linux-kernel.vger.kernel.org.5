Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FD780441
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357469AbjHRDNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357536AbjHRDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:13:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EAA3A91;
        Thu, 17 Aug 2023 20:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692328376;
        bh=HPxdoWuuwg1hlgDgeHdT2jZY0Hdz6NsqEa0j6C1foxQ=;
        h=Date:From:To:Cc:Subject:From;
        b=oOi2jRUf+SE+QZF08hK1DXjmpnA9L/kWM3iDJC6NR673Cieq9oiu24kyqRXDazcF/
         TD7wsvxnd+wEAH1vWqmLkKSMXV4gGbPOK6/o7BXs0MYHVUmBg4tm9ovm2OawYLnWMa
         nsbIkFujxQFOdLWBqHqeC32Rsdjfx99aC/9kU7Jei7F6O3+Q4XmQdR303F6xQRXxHq
         hjaWjTMwGQ049O+kZ9uLFMKbBZvTZdSotAbp1EGNcnG8E3vVkAtDrNmkWEgxmtd7xb
         7ZrO5K/zth2MguQYoqpiiYNoB6NxuoAtGUw5DTaEDmSXVxF1KsMEoyetaaY1zNZwc1
         P52ounNmumS0A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRn4S3c0bz4wxm;
        Fri, 18 Aug 2023 13:12:56 +1000 (AEST)
Date:   Fri, 18 Aug 2023 13:12:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Curtis Malainey <cujomalainey@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound tree
Message-ID: <20230818131255.799cfc22@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.g.vh_Q6z8Wsz9u.Wb9D.Fg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.g.vh_Q6z8Wsz9u.Wb9D.Fg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

sound/aoa/soundbus/i2sbus/pcm.c: In function 'i2sbus_attach_codec':
sound/aoa/soundbus/i2sbus/pcm.c:975:61: error: invalid type argument of '->=
' (have 'struct snd_pcm_str')
  975 |                 dev->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK]->dev.p=
arent =3D
      |                                                             ^~
sound/aoa/soundbus/i2sbus/pcm.c:992:60: error: invalid type argument of '->=
' (have 'struct snd_pcm_str')
  992 |                 dev->pcm->streams[SNDRV_PCM_STREAM_CAPTURE]->dev.pa=
rent =3D
      |                                                            ^~

Caused by commit

  bc41a7228ced ("ALSA: pcm: Don't embed device")

I have used the sound tree from next-20230817 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.g.vh_Q6z8Wsz9u.Wb9D.Fg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTe4bcACgkQAVBC80lX
0Gz0awgAiDN+TOxRSlAW/i3mCNMu8WLcmJ5v+37ksi80lyfZJw4vJPdNm/VgsQMf
nO5i/Xdc8Fczj/+qhahiGYvI96qy26Latp2zug/SCW7aQCvMPdUBxdb51gxh9lb+
Flp7SY8wRTWeoOciXGD59RWKb06lkIGEE4XsdrHvh4H1x9hCjxqndLXiiRFcqMsW
UIIu96HZ3GbSNIKhC5EAKKrWdt9cinDDyac7jYOaXTkjXA6oGu9NTst/dAIoKNQe
nTAPlbO7nO1RyaYXB7f68g7ohAJGqTmtIczFPxjGM6m8cZWC/WcJ7PG+BhSlIgeK
GKyRP9ruTBH3AFG24kWN6ExKrjHIkw==
=1T4j
-----END PGP SIGNATURE-----

--Sig_/.g.vh_Q6z8Wsz9u.Wb9D.Fg--
