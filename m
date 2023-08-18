Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC130781275
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379226AbjHRR5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379296AbjHRR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018B4221
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1BC561FE7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484C7C433C8;
        Fri, 18 Aug 2023 17:57:17 +0000 (UTC)
Date:   Fri, 18 Aug 2023 18:57:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v4 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZN+w+RcanPRx5OVZ@arm.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720173956.3674987-4-glider@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some random comments, I haven't reviewed the series properly.

On Thu, Jul 20, 2023 at 07:39:54PM +0200, Alexander Potapenko wrote:
> diff --git a/Documentation/arch/arm64/mte-tag-compression.rst b/Documentation/arch/arm64/mte-tag-compression.rst
> new file mode 100644
> index 0000000000000..af6716d53c1a8
> --- /dev/null
> +++ b/Documentation/arch/arm64/mte-tag-compression.rst
> @@ -0,0 +1,212 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================================
> +Tag Compression for Memory Tagging Extension (MTE)
> +==================================================
> +
> +This document describes the algorithm used to compress memory tags used by the
> +ARM Memory Tagging Extension (MTE)
> +
> +Introduction
> +============
> +
> +MTE assigns tags to memory pages: for 4K pages those tags occupy 128 bytes
> +(256 4-bit tags each corresponding to a 16-byte MTE granule). By default, MTE
> +carves out 3.125% (1/16) of the available physical memory to store the tags.
> +
> +When MTE pages are saved to swap, their tags need to be stored in the kernel
> +memory. If the system swap is used heavily, these tags may take a substantial
> +portion of the physical memory, which in the case of a zram-backed swap may
> +even exceed the memory used to store the swapped pages themselves.

Hmm, I'm not sure about this claim ;). Is the zram so good that it
manages a 32x compression (4096/128)?

How much would we save if we only do the compression when it can fit in
63 bits?

> +/**
> + * mte_tags_to_ranges() - break @tags into arrays of tag ranges.
> + * @tags: 128-byte array containing 256 MTE tags.
> + * @out_tags: u8 array to store the tag of every range.
> + * @out_sizes: unsigned short array to store the size of every range.
> + * @out_len: length of @out_tags and @out_sizes (output parameter, initially
> + *           equal to lengths of out_tags[] and out_sizes[]).
> + */
> +void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
> +			size_t *out_len)
> +{
> +	u8 prev_tag = tags[0] / 16; /* First tag in the array. */
> +	unsigned int cur_idx = 0, i, j;
> +	u8 cur_tag;
> +
> +	memset(out_tags, 0, array_size(*out_len, sizeof(*out_tags)));
> +	memset(out_sizes, 0, array_size(*out_len, sizeof(*out_sizes)));
> +
> +	out_tags[0] = prev_tag;
> +	for (i = 0; i < MTE_PAGE_TAG_STORAGE; i++) {
> +		for (j = 0; j < 2; j++) {
> +			cur_tag = j ? (tags[i] % 16) : (tags[i] / 16);
> +			if (cur_tag == prev_tag) {
> +				out_sizes[cur_idx]++;
> +			} else {
> +				cur_idx++;
> +				prev_tag = cur_tag;
> +				out_tags[cur_idx] = prev_tag;
> +				out_sizes[cur_idx] = 1;
> +			}
> +		}
> +	}
> +	*out_len = cur_idx + 1;
> +}
> +EXPORT_SYMBOL_NS(mte_tags_to_ranges, MTECOMP);

What's with the exports here? Are we expecting these functions to be
called from loadable modules?

-- 
Catalin
