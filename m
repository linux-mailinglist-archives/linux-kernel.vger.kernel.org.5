Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7977742A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjHJJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjHJJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742122D5D;
        Thu, 10 Aug 2023 02:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E68654D7;
        Thu, 10 Aug 2023 09:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6803AC433C7;
        Thu, 10 Aug 2023 09:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658963;
        bh=qhZ+8g/mVeww1/sDpRrBj/HZogkEpBzYC4tIKMW7d8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQqjRSkffBAhnbZFGqB7ZOsl3VZvb6kihwWvFaB8wjTmp312MrusAY5mlUQy6zGiy
         tyuHfCmuiD/CInSjngxC/tDDmBOVDWCovm3s+nEurCW8xd1yIhaNV8tcGtY/kW4Zs6
         lf5d+1jx3lsAKlTbJubMQZQxaX7Jg7jLTd/O/wZQAYruyc39Z/aFjtss0PCOBCAw9W
         CaFj8ZRYZQyjtV0ly7faDHT/C9T94ctI5E24ool518IMCczxEkAvhbPHNDdXhwXWh5
         ynvslIIhPC/EbRT0MuKtJztLUxy45HuQMrwyMSnJ2SIlyHe9JsjQsfZzMJGRhsSOdj
         HhLE/o9VsR1oA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 20/36] tty: tty_buffer: make all offsets unsigned
Date:   Thu, 10 Aug 2023 11:14:54 +0200
Message-ID: <20230810091510.13006-21-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
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

All these are supposed/expected to be unsigned as they are either counts
or offsets. So switch to unsigned for clarity.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_buffer.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 391a875be20c..e45cba81d0e9 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -12,11 +12,11 @@ struct tty_buffer {
 		struct tty_buffer *next;
 		struct llist_node free;
 	};
-	int used;
-	int size;
-	int commit;
-	int lookahead;		/* Lazy update on recv, can become less than "read" */
-	int read;
+	unsigned int used;
+	unsigned int size;
+	unsigned int commit;
+	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
+	unsigned int read;
 	bool flags;
 	/* Data points here */
 	unsigned long data[];
-- 
2.41.0

