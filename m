Return-Path: <linux-kernel+bounces-112344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6638878A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D37B1C21020
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41457863;
	Sat, 23 Mar 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a50eC65e"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374954D9F8;
	Sat, 23 Mar 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196451; cv=none; b=ZKTPI3N4l7AHBsFRHdUvwbrwxmhkSbAdmlV1j+FzfvQqiCMvNkn57rmt/gV1d50oSNfUIkceqEtURRfOZlyH2fd93DvfY295UXgFmebDkcKYfwisz1X6BVAATd68KtCBSsp/Cllo4RKsolcSOIFd4ha8BbKk5gCFN1Upm7n+yIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196451; c=relaxed/simple;
	bh=pToit27TqLaZTZVIWd9WSIUZ1i+05Dk9aFS/Q3bfuoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loeBhR1awqP9kOBT45iguoC0Qxk4sjSXNmcLwBY1wBw5ePalYW04aTKmMFw8W1VzAFQizbR5Qrd0foKbWAwHFJXngKuP9leUG2skSmdKGZuDl2dkezpaGZDb/UbBWe6CljvnewlCy9H2VjpunaGsYSJ13xXvrSNnbXI7GFiZ1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a50eC65e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d599dbabso3872907e87.1;
        Sat, 23 Mar 2024 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196448; x=1711801248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xtVnBwEs4bYQsVbe2uhOnHxLXkyj8rDngprTSIhtgU=;
        b=a50eC65eWaBcRPKIcQcHSDmCk3duVu5wYKrISH7GjiTV1zbiU+N6OBlUug/hRrvQDD
         5rTVnP4OcvtZaPakEWfpTDkWKgHJZtpJGLQwnU1K0ykLtbt8dgcY+rNwtxhZU0rz+zKo
         Ha+hOgZSO4o5zWG0yjGlbu4k6fS6LOWbi7La47qyz1O7HOOLnVtuI4TXR/KH0O5qgy4A
         haTEXN0RNT4VaHMH+6FxeLmRB/H9Sd5SNRPLhYc9DpX0/yddEG+2B8BWE2als1s+6ZLW
         wQzidtMxBAXN5JqVQoeU5iEtkVAaQSAeIDCCl5Gp1nuraPeSNiKNcIS5LF8sORruoz4D
         FKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196448; x=1711801248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xtVnBwEs4bYQsVbe2uhOnHxLXkyj8rDngprTSIhtgU=;
        b=prvBf5ttBRmVLeeG4os6/O58nTA6iHEx4AXKUUpOmLUt+O8AaaTyBFxpEZ5q6ihJ6S
         D/h61/uW7ZnBTEJvvrU/c6sZseoMOlWv9fMOUE2MDLXKmEhLZquyHIR953bjct+A2s7J
         eRUN2sTy37oqfLWq6FFnQKIeg9o7zduVjWkVGNm1D1RO9qlLZMMVd9GXhH+ZhnRseWUg
         2Ji7zEvwMlYnn5aTXZ7+RRnjbU7iMX8FVLQz3W+wVT1MUmp2WcytD3otuDh/g6dDMksh
         J5Z96/wKrYbJA1KNnzrMzB9QMShmXou6HjPgOWhRYt9NPn98Cm6VKl+/Md9RHMwcurWT
         qS3g==
X-Forwarded-Encrypted: i=1; AJvYcCXIy5pvJHCu3pamlKvWnvCyu1zcN9Qgv6NOlT2BBShZaDoh+MXQn3dYRdgCx5yJGqbrhqvDlsi5BcCvLnH507tt5FelTZSJv4O7OEppI/lJKiJgQCEQLed8eP1L72bK54ZG9xgFPvkrsw==
X-Gm-Message-State: AOJu0YysA9gNW8fdSyfDNa4vgcghFdlbcrFx8OJMGcMcTF6/WJgYjFh7
	atSgWeaAHMOdtB8+OSGmUnfHW/QfJpQkmP1oetRnioTxW4axqODV
X-Google-Smtp-Source: AGHT+IEL9fGHncT0nfVkXdgNVn5H3HiyENNSgBkVIsx/OHDiKca1zsqf+jxso+E1tHLiUKLd3OA+yQ==
X-Received: by 2002:a05:6512:2ed:b0:513:25c6:e98e with SMTP id m13-20020a05651202ed00b0051325c6e98emr1535015lfq.1.1711196448352;
        Sat, 23 Mar 2024 05:20:48 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 6/6] dt-bindings: iio: accel: adxl345: Add spi-3wire
Date: Sat, 23 Mar 2024 12:20:30 +0000
Message-Id: <20240323122030.21800-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240323122030.21800-1-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-3wire because the driver optionally supports spi-3wire.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 07cacc3f6..280ed479e 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,6 +32,8 @@ properties:
 
   spi-cpol: true
 
+  spi-3wire: true
+
   interrupts:
     maxItems: 1
 
-- 
2.25.1


