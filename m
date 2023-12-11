Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F180CAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjLKNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbjLKNU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:20:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2299F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:21:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCBC433C7;
        Mon, 11 Dec 2023 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300862;
        bh=q1SgpAHgTb9yNjf1ijuF/WsU7ziWgOtp9e+gjYp9MJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtVmf+id/i3jL+CkVLVQSKAM+su33w9usY4qz6ohe9ikJJaAELtzij3VYjgA9Ewp8
         IbjgnPDTmFzYLzisW9RoqzCM+BlinoHFZh9dn8c3DWcsxaE7n/xlIFYd5cNd5iiZYM
         xn+RGUNrzobVTZmgr2G/YPkzYJMxadR3JbLDRVmqIeguYU5M9B/epx6dLNTOKngCI1
         MfqbPSRfjDDI0mZH6L+x+WiFuG5bmPQYYmqls0mwsWZmq8aHN3nwqrQ5zwoWRasUBO
         t0AaPcL5MZAHJ+qrn0787/YMKkAZKw1LM4Ra/RYRDixl9gMGsxMV+U5fiYp+UkKYuN
         EBTvml+3hP+1Q==
Date:   Mon, 11 Dec 2023 13:20:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
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
Subject: Re: [PATCH 12/21] arm64: setup: Switch over to GENERIC_CPU_DEVICES
 using arch_register_cpu()
Message-ID: <20231211132054.GC25681@willie-the-truck>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3b-00Csza-Ku@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1r5R3b-00Csza-Ku@rmk-PC.armlinux.org.uk>
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

On Tue, Nov 21, 2023 at 01:44:51PM +0000, Russell King wrote:
> From: James Morse <james.morse@arm.com>
> 
> To allow ACPI's _STA value to hide CPUs that are present, but not
> available to online right now due to VMM or firmware policy, the
> register_cpu() call needs to be made by the ACPI machinery when ACPI
> is in use. This allows it to hide CPUs that are unavailable from sysfs.
> 
> Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
> five ACPI architectures to be modified at once.
> 
> Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
> that populates the hotpluggable flag. arch_register_cpu() is also the
> interface the ACPI machinery expects.
> 
> The struct cpu in struct cpuinfo_arm64 is never used directly, remove
> it to use the one GENERIC_CPU_DEVICES provides.
> 
> This changes the CPUs visible in sysfs from possible to present, but
> on arm64 smp_prepare_cpus() ensures these are the same.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>  * Add note about initialisation order change.
> ---
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/include/asm/cpu.h |  1 -
>  arch/arm64/kernel/setup.c    | 13 ++++---------
>  3 files changed, 5 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
