Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B27E016B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347646AbjKCKCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbjKCKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:02:48 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D672ABD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:02:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E11EC0002;
        Fri,  3 Nov 2023 10:02:36 +0000 (UTC)
Message-ID: <7fa25a76-4e4e-49c3-b0d1-fc34ed73a19a@ghiti.fr>
Date:   Fri, 3 Nov 2023 11:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] riscv: Fix set_memory_XX() and set_direct_map_XX()
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231027143222.115588-1-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231027143222.115588-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/2023 16:32, Alexandre Ghiti wrote:
> Those 2 patches fix the set_memory_XX() and set_direct_map_XX() APIs, which
> in turn fix STRICT_KERNEL_RWX and memfd_secret(). Those were broken since the
> permission changes were not applied to the linear mapping because the linear
> mapping is mapped using hugepages and walk_page_range_novma() does not split
> such mappings.
>
> To fix that, patch 1 disables PGD mappings in the linear mapping as it is
> hard to propagate changes at this level in *all* the page tables, this has the
> downside of disabling PMD mapping for sv32 and PUD (1GB) mapping for sv39 in
> the linear mapping (for specific kernels, we could add a Kconfig to enable
> ARCH_HAS_SET_DIRECT_MAP and STRICT_KERNEL_RWX if needed, I'm pretty sure we'll
> discuss that).
>
> patch 2 implements the split of the huge linear mappings so that
> walk_page_range_novma() can properly apply the permissions. The whole split is
> protected with mmap_sem in write mode, but I'm wondering if that's enough,
> any opinion on that is appreciated.
>
> Changes in v2:
> - Fix rv32 build
> - Rebase on top of 6.6-rc6
> - Move the flush_tlb_all outside the mmap_lock
>
> Alexandre Ghiti (2):
>    riscv: Don't use PGD entries for the linear mapping
>    riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge
>      linear mappings
>
>   arch/riscv/mm/init.c     |  12 +-
>   arch/riscv/mm/pageattr.c | 270 +++++++++++++++++++++++++++++++++------
>   2 files changed, 236 insertions(+), 46 deletions(-)
>

Any feedback from anyone? That's a fix I'd like to see merged in 6.7, if 
no objection, I'll ask for Palmer to take it.

Thanks,

Alex

