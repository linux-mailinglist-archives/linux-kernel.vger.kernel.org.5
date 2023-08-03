Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9780B76F04C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjHCRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjHCRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C48DA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35B361E2F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A5C433C8;
        Thu,  3 Aug 2023 17:06:09 +0000 (UTC)
Date:   Thu, 3 Aug 2023 18:06:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, ryan.roberts@arm.com,
        joey.gouly@arm.com, ardb@kernel.org, anshuman.khandual@arm.com,
        bhe@redhat.com, thunder.leizhen@huawei.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] arm64: fix build warning for
 ARM64_MEMSTART_SHIFT
Message-ID: <ZMvefmB6unOE+OPB@arm.com>
References: <20230725202404.3470111-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725202404.3470111-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:24:04PM +0000, Zhang Jianhua wrote:
> When building with W=1, the following warning occurs.
> 
> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>   129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>       |                                         ^~~~~~~~~
> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>   142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS == 3
> and CONFIG_VA_BITS == 39.

The correct description is that the generic PUD_SHIFT isn't defined for
asm files, we still have it defined for C files (there's an #ifndef
__ASSEMBLY__ guard).

> Now move the macro ARM64_MEMSTART_SHIFT and
> ARM64_MEMSTART_ALIGN to arch/arm64/mm/init.c where it is used to avoid
> this issue, and also there is no other place to call these two macro.
> 
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>

This fix works for me. I'll leave it to Will for 6.6 as apart from the
warning with W=1, there's no other issue (ARM64_MEMSTART_* are not used
in any asm files).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
