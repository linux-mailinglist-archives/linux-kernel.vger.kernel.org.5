Return-Path: <linux-kernel+bounces-160100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DF8B391C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8891F22816
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1954149E17;
	Fri, 26 Apr 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEFbLxFP"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB1149009;
	Fri, 26 Apr 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139636; cv=none; b=MSXTA/WRNac1wSHaoqIxU2IQYBkmhz/6gM49yGsFEjpb0t4vnWe1p+SXW4uTGf8ctcoZw49eC1N9H+fbFcM4sl/tzOBevXOdCs99GDbKVnNozvTUaT/82jGdNwxnRX449C69KB6ffxaM5F7+Owfl+fKXDFRgKKfgaQd8MhUCmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139636; c=relaxed/simple;
	bh=m2yxV5B405RCZQld4AIwLovxgEUSP5z4fMOhlaEf9yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcVCk27ZmhOYDmU6IGplrOlAD7Fkt1jZo+dajTE1TWFWcHvD7gL82RpsuN1WuzhqakxOkOI9heM64RvXSPxrKCIV0+CvX/Gjp6GZES4+vHZoXqJduueNxfFS2JglPYfgOfqybTX90BQ9TvPIXbUpNQsUa2gNURBjm3RjW/UT2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEFbLxFP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34c1fff534fso1271433f8f.1;
        Fri, 26 Apr 2024 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139632; x=1714744432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLJ9dsSLK+nY8Hvlsn/3+HI9I2fOpNl7ItjLv5mlK7A=;
        b=jEFbLxFPPNK9n//JdjmUmawgJ3EzZeK07I1BtlvsTvp9NGZakL678XKzbgZ4HrpA+w
         T4VrPVzPAM6kLlYqbxMBvgcTh0XxwfISpXu6rFnrJ2vbPuD77iXdMtpiu+lHstftJF1d
         Sq8nm1Kp7bwHQIpYtCijzHiRvKqAxURq7af55zeg/OPxEpurQe/kxfzdMJXhMjN4fy9Z
         qcxlZIZKjIrYDurIlYfK0vF55MHaPZj9ZAnmdsbOuwclxzTdmNVyqDm4EB2BeuJFcqfB
         u5ZJv07NekG4Zj7k9QDcC/qGMMLYei8mnNr6NANOIZxS4UZFH4qjj63AYtWQg/Q3cAZo
         zpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139632; x=1714744432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLJ9dsSLK+nY8Hvlsn/3+HI9I2fOpNl7ItjLv5mlK7A=;
        b=Vc8dQPnNHCZCEntGhd8ovJ4ZBlvUfm0QZRKhjamrRKCLNpwGVEDfvZIRHYXJufotVQ
         rPgNbqICn9TgnzCmbxev1th4FDQ4jYBxDQBf/1kG/2/PmB+DkKfhonNyynQW4BaT7vSD
         ZG1S7mZi4LrkbikP4Ox6QZufFeXq6NDkbVztC9C51VAaIQZ1JeoEXzLWeV5T+1pBPs7u
         RbssIFeaUBfNJa0PoDwy25La5XOAj7aLwlF88Ne8pSvBD4IA4fBQKza9wfZmuHH5KsA+
         ZXtnS58NNlnW0/PY/QQOgaXcG5v/c3GW6wq4HxYy44fvAVoQZS+Pu3SBJA5WESomlBay
         2QnA==
X-Forwarded-Encrypted: i=1; AJvYcCVy9LiYpWh54ZYtBKjqsTfFqVLL0ecXXnulVtryWQaVgzkAIsK6ymH13cwTCBhMMDxWvyO3LIQ89GMWF3CoI7JJbLh6FdHErqngrRkzuT4Bb0EUKQKRoQn9c/k5fSuecNm9toMOlg==
X-Gm-Message-State: AOJu0Yz/29HBrRASGH2eBQTT/N3UqBooYpDcmbhy6gw2QGNW+chcTIHP
	S3x2zVWfRcpPtfoVAwA8DJcBllOqiAf6phEF4xdLI/UjKb0wKi9tLnahYuZs
X-Google-Smtp-Source: AGHT+IHEms0dC8ezv3c4Amk0JUZhJpSMYgKLuKKM9jXiTHegW2/Lhl7B/LSPhkV3pnb3KFmE0A3q9w==
X-Received: by 2002:a5d:4386:0:b0:34b:8bf:6019 with SMTP id i6-20020a5d4386000000b0034b08bf6019mr1733253wrq.70.1714139632252;
        Fri, 26 Apr 2024 06:53:52 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:51 -0700 (PDT)
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
Subject: [PATCH 6/7] dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
Date: Fri, 26 Apr 2024 16:53:38 +0300
Message-Id: <20240426135339.185602-7-ramona.bolboaca13@gmail.com>
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

Add ADIS1657X family devices compatibles and specify the according
maximum SPI baudrate.
Similarly to other ADIS1650X devices, ADIS1657X supports sync-mode
values [0,2].

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 .../bindings/iio/imu/adi,adis16475.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index db52e7063116..9d185f7bfdcb 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -37,6 +37,12 @@ properties:
       - adi,adis16507-1
       - adi,adis16507-2
       - adi,adis16507-3
+      - adi,adis16575-2
+      - adi,adis16575-3
+      - adi,adis16576-2
+      - adi,adis16576-3
+      - adi,adis16577-2
+      - adi,adis16577-3
 
   reg:
     maxItems: 1
@@ -98,6 +104,12 @@ allOf:
               - adi,adis16507-1
               - adi,adis16507-2
               - adi,adis16507-3
+              - adi,adis16575-2
+              - adi,adis16575-3
+              - adi,adis16576-2
+              - adi,adis16576-3
+              - adi,adis16577-2
+              - adi,adis16577-3
 
     then:
       properties:
@@ -114,6 +126,23 @@ allOf:
       dependencies:
         adi,sync-mode: [ clocks ]
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adis16575-2
+              - adi,adis16575-3
+              - adi,adis16576-2
+              - adi,adis16576-3
+              - adi,adis16577-2
+              - adi,adis16577-3
+
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 15000000
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


