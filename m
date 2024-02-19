Return-Path: <linux-kernel+bounces-71916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD685AC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03151F24ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26A51C2B;
	Mon, 19 Feb 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="BQ6qlA05"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112651016
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372276; cv=none; b=JlkutdZsdyCTMiei2Zwt63P/GxGTR7sWxJUiD22od5AncQ8ObN8VYx2hIcii9x/YCnkryRq2yWNufFjp8+4oGOByDOsY0I5xiTTBJFFLDOWSuYtxPnOAI5dGlIic7iPDTzMcexHmtMAUvuh+nkwOfhiUvPrXLAnSkiQRvGrWfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372276; c=relaxed/simple;
	bh=cZD9tav3Rsg7FGtsH94q+RH9RD5QCb1KktFz9yZ2dHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uxPCWT0sl1FgGayg76qMzSsugQG4SNYPeWVPYZx/fPDn3Z+KLQrvB/fzgaFzDcyI640gyWfJNWAPIo6mCx5Qf4NVldibEIumvcKFxqFxLuWEMOI9PQfWOlKG5yRi0rv8E/EwP73bio/Fx329oKYFtYnheBZ6vArI9cLkNnlXEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=BQ6qlA05; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso3478753b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372274; x=1708977074;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l1ugTQtT57U/DtQ8yakHbXSOTzUFNQNEozYNeXEqWo=;
        b=SjdvlHI/s36NHfrwE8eBlG2StU8IxCW+Eer2slCk6CdUJedNryoXLkwDMS89mlhn2R
         kV6zip+7D6Mqe5EkvoyKtIEByuiL+iqMT3cAWbVewM5z52gSu/jjrYJMbvVZbcKMZ5CN
         9AG+2olGZwxwGAIEcRbL5t3EGHk+RGAZ08aU88fsVvjpdH/FYzSUTvUzbXOVKr43FOtQ
         lTDrFtwSz1VpJzBceVTY1kzNJNbFuU/Wa0hAQ23SD5Lr1gZYPqLuo/RwFumGz0swsH2L
         2Mug/FCFUJjVvEwTp8828IUB0lw30l9C7FZD0nNGQXYkj98jh60SocBGJwFN2HYdLS4T
         WFKw==
X-Gm-Message-State: AOJu0YxKJ5c3zA9+fR319RuoGLnFyXYzbtW1uNlTD3S7mmAz0xpsGYkW
	ISOn0x0f4G/K2bXobbvrVOloRBoQ2q11JXguUU/6VYQMmJKDEEl+XSnyUt1ZbAR9dg==
X-Google-Smtp-Source: AGHT+IGOQZylbxm5Et+xQk971fIhRDFC3fAOzfpsOqgNOO11rz52xIzJKZZiv6LvqShsA3OQXVdSfw==
X-Received: by 2002:a05:6a00:812:b0:6e4:6047:fdf3 with SMTP id m18-20020a056a00081200b006e46047fdf3mr4740484pfk.14.1708372274176;
        Mon, 19 Feb 2024 11:51:14 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78109000000b006e0debc1b75sm5451473pfi.90.2024.02.19.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:51:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708372272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4l1ugTQtT57U/DtQ8yakHbXSOTzUFNQNEozYNeXEqWo=;
	b=BQ6qlA05MIXKZmZlF7ra4aNSZib6aTA4z3dW9Qn+B28QcwT5yeFXzAbzwZeKZ0OtuzGXHz
	XiASzrYS534ef0nrjQb0Lu8+eZqFSMYdIC1f05WIApLtQolPa8ULAVyVNvny7sBgUpZU0o
	3plyObgOA7dBgaN1Xl4O7I7KluXJAFBGzrxL/6ucHFpjHsRXR0yIVuF0GVpPtOjc+NSvLY
	ycLF5jx9jwThTeYNHyhmEOO6kXeoFziohahe2LjKOMVaJCE6VXsHlASfMTxUcI5E6WeDIa
	h1t/ayHemY28B4beVdj+TVls5tobYRyE66JalhksIZvvtDbHxIYN1UuxJXfbwQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:52:00 -0300
Subject: [PATCH] mcb: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-mcb-v1-1-dc930e7dc11c@marliere.net>
X-B4-Tracking: v=1; b=H4sIAF+x02UC/x2MwQqAIBAFf0X2nKDWxX4lItS2WigTpQjEf886D
 m/eZEgYCRP0LEPEmxKdvoJsGLjN+BU5zZVBCdUJJTWfq+RwcjsafwV+OMtbabT8dqMs1GOIuND
 zR4exlBcTn55HZAAAAA==
To: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=cZD9tav3Rsg7FGtsH94q+RH9RD5QCb1KktFz9yZ2dHM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07FfB+H8LpedTMaq66TTf6LH/jLB603Bj7mLw
 FwXp5oWPsaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOxXwAKCRDJC4p8Y4ZY
 ptiiD/0ZXh+3A6BhIJqz0RLqlzE880HhIdo3dR8T54TPZIHkQf2K8Bw1igZrFoqTcwDmW8LzGAo
 r+/InxENUjCER17HdRgcTSKK66T3ZINXuve99Ed0QUqLLGzDiIlPzOlv3Nkmhffg/49dLma+dtW
 i2DRpTZLT2Kbj5pRu+kwAmxujjV/FjKVvtecC446L5agIq7AyDfuLKjOEf26eC+9H4XAzkoMsVM
 W7oMrOnOh694ZNqfFyIjStoo/vF0CSouHIOclBnRnydm5Nk/ml0CScV+xz7tTw0HeLoefv/D1uu
 rmM5iCLlsNpeN9R+6PaiuPqyb4ry/TTrhSQ6Zr7bQoZ9gBbbVL4m652Nt+ncQ/eidjw5ZFrgKMF
 qV73sScHUtvwov619DS/e4Bf5d3oNtve2DjEc7uJiOkn2DS2XxBx6xSDnHY27jLQGuqdK8Rf3ot
 jvr55bwOkLRUUKfWww1S8/4hGQ5Hft2uvcPx6D6Hz3R1VvD5yY38unG5rg2eOivHhozDkjTk6E7
 2+AWbgGtsCJm1hzyuxrlkRytG+aSUbYtIrAA8IHdjqA14wwYU1cGtb0dhN2UnedWQfz4JWoj7NW
 803c6mFmdJYe3jM0HOXBLO0TjloU0LNM2BkFLcyd0KbED7tJ+aWlIKP3GD29LK2qsqPWDiW0R+z
 TRF9OmCziYUq2iw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
mcb_carrier_device_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mcb/mcb-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 61994da7bad0..8c4f1a1e3768 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -165,7 +165,7 @@ static struct bus_type mcb_bus_type = {
 	.shutdown = mcb_shutdown,
 };
 
-static struct device_type mcb_carrier_device_type = {
+static const struct device_type mcb_carrier_device_type = {
 	.name = "mcb-carrier",
 	.groups = mcb_carrier_groups,
 };

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-mcb-31a910240a2b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


