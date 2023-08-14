Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDE77BB64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjHNORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjHNORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:17:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FDAB;
        Mon, 14 Aug 2023 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ZCRqZIZ+9R/YAsCdB/+Blpu9sk8S1vh2WqxU66lNdw=; b=nxWWF9OPk64csqFPfAmCcpVPMX
        gTKX+XuGyf5Y1aR7e5h9mjRfnHXIHHS+KV4d81uxnaH23o+cenkbrgnNGP+C9xge7xWHyL/WgBpp6
        C5NZt1EfgEwRnzjDBvb4qwerAscYViOCe7ksGyZWLYp8odLhn357hbyroa3t/DNHFRCsmvIWX+RbX
        sxpN/UTZx4NtTbzlq5Uyo0VJKBun+utxE+GB1umi6mgEMo3qr6YC8WNCPBA9cwoTZflzfO+qJUZk7
        NCBKRb5aMfd58Y2ewN4wtxmILm62qqVF+AuUf235AWPYuUHlB8h8BHEgdDUA65qOLKyi2IhCj4xvI
        Yhih/Mig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVYNb-002PiS-B4; Mon, 14 Aug 2023 14:17:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1B6B300137;
        Mon, 14 Aug 2023 16:17:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42894202C2248; Mon, 14 Aug 2023 16:17:10 +0200 (CEST)
Date:   Mon, 14 Aug 2023 16:17:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Helge Deller <deller@gmx.de>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-parisc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Message-ID: <20230814141710.GL776869@hirez.programming.kicks-ass.net>
References: <ZNep5EcYskP9HtGD@p100>
 <202308141646.d3160c77-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308141646.d3160c77-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:40:42PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:key#has_not_been_registered" on:
> 
> commit: 94d4413e506da48ea18f1cc982202874d35c76b1 ("[PATCH] lockdep: Fix static memory detection even more")
> url: https://github.com/intel-lab-lkp/linux/commits/Helge-Deller/lockdep-Fix-static-memory-detection-even-more/20230812-235022
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
> patch link: https://lore.kernel.org/all/ZNep5EcYskP9HtGD@p100/
> patch subject: [PATCH] lockdep: Fix static memory detection even more
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308141646.d3160c77-oliver.sang@intel.com
> 
> 
> 
> [    0.575811][    T1] BUG: key b35c282c has not been registered!
> [    0.576580][    T1] ------------[ cut here ]------------
> [    0.577216][    T1] DEBUG_LOCKS_WARN_ON(1)
> [    0.577236][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:4888 lockdep_init_map_type+0x155/0x250
> [    0.578389][    T1] Modules linked in:
> [    0.578856][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc4-00587-g94d4413e506d #2

> [    0.595653][    T1]  __kernfs_create_file+0x6a/0xe0
> [    0.596244][    T1]  sysfs_add_bin_file_mode_ns+0x4e/0xc0
> [    0.596891][    T1]  sysfs_create_bin_file+0x5c/0x90
> [    0.597496][    T1]  ? nsproxy_cache_init+0x30/0x30
> [    0.598090][    T1]  ksysfs_init+0x5c/0x90

Problem seems to be __ro_after_init. Your patch only considers
is_kernel_core_data(), which seems to not include these other fancy data
sections we have.
