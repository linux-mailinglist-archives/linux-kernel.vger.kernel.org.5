Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E248755F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGQJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGQJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03286E5C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4968E6100C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CD5C433C7;
        Mon, 17 Jul 2023 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689586938;
        bh=7djUuK4CaCxbuErINkByzceZuMx0GZNfPOcNnVQNolY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bg0yktPmRMK5WOrzwMUGsxI4bND332xwWUjzvwP4LVC8cPWizikPosIN8oE+k9PIr
         YAMjk7FLEfCPE+vPQqgomC8dnrBqyWoBE1UUOeVBVsKyh9+7IQiSN8nBJ87pcCHFnn
         EQcvzvDvBpLtYGYg6gaPopsSO0SMqId6ss4Hn3EuzMbZRg4sgzoyxABjF8gW+bgtCz
         CLgYaBrm4uFCFhGjzNaLzOOeV0XxQEw9BepgrMVj4HClrGmLZT+5MftQREetFEvM7m
         SCkiUJAvZbwz3dgQ8YwFur/xl9uuDY1QchpYZDL8Abn9l9Ffs7iXkdRkclXVhOQLmy
         dECA/nlh8wdGg==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qLKkC-00DghT-CT;
        Mon, 17 Jul 2023 10:42:16 +0100
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 10:42:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: enable dead code elimination
In-Reply-To: <20230717080739.1000460-1-wangkefeng.wang@huawei.com>
References: <20230717080739.1000460-1-wangkefeng.wang@huawei.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <801e30a093e41c3eebd675f0d224f8d7@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: wangkefeng.wang@huawei.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-17 09:07, Kefeng Wang wrote:
> Select CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION for arm64, allowing 
> the
> user to enable dead code elimination. In order for this to work, ensure
> that we keep the necessary tables by annotating them with KEEP, also it
> requires further changes to linker script to KEEP some tables and 
> wildcard
> compiler generated sections into the right place.
> 
> The following comparison is based 6.5-rc2 with defconfig,
> 
> $ ./scripts/bloat-o-meter vmlinux-base vmlinux-new
> add/remove: 3/1106 grow/shrink: 4102/6964 up/down: 35704/-99980 
> (-64276)
> Function                                     old     new   delta
> ...
> Total: Before=17888959, After=17824683, chg -0.36%
> 
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-44 (-44)
> Data                                         old     new   delta
> ...
> Total: Before=4820808, After=4820764, chg -0.00%
> 
> add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-1096 (-1096)
> RO Data                                      old     new   delta
> ...
> Total: Before=5179123, After=5178027, chg -0.02%
> 
> $ size vmlinux-base vmlinux
>    text	   data	     bss      dec       hex	filename
> 25433734  15385766  630656  41450156  2787aac	vmlinux-base
> 24756738  15360870  629888  40747496  26dc1e8	vmlinux-new
> 
> Memory available after booting, saving 704k on qemu,
> base: 8084532K/8388608K
> new:  8085236K/8388608K
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I took this patch for a spin in my tree, and ended up with:

   CC      .vmlinux.export.o
   UPD     include/generated/utsversion.h
   CC      init/version-timestamp.o
   LD      .tmp_vmlinux.kallsyms1
ld: init/main.o(__patchable_function_entries): error: need linked-to 
section for --gc-sections
make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Error 1
make[1]: *** [/home/maz/hot-poop/arm-platforms/Makefile:1238: vmlinux] 
Error 2
make: *** [Makefile:234: __sub-make] Error 2

so it's probably not ready for prime time.

         M.
-- 
Jazz is not dead. It just smells funny...
