Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF076C862
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjHBIde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjHBIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83202171B;
        Wed,  2 Aug 2023 01:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A11C6184D;
        Wed,  2 Aug 2023 08:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF834C433C7;
        Wed,  2 Aug 2023 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690965210;
        bh=6L87WFqpRWoyspDs3L6KZduy9PxJ66o4a4lAQyjQVr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYxMnfhfp/hn8Iri+SxArk/uuPg4mGzMWdOpzu5oZn5Pl5CNy8ezbaDd8McBJ203o
         7uOOUooPxq83PZsOSkVUDxZtrWzX1UDk3HR1+FGCP3YJJKYI8Av65YNjiKhedbM25m
         jgI2e0TgWX7c+FRdsmJ8yJ6LLy+35xiTC7jd5P4k=
Date:   Wed, 2 Aug 2023 10:33:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mason Huo <mason.huo@starfivetech.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace
 zihintpause
Message-ID: <2023080253-headache-moneybags-a833@gregkh>
References: <20230802064215.31111-1-minda.chen@starfivetech.com>
 <20230802-sharpness-spoon-f9b8804fb66f@wendy>
 <d64874cb-8628-a6d2-d2f4-8af4d0ebf8b2@starfivetech.com>
 <20230802-seismic-gallstone-fca0f4b17076@wendy>
 <c42bd997-8795-8bf7-eee1-3ac8b153371a@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c42bd997-8795-8bf7-eee1-3ac8b153371a@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 04:17:51PM +0800, Minda Chen wrote:
> 
> 
> On 2023/8/2 15:48, Conor Dooley wrote:
> > On Wed, Aug 02, 2023 at 03:32:15PM +0800, Minda Chen wrote:
> >> 
> >> 
> >> On 2023/8/2 14:54, Conor Dooley wrote:
> >> > Hey Minda,
> >> > 
> >> > On Wed, Aug 02, 2023 at 02:42:15PM +0800, Minda Chen wrote:
> >> >> Actually it is a part of Conor's
> >> >> commit aae538cd03bc ("riscv: fix detection of toolchain
> >> >> Zihintpause support").
> >> >> It is looks like a merge issue.
> >> > 
> >> > Yup, spot on.
> >> > 
> >> >> Samuel's
> >> >> commit 0b1d60d6dd9e ("riscv: Fix build with
> >> >> CONFIG_CC_OPTIMIZE_FOR_SIZE=y") do not base on Conor's commit and
> >> >> revert to __riscv_zihintpause. So this patch can fix it.
> >> >> 
> >> >> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> >> > 
> >> > Did you actually manage to trigger this, or was this by inspection?
> >> > clang-15 + binutils 2.35 was, IIRC, how we spotted this because that's
> >> > what the clang-built-linux CI uses to test the LTS kernels from before
> >> > LLVM's IAS was supported for RISC-V. Seemingly all that needs to be
> >> > satisfied there is that zihintpause doesn't appear in -march so this has
> >> > gone unnoticed.
> >> > 
> >> > Fixes: 3c349eacc559 ("Merge patch "riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y"")
> >> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >> > 
> >> > Thanks,
> >> > Conor.
> >> > 
> >> Thanks, Conor. I found this just by inspection. I found a issue that vdso.so call cpu_relax
> >> cause application core dump in kernel 6.1.31. I need Samuel'patch to fix this. And I search the log
> >> of processor.h found this issue.
> > 
> > That doesn't look like it is fixed in later stable kernels (we are at
> > 6.1.42-rcN right now I think). It sounds we should ask Greg to backport
> > 0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y")
> > to 6.1. Does that make sense to you?
> Yes. 6.1 is lts kernel. Starfive will use this kernel for a long time. Thanks.

What is preventing you from moving to a newer kernel version?  All of
your kernel changes are already properly merged into Linus's tree,
right?

thanks,

greg k-h
