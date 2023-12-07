Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD88D8087A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379286AbjLGMYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:24:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661984
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:24:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF1EC433C9;
        Thu,  7 Dec 2023 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701951891;
        bh=2ZR+kigljAxSl58nJM12epcTWpUT3EwzyZmGVK5BV0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgCn5Q3VA3LT1K6iXAET4r2lgCmTVbPKIgpsN5m7PXaAUE9G4hYeTM+yPGLxb/Gqh
         Y82JJg8TTayqXcZuAkUmmKr1H52LHNawylDl1lsx3yg/wAFxQX6aS72ksJ12QvGDd9
         bwRkogLyA4gczF6i4/JF0iIFQhkQyxlwjSaWIVBHfrwzTBcLoNt5RigCS4OlGryW52
         9vCOoVVStP4YTHZFRwUsV/FfzYqutXQop4oGH1YcY4sR/ozD3lKll667ShU/dvIUoa
         yL7Atea3P2aNtfvOzLcLQz5010Moto/bkqI9dU7VE/36L7/q7D0D19ISrL9QkEpk1a
         BhOyj+G4EpuHw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/5] accel/habanalabs/gaudi2: add zero padding when printing QM CP instruction
Date:   Thu,  7 Dec 2023 14:24:41 +0200
Message-Id: <20231207122444.50512-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207122444.50512-1-ogabbay@kernel.org>
References: <20231207122444.50512-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

QM instructions are in multiples of 64 bits and the command type is in
the upper bits of first QWORD.
To make it clearer that an undefined command is due to a type of 0x0,
always print all 64 bits and add a zero padding if needed.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index bf537c2082cd..f81b57649b00 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7884,7 +7884,7 @@ static void handle_lower_qman_data_on_err(struct hl_device *hdev, u64 qman_base,
 	cp_current_inst = ((u64) hi) << 32 | lo;
 
 	dev_info(hdev->dev,
-		"LowerQM. %sCQ: {ptr %#llx, size %u}, CP: {instruction %#llx}\n",
+		"LowerQM. %sCQ: {ptr %#llx, size %u}, CP: {instruction %#018llx}\n",
 		is_arc_cq ? "ARC_" : "", cq_ptr, cq_ptr_size, cp_current_inst);
 
 	if (event_mask & HL_NOTIFIER_EVENT_UNDEFINED_OPCODE) {
-- 
2.34.1

