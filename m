Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7004A78BC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjH2AjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjH2Aip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:38:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8649DF;
        Mon, 28 Aug 2023 17:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Sj0Gg4fQfJtwbUM/GeAvcxHJ84MBXNva1qgYGBjvRHM=; b=23NiSP4xygxRlsGKU1oVo9OAUy
        fSr1KaqztJobnTseUCo5mOY/xXyFw/rh70zFIvHgOcjn4nq46y9/9uys0ZmzzKkdbLmtLp9CCFSKO
        oooDMZ8VzsDQUG7i2SEBb3UROu0Y6QH1x03Td61XIYLgXq3mhnZ9LP1y8678lAT+a+UMEm4rFTn9o
        taUYbuNZy0m9jAO5uVVJNELKapYuBYPEmnhk3htDiv5LKkZpBNUOlN97wBfyLq8oOlcvfnetWwk8p
        ln1fA41NajTpY4mZmgM4jg8boYcwq9FbRq8nsOkgnPFN6mrpJpgzVvCtp/K2dXL1Egpwa8cInUkyX
        sECF6jSg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qamkj-00AVaY-2G;
        Tue, 29 Aug 2023 00:38:41 +0000
Message-ID: <106e0bb2-1fa6-5914-67f6-269755779e61@infradead.org>
Date:   Mon, 28 Aug 2023 17:38:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 28 (loongarch: kgdb)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:LOONGARCH" <loongarch@lists.linux.dev>
References: <20230828150220.31624576@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230828150220.31624576@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/23 22:02, Stephen Rothwell wrote:
> Hi all,
> 
> Please do *not* include material destined for v6.7 in your linux-next
> included branches until *after* v6.6-rc1 has been released.  Also,
> do *not* rebase you linu-next included branches onto v6.5.
> 
> Changes since 20230825:
> 

There are many build errors when CONFIG_PERF_EVENTS => HAVE_HW_BREAKPOINT
are not set.
This is a reduced list of the build errors:

../arch/loongarch/kernel/kgdb.c: In function 'hw_break_reserve_slot':
../arch/loongarch/kernel/kgdb.c:515:21: error: implicit declaration of function 'dbg_reserve_bp_slot'; did you mean 'reserve_bp_slot'? [-Werror=implicit-function-declaration]
  515 |                 if (dbg_reserve_bp_slot(*pevent))
      |                     ^~~~~~~~~~~~~~~~~~~
      |                     reserve_bp_slot
../arch/loongarch/kernel/kgdb.c:527:17: error: implicit declaration of function 'dbg_release_bp_slot'; did you mean 'release_bp_slot'? [-Werror=implicit-function-declaration]
  527 |                 dbg_release_bp_slot(*pevent);
      |                 ^~~~~~~~~~~~~~~~~~~
      |                 release_bp_slot
../arch/loongarch/kernel/kgdb.c: In function 'kgdb_disable_hw_break':
../arch/loongarch/kernel/kgdb.c:640:23: error: 'struct perf_event' has no member named 'attr'
  640 |                 if (bp->attr.disabled == 1)
      |                       ^~
../arch/loongarch/kernel/kgdb.c: In function 'kgdb_arch_late':
../arch/loongarch/kernel/kgdb.c:732:9: error: implicit declaration of function 'hw_breakpoint_init'; did you mean 'hw_breakpoint_slots'? [-Werror=implicit-function-declaration]
  732 |         hw_breakpoint_init(&attr);
      |         ^~~~~~~~~~~~~~~~~~
      |         hw_breakpoint_slots
../arch/loongarch/kernel/kgdb.c:752:38: error: 'struct perf_event' has no member named 'destroy'
  752 |                         if (pevent[0]->destroy) {
      |                                      ^~
cc1: some warnings being treated as errors


-- 
~Randy
