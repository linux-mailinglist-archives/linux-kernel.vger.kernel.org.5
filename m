Return-Path: <linux-kernel+bounces-44334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD8D842063
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB51C266D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0467732;
	Tue, 30 Jan 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBRjGuiz"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16766B34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608626; cv=none; b=CnwtDRcrRxXhKT46oXAGFCZcem/Nw1xOqb7Z5F5Zi5U+F76s3+5E4M+Y1z4frlEkdmAWxmhFdIUXIUugZ6g1eYuU5ycE8w0AJYIHN2CJw/GPk5LYzO9yc4VX6PRgL16w89fj653+5ZzUxS+f6oRpTbZ+iYI7H5A44HoHJ77rQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608626; c=relaxed/simple;
	bh=DZ/v2H4uuaEQcj7bfKz1fgk00itGWaWjpueC+N1wZt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnEqDogdYX4HiQV+0AZvux2SVvM/Ks+3eoworcFMs7N6ZFmNErCms9Ofr+UA5Ak2GcBD9rmpaFey8oWOfWwKGCUOC4cVnWOmC8tz/atgBT12VhOkRPaTZuKGhXGTFUq47YbHmbMrvuQkX4PAfzUqOIn6Lk6Fy+OzX+hIY6qbFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FBRjGuiz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1620655a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706608624; x=1707213424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAWe64W2NwnFAQiXHeHZ8EMU8gr37Jq34GIw0wUlRAI=;
        b=FBRjGuizXSJu3e8vLLKGziuYE4iXIt8+434d444FTfItnoobx2Xpz5s19yUh40mr0L
         Zuv9B1ScIgx1xDoaQn+wwpjjWo/DgK1iYAGEoYHovs9/iuyzh+68uSQ3jRMMLdIL1jqd
         QJLJbGmMil+mx8kAoBUo2siI3dt3pVKRIZqO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608624; x=1707213424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAWe64W2NwnFAQiXHeHZ8EMU8gr37Jq34GIw0wUlRAI=;
        b=p0E3UxpaaPMWLqS5MxSun4o9CgZXOOPLwJVXNf5LF/uKeWfDdLMze0jvb82hiLUrls
         UgHUUOQ/eNTFCQI3YbsRsDCRH8yeynCs+AyUkyQYyL7eVHZlNnwkYM+y7rDIFeaiBu/f
         NwLJ73MAZzDwDpSfaZiFCZCxlWxjQUithbSDPX8lExpty8qnpOFUFqZ5PODYr3922aob
         J6eMk6zqu1yISpNpdGOKQ4FDcRBeCSStk+ydhMhO8aKeo/LYhHFmlPuINkCskofYqEUw
         c6Pqg80NEm/L4mGgypDizgw/DAPi6gZM2S4p2lQe8j3sOAmjs/Co1nWNZmWQP3+ofJw2
         vLYA==
X-Gm-Message-State: AOJu0YwFB1Pe/3G1z6CujF8DnuHmeM4NPhzBEF4I2KWwoFZqIYfTbkrt
	ZFWxh5mZ0HcQYzGYaySLzPP7HejigyvWoweDy3sS2BPZGXTdZJB7zLTA6vZ+sg==
X-Google-Smtp-Source: AGHT+IFsG8Y80ah1dIgzlZvXYiG5Z2lLgwRHRKU6R8YE9ltRgG2UNVPQyVsusIsxO+y6QwQmac6yuA==
X-Received: by 2002:a05:6a20:2d0f:b0:19c:a389:dd6b with SMTP id g15-20020a056a202d0f00b0019ca389dd6bmr4272695pzl.20.1706608624676;
        Tue, 30 Jan 2024 01:57:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:469:110f:d748:6896])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b0028ffea988a2sm8069810pjb.37.2024.01.30.01.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:57:04 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 2/3] soc: mediatek: mtk-socinfo: Add extra entry for MT8183
Date: Tue, 30 Jan 2024 17:56:52 +0800
Message-ID: <20240130095656.3712469-3-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130095656.3712469-1-wenst@chromium.org>
References: <20240130095656.3712469-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8183 has another socinfo match, with the second cell only
differing by one bit. Add it to the driver.

Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index 3909d22062ce..42572e8c1520 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -45,6 +45,7 @@ static const char *cell_names[MAX_CELLS] = {"socinfo-data1", "socinfo-data2"};
 static struct socinfo_data socinfo_data_table[] = {
 	MTK_SOCINFO_ENTRY("MT8173", "MT8173V/AC", "MT8173", 0x6CA20004, 0x10000000),
 	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000840),
+	MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x00010043, 0x00000940),
 	MTK_SOCINFO_ENTRY("MT8186", "MT8186GV/AZA", "Kompanio 520", 0x81861001, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81862001, CELL_NOT_USED),
 	MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 830", 0x81880000, 0x00000010),
-- 
2.43.0.429.g432eaa2c6b-goog


