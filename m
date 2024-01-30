Return-Path: <linux-kernel+bounces-44332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B3842060
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A110C1C24611
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5A60BB0;
	Tue, 30 Jan 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nIMEjC0/"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04960864
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608622; cv=none; b=Yet2L5PdL/zy54E015SLZDtzCGEsVWvqkg8AQ6lDhCX8GD9CZ71YirpOGRpi78WWNHJSPEJK7jZHFFV7mvbzaRm70uV9dm7btrOgUNh2r5OzeaXWlu0vHMUmqxoKqoU6mZ8DuO6VADEJO/Yd7nMvx/z5pnd04bPjwBgoYs13usA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608622; c=relaxed/simple;
	bh=vbI813naE0KfjH2XtPSzIzbimxv0FRdKAx6o32QdIqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocvsU6VHGaNwxV9N6GQz6baEIDbwB1xhdLhI2uVLKuq/waB7ARFl7fbHt6UI6e40C0q97ILPe0q3kf3bELVGSiCIebW9ZRW2LxKWEuoTuOmNZgRgxi6D7E1V1o6zsDBQHPmmJG6E9bLYNNw1aS9zjWX2s0mQlWrtteeD0xPwhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nIMEjC0/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso3092619a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706608621; x=1707213421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1E8FaeEXOaFC0eCzbjnFP8K081LnYEvpyUI9em1l5vI=;
        b=nIMEjC0/cwtqXVX+ERGx3L8ckgsZ6ls5Byo9mia0c+FGDiQzN/7S5vpRy0P+/BByIM
         4Iu4AyBJ7ZxCn2Yjtq4/H2IMwL5nB9bBqKvGuuaH1XRjvGfSGAoF1Y2ZQ3sps6SGx215
         SlHXdwOuxLLZbv28fLVlbXazPM5ZPvSHtYI9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608621; x=1707213421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1E8FaeEXOaFC0eCzbjnFP8K081LnYEvpyUI9em1l5vI=;
        b=qbRyNdU4POlRKEYliKP9TA1A8IDvmTEEgHOv5kdjYTtOI0fzd+PWTTIoEm6i5l7Rwm
         GzvlAabezYkbfcCKCmF5A4iDq36ErGFvbgrNzMOvDLAEivGh8ZnYKrKoyFlZ6aAdIw/9
         6DLNnJuLEPqr23M7tORqxrflo88gUb4z+Q4H32FHk7j5kdWcj9x5j3Aqe8ZNzJsWzFv5
         xpx/bryO9CiSVYw7SDVBOR13t2RKSBgQN79QILDHYtw/ta8OFz+SEM8Gu8bZVsqtoKUq
         rPrQ6ArS59dYtMCANyq6YF2NaLpRoSDwnDCoHauRDa7NcYhPqXc6inbrnaboXZkvhRM2
         IfYg==
X-Gm-Message-State: AOJu0YxyeXucyk55LCpdgeYTtz20xnkDQasmQ6tDTVpzBKTq/Pt3iv/d
	6BMmMUiYEwXJBXWwYk7C1K0xlLYFb7FSi+WYrp2vrFohZolMERG0OP1MbHQokw==
X-Google-Smtp-Source: AGHT+IEhklyD2jX0T8w1fgxrasE/X8QO381avV5owsKZFBkH/q5N+2daMyJs0ABiAgETVQ3QeKrdRg==
X-Received: by 2002:a17:90a:6303:b0:28d:74eb:97c7 with SMTP id e3-20020a17090a630300b0028d74eb97c7mr5294648pjj.34.1706608620693;
        Tue, 30 Jan 2024 01:57:00 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:469:110f:d748:6896])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b0028ffea988a2sm8069810pjb.37.2024.01.30.01.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:57:00 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 0/3] soc: mediatek: mtk-socinfo: Fixes and cleanup
Date: Tue, 30 Jan 2024 17:56:50 +0800
Message-ID: <20240130095656.3712469-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The new mtk-socinfo driver has a double put of the nvmem device used to
read the socinfo data. While fixing it, I rewrote the read function to
make better use of the device node and device relationship.

Patch 1 rewrites the cell read function in the mtk-socinfo so that no
resource leaks happen, and device lookup is more efficient.

Sidenote: I think the cell read function could be reworked a bit more
to return different error codes for different failure modes.

Patch 2 adds an extra socinfo entry for MT8183. It seems that some units
have chips that have this one. At least mine does.

Patch 3 drops the custom nvmem device name from the mtk-efuse driver.
This was previously used for nvmem device lookup, but on MT8183 with
two efuses, one would fail to probe due to this. Since after patch 1
this is no longer used, we can just drop it.

Please merge. On the MT8183 ChromeOS devices this currently crashes.


Thanks
ChenYu


Chen-Yu Tsai (3):
  soc: mediatek: mtk-socinfo: Clean up NVMEM cell read
  soc: mediatek: mtk-socinfo: Add extra entry for MT8183
  nvmem: mtk-efuse: Drop NVMEM device name

 drivers/nvmem/mtk-efuse.c          |  1 -
 drivers/soc/mediatek/mtk-socinfo.c | 17 +++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


