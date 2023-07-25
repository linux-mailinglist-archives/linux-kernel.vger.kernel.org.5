Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED83761065
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGYKP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjGYKPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:15:55 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B11728
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:15:42 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 6E99616E7EB;
        Tue, 25 Jul 2023 12:15:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1690280139; bh=VkSwamAp/4PDPv7DdYCrtZQ5vmXGPZLbqsG5fwWzuZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p6x10Yht8ow48zlrALbeY2e4IicnzbpwZLWp9qIt+gAjalRXgUE2EMKYQe93s+Wty
         OLQJ4s9WLrmhjHqzKlJ7BdXR8lmGJakv1WIWZnAdt1QImnmnur6uRrtJgOsCEG5Ixv
         67kEzE64ng+hilOryKzXuKOYKRIbGyu1DL460HDayizReh1NBVmXoLBjniDiVU4q06
         viKPt1HvhkjWx5A4k4rrkHEHVZ/ZdSlqSr+uxtHIAugwjbfRiDl1/50VIcpf2q5O7D
         O214xNUZNaHf2zYwx9C0Z+UUERZLxpGkZmMy5l/nFQSJ1qxuK2oPOpB976q6Jvhg1p
         05ofrg+vXWnXA==
Date:   Tue, 25 Jul 2023 12:15:38 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alyssa Ross <hi@alyssa.is>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Torsten Duwe <duwe@lst.de>, Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH v1 1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation
 type
Message-ID: <20230725121538.2bb4b64f@meshulam.tesarici.cz>
In-Reply-To: <652f652d571458522a615040f68a885f10b45ca7.1690274483.git.petr.tesarik.ext@huawei.com>
References: <cover.1690274483.git.petr.tesarik.ext@huawei.com>
        <652f652d571458522a615040f68a885f10b45ca7.1690274483.git.petr.tesarik.ext@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Torsten (somehow missed from the original Cc list).

Petr T

On Tue, 25 Jul 2023 10:44:25 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Torsten Duwe <duwe@suse.de>
> 
> R_RISCV_CALL has been deprecated and replaced by R_RISCV_CALL_PLT. See Enum
> 18-19 in Table 3. Relocation types here:
> 
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-elf.adoc
> 
> It was deprecated in ("Deprecated R_RISCV_CALL, prefer R_RISCV_CALL_PLT"):
> 
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018d7a0ec17023c9389cbd70b1dbc1b0
> 
> Recent tools (at least GNU binutils-2.40) already use R_RISCV_CALL_PLT.
> Kernels built with such binutils fail kexec_load_file(2) with:
> 
>  kexec_image: Unknown rela relocation: 19
>  kexec_image: Error loading purgatory ret=-8
> 
> The binary code at the call site remains the same, so tell
> arch_kexec_apply_relocations_add() to handle _PLT alike.
> 
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> Cc: Li Zhengyu <lizhengyu3@huawei.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/riscv/kernel/elf_kexec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 5372b708fae2..38390d3bdcac 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  		 * sym, instead of searching the whole relsec.
>  		 */
>  		case R_RISCV_PCREL_HI20:
> +		case R_RISCV_CALL_PLT:
>  		case R_RISCV_CALL:
>  			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
>  				 ENCODE_UJTYPE_IMM(val - addr);

