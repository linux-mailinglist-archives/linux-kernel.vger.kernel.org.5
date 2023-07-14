Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16E753ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjGNP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbjGNP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF31BD4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2F861D4E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D23C433C8;
        Fri, 14 Jul 2023 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689348423;
        bh=PohzP/6CVU4qNJVwu6BvOLEqRA2FFMRHS3Zp9exoByM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhA04VnYAHHzDnAUPRYio1BpG+t//WZ4aMT8Qd3OiH5CSCVekX2n3WtS7C9uiVpEm
         Jew0J4wPPuGepXSSRePuXzOTJ7XkYuNtG/WbgXQyopAeD1tn176mXAi6MwdsiIrl+r
         saiqL3DsS2MzU8iyojy5d3YoKE68eUcfLXdictmno4CYzLMePdSpswZcZQNZBXTAYq
         6UXzGxny7gtAIoejg7H58nGBGsqV8fjLSVeSAoA4qI1/GQG7mP9AM+/c0m+rwsFwph
         suUkpxHL//2GFW845r0r/lRZ1BJrJq2knHCVlRollJkJRAnX6rY+3Tm6HurG1nATOb
         EX0bHw0RciyQg==
Date:   Fri, 14 Jul 2023 08:27:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 12/18] mtd: nand: omap: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230714152701.GA1300718@dev-arch.thelio-3990X>
References: <20230707040622.78174-12-frank.li@vivo.com>
 <20230713075751.486075-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713075751.486075-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:57:51AM +0200, Miquel Raynal wrote:
> On Fri, 2023-07-07 at 04:06:16 UTC, Yangtao Li wrote:
> > Convert platform_get_resource(), devm_ioremap_resource() to a single
> > call to devm_platform_get_and_ioremap_resource(), as this is exactly
> > what this function does.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Please apply the updated version at [1], the current version is
obviously not correct, as clang points out in next-20230714:

  drivers/mtd/nand/onenand/onenand_omap2.c:470:2: warning: variable 'c' is uninitialized when used here [-Wuninitialized]
    470 |         c->onenand.base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
        |         ^
  drivers/mtd/nand/onenand/onenand_omap2.c:465:25: note: initialize the variable 'c' to silence this warning
    465 |         struct omap2_onenand *c;
        |                                ^
        |                                 = NULL
  1 warning generated.

KernelCI also reported this at [2]. I apologize if this has already been
reported or fixed locally, I did not see your branch updated.

[1]: https://lore.kernel.org/20230713104422.29222-1-frank.li@vivo.com/
[2]: https://lore.kernel.org/64b137dc.170a0220.b8a13.feee@mx.google.com/

Cheers,
Nathan
