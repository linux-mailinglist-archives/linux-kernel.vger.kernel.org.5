Return-Path: <linux-kernel+bounces-69479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D836858A21
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412E12894B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B91487E6;
	Fri, 16 Feb 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAdeAofU"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C9146900
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126109; cv=none; b=p9pEWtX6stjgIxR1CvJI/vDczicnXbKLTZrXsJZTrKNs+Sc2Nd5PFhZV5BBjWfySQSGqLJ9qnZtqMMF+GauARmQGY4QHdvTepvzih41uL/4xEYzmZHso8kZhFthtVb5I66hVlfAYoik3D29RAEdRmJRjdu/PWLO9t4vgTBOxXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126109; c=relaxed/simple;
	bh=o729TUA+/3yrI2XpDVI6zjAuiCqtDa09o5cSkSVCI84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdHqpsgU2fyKmb+yC5w/PAjW9rBfHA6dkvbGVLRpvgzCYi10AxUs8PSLS/dPuGCjQEPZ5kD01Bi8MBjE051MFaFdupqX7q1i0Vg0PP1owSn1JSVBLrG3Zq8qHYahsauIzz0X6Q/b50r47y8mO4UW/TZDQqIYbIwmRP44HTHMWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aAdeAofU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e11596b2e7so898130b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708126107; x=1708730907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXaXr91zE2iwkpuzNYcgIVZmRt4beRglHQkgu1Q6RzQ=;
        b=aAdeAofUkuGriETMEhZoVyVzihIClabjD93JxqPUpsCpx+cjIIwdjairmGGiP9XVog
         GKVQPfouu7Am3DMuQcvxv9NsuC4ryxtKsFeZnm1twN41IGuIn2THndk/4xq9tduhBoq/
         O53B+kIEOv8pcuFnqPogxIC5SMa6FpV7+YJVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126107; x=1708730907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXaXr91zE2iwkpuzNYcgIVZmRt4beRglHQkgu1Q6RzQ=;
        b=NNuYNXe9yzQGPBoYth4DV8Rkew5AFOMXEg/UYIlY9XZ5nt9ocN6o1LSGoK6EBRwYH/
         sFmE9F7IdO4HEAuVR+fNvsLYW8eHPq5OkiOI+hs3BrFVYJw8eFaOsRFTw+Pgx4GqePQA
         sLWtBBf1lPwGhFr5pzmssZGrkCAZEL5MbkCrcntLzQpswfp+xEDfdTcvjmw7tkyF5zRI
         noQMVGu9Vwhnpd60a3H+nvrS0LmpD7p5rOes6ZA0HW5Cp8a79C6wN4UQEGk5vPJyuJ8k
         Eyq3z4UPsGDv7JTI9X7EMM16Qb7rfxeebzyIjPKWjohbQpH8zNzLurq4C1q1iX95uPno
         9zmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkAwhaATHplHbuoDrNxfhKdox8fjcnKPvAnM6j0Fmb8TxM3bxKzSYyUz5pylGH8Cs80O5ZDtyHNFQEFjUnjgnaE0HHXfET2Orm74eB
X-Gm-Message-State: AOJu0YxO1A7B2eh3dScnTpzxkemCL6XEOjEKjM0Tw2ktUOomYD3Hk0YA
	rkutmOdXA+aUb4CBNYRcOUKylf1SNImfogf65S81q1oMsAhAUQ1Z2FAMiVIKOg==
X-Google-Smtp-Source: AGHT+IHzmse8nnYR28KfPJrToxw6+BFDoqXkfVQ5zblzLbp8e/RsNZ3dw5J5POgI/1Eaua4oIaLVrg==
X-Received: by 2002:aa7:9887:0:b0:6dd:88a8:cf25 with SMTP id r7-20020aa79887000000b006dd88a8cf25mr5714710pfl.8.1708126106847;
        Fri, 16 Feb 2024 15:28:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm16-20020a056a00321000b006e0d22fe8e3sm476961pfb.116.2024.02.16.15.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:28:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Viresh Kumar <vireshk@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] greybus: Avoid fake flexible array for response data
Date: Fri, 16 Feb 2024 15:28:24 -0800
Message-Id: <20240216232824.work.862-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4687; i=keescook@chromium.org;
 h=from:subject:message-id; bh=o729TUA+/3yrI2XpDVI6zjAuiCqtDa09o5cSkSVCI84=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz++YdWhS9IIogaVrW9SXyH69n7HtxXWgzsEWI
 xIH+eLcTAWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/vmAAKCRCJcvTf3G3A
 JlTnD/4zwXwfUJWeKhGf1W4ft6eKbqeQCvVoNZQ9aKFDD0mrJwYRLvv3lE+NCFt2OV8fURFxPPm
 Zi0XIMgEjr6RCcAkWLMXn5WFQlCa7kl3VPK/mcTEY67RfFtM7yqKxQMCg93xlys0g6vfyvbwJD7
 tqiFLue/hRz/hoNvDTY1eNL/ssnp5+c9veBSEChT22FCQUhmrTh82/qH/oGTvts4/OqsET1papu
 ZaDE7QFWM8Gufc850aQKbdha9QGlsSkYN/isMz2o7dL88+015HmuZ2iAXUwqVAEvKWrKP/++Z1D
 MAfLPX9mUdUbMRrS4KSc07keJIyT8pldu3A4LofOHpNF+GQ0tVEs04seMyOBsFW9R3oyQGzAQQi
 Na55cRYAHTRU+wfJrcR/7KL6pLFiXzMxcuWvvR88O+aNjlK9TH4JqHBLTMWMY6144L+ajxsWkMO
 FrHOp7mImhRmyEktzBG2fXS17A4s5BXYsOiNTkxQzHGii7vcjNetNx3O9ue8LJU/2D5HLDllPf9
 c+UJODNrmtCD+6/4n2+w0QBLyzl9tHN3WdQPmBF8WkVgBoZvqQFqagKjKqFlqlSoh9S9k1WyD+a
 EEjjdpdCFOv8uxyFFZiBAhHhZ7Kx6U6WbXwQnOMJGn0pP/PsczRro7m59EI3yT88cICN6/FK+Uj
 X0M/NCL XdMlbTTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
code base has been converted to flexible arrays. In order to enforce
the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
destinations need to be handled. Instead of converting an empty struct
into using a flexible array, just directly use a pointer without any
additional indirection. Remove struct gb_bootrom_get_firmware_response
and struct gb_fw_download_fetch_firmware_response.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/greybus/bootrom.c         | 7 +++----
 drivers/staging/greybus/fw-download.c     | 7 +++----
 include/linux/greybus/greybus_protocols.h | 8 --------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index 79581457c4af..76ad5f289072 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -243,10 +243,10 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 	struct gb_bootrom *bootrom = gb_connection_get_data(op->connection);
 	const struct firmware *fw;
 	struct gb_bootrom_get_firmware_request *firmware_request;
-	struct gb_bootrom_get_firmware_response *firmware_response;
 	struct device *dev = &op->connection->bundle->dev;
 	unsigned int offset, size;
 	enum next_request_type next_request;
+	u8 *firmware_response;
 	int ret = 0;
 
 	/* Disable timeouts */
@@ -280,15 +280,14 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
 		goto unlock;
 	}
 
-	if (!gb_operation_response_alloc(op, sizeof(*firmware_response) + size,
-					 GFP_KERNEL)) {
+	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
 		dev_err(dev, "%s: error allocating response\n", __func__);
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
 	firmware_response = op->response->payload;
-	memcpy(firmware_response->data, fw->data + offset, size);
+	memcpy(firmware_response, fw->data + offset, size);
 
 	dev_dbg(dev, "responding with firmware (offs = %u, size = %u)\n",
 		offset, size);
diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 543692c567f9..2d73bb729aa2 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -271,11 +271,11 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 	struct gb_connection *connection = op->connection;
 	struct fw_download *fw_download = gb_connection_get_data(connection);
 	struct gb_fw_download_fetch_firmware_request *request;
-	struct gb_fw_download_fetch_firmware_response *response;
 	struct fw_request *fw_req;
 	const struct firmware *fw;
 	unsigned int offset, size;
 	u8 firmware_id;
+	u8 *response;
 	int ret = 0;
 
 	if (op->request->payload_size != sizeof(*request)) {
@@ -325,8 +325,7 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 		goto put_fw;
 	}
 
-	if (!gb_operation_response_alloc(op, sizeof(*response) + size,
-					 GFP_KERNEL)) {
+	if (!gb_operation_response_alloc(op, size, GFP_KERNEL)) {
 		dev_err(fw_download->parent,
 			"error allocating fetch firmware response\n");
 		ret = -ENOMEM;
@@ -334,7 +333,7 @@ static int fw_download_fetch_firmware(struct gb_operation *op)
 	}
 
 	response = op->response->payload;
-	memcpy(response->data, fw->data + offset, size);
+	memcpy(response, fw->data + offset, size);
 
 	dev_dbg(fw_download->parent,
 		"responding with firmware (offs = %u, size = %u)\n", offset,
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index aeb8f9243545..603acdcc0c6b 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -232,10 +232,6 @@ struct gb_fw_download_fetch_firmware_request {
 	__le32			size;
 } __packed;
 
-struct gb_fw_download_fetch_firmware_response {
-	__u8			data[0];
-} __packed;
-
 /* firmware download release firmware request */
 struct gb_fw_download_release_firmware_request {
 	__u8			firmware_id;
@@ -414,10 +410,6 @@ struct gb_bootrom_get_firmware_request {
 	__le32			size;
 } __packed;
 
-struct gb_bootrom_get_firmware_response {
-	__u8			data[0];
-} __packed;
-
 /* Bootrom protocol Ready to boot request */
 struct gb_bootrom_ready_to_boot_request {
 	__u8			status;
-- 
2.34.1


