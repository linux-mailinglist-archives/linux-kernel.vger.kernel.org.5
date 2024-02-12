Return-Path: <linux-kernel+bounces-61868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C02851796
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41611C218F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA43BB3A;
	Mon, 12 Feb 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7m+9gvy"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA273BB47
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750364; cv=none; b=T3Y9hKuRvjSmI29+dS73670DwBb/znLCqxfl3DMNRQFw8tw6z6tfSQcZtfPThmxEh3GTIJSH6PlQOGZyorsO3ZHTFAxd2RvYnJoBV4o92NnOTQDAK7xu54XvF/wzXdpc7s17h6IrgoNBIsgMNETlQ0iAwO27r0d3kxYkMEBWk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750364; c=relaxed/simple;
	bh=jPajhqOmFKfyYBx4nGkBrnnNp9aW0JQUFwS8L+jDgWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4+TG8xSCYUFwBwph2GKOrfUZrw7q2IYgU/OdycwGyFtobFLAbQa4nz17gghPUynvoUq2XRDUu/pW+r8qlAFaDqy7CuoBz+kMk/kwkeh31dUvl7Iien8NRK5E7uIEIlxC13xrsEw7yVSvlmSgqZY638mZL/F3tUd7YqQtFFU5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p7m+9gvy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411ab6dbcb5so366835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707750361; x=1708355161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHJkvFek5nskp8YFkfahH/rV0FpJ+iXEjjaNhn1yFHI=;
        b=p7m+9gvybtZoNME7Bw015BmjZ/krijqJu9zSec2RufQTfD/9o2wWeGfMl4Y+aEwgUs
         zlfc2xQGXnNksF/D4UEiF5LqQX5E9uGXeurBNBPbPvqR7KPhD9wo1rXIomqpSiaMraRS
         6fs3NHl8LCZtbd38ns2T1mQFk5XqoJYRrU6z3NlvuYM0JdUWky2SueGx4BhvOUAeRzD7
         KxHf/mq+ZF8nKH1imOBm0SMJ7HbZMhdgd77DjOKfIq7kp4yoCuF8WwX5ruRc6ovhyIUr
         pyWZAFes8f9Lp3bJ2jHy1zvQHpygCsrMz6eMYGHNLgopOfEgmXbCS7khuqap2W6TO/9F
         wEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750361; x=1708355161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHJkvFek5nskp8YFkfahH/rV0FpJ+iXEjjaNhn1yFHI=;
        b=fbmXa+JN0Ytdb+xrz/1GIuMozAD6jyWUFF2TcVsACTf9VEbBCwYqXFd+ihiKRZPX0S
         XimnmEYUjHODpdNbx/fCsxmzrzixrJ0SkmdS5V9ayLsZW+rLb9/cjRtEzLNv0HFCjyIZ
         u4pMpQz0twuH891VM/jF0M/TOrcr7V21+5bjZzmClPWSxEfHvRQbzIYN8wCfC2NCmrxu
         b8SmZsMDQmxtlPT84IduS7wCxanHkxk1lZo5hgQV9rSBODARgdRcRULaqRKxa1QePvZY
         aZcKf2VOKnw9PPRNOtq3silk0m9cdmq7ijHr6Fnq8J25Ib3+S8Mwz3FNm34F6ENyW+8w
         2omg==
X-Gm-Message-State: AOJu0YyKjTftzFq4EehI5UjywBM2A/JKI9hkP2gQIEbR6thqgJ+FeXId
	JpVmY4SPkbcOvqbU/cF81eidJu5F3y12HtNnoq0jFKmLD/1rUbluU0SHLpGN1P8=
X-Google-Smtp-Source: AGHT+IF7rSSg95nQoo2b+8KCj6TBkuLX3+NRVXSWaWYHqrguy3TZPywsPWzP+6EAAdZlO6egxgo/5w==
X-Received: by 2002:a05:600c:1c85:b0:410:ebdf:73af with SMTP id k5-20020a05600c1c8500b00410ebdf73afmr1547417wms.7.1707750361294;
        Mon, 12 Feb 2024 07:06:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUACKApFvJJVxUQMCHD0+UnXJmj9tUOuCj/KyGj7SBipKo5FtkdZOS7UUbfB1SWPJXybQ6L2ULyxmRopRfojiO1pK0egJLqd4SxdQurb3S5fUZFoXvmYvrXte4Q2m7ehvMjExg94fTQ+G3y6C1gMn7o8YCAbzmFUeExVVRU6r7jy+JRy1dr+U/9RTPoPpmbi5OwfIWQwDA1oeJMb2+RMVDdQxGdaOSZj0VTUourLhIrtE55ue+9eShli1qBKQlws0xzm0kZA00B
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id cl3-20020a5d5f03000000b0033b7ce8b496sm4437959wrb.108.2024.02.12.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:06:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: ssm7125-xiaomi: drop incorrect UFS phy max current
Date: Mon, 12 Feb 2024 16:05:58 +0100
Message-Id: <20240212150558.81896-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neither bindings nor UFS phy driver use properties like
'vdda-phy-max-microamp' and 'vdda-pll-max-microamp':

  sm7125-xiaomi-curtana.dtb: phy@1d87000: 'vdda-phy-max-microamp', 'vdda-pll-max-microamp' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
index 0dfd1e3730e9..29289fa41b13 100644
--- a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
@@ -421,8 +421,6 @@ &ufs_mem_hc {
 &ufs_mem_phy {
 	vdda-phy-supply = <&vreg_l4a_0p88>;
 	vdda-pll-supply = <&vreg_l3c_1p23>;
-	vdda-phy-max-microamp = <62900>;
-	vdda-pll-max-microamp = <18300>;
 	status = "okay";
 };
 
-- 
2.34.1


