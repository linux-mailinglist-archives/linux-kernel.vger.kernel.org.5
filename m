Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331E179FD94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjINH44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjINH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:56:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4671FC0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:56:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4188BC433C7;
        Thu, 14 Sep 2023 07:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694678205;
        bh=43+dXaouu7djoigVoxm+HE1AawyJHHKsfY707t/g9tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdHUcK77snHtiH1fIoj0JBOIn6Atut9NYodwp5lUWUVzNxD8HUeW+Wr4Zk4sXrAqv
         IvuWlXrl5Cq6Agmxx3Dn08a2n60FttFEdpJ/7O+fgEluQRNsGL/Rq+LNNg1tsi55DA
         pA/UxvpXRVQuoXCmlbO4Zjk8+/97NfnuaCA/NAO4aJPtH3dL6xslM9qe1BxIYsXO8s
         nQ0ZSrmVGQbxuxU5dQVyYRbhnnljE7VJVJ6ty7RoNfFb/nKZ8gTTlHXiX9h4zbfmcy
         /sSvgkShjcY3VvpCWsQt/B22w13h9n2HXcnVh7FZXGXjEFSnVGGa1vR/SpXCU3oTzr
         jF8zlgVbaTCGQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] memblock tests: fix warning: "__ALIGN_KERNEL" redefined
Date:   Thu, 14 Sep 2023 10:56:31 +0300
Message-Id: <20230914075632.9515-2-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914075632.9515-1-rppt@kernel.org>
References: <20230914075632.9515-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Building memblock tests produces the following warning:

cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o main.o main.c
In file included from ../../include/linux/pfn.h:5,
                 from ./linux/memory_hotplug.h:6,
                 from ./linux/init.h:7,
                 from ./linux/memblock.h:11,
                 from tests/common.h:8,
                 from tests/basic_api.h:5,
                 from main.c:2:
../../include/linux/mm.h:14: warning: "__ALIGN_KERNEL" redefined
   14 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
      |
In file included from ../../include/linux/mm.h:6,
                 from ../../include/linux/pfn.h:5,
                 from ./linux/memory_hotplug.h:6,
                 from ./linux/init.h:7,
                 from ./linux/memblock.h:11,
                 from tests/common.h:8,
                 from tests/basic_api.h:5,
                 from main.c:2:
../../include/uapi/linux/const.h:31: note: this is the location of the previous definition
   31 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
      |

Remove definitions of __ALIGN_KERNEL and __ALIGN_KERNEL_MASK from
tools/include/linux/mm.h to fix it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 tools/include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index 2bc94079d616..f3c82ab5b14c 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -11,8 +11,6 @@
 
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
-#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 #define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
 #define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))
 
-- 
2.39.2

