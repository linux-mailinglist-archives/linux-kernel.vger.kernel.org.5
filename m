Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACA7EF31C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjKQM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjKQM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:57:11 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05820D5F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:57:06 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1700225821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yZD/Sn1R2SVTne1HGGZ4hKTypVy6dTpTjai+r/elyT4=;
        b=voctcqkI8M3/osfELiL5uRL72hNMig0TDFR1ZR7+xmlj6OJObqtE8LUvi3Qzglfs5uHBl8
        LXIe0hTkwSfX6uE4GncVWtF+JtUvwhSrxrJat6y1cVbAtjpajoljkFtpQ3Q4LBOQqC1y8D
        fGrIKupsOn6duLlxjhLty6v8vm6ONGI=
To:     Louis Peens <louis.peens@corigine.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] nfp: flower: Added pointer check and continue.
Date:   Fri, 17 Nov 2023 15:57:01 +0300
Message-Id: <20231117125701.58927-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value of a function 'kmalloc_array' is dereferenced at
lag_conf.c without checking for null, but it is usually
checked for this function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 88d6d992e7d0..8cc6cce73283 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -339,6 +339,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
 
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work, NFP_FL_LAG_DELAY);
+			continue;
+		}
+
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
 		 * work queue triggering. If the number of slaves has changed
-- 
2.25.1

