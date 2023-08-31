Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887B678E53C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbjHaEEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbjHaEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:04:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510CA1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:04:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbncG49ZSz4wy6;
        Thu, 31 Aug 2023 14:04:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <c90780017b624b91771a3e4240dcbadc68137915.1692684784.git.christophe.leroy@csgroup.eu>
References: <c90780017b624b91771a3e4240dcbadc68137915.1692684784.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/85xx: Mark some functions static and add missing includes to fix no previous prototype error
Message-Id: <169345455027.11824.1278535983200395426.b4-ty@ellerman.id.au>
Date:   Thu, 31 Aug 2023 14:02:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 08:13:13 +0200, Christophe Leroy wrote:
> corenet{32/64}_smp_defconfig leads to:
> 
>   CC      arch/powerpc/sysdev/ehv_pic.o
> arch/powerpc/sysdev/ehv_pic.c:45:6: error: no previous prototype for 'ehv_pic_unmask_irq' [-Werror=missing-prototypes]
>    45 | void ehv_pic_unmask_irq(struct irq_data *d)
>       |      ^~~~~~~~~~~~~~~~~~
> arch/powerpc/sysdev/ehv_pic.c:52:6: error: no previous prototype for 'ehv_pic_mask_irq' [-Werror=missing-prototypes]
>    52 | void ehv_pic_mask_irq(struct irq_data *d)
>       |      ^~~~~~~~~~~~~~~~
> arch/powerpc/sysdev/ehv_pic.c:59:6: error: no previous prototype for 'ehv_pic_end_irq' [-Werror=missing-prototypes]
>    59 | void ehv_pic_end_irq(struct irq_data *d)
>       |      ^~~~~~~~~~~~~~~
> arch/powerpc/sysdev/ehv_pic.c:66:6: error: no previous prototype for 'ehv_pic_direct_end_irq' [-Werror=missing-prototypes]
>    66 | void ehv_pic_direct_end_irq(struct irq_data *d)
>       |      ^~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/sysdev/ehv_pic.c:71:5: error: no previous prototype for 'ehv_pic_set_affinity' [-Werror=missing-prototypes]
>    71 | int ehv_pic_set_affinity(struct irq_data *d, const struct cpumask *dest,
>       |     ^~~~~~~~~~~~~~~~~~~~
> arch/powerpc/sysdev/ehv_pic.c:112:5: error: no previous prototype for 'ehv_pic_set_irq_type' [-Werror=missing-prototypes]
>   112 | int ehv_pic_set_irq_type(struct irq_data *d, unsigned int flow_type)
>       |     ^~~~~~~~~~~~~~~~~~~~
>   CC      arch/powerpc/sysdev/fsl_rio.o
> arch/powerpc/sysdev/fsl_rio.c:102:5: error: no previous prototype for 'fsl_rio_mcheck_exception' [-Werror=missing-prototypes]
>   102 | int fsl_rio_mcheck_exception(struct pt_regs *regs)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/sysdev/fsl_rio.c:306:5: error: no previous prototype for 'fsl_map_inb_mem' [-Werror=missing-prototypes]
>   306 | int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
>       |     ^~~~~~~~~~~~~~~
> arch/powerpc/sysdev/fsl_rio.c:357:6: error: no previous prototype for 'fsl_unmap_inb_mem' [-Werror=missing-prototypes]
>   357 | void fsl_unmap_inb_mem(struct rio_mport *mport, dma_addr_t lstart)
>       |      ^~~~~~~~~~~~~~~~~
> arch/powerpc/sysdev/fsl_rio.c:445:5: error: no previous prototype for 'fsl_rio_setup' [-Werror=missing-prototypes]
>   445 | int fsl_rio_setup(struct platform_device *dev)
>       |     ^~~~~~~~~~~~~
>   CC      arch/powerpc/sysdev/fsl_rmu.o
> arch/powerpc/sysdev/fsl_rmu.c:362:6: error: no previous prototype for 'msg_unit_error_handler' [-Werror=missing-prototypes]
>   362 | void msg_unit_error_handler(void)
>       |      ^~~~~~~~~~~~~~~~~~~~~~
>   CC      arch/powerpc/platforms/85xx/corenet_generic.o
> arch/powerpc/platforms/85xx/corenet_generic.c:33:13: error: no previous prototype for 'corenet_gen_pic_init' [-Werror=missing-prototypes]
>    33 | void __init corenet_gen_pic_init(void)
>       |             ^~~~~~~~~~~~~~~~~~~~
> arch/powerpc/platforms/85xx/corenet_generic.c:51:13: error: no previous prototype for 'corenet_gen_setup_arch' [-Werror=missing-prototypes]
>    51 | void __init corenet_gen_setup_arch(void)
>       |             ^~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/platforms/85xx/corenet_generic.c:104:12: error: no previous prototype for 'corenet_gen_publish_devices' [-Werror=missing-prototypes]
>   104 | int __init corenet_gen_publish_devices(void)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      arch/powerpc/platforms/85xx/qemu_e500.o
> arch/powerpc/platforms/85xx/qemu_e500.c:28:13: error: no previous prototype for 'qemu_e500_pic_init' [-Werror=missing-prototypes]
>    28 | void __init qemu_e500_pic_init(void)
>       |             ^~~~~~~~~~~~~~~~~~
>   CC      arch/powerpc/kernel/pmc.o
> arch/powerpc/kernel/pmc.c:78:6: error: no previous prototype for 'power4_enable_pmcs' [-Werror=missing-prototypes]
>    78 | void power4_enable_pmcs(void)
>       |      ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/85xx: Mark some functions static and add missing includes to fix no previous prototype error
      https://git.kernel.org/powerpc/c/c265735ff5b1f13272e2bfb196f5c55f9b3c9bac

cheers
