Return-Path: <linux-kernel+bounces-128559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0C895C71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121931F24A63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08015B974;
	Tue,  2 Apr 2024 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkN7uyow"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE315B572;
	Tue,  2 Apr 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085961; cv=none; b=P+vb+e+qwKtaSD7DXMlYJ32jzLQgUd8btUvEDiykmyyhbu21anuihVD5p1Ot05ZthU++DS40LMIkssIw19z8sV09lTDwnecAhAO/fGBVQ4I56aljv0yxT0luBqVtdQ6DlUyVGewPmLl8RVXkivXhakx3EWT3TKmUWjZtuKiZYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085961; c=relaxed/simple;
	bh=VAM/iIbG6sd0Vm+9c5LNdjtskIH9H5a/W1Fyy4k5ba4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQDsKQ3ALSRFMQben0IY3oxFWgp8D5NmebXRlYnhI3aWTxKXPFG+fisjmh13TtuwCdza8SiAwazcEe7qO/BdQUztj3FrJW6OgXNVaSLCsjocslyV4HORJNDhpUJfeD6LPSXkwMnzKx0e3h8h2hC1CtBvrRk9FZIA+GG3Q/IlDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkN7uyow; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6d063e88bso4052058a34.3;
        Tue, 02 Apr 2024 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712085959; x=1712690759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7rhLLUMHrwedBH2pvRBxfgtMkIBfb1Wwm96WdNqdmI=;
        b=GkN7uyowaDLZix+CkSyIoPeSHFu4zIjw+yamkUNh0I6Xj6ftCfnkfa8OoS1jUWnsju
         2Jr30n5fmIrAizYTBO0aAW29uJBX0dd6PAHv0hrFQeuwLtJCYQdzbePxMWhn44Gbpjxd
         Rw4o7Kd50IE3xmtOA3jodyX8eprupfLpwJQBIciJg8qOOiWhf9G+jOZgE7oQ22ojlfIf
         SuQZ16OhFgVdoSvrQPC/ALQoGSzaEHDG/5WgMrJAKwjRKmNW4cjyQVyFthHH9K6d8hVl
         keqBbvWDQ3mKxj8prLvd/GPtqkZgQsfkpGOrbWbxSmo+c6Fe5Rgc8ZjrBYkqsK0WUNjG
         61lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085959; x=1712690759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7rhLLUMHrwedBH2pvRBxfgtMkIBfb1Wwm96WdNqdmI=;
        b=wbyJWRN3RUsGot3LvdTYGs5d9wciPtItYHvXDLSbpHM0zDBZrydauNOV0YAgS2KIz9
         GJkVQAEQY51RwxqV3yk2BFz8fUTG9niPP8ZpwS+Lb6HIoDC6lw6fyJ5eHW0+X4wd6ziY
         FyT8IDY2CwoGlr56ST04xYk/SrWAHX1opDZzB41QzFCOrtzfN2MXM1D0hBYvZH9lVItE
         aLD016tIr1LIjRAsXFbbcwwHYw9gDDZBXE2sQU5qpT3th0T4DFvTzy0+ir3UF+l/mqo0
         1i/sBmGOhc/nILxSNM0unEn4PAtO9MaVUnV2wA5gT6NXSJzPgUhmMPATB236h+n+PMg8
         wlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUfC8ZOB0BJCyODuZFIPgZGXpDnLc5yD8M7LpzL2FtD2GbfpORS5nsZ3ZyCqQxDDEx7QsxdDIS1fMnxYTU33wNn1V9+KEdSvR72jdUQte8acq8tGZkS9z8jwiGESiADhgG6Zpf0PNVHthnyUEnS5vHVG6gwxroD+dsMgCLwfWvmAkF0LqJPTM4p8jnqlrF52Dyu/IfaSvRS4tkCKABK2iZ7w=
X-Gm-Message-State: AOJu0Yy0sqTCGd40iIqWNhLakCBZIzgDYPQ7kLyTckAFrRW0qUtW/HkA
	lRfwseccT9xdzgqf4yT2O6uENo74Gp9KTHAL3MK0TSWQY6x5+v0t
X-Google-Smtp-Source: AGHT+IEYE+r10McvEe1VUzjmFZOvDyoNfheZXGqnaJ8aS0qLvbp8v9xO8DDJgW+wgkaDNqWfMepAIw==
X-Received: by 2002:a05:6870:fe8f:b0:21e:e6d1:616c with SMTP id qm15-20020a056870fe8f00b0021ee6d1616cmr15659554oab.31.1712085959028;
        Tue, 02 Apr 2024 12:25:59 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id ld22-20020a0568702b1600b0022e8f9fa89bsm75622oab.57.2024.04.02.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:25:58 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: ansuelsmth@gmail.com,
	robimarko@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
Date: Tue,  2 Apr 2024 14:25:49 -0500
Message-Id: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the missing PCIe PIPE clocks.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..52123c5a09fa 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -216,4 +216,8 @@
 #define GCC_CRYPTO_AHB_CLK				207
 #define GCC_USB0_PIPE_CLK				208
 #define GCC_USB0_SLEEP_CLK				209
+#define GCC_PCIE0_PIPE_CLK				210
+#define GCC_PCIE1_PIPE_CLK				211
+#define GCC_PCIE2_PIPE_CLK				212
+#define GCC_PCIE3_PIPE_CLK				213
 #endif
-- 
2.40.1


