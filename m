Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231E2811125
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjLMMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjLMMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:31:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45BA4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:31:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA3EC433C8;
        Wed, 13 Dec 2023 12:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702470696;
        bh=AYrI7SLk86MHABNGX/QodrHC6xXs3xbeF0g+zgtdlks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYLq/MzrCIXIJOMx7Iam0o8x2A2PWGEe8WO2O6+C3rYM1GiaFmXdop7KEplIkfnP6
         qw7t7K8+lO9qHpp0V+0Tl+0pnSY7jU+1YqbaQ8fnRYJzmtw5zHsZskIjuvO8iGeZp9
         StgPNxSVW4Yc2Jme6QpLJtuP0uas3PvhKlfI9j+prdNaD4ZQEaRBfIp2fuwQlrikBg
         o7k94L0B5dxMH74otpF5J1MaYLFBarSDaX2Fz2S7ycnM8gaDsKmKInnl4kviQq691P
         JsHQF9XKlHN4FPkUonBcHTCHfP5zIxBaj37Y4+t5B3XRmE0zrKynPQ7Tz8I2V1eEHf
         JvC7lK/V1Xx/Q==
Date:   Wed, 13 Dec 2023 12:31:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v9 0/4] Implement MTE tag compression for swapped pages
Message-ID: <20231213123130.GC31326@willie-the-truck>
References: <20231113105234.32058-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113105234.32058-1-glider@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:52:29AM +0100, Alexander Potapenko wrote:
> Currently, when MTE pages are swapped out, the tags are kept in the
> memory, occupying PAGE_SIZE/32 bytes per page. This is especially
> problematic for devices that use zram-backed in-memory swap, because
> tags stored uncompressed in the heap effectively reduce the available
> amount of swap memory.
> 
> The RLE-based algorithm suggested by Evgenii Stepanov and implemented in
> this patch series is able to efficiently compress fixed-size tag buffers,
> resulting in practical compression ratio of 2x. In many cases it is
> possible to store the compressed data in 63-bit Xarray values, resulting
> in no extra memory allocations.
> 
> This patch series depends on "lib/bitmap: add bitmap_{read,write}()"
> (https://lore.kernel.org/linux-arm-kernel/20231030153210.139512-1-glider@google.com/T/)
> that is mailed separately.

That's a shame, because it means I can't apply the series as-is:


arch/arm64/mm/mtecomp.c: In function ‘mte_bitmap_write’:
arch/arm64/mm/mtecomp.c:105:2: error: implicit declaration of function ‘bitmap_write’; did you mean ‘bitmap_free’? [-Werror=implicit-function-declaration]
  105 |  bitmap_write(bitmap, value, *pos, bits);
      |  ^~~~~~~~~~~~
      |  bitmap_free
arch/arm64/mm/mtecomp.c: In function ‘mte_bitmap_read’:
arch/arm64/mm/mtecomp.c:198:9: error: implicit declaration of function ‘bitmap_read’; did you mean ‘bitmap_remap’? [-Werror=implicit-function-declaration]
  198 |  return bitmap_read(bitmap, start, bits);
      |         ^~~~~~~~~~~
      |         bitmap_remap
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:243: arch/arm64/mm/mtecomp.o] Error 1


Do you really have such a hard dependency on those new bitmap ops?

Will
