Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87B7C9E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjJPEPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPEP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:15:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62607D6;
        Sun, 15 Oct 2023 21:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697429725;
        bh=J+VIgxPcXp+IeyiNxGp+yUxp5CmsYzRu05W8WdwVlwI=;
        h=Date:From:To:Cc:Subject:From;
        b=tLRLPZ1htzR/JwZGPGLUvSiwNoQmuoZXcHFPuS8Xv54jWcZOTnBMQS9Ol5J/1IFvm
         rg0E4dsR5ZrUvsIgwN5DaPoaPdJYCRs25cxD4MRXozg/mJ5pZY2H0Uh3fsqvG0vtPP
         qUMu3RKp8/xpM93maiEFU8FR0E8Rc+WFZrOVjLX9fhfyS4o+o5e4Ims0lLphxwdKiv
         dGgmi/dA2K7vMuXWErlfI/12YjMChv7VwXXsUCOoIJrTa6IakqgCRPLIKwSDTQjVYt
         1sPfXavgEDu0H6j/CpR0sIjC7BiXi5K46RNH0VnROaz2gysceYegnLbTaeRcyLQwdD
         IO7eOk2/EwsUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S83gK1hzKz4wcN;
        Mon, 16 Oct 2023 15:15:23 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 15:15:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rtc tree
Message-ID: <20231016151522.06839671@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DTVqrZLOnSaCNJVgAhzTv2q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DTVqrZLOnSaCNJVgAhzTv2q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rtc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/rtc/rtc-at91rm9200.c:561:13: error: 'at91_rtc_remove' defined but n=
ot used [-Werror=3Dunused-function]
  561 | static void at91_rtc_remove(struct platform_device *pdev)
      |             ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  48bc8830fbed ("rtc: at91rm9200: Convert to platform remove callback retur=
ning void")

This function lost its __exit attribute (which includes a "used"
attribute) and exit_p(x) is NULL when not being built with
CONFIG_MODULE set.  This build has CONFIG_RTC_DRV_AT91RM9200=3Dy

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DTVqrZLOnSaCNJVgAhzTv2q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUsuNoACgkQAVBC80lX
0GyAMwf5AV0SDVx/24LlPhl5xrj4EjUklc6UrENUX+FRS65pfdKgVWXN1TqCVVDn
17tNPv2eZYAZxtA1qb8sGFgkuQGtCv3yDt2D5F23ulLvyI+6CQ9u8El0ZFvTkeTQ
+N6u8aRMOvT+77lQjsQhtftIkjpAPkz/EjnzTD3RMsIUVh0y6hRxISmBbpCMv1kE
ycJexLF4rOSlLibYeCH65xGAZX+tXhHCq0juC5eo/7Bc90Me7lRWUszfJdwekICN
BpSWtMTHdv3TtySmhmk8biVfc+GkRu0C4Ad5UYQcawCrdPoImAmPKuhip4exLRIn
LilSHpil92CEQbbZW6fCYhBxY4taMQ==
=vwxc
-----END PGP SIGNATURE-----

--Sig_/DTVqrZLOnSaCNJVgAhzTv2q--
