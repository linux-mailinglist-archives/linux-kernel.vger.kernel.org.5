Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74C37FA25C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjK0OTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjK0OSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79543AA0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40859dee28cso34863775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094570; x=1701699370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p7Yk0pPh+5XOIFlXKbXoyDeljmm58+0nwJPnMfZeAs=;
        b=CL8f33vzDfInh8DW9OeVyj7o/Me0n3OXqUPjMexwnhcJA9cpCLL+jlHglkqAyQ2RQE
         2ajYM98zQbGfQ5AVXGcIkigh6ayM5DGkBUc7dcKzcZ2/U6Lrj29i1bz7wJkVPozNTlGf
         Lk5k3+Bwg4SJ/a70Te9y5pEpgkgKAdoXbnhTVcFBArPju2RAGMi/jUwaDJmoTqOTTu1w
         5rvamGporhW1VT/vC8soJvLshja9Uejwk+FIHN7nyZNdykIG+WypDgxvl4Yc9PergTBN
         I36eaJOTglNcLtgXARRmC3Bw00I7SiIpyrtzqu3oSadPQX+SxLIYlXv8pNcCJQd/TVEz
         ZWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094570; x=1701699370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p7Yk0pPh+5XOIFlXKbXoyDeljmm58+0nwJPnMfZeAs=;
        b=eaShsKJiqXPNVDTtULqFlW4HOuFdfzUrCb+tKlRX+Q0FWrPkNQbWJulvpO2qDwqmVW
         3wiMWdeWoc6pjmCE9PEKUY21KkUNqHYaKsWB8u6W/qqikj2tDyKFew1kpdpD1vweQ7X2
         gumeViTwizXZPW4LcDif3Sl786dJVKod9Kxw+jYNEQxsFX+7s4jTQvwD1f5CH/oPXcBc
         pi+52LLp85oO2GwUT9v3R9Ymlyw1ISDq7hYAeOhLqvNaK+Cs9aXbTp/gongZKVNDCWWP
         qnhnNk98QkBdpWdvvBL1vlvelCuRIYT00mNgaUf8iOmA2uLmodWgGxumaCtrHuXQyzwA
         b3mw==
X-Gm-Message-State: AOJu0YzZpmDm+CwT4SqRRaE8dQ1+pUh4C/gWKfpWEuBekHfoSq5cYnFo
        P2DWC58ojKjXZVE10Dk8Dp9uvg==
X-Google-Smtp-Source: AGHT+IGdj2lm+H87M+BbCZltT0WCKLIysUDz4kXF1jFX0sJyav3qV/p+Wda+ZHxLQ7t6J9lKOHi9pQ==
X-Received: by 2002:a05:600c:684:b0:408:56ea:f061 with SMTP id a4-20020a05600c068400b0040856eaf061mr9276619wmn.24.1701094570027;
        Mon, 27 Nov 2023 06:16:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:09 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v6 01/13] firmware: qcom: qseecom: fix memory leaks in error paths
Date:   Mon, 27 Nov 2023 15:15:48 +0100
Message-Id: <20231127141600.20929-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
References: <20231127141600.20929-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fix instances of returning error codes directly instead of jumping to
the relevant labels where memory allocated for the SCM calls would be
freed.

Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311270828.k4HGcjiL-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index a33acdaf7b78..32188f098ef3 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -325,8 +325,10 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	req_data->length = req_size;
 
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
-	if (status < 0)
-		return EFI_INVALID_PARAMETER;
+	if (status < 0) {
+		efi_status = EFI_INVALID_PARAMETER;
+		goto out_free;
+	}
 
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 
@@ -471,8 +473,10 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	req_data->length = req_size;
 
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
-	if (status < 0)
-		return EFI_INVALID_PARAMETER;
+	if (status < 0) {
+		efi_status = EFI_INVALID_PARAMETER;
+		goto out_free;
+	}
 
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 
@@ -563,8 +567,10 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name,
 			      *name_size / sizeof(*name));
-	if (status < 0)
-		return EFI_INVALID_PARAMETER;
+	if (status < 0) {
+		efi_status = EFI_INVALID_PARAMETER;
+		goto out_free;
+	}
 
 	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
 	if (status) {
@@ -635,7 +641,7 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		 * have already been validated above, causing this function to
 		 * bail with EFI_BUFFER_TOO_SMALL.
 		 */
-		return EFI_DEVICE_ERROR;
+		efi_status = EFI_DEVICE_ERROR;
 	}
 
 out_free:
-- 
2.40.1

