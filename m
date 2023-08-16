Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9F77DFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbjHPLA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbjHPLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689E2D61;
        Wed, 16 Aug 2023 03:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBC74665B9;
        Wed, 16 Aug 2023 10:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B6C433C9;
        Wed, 16 Aug 2023 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183519;
        bh=4VZ2evVSvUAzXqtmvQJZAhVFIJnE/OW4U6dWFy5R8X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7UiGgL4LwqR9DTYlgC5CnjHosHnly96ni4yenkymp3FX1B3glAii+AIveeTJBZw4
         pxHW/BTixP4b53eC0f/+WjY5+DCwceg4lPFBe58hrjU15knpJChX4o6dIWDUbRN3az
         9k9bivPInG17tCrRBzjROgYgyW3UK9SIBxeSc6cGMnTMY0/xewagAR90DxS2qXLfLn
         eMcfkZuwaOz2+qneHYD+njpoafowS+rGOU8NQjbw6xYEEAfqGShH3CIHRzx8CLT49O
         pcoUH2FjXzqYV1WlWahLOHBnNbEAWwchbKT4t914Xoh31PSdySduePKYKlpuhq6uIJ
         +VfI6IlMz2cXw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/14] tty: n_tty: make n_tty_data::num_overrun unsigned
Date:   Wed, 16 Aug 2023 12:58:13 +0200
Message-ID: <20230816105822.3685-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
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

n_tty_data::num_overrun is unlikely to overflow in a second. But make it
explicitly unsigned to avoid printing negative values.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 996cad23e385..0b6eeeb94920 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -99,7 +99,7 @@ struct n_tty_data {
 
 	/* private to n_tty_receive_overrun (single-threaded) */
 	unsigned long overrun_time;
-	int num_overrun;
+	unsigned int num_overrun;
 
 	/* non-atomic */
 	bool no_room;
@@ -1174,7 +1174,7 @@ static void n_tty_receive_overrun(const struct tty_struct *tty)
 
 	ldata->num_overrun++;
 	if (time_is_before_jiffies(ldata->overrun_time + HZ)) {
-		tty_warn(tty, "%d input overrun(s)\n", ldata->num_overrun);
+		tty_warn(tty, "%u input overrun(s)\n", ldata->num_overrun);
 		ldata->overrun_time = jiffies;
 		ldata->num_overrun = 0;
 	}
-- 
2.41.0

