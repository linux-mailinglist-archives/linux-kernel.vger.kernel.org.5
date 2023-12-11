Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8280CC06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbjLKNyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbjLKNyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:54:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7B1FFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C73C433C7;
        Mon, 11 Dec 2023 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302790;
        bh=ce52MwjmCIqIGNpNziEdwAz/8cYu0NoXFtL2rJUJqLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNxZzgpLHXLGUscfzHgZELbcJv8FCZjRWlDswmv6kZ/fHe9TzniSXBiDUY8MLEmkp
         1ussrscWsZwFtr9vDld/wApBpwEGqZ9kZ/UZxtOW20Qq50CcoypgyzDPph3BT2Z3R0
         V3V4CWhEaJ+K4pTfZTWo2+ESa9Z6fU2l3VB2RofURrCyodAfuzwWcLoGj5FRmJgiyu
         L2V4sX1pGb/zE2ookO7hvAeLvKMVuNagm/o3aBX854R77zWmjQbU4+mGQ4GektHfmF
         5LgQmxHhArjQYTUL6HBN1AtOfF99/KcjS0HSjfj7fvCortbANtGJWG0jn1UjpdSNFP
         86xQCMNIlQsnA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>, allen.hubbe@amd.com,
        virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 26/47] pds_vdpa: set features order
Date:   Mon, 11 Dec 2023 08:50:27 -0500
Message-ID: <20231211135147.380223-26-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit cefc9ba6aed48a3aa085888e3262ac2aa975714b ]

Fix up the order that the device and negotiated features
are checked to get a more reliable difference when things
get changed.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Message-Id: <20231110221802.46841-4-shannon.nelson@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/pds/vdpa_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 9fc89c82d1f01..25c0fe5ec3d5d 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -318,9 +318,8 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 		return -EOPNOTSUPP;
 	}
 
-	pdsv->negotiated_features = nego_features;
-
 	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
+	pdsv->negotiated_features = nego_features;
 	dev_dbg(dev, "%s: %#llx => %#llx\n",
 		__func__, driver_features, nego_features);
 
-- 
2.42.0

