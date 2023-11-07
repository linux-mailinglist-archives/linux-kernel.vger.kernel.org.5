Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDEA7E4CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjKGXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjKGXWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:22:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB910C3;
        Tue,  7 Nov 2023 15:22:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33024C433C9;
        Tue,  7 Nov 2023 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399357;
        bh=T2WHswAAhfKS2jYhrFvo4RtsljSxrhqjsIsZmlPUiu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Id8axQ6bUXSB+/wcub39gTHgKvqIbYVRp8K62lEXqAU+bsa7VVr1iwFu2+y3dlj3o
         5OKfw95eQFm3pnKyIeWCcDuQy5y7jjT7GYVZI+LWG6mpumu9KbxfjBwyFtBzfqVGeu
         K3M2I4KA4efyxeSMX2jIWsdu3NfGzRVLjjGaaUB+n7YI207S39Jg564HkUiFsOag7+
         ocKDASKRPHxgNjMGfy3A80W1SGLd/CRNXYaehvo9649HAwiQKCanS/8gr0sCCC332L
         aecpn32jBZujspGRtqn68bu1obXfAm5Elp5IKUihkt0uqQ9z2ZBOA7PawJVS8TDzr5
         s/7aLS8Gd8Tmw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/18] thunderbolt: Apply USB 3.x bandwidth quirk only in software connection manager
Date:   Tue,  7 Nov 2023 18:21:56 -0500
Message-ID: <20231107232231.3775605-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 0c35ac18256942e66d8dab6ca049185812e60c69 ]

This is not needed when firmware connection manager is run so limit this
to software connection manager.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index 488138a28ae13..e6bfa63b40aee 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -31,6 +31,9 @@ static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
 {
 	struct tb_port *port;
 
+	if (tb_switch_is_icm(sw))
+		return;
+
 	tb_switch_for_each_port(sw, port) {
 		if (!tb_port_is_usb3_down(port))
 			continue;
-- 
2.42.0

