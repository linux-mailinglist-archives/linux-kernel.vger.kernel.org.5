Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019FB7812BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379400AbjHRSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379483AbjHRSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB841982
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BC367F34
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7E7C433C8;
        Fri, 18 Aug 2023 18:18:08 +0000 (UTC)
Date:   Fri, 18 Aug 2023 19:18:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v4 5/5] arm64: mte: add compression support to mteswap.c
Message-ID: <ZN+13iQ4oOgpKhNO@arm.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-6-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720173956.3674987-6-glider@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:39:56PM +0200, Alexander Potapenko wrote:
> Soon after booting Android, tag compression saves ~2.5x memory previously
> spent by mteswap.c on tag allocations. With the growing uptime, the
> savings reach 20x and even more.

This sounds like a marketing claim ;). The way I read your statement is
that the memory used for tag storage is 2.5x less with your patches and
that's great. It means a 2.5x compression on average. How does the
compression get so much better to 20x with more uptime? The number of
tag storage allocations should be proportional to the pages swapped out
(not equal as not all would be mapped as PROT_MTE). So you can indeed
have a lot more pages swapped out than available in RAM and the tag
storage can take space but not sure which numbers you divided to get
20x.

Anyway, it would be nice to see the full picture of what the savings
relative to the total RAM is. Given that the swap in this instance is
zram, you have an upper bound of how many pages it can store. I'm just
trying to assess whether the complexity added here is worth it.

Maybe not as good as the RLE algorithm here, I was wondering whether we
could use zswap to save the tags together with the page. I looked some
time ago at it seemed slightly easier for zswap than zram. Another
option is to make the swap format more generic to support metadata
storage. Yet another option is for the zram to flag that it can compress
the metadata together with the data (no swap format change needed; when
decompressing the page, it populates the tags as well).

-- 
Catalin
