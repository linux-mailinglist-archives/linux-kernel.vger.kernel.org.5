Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9736F803478
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbjLDNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344301AbjLDNXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7807C4;
        Mon,  4 Dec 2023 05:23:46 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BFC276602026;
        Mon,  4 Dec 2023 13:23:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696225;
        bh=Dywo70CQG363NbYL8uLIRlzPbx56pDtvUEKi675FEes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQhD8+PKDoxYdoPM4Ao1lagEw4nKvvEQJorzb4rCzzTZtgUARwzbUeralYHdgJu0j
         lN9R+DCAN7FbZamZnn+YIJvE/IbgyM/egma+s9RcVmF+w07BkZQvseYPKntPS+Zvyt
         YDMD/Lwx+Kp/xMe9H7361+qBQHdt+KU7ZLVeAZ9WvkJi8/cBmG78hFKTteBWQIwkxR
         6mDdqwHuNIk7UceZdtv8j35Br69iXMeWZkJPvPQvtoSpeVP5D5O0MDQdfZ93S9hbeQ
         zPDyOACJlcJaQiZrwCmPPdAp7vocEuT7RHlYOj+z81pUm2P6jisNZD/eJlb8og+0yZ
         9OLTh1x4wHtZg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 05/36] media: qcom: venus: Remove useless setting of min_buffers_needed
Date:   Mon,  4 Dec 2023 14:22:52 +0100
Message-Id: <20231204132323.22811-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses min_buffers_needed which vb2 uses to ensure
start_streaming is called when at least 'min_buffers_needed'
buffers are queued. However, this driver doesn't need this,
it can stream fine without any buffers queued.
Just drop this unnecessary restriction.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Stanimir Varbanov <stanimir.k.varbanov@gmail.com> (maintainer:QUALCOMM VENUS VIDEO ACCELERATOR DRIVER)
CC: Vikash Garodia <quic_vgarodia@quicinc.com> (maintainer:QUALCOMM VENUS VIDEO ACCELERATOR DRIVER)
CC: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org> (reviewer:QUALCOMM VENUS VIDEO ACCELERATOR DRIVER)
CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: linux-arm-msm@vger.kernel.org
---
 drivers/media/platform/qcom/venus/vdec.c | 2 --
 drivers/media/platform/qcom/venus/venc.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index dbf305cec120..8bdffe546219 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1641,7 +1641,6 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct venus_buffer);
 	src_vq->allow_zero_bytesused = 1;
-	src_vq->min_buffers_needed = 0;
 	src_vq->dev = inst->core->dev;
 	src_vq->lock = &inst->ctx_q_lock;
 	ret = vb2_queue_init(src_vq);
@@ -1656,7 +1655,6 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct venus_buffer);
 	dst_vq->allow_zero_bytesused = 1;
-	dst_vq->min_buffers_needed = 0;
 	dst_vq->dev = inst->core->dev;
 	dst_vq->lock = &inst->ctx_q_lock;
 	return vb2_queue_init(dst_vq);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 44b13696cf82..f2e6bd44ed15 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1398,7 +1398,6 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct venus_buffer);
 	src_vq->allow_zero_bytesused = 1;
-	src_vq->min_buffers_needed = 1;
 	src_vq->dev = inst->core->dev;
 	src_vq->lock = &inst->ctx_q_lock;
 	if (inst->core->res->hfi_version == HFI_VERSION_1XX)
@@ -1415,7 +1414,6 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct venus_buffer);
 	dst_vq->allow_zero_bytesused = 1;
-	dst_vq->min_buffers_needed = 1;
 	dst_vq->dev = inst->core->dev;
 	dst_vq->lock = &inst->ctx_q_lock;
 	return vb2_queue_init(dst_vq);
-- 
2.39.2

