Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D77DB034
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjJ2XEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjJ2XEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993047EED;
        Sun, 29 Oct 2023 16:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E79C43215;
        Sun, 29 Oct 2023 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620443;
        bh=QjzhNeZ1skYvKCj+5xx8iOynDv8Qdyy8qRRAcFnICec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/FNL0wBVXpc2p1l4/Wag3mnjkgxgzgR3eHO4dgRezjxp5xJHJiv639XB+p5pZAL9
         zy4gxylxpMhrD/YMF5OnP0v6JMr16yD69UduoVggW1SqJT+X1LwaXwp6JTya+IGHQo
         T3h8xIStqfxTVRo17oUGmd6UaytZEZCgtBXfkRJupgAl/LTfvYf4yaAO6LgKZwJ67C
         gVmYNLb9NE6e/G/u/HEBj5EiLwWoEfj9DLyONbRXPi4Jzi5kKJkTzHRMJ8rejB/Ujh
         l/6820NZppVPPiwtWKKqbBS0WSDZkBPeFmZTlL5FaIkl6LYRdsmjUWZPGm5K5eVSch
         j7CxvGt4vKAoQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liming Sun <limings@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/16] platform/mellanox: mlxbf-tmfifo: Fix a warning message
Date:   Sun, 29 Oct 2023 19:00:01 -0400
Message-ID: <20231029230014.792490-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liming Sun <limings@nvidia.com>

[ Upstream commit 99c09c985e5973c8f0ad976ebae069548dd86f12 ]

This commit fixes the smatch static checker warning in function
mlxbf_tmfifo_rxtx_word() which complains data not initialized at
line 634 when IS_VRING_DROP() is TRUE.

Signed-off-by: Liming Sun <limings@nvidia.com>
Link: https://lore.kernel.org/r/20231012230235.219861-1-limings@nvidia.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 194f3205e5597..767f4406e55f1 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -588,24 +588,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       sizeof(u64));
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       sizeof(u64));
+		} else {
+			memcpy(&data, addr + vring->cur_len,
+			       sizeof(u64));
 		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (!IS_VRING_DROP(vring)) {
-			if (is_rx)
+		if (is_rx) {
+			if (!IS_VRING_DROP(vring))
 				memcpy(addr + vring->cur_len, &data,
 				       len - vring->cur_len);
-			else
-				memcpy(&data, addr + vring->cur_len,
-				       len - vring->cur_len);
+		} else {
+			data = 0;
+			memcpy(&data, addr + vring->cur_len,
+			       len - vring->cur_len);
 		}
 		vring->cur_len = len;
 	}
-- 
2.42.0

