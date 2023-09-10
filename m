Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD84799D62
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbjIJIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjIJIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 04:50:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844A1B9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 01:50:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77069C433C7;
        Sun, 10 Sep 2023 08:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694335835;
        bh=vsqC4Q0V2oBEuQjchMzNlW8atq0L+1M6Tmmkzi/4EhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLPQ9eXDMYpawn2FVYrooVHIvkEML7VFiVxFM3fpL+1JL79CGzXxdKhWsuOqy4wVT
         QIy6P7u32Sjt+ae7SJoOEZ8JoQttxYaas9a+Y8JkR3aZRczKQZxjJzGJ8b4+sI3pbw
         4l+q20Iuhd7eCVkR3MQSuIIFdzmoMhPm5j9tVPFYPIfS5DIxxtK+KFWrboXBrdJEyl
         Ee33yGFrEov+z7H3J4u3MPzPARqXA8U5fz3odyjCmuSra2DR7UM4cvVwNrQwzeZDTR
         BPzc+SE3BSFEf0us+d6qga17E560ME+J5VuaWcgI2p+lqL9Bu2SgeR2hLehzhp+K7Q
         mJ3IX83I3sVOQ==
Date:   Sun, 10 Sep 2023 04:50:29 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Message-ID: <ZP2DVap64lJZj9g4@gmail.com>
References: <20230810040349.92279-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810040349.92279-2-leobras@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:03:42AM -0300, Leonardo Bras wrote:
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
> 
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exactly
> changes between the versions: Instruction sufixes & barriers.
> 
> Also, did the same kind of work on atomic.c.
> 
> After that, I noted both cmpxchg and xchg only accept variables of 
> size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.
> 
> Now that deduplication is done, it is quite direct to implement them
> for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
> me some possible users :)
> 
> I did compare the generated asm on a test.c that contained usage for every
> changed function, and could not detect any change on patches 1 + 2 + 3 
> compared with upstream.
> 
> Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
> booted just fine with qemu -machine virt -append "qspinlock". 
> 
> (tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)
Tested-by: Guo Ren <guoren@kernel.org>

Sorry for late reply, because we are stress testing CNA qspinlock on
sg2042 128 cores hardware platform. This series has passed our test for
several weeks. For more detail, ref:
https://lore.kernel.org/linux-riscv/20230910082911.3378782-1-guoren@kernel.org/

> 
> Thanks!
> Leo
> 
> Changes since squashed cmpxchg RFCv4:
> - Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
>   in current upstream, (possibly) fixing the bug from kernel test robot
> https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv3:
> - Fixed bug on cmpxchg macro for var size 1 & 2: now working
> - Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to receive
>   input of a 32-bit aligned address
> - Renamed internal macros from _mask to _masked for patches 4 & 5
> - __rc variable on macros for var size 1 & 2 changed from register to ulong 
> https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv2:
> - Removed rc parameter from the new macro: it can be internal to the macro
> - 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
> https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv1:
> - Unified with atomic.c patchset
> - Rebased on top of torvalds/master (thanks Andrea Parri!)
> - Removed helper macros that were not being used elsewhere in the kernel.
> https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
> https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv3:
> - Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
> https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv2:
> - Fixed  macros that depend on having a local variable with a magic name
> - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
> https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/
> 
> Leonardo Bras (5):
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>   riscv/atomic.h : Deduplicate arch_atomic.*
>   riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
>   riscv/cmpxchg: Implement xchg for variables of size 1 and 2
> 
>  arch/riscv/include/asm/atomic.h  | 164 ++++++-------
>  arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++---------------------
>  2 files changed, 200 insertions(+), 368 deletions(-)
> 
> 
> base-commit: cacc6e22932f373a91d7be55a9b992dc77f4c59b
> -- 
> 2.41.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
