Return-Path: <linux-kernel+bounces-125228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB27892276
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1661C27EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419113B2B8;
	Fri, 29 Mar 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYdkybMP"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191436AFAE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732238; cv=none; b=p7kGMAFKVGIZfGFNVlonFdFWtjpITFbJMDrtKeBMoJbxqedXFOwqSorsM1u4jQQncRGFqLzj6XJnOibVMe4v5AsLHBFa2trya1oAZIJmqbvrQAuQ5TacY0Td/xKjx/+juYi6+Yyf8I0muJ2zS8ttQqqvvNVRVeLDKy/al/R+5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732238; c=relaxed/simple;
	bh=TtoLYL6/37TatoGV95OdUAgrxwm+qIAgopro4pJ3dOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pt2RO/F358GE01304RvMa3R2TwLEqv6ZtL1kZnrUuEjNYSkAobpTWhPb2+B/GhCNTyw8pZjmxkRI6VJix/4zDEqRPAi0e2DuSA/508JpjKcsEAlfWl1zbVtJpjEaZ1GYexXE2jX74/RM15LD3lEv9ZdvsXABRJi+v6kox9X/ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYdkybMP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1335506f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732235; x=1712337035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EySlbPc6lhk6b3mrukjMCPGSpH2zeiX1mm/v3sWT7Wk=;
        b=pYdkybMP/oxDS75jztBh8pcoWsmTGNySgSqINdQP1oknjqoRlVvHX1zudh4csugXan
         nLp4bYyy6IxM/lpoWritifzvYUjv8ZT9QJ8PoV6cML0wfzWIFOOKWBXf8/eQF8RC6NeA
         s+Tua+XD6G5LH2aujkPrEEudk7NsI1t+Ppd+yI0aFzPseBHk/d61TAJwupj7Nyb/nSHI
         snA43tbpq1Ri0hFzofiiYHGCAArUeNj62Et3NzesglAN0ELsXMdFa61UTme/RlTWtaBv
         N4OBfgAbcX+6HWWSSt2VkhptZpdOjuVv60J6rrJX3xnB4PGgY6tS/JmNVXB/yBk7QfNk
         +ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732235; x=1712337035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EySlbPc6lhk6b3mrukjMCPGSpH2zeiX1mm/v3sWT7Wk=;
        b=TeGVMki+EqrLeo2j63LgXj/vFhdmk1N+wkREZSjGjrud0PO6StiN7vZKS+0pf4d9jX
         dMgZmV7y9mb0+IecaW9RoWV3PaqygK9pwH5RltrjSC7n/PSa+potXGlBLUAoxHdXFdiV
         efqjX8218A+sS1gKsM//4laPYDvHJdFriHH5mgCq59T9kj45mJ90RsI/DSpnWgWHhoRG
         Kf1TbLkwISmloKzgLcfL+JsfMl8o441VLcG+1+Ero3hbVIgwqkXGrWApzQKQsrsusI22
         c2t1+PmGoWOQgVhZLP2Qlyr2E8Irm9VH1t+RVB8p2k+MFCvU1d6CIpCJRjfzoEnl8ZSs
         QP/A==
X-Forwarded-Encrypted: i=1; AJvYcCXEN3Alw09HwWqqZOI0Mhavm3iVzuqpSFq/FaNQ15clk9r3f/aGrGDyNLTPrf2wqpdXNUdgaGK9Jy39AlOZerZGcTU5Cj35tE1P9DG8
X-Gm-Message-State: AOJu0YygqB6gTwjAmqiEZ7E9cSJ2Y7YLGxjaxq7icO3rasm3rID+GeUs
	Rf3siGzldNT7C3Vo6RKPretV05lqq0z4mvOImnrw+sCKakG3emLcRFMMDcHXwY0=
X-Google-Smtp-Source: AGHT+IEqNLgv3fhZtbvScXxguICCF550H3MDTyxKI1RnEPjR6ISgVMuNMpqBGyf1gUhiVrwdueDb6Q==
X-Received: by 2002:adf:f108:0:b0:33e:c68d:d536 with SMTP id r8-20020adff108000000b0033ec68dd536mr2617553wro.15.1711732235465;
        Fri, 29 Mar 2024 10:10:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] wifi: marvell: mwifiex: replace open-coded module_sdio_driver()
Date: Fri, 29 Mar 2024 18:10:19 +0100
Message-Id: <20240329171019.63836-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use module_sdio_driver() instead of open-coding it.  No functional
difference.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 75f53c2f1e1f..e1b58ca1b3ba 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -3183,7 +3183,7 @@ static struct mwifiex_if_ops sdio_ops = {
 	.up_dev = mwifiex_sdio_up_dev,
 };
 
-module_driver(mwifiex_sdio, sdio_register_driver, sdio_unregister_driver);
+module_sdio_driver(mwifiex_sdio);
 
 MODULE_AUTHOR("Marvell International Ltd.");
 MODULE_DESCRIPTION("Marvell WiFi-Ex SDIO Driver version " SDIO_VERSION);
-- 
2.34.1


