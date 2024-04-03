Return-Path: <linux-kernel+bounces-128952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07D896232
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B70B1C23683
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2815182DF;
	Wed,  3 Apr 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3A/S/Rh"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B5134B1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108592; cv=none; b=ua2Q3Nq+mrC/12kNC7jHBp1WkVHjYuyb7PMMKdXLCGWgW/sThq4s31als/sZgX8KVqYwGAR5B3ZhLY6cZk13HSmQiffUNVDfAhOSO6OZFG6ozsmdSpe16k+efZINU+qLma8ZjWJrhKkPHhuSKLysO6uUGVIxzFwcgjH5z0eIVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108592; c=relaxed/simple;
	bh=IEgsfHYCiIatShTq9fxPKsCrEa1BYDgA1R5BT0x/KPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K84dIab2ftX7v+lZpNhmGLwIYu+Iz34GL6A52R0Ioh39VZNqbI3u9+PbTBmopBZ75vKh1RuICi6qUQiiBdv61NjeJpr/Mrr/1hnQYwC/x1UEbH+O5Gl8UsUay82ldKAfZy/rPkqLBNybAbvLen0QvGZAUn+G3QTnBtJvUrkC1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3A/S/Rh; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1e0fa980d55so47412485ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 18:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108590; x=1712713390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ANtgOYO9WAyBBZOSz5s/CDBqqhmVXwUbrAduDgkrLo=;
        b=D3A/S/Rhhgn4DiIowmYW0RleG9WGLicGpnGpklZOUa/vCmpcn5SGXYME9OCg2s68Wu
         wUl2ECaiU8Yy1SWvjgyysihjXcBhclrNZ+uD3i8nDezFfcBBdeu8qoWcTwVDsNSErm27
         RVwecHef1tyd6eUD5bTQ8UPmrmdypz8WSHzANVPv35SUoz4bbHBSkr8pIJop+FmN4U2d
         IjP+YX+eE1gVFy/n3aWsQCAzW3/9hJqnes74XuDn0iu71xLBXQVV/k4QfPOJ29bYzafF
         BcakXunNWMoKjVKfjtRBZfxaJgwoQh3L2oV32VDRtLmwJcx29jJqIV5VGeC1T8+65ECm
         5pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108590; x=1712713390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ANtgOYO9WAyBBZOSz5s/CDBqqhmVXwUbrAduDgkrLo=;
        b=CS/sAb0INqibEf1EpragmXHpwC5y7M02w386P1ysnmV3o5VsR7bDa7fo+frclcQhPD
         kgrfXYZ7chSkzmA0bkTRzZ8iVOXdz+XeAB9n6V5C7RDuIZmY7SlM9vTKm63Qc2bUXws1
         9YyBieYLZisR4X/gauEVotVxBMlqSinloWHhRe+lDQJ6UdFwdKRdgal/08ua45mSHOuV
         EK2NxiwtR7S9YOr0DVqvN8ePVmuZqmldnxb+iwCy/iUFmCIKAt6Yvtt86susEtc3K4UD
         NWhdPu6OEGNXj5q5OUdjzD3bidS5pEpYUDiRRg5/OEnvax8uCpiG2mWow8nTig2WaUn2
         LW4w==
X-Forwarded-Encrypted: i=1; AJvYcCWMBb/tMT2FKkjlVekdWdObhyQsCIz6+kKSOejKCziBYhT2h9RrKbLUc3l4GdJDw2aKgQolt7dMh92ByNJaAiZBU4jy2v31j0CTwbqo
X-Gm-Message-State: AOJu0Yz03ZiogAggOVJaEkUyPeizjKU+uzAASfWNBZqchhz0bbZlA9W+
	dpyyWUQt1Qu1/e1nTgThsm4+nqAycHpO987F8roFQlKur754NQHM
X-Google-Smtp-Source: AGHT+IEjHW5rJt9AjAJeQQL1pwOLtFoW7nhT0e4O9cBD7XnMBR0LatCqNrz3lBIZ8UAAvq6da797wA==
X-Received: by 2002:a17:902:f547:b0:1e1:5502:18cf with SMTP id h7-20020a170902f54700b001e1550218cfmr1464299plf.69.1712108589903;
        Tue, 02 Apr 2024 18:43:09 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b001dc391cc28fsm11845534plh.121.2024.04.02.18.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:43:09 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] drm/arm/malidp: fix a possible null pointer dereference
Date: Wed,  3 Apr 2024 09:43:01 +0800
Message-Id: <20240403014301.969988-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In malidp_mw_connector_reset, new memory is allocated with kzalloc, but 
no check is performed. In order to prevent null pointer dereferencing, 
ensure that mw_state is checked before calling 
__drm_atomic_helper_connector_reset.

Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 626709bec6f5..25623ef9be80 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -72,7 +72,9 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
-- 
2.34.1


