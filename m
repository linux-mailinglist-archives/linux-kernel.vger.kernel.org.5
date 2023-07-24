Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B072B75E886
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGXBmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGXBlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E21987;
        Sun, 23 Jul 2023 18:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4276E60FCA;
        Mon, 24 Jul 2023 01:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD90C433C8;
        Mon, 24 Jul 2023 01:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162363;
        bh=sPgqBc9MDblYXPHS71Myl2hrzTAGjCrucv1FSII+xSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EM0UmhauI4udZl5u+XH7ultC5F//eMIqa5KVC2fB9rC26zMajo8U/hPJNpboFaqDK
         j/CKVcJnPkRxLEmHArVqkOtxboF10oH2bOU0BApZU7An0sfhfQ2lfH39DSK7OGhNgK
         0qnZlVpLwjPAHljhI8f1aLv3t/j5uMz4dPaYiZfXudjtJqOG180xzaHtfpUAAG16qa
         spBuPx+kNwqUHuL58FXqJOHm18UGvwlX2ZUy9NrJ8xse0AQEOh2U3XKDVBqZZa/+U3
         M5kLLjQS+rFUrU1Es0dV9AcOU9RSeG/ZEPRxQTbgfs9kPFbYtc2t0tXROIC7aXVpre
         DOx61bRKPjkGA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Pina Chen <pina.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 03/34] media: v4l2-mem2mem: add lock to protect parameter num_rdy
Date:   Sun, 23 Jul 2023 21:32:06 -0400
Message-Id: <20230724013238.2329166-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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

From: Yunfei Dong <yunfei.dong@mediatek.com>

[ Upstream commit 56b5c3e67b0f9af3f45cf393be048ee8d8a92694 ]

Getting below error when using KCSAN to check the driver. Adding lock to
protect parameter num_rdy when getting the value with function:
v4l2_m2m_num_src_bufs_ready/v4l2_m2m_num_dst_bufs_ready.

kworker/u16:3: [name:report&]BUG: KCSAN: data-race in v4l2_m2m_buf_queue
kworker/u16:3: [name:report&]

kworker/u16:3: [name:report&]read-write to 0xffffff8105f35b94 of 1 bytes by task 20865 on cpu 7:
kworker/u16:3:  v4l2_m2m_buf_queue+0xd8/0x10c

Signed-off-by: Pina Chen <pina.chen@mediatek.com>
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/media/v4l2-mem2mem.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bb9de6a899e07..d6c8eb2b52019 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -593,7 +593,14 @@ void v4l2_m2m_buf_queue(struct v4l2_m2m_ctx *m2m_ctx,
 static inline
 unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->out_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->out_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
@@ -605,7 +612,14 @@ unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 static inline
 unsigned int v4l2_m2m_num_dst_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->cap_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->cap_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
-- 
2.39.2

