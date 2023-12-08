Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B8809D64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573324AbjLHHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573283AbjLHHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B71734
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702021408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mD12z3Ph+93M5Ou5tdqyf4RyVew89UEB1udxQaJBbFk=;
        b=ejQe09r0efklIB4GuTJZOJ1DOMCY9NOY4iR++z85UeH5sPq04jmagNfFjsf0rE4H1Luch6
        XFzq0a3n1gy1PWF9peVg4Zx/MBKoKpzyUc0YhXXAXiVDRwTjIPQPJWI7/0JhAeJ/YzOQTR
        Vi/E6u5y61j/5i88Ha4wwHeeOlBh6zc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-InC0YeG0PumZKyP_DYV22Q-1; Fri,
 08 Dec 2023 02:42:43 -0500
X-MC-Unique: InC0YeG0PumZKyP_DYV22Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37ABF3C0274D;
        Fri,  8 Dec 2023 07:42:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89CD58CD0;
        Fri,  8 Dec 2023 07:42:42 +0000 (UTC)
Date:   Fri, 8 Dec 2023 15:42:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-next@vger.kernel.org, loongarch@lists.linux.dev,
        kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com
Subject: Re: [PATCH 0/5] kexec: fix the incorrect ifdeffery and dependency of
 CONFIG_KEXEC
Message-ID: <ZXLI748b85be459B@fedora>
References: <20231208073036.7884-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208073036.7884-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot adding kexec to CC, add it now.

On 12/08/23 at 03:30pm, Baoquan He wrote:
> The select of KEXEC for CRASH_DUMP in kernel/Kconfig.kexec will be
> dropped, then compiling errors will be triggered if below config
> items are set:
> 
> ===
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ===
> 
> E.g on mips, below link error are seen:
> --------------------------------------------------------------------
> mipsel-linux-ld: kernel/kexec_core.o: in function `kimage_free':
> kernel/kexec_core.c:(.text+0x2200): undefined reference to `machine_kexec_cleanup'
> mipsel-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
> kernel/kexec_core.c:(.text+0x2480): undefined reference to `machine_crash_shutdown'
> mipsel-linux-ld: kernel/kexec_core.c:(.text+0x2488): undefined reference to `machine_kexec'
> mipsel-linux-ld: kernel/kexec_core.o: in function `kernel_kexec':
> kernel/kexec_core.c:(.text+0x29b8): undefined reference to `machine_shutdown'
> mipsel-linux-ld: kernel/kexec_core.c:(.text+0x29c0): undefined reference to `machine_kexec'
> --------------------------------------------------------------------
> 
> Here, change the incorrect dependency of building kexec_core related object
> files, and the ifdeffery on architectures from CONFIG_KEXEC to
> CONFIG_KEXEC_CORE.
> 
> Testing:
> ========
> Passed on mips and loognarch with the LKP reproducer.
> 
> Baoquan He (5):
>   loongarch, kexec: change dependency of object files
>   m68k, kexec: fix the incorrect ifdeffery and build dependency of
>     CONFIG_KEXEC
>   mips, kexec: fix the incorrect ifdeffery and dependency of
>     CONFIG_KEXEC
>   sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
>   x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC
> 
>  arch/loongarch/kernel/Makefile  |  2 +-
>  arch/m68k/include/asm/kexec.h   |  4 ++--
>  arch/m68k/kernel/Makefile       |  2 +-
>  arch/mips/cavium-octeon/smp.c   |  4 ++--
>  arch/mips/include/asm/kexec.h   |  2 +-
>  arch/mips/include/asm/smp-ops.h |  2 +-
>  arch/mips/include/asm/smp.h     |  2 +-
>  arch/mips/kernel/Makefile       |  2 +-
>  arch/mips/kernel/smp-bmips.c    |  4 ++--
>  arch/mips/kernel/smp-cps.c      | 10 +++++-----
>  arch/mips/loongson64/reset.c    |  4 ++--
>  arch/mips/loongson64/smp.c      |  2 +-
>  arch/sh/include/asm/kexec.h     |  4 ++--
>  arch/sh/kernel/Makefile         |  2 +-
>  arch/sh/kernel/reboot.c         |  4 ++--
>  arch/sh/kernel/setup.c          |  2 +-
>  arch/x86/boot/compressed/acpi.c |  2 +-
>  17 files changed, 27 insertions(+), 27 deletions(-)
> 
> -- 
> 2.41.0
> 

