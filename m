Return-Path: <linux-kernel+bounces-98738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA6877E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F316F1F2107D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA938DD2;
	Mon, 11 Mar 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syi7ZpMy"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D617578
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155236; cv=none; b=cokNiGwel3rdZfBnGlFWXiphTO6nDwb51wjOOyVqEepcghmJQwnG0dHtnk+CaqEuuCKnBCH49jox4KaeItiy2Zs9e/LsAh6UNpnF5YddjL6J/nlAhDMbO5ipDy8bE5zN+wN1QvTPNKjBRRM+ibOp45o5YLPCfADD3YNbaYNUMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155236; c=relaxed/simple;
	bh=W91ZrmkUCWxCeZ+4LJQ7adpppMkeWqBS7Bc3hAOZz70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGu9beDGTmLr+bKgCKE10p7VC7DGUGmVlgBpH1X9EPu4lxBEN95kjTt78EyyN2xBrLI48IWe6c05x3t1zK61NSq1cJfj39ul4DWaockNmz5msBIXOt5BUvzNEcLDHmm7F3CvpK0EfZx8SVOwfsHHc1GzhZ3fkwu9OK2SBYGi6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=syi7ZpMy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5684c3313cdso1519015a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710155233; x=1710760033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/U246wolXDSM1/ZcSZeXGHTTK2nDt0fXBaa0zSz5qY=;
        b=syi7ZpMyi4haWZoR8QnvDcU55YsKvq5CQ+0PUUhFRHjcK3Ojao7vv8pIVnF3lnn0CY
         ybTX3k1ei6L6TkKdLC3tMVMFCAoDCpEoeYj+3pQFaTXjw2UnEh5rXqukOST1SrJcUrqy
         LXLLdZ5x1lCdM6LcfwfL0+LpSYX/6gLyW8NFfyZNd5QTDH5aPZ0cFP6SvUGKqjxtUKn/
         lXv2UHoFZ65TMK8g/n39oANLYe+/lj5DdNS4342qjLjpFjGglWt6TCOKPB8RqZ3O8ENT
         v5yGPdqS5HT4i6FzdZgu+8adaDXlydX1EXiNP9cpdgdaU1sVfVTCiOkEN7ae9VOLQ8jr
         z7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710155233; x=1710760033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/U246wolXDSM1/ZcSZeXGHTTK2nDt0fXBaa0zSz5qY=;
        b=qhac2DXc0Q4JwKHAPFu3MWGvz6jbQXyNmnchiJKvIv6yMR3vQr6JelR7POuP/8l0K5
         qbrdy2eOR1fmPncZVU2knEgxpqzXiWTnKu8VsKahLt4vJnro9fec7UE3JwLwWJGdO0vU
         XJb8xC1MriyWsWza8JYVsojYLt3KwIey5fZbcWSz4FGEVs4mmFxj+ECz0MrxX1aqw3lu
         vO9nt7o8NKNbhlRaXUPQZpJmkUyhsmIyBSUazXYUBRS+l7IQfDlxF7LRQdW1zZhllqF9
         UEfOaDL60XJDbNwJ8450dFlQ7efoK6c9yJy1DjDLZ8976FGkqaq60yZ+rHqFBSMmgEVU
         JoYg==
X-Gm-Message-State: AOJu0YyInaOs09Jd95me92C+/Qyhn0WTqR57vOFiuWOYJ6YvRUkgbsz2
	3NZwCycUuq4m+aeMrhIOZ8nfSJtdM/gN+dlcgD6Ndlih5WHmKID0y1yB+j4owAlJPg521P9HdWh
	e
X-Google-Smtp-Source: AGHT+IHkT/8COS7ltQFjrA4huqIOhMcomaTyFCwkuAWJsY2EJsLFmGtgTZsvrj0L3/jdm88MJ6WGkg==
X-Received: by 2002:a50:a45a:0:b0:568:32cc:f808 with SMTP id v26-20020a50a45a000000b0056832ccf808mr4328969edb.15.1710155232283;
        Mon, 11 Mar 2024 04:07:12 -0700 (PDT)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7d158000000b00568525ab2e8sm1436581edo.55.2024.03.11.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:07:11 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Marc Bonnici <marc.bonnici@arm.com>,
	Olivier Deprez <Olivier.Deprez@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v2] firmware: arm_ffa: fix ffa_notification_info_get()
Date: Mon, 11 Mar 2024 12:07:00 +0100
Message-Id: <20240311110700.2367142-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FFA_NOTIFICATION_INFO_GET retrieves information about pending
notifications. Notifications can be either global or per VCPU. Global
notifications are reported with the partition ID only in the list of
endpoints with pending notifications.  ffa_notification_info_get()
incorrectly expect no ID at all for global notifications. Fix this by
checking for 1 ID instead of 0.

Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f2556a8e9401..9bc2e10381af 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -790,7 +790,7 @@ static void ffa_notification_info_get(void)
 
 			part_id = packed_id_list[ids_processed++];
 
-			if (!ids_count[list]) { /* Global Notification */
+			if (ids_count[list] == 1) { /* Global Notification */
 				__do_sched_recv_cb(part_id, 0, false);
 				continue;
 			}
-- 
2.34.1


