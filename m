Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1B7D2CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJWI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjJWIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:25:59 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4535EE;
        Mon, 23 Oct 2023 01:25:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85424E000B;
        Mon, 23 Oct 2023 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698049554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH7kvmH3ojoWMj9A0P1moFfx4wi0a2NDXu5JLkLu5dI=;
        b=ORcCWdoQOxle8Dj1g3NtvFSN1Kn3zGbnY+5+WIch8s2EmUwNNFyJEX4Yv0BPYN62nhHbxX
        C1SaoZesOnCZWUXZKcNLu1MAqd11Uji4mpuq4/ghZ3VvpHrKSQ8gDln0rNNQTUa2tkmc/O
        Bih2B8DULFedvN6KO7KEiASDeTaGc8xFa5J0H6xDRE3RqeqYLIF1CVp6a7sZFhKUooX5Yi
        1cJ/ZeiB0edSteaBp3HGQoLU7pDMvm+pTzMZuIQ3VYeRj0g/liY2IaBHEdDCibJ012ghyD
        aeUuiZyu5O2LKQO2iFea6Dr2t1dKMlpemycAF3nHsOLUO6Gl9T5d42ydVPknnA==
Date:   Mon, 23 Oct 2023 10:25:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v4] mtd: cfi_cmdset_0001: Byte swap OTP info
Message-ID: <20231023102552.4b053b17@xps-13>
In-Reply-To: <20231020-mtd-otp-byteswap-v4-1-0d132c06aa9d@linaro.org>
References: <20231020-mtd-otp-byteswap-v4-1-0d132c06aa9d@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Fri, 20 Oct 2023 22:30:29 +0200:

> Currently the offset into the device when looking for OTP
> bits can go outside of the address of the MTD NOR devices,
> and if that memory isn't readable, bad things happen
> on the IXP4xx (added prints that illustrate the problem before
> the crash):
>=20
> cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x00000=
100
> ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
> cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x12000=
000
> ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address db000000
> [db000000] *pgd=3D00000000
> (...)
>=20
> This happens in this case because the IXP4xx is big endian and
> the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
> properly byteswapped. Compare to how the code in read_pri_intelext()
> byteswaps the fields in struct cfi_pri_intelext.
>=20
> Adding a small byte swapping loop for the OTP in read_pri_intelext()
> and the crash goes away.
>=20
> The problem went unnoticed for many years until I enabled
> CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.
>=20
> Cc: stable@vger.kernel.org

Would you like to add a Fixes tag as well? Or is this skipped on
purpose?

> Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Collected Nico's ACK.
> - Stalled since june! Has this been missed?

Our current organization relies on Vignesh to pick-up (or tell me to
pick-up) cfi patches. But he is slightly less active these days, so if I
don't get any feedback from him soon I will take it for the next merge
window.

Sorry for the delay anyway.

Cheers,
Miqu=C3=A8l
