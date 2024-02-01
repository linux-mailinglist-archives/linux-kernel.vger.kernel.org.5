Return-Path: <linux-kernel+bounces-48581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B1845E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A131F24D73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB00B5E3B6;
	Thu,  1 Feb 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qYLvcazJ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F11649B1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808150; cv=none; b=ixdJuTxNPy9YKFmU11nluGszlpnkDceRVogBEDhJRXuE35pFF9NVMkDxfKruKQBfCNQSo6UNDjF+fvg0Inv1er5mUkMA+uG1aBCsjasLOBWsYV4BCf18bQEYJm2Owu7kGJl7fuidA1BkVDQ7T1Ui5Ky3PyZ3msaeP6KXMHJ3oQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808150; c=relaxed/simple;
	bh=iDCSG6+vZGjXW16iEBck9mBM4JX3eHfODAFknyZfAVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F40nTGqna+Ex/2J4yKJZEwFzQgF3j+8eCRtOySyxzI9oZTlG2e1qGnK+T7qJHZnModTUckQ82o8cqkTHBEMIWwNGLJu10TqA7dbqxbkZxHx+J/dBqZ0fKH8EMobx/d7x0cnKzP8/V8OQNlUUMlIrYaCUqdJe9/tgh/Vzbkq5xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qYLvcazJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b1b21c020so316952f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706808146; x=1707412946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqglFOjWZ32x4zOs0EjnPV29zDu0VG4eHKNa8brIj7Y=;
        b=qYLvcazJXx9p1dsjfC4x3p4+WU6KaSWRfplTM09YKt39xVXh/U02MWuxPOJ5pSuLXU
         psgKIpfC2SKYQcE5lk/H3oiguKfGMXOY+ywA3lA6v7yJQ7FemX/K3BA0s16WGFv7OvsJ
         mof1WqDul2HQMI6wnFrLngMQYL7JfViw4n+dZFFn7uHIPGg48/PRhtYr8Cm2GRSn88KC
         6HTWXHVpPEA+Nv94R8T37phfBsOBx5LVwv730ypeJMSTeYCWCOcTCuPqH+JLw6Aw/UxL
         psntcE2484BlFH7xfIJilb9nlv7vJpUcW0gI1NzfqEP0yNcX+NLYrddfRqQaP5LoYjw1
         WeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808146; x=1707412946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqglFOjWZ32x4zOs0EjnPV29zDu0VG4eHKNa8brIj7Y=;
        b=uh7Uus4LEdSBE/FItglqdqvekBX0CdI+fuSM1eQ6OtpD2MMtuP7vAe+6P5IllXR5+D
         Hq62Ei49BFBt+6xlK1z3n6Xq3FFzCq/TCe+4J+clUZI/44mSq8zdoKjFChAsiGa+pL+V
         K7nSyrtDd2Sl98olBTBdaKbG4BzdSzWzSIpFqz8ysrwvjr+tKPd6eu7bLXVR3y4Fqm1q
         w6lPsdg0u36sBz7MITGFHr+j67yc7gTyjUd9KiNAnBK3Xs3cW5wAWWWl4MtgoUzhFb7Z
         p8EJLDUNhqMrqiechuRXEzETTBDt/oyvPthr77XPfdBD9ezNGGegbtjoY4/owXU95BB+
         0HaQ==
X-Gm-Message-State: AOJu0YzG2f+M4qviuGtas53E2SYltUL64cgKvBp13j4UAbljmyf6g/jj
	AC2LF0xsjXcCk36NEn/fC+Po6zt+y7Jud2wFWe7Npeaq9p6bXst0+B1o44Kmg6g=
X-Google-Smtp-Source: AGHT+IEPETwpPLT1E0d57PYiCMFFa8neKAkGmr8WdkDjdyh4iSPX4yWVBK1s/n6op0NjB4Pd1FxqUg==
X-Received: by 2002:adf:ea0e:0:b0:33b:17fe:7eb7 with SMTP id q14-20020adfea0e000000b0033b17fe7eb7mr1680144wrm.68.1706808146473;
        Thu, 01 Feb 2024 09:22:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWgDLUJomtN15g1opxXiG5rl9OiizKz5aXqpR/8NPTgDztCPLP6LXlX7gvUorVckRh6tNcOnnHb/o9tfpkM9Z9nXJtRde1/rnPToLU4WUCqTTg56TI7h+7qCLL+cwtpNiii/y4BAUVp8R5A5lAhaFi71FzU1lq+B0HMMnnWl4BaAXVB1pNLC0h2f40vEcIf05wcoiseoVEXcRQQEeqwQ1/OiVHDNsSmjoQhjfWyFUNG7Qj5K1qcogJ6HfnD9Cpymu/+hh/oApC8rwDaM34+QXVfkwy5VYC35jZbwHFUBtgBp2sGXrOr911JQNer/YMppGebUoNHOq6kkFWMWOPWVUTpFxG5fyAZYZ6WYQ+2hPd5BckOWVXUEXTJj+dAw41ZlzCDAWc205uhF6sEfynnmz2Jii+xyhiVGdGOR6Ts0UFRfG84GcQ01K6T0gn8XbbMCN/carFJhdlx2T/DEviVD4FNPqykzGpWkBQnPqdN5dQ98JB3fHeSzpuCE9Eu2ImZCpAQae60DxPOawrxrGrQnm+gXgAMLgdFV+iN3uWhtOMMO8MUymNISDmDh4XTZYODt2A=
Received: from tux.Home ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000036f00b00337d84efaf7sm16733582wrf.74.2024.02.01.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:22:26 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-samsung-soc@vger.kernel.org,
	semen.protsenko@linaro.org,
	peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	klimov.linux@gmail.com,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	arnd@arndb.de
Subject: [PATCH 2/4] arm64: dts: exynos: gs101: add chipid node
Date: Thu,  1 Feb 2024 17:22:22 +0000
Message-ID: <20240201172224.574238-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201172224.574238-1-alexey.klimov@linaro.org>
References: <20240201172224.574238-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d838e3a7af6e..156fec2575bc 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -283,6 +283,11 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		chipid@10000000 {
+			compatible = "google,gs101-chipid";
+			reg = <0x10000000 0xd000>;
+		};
+
 		cmu_misc: clock-controller@10010000 {
 			compatible = "google,gs101-cmu-misc";
 			reg = <0x10010000 0x8000>;
-- 
2.43.0


