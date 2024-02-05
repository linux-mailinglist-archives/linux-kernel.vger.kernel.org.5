Return-Path: <linux-kernel+bounces-53997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA284A8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6AA29469D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D824CB41;
	Mon,  5 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAGqpIne"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC01AB7F6;
	Mon,  5 Feb 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170714; cv=none; b=istdGAmgzjRopPCt+y2Pzgllo/YqqNChpD++hXiHH38Eo694uoUES2BWZrm6nFjK42A+o7IAL527FLsO6sD8o1U7lyM7sBPTcN5OIrmdrFPDYlZLg7HzNStKC+B/8Od9HAIzqj3yyRxSigrUNuqzC3HdqIn+LBqyUjZFfGEJNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170714; c=relaxed/simple;
	bh=FyL3xtkXQG82Kmq8Fv2Y9NKGybm2l+eMfpJXN6+S5z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LUO0R1tHr7kNrXSYW3/DEjpziMY88Z5UY8tShsVa0KQ8dVJD/9S4wVFpmSNDmD4lzCDjdXfC1S3Hd0dnIfo0F20aj4nS9llW7OqqBEbQPntK94pGmWqYZssi+OwlhhSvy/IAU9Ig3STsyN7RQWTN41iDDzUIzlaN/H2qgbaKsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAGqpIne; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so11770415e9.0;
        Mon, 05 Feb 2024 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170710; x=1707775510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTGI0UOvdQER0iXMpVjZqKLFkuJds7ABf556kHVbzGc=;
        b=KAGqpIneRTwat++D7e4f3AAwPgoZI31jjzM/2BCBE+NLeB7t3e9h/EYXiH25mATlHO
         modfAHm97WRxTF+SGGKuArQGRH+QEFtM7+radn8BBRhVEO5hQIpxeh8HgKNmRloKix/C
         5MlAFa7cZudfjoUZ1Misj3Cvueffp8RNPzRkzrlIjaFSo8Gq9pcu9ibnZkU3s/yFbVsJ
         mytw6ZgrcHsVQ8H928vMcmLtznrF1SRrfIfDHXcC6voFVSj+AvVea+Fc1r+YNuS4Oykk
         prFV35BSAXEyLEUyVyj6X5XQnRkA6Nm5ak7MFLilp2Up4CARqDM0o8M2Du41kNRmf5zU
         aaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170710; x=1707775510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTGI0UOvdQER0iXMpVjZqKLFkuJds7ABf556kHVbzGc=;
        b=ellmQSZDrHFmaqhhpW1EUOTVdfq5xZeYoZMrXr0tP4SNV/9Js/zJJGAOonqZrqMLcs
         ZSoIUozAfqdRgrSOyAWkvJ/J3TfrBpZt85aMXzUxL2uCFPxNJCSVzREgWVUTc1lJgBsm
         ElgXnKjiHvBOrBLZv3y7mOtCRzFCvRkdsymfhFlObsgNcu3XaMt39xwzJfMOsAZI3bY/
         cu+uNrJS/amiMHaywRMASvlUNj2oHxSq5TwZgTqr/Ga7BwD2PTZUolL6/ONm4w9hRH0f
         wWdHaYimKYMpXlLNsuCYhFRaQaeTojUHGRaaLh7FpoEt60k64XWHUvXmWnJJYZ12XEZx
         In7Q==
X-Gm-Message-State: AOJu0Ywm2S4RhEvFs2wIHu9pUoRZoboxOGEyIbhwJMT7Czmi3jnRIWw5
	UoXYMo18E0E4e2xgym5vEBiUSX9sn9Gnba2NBEz3RKdJFlVJF7aQKkI/YqUVsoM=
X-Google-Smtp-Source: AGHT+IGbQR1rjjufS35x9olRWmtFr/4qd/TgbArZKtOYNkI3cVsnQOq3X55ZmsYk0RxjZNuBAn+L1w==
X-Received: by 2002:a05:600c:3b19:b0:40e:45c0:ad64 with SMTP id m25-20020a05600c3b1900b0040e45c0ad64mr737050wms.14.1707170710256;
        Mon, 05 Feb 2024 14:05:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHI52K5kg1H/CHZ3CLOaAEclxvAPTRmdA3Dpx4xpLeFAaIDRKyIv4H4KhNdpxeOjsq6+GYlXZkm/rdBzwVa0mc/nKhvDCdR8AhXMKmN332iVIPRPqUxY18MGBsXk9YjDY8S7tD7JiE51zR1C90r8AyerM1Y8LcrxLump8+qNfP/AxUE7LD5vaISYVcNUlzO2ARpWe+G/XK1ftQ1NBTdXor0F+U+XbUY0T7GcY8W/CQJhQQTnvcif4MNLALTFiNj6P3alFPgrUiINTlAdmHzOA2
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q12-20020adff78c000000b0033ae4df3cf4sm536712wrp.40.2024.02.05.14.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:05:09 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: i2c: st-vgxy61: remove redundant initialization of pointer mode
Date: Mon,  5 Feb 2024 22:05:08 +0000
Message-Id: <20240205220508.1851545-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer mode is being initialized with a value that is never
read, it is being re-assigned later on. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/media/i2c/st-vgxy61.c:632:33: warning: Value stored to 'mode'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/i2c/st-vgxy61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
index 2d64466d7ecf..b9e7c57027b1 100644
--- a/drivers/media/i2c/st-vgxy61.c
+++ b/drivers/media/i2c/st-vgxy61.c
@@ -629,7 +629,7 @@ static int vgxy61_try_fmt_internal(struct v4l2_subdev *sd,
 				   const struct vgxy61_mode_info **new_mode)
 {
 	struct vgxy61_dev *sensor = to_vgxy61_dev(sd);
-	const struct vgxy61_mode_info *mode = sensor->sensor_modes;
+	const struct vgxy61_mode_info *mode;
 	unsigned int index;
 
 	for (index = 0; index < ARRAY_SIZE(vgxy61_supported_codes); index++) {
-- 
2.39.2


