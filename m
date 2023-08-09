Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB377680D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjHITML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjHITMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5C2127
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJ/VTCVUVdAN9JEuI46HSpb8/BIcrmXf6cV+lu2tL0Y=;
        b=h/dcFDIovAMCqt3iS50zJh4NB0P3EMrQSpLuvutY+53txNKFzYTSJlYQLdZE+aAqJgLAO2
        iCYzBQY15DRxOGHRU741xjY4RDZo6FAIBQ9kaBFJl18Y+lGILPOF49rCy68x6/2AxOMCjZ
        whqrMWmvAH5SyywWTy7Hbpp6oT6jQXg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-bL-Mnb2GNMm13z9rD9v3sw-1; Wed, 09 Aug 2023 15:11:10 -0400
X-MC-Unique: bL-Mnb2GNMm13z9rD9v3sw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5897d05e878so2946967b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608269; x=1692213069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ/VTCVUVdAN9JEuI46HSpb8/BIcrmXf6cV+lu2tL0Y=;
        b=Ex3mvdbWsgFohmEFM7PX95KCVmt0HAsw0TFWP7OCLiyc6DMohW9iwy/PHVthxHrmGm
         Spg8lr1frbUtbrIhaNMGbYOThMOFeZ1dYcHnAMQGOTqevotVWQxbh9Jgt7oRpxvRTOG6
         R1hPFncYcIjWX6+71lbMZQ52tBQwrBS6MhFAU/yZYx65sNj6Oiy9sq7aIrzysSlMnLwN
         D2h+q8GEQfxFYKuvowzGNuCp8FB2Wd5iJnIBVlllqAp+V8Hh5VEAVpuieKkvT8J0+fHF
         AeUhvIjhtoR2Pqj/R4ZzGiJdAXH69XwfL99CfBJXEQ9wuSZFbtA/SDIAbuqYV+DVK+Dv
         ku5w==
X-Gm-Message-State: AOJu0YzYUgTTPDJWNPM+x7zO8ULbfBZxmjP85h3ND11fy6edNt9jYGpz
        7fC3vwiAuny9l+D+i5Pa4jUmEXhIVjZivsw155AFVYn4gEGx5o3RscYiFA703Zha14ocdhDAuTE
        4uudqfEXUZL8VfHFWUNBIw47P
X-Received: by 2002:a0d:f1c1:0:b0:586:a689:d28a with SMTP id a184-20020a0df1c1000000b00586a689d28amr187553ywf.34.1691608269577;
        Wed, 09 Aug 2023 12:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95W3s4pPhKxWsyLMaLGDznqUQUQCNFJ7eYo88i5GP10VIapnaCZ9OlyNfcy2vDPqKbL/mQA==
X-Received: by 2002:a0d:f1c1:0:b0:586:a689:d28a with SMTP id a184-20020a0df1c1000000b00586a689d28amr187536ywf.34.1691608269344;
        Wed, 09 Aug 2023 12:11:09 -0700 (PDT)
Received: from brian-x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id s84-20020a817757000000b005774338d039sm4172969ywc.96.2023.08.09.12.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:11:08 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com
Subject: [PATCH v2 2/2] scsi: ufs: host: convert to dev_err_probe() in pltfrm_init
Date:   Wed,  9 Aug 2023 15:10:54 -0400
Message-ID: <20230809191054.2197963-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809191054.2197963-1-bmasney@redhat.com>
References: <20230809191054.2197963-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ufshcd_pltfrm_init() over to use dev_err_probe() to avoid
the following log message on bootup due to an -EPROBE_DEFER return
code:

    ufshcd-qcom 1d84000.ufs: Initialization failed

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
No changes since v1

 drivers/ufs/host/ufshcd-pltfrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index 0b7430033047..f2c50b78efbf 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -373,7 +373,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	err = ufshcd_init(hba, mmio_base, irq);
 	if (err) {
-		dev_err(dev, "Initialization failed\n");
+		dev_err_probe(dev, err, "Initialization failed\n");
 		goto dealloc_host;
 	}
 
-- 
2.41.0

