Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B27FD121
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjK2Iki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjK2IkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:40:06 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAFD19B7;
        Wed, 29 Nov 2023 00:40:00 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 245C21BF20B;
        Wed, 29 Nov 2023 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701247199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKfCywz8yVWhuffi+1nkdllKuJTy6/CWyrIaSRqsEDo=;
        b=idDYTh8FaXonBvu10jpAJAvqRXDUMcy3ydRDLkNHkYSI9BJ7ZZ9fS23LrJCTTpMILCV7Mi
        R1hPCxUzohf/QP4DrynIEonaYa9zr6MEo1daksb5YCCT4zwKrP7ain62v8qu/a4E+N7QN+
        JCt1cwaXAlGnow3OZZMcwB480LkPHgVRDNhAu+gHB6w0RR32dxFedr8Tu8QfTPRMhBgJqq
        xwr/qxKl9mGj0p88Y3w2fSz7MLsI1ATrVyrOevFeNrlTaHDQMEHQodqtGfzoqMtgBeTS4t
        uOhMqW2d2oMaG5zOlZ1dcHDDZ72G9Eeb+Z32AxpnBTKTQLLamuWPpoEDJMqqjQ==
Date:   Wed, 29 Nov 2023 09:39:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP
 with -EOPNOTSUPP
Message-ID: <20231129093953.00dc04da@xps-13>
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

acelan.kao@canonical.com wrote on Wed, 29 Nov 2023 14:43:10 +0800:

> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>=20
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
>=20
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
>=20
> 2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
> mainly being reserved for NFS-related errors. To align with kernel coding
> standards and recommendations, this change is being made.
>=20
> 3. By using EOPNOTSUPP, we provide more specific context to the error,
> indicating that a particular operation is not supported. This helps
> differentiate from the more generic ENOTSUPP error, allowing drivers to
> better handle and respond to different error scenarios.
>=20
> Risks and Considerations:
> While this change is primarily intended as a code cleanup and error code
> unification, there is a minor risk of breaking user-space applications
> that rely on specific return codes for unsupported operations. However,
> this risk is considered low, as such use-cases are unlikely to be common
> or critical. Nevertheless, developers and users should be aware of this
> change, especially if they have scripts or tools that specifically handle
> SPI error codes.
>=20
> This commit does not introduce any functional changes to the SPI subsystem
> or the affected drivers.
>=20
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>=20
> ---
> v5. distinguish -EOPNOTSUPP from -ENOTSUPP
> v6. a. spi_nor_set_4byte_addr_mode() should check -EOPNOTSUPP, all
>        callbacks of set_4byte_addr_mode() will eventually return
>        -EOPNOTSUPP if the checking failed.
>     b. Update comment to describe the reason for the patch and the
>        affected parts.
>     c. Update the kernel-doc of exec_op() in struct spi_controller_mem_ops
> v7. added comment for the return code changes may affect userspace, and
>     the risk after this change
> ---

Looks sensible to me, let's make the conversion.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
