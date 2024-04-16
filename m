Return-Path: <linux-kernel+bounces-147704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9C8A77F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B131F2319A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640E13AA5C;
	Tue, 16 Apr 2024 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGMy032n"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69FA13A24E;
	Tue, 16 Apr 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307537; cv=none; b=QfCECktOz02+hUmGkUbyENjVUPmDppQKIHIbivRV3Y5TgmK+LPkFYXqD8YaN9S9pnYKACNVN2jBv6fPEk5kjbVFOWCrnWfng4jIZax9IzVJvBr4/3DGgHPEIdlRswBIwV9D5euNBig/63kxHZhlcHiWURT0X3DsG+RVWW9c0YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307537; c=relaxed/simple;
	bh=E3frt4ehQ5KQRbJiZ5A7MbCj4GSdU8t7aOnund7MNMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V236aXtRBBjnAs7SWjDBxkhrknjt080LoPvjseT1Q0LYkD6MhepMIsP37XR/u25GlclAAudW+Sq6tw0ZpfPSZXe1cZoXfMG/8RATbE40Oj410QSUIhuZIXod9N0hnZegypPRPwFavPrfPpqBZtsSUxV5h08+inOD0KsW4csdXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGMy032n; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d0162fa1so6358506e87.3;
        Tue, 16 Apr 2024 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307533; x=1713912333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s3AWew5rQcLgKkmRXC5fEXauJBaZDm/I3x8ACFaWdM=;
        b=nGMy032nmkWgkVunkiiBcNxZ3ingi9CGtO4tZKIMYPEJXZ/+JfjY/LHaUkxhjQm7iQ
         3IndpfoGztZLbuvNqmeHmU1He4SzKG5l/LZs73jefQdJ5rfnBxvw+IA9NL3oM3eYF6XV
         hsUNqrxPRuKZ04kQc2Es7Xmaj6/Lh4RAeLxs521ZaI3ouLJ6bhwO3b1gshrecjl4u9Lc
         ujORDVVq3Y2Gt8gZ/UILuKLDnYEwB9D44Lf6NWuP8ecHGIDLxHqx7k4WUECTYpWAED73
         sIejze2G9cMjfCClCT8ne2nYk4Qvs4bZ+SevIgfAs6PPJGj5KJK8SsvG2nzDq5qz709G
         7BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307533; x=1713912333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s3AWew5rQcLgKkmRXC5fEXauJBaZDm/I3x8ACFaWdM=;
        b=VF8cAXECfB4vXX6EU0nqSEdg0E5NPDQaHJvg+HOmFtaLq+mmuCTXi2aeOUxN6gjLF7
         MqfBvp2VS6RKzFg34GyjJqm1y+ksrDAI6NK2/RR8fpwdeXwWGsOvWEveTk/dbBxMY3c3
         RQMsZ9NZczwnIL/b2l4rE44/pdKONmnJfaigOTzooW8o7lrFDD+3vUENluG1Nezc9PK1
         gex62hlKLlFv9s4LUA/rXu5LAfFrC6EpEsj9B3ZQkcs9RzLab6XqpOuLWy83NKq63wED
         mp/uf9pmsBNLns1M1Lu374ZbNXQSMziwuDF7xu3U0ON+PM3ZHIQZFePDrhaHI7rBg3NX
         tn0A==
X-Forwarded-Encrypted: i=1; AJvYcCVYgIaCsqbIlgBA7pZ0RdbuK7H2XMu5wUxG+powoC7Yy2blZjB2Yua4UFqIhy/gWzyihX4Zan5QMTcP6u+nyuUBjeZOvkVho9oW9cgu
X-Gm-Message-State: AOJu0YwbkVrySl9EMWVDEhmPGgQOOvn9mTwQn1j7PfFlPuETn10pPD7s
	CPoFHPF9cy5vPek3ssAjQ08FDFgOC8adCfx7Zd3881gJGPvHYS/wVHsywf8TOzY=
X-Google-Smtp-Source: AGHT+IHtCPcr2C0oNh8Rad4+2X6NliKqAzJ2cchHzlJPahx+njH+sRsYV8iH+hGSXYeQZ4T0T69Fpw==
X-Received: by 2002:a05:6512:52f:b0:516:d4c2:5410 with SMTP id o15-20020a056512052f00b00516d4c25410mr10838708lfc.64.1713307532879;
        Tue, 16 Apr 2024 15:45:32 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651201d000b00518be970fb3sm1010384lfp.221.2024.04.16.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:32 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v5 03/16] media: i2c: ov4689: Fix typo in a comment
Date: Wed, 17 Apr 2024 01:45:11 +0300
Message-ID: <20240416224524.1511357-4-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling error in a comment.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index c4d4afd38906..f826571f8f68 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -692,7 +692,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
-		/* 4 least significant bits of expsoure are fractional part */
+		/* 4 least significant bits of exposure are fractional part */
 		ret = ov4689_write_reg(ov4689->client, OV4689_REG_EXPOSURE,
 				       OV4689_REG_VALUE_24BIT, ctrl->val << 4);
 		break;
-- 
2.44.0


