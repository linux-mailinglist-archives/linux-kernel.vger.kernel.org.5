Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A777DFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbjHPK7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjHPK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B4269E;
        Wed, 16 Aug 2023 03:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53BCB665C0;
        Wed, 16 Aug 2023 10:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A459BC433CD;
        Wed, 16 Aug 2023 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183511;
        bh=yNpilYb6nvSQBFaf1Q2HhB1yiFiHFUihCQbVC837jRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXZKDnke8YPV4L/5Sg6ATqj0uhgwWkgynBiplScG00iQQmgSWbiS+1b4e4WGKksUW
         Cd0Vgyf/2aoFVORJA4RrnjiGPOesfIKP84RRyL/AMRjWg2J0owdI7oHPHtzev7d4Xd
         UE6M/IqZNluHU8CP327O6zelKZ05DSNKO1Pn8+7KFWBphRSZ+Ih+yN/OrEvSdFl6BE
         oI3tlqble7GnYCNVIiyw6vK2aQBN/DJKgkeHiLX31adWeDppHZTVlSCBaRBVtn/UDf
         553e/J0V5RTvoN2aGrV3aaSJg3ivBejpxYKIDlVEzdJg77JWTXmhH6tbHO5WyrBWzw
         wj86En1V9k2JQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/14] tty: n_tty: use output character directly
Date:   Wed, 16 Aug 2023 12:58:08 +0200
Message-ID: <20230816105822.3685-5-jirislaby@kernel.org>
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

There is no point to use a local variable to store the character when we
can pass it directly. This assignment comes from era when we used to do
get_user(c, b). We no longer need this, so fix this.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8b2bacb3e40d..f6fa4dbdf78f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2373,8 +2373,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 				nr -= num;
 				if (nr == 0)
 					break;
-				c = *b;
-				if (process_output(c, tty) < 0)
+				if (process_output(*b, tty) < 0)
 					break;
 				b++; nr--;
 			}
-- 
2.41.0

