Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF757897B5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjHZPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjHZPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8E1987;
        Sat, 26 Aug 2023 08:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 817EE628A8;
        Sat, 26 Aug 2023 15:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E4C433C8;
        Sat, 26 Aug 2023 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693063354;
        bh=E31FwGb2oXUbD3L+jAYfB/z3kLDG1QtXIIRlqVD/tW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUOlpGXWP0rfOLwcK6XCLjc+WM3NEII1xsT8EVwOtb4+tvg+tXCit86bkDONF+1qZ
         QEmtFAljqcZEJ4H+xH2dIRs2RwjuJ+yueFS00fZllR8d0KWetKzfErE/vrP96oJYcR
         lHaoCjYS9EPwAx676Wh8+gViDZE6YlRX6YwJ+TRA=
Date:   Sat, 26 Aug 2023 17:22:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] LoongArch: Ensure FP/SIMD registers in the core dump
 file is up to date
Message-ID: <2023082618-mocha-reactor-1dbe@gregkh>
References: <20230826142341.4107728-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826142341.4107728-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 10:23:41PM +0800, Huacai Chen wrote:
> This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
> of FP registers in the core dump file is up to date").
> 
> The values of FP/SIMD registers in the core dump file come from the
> thread.fpu. However, kernel saves the FP/SIMD registers only before
> scheduling out the process. If no process switch happens during the
> exception handling, kernel will not have a chance to save the latest
> values of FP/SIMD registers. So it may cause their values in the core
> dump file incorrect. To solve this problem, force fpr_get()/simd_get()
> to save the FP/SIMD registers into the thread.fpu if the target task
> equals the current task.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Rename get_fpu_regs() to save_fpu_regs().

What stable tree(s) is this for?

thanks,

greg k-h
