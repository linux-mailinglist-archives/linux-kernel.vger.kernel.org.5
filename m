Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F185790AB5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 05:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjICDhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 23:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjICDht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 23:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47CD1B1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693712217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKtB7jxT4Cb7Dh6mDUeRnvr1QZkonAikTMNrLOlN9ng=;
        b=JgGmcaWxHaob2bES7MkR3BwoMy9JQcOQntjdXmYUQC7ukwIbMpkesX2BI6ByRrzc8zQllN
        beCMM3duZV8pGEhsvPExvbDUs2N1bNgU5YDiK/NZ0WvwIhxNjpRBe/RIjMePD/yEZP855r
        +ubJeHb42/JAxJE7XVVTsHp5bL/R7oc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-2R5AotwnOH2WWaOhBKVgZA-1; Sat, 02 Sep 2023 23:36:54 -0400
X-MC-Unique: 2R5AotwnOH2WWaOhBKVgZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2BE610264C1;
        Sun,  3 Sep 2023 03:36:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F260D4781C;
        Sun,  3 Sep 2023 03:36:52 +0000 (UTC)
Date:   Sun, 3 Sep 2023 11:36:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        Dave Young <dyoung@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] vmcore: allow alternate dump capturing methods to
 export vmcore without is_kdump_kernel()
Message-ID: <ZPP/UeP1zUbGPzrt@MiWiFi-R3L-srv>
References: <20230901190438.375678-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901190438.375678-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hari,

On 09/02/23 at 12:34am, Hari Bathini wrote:
> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> alternate dump capturing methods like fadump [1] also set it to export
> the vmcore. is_kdump_kernel() is used to restrict resources in crash
> dump capture kernel but such restrictions may not be desirable for
> fadump. Allow is_kdump_kernel() to be defined differently for such
> scenarios. With this, is_kdump_kernel() could be false while vmcore
> is usable. So, introduce is_crashdump_kernel() to return true when
> elfcorehdr_addr is set and use it for vmcore related checks.

I got what is done in these two patches, but didn't get why they need be
done. vmcore_unusable()/is_vmcore_usable() are only unitilized in ia64.
Why do you care if it's is_crashdump_kernel() or is_kdump_kernel()?
If you want to override the generic is_kdump_kernel() with powerpc's own
is_kdump_kernel(), your below change is enough to allow you to do that.
I can't see why is_crashdump_kernel() is needed. Could you explain that
specifically?

#ifndef is_kdump_kernel
static inline bool is_kdump_kernel(void)
{
        return elfcorehdr_addr != ELFCORE_ADDR_MAX;
}
#endif

Thanks
Baoquan

> [1] https://docs.kernel.org/powerpc/firmware-assisted-dump.html
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  include/linux/crash_dump.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0f3a656293b0..1052a0faf0dd 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -50,6 +50,7 @@ void vmcore_cleanup(void);
>  #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
>  #endif
>  
> +#ifndef is_kdump_kernel
>  /*
>   * is_kdump_kernel() checks whether this kernel is booting after a panic of
>   * previous kernel or not. This is determined by checking if previous kernel
> @@ -64,6 +65,19 @@ static inline bool is_kdump_kernel(void)
>  {
>  	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
>  }
> +#endif
> +
> +/*
> + * Return true if this is a dump capture kernel, where vmcore needs to be
> + * exported, irrespective of the dump capture mechanism in use.
> + *
> + * Same as is_kdump_kernel() unless arch specific code defines is_kdump_kernel()
> + * differently while supporting other dump capturing mechanisms.
> + */
> +static inline bool is_crashdump_kernel(void)
> +{
> +	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
> +}
>  
>  /* is_vmcore_usable() checks if the kernel is booting after a panic and
>   * the vmcore region is usable.
> @@ -75,7 +89,7 @@ static inline bool is_kdump_kernel(void)
>  
>  static inline int is_vmcore_usable(void)
>  {
> -	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> +	return is_crashdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
>  }
>  
>  /* vmcore_unusable() marks the vmcore as unusable,
> @@ -84,7 +98,7 @@ static inline int is_vmcore_usable(void)
>  
>  static inline void vmcore_unusable(void)
>  {
> -	if (is_kdump_kernel())
> +	if (is_crashdump_kernel())
>  		elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  }
>  
> -- 
> 2.41.0
> 

