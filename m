Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E5F7CDAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjJRLpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:45:01 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A03ECFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:44:57 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dxl+g3xS9l3OAyAA--.62733S3;
        Wed, 18 Oct 2023 19:44:55 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxE+Q2xS9lai0pAA--.23449S3;
        Wed, 18 Oct 2023 19:44:55 +0800 (CST)
Subject: Re: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
To:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
References: <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
 <202310102113.bw7w3ZVv-lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b30b034d-46ee-618b-5f92-b0f7dde1219a@loongson.cn>
Date:   Wed, 18 Oct 2023 19:44:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202310102113.bw7w3ZVv-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxE+Q2xS9lai0pAA--.23449S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF45Aw1DGFy3Wr13tw4rtFc_yoW8XFW7pa
        9Y93yIyryrWF18ua4DWr4UXw4jyr40ya4F9FyagryUA3ZIqFy3AFs2yrWY9ryUG3s7trZ5
        KFWS9as8XF1UC3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 09:46 PM, kernel test robot wrote:
> Hi Tiezhu,
>
> kernel test robot noticed the following build errors:

...

>    In file included from scripts/sorttable.c:201:
>>> scripts/sorttable.h:96:10: fatal error: 'asm/orc_types.h' file not found
>    #include <asm/orc_types.h>
>             ^~~~~~~~~~~~~~~~~
>    1 error generated.

Thanks for your report, I can reproduce the error on x86:

   make ARCH=x86_64 olddefconfig
   make ARCH=x86_64 prepare

The build error is related with "ARCH=x86_64", there is no error
without "ARCH=x86_64" when build locally on x86.

As described in Documentation/kbuild/makefiles.rst:

   For example, you can pass in ARCH=i386, ARCH=x86_64, or ARCH=x86.
   For all of them, SRCARCH=x86 because arch/x86/ supports both i386 and
   x86_64.

we should use SRCARCH instead of ARCH to specify the directory,
like this:

diff --git a/scripts/Makefile b/scripts/Makefile
index 576cf64..e4cca53 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -31,9 +31,12 @@ HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) 
--libs libcrypto 2> /dev/null |

  ifdef CONFIG_UNWINDER_ORC
  ifeq ($(ARCH),x86_64)
-ARCH := x86
+SRCARCH := x86
  endif
-HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
+ifeq ($(ARCH),loongarch)
+SRCARCH := loongarch
+endif
+HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/$(SRCARCH)/include
  HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
  endif

I will update the related code of this patch in the next version.

Thanks,
Tiezhu

