Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9D80CBCB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjLKNyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjLKNxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:53:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C111723
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0574CC433C8;
        Mon, 11 Dec 2023 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302784;
        bh=Z11gVKak3AudfsY9eiwwmKrfy2eHNlv6I4ERRcbZX1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0SJguA23bx5x8W174Ga9krfTIu7x60FkA/P5aNeUdsbkTZIwvCiCBnHbonHUiOCK
         Hms2VD1eHQCoiOzWaAJIkTSaWtJ1nw++uVqF2csLDivgahxHcfG5DmAU2HYvNdvINa
         vre/sQ2OTyZKPI6AO+ghnV9BkpIzYOfsRMK/Zo/02CyJiOnJlbWPGr3AZQamH4RsXJ
         k4wTwkzobBzY3kgh1r9HLAGbXCYkzb07O4z8eZTsBWnPbeB9d4qeugXOb8vNmBivhG
         BCCGs7vGf4QPWqbG5CFCJqbCM1YQ9bl/nnqYLJsw3Yw1rkB2TAYWXmzXB3620bd/7c
         jvX/O/FDkRtZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>, allen.hubbe@amd.com,
        virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 25/47] pds_vdpa: clear config callback when status goes to 0
Date:   Mon, 11 Dec 2023 08:50:26 -0500
Message-ID: <20231211135147.380223-25-sashal@kernel.org>
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

[ Upstream commit dd3b8de16e90c5594eddd29aeeb99e97c6f863be ]

If the client driver is setting status to 0, something is
getting shutdown and possibly removed.  Make sure we clear
the config_cb so that it doesn't end up crashing when
trying to call a bogus callback.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Message-Id: <20231110221802.46841-3-shannon.nelson@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/pds/vdpa_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 52b2449182ad7..9fc89c82d1f01 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -461,8 +461,10 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	pds_vdpa_cmd_set_status(pdsv, status);
 
-	/* Note: still working with FW on the need for this reset cmd */
 	if (status == 0) {
+		struct vdpa_callback null_cb = { };
+
+		pds_vdpa_set_config_cb(vdpa_dev, &null_cb);
 		pds_vdpa_cmd_reset(pdsv);
 
 		for (i = 0; i < pdsv->num_vqs; i++) {
-- 
2.42.0

