Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2880575F8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGXNwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjGXNwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:52:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1059CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:49:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R8hN21W7bz4f3mWK
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:49:06 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgCHK59Ngb5kXQPVOg--.36407S3;
        Mon, 24 Jul 2023 21:49:02 +0800 (CST)
Subject: Re: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the
 bottom-up direction
To:     kernel test robot <lkp@intel.com>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Zhen Lei <thunder.leizhen@huawei.com>
References: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
 <202307220500.1I73fZ5Z-lkp@intel.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <ea4b5f96-617a-96ff-094e-7f21d4ddc176@huaweicloud.com>
Date:   Mon, 24 Jul 2023 21:49:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <202307220500.1I73fZ5Z-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCHK59Ngb5kXQPVOg--.36407S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDCr48ZrWkXr17XFyfCrg_yoWrCF48pa
        1Uua1xKw18XFWrCa97t3y3uw4rWasFqFyfWrW8Jr10gF9Fkr93JasagFWfXryDGr1vgay8
        Cw1jqFZ8X34UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/22 5:22, kernel test robot wrote:
> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on linus/master v6.5-rc2 next-20230721]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/thunder-leizhen-huaweicloud-com/arm64-kdump-Allocate-crash-low-memory-in-the-bottom-up-direction/20230721-162312
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20230721081726.882-2-thunder.leizhen%40huaweicloud.com
> patch subject: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the bottom-up direction
> config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307220500.1I73fZ5Z-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Oh, thanks. I got it. The CONFIG_KEXEC_CORE build control is move into reserve_crashkernel().
Function late_reserve_crashkernel() needs to do the same. I forgot to test turning off options
like CONFIG_KEXEC_CORE. I will do it tomorrow. Sorry.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b544ed0ab04193d..d444721011d0b2f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -122,6 +122,9 @@ static void __init late_reserve_crashkernel(void)
        unsigned long long low_base, low_size;
        unsigned long long crash_base, crash_size;

+       if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+               return;


> 
>    aarch64-linux-ld: arch/arm64/mm/init.o: in function `late_reserve_crashkernel':
>>> init.c:(.init.text+0x58): undefined reference to `crashk_res'
>    aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
>    init.c:(.init.text+0x58): dangerous relocation: unsupported relocation
>>> aarch64-linux-ld: init.c:(.init.text+0x5c): undefined reference to `crashk_res'
>>> aarch64-linux-ld: init.c:(.init.text+0x88): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_low_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
>    init.c:(.init.text+0x88): dangerous relocation: unsupported relocation
>    aarch64-linux-ld: init.c:(.init.text+0x90): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x9c): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0xd0): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x13c): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x150): undefined reference to `crashk_res'
>    aarch64-linux-ld: init.c:(.init.text+0x18c): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x1b0): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x204): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x234): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: init.c:(.init.text+0x248): undefined reference to `crashk_low_res'
>    aarch64-linux-ld: arch/arm64/mm/init.o:init.c:(.init.text+0x25c): more undefined references to `crashk_low_res' follow
> 

-- 
Regards,
  Zhen Lei

