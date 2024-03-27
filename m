Return-Path: <linux-kernel+bounces-120592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3588D9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342DC1F2AD60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165B37710;
	Wed, 27 Mar 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKYgg1ic"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FE36B0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530825; cv=none; b=QlN3blImEThZ/PS97FdLzETlxVuOq6G88Dqbc0nbmO5ZjnPoV5fRXRE1cSfNSaacv5k/3T98dQ0F9qhQNiYJCXTEnqaKFTdhWg7c3CPgUx81VGJSxzGyj2EEAmWuBP4jGkkutkweHw4v3NAqZJJxaG9wx/31G/a4YkJbYCGHL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530825; c=relaxed/simple;
	bh=j/C0SCAAOc716GeWq9CRGrnpPBh/Os9U7D52YdIVHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGkz/dpkS764Co8h8whFfsByFq+faOoRxoWARC9mnTaLK0VKzm6j+IjLwiOb1D1njgQPZsr8euo7ULhVppglb5KhVhTF8JqGuedQyhexTPrQfi/9s3d6jFEroOqsUUax23g9hdVxM4oW4XQy2H2VnARyGaVHb6fPuRwEy22T3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gKYgg1ic; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso5713028b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711530823; x=1712135623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCP1xxVL+2XFFuRCnhWKsh1+37AXhGb+RDaWbRieDPQ=;
        b=gKYgg1icNJ7+cKeEiFs+Ash7jz3s1dulAxcoZ+zsBlaLyMoEKzMfgmTZc4ryTZV47a
         PDv9BVVi4prA6odyC0faQGacLotLB5UVUN92kGNfsvDbKckBrA0kmEPFXdIsaNt0U91n
         wmEfZH87++dBjlA6v1phk7AXkEu9RSWImFiNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530823; x=1712135623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCP1xxVL+2XFFuRCnhWKsh1+37AXhGb+RDaWbRieDPQ=;
        b=MNxm3IOt+hlH9MrDyEh3gUn+mFBEvZ7Fy+9Sy7KO6onS1M5xfV7q9OfuUXjYU9uqts
         Eh/m1b4+DsFMnlXdX+W0IBZpB59grcajkriZ3ysbs2Vqv3aoIXOa6Ez0E9BjMJicljIT
         KutHyu2nDFarUWbhR8kFgF1SagbbEmm5cFfF+ySq2m4GJcYfQuSo/XrzCjAbdkp150Pf
         RtLxKzW9XsvYFMX/xI3DiSMOsd8l4/m+zvOPGuD8pWrvogbTinXiRWfnheTxXPYCiOPn
         v8vbTsYYwHgVBmIdU/ODhIRgK75BpH6unY7/44OHexn1aJj8/RC4GO0FJ3Bzo5GLRgGZ
         B6yA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJqMKOpf/1z3Ye3VGFhZ90BYZh3JlBhereLbTcg1/MQ4kX7tY7tg8P5XvMQbE2DG0tK7YrN/UqfpNkN+mEVsqlpqnAljYLQjoGiDN
X-Gm-Message-State: AOJu0YzRV0Du7d6H1GXQKhQHz4/EB4VtlxaRS+3Ja3shu8zjLx3enYCf
	dQH0J8lmzIad1ZO1ixvQuYzlDiD+F7Wgk+Owyo3oDL1VEK9pfRxsXrtCmccgVA==
X-Google-Smtp-Source: AGHT+IGO/q6xt1tiCf12rN/iTWiDaEhcezoHgM4FVnnPfonMbt9q2BCRE5wf+w6mxtmS4gbOe5GCww==
X-Received: by 2002:a05:6a00:cc1:b0:6ea:c46a:3b66 with SMTP id b1-20020a056a000cc100b006eac46a3b66mr2396932pfv.16.1711530822949;
        Wed, 27 Mar 2024 02:13:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74c2:3606:170b:52f3])
        by smtp.gmail.com with ESMTPSA id fa31-20020a056a002d1f00b006e69cb93585sm7342911pfb.83.2024.03.27.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:13:42 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
Date: Wed, 27 Mar 2024 17:13:33 +0800
Message-ID: <20240327091336.3434141-2-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240327091336.3434141-1-wenst@chromium.org>
References: <20240327091336.3434141-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the generic pin config library, readback of some options are handled
differently compared to the setting of those options: the argument value
is used to convey enable/disable of an option in the set path, but
success or -EINVAL is used to convey if an option is enabled or disabled
in the debugfs readback path.

PIN_CONFIG_INPUT_SCHMITT_ENABLE is one such option. Fix the readback of
the option in the mediatek-paris library, so that the debugfs dump is
not showing "input schmitt enabled" for pins that don't have it enabled.

Fixes: 1bea6afbc842 ("pinctrl: mediatek: Refine mtk_pinconf_get()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index b6bc31abd2b0..9353f78a52f0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -193,6 +193,8 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &ret);
+		if (!ret)
+			err = -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		if (!hw->soc->drive_get)
-- 
2.44.0.396.g6e790dbe36-goog


