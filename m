Return-Path: <linux-kernel+bounces-79273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B8861FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050F21C2341D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF271493B0;
	Fri, 23 Feb 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPCLuslI"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBF38FA1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728005; cv=none; b=XnPbv7DZuiJk2qDbH1j0yEd5wMHXOaSBgTOnKR+gUmoKq93PTmhCZe6k0ht7pEa4BWCOtEBNr09Q+vOZm/NlcQxSgF2x+5J6pbnA5i2RzhBRMHGi6scnNyAzCaduUlL8+WZFmnppv38bEksFzl1AN4fSAVyrDu5Efj2FId96cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728005; c=relaxed/simple;
	bh=vi82t7F67vWmb9wn1/YBBQ4WZjEbzfWwx0aAy75cEkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XR5jYY/Ftha89MrcCdlgleytHul5mPsbIauuuvVncp+g7to6GowTEF17k8QLZ6WMG8h6v1EHF24VaGbhErwZEZawa9L5n/b42bl6EeISpF5Bt4KAuNlSYB1N1eW3M6fmWIJdx0qhy/zIinT9nlPZXR4Bm2uZ4GtAAEJ1bJjI89I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iPCLuslI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso729966a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708728003; x=1709332803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izkBVtvZeid9EW6DkeQXaaTaSvfcQ1H0IJ+Swz72A+s=;
        b=iPCLuslI9iTXUDpMy+ekI3bgqPVDfqklwTCx/SW0xEtpXM/kyTnMjcctgOXWlOnONk
         k8eYsCqSbK/tSzLhOnAxRybQ2BuxI08nydh9J2eHSdGcVi7K5cqcSa5+NUPrs+WdWmji
         YJRk6MjVPwvk+NrRW8HtHeaFRtMTWgHeBVEMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708728003; x=1709332803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izkBVtvZeid9EW6DkeQXaaTaSvfcQ1H0IJ+Swz72A+s=;
        b=kcrJfXXJ8M+EMmLasFTd420qwX2bAxTt05FcojREQOPdARyACEHA4O9OLCduFhCoY0
         iinQjxbK/eSEYM44p3869hwB9plCTTk+3sk1siAfzCXml1CW2Ww/HVLpei7aYr5ExuIH
         q0Rv/m6BLIdrKxdRPc/7+6BQBOm4NlE3tO9Ccg1YjgM/xsFwgNKBjdq0eW7eECFjczeh
         Zc2l5PHfoUJuKTvA03ECpvBylLxE1c+DwGnCpdIou5RntOZpiCBG6ngrRwSw4xxczc6J
         alwdThWnWEGlcjQdK4uLpBYMRQL+MF8LPAguhS4lmKPZ9g007YjGC4kfgt2k2j7ApL5z
         0Y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWStgk7nZWPcjHogiRXWB0irO/vqKDhe3zN2GlNyhdLK8cIDpdLgY0ZNT64AYqw1EuZ/kIIIFgFT+lySL8VHPaxSwRHFjEetQUmqukb
X-Gm-Message-State: AOJu0Yw0dUFLQWbmw5f5EiW6rDZRnAhSD/Uc/MJGsuXuAIlpuMow8z3Q
	jbxSHyyB8cRwLF7ykrvM75RR9y4u8yF2V1Ui+SP90RrML1gzZ0W+LoXwsiNUow==
X-Google-Smtp-Source: AGHT+IFLqEp+ut7+L1vZW2F/0DOKxAHKy2m3nbpPVLCCx3mk0ofsuFUvdrdReCRY9vZsTQ3VvgGtIw==
X-Received: by 2002:a17:90a:fb4f:b0:29a:8b5a:892a with SMTP id iq15-20020a17090afb4f00b0029a8b5a892amr1200115pjb.39.1708728002781;
        Fri, 23 Feb 2024 14:40:02 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:8ff9:a089:c05c:9af])
        by smtp.gmail.com with ESMTPSA id cz4-20020a17090ad44400b002966a13f2e9sm2032873pjb.37.2024.02.23.14.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:40:02 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Match panel hash for overridden mode
Date: Fri, 23 Feb 2024 14:29:16 -0800
Message-ID: <20240223223958.3887423-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: Add
auo_b116xa3_mode""). It's found that 2 different AUO panels use the same
product id. One of them requires an overridden mode, while the other should
use the mode directly from edid.

Since product id match is no longer sufficient, EDP_PANEL_ENTRY2 is extended
to check the crc hash of the entire edid base block.

Hsin-Yi Wang (2):
  drm_edid: Add a function to get EDID base block
  drm/panel: panel-edp: Match with panel hash for overridden modes

 drivers/gpu/drm/drm_edid.c        | 55 +++++++++++++++-------------
 drivers/gpu/drm/panel/panel-edp.c | 60 ++++++++++++++++++++++++++-----
 include/drm/drm_edid.h            |  3 +-
 3 files changed, 84 insertions(+), 34 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


