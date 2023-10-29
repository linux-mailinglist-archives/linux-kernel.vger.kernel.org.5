Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20D7DAF53
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjJ2W6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJ2W6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:58:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D413251;
        Sun, 29 Oct 2023 15:57:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48590C433C9;
        Sun, 29 Oct 2023 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620221;
        bh=M6xpNn+t/cZnaseKl9ZdXbq9WpVQdINcyPmzY2CJYL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+oQD12c0DeXTHxheF2pkBbc1ZL6kfzK6d4+hKfmnmg5dfdrksHWTpCxeoMcTTt5l
         1UQAlR3/M+vGq3y05GjEa+sczMUJFhOwkOpkFT+ndRq3GjcUeWeWgw2pGGb0+9z1O2
         ig5RhtqGK3n+Y5hZY2QeU0SA6Dtt0XfcOMmLdBZPlMuG/mhTm3Fnxz1oa2eC8hDlEz
         /8WTda/5qRlx7UbQrjY+rnvkuT+sFPQl7tbY6Krnee08/0qQw2DJetILotp4D5bYJt
         Q3G7nx/a+zdP0Eh7OsVrf/3UNxUcQAPmg0s/lMFxhVpnoaiTBaoVGUK85XAduK5VgL
         nGdVlrPxOZhkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liming Sun <limings@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 48/52] platform/mellanox: mlxbf-tmfifo: Fix a warning message
Date:   Sun, 29 Oct 2023 18:53:35 -0400
Message-ID: <20231029225441.789781-48-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
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
index f3696a54a2bd7..d9615ad600123 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -607,24 +607,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
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

