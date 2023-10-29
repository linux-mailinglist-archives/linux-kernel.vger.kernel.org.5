Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0F7DADD1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjJ2Spz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjJ2Spw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:45:52 -0400
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD72F4;
        Sun, 29 Oct 2023 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1698605142; bh=as9AeGM+ifzsnqtyzSQemv/snnZnIqMpieeTV1wu21Q=;
 b=RSmKmIdAgYUVUMoqCCVeFHEavSI11L44Ut2u7mb7J5MrDWPnRYEHjkpSVm25MVAUv34HwnIdX
 mmOFhHpU9aNGtPggPpIHNJpQvqOTKJQp1034JFLAUslLBc0pwHsK4h6XzKFIzOfFffLFV4qmx8W
 WIELfUHk1lI6ZY+3i3Gjn2c+4N/8XecQalhXgQRpLCXx4yDR3F41gSOHH2H8kZaoY+3LzQTetE+
 ummH5Q43VMFFH/sazb3Uw0jdiBNw3V8b5f6hl79JxtMEG+XuNrXMr/8cggOjZGXCC6cAp0+HMMQ
 BxJaQLbPY+RxTsihF1qXzrS3NXJMBd5A5rLWVdA5Dr2A==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 04/10] media: rkvdec: h264: Don't hardcode SPS/PPS parameters
Date:   Sun, 29 Oct 2023 18:34:11 +0000
Message-ID: <20231029183427.1781554-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029183427.1781554-1-jonas@kwiboo.se>
References: <20231029183427.1781554-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 653ea5c98fe0ffca230b0f3c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Bee <knaerzche@gmail.com>

Some SPS/PPS parameters are currently hardcoded in the driver even
though they exist in the stable uapi controls.

Use values from SPS/PPS controls instead of hardcoding them.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
[jonas@kwiboo.se: constraint_set_flags condition, commit message]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3:
- New patch

 drivers/staging/media/rkvdec/rkvdec-h264.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 7a1e76d423df..8bce8902b8dd 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -655,13 +655,14 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 
 #define WRITE_PPS(value, field) set_ps_field(hw_ps->info, field, value)
 	/* write sps */
-	WRITE_PPS(0xf, SEQ_PARAMETER_SET_ID);
-	WRITE_PPS(0xff, PROFILE_IDC);
-	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
+	WRITE_PPS(sps->seq_parameter_set_id, SEQ_PARAMETER_SET_ID);
+	WRITE_PPS(sps->profile_idc, PROFILE_IDC);
+	WRITE_PPS(!!(sps->constraint_set_flags & (1 << 3)), CONSTRAINT_SET3_FLAG);
 	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
 	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
 	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
-	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
+	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS),
+		  QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
 	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
 	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
 	WRITE_PPS(sps->pic_order_cnt_type, PIC_ORDER_CNT_TYPE);
@@ -688,8 +689,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 		  DIRECT_8X8_INFERENCE_FLAG);
 
 	/* write pps */
-	WRITE_PPS(0xff, PIC_PARAMETER_SET_ID);
-	WRITE_PPS(0x1f, PPS_SEQ_PARAMETER_SET_ID);
+	WRITE_PPS(pps->pic_parameter_set_id, PIC_PARAMETER_SET_ID);
+	WRITE_PPS(pps->seq_parameter_set_id, PPS_SEQ_PARAMETER_SET_ID);
 	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE),
 		  ENTROPY_CODING_MODE_FLAG);
 	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT),
-- 
2.42.0

