Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4987594B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSLzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSLzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:55:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9894CC7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689767738;
        bh=cH2/nzVcXEEHjVV40m2k9jPCJ614RcL25Duhv634PGw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Fc5drKTf7dgjP2S8xnSmZmYb6Ow3YvMz4iFLngt/IYHl9ErC5RiBRV09v2oNpQB1E
         t/+stHPHA9OAWnn457+dDLZlEfZ8/yz8HEgWcLpdrFASgLsypkJ/Vf3t3LvzxCi1wj
         3Cxe+V/iSsVumiXIB7k0y5ulZLLB6YDHFLkRMI9z+lxz2/RgLVa+PVkSK69nPNVCvl
         ArjyEEXsSb/XTkS9SELs9/Ge4y1hsaqsDmltqxWh4onpLKzEugz5bF20s4lgdtSfGJ
         +BserTOUifRmKLhqrG1LgTiHlBIGSeMLKlJc1+V5qGt5kv+GMCgoKcd87aYG61NE4Z
         TID90ajrGC1vg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5Z5Q3Tzzz4wb0;
        Wed, 19 Jul 2023 21:55:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     John Ogness <john.ogness@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
In-Reply-To: <87o7k9l2oj.fsf@jogness.linutronix.de>
References: <20230609051002.3342-1-npiggin@gmail.com>
 <871qh6wcgb.fsf@jogness.linutronix.de> <871qh5jrz2.fsf@mail.lhotse>
 <87o7k9l2oj.fsf@jogness.linutronix.de>
Date:   Wed, 19 Jul 2023 21:55:34 +1000
Message-ID: <87ttu0i095.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness <john.ogness@linutronix.de> writes:
> On 2023-07-18, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> ld: warning: discarding dynamic section .rela.opd
>>>
>>> and bisects to:
>>>
>>> 8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")
>>
>> Can you test with a newer compiler/binutils?
>
> Testing the Debian release cross compilers/binutils:
>
> Debian 10 / gcc 8.3.0  / ld 2.31.1: generates the warning
>
> Debian 11 / gcc 10.2.1 / ld 2.35.2: generates the warning
>
> Debian 12 / gcc 12.2.0 / ld 2.40:   does _not_ generate the warning
>
> I suppose moving to the newer toolchain is the workaround. Although it
> is a bit unusual to require such a modern toolchain in order to build a
> kernel without warnings.

I didn't mean that you should move to a new toolchain to avoid the
warning, I was just curious why you're the only person to see it.

I regularly test with a gcc 5.5.0 / ld 2.29 toolchain and gcc 13.1.1 /
ld 2.39, and I haven't seen the warning. I tried a bunch of others and
can't reproduce it.

Can you confirm that this makes the warning go away?

cheers


diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index bda6c8cdd459..286e1597c548 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -85,7 +85,7 @@ SECTIONS
 		*(.branch_lt)
 		*(.data .data.* .gnu.linkonce.d.* .sdata*)
 		*(.bss .sbss .dynbss .dynsbss)
-		*(.opd)
+		*(.opd .rela.opd)
 		*(.glink .iplt .plt .rela*)
 	}
 }
