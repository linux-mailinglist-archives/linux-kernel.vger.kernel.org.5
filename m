Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC36784FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjHWFXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHWFXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:23:37 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F17E54;
        Tue, 22 Aug 2023 22:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692768215; x=1724304215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z8gFBF0mu3Kl0VGNPxlN8F2BAekuhDcZB1/KPbYzabM=;
  b=ENm9iJ34UDYzLNTI8LTOweed5kYoh08WAeDF3lG3t59s2SFG10QV53lp
   OBEK/QH+Lb9rph9nX+AMD5Dak07p1U5ikM8F7xWBdDhS1pv/KaLyQylRA
   58okqsh3pFisTOFMTuIX14/zd4uDy1IE16ZGoR5cQolg4r8/bjeLE7hD/
   C1NORNhNALYR77vEvQhMcFR6ehjSMWAPm2mX1wzeElDJY7t2/geeA+Icv
   RRno4RLDKeF9IDRQG/ErndasUKY7lD5o/yRhYHd7iRbaQy75/dQlQch8y
   K9gBtXVDzYqvU0K/Tj2ry0Afa6AbmMZSKTKLeE7wCdtDH6Bc+9ks65tZB
   A==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684792800"; 
   d="scan'208";a="32575038"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 07:23:33 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E82C3280075;
        Wed, 23 Aug 2023 07:23:32 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 1/3] hwrng: imx-rngc - use polling to detect end of self test
Date:   Wed, 23 Aug 2023 07:23:32 +0200
Message-ID: <3503619.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230822152553.190858-2-martin@kaiser.cx>
References: <20230822152553.190858-1-martin@kaiser.cx> <20230822152553.190858-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. August 2023, 17:25:51 CEST schrieb Martin Kaiser:
> Use polling to detect the end of the rngc self test. This is much simpler
> than using an interrupt and a completion.
>=20
> Active waiting is no disadvantage here. The self test is run during
> probe, there's nothing we could do in parallel at this time.

If this driver is built-in you are stalling the boot process while polling,=
=20
no? Unless probe_type =3D PROBE_PREFER_ASYNCHRONOUS is set of course.

Best regards,
Alexander

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/char/hw_random/imx-rngc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/imx-rngc.c
> b/drivers/char/hw_random/imx-rngc.c index e4b385b01b11..85207535fd12 1006=
44
> --- a/drivers/char/hw_random/imx-rngc.c
> +++ b/drivers/char/hw_random/imx-rngc.c
> @@ -17,6 +17,7 @@
>  #include <linux/hw_random.h>
>  #include <linux/completion.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/bitfield.h>
>=20
>  #define RNGC_VER_ID			0x0000
> @@ -101,21 +102,19 @@ static inline void imx_rngc_irq_unmask(struct imx_r=
ngc
> *rngc)
>=20
>  static int imx_rngc_self_test(struct imx_rngc *rngc)
>  {
> -	u32 cmd;
> +	u32 cmd, status;
>  	int ret;
>=20
> -	imx_rngc_irq_unmask(rngc);
> -
>  	/* run self test */
>  	cmd =3D readl(rngc->base + RNGC_COMMAND);
>  	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
>=20
> -	ret =3D wait_for_completion_timeout(&rngc->rng_op_done,
> msecs_to_jiffies(RNGC_TIMEOUT)); -	imx_rngc_irq_mask_clear(rngc);
> -	if (!ret)
> -		return -ETIMEDOUT;
> +	ret =3D readl_poll_timeout(rngc->base + RNGC_STATUS, status,
> +				 status & RNGC_STATUS_ST_DONE, 1000,=20
RNGC_TIMEOUT * 1000);
> +	if (ret < 0)
> +		return ret;
>=20
> -	return rngc->err_reg ? -EIO : 0;
> +	return readl(rngc->base + RNGC_ERROR) ? -EIO : 0;
>  }
>=20
>  static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool
> wait)


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


