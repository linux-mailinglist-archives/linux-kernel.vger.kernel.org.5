Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6998A7E9034
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjKLNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjKLNZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:25:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2AD478C;
        Sun, 12 Nov 2023 05:24:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E18BC433C8;
        Sun, 12 Nov 2023 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795475;
        bh=N8F+UNs1y/mpoVrN2/uzh1+/O7lddratvYI+aRdOius=;
        h=From:To:Cc:Subject:Date:From;
        b=NJ60NhNY6oqCVuuuCRKOGvwM3E5ZaPwDNRpWn+F6+r1uos5OVE0I1Eb8izcMmPWG3
         ndytMa4WoMRfAW/JO0Rjho75x1tfPmmbLmXc5WHsn8Cf5xFJYKnTmlkEtNL+2Xxi5A
         hXrltEO25U2NuOnic/CRYjdUG1r1Qqu+8NziBzf0Dcny2sU4+JyzXU+2rDaqFLD2tk
         WwgeLPn4Fo+9y3AKm0qUyP78I8lsHX7rGlmC+ecrM38OsAycgU8OL/3u+BOA4M/NSa
         mEh6/SeeJxd0rSZno+TDUfHUjRVffY8l0NpIFWk+fSQWk6VQNh7AqAL5Q6V6wFXdRm
         +Mq9j1MtOgWDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, keescook@chromium.org,
        gustavoars@kernel.org, linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 1/4] i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler
Date:   Sun, 12 Nov 2023 08:24:21 -0500
Message-ID: <20231112132432.174680-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.138
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 45a832f989e520095429589d5b01b0c65da9b574 ]

Do not loop over ring headers in hci_dma_irq_handler() that are not
allocated and enabled in hci_dma_init(). Otherwise out of bounds access
will occur from rings->headers[i] access when i >= number of allocated
ring headers.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20230921055704.1087277-5-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index af873a9be0507..dd2dc00399600 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -734,7 +734,7 @@ static bool hci_dma_irq_handler(struct i3c_hci *hci, unsigned int mask)
 	unsigned int i;
 	bool handled = false;
 
-	for (i = 0; mask && i < 8; i++) {
+	for (i = 0; mask && i < rings->total; i++) {
 		struct hci_rh_data *rh;
 		u32 status;
 
-- 
2.42.0

