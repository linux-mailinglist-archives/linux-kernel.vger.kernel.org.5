Return-Path: <linux-kernel+bounces-162122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F93B8B563F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5E2283AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB233FB84;
	Mon, 29 Apr 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQhy+5SU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318B3DB8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389343; cv=none; b=ULYqOgikpM/oSxdlc+6/A3PdctpgU3YzI5vy5V95J+5PBV+JpopGEF/HeHpki05lQDzsyk5z+qoGYd+br3rf/ZbrHDmbWbMRyFI2bCASi9mY08emV3gZRTfExscmcoFCDovf3MTRH7m0yYRoTS/tl81cvxGcB6cjxrmiidZ8DTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389343; c=relaxed/simple;
	bh=JzIj7Ki7/qYo2GyJ0yGqA8z31DGWsapDsK8d7OOqKJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hv4Xe6+MwvrbRkKbudR8iWD51wzOD/SABBBLY95c/OujCnJLwRVHgeVTm+hTDnO61gY/CvPHoVjOaOoDymXhGe9kN1A4mD3AD/qZjsa4PGcZTL0n6lBYWC9C3IDiLNLjPoykkOSgayLTxDgBxZnPrYUKZwjYUemNL9kpDwhdQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQhy+5SU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso14550245e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389341; x=1714994141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yMbQtiAp8xI8uIG79aSPKFbh4ZvCdj/X4EWIhmoLqs=;
        b=KQhy+5SUheKSHnx2LgcjsSSWrvESFrY4SGG9IfT1t84PYVFqFk28032nd9dwK7aMnp
         FPu9bWOjTidDVEAUq3RV8RtESsRndDnpUQQyeBCTTUXQvAoGTnJk8gP8KKGxwBdxGErN
         ZyEWAFSDszZVsRzS5ahrS6NtgzxhJefmCxVKrvQLx+/oQB/u+x6PztgrnQS7CVk93h80
         1kybnVL4psb0VREp6SUwA5h4N3gDcfje2VI4nGIvECsNWTu45IkUfVSZtBxw5tkAyxaE
         Bmk0/uwb3kC0BrzMCNxuU6xuFyxz5Kozt4el10TqO4L3JfaLVaUQFfBqCNs1X8lTuy6j
         xV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389341; x=1714994141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yMbQtiAp8xI8uIG79aSPKFbh4ZvCdj/X4EWIhmoLqs=;
        b=eTcF7h/8QbnSSBlaQhYVvIyPKZfCRhviMe3+47bFNDsABndNC+TcohI7hbxSX1Jfac
         97PYWlLvNrT1EA1QwNuYlkkyyENBNBl5rWoBIcl6alaUo640Dv+WntdVDqIOyXznoFoi
         H8HH3A3kVGxY4hAZia+RSdD08jO49ZiaYqz1SVqS98bCF2QEE/4+cmtIyDUseCIctAb0
         fJ1eRNr8YM4YJExBOY0ryOibyulp1RppmNVFw5sN+jPiDaUCDXt4fSJsEADAOjsPOxPV
         CBtZ6ZM+fWg5G1hdUMnykcclp4RsQT/uHXTfsXQ/PkN+lvt5hp0bns6/3K/zyvKuWksn
         WEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIhofeUHGPWPBT++e31gN0N2Z2epSYwuRd9DjDZFnIyXtsWe2gYFhXAygfRjzJB3oDtDhpRrfQ/PjbadnI2kTZ+OC6OV8G1MpxPK9u
X-Gm-Message-State: AOJu0YyHiFqw7ovfuKrVV3ue3FLv0aLmIIG4yX1v40pjweasVWVpvkLM
	DY+uIlebiyGncFchX8EdV7AcDnAxisKR811RsVa8/TgU/2beK3lFksT8JjgjX34=
X-Google-Smtp-Source: AGHT+IH+JCOk3Uxt95Mb3k9cU+5p2y3OpKfXMIcAA3c1KVQYXqLwFESt2EMINrGvBHWGTBOynGRqJw==
X-Received: by 2002:a05:600c:1e01:b0:41b:f43b:e263 with SMTP id ay1-20020a05600c1e0100b0041bf43be263mr4052769wmb.0.1714389340709;
        Mon, 29 Apr 2024 04:15:40 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:550a:b373:6b8:63ab])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041b434e5869sm16005337wmq.43.2024.04.29.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:15:40 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 0/4] Enable UFS on gs101 / Pixel 6 (Oriole)
Date: Mon, 29 Apr 2024 12:15:33 +0100
Message-ID: <20240429111537.2369227-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

This series contains the dts, dtsi and sysreg bindings that enables UFS
on Pixel 6 (Oriole). From v3 onwards it has been split into separate series
as you requested.

Along with the various driver code UFS is now functional, the SKhynix
HN8T05BZGKX015 can be enumerated, partitions mounted etc.

UFS bindings in this series are proposed:
https://lore.kernel.org/linux-arm-kernel/20240426122004.2249178-1-peter.griffin@linaro.org/

Clock cmu_hsi2 bindings are proposed: 
https://lore.kernel.org/r/20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org

UFS phy bindings used here are already queued by Vinod

kind regards,

Peter.

lore v3: https://lore.kernel.org/lkml/20240426122004.2249178-1-peter.griffin@linaro.org/
lore v2: https://lore.kernel.org/linux-kernel/20240423205006.1785138-1-peter.griffin@linaro.org/
lore v1: https://lore.kernel.org/linux-clk/20240404122559.898930-1-peter.griffin@linaro.org/

Changes since v3:
 - Fix unit address ordering in gs101.dtsi (Krzysztof)

Changes since v2:
 - Split into separate subsystem series
 - Split dts and dtsi patches (Krzysztof)

Changes since v1:
 - Collect up tags
 - fix google,gs101-hsi2-sysreg size (0x10000 not 0x1000) (Andre)
 - use GPIO defines in DT and add TODO pmic comment (Krzysztof)
 - Add sysreg clock to ufs node (Andre)

Peter Griffin (4):
  dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg
    compatible
  arm64: dts: exynos: gs101: Add the hsi2 sysreg node
  arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
  arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs
    regulator

 .../soc/samsung/samsung,exynos-sysreg.yaml    |  2 +
 .../boot/dts/exynos/google/gs101-oriole.dts   | 18 ++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  | 42 +++++++++++++++++++
 3 files changed, 62 insertions(+)

-- 
2.44.0.769.g3c40516874-goog


