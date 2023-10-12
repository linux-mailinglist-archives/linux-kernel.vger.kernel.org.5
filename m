Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460457C66D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377807AbjJLH2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJLH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:28:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CC9D;
        Thu, 12 Oct 2023 00:28:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b2cee40de8so125154466b.1;
        Thu, 12 Oct 2023 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697095706; x=1697700506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEqKvIWeFRr8W5s0BPeSsPwNLKn93+5XPQoiJhuCABo=;
        b=b5UXYZkc91cIBJ7igE7i2UsySuIydTQXjE55MupknR44qFIjeVJIL2eLMxwFvD7sSG
         6h14rQqhPym0LJg/Vzb0XzLQdpSYqUhAx664sIYN12deQcb+bqTrskESdpJyaLSQKT2I
         rIvMTcCZzZFiR5i0BeUDTYN+s2xAuoE5uDKViBFonnPCv4H3qts1V8fIOCx8zUVCE17U
         Ve7GulhV/o0p6GLhQ/PXtE+0JvJYvdYZNiWtRU/PaQ3sk0aqoeevCGaXTb3qGe0TUNq9
         naqOlSixCZu4HyuaUeXX0PZbun9xANgfKLsjImFXHepvL6TBt0norQ84MzrWL6Si+Ryw
         WpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697095706; x=1697700506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEqKvIWeFRr8W5s0BPeSsPwNLKn93+5XPQoiJhuCABo=;
        b=IcufihXrY9gM7/bnLrIDjXMzSsTlYLJYW+0H30WIOidWyHcj1YTm1dLyAUqcxcwyTZ
         KrJGRegIp6MmnMVSimjwyFj/mpQEVPVOyJDU/Z4eJb7RG8FdjTaM4NhRlPIXHkyxXwcW
         ccXMI363j1mvzkj4Cj8Gql8DxlL6MXJU+u0HyL3AzDY9CK0h6keFU4ww3THpVXFAk0NY
         enXSnk4POBEm9XIR465XVRDIhk8l+ugGht0YVoEZDvDqRCllOFTXoK3tD1y2j3wsTwvU
         cx63jz7uiFGVlVtGCC1f57CLUmAupk4YrEt+QWVV+mgvA1PTI10wgKjbzeHqX8J4wuEk
         cJcA==
X-Gm-Message-State: AOJu0YxoHdRTMIBmMfrOGlHgKg60eK4WfUz23ZMQj5yu6919nY+Lf0zY
        xopNcQhtxIs8BfpZHDS1//8=
X-Google-Smtp-Source: AGHT+IFdcug422fZ9CQ3p/vnodtvTJxBtSb/0L4CdV5alrbUijpVrx+baQdM5YlE+adz/UU7cIal8g==
X-Received: by 2002:a17:907:7f08:b0:9a9:9d19:b250 with SMTP id qf8-20020a1709077f0800b009a99d19b250mr16312225ejc.17.1697095705420;
        Thu, 12 Oct 2023 00:28:25 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id a6-20020a170906468600b009a5f7fb51dcsm10616261ejr.42.2023.10.12.00.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:28:24 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     alim.akhtar@samsung.com, andersson@kernel.org, avri.altman@wdc.com,
        bmasney@redhat.com, bvanassche@acm.org, conor+dt@kernel.org,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        jejb@linux.ibm.com, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        kyungmin.park@samsung.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        myungjoo.ham@samsung.com, nm@ti.com, quic_asutoshd@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_cang@quicinc.com,
        quic_narepall@quicinc.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, quic_richardp@quicinc.com,
        quic_ziqichen@quicinc.com, robh+dt@kernel.org, sboyd@kernel.org,
        vireshk@kernel.org,
        "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Subject: [PATCH] scsi: ufs: core: Fix build error: ufshcd_opp_config_clks
Date:   Thu, 12 Oct 2023 07:20:51 +0000
Message-Id: <20231012072051.1517826-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011122543.11922-4-manivannan.sadhasivam@linaro.org>
References: <20231011122543.11922-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building linux-6.6-rc3 with this patchset applied and the following
configuration:

CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFS_BSG=y

I got:

   scripts/mod/modpost -M -m -a      -o Module.symvers -T modules.order vmlinux.o
ERROR: modpost: "ufshcd_opp_config_clks" [drivers/ufs/host/ufshcd-pltfrm.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/home/alessandro/src/linux-6.6-rc3/Makefile:1865: modpost] Error 2
make: *** [Makefile:234: __sub-make] Error 2

I needed to add an export symbol to have the build complete

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ccd7fcd18355..c0631c37c3d1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1098,6 +1098,7 @@ int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ufshcd_opp_config_clks);
 
 static int ufshcd_opp_set_rate(struct ufs_hba *hba, unsigned long freq)
 {
-- 
2.34.1

