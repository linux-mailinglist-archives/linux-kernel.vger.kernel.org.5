Return-Path: <linux-kernel+bounces-79601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7A8624A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA471F22EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ADC3A1B2;
	Sat, 24 Feb 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbu1n1+h"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0D1B7E8
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775051; cv=none; b=urVLUx5825SaZIqP+UBs1xxo7ZEc/9R5Gh1FcZ62w9Y+107VWwKejwByYIbGCLxkhvpr1oBqqoCHlGuOjeZ3OoHVPRIQnUjlpqYqoRyKHPG9+kXY3QuuS0EzCrjIRITxjzPL5ViT693pH1rAuHZk2zKr42569sOzMhRarcCKDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775051; c=relaxed/simple;
	bh=XFI+jtL4dDqjS1IqkC6vCH/t60+ppDDAH7TnHqYUluI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrBHFRzoAqq8XyMrGrgojm1oUbmUfacvbXbsUEFkXx4SO9MsUib6nfK6EBh/ouPDthGNvP1O+b8W0prTh8TiTFPh6aGCSZx4eB4066ZI9NUPtjQdYFxFrbXzVIFwCPiQ7y6mgJ7ZvbS1ov0MwjeytYxHgyLskcIGeCGsuP0b8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbu1n1+h; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f829cde6dso188202766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775048; x=1709379848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ73qLxfhu/ZV8dBUz1nsfOMW+79ShPz9dGKG5vZ5V8=;
        b=dbu1n1+hp9ur2aL7ftMa+pPEizGR/hJlb/NoB4DA+cXvyHoDtlG0PNL5wtO+CGxElR
         x6nBYx2JT4Kvy8y/tvCMefP/+N/3Bn18j4mxmgIdsWsZum7BS9VYGq8FIRJz7ffwMQuV
         djFzvsvuTkIueKMNsNJbDu5YP/9CASIfabOd11Y8Znv9vu+6w0RRZoau540AF1cHXbD5
         68zVwMlK0Ew9vL9bc/yFmWbiVlUv2IutVuildmV/7Miz55EwzMYnjXCgjGbSfTKgqMUd
         FnLp6d81U5EJY9sJD9TJWlxC+mM+qhJ2GBQfu9rKydLWHCR0POejfBN19DLua+mhH3Tz
         5rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775048; x=1709379848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ73qLxfhu/ZV8dBUz1nsfOMW+79ShPz9dGKG5vZ5V8=;
        b=T0IwdMYGZMaxQziqi+KukM2Xvl2pgDp/rivItwJDZMQflqAX7u3/gd0HaRJiyEiJ3D
         VGxZOH4LRhq41/DONsXKQZaIUaZKT5xBVUS+I79CAMOqi05BuscHPpjjWPwwDfnyEH0U
         jnVaj59Uukp7nEWVc2Zvr+h+JZDY09RPFicP8oUlDrI7Ad3eNIfJ7LUe9c46Xen10wVu
         iX0OWKzALsRzMthesn3WgL5ESalpjJTTTOiJ636Ct8UpAOcDpLY6eTSv4u6UlTRknOiZ
         veMryFy8QBLy38JlaP4RR0IzkIpxwHU/DexCAwH8f7+tlYI7ldrvk2Je+pB7mpk065Y/
         KnYQ==
X-Gm-Message-State: AOJu0Yw1muOCIHbbvOy5EfxlBupM5/PduynVxrFcOlSQNpB/UR8I2D45
	Mwxkx8pnwAhJbtTCwqha11UYT/0kcmp6Mm+s1jyPY2RtGIbhjL1zcVeNuOukfZ20Wmfl/+px7/u
	V
X-Google-Smtp-Source: AGHT+IHWW8SjFFGB/ncFo0Ri3/punVdTnOvpMr7gc6bjtVGGQ/ZtmxtFp5KiDGUrXa0a3S+q1CzZ9A==
X-Received: by 2002:a17:906:4e93:b0:a3f:55f2:a166 with SMTP id v19-20020a1709064e9300b00a3f55f2a166mr1294841eju.38.1708775048139;
        Sat, 24 Feb 2024 03:44:08 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709060a9000b00a3fc12516aasm510734ejf.217.2024.02.24.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:44:07 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: qcom-ngd-ctrl: Make QMI message rules const
Date: Sat, 24 Feb 2024 11:44:02 +0000
Message-Id: <20240224114403.86230-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114403.86230-1-srinivas.kandagatla@linaro.org>
References: <20240224114403.86230-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=3cH2JFkE1Y/qmADowsjF0mSv9O+KlgHyPg5CFZfsAQo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2daDJttsmchMsca//20z0OGqjGzuussbxu4QV wHWXem5+nCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWgwAKCRB6of1ZxzRV N357B/0dbSEs6sPQRaoMJmR5MLbe6P/eG0SuVVLBLi5uEIsMAnQDsZ9PHHeqsaA6CtemhWgJG3G iHoo5rpu9gDsfQmn9zxwC248lkLbk2g6oBngi1dFuKWKS9NVF8S+lEsM8uGxR1SoKtXkf+uS+8x cBluAVxvs5Abi+nLVa5rxJr8FjIF4KiKp1Y1Af9v1u44wuyWHhxle/vOVstZHRrv5S9b5L0XvmS FaQ/Xosh9sACrQT1OLW38oi8POdoNtB3KgGd9lTophusWCVlsgFMJL2KUYO8mYzmU6uy7dnr/lJ 0lAqWlNylaAy2atc8IQK7qLPRNL10MwA1+BXhopaTEkiRudv
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct
qmi_elem_info") allows QMI message encoding/decoding rules
to be const, so do that for qcom-ngd-ctrl.c.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 77aa6d26476c..efeba8275a66 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -220,7 +220,7 @@ struct slimbus_power_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -262,7 +262,7 @@ static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
@@ -284,7 +284,7 @@ static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -324,7 +324,7 @@ static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
-- 
2.25.1


