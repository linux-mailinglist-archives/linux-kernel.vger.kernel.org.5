Return-Path: <linux-kernel+bounces-96465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4563875C88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58438B21568
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636528DDF;
	Fri,  8 Mar 2024 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws4ipUVs"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A622206E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709866322; cv=none; b=PzF4rlsTZNkzDkEfJCNIuM/02+0AcERRe0KU7ivx44KeYuSBILnAMJpCYrW5bHfBj8/twhSHxNiF6dOonO8SeXX1jzfQbUsvAmZBM0gFsO4WS7ENeuvC03NYKe9kJ/AX7wExJMkNlgODEmFJ4f0xWC//Z+BSt+qll5dTBPl2U+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709866322; c=relaxed/simple;
	bh=Yfzc7AZXybbKHNsurNMrpZ7nc/dZF+6Uwb+xK0ZPMLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=loMcxU6PevfpjvvqeS+VRBaFrT3vPEUM/FykOE6TY+3gaKxD7Gllt7iVbEpLKt8NSHUtXldoDPQ8NrGjy8n/ULgirJtU+UxxPa0Hh+pgoCLOe8UOLaydWhe93zVim61B2Amzhrgljboztf+SpPIX+34P6S/nxdu/Dj558FCacNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws4ipUVs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso236629a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 18:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709866320; x=1710471120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baVudaZS4zD+8o7ZlYXWf30QyVpCFFcOvkwKCWeTB6I=;
        b=Ws4ipUVsGlLerBYtIAKY53Pc7tXj9bprctShWK2d6weAmL5iN5+5JIwEIE6jTxj5R1
         PziISte3Wk4zdwivwxNkEghvEi9QobQoN8/PxQne2DrKQudlVqK6neqjbx3SBOcbs2Fg
         uAbKgoNqcwH14d9clY4vsoKqDUg2fqBhMwhpzB6f7sBle0RXNuVRhNwOlGfTydIPNL5g
         298APhGfKlQ+CbZCrTbXh/u6FMLpiqrYZF+dWIXfBqke3zn5xalZpC4WaLrJU65QAclE
         GCQ7xY9s28ZXcqKulqwKFASNnNXYQjNPeTijM8DF+ZDvYBHXRjXrdtR5fUxXkvT0IGgu
         Cx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709866320; x=1710471120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baVudaZS4zD+8o7ZlYXWf30QyVpCFFcOvkwKCWeTB6I=;
        b=GIqiybR7rroDjTm/CK5m6iD14n2/rTIeFcbnk1304NJ5uDMJD+acooosFF0ndsu8sI
         CFx6cCRZBvEHmEeHsuLOyU08pYUKJ+rlDQ0xIFwMxWGFAWRfHAub6glba2UO7geNdz9Y
         RFgHzdG2TlYgNlU5P3gUhoOveUFDC0e1hnhescaveJQdwnYCZPwx05MG/sNgE4Qg5DQP
         jdTrUzQ3X60Q1ugcJFRFwB0O1DjdUah50b2C1BnO20JxXjf47cLpDj4g1mn37eb8bWXH
         KzolXaiPFUvURXD3BGBrc/qe1fRRzqDyvmxSXie9j2qPBqRmsMGFYAAaW5Fb7ssOhPv0
         3Taw==
X-Forwarded-Encrypted: i=1; AJvYcCWNkbGFWhnWzMIHtaKJEaCY9JgAw/pFC7XCSAhDLjNDcRwqGFEeFm7NlC3qwVTkova8+pS3T4raDitWz9SzyV9FXnFmL1dgfiW6THM5
X-Gm-Message-State: AOJu0YxA3aP9KenbGBzVxjRs7WQcPUVQnnJFwhWvB5TyeWG6o70hselb
	K8YJ9qUrFI/aqR2aPnSoeoYK0YkDv6AAs37Gz8XZmYCzc6aR0KPq
X-Google-Smtp-Source: AGHT+IFvgO8ppt6dHktQcYZ7vUjAd53/vJ6tZUJHApIea34LR7LbgXp7EGr+8/vDJWidOhFELPUCAw==
X-Received: by 2002:a17:903:32c7:b0:1dc:266e:a7e2 with SMTP id i7-20020a17090332c700b001dc266ea7e2mr11009745plr.11.1709866319761;
        Thu, 07 Mar 2024 18:51:59 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:de01:1b58:d4c6:7d2f])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b001dd5b86d809sm1677827plg.279.2024.03.07.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 18:51:59 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	lyude@redhat.com,
	imre.deak@intel.com,
	jani.nikula@intel.com,
	mripard@kernel.org,
	ville.syrjala@linux.intel.com,
	Wayne.Lin@amd.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed vcpi field description to fix kernel doc warning
Date: Fri,  8 Mar 2024 08:21:52 +0530
Message-Id: <20240308025152.17297-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For linux-next repo

/include/drm/display/drm_dp_mst_helper.h:156: warning: Excess struct member 'vcpi' description in 'drm_dp_mst_port'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 include/drm/display/drm_dp_mst_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 9b19d8bd520a..3ae88a383a41 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -83,7 +83,6 @@ struct drm_dp_mst_branch;
  * @passthrough_aux: parent aux to which DSC pass-through requests should be
  * sent, only set if DSC pass-through is possible.
  * @parent: branch device parent of this port
- * @vcpi: Virtual Channel Payload info for this port.
  * @connector: DRM connector this port is connected to. Protected by
  * &drm_dp_mst_topology_mgr.base.lock.
  * @mgr: topology manager this port lives under.
-- 
2.34.1


