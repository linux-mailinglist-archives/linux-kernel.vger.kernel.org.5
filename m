Return-Path: <linux-kernel+bounces-144098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222358A41C1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239D11C20E18
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5E25634;
	Sun, 14 Apr 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzK7vl6R"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87F2421A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089610; cv=none; b=qwnQ0k9AkaKQT7DudLnk0/6azjrM58BbkklLBsckqULfOToWExDcfUpfOfGhHAKYu8peyQ0AtlvK+LPjQ4TP5S/9KTFlCsCRNV7/L8npVXfHTbWwOi8S3NdgNw/ggrux1xuEw4xKlP9U3W5ndOnHBqG14mluPGnCVxvw84yO82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089610; c=relaxed/simple;
	bh=eu3RIPlesOCMNpapPQiLQQGHQ5c0R8gFHURQsuCA0to=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lv8WXBzKRQfXWGNHozq69vacT6GkDx2M3bW2NeSfGKl03wKYgUROJmIQIMsHWUGmi++Xsjm7aYwFMt0fPMS99iJ3tSFj+bmylXT0ggIQnlvVx3zzCXT7g0yPbByfrRR8hWE12TfR+9nuEP2xX3G0vB8fDg9iLo0Shs1YRkBhAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzK7vl6R; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a526803fccso1179354a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713089609; x=1713694409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppS6ek5/XJpbF167CeCFNk04CBvsK3wqfw3EHalGC50=;
        b=IzK7vl6Rq2r4nJc5GfiyAcz6+Zv8vdHQgdwUMWhtfvJwSsFbnQG7O5XWowhTZ4+//6
         itEx6YbjURz5c9rEwrKIbyulwOxltxDWw5e8zWaqYSay/XJ4azccVJZ0T9hQOy+BJytD
         DHVXN1sOYXRh+hFRQggs4nsdSxtA4Um+tDL6d1MZhjFOaRudLkwAcU7HqA4Du1xS41Tz
         KFkPZqMJL6/Yk5A6twg1qxkxmlu4NuCqUps0Bggn1klVGrekdkbqn1xws3Y71b6njJIi
         qCDvGJEmBOn0wfohlrTSJRxYoFjzmr2VvP5bw1OtGDTs/8OsSGjN2HM2vL35+C7nbzZk
         xbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713089609; x=1713694409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppS6ek5/XJpbF167CeCFNk04CBvsK3wqfw3EHalGC50=;
        b=Qtq3AKv/neqwmhFQP35+3ISrItxR12sQHFCh6k32yyF0ss2wdELnEW94TuhbvgQknX
         purs3KkrMecxeRGgKCX7Us29d15ng1bnIxtQNqdR9P+FOuzE68uf+6Gf+nW7z4ltNtXT
         2EEgLM4krlHvNxfTLfzSOSrfmGHd75O5q5P8DADrQ+vmxOQeFsuUOp2dJ/wUUuk2upVu
         bQDd5cDWfLogCyYroXol6RsvoHSjOTpBbFNN3YX+Bt4kgv2oWwgrwvSuCMpFl67k/AJF
         OtfzGqsiGVlDROplUP8i9Z5qDrXGSzEFK/N78zC7FTWJfK3gfE9bi2kMqywFZuAyztCn
         ZxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCEMjYUiqiu3RyQHgEkB3Vvnlhc7wjMgX3idtr2NKBydcui/NBU4ukBSzTGt851cJvGGbE3kCCoYgiLIYfXOgDKQ6uX2hPI//DzCsC
X-Gm-Message-State: AOJu0YyceRh/Nfv5Ej48jpgayS+3ssavie4smOYQSkBoEzpfrXgmP+od
	P31+2M0s/RBXdyKmCkt9A9LiN+YDG3JFhqASEgEXPPSizgydMc8I
X-Google-Smtp-Source: AGHT+IFOEUpKQEYzn1hknyRGE+08JrW+3bzlUB4i2iZR8oLtnI9F1LxxbNLsHakD5WowNGpa5ws/9w==
X-Received: by 2002:a17:90a:38c3:b0:2a5:37cc:cc4e with SMTP id x61-20020a17090a38c300b002a537cccc4emr6114571pjb.32.1713089608646;
        Sun, 14 Apr 2024 03:13:28 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb8:5ab4:8eca:a8e7:b24c:7514])
        by smtp.gmail.com with ESMTPSA id az21-20020a17090b029500b002a0187d84f0sm5304830pjb.20.2024.04.14.03.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 03:13:28 -0700 (PDT)
From: sumadhura kalyan <opensourcecond@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sumadhura kalyan <opensourcecond@gmail.com>
Subject: [PATCH] staging: vc04_services: Code optimized to use linux BIT macro.
Date: Sun, 14 Apr 2024 15:42:58 +0530
Message-Id: <20240414101258.98358-1-opensourcecond@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue found by checkpatch

Signed-off-by: sumadhura kalyan <opensourcecond@gmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
index a0cdd28101f2..d811bfd3bb84 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
@@ -27,7 +27,7 @@
 /** Common parameter ID group, used with many types of component. */
 #define MMAL_PARAMETER_GROUP_COMMON		(0 << 16)
 /** Camera-specific parameter ID group. */
-#define MMAL_PARAMETER_GROUP_CAMERA		(1 << 16)
+#define MMAL_PARAMETER_GROUP_CAMERA		BIT(16)
 /** Video-specific parameter ID group. */
 #define MMAL_PARAMETER_GROUP_VIDEO		(2 << 16)
 /** Audio-specific parameter ID group. */
-- 
2.25.1


