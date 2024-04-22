Return-Path: <linux-kernel+bounces-152769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5518AC405
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFDD1C20C32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7D18B09;
	Mon, 22 Apr 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="F5V/FCKT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7315E89
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766156; cv=none; b=V+nlP/d6bZx1Nl4MCYZWEtOstWyc7vd27Q0EXQcF4juLAmbpPEO3/F6P1oOHcQvXgageqqkpdphLieoP1voTDRKO+F3TJt3W3idFcKzcgMpfqNh0EaJMMZo9I15wo6Di7AZGTImNKQlyvtCLzIeZrnlDwKwbJABS6gOHyAgH1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766156; c=relaxed/simple;
	bh=nyArUnBg5/hDmOuC6ahA58yh3apbVYLq5zMmcb+2gVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCLAl3yHqT0KXy+Jf9L1rja81YPizIh+d4zZ4zLmecR235p98hkOlzFDhSocfHaNekoVqCTeYL3gYj4jaHqMObM6s94xXR4tZz4YiMs6RsKABq7+oS0nKpggjLDfG5AYM5bbAgX9WexwocNKyDE5yZtE4HzeQP2HdFKGJqwNgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=F5V/FCKT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed112c64beso3386994b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713766154; x=1714370954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPdE9YfOY6tF7QVVshsJe8Xe/FfKSmz53cCLcrBPnoE=;
        b=F5V/FCKTtAfRs8vTvGZZGYuj0O5/MKSRpoKYD97xWKHGKGVsARTIZufHFUvibuvIvJ
         UrnqLXxlxRfuVw8/yCTT23LNGc/M5EtoMcM99ebFZZ1p0xfTuHO3hqoWtLjtWPAI1hjw
         uiEHV8OssD1h/YZMIJQ5zD1U21Ptsr2K6lFTcEWm3dI+a6hiSnfgS6GA4XyR/ckscobJ
         bqYVO3Y+soyG8qVYvesgwDWxTGxsFEkWiExJT6OjWzUB+00GRpRj+HWgKjUkHS7d7RKD
         Hp5KcCH82CysoBldw4xNKkNzosQfKY5bEBufywhEPn1BzBa8dRrxnCV2cP+oK4FioRHa
         OuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713766154; x=1714370954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPdE9YfOY6tF7QVVshsJe8Xe/FfKSmz53cCLcrBPnoE=;
        b=RLFkp4Oqfv9AGNLr8KqVo6hgigdCQrrdhi6V7jRYvQUyqZxKk5mWlnYnt6Van6tAq2
         5CX2c/RFCwM6njkKbSBSFY3BeEitIClGnesEhCh2UoTI7UYQGZPgwtL7u4YgfD3Rk445
         7mfTBV1EmjskgVHkkCyzEVkjjYxJu0mC4MqkGKsuYeppGGm4M8N5tWaOiNZz6DOefat4
         0OXfhlTXUHc2+brD50hlnp7SO9KcHUklA05gxx5tSC4wLeFlVmWpX12mEa2YQJr90LTG
         AeLQto3hj5lUiYnnMh0JF077ZvdwHplojHKVDk6WJhPbAtjh2JrAtiGUiUdq1Nll0xth
         D0ig==
X-Forwarded-Encrypted: i=1; AJvYcCVT/oRBMSlD+SUnzfP2vqd5eCetN7olE9+O85CYurWuM79BKKmcfe2paV97GXLt80Ogtt3dDXOwlYsQganVbnvs/q1b8AJ140y3/cPu
X-Gm-Message-State: AOJu0Yyw+qzt7h2Ly171xn5FQiQVZDHj9ElVFHMhehXQ31f8x+OFLIHG
	GF3Vso0MUFVDLvqDlYrTp8kRFsQeaUIfXM+DhMRFDJVINszLTl/BmJtQ/qP1kcc=
X-Google-Smtp-Source: AGHT+IE7uuh+ywoyBucKduzYL7bX2Qw9Sd/LYqw1wAGxX4QfchDgzdgePUmiui6ueBcvQf1bgrpoXg==
X-Received: by 2002:a05:6a20:3213:b0:1a7:242a:cb69 with SMTP id hl19-20020a056a20321300b001a7242acb69mr7435722pzc.40.1713766154336;
        Sun, 21 Apr 2024 23:09:14 -0700 (PDT)
Received: from xu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id f25-20020a056a000b1900b006ed97aa7975sm7057014pfu.111.2024.04.21.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 23:09:14 -0700 (PDT)
From: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
Date: Mon, 22 Apr 2024 14:08:11 +0800
Message-Id: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the following panel:
CSOT MNB601LS1-1

Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index d58f90bc48fb..5e0b1c94bc62 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2036,6 +2036,8 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50, "MNC207QS1-1"),
 
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
+
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
-- 
2.40.1


