Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20D798D02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbjIHSTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbjIHSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B232718;
        Fri,  8 Sep 2023 11:18:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7BEC32774;
        Fri,  8 Sep 2023 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196996;
        bh=FU1lqmmuZW2SGaZg71bx0OH1zvUJpmq4tL2t7nuLsQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUQ1R8PprR6dT+Oa2LGT/yat693BUnlICASNNySvutIFifQ1/iXoZGCKCgZ5mCjyU
         U5yC6EY5JNGFjTjGqPXLE+RrVxGqahkMEe7grb5PCNCQTbmy/3zJCqmb63M6TkB7op
         YCqyaLyUfxI8ZLr8Ioiqud3yo6grrICdY+LKMqhaBcNNRqIt1vGgMiW8hTgE5F3mSA
         +Orc0Hg/xjzdsZtu05qIFqeSv0rr8QAncjDCuXLyizlwc82BobY+qwCQisEwzY1ffR
         Yae3I4qCb1rAIwKkQls13MhF5+h+4xKESaZxkEFxVANKC6MCXPDJsfeLWSV0C184fs
         j00t6iz/OYX5g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 14/41] wifi: ath12k: Fix a NULL pointer dereference in ath12k_mac_op_hw_scan()
Date:   Fri,  8 Sep 2023 14:15:28 -0400
Message-Id: <20230908181555.3459640-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 8ad314da54c6dd223a6b6cc85019160aa842f659 ]

In ath12k_mac_op_hw_scan(), the return value of kzalloc() is directly
used in memcpy(), which may lead to a NULL pointer dereference on
failure of kzalloc().

Fix this bug by adding a check of arg.extraie.ptr.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230726092625.3350-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 58acfe8fdf8c0..4cae50c396486 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2752,9 +2752,12 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	arg.scan_id = ATH12K_SCAN_ID;
 
 	if (req->ie_len) {
+		arg.extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
+		if (!arg.extraie.ptr) {
+			ret = -ENOMEM;
+			goto exit;
+		}
 		arg.extraie.len = req->ie_len;
-		arg.extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
-		memcpy(arg.extraie.ptr, req->ie, req->ie_len);
 	}
 
 	if (req->n_ssids) {
-- 
2.40.1

