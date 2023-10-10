Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86167BEF67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbjJJAA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbjJJAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:00:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F23A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:00:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7362C433C7;
        Tue, 10 Oct 2023 00:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696896054;
        bh=YKS8Y/7EmqBXYuLK/9MivE+xNPfZVkeyEmaZhaCyW+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RryLjpiV4EvbXtkF6jCKy71S0MNAG5dgMqH2ypf7KUcH8JxcCO2Az3wr4Fop2QoZB
         3vUic30DMWobAmFZ3NSBupUnzR8oiCFyzwCFCRMhVbHe34pG+kprS/MS9qoywVGkBA
         VSZqLNIVRk+B/g6HIw4aYkQXMV018pdZOysyJ0yw=
Date:   Mon, 9 Oct 2023 17:00:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH v2] kasan:print the original fault addr when access
 invalid shadow
Message-Id: <20231009170031.a294c11575d5d4941b8596a9@linux-foundation.org>
In-Reply-To: <20231009073748.159228-1-haibo.li@mediatek.com>
References: <20231009073748.159228-1-haibo.li@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 15:37:48 +0800 Haibo Li <haibo.li@mediatek.com> wrote:

> when the checked address is illegal,the corresponding shadow address
> from kasan_mem_to_shadow may have no mapping in mmu table.
> Access such shadow address causes kernel oops.
> Here is a sample about oops on arm64(VA 39bit) 
> with KASAN_SW_TAGS and KASAN_OUTLINE on:
> 
> [ffffffb80aaaaaaa] pgd=000000005d3ce003, p4d=000000005d3ce003,
>     pud=000000005d3ce003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 100 Comm: sh Not tainted 6.6.0-rc1-dirty #43
> Hardware name: linux,dummy-virt (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __hwasan_load8_noabort+0x5c/0x90
> lr : do_ib_ob+0xf4/0x110
> ffffffb80aaaaaaa is the shadow address for efffff80aaaaaaaa.
> The problem is reading invalid shadow in kasan_check_range.
> 
> The generic kasan also has similar oops.
> 
> It only reports the shadow address which causes oops but not
> the original address.
> 
> Commit 2f004eea0fc8("x86/kasan: Print original address on #GP")
> introduce to kasan_non_canonical_hook but limit it to KASAN_INLINE.
> 
> This patch extends it to KASAN_OUTLINE mode.

Is 2f004eea0fc8 a suitable Fixes: target for this?  If not, what is?

Also, I'm assuming that we want to backport this fix into earlier
kernel versions?


