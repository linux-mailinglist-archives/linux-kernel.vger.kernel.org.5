Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3A7EC8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjKOQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjKOQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADD98E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF136C433C8;
        Wed, 15 Nov 2023 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066364;
        bh=gfk8zALZbdkLMNgU9Gvg6x8rMFGs5nttVZo1WOrF8z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1sPNITGGaeCwOfznhyoXmKJGEFd0tZ++yksjkpidz9p2R/pI7A2/vyZIT56zhhQl
         H2Zu9ECdXB+0ViFFD6rL81ZhRKBUQZyPJH+TRGJd0uykgthPOEZQoH4pkqwp1OgRO8
         eYlBs17wIOYFJLxu3w1XbQdFeHSizwRRIevYRVRgGJ//mZ4V8jxK8KU7JV/vsSeZTb
         URJPS9RZMjJLmAgylqCEozfgTL0d/2w3DOcTaTRb/MK3jaEUlXJkdguHa2E+ZApntr
         tMVIhYfRW36fi9h6gfZaDTvrREzef+uaBCG6JSDvqYshritwA52uQ5OjRT9PMK+uf9
         VCIgX3hpVyDsQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 05/10] accel/habanalabs/gaudi2: fix undef opcode reporting
Date:   Wed, 15 Nov 2023 18:39:07 +0200
Message-Id: <20231115163912.1243175-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

currently the undefined opcode event bit in set only for lower cp and
only if 'write_enable' is true. It should be set anyway and for all
streams in order to report that event to userspace.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index b739078c2d87..5075f92d15cc 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7929,21 +7929,19 @@ static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, u16 event_type
 				error_count++;
 			}
 
-		if (i == QMAN_STREAMS && error_count) {
-			/* check for undefined opcode */
-			if (glbl_sts_val & PDMA0_QM_GLBL_ERR_STS_CP_UNDEF_CMD_ERR_MASK &&
-					hdev->captured_err_info.undef_opcode.write_enable) {
+		/* check for undefined opcode */
+		if (glbl_sts_val & PDMA0_QM_GLBL_ERR_STS_CP_UNDEF_CMD_ERR_MASK) {
+			*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
+			if (hdev->captured_err_info.undef_opcode.write_enable) {
 				memset(&hdev->captured_err_info.undef_opcode, 0,
 						sizeof(hdev->captured_err_info.undef_opcode));
-
-				hdev->captured_err_info.undef_opcode.write_enable = false;
 				hdev->captured_err_info.undef_opcode.timestamp = ktime_get();
 				hdev->captured_err_info.undef_opcode.engine_id =
 							gaudi2_queue_id_to_engine_id[qid_base];
-				*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
 			}
 
-			handle_lower_qman_data_on_err(hdev, qman_base, *event_mask);
+			if (i == QMAN_STREAMS)
+				handle_lower_qman_data_on_err(hdev, qman_base, *event_mask);
 		}
 	}
 
-- 
2.34.1

