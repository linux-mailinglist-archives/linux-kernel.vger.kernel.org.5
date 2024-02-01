Return-Path: <linux-kernel+bounces-48580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3632845E69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ABF1F223D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5231649CD;
	Thu,  1 Feb 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMndUhjz"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97C5B05A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808149; cv=none; b=qDNLKpyxc/+lAlUYkc6zUA2EKul8MBmXgY3KiR+y/aCgORpT8bjI/T/jt/jk3jZXQVIS627mX6SyWNpqY/HPA3aoZhbqK245HK37STT8ah2kYVrwWHtNcg8ICfr3U2OZ8VMrQtO/wEgigiA38vWvzf/8JGydqdRXgiKujW/hHNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808149; c=relaxed/simple;
	bh=52w61SL9U4SK4WqY0kMb5Iy12v+xHbJ4FGKmp75wAto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFst0A/3vCp39RJekbiaRQNKBprMcyz7OsSam5G/woV4S2LHEIjLLiobczLs7srpgVm0zMEO7T/pt0mrYca93UnjE0JEgtnNqC44BljtcJRAeC/DJY/+4nGmbwgf17tFRvpuW/oEBj2qgwloUQ8FwmHq/47M9ZwacskkNce7bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMndUhjz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b11ea47d9so750122f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706808145; x=1707412945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Olzs5jHBV5th4bf/0xR3cFxQ7USKSVC7J+wiOfI31K0=;
        b=WMndUhjzW9TQPcwgkLtSGOWirOgslP/EJhR0OoeAAP1FsB244HQjLdRuM2GwSh0klD
         LBETlFV1GPHarU9wLt5xQPWt3QIhhoQ/3+oFjJByZymuhKl9/nryjxTXnL8oMhQPitj6
         BZ6gEumtyAUjj2pB2ZvG21dlyC70X1jYWUp6vrtmKadgY/kqnZ0M2ulsyQqBuOHXMYV0
         dKXbgfE7cb3WAAuQu/PVIEupH237b0zwQ9vA+LQ3wmQZjoYC0qfDesbarI2u5I9aSz8N
         G5UFQdRGen4X+c5zEDAGp1V2TXsq8lopatBC0XfHPn8LWX4Ia+dhuljTpg2WTybBtUUP
         sUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808145; x=1707412945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Olzs5jHBV5th4bf/0xR3cFxQ7USKSVC7J+wiOfI31K0=;
        b=CQSe8zcGwFjMPwlkIdwCNaHc4VAF1ruzpGRj3r28CCYJu4m9z1+YMqHPBs1VWQfUpR
         BqOv7z3I2iscePouHqSiRyvyMWwpVdLvCs7qlNsJ3cDRLft9w6ukz5p+4c+YIbGcYEpZ
         xJolrv4gkSjKI/ufQFOqA69F36FIZY/eftrMYFVu0jU0F9Pi0PuEHppurdxb3l5xVFQT
         Zt9IVDEXJjaJdjAbzE8/cH973dcIuqE243NzBR6BMYoPyBHq8kThUBpjWGBdfNAJuYBY
         0hrPntxSTRucVWIHYZ/2iVQ8AoRRz4pACxc8rOY6g8XYWEwdZavbpuCJO7YghGUC7MhK
         HNPA==
X-Gm-Message-State: AOJu0YywOEO0dRXUQ2v+Rg/cWzDCNnhDW9Vv14WKdvclwIB33jBqnSks
	0crAmxM7U1ZLfB+QRM1fMkB6HGfRDqcY6qevGlmAKJ9nXEYaxrFlt4sS6q7Fdx4=
X-Google-Smtp-Source: AGHT+IFpmBY54yA+GRbMJhIIQPcZ3OaDrFdyCo+12N3dtJyiP8+y6KOZsPaHG6a6biOb79hAePH7Dg==
X-Received: by 2002:a5d:610b:0:b0:337:9d3b:c180 with SMTP id v11-20020a5d610b000000b003379d3bc180mr4025840wrt.4.1706808145483;
        Thu, 01 Feb 2024 09:22:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXAyBCUGeofnISmWVvuayh3uWyPjp7ReG6k3Z7Cg4Ixith4cEy/8G9skYPPoXvjaLvnvvELl90LT/8UIpCz+FIb2gNldRtIzSIMfa3zk7ldRWyj2S/GtzBd0x+YuoVwvsOVeL2PGmo0wEhKpRxxmj/ldV0D4/uICodrORh3mxhdKB7LhY9oZtv4MDLlmsfkWgnIvH3MWc7BIF1NWvp4PR8cNidJKPAfyY30tqwaMQdEMX3vopapymYiwLjgaF0+XwjKsKzGej1zgHEy3qOZJMot+uKeLK8Fk5xv+Ky6qoeoG3vdIyBY7s3v/TpMUCL9k/Y+Q2a/Zktg5Ubhfb1cz2arRAc06pjbJ2+UBOprShdj3dGyr5U9/EdtAmwNri8XqoOBAxt0PgH6XrYoVvRuvvWomLMPJkVwkb1ahmIujePs+3YQtV72NoeQHmvbuUQBOR4EhVAv4d+iD44CS3frSGvzy2SuoeT0IoKkEdmoosiBqeAEumgoRDYMGlktdk+hDmpW+FT/YtCfdh7hTG/FyXjq1jqQOdKhH29mOhxRvqd1m0BzPDYACSx/if5FW+tylTs=
Received: from tux.Home ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000036f00b00337d84efaf7sm16733582wrf.74.2024.02.01.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:22:25 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: hwinfo: samsung,exynos-chipid: add gs101-chipid compatible
Date: Thu,  1 Feb 2024 17:22:21 +0000
Message-ID: <20240201172224.574238-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "google,gs101-chipid" compatible string to binding document.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
index 780ccb5ee9b4..b1d933808b6c 100644
--- a/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - google,gs101-chipid
           - samsung,exynos4210-chipid
           - samsung,exynos850-chipid
       - items:
-- 
2.43.0


