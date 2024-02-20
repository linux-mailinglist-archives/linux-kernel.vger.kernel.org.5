Return-Path: <linux-kernel+bounces-72943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A062E85BAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38C21C24438
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED267E76;
	Tue, 20 Feb 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVuSZKCs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A167C5B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429823; cv=none; b=FpdmymEOVyGHSZCTdqICQ+kWLFOtRDP5ACOrN33KTxeoXNlYTbhxh5Jz1UruGMj9+DbCEsOgbsGWZqs5B6p4qnpBEK6rfXGM6GbRnR6nT0X3jQEZRShLxRz5oRfbBn3PlKBXdgVgaUMx2NojpsYU816Z+cHbL6+4BOqTQM29YsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429823; c=relaxed/simple;
	bh=CxiR74akScPcxbYf23Me48D1EuqZdg7o+HrvY4MWK4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra3wYUCdM0U3HI9zkQZpmn3CF0tCzzOqCYNOv9tx5s0EWuy/WVzCHX4KFHLth/icSZhVsE0KfDmwML+YZOp9yHvbwdgovLJzHl2KckDZVXjhOzuU3Qd3cuGdvixmsX4/+qAmiV1dLsz/wMi1VnBX1ICwyN9rb5RCvkAlD0hIf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVuSZKCs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7200152a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708429820; x=1709034620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLPhn5F1IILXAvLH2tiC+iCBpGghWpYxEC9f2Dxu3S0=;
        b=vVuSZKCsFFD3H17QgEjCqnLEu2PsLLvL3BDelHaGaTFozw45nxVf05ON/ZtVXG/ilE
         gtCrL+3aun/NlSdFPZrlYPnFBa1Zuo427Jmo7nG8PWsotDWJJAKQA22pLtVXRyf5G2Ac
         cTZwNF9X5mD+9ZNezjrJK8Jy2FeijIPn3kovulhvQvLdiXTiIpr00bUT9xB/4iegTOch
         iPlOBnzsdot1b8AdPDHZGuujj0pcz5fha2GwenhBR0gCBBltwvh9xcW4G3fwPNcLfMQW
         oG3rhlBdjQW2l3B8SUQmISpcL6PbONCYpibSR7q7fn5jSuYTs9n091GsUGdrn5vbhZS+
         qbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429820; x=1709034620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLPhn5F1IILXAvLH2tiC+iCBpGghWpYxEC9f2Dxu3S0=;
        b=SbTPQL7tjgC7QyrKC44mFw3lmTF2slrRA/O0RCKmkKOtz9056LQOwlf0dcixukRnZD
         BcBCsJrby5Kes3t3yiULicc+rOH9bRTR6VE6vI3i+DhFur+o6tU+UKWUEFgyb+NbYjdB
         W65L5OuOmHYYTH2XHz9iqSaOmzC3UDpLNTJXqCmhGsOEQycDUcrnEBjD8CSXqn0y3AeU
         ClHiZQj0KFUwBRG/9wpMKJNF8ZtNTloXZv3CA4v+B2tVwgc4NyBnQuC3YmbZhkTY5YxB
         yssD63+zKKYoGzbIp8Klzpavju6XZDBiQf/L90XYBXcK7dBr0pZpPbGA+e08eGTu9ihf
         sVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmkoCvOAmTgmIbuMAoGBbUkbxcSiTDmBdZRlXKUPjxJspXNY46CSdi7KFSXKwiE2Z+kjdOEG740aixH8H46+WNazeB1RKG6i+J3gQJ
X-Gm-Message-State: AOJu0Yw9PRhchJ5FnutvJAe2ZfsfArOdItDwXsMDMjFXdwkPodF89g8O
	f8k5YZtPv1QWSmCk9Qyq+0BkZ53gWYHD8KKlQrgjGhe4dNCkrf8PdxP5Myg9Bqg=
X-Google-Smtp-Source: AGHT+IEV2SGfyL00WThZuIpxrCxkMf+jEK6pTjTLPCvz1phzExr0o/5hORq48Qd+ppjGItJ2AO/NBA==
X-Received: by 2002:a05:6402:1b1a:b0:55f:6a87:8033 with SMTP id by26-20020a0564021b1a00b0055f6a878033mr12182959edb.31.1708429820121;
        Tue, 20 Feb 2024 03:50:20 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-74-232.as13285.net. [92.18.74.232])
        by smtp.gmail.com with ESMTPSA id u16-20020aa7db90000000b005645c4af6c7sm2317832edt.13.2024.02.20.03.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:50:19 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	lee@kernel.org,
	thor.thayer@linux.intel.com
Cc: kernel-team@android.com,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pankaj.dubey@samsung.com,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 3/3] mfd: altera-sysmgr: call of_node_put() only when of_parse_phandle() takes a ref
Date: Tue, 20 Feb 2024 11:50:12 +0000
Message-ID: <20240220115012.471689-4-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240220115012.471689-1-peter.griffin@linaro.org>
References: <20240220115012.471689-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mfd/altera-sysmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 0e52bd2ebd74..fb5f988e61f3 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -109,7 +109,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-- 
2.44.0.rc0.258.g7320e95886-goog


