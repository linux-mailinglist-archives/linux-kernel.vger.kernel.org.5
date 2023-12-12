Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5D80F443
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjLLRRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjLLRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F7099
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:17:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36EFC433C8;
        Tue, 12 Dec 2023 17:17:40 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:17:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v9 3/4] arm64: mte: add compression support to mteswap.c
Message-ID: <ZXiVsiPj7iULFCY5@arm.com>
References: <20231113105234.32058-1-glider@google.com>
 <20231113105234.32058-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113105234.32058-4-glider@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:52:32AM +0100, Alexander Potapenko wrote:
> Update mteswap.c to perform inline compression of memory tags when
> possible.
> 
> If CONFIG_ARM64_MTE_COMP is enabled, mteswap.c will attempt to compress
> saved tags for a struct page and store them directly in Xarray entry
> instead of wasting heap space.
> 
> Soon after booting Android, tag compression saves ~2x memory previously
> spent by mteswap.c on tag allocations. On a moderately loaded device with
> ~20% tagged pages, this leads to saving several megabytes of kernel heap:
> 
>   # cat /sys/kernel/debug/mteswap/stats
>   8 bytes:	102496 allocations,	67302 deallocations
>   128 bytes:	212234 allocations,	178278 deallocations
>   uncompressed tag storage size:	8851200
>   compressed tag storage size:	4346368
> 
> (statistics collection is introduced in the following patch)
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
