Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C48089E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443000AbjLGOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442978AbjLGOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:09:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46AB10CB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:09:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0B9C433C7;
        Thu,  7 Dec 2023 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701958167;
        bh=H4XF+LqR6lnW5axiIdnTAEfuhRgWdQr7OOX8znjsCwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gXnRRnfdQToNJAuodRkXasWCP48sM3fMyS8EC6ilFDSGi0arEZSYiYdJyhCZpsZbt
         GiRohH6K3kZYMUQOsyz7cA2QzJExNzJivnJz3T1xeCp/1gQmn/ZF/CK6YzOQpvM+QS
         qCjKrjtKzFOpfEpbEtkURKSIie0/P+6ptCei62sxi+rtI9wPxTe2LhI7Ku4BaqQ7DE
         vaT7gDjWTmBCCFdKyIcm5cZwPIpeByQe3L75Fx/JcGDUFDav5a87o2umzIF3llBWSl
         9lQc/rN7NMq2IcBv3K9jejz8aLd28UkbcLrdcsbuAoewClRPn76fCMaIkwQCjPmaJm
         qriPrsZUgZkxw==
Date:   Thu, 7 Dec 2023 15:09:17 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sjoerd Simons <sjoerd@collabora.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: moxtet: Mark the irq as shared
Message-ID: <20231207150917.6f69999c@dellmb>
In-Reply-To: <20231123142403.2262032-1-sjoerd@collabora.com>
References: <20231123142403.2262032-1-sjoerd@collabora.com>
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

On Thu, 23 Nov 2023 15:23:37 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The Turris Mox shares the moxtet IRQ with various devices on the board,
> so mark the IRQ as shared in the driver as well.
>=20
> Without this loading the module will fail with:
>   genirq: Flags mismatch irq 40. 00002002 (moxtet) vs. 00002080 (mcp7940x)
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
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
