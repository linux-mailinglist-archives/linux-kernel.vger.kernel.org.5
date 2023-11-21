Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F37F28BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjKUJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKUJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FE184
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EF8C433CC;
        Tue, 21 Nov 2023 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558591;
        bh=Qlx9viffecoULgm507HOr5Qx31VBXtpcn9Bhu0b34Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFn/ZE2n+WBA7LzQvXL2q7Gw+jjgjE6FrzYMD4rVEbwMWYrBxPRttH5nRe3UCpSHd
         C2lKTTJ9INTa+OueAOy/ivf9zQaB/8xWw+2b+cVZmw9xDKU9D4IvDmiaGi3XM9mkuB
         /YXvL1iYbUUxCqQFNZAq33TKIWGw161dxWdCt3PCTL5H9CQkyDlMivh1As723X0cN1
         vDTjQ9VE84Vn5e3/2rV3GTcr+kPqvohyxr+izf7e+kwmu93pqFbkpB3GsdOmcV7BS+
         mwlXNnndw+09YmvSx2Y1Oj1pU+IJv9PaNpUpeHilEJ+2rg9JTal6QfuquBrr4pjhCI
         KnZ3/mApPmwgA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/17] tty: amiserial: return from receive_chars() without goto
Date:   Tue, 21 Nov 2023 10:22:46 +0100
Message-ID: <20231121092258.9334-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

The 'out' label is just before 'return'. So return immediately and drop
both the label and the return. This makes the code more straightforward.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/amiserial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 785558c65ae8..b9580bb9afd3 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -230,7 +230,7 @@ static void receive_chars(struct serial_state *info)
 	   * should be ignored.
 	   */
 	  if (status & info->ignore_status_mask)
-	    goto out;
+		  return;
 
 	  status &= info->read_status_mask;
 
@@ -258,8 +258,6 @@ static void receive_chars(struct serial_state *info)
 	if (oe == 1)
 		tty_insert_flip_char(&info->tport, 0, TTY_OVERRUN);
 	tty_flip_buffer_push(&info->tport);
-out:
-	return;
 }
 
 static void transmit_chars(struct serial_state *info)
-- 
2.42.1

