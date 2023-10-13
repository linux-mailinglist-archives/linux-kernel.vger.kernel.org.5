Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1383D7C7AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbjJMAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbjJMAeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74976B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697157214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16ake0/JJsC/X6fPrpFm7y1Me9MIldtPbCM7XyBYJoE=;
        b=LNVqhs7R7TvMgp6FUuTU8hfg3wOqzMr5hzx9nKQ4Ol+TEJddg6IicC0tGDIs66K5woTML1
        DHsilx9/9aLkZK4JctmeJrShmwG4eA4u6Rqooge5HLNXuMh5ts4lyRKiZ1L4kqPleeaGVL
        2FQbdvnkTGUGLPEm/qaGJB0GZIh/q5s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-jsGili0QN4uVFKgnC2WNsg-1; Thu, 12 Oct 2023 20:33:13 -0400
X-MC-Unique: jsGili0QN4uVFKgnC2WNsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBB823C0C10D;
        Fri, 13 Oct 2023 00:33:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1F712157F5A;
        Fri, 13 Oct 2023 00:33:11 +0000 (UTC)
Date:   Fri, 13 Oct 2023 08:33:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     palmer@rivosinc.com, Chen Jiahao <chenjiahao16@huawei.com>,
        patchwork-bot+linux-riscv@kernel.org
Cc:     robh@kernel.org, aou@eecs.berkeley.edu, zephray@outlook.com,
        alexghiti@rivosinc.com, thunder.leizhen@huawei.com,
        bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com, palmer@dabbelt.com, jszhang@kernel.org,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        akpm@linux-foundation.org, ajones@ventanamicro.com
Subject: Re: [PATCH -next v2] riscv: kdump: fix crashkernel reserving problem
 on RISC-V
Message-ID: <ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv>
References: <20230925024333.730964-1-chenjiahao16@huawei.com>
 <169714322507.23371.6628705957236576989.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169714322507.23371.6628705957236576989.git-patchwork-notify@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/23 at 08:40pm, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This patch was applied to riscv/linux.git (fixes)
> by Palmer Dabbelt <palmer@rivosinc.com>:

This patches fixes a regression of one risc-v patch which Andrew picked
into his akpm tree. Later, Andrew merged those two into one patch, now
it shows up in next/master as:

39365395046f riscv: kdump: use generic interface to simplify crashkernel reservation

Maybe it can be droppped in risv-v git tree so as not to cause conflict
when merging.

Thanks
Baoquan

> 
> On Mon, 25 Sep 2023 10:43:33 +0800 you wrote:
> > When testing on risc-v QEMU environment with "crashkernel="
> > parameter enabled, a problem occurred with the following
> > message:
> > 
> > [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
> > [    0.000000] crashkernel reserved: 0x0000000177e00000 - 0x0000000277e00000 (4096 MB)
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:779 __insert_resource+0x8e/0xd0
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-next-20230920 #1
> > [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> > [    0.000000] epc : __insert_resource+0x8e/0xd0
> > [    0.000000]  ra : insert_resource+0x28/0x4e
> > [    0.000000] epc : ffffffff80017344 ra : ffffffff8001742e sp : ffffffff81203db0
> > [    0.000000]  gp : ffffffff812ece98 tp : ffffffff8120dac0 t0 : ff600001f7ff2b00
> > [    0.000000]  t1 : 0000000000000000 t2 : 3428203030303030 s0 : ffffffff81203dc0
> > [    0.000000]  s1 : ffffffff81211e18 a0 : ffffffff81211e18 a1 : ffffffff81289380
> > [    0.000000]  a2 : 0000000277dfffff a3 : 0000000177e00000 a4 : 0000000177e00000
> > [    0.000000]  a5 : ffffffff81289380 a6 : 0000000277dfffff a7 : 0000000000000078
> > [    0.000000]  s2 : ffffffff81289380 s3 : ffffffff80a0bac8 s4 : ff600001f7ff2880
> > [    0.000000]  s5 : 0000000000000280 s6 : 8000000a00006800 s7 : 000000000000007f
> > [    0.000000]  s8 : 0000000080017038 s9 : 0000000080038ea0 s10: 0000000000000000
> > [    0.000000]  s11: 0000000000000000 t3 : ffffffff80a0bc00 t4 : ffffffff80a0bc00
> > [    0.000000]  t5 : ffffffff80a0bbd0 t6 : ffffffff80a0bc00
> > [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> > [    0.000000] [<ffffffff80017344>] __insert_resource+0x8e/0xd0
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Failed to add a Crash kernel resource at 177e00000
> > 
> > [...]
> 
> Here is the summary with links:
>   - [-next,v2] riscv: kdump: fix crashkernel reserving problem on RISC-V
>     https://git.kernel.org/riscv/c/1d6cd2146c2b


> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

