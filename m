Return-Path: <linux-kernel+bounces-131432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25408987DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4298C1F22599
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53AB82C7E;
	Thu,  4 Apr 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZIzIfnH"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E413A41A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233674; cv=none; b=K9MjQMer3PdPk1sa+T/oHbbZF3hZlr0kDYYrlD/EL8b3Pn1zQ0ezxhNPMz4x6LhWwlDGpHH3/uTyRZTG74brvRpk8vFPW0ccp+l9QTQI7ZqlZTnKEYaXYvAPfPQ2fvzojYZ9YVBniMAayY/pKy84ZYKS8t4HzQwPy0abG3RrbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233674; c=relaxed/simple;
	bh=1usg8EVo8lpQx89y6EqbzjPZs8xvMoC2TNFiu1OGw0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpowaDPPHxefv1guLAwC3750vO0N9AkNkV5uKUI1wvtg7vOflMQyhqvjOREQdcuqiBl5y4gcHWpRdXCXoO+Wt7d17LUTZwCVZHrEWDBhCr7aGJCbCDSVCytAzMnq/jMlKN1pNNz7TsX/051jO5Y6ZbOhfBgVRux7hP261RMrDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZIzIfnH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4162c210c33so961535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233669; x=1712838469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2/Kxl6LpRi19aNU0GnPRsNjsIub/vSGQr1JFgUlFR8=;
        b=WZIzIfnH6HJ7sajXhnlneF1gm+bprHF1U58Ah9UEwE+H9i6X2vMO4oV6ihl31ghRwl
         MNRQYj8fjJZletlEGf74dOmfA+EuisSxrs2Tw7Z/52TAy0DCubRAWXXIpYo7hGREiO2f
         auejeMaB2Seshjovc5VYLUa55cRKk8YN/w4lHTlDzM++NOFLJXVBM6RzNRUDoOOXUoH0
         HA/wWgMobQp26f9xQq76gMQexyXcpc+6gjUIFUQCotuW4xA8isLyDkAaxVtvQNddGv23
         HXHsiTteEBllJNCkSNO2/vaTYr2OtkN409KlidGqsuVThurbaxN82/9q99XmQpBUdBzd
         cT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233669; x=1712838469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2/Kxl6LpRi19aNU0GnPRsNjsIub/vSGQr1JFgUlFR8=;
        b=YJTzQuMoOI1HYS8aFtd+kKp8fD5lvadKflx33XlFpSnftShEM0+i97oWm+9OKZmYrK
         Mpg3Otq2S3JY+sC8B2+IvC6E/5Q1m0vaCQyOLPCXa2cZYdJZXVcIX7FPlsoMJy+mNBg4
         fkszMhK15GMi852gBE2mbUdtMrGl99asqZL+Nm4Cb6oX2zb+8KESI9Acxyc7ULC0yW+2
         AxXvNkpQyGdY1R9l3C9+odpHI6D8zubWKaycIJNaUVm52yvmVfWDTHyVICIihV4a5QIL
         MZ/4epKCKSruq62QKINweKHGw1dq8fXImJoa4tAEqB42J/WN1XP13G7XaHW4C/JcXBA9
         rg/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjwLIzkvmYThxz0ZGcXhrcGqNJeMMpA3z9tRXBCYiq/8NJeLsai1EZjlIAucwJEkUvZidB/w9k0WZx5pV+AnI0oGOw5MTlsr1Q9WJM
X-Gm-Message-State: AOJu0Ywjcz4nm1cqSm2jmYDLbgVq6HQGkQLKbTOXDp/pBl40LeFFu1qV
	OKFUguGxC15YJTpx27ADJ60S17b8XRYOJHSjVUjHU9tp+MdTrpx2pgoYiY84OfQ=
X-Google-Smtp-Source: AGHT+IE4lWG03NrsYGIMb38leE/EL6KNHhTvu/DlJtCiu5w5jF8R4KkplAWIhngCJVQJeXTuDbWSsA==
X-Received: by 2002:a5d:58e6:0:b0:343:419d:ba87 with SMTP id f6-20020a5d58e6000000b00343419dba87mr1780461wrd.13.1712233669746;
        Thu, 04 Apr 2024 05:27:49 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:27:49 -0700 (PDT)
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
Subject: [PATCH 17/17] MAINTAINERS: Add phy-gs101-ufs file to Tensor GS101.
Date: Thu,  4 Apr 2024 13:25:59 +0100
Message-ID: <20240404122559.898930-18-peter.griffin@linaro.org>
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

Add the newly created ufs phy for GS101 to MAINTAINERS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 491d48f7c2fa..48ac9bd64f22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9256,6 +9256,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c
+F:	drivers/phy/samsung/phy-gs101-ufs.c
 F:	include/dt-bindings/clock/google,gs101.h
 K:	[gG]oogle.?[tT]ensor
 
-- 
2.44.0.478.gd926399ef9-goog


