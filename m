Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAE7F2A96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjKUKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjKUKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:36:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9D138
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:36:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1583C43391;
        Tue, 21 Nov 2023 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700562993;
        bh=Br1SkmNs2wmxWtCfzlRvkihDMx+ev4HQgVz58LlvuJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqM9ioDnWDYdrf47n7Fr+BtuSZC4Gg/CsWiMHkyqPmowW5WVa/Ramv6XL7VXoQvjd
         2Vv8xGBifzOwiM2JapDt2wMFF6AarpQtr9G5AAuDYM1zsbaRo7tUhRtpbMrDtfprMG
         dKEkkfct6vdxIhhrZ8m/3fm72yeTiAqEtPsTgQdKQif6cEnhh6CRrIsm6mLjqZaRjq
         3bK4LCrSBYOauRyZSTZLAUoAD6HUrRzradOR604vaD+TZOCmtLzMuoJ2mzJlhoxBq+
         n/y9/z0YPsAuhrKn+o/wGZFe1FoCMEGwKjux/V3uNQXhTpa1eU31k/4U9IdckLiqt5
         RVCYBp9a68BLw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 1/6] tty: con3215: drop raw3215_info::ubuffer
Date:   Tue, 21 Nov 2023 11:36:21 +0100
Message-ID: <20231121103626.17772-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
References: <20231121103626.17772-1-jirislaby@kernel.org>
MIME-Version: 1.0
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

clang-struct [1] found raw3215_info::ubuffer unused.

It's actually not used since 2004 when we switched to kernel buffers.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 99361618c31f..34bc343dcfcc 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -89,7 +89,6 @@ struct raw3215_info {
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
 	struct timer_list timer;      /* timer for delayed output */
 	int line_pos;		      /* position on the line (for tabs) */
-	char ubuffer[80];	      /* copy_from_user buffer */
 };
 
 /* array of 3215 devices structures */
-- 
2.42.1

