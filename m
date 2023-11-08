Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F57E5A89
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjKHPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:54:07 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2821BC3;
        Wed,  8 Nov 2023 07:54:04 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C80EA60008;
        Wed,  8 Nov 2023 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699458843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYS94S7++WYKx+tHBKHHGfIvXY84QiR+o61nAhem3TE=;
        b=JMmrAxt6CfsPfRIT849ExEJi2VTTQkFSMaqLfqgUH4rvB5ZfddAYUbwUnjgGxDIq8YaOxl
        B5Zs58doliOu1V5XAgr5Tw38Z1+5CRVNvd7AZsFJ5YKyTc5v/EX8df+BFjxU/kDeqmhRWV
        8mifPlDY5iQb3p6b6jxvAmqf0Y87HAK6Iz/dWJ2ogWB2MW6jdZshdyV/tjYtH+CDrseL6c
        tW0wdNCF061azZnNKVx9kSNfGNTvWf/PXpbdSKGyKItVc1PwwFQztE7OqJlQDOQ8QYNGuv
        K+J87XKp360j9MWnbE3DsJ5UTmGYXLso7wSAid5sirjABqj0oBrNjYf/fsuuPg==
Date:   Wed, 8 Nov 2023 16:53:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 4/6] mtd: rawnand: gpio: Use device properties
Message-ID: <20231108165359.33dccef0@xps-13>
In-Reply-To: <20231108-fix-mips-nand-v1-4-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
        <20231108-fix-mips-nand-v1-4-5fc5586d04de@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

linus.walleij@linaro.org wrote on Wed, 08 Nov 2023 15:33:52 +0100:

> The platform data (struct gpio_nand_platdata) isn't really used
> in any boardfile in the kernel: the only probe path is from
> device tree.
>=20
> Convert the driver to not use the platform data header at all
> and read out the device tree properties using device
> properties so we don't need to have the driver be exclusively
> device tree either: ACPI or software nodes work fine if
> need be. Drop the ifdeffery around CONFIG_OF as a consequence.
>=20
> The code reads "bank-width" to plat->options flags and passes
> it directly to the NAND chip struct, so just assign this
> directly to the chip instead.
>=20
> The code reads one property "chip-delay" that it stores
> in pdata->delay and never use, so drop this altogether.
> If timings should be supported this can probably be done in
> a more detailed way using the new elaborate timings structs
> that exist for NAND.
>=20
> The platform data contains a callback to augment partitions,
> but since there are no board files using this platform
> data to define a gpio NAND device, this is never used so
> the code handling it can be deleted.

Nice cleanup. I'm a bit more reluctant on the bindings side, I'll come
back to it later, but the driver side looks neat.

Thanks,
Miqu=C3=A8l
