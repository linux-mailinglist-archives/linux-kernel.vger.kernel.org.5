Return-Path: <linux-kernel+bounces-80231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29535862C54
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81B0281718
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660B1C6A4;
	Sun, 25 Feb 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGwdw0D5"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C841B803
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882431; cv=none; b=amxaqlrwqm4H8OIeeH/8wNnmd8xjexnWL8WQUnuhrovRSM5WZFvo+fDnVtSjQS/aiLzcKhLJPw1ZiW469XQ+WqGsFFRU+JKLlnHHU2zZ0smmfUCHYIokVMiZCwArbS8WxMQxTSCCHVsdbd4b1w7EAjoCWQMF6/sZwcQa9/ouH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882431; c=relaxed/simple;
	bh=IthABUHIimXWHHseJF0VRBJddzoOxpJPDMhoS9JXf5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CB8iGwGobwbyM8dluV7wzF4uOW+2jfaaer4eKMTXb2mxbTRgSs/gzB9Mjx5HYFJ4e4hW53aSLMojePgBEE5IVIKSw+hM+9pYxBkMsUxIsBDZIMVtfnCaMBIn3zoVDTiJ/HqQnaB9NYJqG6t5qz62G65qaWkp0Be/vXdnvvaNB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGwdw0D5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso22795451fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882428; x=1709487228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPBFT1fUIi7ksuCRDDRVswlvAaa8ikGoP2BWWAmlidQ=;
        b=IGwdw0D5V65UfFPbjwqna6KoxbhnSk2FNmPyEp4mtK5LINePq3agb19rAE856bFT7l
         04VXzU19wyPnN3NSCX9I2lxr8f8Fb3VBDmfmLUBN4ujaer7QwZahene1+2Xj8ylMoxVj
         uj5z0eEt55t7wmyfU3zkdM8BJ4IMZNkB/J+QmKdAxx/hjj9NbnqoKyDKlhbIzUMPih/Q
         M/mtHvuAjvhyDARIU/xZD9yDuKrEhoSDLwDmA5BE0fh954JeXiCMeZppKmYbVdVH/0VO
         cfS03ETHB58JGEusy8o7azQJmlDdeZEDe/DP45PdJ7P1daT3tyzHeEFMOJv/X6vO7418
         uzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882428; x=1709487228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPBFT1fUIi7ksuCRDDRVswlvAaa8ikGoP2BWWAmlidQ=;
        b=vYsmPJk2p9vZcKNwiGM6hoJ3PO5FKoh6KggShWMBzzmFVAUXNB3hQWzBow4FO8aJ3P
         T1G7KIl2DKPYusyppQkJJ7XmXEL9m4ZEiA5Eto3GyFFCVVL5JVexqG+jCqlAKPUBGKZ6
         au1H/ivxkxd7Iivg8nULX52Rfv09O3tbgkBf1ghjsmugwG2KbQEJfmQO9aALiO/YBsVs
         C+EfVFFUcfmjFmuniPa5DfuILMJVaRK63JIp2sY2CjV8/tXeQurmNXX8JAM4taZcwEnV
         NFgENLaMVupD+NxAr4XX8hzPnRcO+n4P4Tc0baPs7qoWakvJVRW2cjmWyspfWasmk3H0
         IrZA==
X-Forwarded-Encrypted: i=1; AJvYcCVnTtVd50Wx8ZzIQh1pZy6Li+Q78O9waSz4H8+W2VWleVpL37MbB1QnpZN06JdCb+gMgM1VBXmqbuNzZQVRVbUEgy+PsIQIjn1vfqIA
X-Gm-Message-State: AOJu0YyW5k73dyjPuRz3orLFCsx6SU/QfleBpNRTqkUTdXKBXj635lj/
	YSneHq99Zus4TCTJBx1IZAXUQSNWVhOkVNArJMqgbAABhe2DH0qv
X-Google-Smtp-Source: AGHT+IHsOM8tGc0IV6nc5wCo4tWx4xoV/xDFmcQqpT3Ngh5ZCvNbksI08Y5hlXG7TJXPU1CK9qZSdw==
X-Received: by 2002:a2e:8543:0:b0:2d0:a19f:e44a with SMTP id u3-20020a2e8543000000b002d0a19fe44amr2575095ljj.44.1708882427456;
        Sun, 25 Feb 2024 09:33:47 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:79c9:6db8:8198:3c60])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm9400108wmc.27.2024.02.25.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:46 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: pi433: Remove the unused FREQUENCY define
Date: Sun, 25 Feb 2024 19:33:39 +0200
Message-Id: <20240225173341.1278918-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225173341.1278918-1-ikobh7@gmail.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FREQUENCY is not being used, delete its comment

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index 52e43a909b03..e63e87fd6cce 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -11,8 +11,6 @@
 #include "rf69_enum.h"
 #include "rf69_registers.h"
 
-/* NOTE: Modifying FREQUENCY value impacts CE certification */
-#define FREQUENCY	433920000	/* Hz */
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
-- 
2.34.1


