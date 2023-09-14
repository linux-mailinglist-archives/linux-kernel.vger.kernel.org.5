Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20B77A0529
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjINNMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbjINNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:12:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8931FE0;
        Thu, 14 Sep 2023 06:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08064C433C9;
        Thu, 14 Sep 2023 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697152;
        bh=Kh9pU/xf+VGPc4ooL6xm3VqJZN3l4jNcBSstCB+238k=;
        h=From:To:Cc:Subject:Date:From;
        b=mCVDV+GD+8nvp5pITa6SeYr4XF5qno/5NReU62xueIFEo+GTc7tstKSCKz+8wsTfH
         1jt07kDpuXXhx1pHrQVd0yJPnuu/C5Dmsny9Xg+Uk3QS8m4ObNaitOGiVTrCCbUEOZ
         1o4xQ5v6fYrEY8RXNZH6N2onC5AeqGAMES4WucwtvIWBhngLIyN7Wy0IKyXWZ93wab
         p875ryf7KuAE8RcVOuGDi5P6qZ89K1TW90m2uBOBlIPCb2NAA6XMkPxlQIk9WTQiDH
         57DJbNxSLeEaBdGJzpu4UqxOBt7/HtIDhELLrNKnbzfwvtxMnusK6wdKg2hXhNUrkp
         7J79NBrT0Risg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v4 0/3] Fix 'faddr2line' for LLVM arm64 builds
Date:   Thu, 14 Sep 2023 14:12:22 +0100
Message-Id: <20230914131225.13415-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's version four of my faddr2line fixes previously posted here:

v1: https://lore.kernel.org/r/20230724174517.15736-1-will@kernel.org
v2: https://lore.kernel.org/r/20230725211157.17031-1-will@kernel.org
v3: https://lore.kernel.org/r/20230728113415.21067-1-will@kernel.org

Changes since v3 include:
  * Add support for specifying specific LLVM versions with LLVM=
  * Drop the mksysmap filter in favour of a simpler regex implementing
    is_mapping_symbol()

Cheers,

Will

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: linux-kbuild@vger.kernel.org

--->8

Will Deacon (3):
  scripts/faddr2line: Don't filter out non-function symbols from readelf
  scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
  scripts/faddr2line: Skip over mapping symbols in output from readelf

 scripts/faddr2line | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

