Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832037DB06E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjJ2XG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJ2XF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:05:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D71731;
        Sun, 29 Oct 2023 15:59:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74D3C116B7;
        Sun, 29 Oct 2023 22:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620399;
        bh=CJqlyIhB/xA4mTuuYRBU2/HCHTC5X8HdZJoiM/AgBcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSdNN91aRfkQSwhBpjzOsxXVxvKRtGlC4+iMXngm+YEjLtL2Fs/hb9Xyjt0N9G2t7
         nkqulQrCMY62/bj1gsVcMnw77Hbu+jmbaQ+3o0gLTqGIPA9O0ZD4ZRbwlU/Re6Z7T6
         7wUiESwASBw9FoS4IKiPt2L6HoAWXUGzax01d1VU9nQblDO4A/98sJFo3AmWpnlueO
         Nh9baiHZJkI0rNM7v4DcD2JSPr96+zripMzQ4AM1LC3qdSioNGcipWE1MkczxuK293
         nrUyohQ8LMjOIWxUj7ouvw49qCqQkurlWUrBLU/3NX/GA1ojRlgH0iZMhnexeMKYhA
         ftkPeqBZZZfQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, welsh@cassens.com,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 27/28] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date:   Sun, 29 Oct 2023 18:59:02 -0400
Message-ID: <20231029225916.791798-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 ]

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 65172a654a198..19a61cddb56d2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3307,7 +3307,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.42.0

