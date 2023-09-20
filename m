Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB47A71E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjITFW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjITFVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F47F3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wYiT4DruSD+QC32dES8hhCpNakimhJKyMGf+5+i73PQ=; b=1SA6bvTQV2Vk09FYca8lUX8/en
        sVV57qGZ/26jHOL/POPyxs05mIJHAa49pv13lxW8gjnxCvQOcgzdMkxYsni7rDe4sIO3kcdY7bIfN
        X/t96CMQWNpMQU/gxGtrcVFTAr4uNMznh4UZ9BCFRBg6/QvM9usq+vPx+wVIqkC5T8iVPmDxT7xwV
        P6AaSESTff3eVtAHn42AAXXVOtjmQ4ffEB/k7elyG0hbVHA17h9mNqPKbUvj7tCCeGu772LN25p4J
        UkEONw7qHXJiRvJM9YNMoufwhdL4K24Skx5TmtCHXkMxVSbF1qUrpDJWH+p7ONLCdk31DsDUS9lGP
        /isNwHrg==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipek-001tym-1P;
        Wed, 20 Sep 2023 05:21:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 15/16] xtensa: umulsidi3: fix conditional expression
Date:   Tue, 19 Sep 2023 22:21:38 -0700
Message-ID: <20230920052139.10570-16-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even when a variant has one or more of these defines set to 1, the
multiplier code paths are not used. Change the expression so that the
correct code paths are used.

arch/xtensa/lib/umulsidi3.S:44:38: warning: "XCHAL_NO_MUL" is not defined, evaluates to 0 [-Wundef]
   44 | #if defined(__XTENSA_CALL0_ABI__) && XCHAL_NO_MUL
arch/xtensa/lib/umulsidi3.S:145:38: warning: "XCHAL_NO_MUL" is not defined, evaluates to 0 [-Wundef]
  145 | #if defined(__XTENSA_CALL0_ABI__) && XCHAL_NO_MUL
arch/xtensa/lib/umulsidi3.S:159:5: warning: "XCHAL_NO_MUL" is not defined, evaluates to 0 [-Wundef]
  159 | #if XCHAL_NO_MUL

Fixes: 8939c58d68f9 ("xtensa: add __umulsidi3 helper")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/lib/umulsidi3.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -- a/arch/xtensa/lib/umulsidi3.S b/arch/xtensa/lib/umulsidi3.S
--- a/arch/xtensa/lib/umulsidi3.S
+++ b/arch/xtensa/lib/umulsidi3.S
@@ -3,7 +3,9 @@
 #include <asm/asmmacro.h>
 #include <asm/core.h>
 
-#if !XCHAL_HAVE_MUL16 && !XCHAL_HAVE_MUL32 && !XCHAL_HAVE_MAC16
+#if XCHAL_HAVE_MUL16 || XCHAL_HAVE_MUL32 || XCHAL_HAVE_MAC16
+#define XCHAL_NO_MUL 0
+#else
 #define XCHAL_NO_MUL 1
 #endif
 
