Return-Path: <linux-kernel+bounces-88090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B386DD3C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1461F26E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A06A018;
	Fri,  1 Mar 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="kYiJ+fHx"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865056A00F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282420; cv=none; b=CUcPr1DtwC2omySGN3niD0C/u41h8S1lf5FjjsldHzu/7AlJYKay05hTc9O80nUDqvl0sciULQSZpe5DehMVsuyvIUS5mMpfj8Ny/VBNcKU9L/YhIs4FbjjGFFCP8NRg3vtsp6uNzzppiZXweXWAOo68fUnUYqoQThqUlmb+EMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282420; c=relaxed/simple;
	bh=F1AJeGIO++EwOwEA0NDI6yJqtQvFffXVIE8lDzksl60=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UnWdbhkjzeCMyN1/gZusZ4oRZ+Mhr++QaK3egj3y9qMlLQ+RGegByh976uNdnE+0m+aXNQbv30THQryCcumTNpWFGkdF4tCbgIYySn1qKEFNCS/k+9UeNHHu7biAMGDqLYW6xpQaj/SR5+aP+J5MFKdD1NxYjuBEMZR8MLA9l7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=kYiJ+fHx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso1615425b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 00:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1709282418; x=1709887218; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5gSJCZo7ixIJLnhON1L26aJ3aOWrknxiAlTJBVJYsQ=;
        b=kYiJ+fHxFcJUY4BuhZC5LmF8mfzwL4uvHXtg2Qygcg45YYoFHeYD2uNTrS29Gaofo/
         kolqaXYcGWThPnOG1S0MC4U1HwxLa8Qie0YKiZ8FbDgKdJv6X4PyZhQU8UMIZHZDQ3l1
         KT1i980yKQXMSeQnsLTIzkWRIshK1P5+NIihAs5IwYgQhi977tphT4bgGVa9qS2FQrhb
         9nwzrOiJMrw2WtMNvNwwieCn7V3JW8aaXv7PTlEfYfYj6yigEDG0nvbYkrAmn59ztLX1
         1ZDnugo1qTkyyYurjLqmg9Y1iN7l1WZMx/4z7pMB4jQZho3D3dR2EfcqDG6kI12POXqN
         pe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282418; x=1709887218;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5gSJCZo7ixIJLnhON1L26aJ3aOWrknxiAlTJBVJYsQ=;
        b=qdAXaaHt2FkkE/CEzXpe6KvDeUlbxkt6SL77IVSSFoQ8g0ead+yOLL3dQaVYczFv/6
         5xKV0RxpDeoF4vr+1o+WAnEzquZI4rBBr0s+/uycRhP0v8Ujc6oqwJ5CDjYBVujwfwHr
         oEycdOm9xxFTMIFQvub/fgEqILvxYz4TPKSgNYG1LNG+xik0QHK7MNLEzqgBuZz3Nw+F
         PqCs86jfdKfSKH5VyCU11gWvTZorAIUxT3nEDy4h4hYJ2QWbfAmiDky3kCnzBEImvq4K
         Sou3uJmI6iL/A9dI90lQQwXcQLnrcXX+Vit0LYLoRfqaYKDresnbCqLBwdcaRMmZsdUp
         2z8g==
X-Forwarded-Encrypted: i=1; AJvYcCXw754/A2jR40XZOr/yQT+p0FFOTB3hAyaDlpRdOyvE54Rpt8rgjIociYvQebt2HChZgEiuiS8uOMfSclZGtan/c447tPv93fh3ebCC
X-Gm-Message-State: AOJu0YwFvqsUrsQhrYwI+IUpOdckmB9n9x1362CAwY5omCrrmDLA3aiJ
	w4jFPNT9mmNArRgobU7fONG04r9OqIvinDUamEu6AecJWzLirVv0M8xxg+2CnsY=
X-Google-Smtp-Source: AGHT+IFZeXSCqVXABlYyhd2dNoXuwhIgTgSE4/dK5a/e0RBUrLN1/e7UrxY0KflVMxJ8ZHEU3IoG4w==
X-Received: by 2002:aa7:8896:0:b0:6e4:fc2b:5f69 with SMTP id z22-20020aa78896000000b006e4fc2b5f69mr1596061pfe.4.1709282417746;
        Fri, 01 Mar 2024 00:40:17 -0800 (PST)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm2450021pfn.159.2024.03.01.00.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:40:17 -0800 (PST)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: dianders@chromium.org,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: panel-edp: Add prepare_to_enable to 200ms for MNC207QS1-1
Date: Fri,  1 Mar 2024 16:40:06 +0800
Message-Id: <20240301084006.14422-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For MNC207QS1-1 panel, Splash screen occur when switch from VT1 to VT2.
The BL_EN signal does not conform to the VESA protocol.
BL_EN signal needs to be pulled high after video signal.
So add prepare_to_enable to 200ms.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d58f90bc48fb..745f3e48f02a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1865,6 +1865,13 @@ static const struct panel_delay delay_200_500_e50 = {
 	.enable = 50,
 };
 
+static const struct panel_delay delay_200_500_e50_p2e200 = {
+	.hpd_absent = 200,
+	.unprepare = 500,
+	.enable = 50,
+	.prepare_to_enable = 200,
+};
+
 static const struct panel_delay delay_200_500_e80 = {
 	.hpd_absent = 200,
 	.unprepare = 500,
@@ -2034,7 +2041,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 
-	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50, "MNC207QS1-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200, "MNC207QS1-1"),
 
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "Unknown"),
-- 
2.17.1


