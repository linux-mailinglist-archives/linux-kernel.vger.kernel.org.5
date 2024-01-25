Return-Path: <linux-kernel+bounces-39226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53883CD10
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0925A1C23A00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431C1386AA;
	Thu, 25 Jan 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="lerGpfeD"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C7135A78
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212884; cv=none; b=ftcH8rlNmlfAC4Wgs9mPnTdciv5PLTe6bTc4wUn6ecFqNzKWgB6n1GwwRgbqoUrfoG5oT/lUmVlp7BC+TiJ199pC1vpUhkjLsWWGM40NeUaQ/d5U/mJU/q6l6qlsdHa6fmHmiH45KzSfHO9z0stMIOQ1FYvGhMGVogaOKWWPjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212884; c=relaxed/simple;
	bh=bipr9jBFXsYwifKtcq+gl95MEZqc4KWQsElwUf4n1GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUnES0OCB2qlBSJf1YTlU5FajfKSsW3u63xnbPZQXUO+IIBTb5LHUs/Yhbs8D8AFGxTgeiIhWIGr1px9BZ/WZxzc0lv/3fV9R8R2jAv/8OeKzvwvGxwmPxbMvCmNhpMsuZIbNDWNZ2q/8pwoSLKysasB1qaknmDJ83UL+7Py5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=lerGpfeD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2e633c5365so193722966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1706212878; x=1706817678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ0g29wlAAYawG7enqb5FROZ6lIs9rjJ1HjxjPIRBr4=;
        b=lerGpfeDvvuFxbiiTZq2WFzlhB36vAXuJM8a5J8Z+2fa3NNkVm67UW9g6um7uKC+yu
         edbdKsrBbq6cIHMkJnFfuxlnyvDJptV9C5X/PmxpmRNOV8ZybEOY8QtFpfdwkLN63JN+
         4TT/pAypdUDsDRirVlzkbYc2g5+ubaTuYOdUic4hfn3GHSlfiRZOLEWXU4YZm1kLToOm
         N/CLdsompxsRq/qmu4lFw/cha5vw1/+ysbOC1tlqmVOQpKSBZ+JlHHfZ+ScFm07+XCY9
         WAC1yzLKNXAQxjcFlgYvDQXAfZXpqqewuhn3tOn+briN8ppdsMvaylu9rMpnz8OXVi5Y
         em/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212878; x=1706817678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ0g29wlAAYawG7enqb5FROZ6lIs9rjJ1HjxjPIRBr4=;
        b=bDuUEPCgO25dbJ2h9LXimpX525Xm9reKLz5g4SKcQcRXMaZQ2Z3ucQe2JzP+v9Z40T
         rCYpFXD8sS7sCLyPdAr4Z+XFP470R9wjS6K92XghHjSQctGhktJSXY4M0LBwMZz3GmfJ
         cLovwM0o83rT3FzcKMOTP068ThuhLkBNihGGGlYk/NgL7zWYVJdOmlb8VlUJ1w2REgcl
         wi3/cuGi+XuIuQdV0AYLXhG1yNDf4LxpC+0Wj1FbLoS+prc+89UfHq7hUxp6rn79xljb
         xDnuze0rsoUb1nc6ECjpNdbgA6c+BLx5c8W0479vfRV+37vrKRe0MpeX83jPWTP7+Ten
         kUQQ==
X-Gm-Message-State: AOJu0YySZIvyCi7+JV25INPkncAsFDC5qkAIOGrC4zf9YH35Tp2cMXAh
	aDu/E/vn0/d1GVku7H+jyXbRr3Lvgw+O9m4CWNGPWK+iU+aqIluZTD3L8Mz2AgM=
X-Google-Smtp-Source: AGHT+IHqVYL/lJVL7JEAq3szsDoY8tNhXCz0ekp9lxwVygOHTiAaO1z5D4lST0SmwVn/brdSUyzCLQ==
X-Received: by 2002:a17:907:7da5:b0:a31:1d58:262c with SMTP id oz37-20020a1709077da500b00a311d58262cmr170599ejc.5.1706212878670;
        Thu, 25 Jan 2024 12:01:18 -0800 (PST)
Received: from pikachu.. ([105.225.45.176])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907c01100b00a3496fa1f7fsm195577ejc.91.2024.01.25.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:01:18 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-mtd@lists.infradead.org
Cc: Chuanhong Guo <gch981213@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: spinand: Add support for 5-byte IDs
Date: Thu, 25 Jan 2024 22:01:07 +0200
Message-ID: <20240125200108.24374-2-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125200108.24374-1-ezra@easyb.ch>
References: <20240125200108.24374-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

E.g. ESMT chips will return an identification code with a length of 5
bytes. In order to prevent ambiguity, flash chips would actually need to
return IDs that are up to 17 or more bytes long due to JEDEC's
continuation scheme. I understand that if a manufacturer ID is located
in bank N of JEDEC's database (there are currently 16 banks), N - 1
continuation codes (7Fh) need to be added to the identification code
(comprising of manufacturer ID and device ID). However, most flash chip
manufacturers don't seem to implement this (correctly).

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---
 include/linux/mtd/spinand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index badb4c1ac079..5c19ead60499 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -169,7 +169,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
-- 
2.43.0


