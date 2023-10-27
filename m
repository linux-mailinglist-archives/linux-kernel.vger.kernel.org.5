Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD47D9F05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbjJ0RrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0RrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:47:18 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E56E3;
        Fri, 27 Oct 2023 10:47:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F29E920004;
        Fri, 27 Oct 2023 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698428832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzMCYtHoI7SG+hrdCFiCqKFA4nKMelQAhb2DhwTgKRQ=;
        b=ks2FCKwG+qUGKUKS+xSIydbNB4NGUY3mwlU/NgeDdlDTejLg2JambDcbwdSVHxjpDt6RUt
        SOU6wkVUqDvDPuNYREmWTw4y4l19+SkYR/efASy76gR27gfeiCCE7jeH4Z3jQUyM1WHzHy
        mPbVYC7t/7eCFUEPF2V1NPcbHqAafDEmZlQgUqUtr56luoeH2EYplww6oKLNY+/bJC3oBB
        w9FLaRfw30aAVWcE/AAfxziwv5+k6QSmrJlZZQAXHmLcr8t2gOYXO7q+ZcEt9i6JB7lV+n
        Y1868b/iAouRTioj4Z+j4Jr3mGg2R4itesLTyA8FLznzayFbfVBu98AV2TlnqQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v4] mtd: cfi_cmdset_0001: Byte swap OTP info
Date:   Fri, 27 Oct 2023 19:47:11 +0200
Message-Id: <20231027174711.369946-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020-mtd-otp-byteswap-v4-1-0d132c06aa9d@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'565fe150624ee77dc63a735cc1b3bff5101f38a3'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 20:30:29 UTC, Linus Walleij wrote:
> Currently the offset into the device when looking for OTP
> bits can go outside of the address of the MTD NOR devices,
> and if that memory isn't readable, bad things happen
> on the IXP4xx (added prints that illustrate the problem before
> the crash):
> 
> cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x00000100
> ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
> cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x12000000
> ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address db000000
> [db000000] *pgd=00000000
> (...)
> 
> This happens in this case because the IXP4xx is big endian and
> the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
> properly byteswapped. Compare to how the code in read_pri_intelext()
> byteswaps the fields in struct cfi_pri_intelext.
> 
> Adding a small byte swapping loop for the OTP in read_pri_intelext()
> and the crash goes away.
> 
> The problem went unnoticed for many years until I enabled
> CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
