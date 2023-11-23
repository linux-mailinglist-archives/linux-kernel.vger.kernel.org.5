Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599717F6188
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjKWOdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:33:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000819E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700750004; x=1732286004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/isVcwGC/oBWwnXkex9wo2ndvurQu56usHeNj6PgxsI=;
  b=YXp/HAOGDkgZ+Ht7K647YZpVq7MVKofQHYpLG7zbCQrzRLoeIIdZCAZA
   uThlAuVin9dq/GodA6y9dpkdQmW5C3VlG91YD1b20fE7jucCwSMEEQUhj
   dXGxRaZAYUpSofz2InlEM2ffEOOoKtJTnZbYknsMSwJwLEeEbkeauqnhR
   SHh73W204Q67EU/yUpRh35seHn3kFZPU7b1HkWhx5X5snWFKtSHzOd+Vc
   CrGGA+BMDuS2VQbFLB74X5st8WKGN9cSgDiK6maFCmGECHvBMnojaOuJD
   wX1jf4RvfM9PpipYUAslvkvqXDTOjdn781KH+0j17LRiDFLSmCqWePumn
   A==;
X-CSE-ConnectionGUID: arLnt+AGQiSlEZrXvp7v7A==
X-CSE-MsgGUID: uGTi7ZUeTMiO3IPjpg/iQA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12937175"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 07:33:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 07:33:17 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 07:33:12 -0700
Date:   Thu, 23 Nov 2023 14:32:44 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     Conor Dooley <conor@kernel.org>,
        Yu-Chien Peter Lin <peterlin@andestech.com>,
        <mark.rutland@arm.com>, <heiko@sntech.de>, <atishp@atishpatra.org>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <linux-riscv@lists.infradead.org>, <will@kernel.org>,
        <anup@brainfault.org>, <dminus@andestech.com>,
        <dylan@andestech.com>, <ajones@ventanamicro.com>,
        <aou@eecs.berkeley.edu>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <locus84@andestech.com>, <tim609@andestech.com>,
        <paul.walmsley@sifive.com>, <linux-arm-kernel@lists.infradead.org>,
        <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
        <evan@rivosinc.com>, <palmer@dabbelt.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [RFC PATCH v2 07/10] perf: RISC-V: Move T-Head PMU to CPU
 feature alternative framework
Message-ID: <20231123-edge-skinless-3ec70c2958c9@wendy>
References: <20231019140119.3659651-1-peterlin@andestech.com>
 <20231019-predator-quartet-e56f43d5aa8d@spud>
 <ZTJAYqk_DnrR9-Sc@APC323>
 <20231020-snippet-diffusive-1a6052d52aae@spud>
 <ZTTmtVnZrioRWpJx@APC323>
 <20231023-impulse-quickness-4c7076e6eb58@spud>
 <a0a95390-ac9e-4d82-9727-d4880e5e48ae@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EPTcSEsndYxsXW5r"
Content-Disposition: inline
In-Reply-To: <a0a95390-ac9e-4d82-9727-d4880e5e48ae@sholland.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EPTcSEsndYxsXW5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 07:43:09PM -0600, Samuel Holland wrote:

> PMU support is not required to boot, and it didn't really work correctly =
anyway
> until OpenSBI commit c9a296d0edc9 ("platform: generic: allwinner: fix OF =
process
> for T-HEAD c9xx pmu"), which is still not in any released OpenSBI version.
>=20
> So I am fine with requiring a devicetree update for continued PMU support.

Okay, would be nice to get an ack on the relevant parts of the most recent
iteration of the series confirming this :)

--EPTcSEsndYxsXW5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9ijAAKCRB4tDGHoIJi
0jzqAP99wSNOFoSEnhErwZWcLiwLSjE+zabiRoiFl3LNjc8IoAEAxwsezaMF/4hx
55Y2gIY06+bjvIcZKyXPokGQMOmbcAU=
=dCRP
-----END PGP SIGNATURE-----

--EPTcSEsndYxsXW5r--
