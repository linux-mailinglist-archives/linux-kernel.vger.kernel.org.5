Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB117F4459
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjKVKxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjKVKxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:53:49 -0500
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE992
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IRLAbCze70rcXY5T2JejioYRFHEx7GCXD/81d6GGbbM=; b=FvukDxAYqR4gFcEGZzhrPO/6UT
        gpeCGrfjPsr0DCjdwGwCOeRoBrD9L8ZUrSSH2xuZRTnk7IeKBj5dJDiBD3w/xp76viNt53vYs9jTW
        R8lT/5V3cgKru10etZo33jlZ8Q2DRztTD8JC65NcR5FZAAkmbPuHZlqkaqvvrr4ve/m5HdgPltCwc
        jZlGHgBcKkURbY4jQJdXZa/HovfgaNPz9WuuCkoWkt6uc6JbIpZjXS4eQy+oKZm1251qAweCThdPq
        PUhq0oZ1F32pY75cxyBKgtSs/QlFcn1yBITKmXJjploVQ4pKkxjmxQeGMPZBuDJPxBp78WHuoyNxD
        llbDax2g==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r5krT-004Fjf-KJ; Wed, 22 Nov 2023 10:53:40 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r5krT-000000014q4-36Zv;
        Wed, 22 Nov 2023 10:53:39 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] lockdep: make variable check_consistency static
Date:   Wed, 22 Nov 2023 10:53:36 +0000
Message-Id: <20231122105336.256919-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable check_consistency is not used outside of this
file so make it static to fix the following sparse warning:

kernel/locking/lockdep.c:1148:5: warning: symbol 'check_consistency' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad3e206..73aeee69ebd1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1145,7 +1145,7 @@ static bool __check_data_structures(void)
 	return true;
 }
 
-int check_consistency = 0;
+static int check_consistency = 0;
 module_param(check_consistency, int, 0644);
 
 static void check_data_structures(void)
-- 
2.37.2.352.g3c44437643

