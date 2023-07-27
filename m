Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80699765739
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjG0PRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjG0PRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:17:44 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802931B8;
        Thu, 27 Jul 2023 08:17:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92E5C60007;
        Thu, 27 Jul 2023 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690471061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNG9tje3l3xvzkqp9p4Pdm+9j03eaDrBKVPPDevDw7w=;
        b=a8isnEEHtGmLESwkXnzgHu0zmOpF5SXA6XP6oLmnOaOB1NpUhdjXq+lDqG08hOsvMhiCAH
        YEyUuVY5aldv26ZSUh6y+CkxEFf1ERZbglj77phxqtrpUCxVA/KVko+8jZUCaipIxNYuqw
        JN1ddb7ZXDTXbFwdVL080k2EYfyfxz4kMk8AU1+ouspuqrgeIqNCzUDR488no7iZEpU2vR
        KjXU5qUOULncJ4Suzpdkxg1MpctDH/yPuVmtrTnG02ZswGZODWuij9dKVKNpyv/5vmuTuB
        +AbUa1TBEMTWdvefjTzngTIPUtsdm7pyI3Cu8LZ3aG4M7pjtr4rstY/LhPuUuQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Foley <pefoley2@pefoley.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: avoid holes in struct spi_mem_op
Date:   Thu, 27 Jul 2023 17:17:38 +0200
Message-Id: <20230727151738.586338-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719190045.4007391-1-arnd@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'71c8f9cf2623d0db79665f876b95afcdd8214aec'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-19 at 19:00:25 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc gets confused when -ftrivial-auto-var-init=pattern is used on sparse
> bit fields such as 'struct spi_mem_op', which caused the previous false
> positive warning about an uninitialized variable:
> 
> drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]
> 
> In fact, the variable is fully initialized and gcc does not see it being
> used, so the warning is entirely bogus. The problem appears to be
> a misoptimization in the initialization of single bit fields when the
> rest of the bytes are not initialized.
> 
> A previous workaround added another initialization, which ended up
> shutting up the warning in spansion.c, though it apparently still happens
> in other files as reported by Peter Foley in the gcc bugzilla. The
> workaround of adding a fake initialization seems particularly bad
> because it would set values that can never be correct but prevent the
> compiler from warning about actually missing initializations.
> 
> Revert the broken workaround and instead pad the structure to only
> have bitfields that add up to full bytes, which should avoid this
> behavior in all drivers.
> 
> I also filed a new bug against gcc with what I found, so this can
> hopefully be addressed in future gcc releases. At the moment, only
> gcc-12 and gcc-13 are affected.
> 
> Cc: Peter Foley <pefoley2@pefoley.com>
> Cc: Pedro Falcato <pedro.falcato@gmail.com>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108402
> Link: https://godbolt.org/z/efMMsG1Kx
> Fixes: 420c4495b5e56 ("mtd: spi-nor: spansion: make sure local struct does not contain garbage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
