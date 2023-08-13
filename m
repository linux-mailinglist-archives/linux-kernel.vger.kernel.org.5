Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF277A7A8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjHMPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjHMPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F9E73;
        Sun, 13 Aug 2023 08:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270C86303A;
        Sun, 13 Aug 2023 15:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEAAC433CC;
        Sun, 13 Aug 2023 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941781;
        bh=uewy2yNn9F65oLxAQMXFZszdhFU20SCYbOo+3oaOn84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKVu05NAoCPzu84IAiOyH4dker3NEwHFZC84r/4+tHskKVQirkcClq4Q3ZeJAU0hg
         KLdkB+3GYgNryfqZdd1nIMUtP3Z8iZTeqD3MdvOf8pkmwvri3t9JfCA6gzoJ0ehEbf
         f8+u/JYdtgkpW6pAOwR2VaSQCnnkgroF8c3WHjzMpz2bUPKlPoEUoPhWYka/4m4dUz
         W7LvS1rNFHrYvXELSFBu2009wdnpqRwkiAPu554mkjftPSSJMF4wZyzwWzzMkJ+TBM
         5a2OYTnS5044Q2RK7ApUyxGR91fmng0BI2v5T0ctWxWBXapCZyq5QrWHTbhErjILxF
         pp+mDvjDzdkJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        ming_qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shijie.qin@nxp.com,
        eagle.zhou@nxp.com, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 04/54] media: amphion: use dev_err_probe
Date:   Sun, 13 Aug 2023 11:48:43 -0400
Message-Id: <20230813154934.1067569-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 517f088385e1b8015606143e6212cb30f8714070 ]

This simplifies the code and silences -517 error messages. Also
the reason is listed in /sys/kernel/debug/devices_deferred.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: ming_qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_mbox.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/platform/amphion/vpu_mbox.c
index bf759eb2fd46d..b6d5b4844f672 100644
--- a/drivers/media/platform/amphion/vpu_mbox.c
+++ b/drivers/media/platform/amphion/vpu_mbox.c
@@ -46,11 +46,10 @@ static int vpu_mbox_request_channel(struct device *dev, struct vpu_mbox *mbox)
 	cl->rx_callback = vpu_mbox_rx_callback;
 
 	ch = mbox_request_channel_byname(cl, mbox->name);
-	if (IS_ERR(ch)) {
-		dev_err(dev, "Failed to request mbox chan %s, ret : %ld\n",
-			mbox->name, PTR_ERR(ch));
-		return PTR_ERR(ch);
-	}
+	if (IS_ERR(ch))
+		return dev_err_probe(dev, PTR_ERR(ch),
+				     "Failed to request mbox chan %s\n",
+				     mbox->name);
 
 	mbox->ch = ch;
 	return 0;
-- 
2.40.1

