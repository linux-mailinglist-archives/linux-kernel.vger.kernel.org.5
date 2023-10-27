Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2147D9CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbjJ0PZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjJ0PZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:25:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4D186;
        Fri, 27 Oct 2023 08:25:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D593C433C8;
        Fri, 27 Oct 2023 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698420322;
        bh=VROuko5K8q97+Xwgq8pAwl1aEf0SQdloFO2Kq63UPCM=;
        h=From:To:Cc:Subject:Date:From;
        b=FS1BPOe8kPw9vWm002m0NPlWlCIzQa1WXJIZaqIy2w4KexEWvx+qvn1cN/AcCD72X
         m/x4GMIiYQFdhqiFVkaTWM8dV+W0SQPvw2BU2N6qiN63Ahf2yK7FpzKvOHqxTfV7pi
         5VWZkD0yM44aHrzcnQroEPD7HZZBuSYRhomHmLcy1IvicwMuqx5K17D8WVLAwsxioV
         O9EKb3U5m1MO7rye7UpD+SOQaacVopt5hR/qjwtVcfkeQR/nvc3R7q72d60xlO6EIb
         hm/zUZBhHLIkWkO0vvaA6I9gZB5fxWwtCMwlE9l0B9z+TSrTXu4OQOx2x/XvJA4fPR
         m5KEhVIbL6LWQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: mark cs35l41_verify_id() static
Date:   Fri, 27 Oct 2023 17:25:09 +0200
Message-Id: <20231027152515.482411-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced function is global but only called in this one
file and has no extern prototype, so it should probably be static:

sound/pci/hda/cs35l41_hda.c:733:5: error: no previous prototype for 'cs35l41_verify_id' [-Werror=missing-prototypes]
  733 | int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, unsigned int *reg_revid)

Fixes: 881b7bce0c25 ("ALSA: hda: cs35l41: Run boot process during resume callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 496ff6a9d300..98a5123e9f50 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -730,7 +730,7 @@ static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsi
 				    rx_slot);
 }
 
-int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, unsigned int *reg_revid)
+static int cs35l41_verify_id(struct cs35l41_hda *cs35l41, unsigned int *regid, unsigned int *reg_revid)
 {
 	unsigned int mtl_revid, chipid;
 	int ret;
-- 
2.39.2

