Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4A8755D02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGQHfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGQHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273DE1A4;
        Mon, 17 Jul 2023 00:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA19A60F97;
        Mon, 17 Jul 2023 07:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F04C433C9;
        Mon, 17 Jul 2023 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689579282;
        bh=vhh6DlpbxTDrDy1mnUesEe41wUAuLHP4kh7GVzyGoPs=;
        h=From:To:Cc:Subject:Date:From;
        b=HxcV5P7CSC/TxEWjWv7GBIP7qnLDX3+r2VgAbr4JbgXfoMZk1v05VYOLEGi2b6T1c
         ZTbIik1WgXcwLXUcd7THgvZ4zY7MxZjI7uAxVxZTpaQISuKmcPcUR7VeqgqTM/cmWL
         qu3jeVBG7CWsHl3E/tCHXWcNBzFcAfO6z64oKKqSKldQyf2lwHh459ThOfNHjG63yM
         vH1tEC5Z8PUdxx9DKHX1LGzyfFJo/uAEMKGHmBh2z6QTEnnYWNBZFqvWx2fTIBFD3D
         wBZ+3yBm4PAEu2VfxavrfqQBokUr2gitew3dSSjbdIw2kTcInOfcmY9Np6JEM8Fb/A
         VGTkT1C0dIMNw==
From:   djakov@kernel.org
To:     djakov@kernel.org, konrad.dybcio@linaro.org, andersson@kernel.org
Cc:     stephan@gerhold.net, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: icc-rpm: Initialize ret variable to fix smatch error
Date:   Mon, 17 Jul 2023 10:34:29 +0300
Message-Id: <20230717073429.2115015-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Djakov <djakov@kernel.org>

Fix the following smatch error:
drivers/interconnect/qcom/icc-rpm.c:243 qcom_icc_rpm_set() error: uninitialized symbol 'ret'.

Fixes: 32846c4a8f2a ("interconnect: qcom: icc-rpm: Set bandwidth on both contexts")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 612390b9eb18..6718cc648d75 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -206,7 +206,7 @@ static int qcom_icc_qos_set(struct icc_node *node)
 
 static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 {
-	int ret, rpm_ctx = 0;
+	int ret = 0, rpm_ctx = 0;
 	u64 bw_bps;
 
 	if (qn->qos.ap_owned)
