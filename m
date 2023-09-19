Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957257A5CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjISIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjISIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B97E6;
        Tue, 19 Sep 2023 01:52:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89483C433CA;
        Tue, 19 Sep 2023 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113525;
        bh=BIErATDceY6ExeUaCulU3mr2Dddd6kPOEIhHuMduq7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0QlOdvLfDUG8c/J1j+tD/EWzkI7Z/KLetbEN00n/upp8pJ9V8mrpZrpEaydJ6nzB
         yUYBQNmSOqcvAtzYd4LpOkisNbPe/M+B99MV/l7TCUnxWBV9AixJb8xI2g7CTk8glu
         WDMlZGcBMnPDzxcZi14FVknzyfyP/l1IXJtUrBIRtJkJH57XzJYOURyOOD3IhwPFT8
         qGjpXnEsGGDWeP1qAuQZNWLZckWmEF6OIJyWBryteWHtnwX6h1jzoPQSPFf5QGyZJq
         lqEZJe2FBvUfap+golpuqzH3MiA4UXxkAuhZm0qnYIRagieNDBXJTwAYnWKnpOntD6
         xwaOmK06NhrAQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/15] tty: n_tty: invert the condition in copy_from_read_buf()
Date:   Tue, 19 Sep 2023 10:51:45 +0200
Message-ID: <20230919085156.1578-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
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

Make "no numbers available" a fast quit from the function. And do the
heavy work outside the 'if'. This makes the code more understandable and
conforming to the common kernel coding style.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6a112910c058..922fb61b587a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1966,24 +1966,26 @@ static bool copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
 	size_t tail = MASK(ldata->read_tail);
 
 	n = min3(head - ldata->read_tail, N_TTY_BUF_SIZE - tail, *nr);
-	if (n) {
-		u8 *from = read_buf_addr(ldata, tail);
-		memcpy(*kbp, from, n);
-		is_eof = n == 1 && *from == EOF_CHAR(tty);
-		tty_audit_add_data(tty, from, n);
-		zero_buffer(tty, from, n);
-		smp_store_release(&ldata->read_tail, ldata->read_tail + n);
-		/* Turn single EOF into zero-length read */
-		if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
-		    (head == ldata->read_tail))
-			return false;
-		*kbp += n;
-		*nr -= n;
-
-		/* If we have more to copy, let the caller know */
-		return head != ldata->read_tail;
-	}
-	return false;
+	if (!n)
+		return false;
+
+	u8 *from = read_buf_addr(ldata, tail);
+	memcpy(*kbp, from, n);
+	is_eof = n == 1 && *from == EOF_CHAR(tty);
+	tty_audit_add_data(tty, from, n);
+	zero_buffer(tty, from, n);
+	smp_store_release(&ldata->read_tail, ldata->read_tail + n);
+
+	/* Turn single EOF into zero-length read */
+	if (L_EXTPROC(tty) && ldata->icanon && is_eof &&
+	    head == ldata->read_tail)
+		return false;
+
+	*kbp += n;
+	*nr -= n;
+
+	/* If we have more to copy, let the caller know */
+	return head != ldata->read_tail;
 }
 
 /**
-- 
2.42.0

