Return-Path: <linux-kernel+bounces-151661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4028AB1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F5281F26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0512F5B2;
	Fri, 19 Apr 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6e+1u4F"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604112AAF4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540201; cv=none; b=bEYAEOB48a8138JUE9ozANoFCZoloQwq+EMEt4y3HsrHrl0TecRnZFZEUPew0Js9mgl8wc59h/WPBnlZYukm/7zYjJcXs8hLugxZ/CvgZ4hQQPZiH96sZ8VPh2bmS2uD7AP/gJGkL2yMTHu6oKCMGNK3yAZNpdYivsn0RdLBBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540201; c=relaxed/simple;
	bh=sMYmeGEwN83BEA6+SV4SlkrUjV7nTJSPzcIVkqnAUOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iip9VBO+RijgumQGs1raa57jnLXy2Y4Xu4LRv7DtetNRqHf2Rxg0vcBhLr4Dh8WDM7G1CmiybPIsxU8sPS+VHw3QjciEPRvV0niQIEZBs+xRZJ2bDh6MB3/Ip3y9g6lf0h11gab/4zIU71fhOrOd7S9v/r5daZhbHZ329fekvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6e+1u4F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2336132b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540199; x=1714144999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INx2PSoC80punQbd7jMF0869fDvIdi67uwkmtDA3+5E=;
        b=Z6e+1u4Fv67m8KLYUfnEJEe8LsMzNUr2AkyCpkBMTrt6/tVfj4mbmsH85mNelEsxG3
         m9ZuoOR6BPQcKAyxkQRaefuN5CO+LR48/VeiRKLa+crZzYoPv+GY8suUm6plVHavnLyN
         tHR+aGt7bEWRtjKI2Aau3njjZwOIPXwQb+PxveAJ0MH8n8vADlKrD64I2AeAG75AXTjj
         Bp7uOr9e5KddNR4uAAZFr0jwpCkJoDHpUStaIJE0Y1K/OwSxP0BwfirxUBTmoFZCrr/f
         bg4YkPTqVNZnk48dbl+w8UwVYXXcmJLe8N/aFR+cbwcI+CfJde/LDOVEDKwc52Mc3we0
         CNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540199; x=1714144999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INx2PSoC80punQbd7jMF0869fDvIdi67uwkmtDA3+5E=;
        b=JEa0e0k8TxhKXgxyew2eE2rF/TWboael7uvPBF/t526L3u2g6vkAX/WYuQA2IeZjU7
         vUHlPOcR/ILxZojtNOFt4UBJOtOo3rNxl1tXwJlN5+7eDqXri8fciWP56txVtBQRJf3x
         O7z1e3HfPLHrnCGuCyunV6tqmvv4NjswZzqkyiy3liRhmfyBCqP51cAV9dvd8ocX3f8L
         lHdQzXBv0oTmeqbeZ/yygkyKfus2Tn4kM4SApd5kDoqjvPz6K8TPywwAuCE2IIt1FfFY
         iUruUbHqiMU76ZpjsEkrl22L0XfK1IWrPcSewlbxX14s4OAr3ORoKsarxvnNLBvALPwr
         /GkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJpDK2GcA+IsTHR/x6+P+LJsSNzij5y5GKm3qmGL1dvea2EV4SpTbbYb0XcHk4p8Qhh3cJqIzXNhSwCvGr6BidebHERcCleFRs/2fu
X-Gm-Message-State: AOJu0YxvnS9CeoavtOk7N8KHjyVCNx1rGpDjPRGjzUvFGYh9iSagvi5o
	d8NUsHvFPmMTxFfK56nKrWxp+kTcZJbY3k0ORk15EXuGH+1eaX72
X-Google-Smtp-Source: AGHT+IGDRJOmEWJobRQpk5TnSzXpKTEgICaYfQ2jmDxPFG4qoZuXuS3icvGufHpIFmT4dog+HvWLfw==
X-Received: by 2002:a05:6a20:7287:b0:1a9:7f1b:e3f7 with SMTP id o7-20020a056a20728700b001a97f1be3f7mr2884556pzk.50.1713540199574;
        Fri, 19 Apr 2024 08:23:19 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:c4a9:af77:5f5:9531])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090a3f1700b002a55198259fsm6412036pjc.0.2024.04.19.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:23:19 -0700 (PDT)
From: sundar <prosunofficial@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	sundar <prosunofficial@gmail.com>
Subject: [PATCH] Fix for kernel doc warning [linux-next]
Date: Fri, 19 Apr 2024 20:53:07 +0530
Message-Id: <20240419152307.13099-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the kernel doc warning due to typo error in field name.

/include/drm/drm_mode_config.h:973: warning: Function parameter or struct member 'size_hints_property' not described in 'drm_mode_config'
/include/drm/drm_mode_config.h:973: warning: Excess struct member 'size_hints_propertty' description in 'drm_mode_config'

Signed-off-by: sundar <prosunofficial@gmail.com>
---
 include/drm/drm_mode_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 06d7777a881f..8de3c9a5f61b 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -953,7 +953,7 @@ struct drm_mode_config {
 	struct drm_property *modifiers_property;
 
 	/**
-	 * @size_hints_propertty: Plane SIZE_HINTS property.
+	 * @size_hints_property: Plane SIZE_HINTS property.
 	 */
 	struct drm_property *size_hints_property;
 
-- 
2.34.1


