Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABC7D1726
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJTUiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJTUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:38:53 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B6C0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:38:50 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8561E60A;
        Fri, 20 Oct 2023 20:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8561E60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1697834330; bh=LvqzsKrogBPLWtwDR0EhP9713sN3hW79CcKzrRif0MU=;
        h=From:To:Cc:Subject:Date:From;
        b=FZ+6YTW/OTdsweXd+r3WaHyCLCL+kvHQbSKgnkgb0KxkuHJmBNppkyQamBpnAC1rz
         CrxERQu99emWm7KHuY+pl9QWmrcaONM32zbxx2qUFpBzG2WFWxcsbDXUfd9ZTCn3Qh
         kxVsYV54qOGsas7/jJvjmj+GtJEGIjcRTdFCfQHCIzc15ilNnnReWW0usHIeJbmiAU
         hmB5DEc4Dyd7mW4ssYPnzVW2zLev7TmulsSdGLQSjL3TUQd+uUFs9R28CYOqCyiCC/
         tfZ6K4fi+SSPMtmccFzDKr5fzeDe3vWN7yNQUsLjO/tVaHJNfsIhe3azYqa3jB88WO
         XE+xrIZC4IzJA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] seq_buf: fix a misleading comment
Date:   Fri, 20 Oct 2023 14:38:49 -0600
Message-ID: <87pm19kp0m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for seq_buf_has_overflowed() says that an overflow condition is
marked by len == size, but that's not what the code is testing.  Make the
comment match reality.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/linux/seq_buf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 515d7fcb9634..026302765494 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -39,7 +39,7 @@ seq_buf_init(struct seq_buf *s, char *buf, unsigned int size)
 
 /*
  * seq_buf have a buffer that might overflow. When this happens
- * the len and size are set to be equal.
+ * len is set to be greater than size.
  */
 static inline bool
 seq_buf_has_overflowed(struct seq_buf *s)
-- 
2.41.0

