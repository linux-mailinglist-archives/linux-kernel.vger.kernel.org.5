Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CFF800B66
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378923AbjLANDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbjLANDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:03:09 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F76710F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:03:14 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3B1D37RU008087;
        Fri, 1 Dec 2023 21:03:07 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Fri, 1 Dec 2023 21:03:07 +0800
Date:   Fri, 1 Dec 2023 21:03:03 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel.holland@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3] riscv: errata: andes: Probe for IOCP only once in
 boot stage
Message-ID: <ZWnZh8vqaNaZmsHf@APC323>
References: <20231130212647.108746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130212647.108746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3B1D37RU008087
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:26:47PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> We need to probe for IOCP only once during boot stage, as we were probing
> for IOCP for all the stages this caused the below issue during module-init
> stage,
> 
> [9.019104] Unable to handle kernel paging request at virtual address ffffffff8100d3a0
> [9.027153] Oops [#1]
> [9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can_dev spi_rspi i2c_core
> [9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
> [9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> [9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
> [9.055558]  ra : andes_errata_patch_func+0x4a/0x52
> [9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffffc8003abb00
> [9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 0000000000000000
> [9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffffc8003abb20
> [9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 0000000000000001
> [9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff8100d8be
> [9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 000000000900031e
> [9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 000000000000031e
> [9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 000000000000003f
> [9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffffff8151a1b0
> [9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefefefefefeff
> [9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
> [9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause: 000000000000000f
> [9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x3e
> [9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
> [9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
> [9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
> [9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
> [9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
> [9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a8
> [9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
> [9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
> [9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 (0123) aef7
> [9.205994] ---[ end trace 0000000000000000 ]---
> 
> This is because we called riscv_noncoherent_supported() for all the stages
> during IOCP probe. riscv_noncoherent_supported() function sets
> noncoherent_supported variable to true which has an annotation set to
> "__ro_after_init" due to which we were seeing the above splat. Fix this by
> probing for IOCP only once in boot stage by having a boolean variable
> "done" which will be set to true upon IOCP probe in errata_probe_iocp()
> and we bail out early if "done" is set to true.
> 
> While at it make return type of errata_probe_iocp() to void as we were
> not checking the return value in andes_errata_patch_func().
> 
> Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

It seems that vdso.so currently does not have a .alternative section.
Anyway, it makes sense to me.

Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>

Thanks,
Peter Lin

> ---
>  arch/riscv/errata/andes/errata.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> index 197db68cc8da..17a904869724 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -38,29 +38,35 @@ static long ax45mp_iocp_sw_workaround(void)
>  	return ret.error ? 0 : ret.value;
>  }
>  
> -static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
> +static void errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
>  {
> +	static bool done;
> +
>  	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> -		return false;
> +		return;
> +
> +	if (done)
> +		return;
> +
> +	done = true;
>  
>  	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
> -		return false;
> +		return;
>  
>  	if (!ax45mp_iocp_sw_workaround())
> -		return false;
> +		return;
>  
>  	/* Set this just to make core cbo code happy */
>  	riscv_cbom_block_size = 1;
>  	riscv_noncoherent_supported();
> -
> -	return true;
>  }
>  
>  void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  					      unsigned long archid, unsigned long impid,
>  					      unsigned int stage)
>  {
> -	errata_probe_iocp(stage, archid, impid);
> +	if (stage == RISCV_ALTERNATIVES_BOOT)
> +		errata_probe_iocp(stage, archid, impid);
>  
>  	/* we have nothing to patch here ATM so just return back */
>  }
> -- 
> 2.34.1
> 
