Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5E77DFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbjHPK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243950AbjHPKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1213E;
        Wed, 16 Aug 2023 03:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1683363FBB;
        Wed, 16 Aug 2023 10:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A750C433C9;
        Wed, 16 Aug 2023 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183336;
        bh=rtvLwjn0+HFhIw5kcAsqn47YQB2JGor/QQpglZNQ9tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jC0W+wWJkaOWqIbHWSW6Y4kUN+1oTd+M02FRGAiS0Ldxkja9Kxph2XDww81mVBbFA
         3XwOv9EV0NoInFjgnLV9wM92Rtzp0roWIIfQoMM89WJhJ5wH9qorFAarPdtJpq/JVw
         kTmgZiPtFhF96vhq4kBYa/7Z62qLrltVYEAhnqEP9IB1pp3OBBnlieypUb51Fms8JN
         kn/3VD1EHovoxyH3d9fIL+qq6avcLP3mm580Sdg0VqQMk4NTb8Riu6yotEI0kW1ekx
         QN8DDNFT1bFYWzX9xyt6vfUFoYiKJF0GOfbxIfyqO0HthCHzYs2NcXAUYNGzamxbW8
         gLSylhT1aAktg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/10] tty: tty_buffer: use struct_size() in tty_buffer_alloc()
Date:   Wed, 16 Aug 2023 12:55:22 +0200
Message-ID: <20230816105530.3335-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that tty_buffer::data has the right type, use struct_size() for
size calculation. struct_size() makes the code less error-prone and more
readable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 684d099cbe11..c94df1a2d7f8 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -177,8 +177,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	 */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
-	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
-		    GFP_ATOMIC | __GFP_NOWARN);
+	p = kmalloc(struct_size(p, data, 2 * size), GFP_ATOMIC | __GFP_NOWARN);
 	if (p == NULL)
 		return NULL;
 
-- 
2.41.0

