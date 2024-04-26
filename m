Return-Path: <linux-kernel+bounces-159988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074DE8B3749
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BB11C21F24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690D77624;
	Fri, 26 Apr 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/wolc9o"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F21E87F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134668; cv=none; b=qmWwvYoF8Tzx45bx0kH6Gls/mUkmvIOf7+FnW8r5btq+Qdvi5ve3T4QX4YTPP0FERIMPomwSdcri1bU7jw/Ctmi7Wvtwvqfrd/oK8uXQaY3V8R9eOhQ1IOMm4zj1Z82glJBtZmtDoc4QGwjV8SdWdo8kwX1bE5y2P7tVml3c++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134668; c=relaxed/simple;
	bh=d/oaR76lqNG7xNtfX839VYSmrqO5K70+zhGXLKbDQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmtgb03JO7Ja6pA3QZDd/dP0Gq5QG77iP2tw5dDltbnakk74bjWGn54Z6qSFbSZbHsigLHXbOylgSkcRwPdFXzJpwzFYff5/Jgf+6y8SUXDc+IAmu3+6eLQ+YOLbvBVZgekZrH/9HObrPZWdicIU5l/8ZOzVbyd+LXID2/LJ374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/wolc9o; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5723edf0ae5so2272146a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714134665; x=1714739465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xiMpqWHu87fDT4J0TWysn4eELCjDaabUFZMQse25vy8=;
        b=D/wolc9ob4kex3NU5qR5VlNGjy7CycY+dz5VsD9mgF7Gs4EPgIomtoMpTSJs4FowkR
         DhlUY4/B7gfB4vFV3aX0Hrs9XeTM8GuATK3YtN9dFew72Y7Sr4mPFzi5aICTq+3DGjg8
         9jMl8XW2mLprfEyJfYx153kyaHdMn0ZubpfodUkaI4DBwtADy60dD4cZXFfqxLGw3Zyb
         hj+tdIP/V1bD62xYuhg9O+HraPWNqxwclMhSPldhCDMLUz9sfXfhT+G8t7Z4t3tAagXN
         HGQHFVxIHqwyAbWtnLyavTfDF9p3A4rUEvVL1uX8ip4J/Hw27BFWBS1jaC8Tb9ZgQHEU
         ilsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714134665; x=1714739465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiMpqWHu87fDT4J0TWysn4eELCjDaabUFZMQse25vy8=;
        b=IvRjSwWj6XpkmXQeAgxGQHHV+Xf5VccRKTH30nH8nIOCozkSGUy2FiKl0scNkaCNaz
         GZ+iXwNi4MH9BWytFjzM6AOU5MCjChhH8t7kDFOSBiuigjcz5RKGHCQMHrgEYDgMcZUC
         1u0TP1ybxNRgmzlh9JJYzbhOT5p+/mSAeMS8XSHR2oYLIzgOzdZ5x0+rfX6OCnmowFYd
         ncMbILimuUw0RaPN/EHipZEgxOT0zg99fi3zk0k8YWVdQfoEX3IedwyYZ13mmQLkZZuR
         d0mebVg3lxLaZ7duwALf/XZA4vr5507ricczv/f4kjIIbU5C5kDxbWDnWhFI8EvKx+FA
         z3og==
X-Forwarded-Encrypted: i=1; AJvYcCUPoIX5jRhnynGyW+ABl0Rq1qkXHJRDZLlafpHwMGjLsHAktMVO/PBiR+9FaECCgnh6oRoLqfGXoSFeqCVWomxPHzyXB19P4BSYAfbJ
X-Gm-Message-State: AOJu0Yx3Wf/GZ4FkYVwtrUsEbGf1mt3nDG/vPD3Ty7jqiT7SuzLZRKzm
	/GZChKgi1cItrzstjAW4QEkFPK/Ach2MO/WeLYnotduCUYvVeY15wQe02N8icpE=
X-Google-Smtp-Source: AGHT+IH/DanPdRwEVdnmt/V0koBH8Pn/HkA087uaLGGXbaFu8Y57wMImmUEd2BZTYXYPKYE5kon+Rw==
X-Received: by 2002:a50:baaf:0:b0:570:5e7e:474e with SMTP id x44-20020a50baaf000000b005705e7e474emr2039629ede.22.1714134665008;
        Fri, 26 Apr 2024 05:31:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q25-20020aa7cc19000000b0057203242f31sm6144342edt.11.2024.04.26.05.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:31:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qocm: sdx75: align smem node name with coding style
Date: Fri, 26 Apr 2024 14:31:01 +0200
Message-ID: <20240426123101.500676-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Node names should not have vendor prefixes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index f58da999a72d..b8b80127079e 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -405,7 +405,7 @@ hyp_smmu_s2_pt_mem: hyp-smmu-s2-pt@bfc00000 {
 		};
 	};
 
-	smem: qcom,smem {
+	smem: smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
 		hwlocks = <&tcsr_mutex 3>;
-- 
2.43.0


