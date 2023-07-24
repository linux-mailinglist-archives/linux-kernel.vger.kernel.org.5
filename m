Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59976027D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGXWlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGXWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:41:12 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5181987
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:41:10 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-785ccf19489so256954439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690238470; x=1690843270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeP2Bpkp9J7OOE4sWn2E6NWLqeXa4peAEEdE+9mQzSs=;
        b=uVBTiaICcqS0cbclHhojIy9A/rn1xLF2yWj0IT3eGwYot+z7UEEoFf8vl2QmbV5HZd
         oZMhnIVX0R9vxalzBDfEdnRYeggfqAWPp4oZ9iIRiYDirNYDPry665l3xLJOv4w9ndoV
         atAKzCpgip8LDAIXf6qHwji/s1g3JbuWcbuDNTbWkgkfmMoERf1A203T+0pmhikbtKdF
         ftEXpPbfnz5Wvvbtbdb23i/4K0J3WvPEoAfxj+wRypNZFJmdRvo094Efvgx0Uz399ao+
         kY/uZo+vG0RSD0FXczITHgWRFih72r4lLaRNLR1zaoxfD2RRB/VOQFv104/3q7VyvDCy
         wRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690238470; x=1690843270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeP2Bpkp9J7OOE4sWn2E6NWLqeXa4peAEEdE+9mQzSs=;
        b=hC3bMN7H5/4XFC3ri6t4egdGptG1iFvmZ08dNXTndHOvTiIvw7J/rwkHO/W8xbNaeh
         WTrHajWYSPpQ+HvKWFGWJg+W5r5BwU23la5kzpaXiSIr3B2y3KjyQ6vGwUXaRgJUHMSq
         EAUPhtdirnzNYT0+A5SiZHtDCm/MPvgdq6x01hU4MZT0QtgWIw7GejIOF8blnIcSPqz0
         u8tpOas3zVlmDKCy05rBLjy+h157cloGx2Kgk6ci8hQwY7C2jcEzUYMziT0IbCQtIJiQ
         8SynBTYJErj7nf9yEz5CWOp+3n4LToQOtfrnBxhixnnYyU7YsuGcwK1Li94uMTf6/XOa
         ABew==
X-Gm-Message-State: ABy/qLaf8t9Fm0JfkEEIwsIfclMOck45u5nkVdakfW+oNquluipcrL2f
        rB1dFoSk7ZMcITeXuIp83A2r6w==
X-Google-Smtp-Source: APBJJlEhDUh7RSS2Z2tTSspy5ELCXvyGnC/B2CaIbRlOt16SjoWMnBbRRS+8HrDzVxydj5/qeS3lcg==
X-Received: by 2002:a5d:9b8f:0:b0:783:5e20:768d with SMTP id r15-20020a5d9b8f000000b007835e20768dmr1134570iom.18.1690238469994;
        Mon, 24 Jul 2023 15:41:09 -0700 (PDT)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id gv18-20020a0566382e5200b0042b1297468esm3103953jab.51.2023.07.24.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 15:41:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     dianders@chromium.org, caleb.connolly@linaro.org, mka@chromium.org,
        evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH net] net: ipa: only reset hashed tables when supported
Date:   Mon, 24 Jul 2023 17:41:06 -0500
Message-Id: <20230724224106.1688869-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last year, the code that manages GSI channel transactions switched
from using spinlock-protected linked lists to using indexes into the
ring buffer used for a channel.  Recently, Google reported seeing
transaction reference count underflows occasionally during shutdown.

Doug Anderson found a way to reproduce the issue reliably, and
bisected the issue to the commit that eliminated the linked lists
and the lock.  The root cause was ultimately determined to be
related to unused transactions being committed as part of the modem
shutdown cleanup activity.  Unused transactions are not normally
expected (except in error cases).

The modem uses some ranges of IPA-resident memory, and whenever it
shuts down we zero those ranges.  In ipa_filter_reset_table() a
transaction is allocated to zero modem filter table entries.  If
hashing is not supported, hashed table memory should not be zeroed.
But currently nothing prevents that, and the result is an unused
transaction.  Something similar occurs when we zero routing table
entries for the modem.

By preventing any attempt to clear hashed tables when hashing is not
supported, the reference count underflow is avoided in this case.

Note that there likely remains an issue with properly freeing unused
transactions (if they occur due to errors).  This patch addresses
only the underflows that Google originally reported.

Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
Cc: <stable@vger.kernel.org>    # 6.1.x
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 510ff2dc8999a..cd81dd916c29e 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -311,16 +311,15 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, IPA_MEM_V4_FILTER_HASHED, modem);
-	if (ret)
-		return ret;
-
 	ret = ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER, modem);
+	if (ret || !ipa_table_hash_support(ipa))
+		return ret;
+
+	ret = ipa_filter_reset_table(ipa, IPA_MEM_V4_FILTER_HASHED, modem);
 	if (ret)
 		return ret;
-	ret = ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER_HASHED, modem);
 
-	return ret;
+	return ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER_HASHED, modem);
 }
 
 /* The AP routes and modem routes are each contiguous within the
@@ -329,11 +328,12 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
  * */
 static int ipa_route_reset(struct ipa *ipa, bool modem)
 {
+	bool hash_support = ipa_table_hash_support(ipa);
 	struct gsi_trans *trans;
 	u16 first;
 	u16 count;
 
-	trans = ipa_cmd_trans_alloc(ipa, 4);
+	trans = ipa_cmd_trans_alloc(ipa, hash_support ? 4 : 2);
 	if (!trans) {
 		dev_err(&ipa->pdev->dev,
 			"no transaction for %s route reset\n",
@@ -350,12 +350,14 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 	}
 
 	ipa_table_reset_add(trans, false, first, count, IPA_MEM_V4_ROUTE);
-	ipa_table_reset_add(trans, false, first, count,
-			    IPA_MEM_V4_ROUTE_HASHED);
-
 	ipa_table_reset_add(trans, false, first, count, IPA_MEM_V6_ROUTE);
-	ipa_table_reset_add(trans, false, first, count,
-			    IPA_MEM_V6_ROUTE_HASHED);
+
+	if (hash_support) {
+		ipa_table_reset_add(trans, false, first, count,
+				    IPA_MEM_V4_ROUTE_HASHED);
+		ipa_table_reset_add(trans, false, first, count,
+				    IPA_MEM_V6_ROUTE_HASHED);
+	}
 
 	gsi_trans_commit_wait(trans);
 
-- 
2.34.1

