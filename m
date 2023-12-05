Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF58062AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346533AbjLEXFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbjLEXFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF6B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701817515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9g0AqQltjx9HVi2PVmhYskrOtwbSdqnOJIb+sPsbDU=;
        b=JZGvNj4vzVesqoLOtCOLP4euBwjPjpmPpx2nsBgYsBdbHMTkKiS7KgcM3k35ulyFikzjQ6
        qND1L7lzHBB4PW+gkVVJLgkQbrDCbMIUpxPdPOsD+sNLEKNPKFs0R3dK9lYFxrEgUV7tM6
        cAPUVAhz2qwd71pAnDa0t9VUV9DuJPM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-8g54K8ZlNYGoh-sbE_VNJA-1; Tue, 05 Dec 2023 18:05:13 -0500
X-MC-Unique: 8g54K8ZlNYGoh-sbE_VNJA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-423f4f5f586so2436171cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 15:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701817513; x=1702422313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9g0AqQltjx9HVi2PVmhYskrOtwbSdqnOJIb+sPsbDU=;
        b=BqM2smaNtWmsNEtdQ2b2yHkH/5ugVBoSOOm39CFX+Hh10WCfyF8ejamcAOtzQPSX67
         SfxJHC5/8QddGCuk1uHsfQojqET0LMgKOxu75x+pFRS82rQm9mvk/GOwrDZ2441onQt8
         JGsEemoGpL0yoB8rbXYpO3uJDJykC+6aljD8xV5ngWXLOAihYypLMcq7cX5B9xnubDa0
         6CzWg3idp8kzVUmOEAOKxHiuG7lrWZIRvcCbuZmXlGv37V2dOeWNqM7S/eFjmjMc9oEe
         2o8BBlbykHOa2bVVH+fFUjscYjGSO1tLNEdtbU/LiNk25rRqqRtW/6BGFGj6+61v3gHE
         SzEQ==
X-Gm-Message-State: AOJu0YxQIU97S/kfC7O2ATna2ZPyTTQWoKFavxjVRg3iM9WuI8WMeNCE
        if92kqOsWrndqFTCvMvwLApaRG8RcCdVOzR0lU+drAJoCLJd+xjBYO0gohuLlYxNIJsqJWSBBXk
        czCU0MzDClCCu6JLn9HB2aF07
X-Received: by 2002:ac8:7d8c:0:b0:425:4043:5f1b with SMTP id c12-20020ac87d8c000000b0042540435f1bmr2507693qtd.89.1701817513292;
        Tue, 05 Dec 2023 15:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjtHacZ3EDCaJIyW6TtCHW6exbpgEh/YaVRvf97hFBjQsptkQMAzP6q1I3JbKbcJd7uc8Aqg==
X-Received: by 2002:ac8:7d8c:0:b0:425:4043:5f1b with SMTP id c12-20020ac87d8c000000b0042540435f1bmr2507679qtd.89.1701817513069;
        Tue, 05 Dec 2023 15:05:13 -0800 (PST)
Received: from [192.168.1.164] ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm5504430qtb.71.2023.12.05.15.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:05:11 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Tue, 05 Dec 2023 17:05:09 -0600
Subject: [PATCH 1/3] soc: qcom: pmic_pdcharger_ulog: Search current
 directory for headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-pmicpdcharger-ulog-fixups-v1-1-71c95162cb84@redhat.com>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
In-Reply-To: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As specified in samples/trace_events/Makefile:

    If you include a trace header outside of include/trace/events
    then the file that does the #define CREATE_TRACE_POINTS must
    have that tracer file in its main search path. This is because
    define_trace.h will include it, and must be able to find it from
    the include/trace directory.

Without this the following compilation error is seen:

      CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
    In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
                     from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
    ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
       95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
          |                                          ^
    compilation terminated.

Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/soc/qcom/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 110108e23669..05b3d54e8dc9 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
 obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
+CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o

-- 
2.43.0

