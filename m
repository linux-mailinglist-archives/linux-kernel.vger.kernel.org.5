Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AC79796E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjIGROJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjIGROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:14:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284301FD3;
        Thu,  7 Sep 2023 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EwZY3xeL8bPY6t3VJcawMd6VTgi15NEguqkiZW76ycY=;
  b=bZpdL9BR4gaYR8qAvDNGS6JNT/SUo9NZFWkqZHorlhCZE0NQR0PPIJQ3
   XucEFPUQ3ID+HyIa/eHP0fKNGC96kzlgz5GKuLBoEHspVQE+F/SpVzwtf
   L9QvwawiciUWzBIPWYxgpiLrwkhWaxlk2NK59kkMHsLoRBvDXzhuVs7IH
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324655"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:30 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH 01/11] arm-cci: add missing of_node_put
Date:   Thu,  7 Sep 2023 11:55:11 +0200
Message-Id: <20230907095521.14053-2-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_available_child_of_node performs an of_node_get
on each iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/bus/arm-cci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -u -p a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {

