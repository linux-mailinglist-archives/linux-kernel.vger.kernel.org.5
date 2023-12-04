Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C0802E24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjLDIek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4051C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701678885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9tcnzIexPrb0OUsvkaLGTMaO9LwJfJejgNnOdDmMeTA=;
        b=OG47XKa1BklctfdNYzS51Nxdrnl3EcPNK6ux3NuORWABTHGxsa66FBSNgBip5E3YaohOcO
        YEwM/ZFPZx7KlrjmwwoyIKjcn4CfkB2A2/Z5hlOpHMEr0PFyiH4E1BPwjTKfC9+9s32n03
        pn0Yh7ehm6BfrDM7iA5fAEE3t4F9DjY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-TP6E8WNAO9SqzRiAn5erpQ-1; Mon,
 04 Dec 2023 03:34:40 -0500
X-MC-Unique: TP6E8WNAO9SqzRiAn5erpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B4DD38476C0;
        Mon,  4 Dec 2023 08:34:40 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B38C1596F;
        Mon,  4 Dec 2023 08:34:38 +0000 (UTC)
Date:   Mon, 4 Dec 2023 16:34:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org, mick@ics.forth.gr,
        changbin.du@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] riscv, kexec: fix the ifdeffery for
 AFLAGS_kexec_relocate.o
Message-ID: <ZW2PHF3HVUUH8+NV@MiWiFi-R3L-srv>
References: <20231201062538.27240-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201062538.27240-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Andrew.

On 12/01/23 at 02:25pm, Baoquan He wrote:
> This was introduced in commit fba8a8674f68 ("RISC-V: Add kexec
> support").
> 
> It should work on CONFIG_KEXEC_CORE, but not CONFIG_KEXEC only, since
> we could set CONFIG_KEXEC_FILE=y and CONFIG_KEXEC=N, or only set
> CONFIG_CRASH_DUMP=y and disable both CONFIG_KEXEC and CONFIG_KEXEC_FILE.
> In these cases, the AFLAGS won't take effect with the current ifdeffery
> for AFLAGS_kexec_relocate.o.
> 
> So fix it now.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/riscv/kernel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi RISC-V people,

I didn't test this, while believe this need be fixed. Please help check
if this is necessary.


Thanks
Baoquan
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..82940b6a79a2 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -11,7 +11,7 @@ endif
>  CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
>  CFLAGS_compat_syscall_table.o += $(call cc-option,-Wno-override-init,)
>  
> -ifdef CONFIG_KEXEC
> +ifdef CONFIG_KEXEC_CORE
>  AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
>  endif
>  
> -- 
> 2.41.0
> 

