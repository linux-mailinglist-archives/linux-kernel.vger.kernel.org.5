Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8C808AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443257AbjLGOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjLGOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:43:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A10AC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:43:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECA8C433C7;
        Thu,  7 Dec 2023 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701960193;
        bh=GS0pkCiCklBA0a7xl7TBuU7N9iIAAufEGuz/4h4QpeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S3q88fnkCsJDZ+yihqdkttJ3GffGOnFsmkywke2kTkN4KViKKNJludWPdPrA290PK
         P6IDDqLaELe5ah6+dl3/ULxe9DX5cOe+wx0PsDkDWjArS1IVF428O0Ii3ErtncLNhn
         c4XaPpSIy2Nzfmt75id2nUPRRFExIeLhWxRPRWE51M1n5hVd3QB839qnf4RQu+v4P7
         Gv7rHq13RNCDb4ZXJQDYzdGVNDR6e+TGtjxnVgL9PLdfLzfgdvBsNEraV7m84KLL1v
         RoHxylIGPWKBZrxXpamPxteb7dcR/kYk6W8OjmCucvIS0L2ncrmXRgyjF4cfb6YpxO
         +Z6DcWd9980xQ==
Date:   Thu, 7 Dec 2023 15:43:09 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sjoerd Simons <sjoerd@collabora.com>
Cc:     kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] bus: moxtet: Mark the irq as shared
Message-ID: <20231207154309.174a0753@dellmb>
In-Reply-To: <20231128213536.3764212-2-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
        <20231128213536.3764212-2-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 22:35:04 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The Turris Mox shares the moxtet IRQ with various devices on the board,
> so mark the IRQ as shared in the driver as well.
>=20
> Without this loading the module will fail with:
>   genirq: Flags mismatch irq 40. 00002002 (moxtet) vs. 00002080 (mcp7940x)
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Cc: stable@vger.kernel.org # v6.2+
> ---
>=20
> (no changes since v1)
>=20
>  drivers/bus/moxtet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 5eb0fe73ddc4..48c18f95660a 100644
> --- a/drivers/bus/moxtet.c
> +++ b/drivers/bus/moxtet.c
> @@ -755,7 +755,7 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
>  	moxtet->irq.masked =3D ~0;
> =20
>  	ret =3D request_threaded_irq(moxtet->dev_irq, NULL, moxtet_irq_thread_f=
n,
> -				   IRQF_ONESHOT, "moxtet", moxtet);
> +				   IRQF_SHARED | IRQF_ONESHOT, "moxtet", moxtet);
>  	if (ret < 0)
>  		goto err_free;
> =20

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
