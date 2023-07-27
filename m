Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C693F764530
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjG0E7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjG0E7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2AAE47
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F5EC61D32
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFE3C433C7;
        Thu, 27 Jul 2023 04:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690433946;
        bh=nI3Z9E6LOhtjoLvillvTW615wdZhZT9TfqRBESPyb7g=;
        h=Date:From:To:Cc:Subject:From;
        b=js8a6UH9dinR7AIi+YwNglSjbd6sFcwWYXFMgJXueedhSrAeN5vww8wXM6VIZzoZe
         cw+hm2tvfhvHA3BYoLQs5r0N4QaMEHCQnYB4iT0UjeZiRKZ4RIiA/Oy5g0tjDjLgbW
         55wyhbb6qXK2G45s7s18Ihczb1IXr+KMbIcg+ZFVd348P5HPtkAYpDKbHYITqS6z08
         Wk6bGMfqyRKQUkVirBTYWM83C1VkNKtke21THQs1I3nUw5VX/VGbhuFrWDmhC1CHsx
         YUJf0xPA0FCEJH8KXmUDTKyF66Nph6dejQgYe90jvwQfrc0HUof3cfVqiB4VnFoQN9
         FwyOmxNnnUU5w==
Date:   Thu, 27 Jul 2023 07:58:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock fixes for v6.5-rc4
Message-ID: <20230727045831.GB1901145@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2023-07-27

for you to fetch changes up to 9e46e4dcd9d6cd88342b028dbfa5f4fb7483d39c:

  mm,memblock: reset memblock.reserved to system init state to prevent UAF (2023-07-24 08:52:56 +0300)

----------------------------------------------------------------
memblock: reset memblock.reserved to system init state to prevent UAF

A call to memblock_free() or memblock_phys_free() issued after memblock
data is discarded will result in use after free in
memblock_isolate_range().

When CONFIG_KASAN is enabled, this will cause a panic early in boot.
Without CONFIG_KASAN, there is a chance that memblock_isolate_range() might
scribble on memory that is now in use by somebody else.

Avoid those issues by making sure that memblock_discard points
memblock.reserved.regions back at the static buffer.

If memblock_free() or memblock_phys_free() is called after memblock memory
is discarded, that will print a warning in memblock_remove_region().

----------------------------------------------------------------
Rik van Riel (1):
      mm,memblock: reset memblock.reserved to system init state to prevent UAF

 mm/memblock.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Sincerely yours,
Mike.
