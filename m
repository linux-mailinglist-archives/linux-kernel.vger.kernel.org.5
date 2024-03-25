Return-Path: <linux-kernel+bounces-118068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C288B64A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FF3B3CD8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84A6FE2B;
	Mon, 25 Mar 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OmCdKPSK"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D86F525
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403820; cv=none; b=FX8kT1OcpkZgroiXvLdqxBsXcctE8FGRVSDqzHbDtIvCgsz/az5PTPOMNRm6R+D5lX4P9BsUxFanHET2imbhL6KYTRRwNDMqZsOHdJWaNZUSit7DNw6n7cFj3qbNlWtjd4jGR4aQ7cUVhRvRc5wpbIgEU4uQOKJg3muqAPq5PXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403820; c=relaxed/simple;
	bh=yULUuFpaQi4mHiQRsxtWHLwt0K5+xxOrBTrFegQ3W+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9+GGqRx9dWrgugq/qpqpGUQFllAWo5zWVMGSXLhQiXwjMHOSviBeaPJV3iCqumTlqNX4yu70WjHHdDUEhLutAbSolU1jrox+DmuFX+rkRe3N+tl9kI0hvyd2TODZKC77bDX5o3mwND7TY9eZ6Ui4lLTq2j3nfEuwJX3k42u/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OmCdKPSK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso2439748a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711403818; x=1712008618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UR7sFSEYjP8BO01JVRD78Toou7R7NTsnLZcSYy9yMLk=;
        b=OmCdKPSK50QeT2a9kcn82Gl3bMDJ1m+IhSg8ywsH66zN+u8/XOUGmDBDhmKpqqmYFe
         6a3JvCumtCUIL9yKAIMDT8/kO5edOZR9k0ZGvoxUo4m3AxIPUbkQmVu3dltoi+Q5gl3I
         z8nLWvYEE3vN1YyWr1nY/f9JJ3FOezvm68CRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403818; x=1712008618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UR7sFSEYjP8BO01JVRD78Toou7R7NTsnLZcSYy9yMLk=;
        b=YVG7wERpJO+WxANg5hUEwLOzDKHTPW6aabsjD2GinvYQkMPq79s5VWEUudDYUqh+MK
         fzitR0y6ieOUP3nD7VRni8rI6UopbrnJ1LblaCbT6rssKwS3aVZYARX9LmolXionBWF4
         xev777aSQitgYEDsFXj3ea3VUr4BOqADYVABlIR0OX/JRGMBdP1L6k2u4RDB6zF1fE3G
         bsGmcyopF+d0PU2JGxICiKfcB89PeYVfvEJqIe9vtQSxjBcFwkBXwjS/08wh01WqHp4A
         pAdPDrFnl2zq5Z9kbYVr5qj3cfWPUn6SKapxip0g0Tn2diqHameoMyv/qlHMN5nu3yma
         Ychw==
X-Forwarded-Encrypted: i=1; AJvYcCXBKJzjMWUnpxk5GnfqlUG7bzhjJbufARQYu6q/RU78YBoEzYaJwlx/6P+B3nZBsHpq5RlF614L4jhp8t5JiBSwLz10UyvmJQqimgfh
X-Gm-Message-State: AOJu0YxXt0UVDd6yy0XY3kba50PmlgHWyGQOLbb707FN11vh9/Csxc6C
	iCADvIrkgh+yd6yrtmOXTEO1hEeh+3D1HXh34lHpUfCon/vr5pjg01bslLBRIGmA+eshAoljufk
	=
X-Google-Smtp-Source: AGHT+IFvvymI/+nAjVhwHLdNpVFDRLNACuh+o6MvjynK0XJWPebIEwChaIwn4LWdWp8KHSfw+SjCnQ==
X-Received: by 2002:a17:902:ec8f:b0:1e0:73d:9172 with SMTP id x15-20020a170902ec8f00b001e0073d9172mr10772950plg.23.1711403817749;
        Mon, 25 Mar 2024 14:56:57 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f21b:7dde:93cc:b987])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5207866plf.76.2024.03.25.14.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:56:57 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Pin-yen Lin <treapking@chromium.org>,
	Prahlad Kilambi <prahladk@google.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm-panel: Don't make failures quite so fatal
Date: Mon, 25 Mar 2024 14:56:24 -0700
Message-ID: <20240325215631.3804796-1-dianders@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch series is born out of the observation that after several
Chromebooks transitioned over to the generic "edp-panel" compatible
string that we received a number of in-the-field reports of the
primary graphics device for the Chromebook not coming up.

The current belief is that these Chromebooks are actually suffering
from a true hardware failure and the panel is either fully
disconnected or it has some type of intermittent connection. While we
can't solve that problem, digging showed that we actually dealt with
this situation better _before_ switching to the generic "edp-panel"
compatible string.

Before switching to "edp-panel", devices using eDP would finish their
probe and would actually not show any failure until you tried to turn
the panel on. That was a _good_ thing. The component model used by
many DRM devices means that if the panel doesn't finish probing that
the rest of the DRM device doesn't probe. In turn, that means that any
other display adapters (like ones that would allow hooking up an
external display) don't probe. The end result was that a device with a
broken panel that could have continued to be a useful computer by
hooking up an external display became e-waste.

I won't say that this series is the most elegant/wonderful thing in
the world. Ideally we could fail the probe of the panel and still use
the external display. That's a pretty serious re-design, though. DRM
devices work like they do with the component model because of some of
their inherent complexities.


Douglas Anderson (3):
  drm/panel-edp: Abstract out function to set conservative timings
  drm/panel-edp: If we fail to powerup/get EDID, use conservative
    timings
  drm-panel: If drm_panel_dp_aux_backlight() fails, don't fail panel
    probe

 drivers/gpu/drm/panel/panel-edp.c             | 60 +++++++++++--------
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  |  9 ++-
 2 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


