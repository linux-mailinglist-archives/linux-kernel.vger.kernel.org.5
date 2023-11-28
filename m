Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158827FC85A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbjK1V1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjK1V1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:27:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274D35B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC2BC433C7;
        Tue, 28 Nov 2023 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205648;
        bh=qSIOZxomh9bqGqVlenPpEsVcBxrve1a1I35FfYRsidw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcWvhUWltC6MD21iyFocM32U5tv8iU8jBPFvk6Q7w+Nj3hXLjPDEH84+oVaW9VdQh
         mAPEUJYcf/j3LBsJziKnc7JqtJPGXCFoTbrhR1h7AEsirGFIest594QeCIVN8npsBA
         eiDySeWlv+DutR1oDh0sHnUGBx24IHyXyUb9mJ5tINynSQNcBjoGd2s1knXNubXvTE
         VP5kNMoLF/ua8KMJWQ3ALqOckNULPfjrMwXE1BQmdkjw6o8hk/nrkhfrdd0QGjF4iw
         sUrWazbo8Pk3nCOR1SC2LJfis1QEE/o0O2Sl07aq+FJV4mO/KaNqJ8PbYZWDwOEWIG
         KH6RWCimd0TJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, glaubitz@physik.fu-berlin.de,
        rdunlap@infradead.org
Subject: [PATCH AUTOSEL 6.6 33/40] scripts/checkstack.pl: match all stack sizes for s390
Date:   Tue, 28 Nov 2023 16:05:39 -0500
Message-ID: <20231128210615.875085-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit aab1f809d7540def24498e81347740a7239a74d5 ]

For some unknown reason the regular expression for checkstack only matches
three digit numbers starting with the number "3", or any higher
number. Which means that it skips any stack sizes smaller than 304
bytes. This makes the checkstack script a bit less useful than it could be.

Change the script to match any number. To be filtered out stack sizes
can be configured with the min_stack variable, which omits any stack
frame sizes smaller than 100 bytes by default.

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/checkstack.pl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 84f5fb7f1cecc..d83ba5d8f3f49 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -97,8 +97,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 		#   11160:       a7 fb ff 60             aghi   %r15,-160
 		# or
 		#  100092:	 e3 f0 ff c8 ff 71	 lay	 %r15,-56(%r15)
-		$re = qr/.*(?:lay|ag?hi).*\%r15,-(([0-9]{2}|[3-9])[0-9]{2})
-		      (?:\(\%r15\))?$/ox;
+		$re = qr/.*(?:lay|ag?hi).*\%r15,-([0-9]+)(?:\(\%r15\))?$/o;
 	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
 		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
 		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
-- 
2.42.0

