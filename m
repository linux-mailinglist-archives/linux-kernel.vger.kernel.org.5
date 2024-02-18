Return-Path: <linux-kernel+bounces-70365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325118596A3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C471C20A0A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B680612C3;
	Sun, 18 Feb 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U/qPtr2l"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD64EB55;
	Sun, 18 Feb 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708255214; cv=none; b=rLQxqGFZkO0+6oZopkw0F5ah0NRlAwqx2RcvO4eBnCGr9hc3I+DhS7+DEA6gnhz/zsCusvKT65UMdDid4Jr4I1B0kWbMHOMEHyurFJe4HaUq03/F3gRNxquKJLz4MDLOD5gcZraIHauVpyCCQsDjUUdc/doOeatvnSsqZQNT2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708255214; c=relaxed/simple;
	bh=zqnW28S8Yxx5VQr6WVf7DEutvm+PvFJpi9jbywhz3oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPOoO4a17V3VAMSMYPw/TvHSIXLi+L8NkGxEWVsBx1lH6Svdd8Ak5FU+SQGHiAL3Ojttu8UXtl+bAEP+i/z2A48cVhEs8kQar2rrtMGfXBRlfa3li9V1GpucyXp/5xpQ9OVDCFcJErKpdqDiHDpQDXHHjeAoEUzaHEGrPsJp3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U/qPtr2l; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5129c8e651fso1761823e87.3;
        Sun, 18 Feb 2024 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708255210; x=1708860010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTAPslvY13p4NzGhsLnW7/SPW/FSBPPIbk4inx6n6fA=;
        b=U/qPtr2lvtm8Y6SMXdC5o3QdbAkYWBxL9Ud3Wh6h4d1GxfStHFpWze9vS7MPd8pDKy
         KzSNhwpa4Pn/amGfBWwBtJmSWP+SyEBFxLWayN4zxVecNdg4VS6oSZDAPpt+ZVquZaOk
         4iLpER+x4ujUoaChdDgdMJK+eG00xvs4OpzPsYO+02ghcwGK/BQVHMcqM/7gkc4mI8mW
         Ou26VPq0WVVUkIE45ZR8xONlxbKLLnzN439O0OxfXPISI6C5PSFzP3w6Yk08bvdh1oGZ
         sDw3d/qQVyivFg3Wyd4NY4oH0wO3rv08OdtTozIcYNLNxoS1IsI78iLOZIThF0ILBTtN
         POPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708255210; x=1708860010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTAPslvY13p4NzGhsLnW7/SPW/FSBPPIbk4inx6n6fA=;
        b=lwuy6y9BkbY1ZgOFdVHYqRkngUOhatTLHTTGYB2kh+Fm81rcxYwQcXvgClAYCvMHO2
         ahNyieNQ9NsU5O1J2SunIy+kOgxAT+vMR9pwNFv4lG557nYQVFn3nRMWrPVKLMZHm162
         Bo4Hy1z3toVRzd+CLFc2nMXx7pta9b+EPCA7v+Rs7I2G3KAwKfquNfegC+wN9TXrJfls
         iqFEw9imMCauHiDLnXsDQbY9MJQsYCMpVhWpGWN4Rz0EROmSR3XdnqLeqNDRX+uHKWFK
         B7qS2jbVubmzKN9/nsB4JtxKocPjw8hpnkZEa3s8Qp4HBpxyp5F6MTbVRIZ/t6Mwrw3b
         OaRw==
X-Forwarded-Encrypted: i=1; AJvYcCW/f3vB5KofzSrvh9wTpQsSTxzSK9ycQGRpp1wiiruvEngB1+t9GiHl8PTiO0u4zuDOV4UwcTQYa+qYPBPWvusgHcjKpmSIgdVzwuqf
X-Gm-Message-State: AOJu0Yy5H3vMnOj0gARP5mzVOqiafT2NT8im3RtVZASfYgnf5y0S4jXO
	p2xWvPKx5bffhykTPbeSKRZ3Hijm5YvR/TO0y9wizBA1e6oCjks3
X-Google-Smtp-Source: AGHT+IGU3FwogvLK9Dsn9o6uvECcYP+s4KmRBN1wMYYeK+Xa3bpz+cCRwNNUFBq6Z04WlW7CKzBVyg==
X-Received: by 2002:a19:2d16:0:b0:511:aae2:e5e8 with SMTP id k22-20020a192d16000000b00511aae2e5e8mr5883720lfj.52.1708255210162;
        Sun, 18 Feb 2024 03:20:10 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id di25-20020a056402319900b0056401eb3766sm1675190edb.29.2024.02.18.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 03:20:09 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/3] ARM: dts: amlogic: Three small binding check error fixes
Date: Sun, 18 Feb 2024 12:19:56 +0100
Message-ID: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains three small binding check fixes.
Nothing functional was broken before, so no need to backpport any of
these to -stable.


Martin Blumenstingl (3):
  ARM: dts: meson: fix bus node names
  ARM: dts: meson8: fix &hwrng node compatible string
  ARM: dts: meson8b: fix &hwrng node compatible string

 arch/arm/boot/dts/amlogic/meson.dtsi   | 6 +++---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 1 -
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.43.2


