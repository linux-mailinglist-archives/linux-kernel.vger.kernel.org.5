Return-Path: <linux-kernel+bounces-79611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069218624B0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0065F1C21B00
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048C447A67;
	Sat, 24 Feb 2024 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxuve0Bz"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826104317B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775154; cv=none; b=QV90zujDvtPsJAPuHdwTmkimH86KYXeQFOxnJ1WAL84nOngjCnKHVt83e4z5yLH4SR1VEuDB4uBtVb7yWVzveoXncW/JwmKC7mdihjyILPF9ssTfu5LdIrXPhDxLR0PMLMzJ4/NTf9UXEXMRqECA9XKub2cAnfmCmzfyu/RW7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775154; c=relaxed/simple;
	bh=TA4ETXsx3S0GLeuWu5ZSJ8+45soZV64UoCsLNAcK9Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tx/GEKN4EMMZ+v4zXzYiajbEzkC6mNhguzrAjLoV+ezliLpgYXTmz+hjpM3JioXr9ilwHLVu7s1yYPtb+NWX1BpHiMsSZck5Aqf4UDaq07K4TvlJ9gsXSiKM0ac0+TP554YiWBJaoGDZXlJqY0xwh/hK/l5CylDlv0FsdA4YrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qxuve0Bz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso1782438a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775151; x=1709379951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr7GZOkOAgNmtVmjzk3ZYZlo6pqWv5vhnfTOY0veyUE=;
        b=qxuve0Bz+RSfJaoNoPMB+sPjLnrsKTtC68lHIpPru2M3bjajGQsOWjQKKmy+cQKKPw
         K42eOrrb12xhVWNiZgmsGmlkQDkkiVSMjRfLg98Bph3YbPqQiUHUzozQMZZsOddqPx18
         dteIy6anFTsCIiMK69huaLtX4vvFtWz2u09S/WXMDVuuIcd6LgFazEfquzGdKyPs5Fum
         Z3wjjMI3gVA0GDk2q1NGCZGjwdZsh9AmCMQQ9aCBc5nBU7MRQ1ZQp1lh5k8BiX/Av7am
         f2US46G/ZvisovPP6KxgQs9vuILW+7OwTsaH7HfjDefe8J095rw9JgcMN871asv7Fvqc
         IK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775151; x=1709379951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr7GZOkOAgNmtVmjzk3ZYZlo6pqWv5vhnfTOY0veyUE=;
        b=dfsYHTEcp1GwTJwYuV+YEN3QkqsrbsK4DYxoj1L/GovcWRqv8okYkUBtcQyJM9fzHV
         1fU03Lqpv7Z+BKF17b0IQZTdGt+/1Hlts6rOqS74XQBZNlT3zTxIqbaloT5nEQalRYy+
         LipWcfbfoGT2ZkllBhQ/Ug49b5LlHwxAJ8AK4iRfEii0e1UMOqyR0osNplAgNQk6Uo6B
         aUh9UgEC0yQjKFS4UT165BDU+n/TnapSEA4GoChTaAl3OGqubLPb4dGilZYSPfB6gfBX
         VKuhlPU8eqK/UOdqUmw0nbVSyTsZLEiNBF1ni0p2s4bYfH/4MPq+66mqvXAtEdB+ozxg
         ARnw==
X-Gm-Message-State: AOJu0YxOO6P55aMkzuxoBKUkHY2s0AJ5fTpXy7pGea3w0Hbf3SYvtcLD
	9UDD/AUA0W6H2jjxpsOfmSF6uJEgE71Yxe2FDJ7Hn8U57ab0Ho0xZRVJqNZGcw8=
X-Google-Smtp-Source: AGHT+IFYNIFitYY/GBsvSxprzH6u3x9z/d2E+ONlWFg9lNKMIztrNKM18CC4ZwNGU4SUj4bvn8wQIA==
X-Received: by 2002:a17:906:2b05:b0:a3e:74f5:f933 with SMTP id a5-20020a1709062b0500b00a3e74f5f933mr1408082ejg.12.1708775150951;
        Sat, 24 Feb 2024 03:45:50 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:50 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/11] MAINTAINERS: Add maintainers for ZynqMP NVMEM driver
Date: Sat, 24 Feb 2024 11:45:13 +0000
Message-Id: <20240224114516.86365-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=FVGxPxo7dhefAgv0+pTOuq3PsgkfA3XqEYIs5C/hUlk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLVMAMEyMDgFRsk7UM4RKH5C9b4/vOUmW64 8T+/CnvY9iJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV N6eaB/0S7VoAO4aDysPHYTx6ZQbvF1A0D2z6nD1IfjlhgmGdgopX6eKtOBO3w0oT8yT7C7C3AMT PDoeThT7DgTrzi/KPgqozg0s/NN9GcE36CQVWnX4ZUiyL0/u8lk21nvh/Q0+wjfTkLm0XmcUGjX 0hTT8wlcRfI/zwvSPscVhgy+RfMPWFj56S4ufO1cT3xakA2pWVkMktkWgMLKpZ1SP0CEkZKlVZA 6A6GgKgtcqQAXVssR14+EO3RxnjSLOpE4cT/Dp7UnG6E2l6qVvpNqfmqXiwOUqmsAsSFbWvVkKW X4WRjpAwKsrmD6mCWbPR1XYLvBihzdOKN//ri8FTgU7YVsF+
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>

Add maintainers for ZynqMP NVMEM driver and driver document.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..b3103e03015e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24233,6 +24233,14 @@ M:	Harsha <harsha.harsha@amd.com>
 S:	Maintained
 F:	drivers/crypto/xilinx/zynqmp-sha.c
 
+XILINX ZYNQMP NVMEM DRIVER
+M:	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
+M:	Kalyani Akula <kalyani.akula@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+F:	drivers/nvmem/zynqmp_nvmem.c
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.25.1


