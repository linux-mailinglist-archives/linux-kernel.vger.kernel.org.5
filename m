Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC06675FCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGXQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGXQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:59:17 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F31720
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:59:06 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7025C2608C9;
        Mon, 24 Jul 2023 16:40:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D1B63260E24;
        Mon, 24 Jul 2023 16:40:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690216842; a=rsa-sha256;
        cv=none;
        b=x+7MPUw5fL6nA9cvVJkt8DgGQOGJSKQALb/Sy3/s4ZtEp8XqxtxOwlkFNFC0g7mVpzHPD9
        p/SIeGVXAEXuj5TU7edT4jK9bbbTgQulz4cl2DsbOi6HROtR1iDVOlADwq6JTk0JXvJSuG
        i7iNRkwJZ3+93pd7p8wSUf3tgj7Yw9yAMxquUBRpsnN1DpSgBuQULi91DsLETRGV4pwtMq
        AQAYCTFMWHPiBW3wna54wiU3vKXu0DAvq8SCC98yvGyfMXQub294NfrShm3xv2Oh99Lwz2
        Xe8bkr2Bjz9Dyra6He14tdMwM4H5d+6yR5lXqDKIM7MwGb5IZ7dfeKdOPRNFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690216842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=HI5HsAyIgbuNmMiHyUp0xoxfU/rB3qI9Rdr7rFs4fLE=;
        b=4a9S2fDIi5ZbHHspd2mW5aekQ//ItZeEPKkZXft6eOVupAt4jTdN2l21wEiBnuN8TB8Bs0
        Pq1AUw/MVpORzaLHB9V2miDc7JdidSGNTx9c8zJKjO6nkGmRUSoC+5TZ/nFC9wlO0MiDb3
        2ZK9Q9zocMawkyeVWSprAu5DChgn/ItwTJwM2M5eomUL5Rmfv0u5/BMOdT8Fsrkp2OcHET
        JM0I2ZjqGeb74YQ1Y40FmCvAXKjs0TQuIZVlv8RyIiDa304GHEl7JIFQe9mWPNS4LZpiZU
        IerZdPaGdpHc6VuAvSrdpy22+t21YBm9rEb+CWzlqkQpO3PogMd9l6hq430oWg==
ARC-Authentication-Results: i=1;
        rspamd-6879cb8ddb-9qh9b;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Tart: 7a3290322133fd1c_1690216843188_2113104553
X-MC-Loop-Signature: 1690216843188:627865133
X-MC-Ingress-Time: 1690216843188
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.229 (trex/6.9.1);
        Mon, 24 Jul 2023 16:40:43 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4R8mB22kjcz5h;
        Mon, 24 Jul 2023 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690216842;
        bh=MsTwLuEDgc+9UD2cicB1Bz4PLB23R0GxMlz+NEeMIsQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=A8b07ODsq2WLaTolQ1okm2fdkW6KLSeuT3eV58lwXV3wtP5wuJBfqpKFzZBllNvYm
         bJLYZX1yTXKpz4e/Cq23N+f2pJAY0Js7+52YJxdyxHhfdVhPLIMI2m+od1CNgvki5w
         hVoolFHimXAeD2K3Ck2L7WKHLPw/+9vbLFgPnYiKk9cpGE9BMQn8Q5OowzAbWFQTOo
         fElx8l4O8l3gNIvkiwpXwRh57Y3v1kEQn6psv9nTRold5S4UXc2hTSEk5s0v8dOE/3
         EwWIV8YVaej2Uekdr4qDutYJAfd4giqeI9wEYyloN8zLqBlXmPLb9P0FDou86JQWRI
         eaKE4vMcWOQlg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH] rcuwait: Add might_sleep() annotations
Date:   Mon, 24 Jul 2023 09:03:36 -0700
Message-ID: <20230724160337.20851-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... as with regular waitqueues.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 include/linux/rcuwait.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 27343424225c..c0fcac903d03 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -74,7 +74,10 @@ extern void finish_rcuwait(struct rcuwait *w);
 })
 
 #define rcuwait_wait_event(w, condition, state)				\
-	___rcuwait_wait_event(w, condition, state, 0, schedule())
+do {									\
+	might_sleep();							\
+	___rcuwait_wait_event(w, condition, state, 0, schedule());	\
+} while (0)
 
 #define __rcuwait_wait_event_timeout(w, condition, state, timeout)	\
 	___rcuwait_wait_event(w, ___wait_cond_timeout(condition),	\
@@ -84,6 +87,7 @@ extern void finish_rcuwait(struct rcuwait *w);
 #define rcuwait_wait_event_timeout(w, condition, state, timeout)	\
 ({									\
 	long __ret = timeout;						\
+	might_sleep();							\
 	if (!___wait_cond_timeout(condition))				\
 		__ret = __rcuwait_wait_event_timeout(w, condition,	\
 						     state, timeout);	\
-- 
2.41.0

