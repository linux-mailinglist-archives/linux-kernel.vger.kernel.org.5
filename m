Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD1751A95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjGMH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjGMH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:35 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED369211F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B1142000F;
        Thu, 13 Jul 2023 07:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgxUjxWYaES9J/u7KyH5WhMtdN6ljfnBaRxicp8S6UY=;
        b=lz+a+PkGSLThvtWT9tWmOR0dk/jDrDCdJO+LZfme7Ee+yf38vGGi3+Y55nxcLFgzStjCRA
        SAgU4ErCTN8XUEPG44r7QN4p7af0fmP38ErI4NqU42mj/ySFPWmQ0vC8BXrbMpBAaEeut9
        2V4iNfjtjKoaLyIbJX6kPk/pere5nmRkN33T0SgockNaVlauTLy96mSA2E1c8unhFlec1Q
        nJUiHrdoV62slBXN6lCqxKCKxvT3IxkXW2d4QrjNtHo9pZjMttopytAIFlniz7KdOPfU0g
        zN0qhg6Hq4t/uL2rp9C/1F/qQKEiT2sv5IfauOMw0uOOKF7gRZLnZ86u0teraA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, f.fainelli@gmail.com,
        rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: rawnand: brcmnand: Fix mtd oobsize
Date:   Thu, 13 Jul 2023 09:58:30 +0200
Message-Id: <20230713075830.486450-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706182909.79151-6-william.zhang@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'60177390fa061c62d156f4a546e3efd90df3c183'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-06 at 18:29:09 UTC, William Zhang wrote:
> brcmnand controller can only access the flash spare area up to certain
> bytes based on the ECC level. It can be less than the actual flash spare
> area size. For example, for many NAND chip supporting ECC BCH-8, it has
> 226 bytes spare area. But controller can only uses 218 bytes. So brcmand
> driver overrides the mtd oobsize with the controller's accessible spare
> area size. When the nand base driver utilizes the nand_device object, it
> resets the oobsize back to the actual flash spare aprea size from
> nand_memory_organization structure and controller may not able to access
> all the oob area as mtd advises.
> 
> This change fixes the issue by overriding the oobsize in the
> nand_memory_organization structure to the controller's accessible spare
> area size.
> 
> Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
