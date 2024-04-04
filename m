Return-Path: <linux-kernel+bounces-131415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1A898784
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACDAB240D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D8129E8A;
	Thu,  4 Apr 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMVIZZWi"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFE129A99
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233587; cv=none; b=KZBvtyw7fUuakuwWylLKiIGG7+/wsgtSMDTxslDk+7sTreerlwy/N0rVV9eCE4ey91prddBY9LBt1YiY3VSEWBwY9no/ZdAofAjcVjGciQ5XZr6El6SDcXtMJDGYMj9FAP7bsKgDpLkr952e2giOgdSRlG7wFfgAmIdgNXAutgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233587; c=relaxed/simple;
	bh=hmBS3wUHO0mONt4FlN4wFgGGwPzu6YR45Hg+n9iZFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiDOrlYRDAd5a0QgwFFSPLXDm3HiAGe5rclHyFY0ByHVh3uBl2d3MFvsSockwD46K4zXilg4DGV0F1+U2ZWqK4lhBl2XrHACbq23STQxfhfrpZp8gIiqi9nWwepY/VdUNPVh7lsfUi1JvC6iKjTPloSql0oOh7+booF/5xrZobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMVIZZWi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34388753650so409681f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233584; x=1712838384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXMXdhzuoLCLynIjoXzQvanMKsFRKu7E/3G3H+50quM=;
        b=gMVIZZWi1z2FkhN00xQ+9vw0OIo8cysxMi1K7veW43FyRARjY0LAKrwqdvWOL0ACmQ
         h87Vk9Z67FyZAJ7ooIL1l95eXG7TZxG29nqqc3NHBOte/N/rn2VKTT58WkEsLPq4UjoP
         tbKqE2eNEF8UGuTfN+R7d80PcLP0d2tP8CTApvdkXUEbKGyLFuG8LyiMp7I7C6ZAfsOZ
         fmZ+pwXoB/TW14/ree+87TxWxgAY4U6jCEOTYu7e7aqmE2nc92+brfKiEwCHbgyJLQhf
         LdqplzbB2SiIi6COgJNg4zBIesqMqEV32VxyjW10sBS801e6atOE9FHCgcxmP7fxRUHP
         purQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233584; x=1712838384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXMXdhzuoLCLynIjoXzQvanMKsFRKu7E/3G3H+50quM=;
        b=C5yCv0+DMS5N0K+ornBN6tYlZgAlUk/qh9ViHuHmdFkNneBDaL0pSRuxRlCQwEewM8
         FIFtGhIWkURc/g0OYKqRp7dQKgqMOpHENXCRVUHbDZZFdZPibQbYG2Na/h/376Mn2EPj
         7plBOmudojONOtmVCWBYvCMouG9ok5554C+TPDFo9oQdOXSQH3L8c9BoQ4sp5EcYoc77
         1WIVZSup4fyfrz+fM0G6ZxZfkB1uFk59MLpAEwkL/mWfLFtg+NpINVUJDMhrCXeDxSr/
         3Gh98CFe5uxdbAhUhgmBaH2/zB7sg7o1ItWoiEpvUO9SyOsLXIDZGFXooYaucqyGIc8M
         8amA==
X-Forwarded-Encrypted: i=1; AJvYcCW2gF11OsWvDGvU7AgYdsOAKwd7C1IDjmpYu0kQxQc3uav9Oom5IYpX20bGnMBW2iHKBQbODVJS/0yn19uGix2EEUfH1cHWV0M/SbJ+
X-Gm-Message-State: AOJu0YxdUl2xyN1zpQw0CLFQsheWQyP5nM/dFIbQ8T5aDsr+nX6CDm0t
	J8/1aokcU2C3Cn+1FhBJwlMKmqwt1jTHbJWNKNb8wEb7CbQ4PTDMSSdiwxp14pg=
X-Google-Smtp-Source: AGHT+IEApEjUKboR0OBWLDTAS6Jxlk1eQTEdQEi/Xza6SHa5181j+IZCoUEpXbG45sbONQ13Dr267A==
X-Received: by 2002:a5d:60ce:0:b0:343:9189:e685 with SMTP id x14-20020a5d60ce000000b003439189e685mr1644596wrt.48.1712233584399;
        Thu, 04 Apr 2024 05:26:24 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:26:23 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 02/17] dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
Date: Thu,  4 Apr 2024 13:25:44 +0100
Message-ID: <20240404122559.898930-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update dt schema to include the gs101 hsi2 sysreg compatible.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index c0c6ce8fc786..3ca220582897 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - google,gs101-apm-sysreg
+              - google,gs101-hsi2-sysreg
               - google,gs101-peric0-sysreg
               - google,gs101-peric1-sysreg
               - samsung,exynos3-sysreg
@@ -72,6 +73,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - google,gs101-hsi2-sysreg
               - google,gs101-peric0-sysreg
               - google,gs101-peric1-sysreg
               - samsung,exynos850-cmgp-sysreg
-- 
2.44.0.478.gd926399ef9-goog


