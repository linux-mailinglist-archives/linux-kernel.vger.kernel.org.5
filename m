Return-Path: <linux-kernel+bounces-160095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D28B390D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DCB1C22C87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A83148822;
	Fri, 26 Apr 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHXGWD3P"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D63140389;
	Fri, 26 Apr 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139630; cv=none; b=nSt5g8dG0B7wXZxHF4QhPdE/WPKKrvZUdNrM6yPx8sx1OPbbMrFqHEED+i3fxn5UbfqovzS/YElFLiGel2mPdP4broTpUMcsk6gqrdiMVC5ztgFJcd5Q10J5RQbREr6U7D4sYpDkTyyEmwiGC1fti6CpgnXPfOeKkVmDFso56DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139630; c=relaxed/simple;
	bh=jE77QCDMt8FwzgOuvtcRtNpEyM7B9IdjipAa7V0Vnhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmexbmJ1vaZ54SK9zYsttqPfMpfLmUzf8HezIoMqLL0SFXCJr2QDsL16Lp3bDvWGsSjMzOksBcMSWh3OqmTB4BkSLoQajS1qdCK/hZrMbBnDUeklvV7MNpgEMxGCUyuNEzBoMWC8YZZMeABlUUQSRhT7xOFJDcDlvAY5ImYg6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHXGWD3P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b794510cdso7886475e9.2;
        Fri, 26 Apr 2024 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139627; x=1714744427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5BiHIzy1OpDKFE+aIX8lP+4Or4DjMdCT+bDgB2qK+M=;
        b=aHXGWD3PVzcxiobRb09ZzmGqt142pmcHjxCJQEqml6V6TMcKRoKBT8HvZQizt1EbQS
         YHtjUDtJaVuDIYkSlbxRJlunspCGJrcKUNDZ4/onPq4XjfuEp2FFvRXlQiZdxF87cB5W
         EFciukFyBM3hrSq/ucU5goCbfxMcPE6T5mGJCd/81Nct1rX1ir/9c2a1Opc9jffX9I8t
         mkRaXFGyAZIXTs/k0wiekXkML/BR++rDCQ1xFYvHCT1PskUYmygtT6h/HpDB6ko9UNhU
         K6CrCUE++8IKDgiKBu1BY68SXMFgk/oz5xohMrS5cM60nnJi7fces2IbI3Qykm2fLRwG
         aO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139627; x=1714744427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5BiHIzy1OpDKFE+aIX8lP+4Or4DjMdCT+bDgB2qK+M=;
        b=KjueZTENUiLCkhRFcuAwwCpmQRIoDK66wYyNnTRJdFREmdYhvkEkD1P3UgHRJbU63c
         beXxtg5QVNrvAWBIP+k6I5zAV86Apq/VtjNawSRKnqpfR0npH8i/C0rjKfnNfrlOFIB4
         /ivzmat7RglPGuq7ZePqA1WdkWTOK4urnXcEyUySpxcS8geyQhTe+PBGXwCLTTp8wItQ
         r/2Aw6UlAmvwjf/Mf0fGIa3Pwjgx3OreIMXPXpE1kMwQlLtkV9XRKu0NLO+R7z7pE/Fy
         wl2wsbfM9fR1yU4aqLfBJJ/DzfMGpMqM4daIAl9v18BKrMMxykGmAtekFRCNjFg9kYTZ
         dM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXryyTUEDaHKB9xxjpOAkRD5UBww6DSpfM/rq8/iyEsKCNik/zhj9voXGFAQXUjkYYEp4d2M/9wzITRks0pGp5ntfZytUea3gh+8oJj5FwOdHzzGRM8ce049bpKyhqhfurNexMx9A==
X-Gm-Message-State: AOJu0Yzk/jv8Py2LLNScWwAvbYcvlbREURl6WlnGCZHEhsHXqbOEOF8q
	LJu2e7oVMBCkMSZvnqVMRGPnLodopel+7syqmwXtG021ilfCophHF5QySlPs
X-Google-Smtp-Source: AGHT+IFr4K3EWkmjSSIxfxDbFf5ZiIh1C7rABITOOtTxZcaLrK3wlEy647XElEosUxRWh33IhQuTSA==
X-Received: by 2002:adf:e70b:0:b0:34a:cc2:1a34 with SMTP id c11-20020adfe70b000000b0034a0cc21a34mr1664499wrm.42.1714139626754;
        Fri, 26 Apr 2024 06:53:46 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:46 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 1/7] dt-bindings: iio: imu: Add ADIS16501 compatibles
Date: Fri, 26 Apr 2024 16:53:33 +0300
Message-Id: <20240426135339.185602-2-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS16501 compatible. Similarly to other ADIS1650X devices,
ADIS16501 supports sync-mode values [0,2].

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 9b7ad609f7db..db52e7063116 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,adis16467-2
       - adi,adis16467-3
       - adi,adis16500
+      - adi,adis16501
       - adi,adis16505-1
       - adi,adis16505-2
       - adi,adis16505-3
@@ -90,6 +91,7 @@ allOf:
           contains:
             enum:
               - adi,adis16500
+              - adi,adis16501
               - adi,adis16505-1
               - adi,adis16505-2
               - adi,adis16505-3
-- 
2.34.1


