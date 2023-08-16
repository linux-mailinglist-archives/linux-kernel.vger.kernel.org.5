Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4077E19C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbjHPM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245297AbjHPM2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:28:24 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF3270E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:27:57 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RQnTH60S9zBZ;
        Wed, 16 Aug 2023 14:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692188851; bh=ZoZ74Qt7gAfxTdmWNwTdEhvWfKZGk4ZFTxTG8dPs4zA=;
        h=Date:From:Subject:To:Cc:From;
        b=pV9Jn9RXX6WjAGPqgR4EUTdzAOuRu3DC5xsMjZbZlocF4y4liLkPh88mB4hbAfm3q
         F9ZZZ1tSUMK4Im9KwB9Hk90lnyTHSQ70gJt7z096lXJE6XzAJpiIqHdsSM789vLnb0
         yJ+zA74YnhWIdijH7kcNo4EoxIxnjdPmF6M8K+kArqlYUEbUNHt27lUkYF8V8NB2EQ
         nuTnhWEN2YdXeffNy6ud6+7Yphb1ZDllT62dhcA9I17KkQC01LfCgJuqj9uJ4WoIK/
         ZrkhwM0cylGg2t/cCQuB9ThGrmsb2NnNSv7gbLSpmcSYdwyGF6RcKm3SsXyvoLU/4m
         0N9OR/8gXoF+A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 16 Aug 2023 14:27:31 +0200
Message-Id: <aa8de668f39f76c98e443c7cce2834e813807111.1692188782.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mfd: core: Un-constify mfd_cell.of_reg
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_reg is the only constant member of struct mfd_cell. It seems to be
accidental and prevents dynamically filling in mfd_cells that use of_reg.
Remove the `const`.

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 47e7a3a61ce6..e8bcad641d8c 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -92,7 +92,7 @@ struct mfd_cell {
 	 * (above) when matching OF nodes with devices that have identical
 	 * compatible strings
 	 */
-	const u64 of_reg;
+	u64 of_reg;
 
 	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
 	bool use_of_reg;
-- 
2.39.2

