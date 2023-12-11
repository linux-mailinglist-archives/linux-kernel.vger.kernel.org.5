Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D780CACC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbjLKNVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbjLKNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:21:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2914C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:21:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D26C433C7;
        Mon, 11 Dec 2023 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300894;
        bh=pdOjaPV9Jsg2+hufBUTJoin1FtJ4JLo5gH1YiEsQ8lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIX+Piq0oQQdGn8TD0Edg+vyONGxOr1LGqK2bq6Dsi6ovtOvnWpT/rIpQOFhBlA3b
         RD+M0Y9olHV8bbTdPocbTzZZmSuQtM3wSgOKRufOCXeKAdrG2YkwpRzI1hwx19gfpd
         R8J7br7NfDKSsDo3Ubfz/IzHwRPxRpH0UZXsDmakCZQtxs8yx3CHcht0dAUUySZ72W
         7ezqAlqh/1/ULVq4w52iqG1vo6pwpmtsxVWD0ybb3R5KpAvHOys51oI1D1oLC2d49W
         kbq2skXfspeTVUkdhvgV61N5n4rZQ8glL+SZEddbiQ/dbTg34ryLGY2yDr7oygKcuA
         WwZRQbf9JcgXw==
Date:   Mon, 11 Dec 2023 13:21:27 +0000
From:   Will Deacon <will@kernel.org>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/21] arm64: convert to arch_cpu_is_hotpluggable()
Message-ID: <20231211132127.GD25681@willie-the-truck>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3g-00Cszg-PP@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r5R3g-00Cszg-PP@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:44:56PM +0000, Russell King (Oracle) wrote:
> Convert arm64 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm64/kernel/setup.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 165bd2c0dd5a..42c690bb2d60 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -402,13 +402,9 @@ static inline bool cpu_can_disable(unsigned int cpu)
>  	return false;
>  }
>  
> -int arch_register_cpu(int num)
> +bool arch_cpu_is_hotpluggable(int num)
>  {
> -	struct cpu *cpu = &per_cpu(cpu_devices, num);
> -
> -	cpu->hotpluggable = cpu_can_disable(num);
> -
> -	return register_cpu(cpu, num);
> +	return cpu_can_disable(num);
>  }
>  
>  static void dump_kernel_offset(void)

Acked-by: Will Deacon <will@kernel.org>

Will
