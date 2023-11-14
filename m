Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436697EB1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjKNORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjKNORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B841FD0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699971369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKVLJOgm4tyS8bx4YwBGzuXwyrL/SHecWOOFNbyUgkI=;
        b=drbYRBZCQ+94ZOXv0App5XDx+43ijL6H9kEJfnvJxH70CuvrmBQGfz1wwdCtGiXfLRvuDe
        2+2lwqZf7fxBMk1QlHHWN6rodDm3RTvfbvEW2zmD2DuIu5CGfqNmQozrCBeEOzecebNx22
        orY8HOlWg8+jIfHWRLOmoiTqmwIH1xM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Bt0mks0TOoiq4CGlL5-bsw-1; Tue, 14 Nov 2023 09:16:06 -0500
X-MC-Unique: Bt0mks0TOoiq4CGlL5-bsw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0CE8821BC5;
        Tue, 14 Nov 2023 14:16:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F027492BE0;
        Tue, 14 Nov 2023 14:16:04 +0000 (UTC)
Date:   Tue, 14 Nov 2023 22:16:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zac Tang <zactang@google.com>, Cloud Hsu <cloudhsu@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
Message-ID: <ZVOBIfIpuTIO+E8M@MiWiFi-R3L-srv>
References: <20231023023121.1464544-1-jsperbeck@google.com>
 <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
 <CAFNjLiVAdcPEc+UK_5Z+uutqAVki5geWgpWewzu9iyJsYyiRjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFNjLiVAdcPEc+UK_5Z+uutqAVki5geWgpWewzu9iyJsYyiRjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 10/23/23 at 02:54pm, John Sperbeck wrote:
> On Sun, Oct 22, 2023 at 7:42 PM H. Peter Anvin <hpa@zytor.com> wrote:
......
> > >---
> > > arch/x86/kernel/kexec-bzimage64.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > >index a61c12c01270..d6bf6c13dab1 100644
> > >--- a/arch/x86/kernel/kexec-bzimage64.c
> > >+++ b/arch/x86/kernel/kexec-bzimage64.c
> > >@@ -36,7 +36,7 @@
> > >  */
> > > #define MIN_PURGATORY_ADDR    0x3000
> > > #define MIN_BOOTPARAM_ADDR    0x3000
> > >-#define MIN_KERNEL_LOAD_ADDR  0x100000
> > >+#define MIN_KERNEL_LOAD_ADDR  0x1000000
> > > #define MIN_INITRD_LOAD_ADDR  0x1000000
> > >
> > > /*
> >
> > This doesn't make any sense to me. There is already a high water mark for his much memory the kernel needs until an initrd or setup_data item can appear. This is just a hack, please fix it properly.
> 
> The startup_64() code in head_64.S changes behavior based on whether
> it's running below or above LOAD_PHYSICAL_ADDR:
> 
> #ifdef CONFIG_RELOCATABLE
>         leaq    startup_32(%rip) /* - $startup_32 */, %rbp
>         movl    BP_kernel_alignment(%rsi), %eax
>         decl    %eax
>         addq    %rax, %rbp
>         notq    %rax
>         andq    %rax, %rbp
>         cmpq    $LOAD_PHYSICAL_ADDR, %rbp
>         jae     1f
> #endif
>         movq    $LOAD_PHYSICAL_ADDR, %rbp
> 1:
> 
> In my example, we were running from address 0x00400000.  The %rbp
> register will start with 0x00400000, but will be changed to 0x01000000
> after the check against LOAD_PHYSICAL_ADDR fails.
> 
> The 0x01000000 value in %rbp is passed to extract_kernel as the
> 'output' argument.  Unless choose_random_location() decides
> differently, this will be where the kernel is decompressed to.  The
> size of the kernel is large enough in my example that the
> decompression overruns the initrd.
> 
> If the startup_64() code didn't have the LOAD_PHYSICAL_ADDR check and
> used %rpb as is, then there would be no issue.  The decompression
> would have been to 0x00400000 and would have completed before reaching
> the initrd memory.
> 
> That is, the kexec code is being careful to ensure that the kernel and
> initrd memory doesn't overlap, but isn't paying attention to what
> happens if the kernel memory is below LOAD_PHYSICAL_ADDR (the kernel
> address is effectively changed to a different location).  My proposed
> change makes it aware, and avoids such addresses.

Wondering why kexec-ed kernel is located under 0x1000000. The loading
code will search physical memory regions bottom up for an available one.
Usually, kexec kernel will be loaded above 16M.

I have posted a patchset to load kernel at top of system RAM for kexec_file
load just as kexec_load has been doing. Do you think it's helpful?

[PATCH 0/2] kexec_file: Load kernel at top of system RAM if required
https://lore.kernel.org/all/20231114091658.228030-1-bhe@redhat.com/T/#u

Thanks
Baoquan

