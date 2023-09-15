Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209F27A1FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjIONgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjIONgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:36:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC942126
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:36:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A4BE218EC;
        Fri, 15 Sep 2023 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694784974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rlrz3u2Vsb7vGlQTOlcmAup+cWeQZdVEYu0oGCHX8Q=;
        b=Gsf1eUJ8XcQyXAK6NTaBzs+N2+cdSyYIzeO1b/6RlP7vdDItVhbz80p8Qj3Qn8t4LxdmrR
        5QEwjUPmp+6VQDd1NSictR5mbiGJEIqRpC3GmW7A37Q1qaei5tpPCFdsg0cWBZYiULZLVQ
        3SWSGOBae2UIwjvy8R2KcUi+cAr2xgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694784974;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rlrz3u2Vsb7vGlQTOlcmAup+cWeQZdVEYu0oGCHX8Q=;
        b=zf2vbx7BqDgGUZ4WxbsB6fugz/uSdeVGa7gqa3pSZsnTM9EHCeGeqr1PthyoSONkMRrj/1
        pT32eXfikGMIKbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F024E1358A;
        Fri, 15 Sep 2023 13:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VyDGOc1dBGUbYwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 15 Sep 2023 13:36:13 +0000
Message-ID: <c5e0caf5-cefd-fc4a-9e3d-a3479323bd09@suse.cz>
Date:   Fri, 15 Sep 2023 15:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <202309111340.f59c3f22-oliver.sang@intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202309111340.f59c3f22-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 07:56, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "UBSAN:shift-out-of-bounds_in_mm/slub.c" on:
> 
> commit: f04d441027621c16081803832a54f59272112cf5 ("[PATCH 4/4] mm/slub: refactor calculate_order() and calc_slab_order()")
> url: https://github.com/intel-lab-lkp/linux/commits/Vlastimil-Babka/mm-slub-simplify-the-last-resort-slab-order-calculation/20230908-225506
> base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
> patch link: https://lore.kernel.org/all/20230908145302.30320-10-vbabka@suse.cz/
> patch subject: [PATCH 4/4] mm/slub: refactor calculate_order() and calc_slab_order()
> 
> in testcase: boot
> 
> compiler: clang-16
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | a17847b835 | f04d441027 |
> +-------------------------------------------------+------------+------------+
> | UBSAN:shift-out-of-bounds_in_mm/slub.c          | 0          | 12         |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202309111340.f59c3f22-oliver.sang@intel.com
> 
> 
> [    0.901457][    T0] UBSAN: shift-out-of-bounds in mm/slub.c:463:34
> [    0.902458][    T0] shift exponent 52 is too large for 32-bit type 'unsigned int'
> [    0.903477][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.5.0-rc1-00009-gf04d44102762 #1
> [    0.904450][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [    0.904450][    T0] Call Trace:
> [    0.904450][    T0]  <TASK>
> [ 0.904450][ T0] dump_stack_lvl (lib/dump_stack.c:107) 
> [ 0.904450][ T0] dump_stack (lib/dump_stack.c:114) 
> [ 0.904450][ T0] ubsan_epilogue (lib/ubsan.c:218) 
> [ 0.904450][ T0] __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:?) 
> [ 0.904450][ T0] ? tdx_handle_virt_exception (arch/x86/include/asm/shared/tdx.h:60 arch/x86/coco/tdx/tdx.c:375 arch/x86/coco/tdx/tdx.c:430 arch/x86/coco/tdx/tdx.c:650 arch/x86/coco/tdx/tdx.c:666) 
> [ 0.904450][ T0] ? kmemleak_alloc (mm/kmemleak.c:977) 
> [ 0.904450][ T0] __kmem_cache_create (mm/slub.c:? mm/slub.c:4159 mm/slub.c:4473 mm/slub.c:4507 mm/slub.c:5104) 

Oh thanks, fixing up:

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4152,7 +4152,8 @@ static inline int calculate_order(unsigned int size)
                        nr_cpus = nr_cpu_ids;
                min_objects = 4 * (fls(nr_cpus) + 1);
        }
-       max_objects = order_objects(slub_max_order, size);
+       /* min_objects can't be 0 because get_order(0) is undefined */
+       max_objects = max(order_objects(slub_max_order, size), 1);
        min_objects = min(min_objects, max_objects);
 
        min_order = max(slub_min_order, (unsigned int)get_order(min_objects * size));
l

