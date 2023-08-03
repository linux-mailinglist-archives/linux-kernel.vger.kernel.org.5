Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BAA76EDA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjHCPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjHCPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5EE73
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AC561DDD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09820C433C8;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075423;
        bh=vFaNgVOf1d9a/Nv1QbSxl/OPoNUBiM1RhE9LpnHf+Lo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tDU1II5tvV59psSojipcbWXN4+u0Ol3x5rYJnhE4t3Dkya4wXar5k+19IG6KePPzU
         YmZ6vMTT5cKHwLTbOGZlLfvdKPIYB4TMdO0bVP4NO43LzzYUdaKTE6eKwCQ+AXUXrI
         kb2BXzfCjFfcLYvGX66e17KXUNG36jP1sj+ETCqVKhNMHls6syfXjSMsznqUA0KqHN
         KaZE0hgqsHNo/gNhCC4jSqioO2Cpd1I5oRB55PCTqnb9mryVtxU2xjVCd65LVtcG1A
         kpresnOnHXiCZWlndJNzoPKzZjWHODdTDoXQCuVdIhChv+Nzhbu3nbCz+OZ47i2u6r
         kmJjYVzWwfWQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDEA6C595C1;
        Thu,  3 Aug 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return iomem
 address
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542290.19238.2836773902339575620.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 15:10:22 +0000
References: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
In-Reply-To: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, lkp@intel.com, conor.dooley@microchip.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        ajones@ventanamicro.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Jul 2023 15:33:46 +0530 you wrote:
> acpi_os_ioremap() currently is a wrapper to memremap() on
> RISC-V. But the callers of acpi_os_ioremap() expect it to
> return __iomem address and hence sparse tool reports a new
> warning. Fix this issue by type casting to  __iomem type.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@intel.com/
> Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> [...]

Here is the summary with links:
  - [v3,-fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address
    https://git.kernel.org/riscv/c/568701fee366

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


