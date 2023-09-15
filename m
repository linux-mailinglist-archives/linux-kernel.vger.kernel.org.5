Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214CE7A1F94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjIONO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjIONOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0601713
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694783642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sb5wr0wfo93KZmmG9iONfAq+eRQpW+VSRFFBiRCmnG8=;
        b=ME90bPtPrqAK51sH/D1eRBecNBH8eVB0ed92BhbTjJtvNyzo2qzSR23+3TDqKtvhD7T038
        beKJ5wMpyOE94Saae2m2jTiqoKWOTrvw2pR4YPzu0eu8z4PPXgkpzes5D5HR5VwyZuUn4l
        dECaujLAGd/slmOscEP5wodgtWYwdJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-qPOpJlElMJyjGulFdS2cwQ-1; Fri, 15 Sep 2023 09:13:52 -0400
X-MC-Unique: qPOpJlElMJyjGulFdS2cwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1227858285;
        Fri, 15 Sep 2023 13:13:51 +0000 (UTC)
Received: from localhost (unknown [10.72.113.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 806C32026D68;
        Fri, 15 Sep 2023 13:13:50 +0000 (UTC)
Date:   Fri, 15 Sep 2023 21:13:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com, catalin.marinas@arm.com,
        chenjiahao16@huawei.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 6/9] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <ZQRYixr2AtJtRFrh@MiWiFi-R3L-srv>
References: <20230914033142.676708-7-bhe@redhat.com>
 <202309141534.moH4dTcz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309141534.moH4dTcz-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/23 at 04:12pm, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on powerpc/fixes linus/master v6.6-rc1 next-20230914]
> [cannot apply to arm64/for-next/core tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230914-113546
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> patch link:    https://lore.kernel.org/r/20230914033142.676708-7-bhe%40redhat.com
> patch subject: [PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309141534.moH4dTcz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/setup.c:476:15: warning: no previous prototype for function 'crash_low_size_default' [-Wmissing-prototypes]
>    unsigned long crash_low_size_default(void)
>                  ^
>    arch/x86/kernel/setup.c:476:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    unsigned long crash_low_size_default(void)
>    ^
>    static 
>    1 warning generated.

Thanks for reporting this. I can reproduced this warning on x86_64
machine by retrieving the LKP's config and build it with below command:

	make ARCH=i386 -j128 W=1 arch/x86/kernel/

I can fix it by moving crash_low_size_default() into arch/x86/include/asm/crash_core.h 
and make it as static inline as below draft change.

Hi Andrew,

I should post v4 of the whole series or just v4 of this patch?

[PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code


diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
index 5fc5e4f94521..76af98f4e801 100644
--- a/arch/x86/include/asm/crash_core.h
+++ b/arch/x86/include/asm/crash_core.h
@@ -18,6 +18,7 @@
  * no good way to detect the paging mode of the target kernel which will be
  * loaded for dumping.
  */
+extern unsigned long swiotlb_size_or_default(void);
 
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX     SZ_512M
@@ -29,6 +30,13 @@
 
 # define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
 
-extern unsigned long crash_low_size_default(void);
+static inline unsigned long crash_low_size_default(void)
+{
+#ifdef CONFIG_X86_64
+	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+#else
+	return 0;
+#endif
+}
 
 #endif /* _X86_CRASH_CORE_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 0acc86587fc0..d7baa567c68e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -470,18 +470,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	}
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-unsigned long crash_low_size_default(void)
-{
-#ifdef CONFIG_X86_64
-	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-#else
-	return 0;
-#endif
-}
-
 static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size, low_size = 0;

