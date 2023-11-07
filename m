Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46E7E4D36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbjKGX0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjKGXZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:25:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBD19B2;
        Tue,  7 Nov 2023 15:24:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A4FC433C9;
        Tue,  7 Nov 2023 23:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399465;
        bh=LJ8eOtrvRqn2MCoxinBi1DcpeWZNt4KNVmzOoxSfNfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amUiar8+RLUEcz7lvuJ9Ckf0T1DwDkgHVs3ZqT3C5a+Ozjt8Q4XCmH+vt2ElE7zTT
         mk2PJb3BcCBwQSyxadgDcJYWaHpVBFSxb2QL2DNdgyPjju7G1ZUODy5gxrbhGvT0td
         j8GAqdT8Qx7EWac/cO4Tns/+6tURHjAW69BCeW+sfelzds7tZ/sHLr/8kJvTXgMpFR
         pqWHlp2ABSMmR2fNXcjgR4sdOdeoGNTvRTocaqjWutBAKDJ4sJwrzQyo7+OnzZJR2Z
         qs23KH72cVNAM2pG6iOLmGWMAebthIVX3ZV8ezQRoja7SjLBS3kxdis7gaOoQg4A4y
         wmtifALDN8wYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/11] thunderbolt: Apply USB 3.x bandwidth quirk only in software connection manager
Date:   Tue,  7 Nov 2023 18:24:03 -0500
Message-ID: <20231107232420.3776419-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232420.3776419-1-sashal@kernel.org>
References: <20231107232420.3776419-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 0c35ac18256942e66d8dab6ca049185812e60c69 ]

This is not needed when firmware connection manager is run so limit this
to software connection manager.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 8c2ee431fcde8..4ab3803e10c83 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -30,6 +30,9 @@ static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
 {
 	struct tb_port *port;
 
+	if (tb_switch_is_icm(sw))
+		return;
+
 	tb_switch_for_each_port(sw, port) {
 		if (!tb_port_is_usb3_down(port))
 			continue;
-- 
2.42.0

