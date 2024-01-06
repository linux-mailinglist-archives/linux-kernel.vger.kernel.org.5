Return-Path: <linux-kernel+bounces-18571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D612A825F81
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0767BB2278E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE9747D;
	Sat,  6 Jan 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWMUhiWo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDD7460;
	Sat,  6 Jan 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e37524fafso4939205e9.1;
        Sat, 06 Jan 2024 04:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704544935; x=1705149735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0Suv6vzFBcJ+SsSx39OTc6z6wFXvzjX7d7HBkY6jok=;
        b=RWMUhiWoFSkJduu4qN/InXxREDA9heLxndFLQaRyAA1vSTC708xPq4AdH+BeG0grgu
         lI7vW3eeewLZvVFcFxHaGDHyjgAK93yW6MJF38/lCcTJJVGV4XB0YJ4cNEOYPzJN+No9
         By6OZSHhNKpqrO6juExvFS+bRBLGOMWhSB/cisuds2F5MaDxHVLfXdbDS5/vNgrgpsWB
         aDiTnC1iosrNHbX0SP+gBS/tQDl6iNZy1XKu5IJWiNIP0eTTi9zb7y66Wel4lkXZMosj
         VkurzhSY8NlPrh7v7/DiqKtfiQ59VmQD8DIUM0p8JfFnNLgRaml6SmwkLNw7zAqflBrz
         ufRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704544935; x=1705149735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0Suv6vzFBcJ+SsSx39OTc6z6wFXvzjX7d7HBkY6jok=;
        b=jOD/kTbufEvw0EvfwtffHCgCFkq3sQ5VNEUymkYJOjbuIpw+nNPMEdcuVKbHzAGJd4
         kNO9ohuWVi/au4S8Dd6N6wMsLo6OhF3pAk5lNYaak7YXt311oiKEzc9bDl2fuC2EqMTn
         IyHoEascpkNrGJZoMJLjwM+G1iQpmVWIEcFPWuEKcwzyvX/v9ZRZnO1/dLbHv/LLxB5K
         02B8ljmoXQdOBF79382VLfGY45vO2O2MAMAGOin2ROxUbHT8zHHjGWSwqtteoOH6kJco
         M/5OtGEToiDUO4hVQqtwD8rc4Svv7Mn9nC1Su8fxoxTsZrUR+e+ZMamLRTCZFK4qcVx+
         61Jw==
X-Gm-Message-State: AOJu0YwnOzYe7yJ2AycJvOqj1QeBtgLhtNZuzM5pJSSDBfLc2VAFidgT
	QGMqgpd8yUxSG4JDV793lJL6KdRxsLg=
X-Google-Smtp-Source: AGHT+IFrkzRgV/gv7FAO9JRFh/XcDmwNGvDyTskg1q4LQSQ28sa30tIiulxogkC1T/j5A4oCCi0rqQ==
X-Received: by 2002:a7b:ce90:0:b0:40d:7fbe:e966 with SMTP id q16-20020a7bce90000000b0040d7fbee966mr518086wmj.40.1704544934665;
        Sat, 06 Jan 2024 04:42:14 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b0040d5f466deesm4568664wmq.38.2024.01.06.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 04:42:14 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Oded Gabbay <ogabbay@kernel.org>,
	Ofir Bitton <obitton@habana.ai>,
	Benjamin Dotan <bdotan@habana.ai>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] accel/habanalabs: remove redundant assignment to pointer 'input'
Date: Sat,  6 Jan 2024 12:42:13 +0000
Message-Id: <20240106124213.51392-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@intel.com>

The pointer input is assigned a value that is not read, it is
being re-assigned again later with the same value. Resolve this
by moving the declaration to input into the if block.

Cleans up clang scan build warning:
warning: Value stored to 'input' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@intel.com>
---
 drivers/accel/habanalabs/goya/goya_coresight.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/goya/goya_coresight.c b/drivers/accel/habanalabs/goya/goya_coresight.c
index 41cae5fd843b..3827ea4c02f7 100644
--- a/drivers/accel/habanalabs/goya/goya_coresight.c
+++ b/drivers/accel/habanalabs/goya/goya_coresight.c
@@ -576,7 +576,6 @@ static int goya_config_spmu(struct hl_device *hdev,
 		struct hl_debug_params *params)
 {
 	u64 base_reg;
-	struct hl_debug_params_spmu *input = params->input;
 	u64 *output;
 	u32 output_arr_len;
 	u32 events_num;
@@ -592,7 +591,7 @@ static int goya_config_spmu(struct hl_device *hdev,
 	base_reg = debug_spmu_regs[params->reg_idx] - CFG_BASE;
 
 	if (params->enable) {
-		input = params->input;
+		struct hl_debug_params_spmu *input = params->input;
 
 		if (!input)
 			return -EINVAL;
-- 
2.43.0


