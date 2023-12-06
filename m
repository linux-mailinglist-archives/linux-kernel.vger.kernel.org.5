Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9225D8070B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378462AbjLFNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjLFNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:16:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F4AC;
        Wed,  6 Dec 2023 05:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9xb/j8079N30XiCpQfsE2XSQRB8MrOJjvILD0qCjplA=;
        t=1701868581; x=1703078181; b=xaLQFagEZqYh1tkDzaYFr8lElv1xj6gKYaOCl34tQDuzj+9
        GXWnOkKrvJAfp/R6yc71cWAoR4TfsFniWYvyDtg896k0KhHQySv4bUwPjfl1Sxyy0b/yUC6cHBirM
        tFB3rFR9B9ljB5loCeut7ilBwFQ12YKtFdBj5t9hqEwYZC1fnnyppx5A0kgNW/rf/7Typa8qtdToU
        vsYWyTXXmrCCRRpgP23d2LUA7gRqJXxK70nxclSu/YaEGMrC3hK0AuPTqB+I2YXDYIpUejcxN1AwZ
        Z2tXEt3kCX1XjkbIoLFHlOsJxmbzhT9jfJFZAgxK9/VX9/tU4nie9zmqOK/z7OXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1rArlB-000000004Nm-0dCe;
        Wed, 06 Dec 2023 14:16:17 +0100
Message-ID: <cd25fd96fa391d3c8a5811d995d166cbb0b0efe5.camel@sipsolutions.net>
Subject: Re: [PATCH] net: rfkill: gpio: set GPIO direction
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Josua Mayer <josua@solid-run.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Date:   Wed, 06 Dec 2023 14:16:15 +0100
In-Reply-To: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-06 at 14:13 +0100, Rouven Czerwinski wrote:
>=20
> +++ b/net/rfkill/rfkill-gpio.c
> @@ -126,6 +126,16 @@ static int rfkill_gpio_probe(struct platform_device =
*pdev)
>  		return -EINVAL;
>  	}
> =20
> +	if (rfkill->reset_gpio)
> +		ret =3D gpiod_direction_output(rfkill->reset_gpio, true);
> +	if (ret)
> +		return ret;
> +
> +	if (rfkill->shutdown_gpio)
> +		ret =3D gpiod_direction_output(rfkill->shutdown_gpio, true);
> +	if (ret)
> +		return ret;
>=20

That's weird, you need ret to be inside the if. It's even entirely
uninitialized if you don't have ACPI, if you don't have reset/shutdown.

johannes
