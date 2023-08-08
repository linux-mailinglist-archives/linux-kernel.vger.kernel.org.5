Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44365774716
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjHHTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjHHTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C391131C04
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NAdb78Y0H73weIO98ugUGfmSIY7jdtUo6DNWWtUmQ4=;
        b=VihupwTVOy0YTBacKTm2hB1sZCFpA9sBwPaqYmZRf+QJRqg19o0yuLxESaVf0fDe1BnL6d
        F/4XQoZg6/2LxpG+9mmgZByRc8N0vF7KT6w+t2VLZxVFN5pbUlDS+wuO4sWnMAb9jQiGFM
        Yt+utDlx2+Nzd+/zkF5ndZnAYNUi5Rk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-uBoU9ePdOSyMQ52hxoyLNA-1; Tue, 08 Aug 2023 10:27:16 -0400
X-MC-Unique: uBoU9ePdOSyMQ52hxoyLNA-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-d07cb52a768so6087695276.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 07:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691504835; x=1692109635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NAdb78Y0H73weIO98ugUGfmSIY7jdtUo6DNWWtUmQ4=;
        b=UjN+bZwBd6xiwDCBsgWsGuSFR8hJoSQo+4+Qu6/bGPTStNbuHcp/BYxEr6acsILHLW
         6V+1LgX1iAx50V3rQ4rtYT1uH8nO4cc44CmyyPP/1psygLVPBOtke4jFXqDJWwfXK/lJ
         PkOV3JLX+W12ZLDiOqU4r1youFopuIsH4kGOGDs4KTL4HUxI1XLnuLZ2DmYyrf6xmjjD
         NdHDj5TbjC7BLGiKtH72lcDF19WlFR4yHJd4wVbtgLyFsFr8TATyL2gcoIVLkFF1+1Vn
         e5KsEdXqgw1aqir+96LkmqYXgUaB2BKMpMj+Eel7rEn76AgrdLvbfpugx0GXbj7LXclW
         ZnvA==
X-Gm-Message-State: AOJu0YzzjsLfUWXiL6Tz0Vmd/S7ckXk4FnhzYJDsXB3AriT7hRDQEXZ4
        OOR+smFAirt4IzmTLGu7FZkzVPajulswYhGqBImVwwBfdzUUCP/lt68XSSJRvTBZkf+9t38DXRK
        YSQXR+DICvy7bBDRx60KkeTQC
X-Received: by 2002:a25:f828:0:b0:d09:34f4:6693 with SMTP id u40-20020a25f828000000b00d0934f46693mr11968670ybd.25.1691504835474;
        Tue, 08 Aug 2023 07:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/DUUfQxavR7RqM5scoji8HEnxVztw4xX0S3NZ+ZEK++1ssDoFQJEo57gsqTValGWBjevnWg==
X-Received: by 2002:a25:f828:0:b0:d09:34f4:6693 with SMTP id u40-20020a25f828000000b00d0934f46693mr11968662ybd.25.1691504835224;
        Tue, 08 Aug 2023 07:27:15 -0700 (PDT)
Received: from brian-x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y9-20020a259c89000000b00c71e4833957sm2713058ybo.63.2023.08.08.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:27:14 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: ufs: host: convert to dev_err_probe() in pltfrm_init
Date:   Tue,  8 Aug 2023 10:26:50 -0400
Message-ID: <20230808142650.1713432-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808142650.1713432-1-bmasney@redhat.com>
References: <20230808142650.1713432-1-bmasney@redhat.com>
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

