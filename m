Return-Path: <linux-kernel+bounces-55288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D5D84BA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BBE1C22976
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F51350F8;
	Tue,  6 Feb 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbsX+eXw"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D73130E30;
	Tue,  6 Feb 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235028; cv=none; b=H43upUKd5jiUdtCEhu/5C7m3zCsFi7g+mv93k7qT0UHqzYhRJ7+dKKVxWTCl5kCoPJHqmxFanIFxagt3BSVxkDVJRxnJnDzkiTKlmAvxaUwimtHmvEv7P7c/fFHTpjTMUk1KYlrFx8BBwlT1A7ebV4kxisHPP1CthW80qUc+4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235028; c=relaxed/simple;
	bh=yZxdr2dsDRt7puR0RK7vf8GPzQL3GlOUGyYoQ9A6MiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6QpPMeBZ1hiGYg1iBfEcJwr948VQ9bk/7UMAovK8cnVTpDnns0Snf8p0UVzTylAy/0ZxNcJNyjPYEb2WIHhyziBDXoff/PJ9j5fPNUjtW3HNR3IeByCEfNbF+Y/+3vseOxp7zGMVxSjvmUxWngF/2SLsZKFN0d0CMPzf9uMWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbsX+eXw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d08d34ce3dso42201781fa.0;
        Tue, 06 Feb 2024 07:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235025; x=1707839825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95yg+DTXxQL4KdqLyvezyeLaZI+ZLzl6szC4BlO6nWQ=;
        b=ZbsX+eXwxq9a5HKnhAFrWEREI8RfiH6fbcTsAtAh6Y/CWrjyJ6ohQxd+g67VOJI4/x
         L+pMyotki7wfHFtYIWs9XO3i+hDB7xXchJ8Gt6jMBc+yRHEFRxkLeaZtHIA/oqWcJHTk
         CGgqwf6aHsGqwHI9F/KxhS+zhsvxp19elhic9OnbCpTlXYQjK56Juo4JOxFmyr0xzFFK
         Coc4ZhN7TJQlEmVAXgVH26eLQgU47al1yui5o67JNLv8NaGwSKlmtK+i06/qBiWkTIE1
         noMdzwlUdCALvmlg25QKqC+43A2pa4E+w2Ugnow77IbbNbqK/pcs40jNqWgej1D9y3Lv
         tfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235025; x=1707839825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95yg+DTXxQL4KdqLyvezyeLaZI+ZLzl6szC4BlO6nWQ=;
        b=vNRdIElZCzVMuRt20qVIxa0rmdwj4jeXLugMwkBosnObvU2eQHZ2bwIXKReLUHgnVS
         IO0jh9TsrIBlXUViyr3BwKEGQTdSr4OBio2AIxXHxgOJzPju45o++boiWrxAT4ovI5Z6
         Z0ZtIZXXiqS2GZv8ISL5Y76jsscutS/HKNJkhgY+IflTL2faNTti9EcHndA9ivgtQDWD
         IuuvLZ+ePPDIrh2iOTmkWnoMk1ZsLdmztqV41k6/bVmXlOzSXZTYLqrL7HQNZRTG7wV8
         WB2BIi4Cz9NtnK5ovULxmYTdncGTMQTQZrbJ/71Kj9XeZtQB2ajDZA/XCBeD46H64QXJ
         tlUA==
X-Gm-Message-State: AOJu0YzZdv3aX7spN33mJ5bU9pttccD0qwe+DsNDl078lwKOLx6y+nxW
	Dw8kzKa2zjNVRcfegzb3VgHShOQ0hcBDOzqPdP96+rCrXH7C/7GlLDtFttvE
X-Google-Smtp-Source: AGHT+IEElEfg11Fm5ilaoCu9E/XweWbRKvfnK4ZZr+jGkrYtUBHUG7Kan/yNwYu1A3tb05mw7ED+mA==
X-Received: by 2002:a2e:9496:0:b0:2d0:a3ff:33d1 with SMTP id c22-20020a2e9496000000b002d0a3ff33d1mr2458561ljh.9.1707235024814;
        Tue, 06 Feb 2024 07:57:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXNjphZgRXY6uxtd0ZcZp/kbUGqEyyN6j+A+PqZbGhVqjmIv8jf7E92pz1CYdSuHWO8lh0j73WrmEoEcYX9zXubQlIw/qyhJhzogaUjsLuy5FJXyg8KabH/SjDbnl+xsIvvcKGLllEr5sp1kdw0HY8zyoeSdfW+rQT9j+fNTaloCJV4tYdzgdw8YKxckjcb2Ytb2lh7Sv/syfdtAzER8qm1Lpi/+tYETy1Jf9ZwBLLXW8hmVyGaAl2tGNkgLFpmRu1dR5p8tECTI4+83NiP0pw76WThNzC/bdYdKhkzf2gDEZdGOgOGlriaIv8Ljo8D3aegF7umiJb05MyYDcwSwgPG3ygH3FotNfkRnkXGiOJW5wyEw3mNdot9nvSerfl5jJsPWQ==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0564021ace00b005605716e755sm1149869edb.52.2024.02.06.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:57:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880
Date: Tue,  6 Feb 2024 17:56:41 +0200
Message-Id: <20240206155643.28749-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206155643.28749-1-clamor95@gmail.com>
References: <20240206155643.28749-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Add a compatible for the LG Optimus Vu P895 and Optimus 4X P880.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index fcf956406168..8fb4923517d0 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -64,6 +64,14 @@ properties:
       - items:
           - const: asus,tf700t
           - const: nvidia,tegra30
+      - description: LG Optimus 4X P880
+        items:
+          - const: lg,p880
+          - const: nvidia,tegra30
+      - description: LG Optimus Vu P895
+        items:
+          - const: lg,p895
+          - const: nvidia,tegra30
       - items:
           - const: toradex,apalis_t30-eval
           - const: toradex,apalis_t30
-- 
2.40.1


