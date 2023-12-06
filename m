Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA180721B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378749AbjLFORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378679AbjLFORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:17:09 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EB21A2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:17:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAshz-00046l-92; Wed, 06 Dec 2023 15:17:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAshy-00Dyxm-6P; Wed, 06 Dec 2023 15:17:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rAshx-00FWPh-TA; Wed, 06 Dec 2023 15:17:01 +0100
Date:   Wed, 6 Dec 2023 15:16:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: stats: fix 64-bit division
Message-ID: <20231206141658.kjpjwjy7utdux6b5@pengutronix.de>
References: <20231206123717.524009-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bt3retbuplb4zmrk"
Content-Disposition: inline
In-Reply-To: <20231206123717.524009-1-arnd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bt3retbuplb4zmrk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Arnd,

On Wed, Dec 06, 2023 at 01:37:06PM +0100, Arnd Bergmann wrote:
> Unguarded 64-bit division is not allowed on 32-bit kernels because this
> is very slow. The result of trying anyway is a link failure:
>=20
> arm-linux-gnueabi-ld: drivers/soc/qcom/qcom_stats.o: in function `qcom_dd=
r_stats_show':
> qcom_stats.c:(.text+0x334): undefined reference to `__aeabi_uldivmod'
>=20
> As this function is only used for debugging and not performance critical,
> rewrite it to use div_u64() instead. ARCH_TIMER_FREQ is a multiple of
> MSEC_PER_SEC anyway, so there is no loss in precisison.

Maybe add this information in a comment?

We have

	#define ARCH_TIMER_FREQ         19200000

so it's a multiple of MSEC_PER_SEC (=3D 1000) indeed.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bt3retbuplb4zmrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVwgloACgkQj4D7WH0S
/k5/EQgAjoPq0DwSBp9X9Iw7m71/SG3pDFB7cCoO87XsgX3HZcF0OkXvXPg35ls3
Ai4k8vvrjnmR+JgG7gOcGTHEeszInVUaRptidX8DejmgCet0CveSYp1LCnhk+ZxP
GjfYwWBDyx7YwMMvT1bLjBGg2p1DBEfXyaz4+MBaGkblJX24w1CvHqGQHjAXN5SL
YAl9RqqN2l+2+Bdx6BwKAXAPD6MdZva0/xOiHunIa0g5r2wYnRoxaQQnWnRPmzaC
tvt9C4NSuKCKSW8+VhVCiBgcYtUKFq0qT/dqmaahPX33SmRL0wyQTVNR6vIeJ14i
SGw6GGmjZRuGf+SDNQfFlwzwyVbv5g==
=X2bc
-----END PGP SIGNATURE-----

--bt3retbuplb4zmrk--
