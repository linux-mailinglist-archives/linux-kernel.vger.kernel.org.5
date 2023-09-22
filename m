Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9597AA9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjIVHSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIVHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8119C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695367026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rdzgewSS63Y8Rwj0aud5egqw4iJJTbEb4cB0JfdUZMA=;
        b=h8XInOBNzxXt8HcwHdZdFCXDZvJgdJ1wssugtAB/Syl01FBP6Ll7X1guCUYf7EZr8UbXBX
        7KgHkDEKl14hVGn7hq8Wffu9nwpxe8PZkeb9R3HROO0iXu8faDe5T4pFxpC7OgzzLxP9CC
        T0S9ab148dCxdOj7vXWgmB4k2A//t8Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-9ZYp2v8OMry7WHImz2-Nmw-1; Fri, 22 Sep 2023 03:17:01 -0400
X-MC-Unique: 9ZYp2v8OMry7WHImz2-Nmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D237E101A53B;
        Fri, 22 Sep 2023 07:17:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA5E40C2070;
        Fri, 22 Sep 2023 07:16:59 +0000 (UTC)
Date:   Fri, 22 Sep 2023 15:16:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     thunder.leizhen@huawei.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, alexghiti@rivosinc.com,
        ajones@ventanamicro.com, jszhang@kernel.org,
        sunilvl@ventanamicro.com, robh@kernel.org, bjorn@rivosinc.com,
        zephray@outlook.com, akpm@linux-foundation.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] riscv: kdump: fix crashkernel reserving problem on
 RISC-V
Message-ID: <ZQ0/aK6cg8oNloA4@MiWiFi-R3L-srv>
References: <20230922030722.708267-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922030722.708267-1-chenjiahao16@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiahao,

On 09/22/23 at 11:07am, Chen Jiahao wrote:
> When testing on risc-v QEMU environment with "crashkernel="
> parameter enabled, a problem occurred with the following
> message:
> 
> [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
> [    0.000000] crashkernel reserved: 0x0000000177e00000 - 0x0000000277e00000 (4096 MB)
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:779 __insert_resource+0x8e/0xd0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-next-20230920 #1
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] epc : __insert_resource+0x8e/0xd0
> [    0.000000]  ra : insert_resource+0x28/0x4e
> [    0.000000] epc : ffffffff80017344 ra : ffffffff8001742e sp : ffffffff81203db0
> [    0.000000]  gp : ffffffff812ece98 tp : ffffffff8120dac0 t0 : ff600001f7ff2b00
> [    0.000000]  t1 : 0000000000000000 t2 : 3428203030303030 s0 : ffffffff81203dc0
> [    0.000000]  s1 : ffffffff81211e18 a0 : ffffffff81211e18 a1 : ffffffff81289380
> [    0.000000]  a2 : 0000000277dfffff a3 : 0000000177e00000 a4 : 0000000177e00000
> [    0.000000]  a5 : ffffffff81289380 a6 : 0000000277dfffff a7 : 0000000000000078
> [    0.000000]  s2 : ffffffff81289380 s3 : ffffffff80a0bac8 s4 : ff600001f7ff2880
> [    0.000000]  s5 : 0000000000000280 s6 : 8000000a00006800 s7 : 000000000000007f
> [    0.000000]  s8 : 0000000080017038 s9 : 0000000080038ea0 s10: 0000000000000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff80a0bc00 t4 : ffffffff80a0bc00
> [    0.000000]  t5 : ffffffff80a0bbd0 t6 : ffffffff80a0bc00
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.000000] [<ffffffff80017344>] __insert_resource+0x8e/0xd0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Failed to add a Crash kernel resource at 177e00000
> 
> The crashkernel memory has been allocated successfully, whereas
> it failed to insert into iomem_resource. This is due to the

This is a warning, not a failure, right? Inserting crashk_*res into
iomem_resource has been successful, just the repeated inserting cause
the warning. Maybe, we should tell this in log clearly? Other than minor
concern, this looks good to me, thanks for the testing and this fix:

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> unique reserving logic in risc-v arch specific code, i.e.
> crashk_res/crashk_low_res will be added into iomem_resource
> later in init_resources(), which is not aligned with current
> unified reserving logic in reserve_crashkernel_generic()/
> reserve_crashkernel_low().
> 
> Removing the arch specific code within #ifdef CONFIG_KEXEC_CORE
> in init_resources() to fix above problem.
> 
> Fixes: 31549153088e ("riscv: kdump: use generic interface to simplify crashkernel reservation")
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  arch/riscv/kernel/setup.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index e600aab116a4..aac853ae4eb7 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -173,19 +173,6 @@ static void __init init_resources(void)
>  	if (ret < 0)
>  		goto error;
>  
> -#ifdef CONFIG_KEXEC_CORE
> -	if (crashk_res.start != crashk_res.end) {
> -		ret = add_resource(&iomem_resource, &crashk_res);
> -		if (ret < 0)
> -			goto error;
> -	}
> -	if (crashk_low_res.start != crashk_low_res.end) {
> -		ret = add_resource(&iomem_resource, &crashk_low_res);
> -		if (ret < 0)
> -			goto error;
> -	}
> -#endif
> -
>  #ifdef CONFIG_CRASH_DUMP
>  	if (elfcorehdr_size > 0) {
>  		elfcorehdr_res.start = elfcorehdr_addr;
> -- 
> 2.34.1
> 

