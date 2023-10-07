Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E77BC781
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbjJGMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJGMcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:32:04 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02858B6;
        Sat,  7 Oct 2023 05:32:02 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 7B588100057; Sat,  7 Oct 2023 13:32:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696681920; bh=rOBP2wQ6cH9vnnvMHhphypU81Jp3mFXrC6UZzoQjoM0=;
        h=From:To:Cc:Subject:Date:From;
        b=Sni86AsxZpbp/gQsZjXdVg1Kfbm7X3sdEXxVaSyfEMbRG/TQuy6RYcur4DQC2aEXi
         X0WFwSC7pGUm/xMo4m+FRgCcvLt4K8vxYxWO24Vz9jtH3JTeEusNMEC1PvDeFXb9Xl
         ozn/WgdO0OQEMxt8rTYxruas4q7uf9yrHNeCJG/mgKIO+Fm6RSMe8X8ILQQlbFZYls
         FsP4sYl1isXqPHlPVpF5Pjvm0JYae231WfNWWf7C+r6GSmUE+9ml7QLt3MaX+dYAhF
         pNQ10rfmU+eRSBLy83rZfRIdd8xQMN4nLPyipAeC+6cH+1WFJUFllGWnW31LVxIAYG
         7u2U3EFH9HtHg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 73A04100057;
        Sat,  7 Oct 2023 13:31:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696681918; bh=rOBP2wQ6cH9vnnvMHhphypU81Jp3mFXrC6UZzoQjoM0=;
        h=From:To:Cc:Subject:Date:From;
        b=knqb0WvDFjlUdrIqLXQYEz9R4cp4vJmKBf9VZeoBP1US3ZpKfJ8Szl2aQzBG2Zrfg
         2RjU+SSaGhWTi8Fyv6YoC3Qx0UDJJDLsAw0NskJpN9dOmKtA1sSYTNaB+LpX8rh05F
         bi851ahx7PnWUK85tw6cYuC7NvTTiSPnfRbRll+qmx1J58A/W/L4z/QUmPKcHNNjoN
         qscw/GZxo6nSChatzvVa2LbK9YCkHG+Ni+CUILrBjyqG0Avnbdj/jcY9ED27p5+j4U
         IYvS/rMSlGhcdvz7D/j4XiDbpwb+Cn63aSa5vwwIj+GveDWwfhupdwstDLfcLlj79K
         Wvb1KCA851hOQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: lirc: drop trailing space from scancode transmit
Date:   Sat,  7 Oct 2023 13:31:33 +0100
Message-ID: <20231007123133.6718-1-sean@mess.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When transmitting, infrared drivers expect an odd number of samples; iow
without a trailing space. No problems have been observed so far, so
this is just belt and braces.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/lirc_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 043d23aaa3cb..a537734832c5 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -276,7 +276,11 @@ static ssize_t lirc_transmit(struct file *file, const char __user *buf,
 		if (ret < 0)
 			goto out_kfree_raw;
 
-		count = ret;
+		/* drop trailing space */
+		if (!(ret % 2))
+			count = ret - 1;
+		else
+			count = ret;
 
 		txbuf = kmalloc_array(count, sizeof(unsigned int), GFP_KERNEL);
 		if (!txbuf) {
-- 
2.42.0

