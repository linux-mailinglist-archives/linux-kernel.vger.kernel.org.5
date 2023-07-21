Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3C75D158
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGUSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjGUSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4635B8;
        Fri, 21 Jul 2023 11:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6779761D7D;
        Fri, 21 Jul 2023 18:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11E2C433C8;
        Fri, 21 Jul 2023 18:25:06 +0000 (UTC)
Date:   Fri, 21 Jul 2023 19:25:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        mark.rutland@arm.com, ryan.roberts@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, linux-doc@vger.kernel.org,
        corbet@lwn.net, peterz@infradead.org, arnd@arndb.de,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>, wangkefeng.wang@huawei.com,
        xhao@linux.alibaba.com, prime.zeng@hisilicon.com,
        Jonathan.Cameron@huawei.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v11 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation/migration
Message-ID: <ZLrNgfDNyZGWx5bG@arm.com>
References: <20230717131004.12662-1-yangyicong@huawei.com>
 <20230717131004.12662-5-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717131004.12662-5-yangyicong@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:10:04PM +0800, Yicong Yang wrote:
> +static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +					     struct mm_struct *mm,
> +					     unsigned long uaddr)
> +{
> +	__flush_tlb_page_nosync(mm, uaddr);
> +}
> +
> +static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> +{
> +	dsb(ish);
> +}
> +
> +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +	dsb(ish);
> +}

Nitpick: as an additional patch, I'd add some comment for these two
functions that the TLBI has already been issued and only a DSB is needed
to synchronise its effect on the other CPUs.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
