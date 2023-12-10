Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948780BBF0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjLJPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494F9D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702221884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3KL7UhBIXaTA/icsLmumqXQXBryDvbpvjDvF0vr8/M=;
        b=JLi80k4LnhqWN9W8c9cnxD2wXPTQS8CMG+HDQO1LZ5a2hxgPAy2wDzblntstEw6v/Pzkv5
        EAz/qYcNGrdAHS50oAo3+6VZIxaUSD9PVNAIBD2rLgJOr6k8c6ZfL9iA7EbzdGQp287rX6
        ENmY7Ny/Udwl4A5NAqzlp8dsoVsFEjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-rRNGTIKxNeSGnmN1mzSqXQ-1; Sun, 10 Dec 2023 10:24:36 -0500
X-MC-Unique: rRNGTIKxNeSGnmN1mzSqXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 022AF185A780;
        Sun, 10 Dec 2023 15:24:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 022C1112131D;
        Sun, 10 Dec 2023 15:24:33 +0000 (UTC)
Date:   Sun, 10 Dec 2023 23:24:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        schnelle@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com,
        dave.hansen@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH V5 12/20] asm-generic/io.h: iounmap/ioport_unmap
 cleanup.h support
Message-ID: <ZXXYLuRpQ7bThB1X@MiWiFi-R3L-srv>
References: <20231123040355.82139-1-david.e.box@linux.intel.com>
 <20231123040355.82139-13-david.e.box@linux.intel.com>
 <f83e4a40-314-d279-75e6-17ad83501982@linux.intel.com>
 <adb8c80395d2c23488496b9ad323bfc265ad3514.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adb8c80395d2c23488496b9ad323bfc265ad3514.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 at 05:55pm, David E. Box wrote:
> +Baoquan for ioremap question.
> 
> On Thu, 2023-11-23 at 16:30 +0200, Ilpo Järvinen wrote:
> > On Wed, 22 Nov 2023, David E. Box wrote:
> > 
> > > Add auto-release cleanups for iounmap() and ioport_unmap().
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > V2 - Move from linux/io.h to asm-generic/io.h. Adds iounmap cleanup if
> > >      iounmap() is defined. Adds ioport_unmap cleanup if CONFIG_IOPORT_MAP
> > >      is defined.
> > > 
> > >  include/asm-generic/io.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > index bac63e874c7b..9ef0332490b1 100644
> > > --- a/include/asm-generic/io.h
> > > +++ b/include/asm-generic/io.h
> > > @@ -8,6 +8,7 @@
> > >  #define __ASM_GENERIC_IO_H
> > >  
> > >  #include <asm/page.h> /* I/O is all done through memory accesses */
> > > +#include <linux/cleanup.h>
> > >  #include <linux/string.h> /* for memset() and memcpy() */
> > >  #include <linux/types.h>
> > >  #include <linux/instruction_pointer.h>
> > > @@ -1065,6 +1066,10 @@ static inline void __iomem *ioremap(phys_addr_t addr,
> > > size_t size)
> > >  #endif
> > >  #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
> > >  
> > > +#ifdef iounmap
> > > +DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
> > > +#endif
> 
> Baoquan, LKP is reporting an undeclared function 'iounmap' error with the above
> change from this patch when building for s390 with PCI disabled. The ioremap
> defines in arch/s390/include/asm/io.h are not wrapped under the #ifdef
> CONFIG_PCI block. Shouldn't they be since the s390 Kconfig only adds
> GENERIC_IOREMAP if PCI?
> 
> https://lore.kernel.org/oe-kbuild-all/202311241214.jcL84du7-lkp@intel.com

I tried to reproduce the error, while I got failure as below. I will find a
s390x machine to try again.

---------------------------------------------------------
[root@ linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-16 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
Compiler will be installed in /root/0day
PATH=/root/0day/llvm-16.0.6-x86_64/bin:/root/.local/bin:/root/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
make --keep-going HOSTCC=/root/0day/llvm-16.0.6-x86_64/bin/clang CC=/root/0day/llvm-16.0.6-x86_64/bin/clang OBJCOPY=/usr/s390x-linux-gnu/bin/objcopy AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJDUMP=llvm-objdump OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar CROSS_COMPILE=s390x-linux-gnu- --jobs=128 KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wenum-conversion W=1 O=build_dir ARCH=s390 olddefconfig
make[1]: Entering directory '/root/linux/build_dir'
  GEN     Makefile
scripts/Kconfig.include:40: linker 's390x-linux-gnu-ld' not found
make[3]: *** [../scripts/kconfig/Makefile:77: olddefconfig] Error 1
make[2]: *** [/root/linux/Makefile:685: olddefconfig] Error 2
make[1]: *** [/root/linux/Makefile:234: __sub-make] Error 2
make[1]: Target 'olddefconfig' not remade because of errors.
make[1]: Leaving directory '/root/linux/build_dir'
make: *** [Makefile:234: __sub-make] Error 2
make: Target 'olddefconfig' not remade because of errors.
------------------------------------------------------------------

And when I execute the 3rd step of reproducer to apply the required
patch series, I never succeed. Don't know why.

----------------------------------------------------------------
[root@intel-knightslanding-lb-02 linux]# b4 shazam https://lore.kernel.org/r/20231123040355.82139-13-david.e.box@linux.intel.com
Grabbing thread from lore.kernel.org/all/20231123040355.82139-13-david.e.box@linux.intel.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
  Added from v6: 21 patches
Analyzing 63 messages in the thread
Will use the latest revision: v6
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v6 1/20] platform/x86/intel/vsec: Fix xa_alloc memory leak
----------------------------------------------------------------




> 
> 
> Note that the report includes pointer arithmetic warnings that are not related
> to this patch. Those warnings occur in mainline as well.
> 
> David
> 
> > > +
> > >  #ifndef ioremap_wc
> > >  #define ioremap_wc ioremap
> > >  #endif
> > > @@ -1127,6 +1132,7 @@ static inline void ioport_unmap(void __iomem *p)
> > >  extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
> > >  extern void ioport_unmap(void __iomem *p);
> > >  #endif /* CONFIG_GENERIC_IOMAP */
> > > +DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
> > >  #endif /* CONFIG_HAS_IOPORT_MAP */
> > >  
> > >  #ifndef CONFIG_GENERIC_IOMAP
> > 
> > Has this now built successfully with LKP? (I don't think we get success 
> > notifications from LKP for patch submissions, only failures).
> > 
> > There were some odd errors last time but I think all they were unrelated 
> > to this change (besides the checkpatch false positive, I mean).
> > 
> 

