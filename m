Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733A7F34F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjKURb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjKURbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:31:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6EC1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZAL9dKnpF2ahjvBFKbedpgAAAyCrsmHVHqmzV1GMUOI=; b=UoiQqT8ica+PbDUU4t2T39jz3B
        QDK3+NM6mXtG5imeilghnFe0t7aCBGqfDVrCWmB9jhF6hbA+lDaQlz120X3Pd6Edyf/ScAKRcuPuT
        f1v03a9zQnRjVtOy+FOQyu/W9dB+9i8VkQSyfEBfZ2MLXlSGtbrqDtQl/VlrdwdMECfFYxSlQyrWz
        yWZluZoyZV2B8FvJ5eYTl+W5kRayjRUGUG3gusBP9sCNcOfFDRzsDNatqwmH/7oxDuj8AccbvTugp
        qSs/mD7o6hTs+FJQk2k/Bfzf4LlAfa8fUrIEUwdiGmUUpk8NIOSRlO83n7I/TvNuHblg+Se6wQG7s
        O4++ZvcQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5Ual-00HOYU-0u;
        Tue, 21 Nov 2023 17:31:19 +0000
Message-ID: <24a07872-ca92-431e-a81b-3e9815aa3c9a@infradead.org>
Date:   Tue, 21 Nov 2023 09:31:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Support rv32 ULEB128 test
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
 <20231117-module_fixup-v1-1-62bb777f6825@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231117-module_fixup-v1-1-62bb777f6825@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/23 11:56, Charlie Jenkins wrote:
> Use opcodes available to both rv32 and rv64 in uleb128 module linking
> test.
> 
> Fixes: af71bc194916 ("riscv: Add tests for riscv module loading")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/riscv/kernel/tests/module_test/test_uleb128.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/tests/module_test/test_uleb128.S b/arch/riscv/kernel/tests/module_test/test_uleb128.S
> index 90f22049d553..8515ed7cd8c1 100644
> --- a/arch/riscv/kernel/tests/module_test/test_uleb128.S
> +++ b/arch/riscv/kernel/tests/module_test/test_uleb128.S
> @@ -6,13 +6,13 @@
>  .text
>  .global test_uleb_basic
>  test_uleb_basic:
> -	ld	a0, second
> +	lw	a0, second
>  	addi	a0, a0, -127
>  	ret
>  
>  .global test_uleb_large
>  test_uleb_large:
> -	ld	a0, fourth
> +	lw	a0, fourth
>  	addi	a0, a0, -0x07e8
>  	ret
>  
> @@ -22,10 +22,10 @@ first:
>  second:
>  	.reloc second, R_RISCV_SET_ULEB128, second
>  	.reloc second, R_RISCV_SUB_ULEB128, first
> -	.dword 0
> +	.word 0
>  third:
>  	.space 1000
>  fourth:
>  	.reloc fourth, R_RISCV_SET_ULEB128, fourth
>  	.reloc fourth, R_RISCV_SUB_ULEB128, third
> -	.dword 0
> +	.word 0
> 

-- 
~Randy
