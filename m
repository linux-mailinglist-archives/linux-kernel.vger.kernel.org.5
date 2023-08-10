Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E3777A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjHJOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJOV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CB26BA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AEDE65D8C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4ADC433C8;
        Thu, 10 Aug 2023 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677288;
        bh=tTqvGfdqpSqLF9l0SW+6nk+RpKMVxa+ONkZwfa69O+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfRgllDuDt4/G7hW7Rt7G8F0kIsNIKHptUqki5KgQAyrb/TdOBdoRpWfkGQz9gxBZ
         M2dIFm02TYsFvPuXBh7YVae2IssCtAMCLTifuDsgpN8UJ3uy/SByvMeVthjYPJMtmx
         HvBaRyC1utACwGZFIEDFmh/KNugNfI+C+Aa3npPuh4ZUsMr69Ermh+zWoizy+nTVR4
         PXsfmwtLRy+Iv50hRS0M2CYugo9wThGn75cOzX4iE64Zasev+yHPCOg99fNAOYNe/2
         Qt94rXS3aWIw0tndDDXDQdGr8Wnm2PU6ocX5kUQrn7fQzPb/nQ1Xf8LxidEO09YR4b
         tPfaQ5Yzitb+w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/17] [RESEND] ida: make 'ida_dump' static
Date:   Thu, 10 Aug 2023 16:19:21 +0200
Message-Id: <20230810141947.1236730-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is no global declaration for ida_dump() and no other
callers, so make it static to avoid this warning:

lib/test_ida.c:16:6: error: no previous prototype for 'ida_dump'

Fixes: 8ab8ba38d488 ("ida: Start new test_ida module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_ida.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index b068806259615..f946c80ced8b6 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -13,7 +13,7 @@ static unsigned int tests_run;
 static unsigned int tests_passed;
 
 #ifdef __KERNEL__
-void ida_dump(struct ida *ida) { }
+static void ida_dump(struct ida *ida) { }
 #endif
 #define IDA_BUG_ON(ida, x) do {						\
 	tests_run++;							\
-- 
2.39.2

