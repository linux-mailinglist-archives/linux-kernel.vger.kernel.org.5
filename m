Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5782757728
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGRI4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjGRIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:55:51 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162801984
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:55:34 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6686c74183cso5474505b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670533; x=1692262533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL6T6zUPXE3CCWce7xEIKEuuvu+FT0vtNSNDLrKiyG4=;
        b=ABgP15rhu7WVkPoLd0KVZ0Q7Esk0dULJYgtgxAnXzXm0pfpsplqOEVeXissa0SObTp
         vvCyDzbABKWkTQnrw+o6peYhdfc3E7NEPQi2vkvfWLPVFbRoHVrX7kEGVdKsnT8zk6bS
         7BnRW1ERW6hQxm6ME2u15qbvLYUdfPEGvpMYpBGal/s8ERucoj0fby4Mw4bqoRzY91lu
         ms1ISTqzB+ojYwFpkBN9RX580VnlcrivzSoBqHahNCssw1ktXiUQHTkBTiYbWb8Ag5sQ
         ROxR+UdcjNhKcKeTdB6w/riBbydVCj0mz/GmVJbnoFQGPdZxNk9VZUEDy70mLLLO51P8
         XFJA==
X-Gm-Message-State: ABy/qLYB9Rebhjh6952XKGjNmhneodwel5SpqcercrsQHROowTSClDiH
        k7k2awNxWzphkuP3OnVhtR8=
X-Google-Smtp-Source: APBJJlEXVOfK+Oz77sy2Agp3i5Bz0sg+YTaUgKgUKZikigImO+hddycG37H2R6gvmih7I+qe4ag0jg==
X-Received: by 2002:a05:6a20:d9:b0:134:4f86:7990 with SMTP id 25-20020a056a2000d900b001344f867990mr7635622pzh.3.1689670533336;
        Tue, 18 Jul 2023 01:55:33 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b00678159eacecsm1073860pfh.121.2023.07.18.01.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:55:33 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Fix signed error return values handling
Date:   Tue, 18 Jul 2023 01:55:29 -0700
Message-Id: <20230718085529.258899-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle signed error return values returned by simple_write_to_buffer().
In case of an error, return the error code.

Fixes: 3c3d818a9317 ("firmware: arm_scmi: Add core raw transmission support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
This is based on static analysis. Compilation tested.
---
 drivers/firmware/arm_scmi/raw_mode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 6971dcf72fb9..0493aa3c12bf 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -818,10 +818,13 @@ static ssize_t scmi_dbg_raw_mode_common_write(struct file *filp,
 	 * before sending it with a single RAW xfer.
 	 */
 	if (rd->tx_size < rd->tx_req_size) {
-		size_t cnt;
+		ssize_t cnt;
 
 		cnt = simple_write_to_buffer(rd->tx.buf, rd->tx.len, ppos,
 					     buf, count);
+		if (cnt < 0)
+			return cnt;
+
 		rd->tx_size += cnt;
 		if (cnt < count)
 			return cnt;
-- 
2.34.1

