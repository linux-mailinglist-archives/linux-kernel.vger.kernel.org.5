Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6742A772BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHGQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjHGQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4C19AF;
        Mon,  7 Aug 2023 09:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A0D61FB5;
        Mon,  7 Aug 2023 16:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD06C433C8;
        Mon,  7 Aug 2023 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691427328;
        bh=WU3AeiqSRDkKCekepGZR4kr95/r5A21Ia8054t6T2ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3NQqGi+B4y/KPTi4YTTMJpZixaDzDrB70X+f+DCDBOWJl6H2ZNBdO0n1AeyWxgJi
         4AjZffAdBLZH+6iv1WA/yETU8ipTXzrSFmHtx5EvwUx8ONAdHXcTIjd+RILAD+WqVd
         kvNWewKH0h3l0O03+5UeMobT9dBL3JSHQscCN4xds06zOpnQJSLS6Y0tIH7HR9md5P
         N7mjgGppNygMOFSCZCduREpb5r7JY78NSidBD6lJN3n3OktnlcwWhXQ/y6WwBKMZUO
         QIsvJ3sFcttsVrQc2mj2XvoR2Hoz+fOeTJuxO2x+iyP5itbuN5ksXEjy2FD8b2cxe8
         eYrCsM4skQHJA==
Date:   Mon, 7 Aug 2023 09:55:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] Makefile.extrawarn: enable
 -Wmissing-variable-declarations for W=1
Message-ID: <20230807165526.GA2744968@dev-arch.thelio-3990X>
References: <20230807-missing_proto-v1-1-7f566b7ba5ca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-missing_proto-v1-1-7f566b7ba5ca@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:50:32AM -0700, Nick Desaulniers wrote:
> I noticed Tom was sending patches where smatch was recommending
> annotating functions as static when no previous declaration existed.
> Surely the compiler could make such recommendations as well, I thought.
> 
> Looks like -Wmissing-variable-declarations can make such
> recommendations.
> 
> GCC just added support for this warning (gcc 14.1.0 will ship with
> support), and all versions of clang relevant to building the kernel
> support this flag.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Any idea how many instances of this there are? At least x86_64 defconfig
fails immediately with:

  In file included from scripts/mod/devicetable-offsets.c:3:
  In file included from include/linux/mod_devicetable.h:14:
  In file included from include/linux/uuid.h:11:
  In file included from include/linux/string.h:20:
  In file included from arch/x86/include/asm/string.h:5:
  In file included from arch/x86/include/asm/string_64.h:6:
  In file included from include/linux/jump_label.h:112:
  In file included from arch/x86/include/asm/jump_label.h:7:
  arch/x86/include/asm/asm.h:208:24: error: no previous extern declaration for non-static variable 'current_stack_pointer' [-Werror,-Wmissing-variable-declarations]
    208 | register unsigned long current_stack_pointer asm(_ASM_SP);
        |                        ^
  arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
    208 | register unsigned long current_stack_pointer asm(_ASM_SP);
        |          ^
  1 error generated.

> ---
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 40cd13eca82e..617739eb84e2 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -32,6 +32,7 @@ KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
>  KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
>  KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
>  KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
> +KBUILD_CFLAGS += $(call cc-option, -Wmissing-varibale-declarations)
                                                ^ variable
>  # The following turn off the warnings enabled by -Wextra
>  KBUILD_CFLAGS += -Wno-missing-field-initializers
>  KBUILD_CFLAGS += -Wno-sign-compare
> 
> ---
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> change-id: 20230807-missing_proto-0cb90ec6454c
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 
