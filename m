Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76BA7BC5DF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbjJGH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343781AbjJGH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:56:18 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2948F1
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GJAno
        WHcVnS1Uf1GS0rXopgZcpLPLXbvCJAQMypci+I=; b=h9kYUBi0mxZdXxrAQohVq
        6a0aHvMphBswF8zs39Kw89zklicDuWyEiDfnLAOCF/hV0YyLORRvSNoCkgUit7vT
        9BhP873fmvZAZhmk3LCksfGTCTbtRoIzm1tjvMvFRqagB57R+BelqYzrBwSKe/4a
        60WBS/8s4lJeOr6Yuf+OqM=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wBH1HQRDyFlZwQrCQ--.50815S4;
        Sat, 07 Oct 2023 15:56:11 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     make_ruc2021@163.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] bus/arm-cci: Fix refcount leak in cci_probe
Date:   Sat,  7 Oct 2023 15:56:00 +0800
Message-Id: <20231007075600.4002159-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBH1HQRDyFlZwQrCQ--.50815S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRVpBVUUUUU
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyB4CC1p7MCPnxQAAsP
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing of_node_put() to release the refcount incremented
by of_find_matching_node().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/bus/arm-cci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..6be7b05b5ff1 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -548,6 +548,7 @@ static int cci_probe(void)
 	}
 	if (ret || !cci_ctrl_base) {
 		WARN(1, "unable to ioremap CCI ctrl\n");
+		of_node_put(np);
 		return -ENXIO;
 	}
 
-- 
2.37.2

