Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F975FE78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjGXRth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGXRtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE49448C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC81861381
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC384C433C9;
        Mon, 24 Jul 2023 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690220722;
        bh=MuNKACAMApCcjb2hzOx6KGU1cfKOZz6a4OvLvRsWOfg=;
        h=From:To:Cc:Subject:Date:From;
        b=OVpBWdFUq1/9ApYyMZ3ZFRGlBW+dyZkhr8KU00dh5ayOBVZQfP0wjxJU+bOwP/tab
         yhROc4Hk6Ucgp1iA+PrX7/FBKHhWArCac2m8RFRyLwA5+bwBzFWUCtwK5UQsJIpD57
         JXQ8B/sNKQ+M/T2cMaXxewXNILdL01gtCImk9wqxhB/JBaDqIAgzk7OqqqKpqZFrE1
         eEEi9n0iRjO1jWOdNYPZNxtR6vnzIXCCMiaQCuHNEu4DaHxGd/9C0dzidDv3UKHEs4
         ZET8/r7K9Lgb1tchjlQULve+J92+VJOUYH39I6r4sRk+QyTqmIIJ8k5YEpoYp1AYj+
         ku1pDJ/SkdH4Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH 0/2] Fix 'faddr2line' for LLVM arm64 builds
Date:   Mon, 24 Jul 2023 18:45:15 +0100
Message-Id: <20230724174517.15736-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

We recently noticed that 'faddr2line' isn't working very well on arm64
Android kernels built with LLVM, so I've hacked up this pair of fixes
which get it back into action. Please take a look!

I suck at shell, so apologies in advance for the patches.

Cheers,

Will

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>

--->8

Will Deacon (2):
  scripts/faddr2line: Ignore non-function symbols in readelf output
  scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1

 scripts/faddr2line | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

