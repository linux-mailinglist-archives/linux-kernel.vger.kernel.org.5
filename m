Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC07676B60B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjHANkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjHANkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17909139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872D96157C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CD9C433C8;
        Tue,  1 Aug 2023 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690897236;
        bh=1F/npABRXysSuJPmy5xHodfUuUjJEuXIHmC2YuarPHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNLgLd+DD4ffPBVltZF4rkHUPw/buHwy4IJSef5CuVwFThxOyoVHk1/KJdVGqyEZe
         s2oL+PSa2r5OZdF1EjGysdOupFDmvEPkPbbRi8hLKBGdRu1QQDhxiSgeF7W/Ew8itZ
         Td3fQQz/Ge+fm6Iad2/gA/inxGHoiMOJbP/lVgTHcHTH3CSNg05knLSlFyJPYWGx1q
         3xntjHecjlrJxkWbUPhiNC+J6loH1CbKlolVg/BtpXLd2BWIrPUkAs3By+rbwJqTbQ
         cAsMXiRsE+xmBc5ANcY09gczsQl0S1Fnw8EtzQX6dABfA0prU0iOGSSlw67KTV2AmQ
         GvSWduXMYsdrg==
Date:   Tue, 1 Aug 2023 06:40:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Error out if clang version is less than 17.0.0
Message-ID: <20230801134034.GA3831650@dev-arch.thelio-3990X>
References: <1690871446-23713-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690871446-23713-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

On Tue, Aug 01, 2023 at 02:30:46PM +0800, Tiezhu Yang wrote:
> On my test machine, the clang version is 16.0.4, when build kernel
> with clang:
> 
>   make CC=clang loongson3_defconfig
>   make CC=clang
> 
> there exist many errors such as:
> 
>   clang-16: error: argument unused during compilation: '-mabi=lp64s'
>   error: unknown register name 'a0' in asm
>   error: unknown register name 't0' in asm
> 
> the above issues have been fixed in the upstream llvm project recently,
> it works well when update clang version to 17.0.0:
> 
>   make CC=clang loongson3_defconfig
>   make CC=clang menuconfig (set CONFIG_MODULES=n and CONFIG_RELOCATABLE=n)
>   make CC=clang
> 
> thus 17.0.0 is the minimal clang version to build kernel on LoongArch,
> it is better to error out if clang version is less than 17.0.0, then
> we can do the right thing to update clang version and avoid wasting
> time to analysis kernel errors.
> 
> By the way, the clang 17.0.0 still have some issues to build kernel on
> LoongArch, you need to unset CONFIG_MODULES and CONFIG_RELOCATABLE to
> avoid build errors. Additionally, if you want a workable kernel, some
> modules should be set as y instead of m if CONFIG_MODULES=n.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1787
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index b1e5db5..f07f62a 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -10,6 +10,12 @@ KBUILD_DEFCONFIG := loongson3_defconfig
>  image-name-y			:= vmlinux
>  image-name-$(CONFIG_EFI_ZBOOT)	:= vmlinuz
>  
> +ifdef CONFIG_CC_IS_CLANG
> +  ifneq ($(call clang-min-version, 170000),y)
> +    $(error Sorry, you need a newer clang version >= 17.0.0)
> +  endif
> +endif
> +

Thanks for the patch! I agree that we should restrict LoongArch to LLVM
17 and newer. However, there is already existing infrastructure for this
type of check in Kconfig, so we don't need to add anything to
arch/loongarch. Just modify scripts/min-tool-version.sh like so then
there will be a message during configuration time that the compiler is
too old.

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 2ade63149466..572c0526ad61 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -26,6 +26,8 @@ gcc)
 llvm)
 	if [ "$SRCARCH" = s390 ]; then
 		echo 15.0.0
+	elif [ "$SRCARCH" = loongarch ]; then
+		echo 17.0.0
 	else
 		echo 11.0.0
 	fi

***
*** C compiler is too old.
***   Your Clang version:    16.0.6
***   Minimum Clang version: 17.0.0
***
scripts/Kconfig.include:44: Sorry, this C compiler is not supported.

>  ifndef CONFIG_EFI_STUB
>  KBUILD_IMAGE	:= $(boot)/vmlinux.elf
>  else
> -- 
> 2.1.0
> 
> 

Cheers,
Nathan
