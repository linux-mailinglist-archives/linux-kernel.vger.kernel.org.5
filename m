Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D07D4693
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJXD6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjJXD6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543461702
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698119750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNDuXbYjtRLJzfaUrnn30bwHvtiVZ7rNQxf0BdBPcfY=;
        b=Fhkd59dEq1QTOxhFEwSG+Eh06dgUm4moPu5DCZ9/1S6JC/N/9ngtm4z8yu7VtJ60Lo0SKZ
        CZXrEJbhxb/0/MuBVax1B4t6xverGpRHvZZXnJT0/pDh3+YZAyHfV069r2YzfJc8JxIUOD
        ksGJxEs4KXHxcbj+8XzrR1f6OlVM26Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-nUyCnobAM5ix9yYjgAujlg-1; Mon, 23 Oct 2023 23:55:32 -0400
X-MC-Unique: nUyCnobAM5ix9yYjgAujlg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8E0680F8F5;
        Tue, 24 Oct 2023 03:55:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F066D492BD9;
        Tue, 24 Oct 2023 03:55:28 +0000 (UTC)
Date:   Tue, 24 Oct 2023 11:55:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH 2/2] kexec: select CRYPTO from KEXEC_FILE instead of
 depending on it
Message-ID: <ZTdALtO2rN4FaneC@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
 <20231023110308.1202042-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023110308.1202042-2-arnd@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 at 01:01pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All other users of crypto code use 'select' instead of 'depends on',
> so do the same thing with KEXEC_FILE for consistency.
> 
> In practice this makes very little difference as kernels with kexec
> support are very likely to also include some other feature that already
> selects both crypto and crypto_sha256, but being consistent here helps
> for usability as well as to avoid potential circular dependencies.
> 
> This reverts the dependency back to what it was originally before commit
> 74ca317c26a3f ("kexec: create a new config option CONFIG_KEXEC_FILE for
> new syscall"), which changed changed it with the comment "This should
                       ~~~~~~~~~~~~~~ typo
> be safer as "select" is not recursive", but that appears to have been
> done in error, as "select" is indeed recursive, and there are no other
> dependencies that prevent CRYPTO_SHA256 from being selected here.
> 
> Fixes: 74ca317c26a3f ("kexec: create a new config option CONFIG_KEXEC_FILE for new syscall")
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/Kconfig.kexec | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index bfc636d64ff2b..51f719af10e79 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -36,7 +36,8 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "Enable kexec file based system call"
>  	depends on ARCH_SUPPORTS_KEXEC_FILE
> -	depends on CRYPTO_SHA256=y || !ARCH_SUPPORTS_KEXEC_PURGATORY
> +	select CRYPTO
> +	select CRYPTO_SHA256
>  	select KEXEC_CORE
>  	help
>  	  This is new version of kexec system call. This system call is
> -- 
> 2.39.2
> 

