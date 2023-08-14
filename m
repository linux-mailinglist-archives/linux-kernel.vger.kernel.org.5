Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB03477BFF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjHNSpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHNSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E410C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gp3M5Azj+TRHJSQxak5e6jqixExltDd4LGqwek74hI=;
        b=g2NqXDgoMCdlGh/WXiClB6Z1AB54izxIqLos/irEV0Uqeg+Ml4VaafIJqiRS5F65uWc3Wj
        /6sMEvKlsswodvSU5O6iXVlTDSirLoQ4QUnaCJKHs6jG/1c3EQlLOqKiYgUzBaXUVoJ72B
        0oZajTYiZc6S/YS1XCgwS/mh8QNLO8o=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-o0WIo3pbOfiYJyaxpZXaKQ-1; Mon, 14 Aug 2023 14:44:04 -0400
X-MC-Unique: o0WIo3pbOfiYJyaxpZXaKQ-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-d664f9c5b92so4314529276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038644; x=1692643444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Gp3M5Azj+TRHJSQxak5e6jqixExltDd4LGqwek74hI=;
        b=C8LyYQOwNsYpB0sI2F1OWBoAybhxHKZJpDRTvTvyyxEfghC9SxLkeF4RvlWHdoRjB8
         cU/z3V/uB7xhNjtkMVxkTbHFVdD7bIpyYazPxmz1wqhrcv0aPmol/VpUbuYSWHwuhbdh
         frIuJq4z+XfvGRO5IUR0jTSrO5ODiYpZH129qG+VSBPHM8IKx//Uesje4yFKvBWMk4Y8
         uSuWSiiJ5jsH8mV2YOp+vdnz4mRtun/M9D/gNNCu79HMYFnXhiLRzIHxiZPw7iMYOXjD
         SfK/qIjrCUxSB1F0rVO7FbcMdzjNCaQClkilU7pw4mx2TJJg/woBfsf3Q7DAOrHE7vIt
         0Nlg==
X-Gm-Message-State: AOJu0YzWhiQRqMswkerhCkv3jCsrxEKiHTd/w+2RrHZTShL2KlP/qiGa
        /BMIxyd47bmSL2E4LU1tHjzVokQikDTlHa1QkmyXSz69z2Sk/+cJbU/ZfPz0XhTYQGVxW2/9BTv
        J8+wjfYZnddIXcxASTrgrZaxh
X-Received: by 2002:a25:5f05:0:b0:d43:18d7:e292 with SMTP id t5-20020a255f05000000b00d4318d7e292mr10598598ybb.32.1692038644200;
        Mon, 14 Aug 2023 11:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGguQmeB10V/5AccRVyZd0dd7vr6MgAslQXlaCOlGjUzVLf76JAbZjfOrHJFSTqf8yAC1Plxg==
X-Received: by 2002:a25:5f05:0:b0:d43:18d7:e292 with SMTP id t5-20020a255f05000000b00d4318d7e292mr10598588ybb.32.1692038643975;
        Mon, 14 Aug 2023 11:44:03 -0700 (PDT)
Received: from brian-x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id x131-20020a25ce89000000b00d674f3e2891sm1864387ybe.40.2023.08.14.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:44:02 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
Subject: [PATCH v3 2/2] scsi: ufs: host: convert to dev_err_probe() in pltfrm_init
Date:   Mon, 14 Aug 2023 14:43:52 -0400
Message-ID: <20230814184352.200531-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814184352.200531-1-bmasney@redhat.com>
References: <20230814184352.200531-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ufshcd_pltfrm_init() over to use dev_err_probe() to avoid
the following log message on bootup due to an -EPROBE_DEFER return
code:

    ufshcd-qcom 1d84000.ufs: Initialization failed

While this line is changed, let's also go ahead and add the error code
to the message as well.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes since v2
- Add error code to message

Changes since v1
- None

 drivers/ufs/host/ufshcd-pltfrm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 0b7430033047..c81a14f9eaf5 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -373,7 +373,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	err = ufshcd_init(hba, mmio_base, irq);
 	if (err) {
-		dev_err(dev, "Initialization failed\n");
+		dev_err_probe(dev, err, "Initialization failed with error %d\n",
+			      err);
 		goto dealloc_host;
 	}
 
-- 
2.41.0

