Return-Path: <linux-kernel+bounces-125861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A813892D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398DA1F21D01
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962124F5FD;
	Sat, 30 Mar 2024 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkcclpP3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971645948
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831121; cv=none; b=QRaxU8k79q4yumh44S+JZkZ7CX5WuDNTaxX1ihEH6buKXB/MVOkgDbdIKzN2q06t1+LPWCUGNURVRVSrJIUJ5l44Y4yxAkGlpIHb2gWisa8N7eqmghH/zbh3Nz/2ziMYzXgpQ17ZUk6uGTdlxkUX0zY/0ZRVS5Uk5CJcIYyttVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831121; c=relaxed/simple;
	bh=yYEtN2oFIdrLN/dotMYQbd1WzbLUSQk5tx6GKto/3mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjR3s41R+cw0hAsGxyWGUrKp986F6tMF14xfQGTY9n85D8Oaf/1LRMrg044/bJT8nFVplVeH9YtvLgbO0FkudebwJ/2pZQT1Yv0jy9gMD37nYmmJDBo54aZ+rOiM6MiEWCx06UozHgWPWcMWf2Ih5oaTDq40pq0zK1Uhq6OvS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkcclpP3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41544aef01aso18632785e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831118; x=1712435918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFs4+JJnShJ+MLRpqXVBdO/xAumqPjEee/iEWsZXnTY=;
        b=xkcclpP3b80ZB0pQ95GD3G9ipCohjjMQa0A1JRklUFHRvYmbMdHiZrEvSZEmHDy+QU
         5TmPzObUDlPmEV+9bh6Y2vv/DD098YMKQsYWPBU1MRs2/yaFGGBSCG+HQVKPalfy/IDt
         WJMeMU6x16lfKHyCX619j5IYHuxJhPpaB27/HdBIB+9Jf2EIKzwMPhbnKLPYXPv+0X5i
         EY8mDNBWgXPMr91BEshR8u/vJ/Bf48eoXsBLhvvOa5CgxiCl0+Txa3H95YQa+tZf30Je
         B0CKRq2isKHfoTslKxWam7xDLknHwnIMtc2DtrHiFFaUeywy4494ONVdrzmoWD3TCIju
         2/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831118; x=1712435918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFs4+JJnShJ+MLRpqXVBdO/xAumqPjEee/iEWsZXnTY=;
        b=A84wbo3H6MAbguVSuLm8e3IAU3EdL80/72fUvlxlEiPXubFHCdismd44sA0+5bKlr2
         YKnU+pApQWyC0bWM0LfBbO9JH94UWHN0rZkkpd6OFPPMA6n6mVK8DPgHeeEScUXVhdNK
         a1zpj0d0Ocj0EhWc6TfwG2SXy6QPSUsE8jYs/VNDvz7n7YziNFQ/Vc/6vCp2DvZhVB1y
         C0OjUTYgf+MpFS4RZadSugIE1SuZKYe/Jz0ifbZkzvc3ey+1mwWS/PfwDCmYKUCVtl/s
         ia2eomMqaRmNGkELa4NIRdecByPFfx56iKSggYdfUGb6JNml0UNhaVQE1eqBe4KGn6I+
         7yZg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsZrM/bWGSQkuD5/WVWwvWcYV5fwaXI+w07t+2MURXEjRQERhsX5g6pimXOuF6gzkGlm3KcKAjd2pf/VipKehHkKif5DeunkyMxKE
X-Gm-Message-State: AOJu0YwY6KSGLDN+vJNkaycHqsIIAW6Xrb3sayDAnext3tyY17A0+2+h
	vO8HupXN3Tx3BJTfhrwyEOslNNRinUj+QBCE/DeTfw/0waFVkf3N4INrOlfrRXY=
X-Google-Smtp-Source: AGHT+IG7v7k288T1Vn3krtCWuG9g6DrlfdzI9rYZk3NsnNHv7nvenJUD+y7dYXT65M6K74TQ5WG4ZQ==
X-Received: by 2002:a05:600c:3ba2:b0:413:38ee:69e7 with SMTP id n34-20020a05600c3ba200b0041338ee69e7mr4379496wms.36.1711831118494;
        Sat, 30 Mar 2024 13:38:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b0041493e21844sm12663154wmq.27.2024.03.30.13.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:38:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] drm/sti: tvout: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:38:30 +0100
Message-Id: <20240330203831.87003-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/sti/sti_tvout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index 64615638b79a..e714c232026c 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -886,7 +886,6 @@ MODULE_DEVICE_TABLE(of, tvout_of_match);
 struct platform_driver sti_tvout_driver = {
 	.driver = {
 		.name = "sti-tvout",
-		.owner = THIS_MODULE,
 		.of_match_table = tvout_of_match,
 	},
 	.probe = sti_tvout_probe,
-- 
2.34.1


