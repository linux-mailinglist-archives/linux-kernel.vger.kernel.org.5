Return-Path: <linux-kernel+bounces-53225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77884A259
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8CD1F25166
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E0D52F74;
	Mon,  5 Feb 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yw1XbxRp"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB450A6C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157710; cv=none; b=l/HMaETKXo/zd4QFR9TAJ/jeNcpmRDCTw/c/V2VZi6On1/+5JXWz9OdqOSCe/wn8nEkFR/EcvIp9atwYCvU52udE9o2SdVd3kB596Rf5lSeRMJSzjpsGJFcLZg1MqpYz99/c0azTTBnOvVCt2ow5AmG1wte78wKJWXRW3D6ITCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157710; c=relaxed/simple;
	bh=5OOWzBxeb7BtobnU9iNj/y8p2LAmrftIcVh9GRDhdDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bixzwyViZbv/z9It+ucf1D7lorXUCgGFx/XfxGAu5pqq0kaDtCZ6w3AcrTfulKKeNiBcHygpk8FN5DXfvSJ91iOmDQ861k0h1/l1tkjHAMhZxbO74DcABvmHLHXQXAj9JnbMYiyNum7m+898YXsyL3Ksbaen/S2AATUGlbPyF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yw1XbxRp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fe076f911so848285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707157707; x=1707762507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0tdf3eyAnzGsNLeuGvazlCndWizgRVXM7rJoHxIMZA=;
        b=yw1XbxRpsOo73hOsMVv5s6bhobH85BTOY2XsuRziUpwDW/96r2tGuPYBjQ6qrwGDZg
         BWE3fQV38lIBkAYmQY3l+scaSpCb4YztccKcGHxd1Z8dTuqPBAMkPnK1G1bHJ9qWnD4U
         Vn6Yib+K3RJ1KTS3nvuHbOHWOALk70kDKIPWhgxcTMluo2YJ52eKk5ls2aDd0OUlxDzx
         7UlLh8VitdobYN4DXD+clUC/VWI6XHySz1qlMRDiHG/YqLJ0GHIoJUCcxQuUzl6MOl+g
         XPGc5JOjfO4ziIzWxfd9zG10HjyNSSS8S0fqRhjK13xwpmgHHY/LhSbedrfr80SYKPGM
         KM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157707; x=1707762507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0tdf3eyAnzGsNLeuGvazlCndWizgRVXM7rJoHxIMZA=;
        b=Ufe4VSH4hIeWB9oLS56zZnb0PzL+qAD2aiQ6lE5DA/A7kWtE++zzmBKqG541ZIquHw
         B2W3rRy15kfzEcxkdiRF/qb6a/S7z/BJkLdQsKU9F6vKI+/PiVbUz7Q4al0iTmtzCRzQ
         Ex+RNQsZp7q0YbBdnuLM4eIurop4uVAg6m3ssMdhxYmiAFPWrZXggejHd9vxlNPkFtJ5
         pvN3DwECW1XEbf/uenWkLg/TvhCL2PW4IrkeyGv1WS/Bs9jRUi+uPL4TS0JqBL4GzTu2
         FvjIc9Sp6/pxVP4GZveRj7eQaEdxcng2/20qlNToXtJVub1w6IRzusqIu5JByGJ+J/dm
         1CXQ==
X-Gm-Message-State: AOJu0Yz38Oi7Xm3xrobQewD+8iKWEHgqh7QRQeTtsyXO350Cwd7yJEuG
	PYF86nNqStZFXaYy3bNhbi5kjm0jf/z2lZ9xQM96cqaq5vrxFBJcwnMdhzcpfNU=
X-Google-Smtp-Source: AGHT+IHu5p1ceHFoAUa++kZkcnC3iCS/21606cNviCdPf+6pX55U9pu4oXhyXtJF6JmtMSV/S4UbKg==
X-Received: by 2002:a05:6000:1a50:b0:33b:3ced:a5e1 with SMTP id t16-20020a0560001a5000b0033b3ceda5e1mr243568wry.20.1707157706813;
        Mon, 05 Feb 2024 10:28:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXGRBLc/LqneVab/oV9PBWtd0RCAUMnY+sHtiXRGVsKANmqAxba5G6tcECdeTHHpnPjSiRcWsn0zChBXJhXgszshnBOd8Fo4Cj+AKcG/InSph0+OfBODs8GtnACDq1QZFrPjNoT/9TaP99NGEVERvaiMDUv5T1RwzKhLusUZaT7VkuMDHmKJA8JCP0fuYkdxXLFPnEkF08NP15WVLhbjbX6p+XLug6x+NnFcqpz0ur3KAkGug5hR8GYEQdWRXUtrDEBqhfHKFnXInLjJsL8Wm3GMtfMPXDjAHID1PyLgJ0Czo+jFBDbVcuRpbiFveU8BhIBDGSEdLdSFxxIxtCdvYUr3byl33M3nbVLB86JNXQvjGa4WiTITOSM/9coD9i5fuAZcundTalQx1ubNGKPncUEK6I7RJIQaaPond8W0bfcnx1yhQMtaLx9flVGFEMgwBAcQonQWGxFapvtuHMNq+xGPMZ8xgCi8+D0PXmcSfQYy1i4PBjxo1l5+XHbXdzcBtJkqOQ8sKPN6vHawF5djxi6Iszoc+WcxzBwECWeruU5VBw0asO37OMCk1HX8Vbq0BM=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0033b17e18df8sm203229wru.12.2024.02.05.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:28:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v7 06/12] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date: Mon,  5 Feb 2024 19:28:04 +0100
Message-Id: <20240205182810.58382-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>
References: <20240205182810.58382-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 31071a714cf1..11638daa2fe5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
 {
-	dma_addr_t payload_phys;
-	u32 *payload_buf;
 	int ret, payload_size = 5 * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
@@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       payload_size,
+							       GFP_KERNEL);
 	if (!payload_buf)
 		return -ENOMEM;
 
@@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[3] = 1;
 	payload_buf[4] = payload_val;
 
-	desc.args[0] = payload_phys;
+	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
-	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
-- 
2.40.1


