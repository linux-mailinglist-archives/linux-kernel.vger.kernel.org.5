Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919D770082
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHDMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjHDMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B24C18
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E87B361FD4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B5DC433C7;
        Fri,  4 Aug 2023 12:48:21 +0000 (UTC)
Date:   Fri, 4 Aug 2023 13:48:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     will@kernel.org, ardb@kernel.org, mark.rutland@arm.com,
        ryan.roberts@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, thunder.leizhen@huawei.com, bhe@redhat.com,
        kristina.martsenko@arm.com, yajun.deng@linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] arm64: fix build warning for
 ARM64_MEMSTART_SHIFT
Message-ID: <ZMzzkyc0M9y29yWw@arm.com>
References: <20230804075615.3334756-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804075615.3334756-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:56:15PM +0800, Zhang Jianhua wrote:
> When building with W=1, the following warning occurs.
> 
> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>   129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>       |                                         ^~~~~~~~~
> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>   142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> The generic PUD_SHIFT was defined in include/asm-generic/pgtable-nopud.h,
> however the #ifndef __ASSEMBLY__ guard in this header file makes it unavailable
> for assembly files. While someone .S file include the <asm/kernel-pgtable.h>,
> the build warning would occur. Now move the macro ARM64_MEMSTART_SHIFT and
> ARM64_MEMSTART_ALIGN to arch/arm64/mm/init.c where it is used only, to avoid
> this issue.
> 
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
