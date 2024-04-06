Return-Path: <linux-kernel+bounces-133878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ABD89AA39
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72E01F21BF1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C5E23767;
	Sat,  6 Apr 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNEA5Z5o"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FF225CF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712396898; cv=none; b=cD9Sw+oPba0loE+t8xLRgUNAssZZDDhMIILeNHnyA/oqT0qHfX8Fw3aY+5GqnpXwkAAq4ijxaATCnTAvCmHXtf4Me+Ok2qoJveg1MV+tS3qdd7uqm++1Me4kb8OYyzGVkXbj8T4KqKHid7wrX9KDAxb4fYC9yIMFwVKdUyZjny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712396898; c=relaxed/simple;
	bh=/MfpN9okl8H5rFoHIvWq24WtEgguQcP6QqEsBwHAG/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjF5mZN0iTq/Nfn3ow1vgUedGqfFfIYqM6Ln68FE/CsLImSnIeQJCHxFL98GRjZbVXsWNkgg+CQ6UAKlm1gdNbtVlMNHEEQPC46fEG9q2/1yxtJpUX085LbN2uf8CyT7BVxYP3bxhMLqddu9k/gswsivDmNl9lMHjSkWVHRIFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNEA5Z5o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed150119f6so204946b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712396896; x=1713001696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48v1DyWIRGHgOWn3r5CxOJNWFsbPTbw0i9C5xk0EDEI=;
        b=CNEA5Z5ob/fYQd7LGzCAGF9I5kyO3RRpMmLmNVLM3Rpc5vnNDfSKIQyytCTKXmXf7x
         XBFPveCbxOrKb2wbLO7Kj74u70DtXenXrcHMyH73pG/s155M3t5xMpDtU0rcGKU98TXt
         6XqFp5TUvJUi6pPQ1B6kcVnkYIO3wnrYCY1W1Kh64V0ULP1uq+Kd/nqQfR7J7L4ebTgD
         KO4ET6YzvudC8cB/PacHffXkJcH21g8wn9tZ3rq3p3jSqOwZ6wPN6k8MqWSZ6ARh/1Aq
         rpyqd2kBF99sLtAG6zMC5BikXYrQMutf+Eh0WFBs6V20AAq7PXmIUQ/BF08soSCUsxnH
         QsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712396896; x=1713001696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48v1DyWIRGHgOWn3r5CxOJNWFsbPTbw0i9C5xk0EDEI=;
        b=r9h1WXY6Xi4FzYTH+ggRA0Z5XNmMNsZdYE2GYrwxBFUxdY6wynRQXEgq/hXwsnG/Gn
         lo5wXPIsf4+NK44IFBVmiJbl6/cAxK48sF5mIUNQNY3lUhNxrvMnlDVPenisZlnZfz2J
         qw3Mmgz1BZLHiOzdzcDQ8NXk7kvXfVFe80sZT/6IMo+x/5uCGvZsB3GduV87DEWxcSgv
         USF58LnaLqhDETBzq9vNDsTqCtUvagavAFC5YabzNWP1a4iUfO9aAhu5U13XFCCTbW1X
         D4o9KJ6M2AFP1YRxHcE9iX3Tm25EXvgzHMIGcMtQiOz3ujw8DYngF+vg7hxCin/zTP15
         OWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFW8iorANH2Hxl5xYWFRJD37Yc44X5PGCiFrSXNO5EuZZE+E6H5IHSZok50sWKm99557V3e+cK/qoumhrpwjBWyKMuKGpsOinjvXXt
X-Gm-Message-State: AOJu0YyWVTnEC9GcnNeWOwGTX6GlVGzGY1c1C4brUc7wtRHCNvn2hHh/
	gFRlvicVRi8J04YPE/6EPT2lsOHT9lwh0bfCQmwUEzEjyG1+W+1l
X-Google-Smtp-Source: AGHT+IGCWcAU2MpP1I6UGGQFKMtNKfCgiiUZSakrZ9PbkmO4OoKTK7qFHCDjW0zqxVNfGpmgqJ2uKw==
X-Received: by 2002:a05:6a20:8423:b0:1a3:ac20:e204 with SMTP id c35-20020a056a20842300b001a3ac20e204mr4823805pzd.3.1712396895877;
        Sat, 06 Apr 2024 02:48:15 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:6906:a9a6:61b7:7791])
        by smtp.gmail.com with ESMTPSA id it10-20020a056a00458a00b006ece7862035sm2855249pfb.128.2024.04.06.02.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:48:05 -0700 (PDT)
From: R SUNDAR <prosunofficial@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	dmitry.baryshkov@linaro.org,
	ankit.k.nautiyal@intel.com,
	mripard@kernel.org,
	jani.nikula@intel.com,
	quic_abhinavk@quicinc.com,
	imre.deak@intel.com,
	dianders@chromium.org,
	mitulkumar.ajitkumar.golani@intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Fix for kernel doc warning
Date: Sat,  6 Apr 2024 15:17:40 +0530
Message-Id: <20240406094740.7143-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[linux-next] Changed enum name to field name to fix kernel doc warning.

/include/drm/display/drm_dp_helper.h:126: warning: Function parameter or struct member 'mode' not described in 'drm_dp_as_sdp'
/include/drm/display/drm_dp_helper.h:126: warning: Excess struct member 'operation_mode' description in 'drm_dp_as_sdp'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 include/drm/display/drm_dp_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index baf9949ff96f..6799f57d635c 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -112,7 +112,7 @@ struct drm_dp_vsc_sdp {
  * @target_rr: Target Refresh
  * @duration_incr_ms: Successive frame duration increase
  * @duration_decr_ms: Successive frame duration decrease
- * @operation_mode: Adaptive Sync Operation Mode
+ * @mode: Adaptive Sync Operation Mode
  */
 struct drm_dp_as_sdp {
 	unsigned char sdp_type;
-- 
2.34.1


