Return-Path: <linux-kernel+bounces-168262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302978BB5DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA84F2832CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006C5820E;
	Fri,  3 May 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bejV8R1y"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D54CDE0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772186; cv=none; b=F+U3rByDTRAuRlWXU4Ki98auQf14i0CuLSR1zV8QE9PgKbOX7n83cAyhKKxIpYWjV/eOlRGfSAb8g98AKz319OOtH7nTE7jJDFiAXqtG+SeRfYOIqLcjic4iqLE8HWKF/E688oOmYSX4ehXzWd/9Q5S/eKGAvBfP1rqj1fEgykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772186; c=relaxed/simple;
	bh=zPdUhEqWBJ29dUl2NmZwwOZKTWDEHAXfImCAJa6FEJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pF6+QxHvHxTOoFStvHARV7cqHfiTuN2HCAklGcQvzH4g8b0wixmvyj12URhmtsmqYCBuT+uMkUNbWo8gCbcoMeEHQTKQ1nuwdKD7b11AIDozRAAvk/7uL2NggsxuFsGv348Grj4e63IqYXCKqtq8GxD8QUGYpBM/UvoM7baO00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bejV8R1y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3f17c6491so778445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772183; x=1715376983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7IvcNsNHU8RMEEGHB36x94SUhZEWVNbyGS+d0gObkA=;
        b=bejV8R1yB7mZngTOPiRdHYmUxE05BRPS1ROUnG/rWyJuT8Ns78KGXJ+QHqFvu24O9e
         VVPJ9zO74+duR5I/J2Bn3wQ13DmF2hImmkqmM7hhiXCetce6CZNLqyP8UzcNP5gSmQzc
         Qj4VS74FJqI93SFvOEp+9VLes4vNTwQ9NLawI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772183; x=1715376983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7IvcNsNHU8RMEEGHB36x94SUhZEWVNbyGS+d0gObkA=;
        b=QI4QY4VUI04xQ1z55wiUkDdCjMM+Kq+XJnpB5DHq9aFBHMLKvoomOpFp1A7EAEG2am
         FwbcxSEmbIOQkGmZO+a5eY5iswgWBitLVkcSH+4O/C+lrY9Jezw/cqnvdh7x6lQs2HON
         JfDNTWkMD9D3zRLl6V50Kwu5+UFdQJtZ4kkU0ZuAb4rMSBJzwcWXE1tbU1o4Ok7xF9RF
         PFMNM/Pk3zjC2QMILDM3lmy5cE3gK679lXlGR5OStzTDTKvySUeAfaHs9NIzIdMMXDb2
         0o90jKa4rTgAgbWpNJQY24AU1BaT4RNk5UiPu+QeX1fHssQbUAQk7A+25VdwWk0WD69E
         IX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6JyyXe9Zd/iLbw3H/6tQ7mFn5yKel1lSS2a/WamAhzNjCrYyjt3D5+v+lsLFysXV2VQveNQdQo4OERhkEZ0PIkdTa4CGmhvUWTqtJ
X-Gm-Message-State: AOJu0YxN+k27X3V3RXfJs4m7td0MdXfLhidYL0T6C02wPlPDI/P20Rna
	1NUcGG3jNmD75QHmCYnSf5Ei0tRtrVR3/b3B2HJaDZDXPUmv/lXtp3is/OLqjA==
X-Google-Smtp-Source: AGHT+IH5eduOHdb1FCgLuhTvqIJg3l60grEr/JNT4BiC6IxKFTTgVq2iMUFgza4DOD4xTrjDsAYlqw==
X-Received: by 2002:a17:902:e882:b0:1eb:4950:554f with SMTP id w2-20020a170902e88200b001eb4950554fmr4690309plg.22.1714772183009;
        Fri, 03 May 2024 14:36:23 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:36:22 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	=?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Purism Kernel Team <kernel@puri.sm>,
	Robert Chiras <robert.chiras@nxp.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Stefan Mavrodiev <stefan@olimex.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [RFT PATCH v2 00/48] drm/panel: Remove most store/double-check of prepared/enabled state
Date: Fri,  3 May 2024 14:32:41 -0700
Message-ID: <20240503213441.177109-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

This series attempts to do just that. While the original grep, AKA:
  git grep 'if.*>prepared' -- drivers/gpu/drm/panel
  git grep 'if.*>enabled' -- drivers/gpu/drm/panel
..still produces a few hits after my series, they are _mostly_ all
gone. The ones that are left are less trivial to fix.

One of the main reasons that many panels probably needed to store and
double-check their prepared/enabled appears to have been to handle
shutdown and/or remove. Panels drivers often wanted to force the power
off for panels in these cases and this was a good reason for the
double-check.

In response to my V1 series [1] we had much discussion of what to
do. The conclusion was that as long as DRM modeset drivers properly
called drm_atomic_helper_shutdown() that we should be able to remove
the explicit shutdown/remove handling in the panel drivers. Most of
the patches to improve DRM modeset drivers [2] [3] [4] have now
landed.

In contrast to my V1 series, I broke the V2 series up a lot
more. Since a few of the panel drivers in V1 already landed, we had
fewer total drivers and so we could devote a patch to each panel.
Also, since we were now relying on DRM modeset drivers I felt like we
should split the patches for each panel into two: one that's
definitely safe and one that could be reverted if we found a
problematic DRM modeset driver that we couldn't fix.

Sorry for the large number of patches. I've set things to mostly just
CC people on the cover letter and the patches that are relevant to
them. I've tried to CC people on the whole series that have shown
interest in this TODO item.

As patches in this series are reviewed and/or tested they could be
landed. There's really no ordering requirement for the series unless
patches touch the same driver.

NOTE: this touches _a lot_ of drivers, is repetitive, and is not
really possible to generate automatically. That means it's entirely
possible that my eyes glazed over and I did something wrong. Please
double-check me and don't assume that I got everything perfect, though
I did my best. I have at least confirmed that "allmodconfig" for arm64
doesn't fall on its face with this series. I haven't done a ton of
other testing.

[1] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid
[2] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[4] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Changes in v2:
- ("drm/panel: raydium-rm692e5: Stop tracking prepared") new for v2.
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.
- panel-edp and panel-simple just get a comment now.

Douglas Anderson (48):
  drm/panel: raydium-rm692e5: Stop tracking prepared
  drm/panel: boe-himax8279d: Stop tracking prepared/enabled
  drm/panel: boe-himax8279d: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: boe-tv101wum-nl6: Stop tracking prepared
  drm/panel: boe-tv101wum-nl6: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: edp: Stop tracking prepared/enabled
  drm/panel: edp: Add a comment about unprepare+disable at
    shutdown/remove
  drm/panel: innolux-p079zca: Stop tracking prepared/enabled
  drm/panel: innolux-p079zca: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: khadas-ts050: Stop tracking prepared/enabled
  drm/panel: khadas-ts050: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: kingdisplay-kd097d04: Stop tracking prepared/enabled
  drm/panel: kingdisplay-kd097d04: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: ltk050h3146w: Stop tracking prepared
  drm/panel: ltk050h3146w: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: ltk500hd1829: Stop tracking prepared
  drm/panel: ltk500hd1829: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: novatek-nt36672a: Stop tracking prepared
  drm/panel: novatek-nt36672a: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: olimex-lcd-olinuxino: Stop tracking prepared/enabled
  drm/panel: olimex-lcd-olinuxino: Don't call unprepare+disable at
    remove
  drm/panel: osd-osd101t2587-53ts: Stop tracking prepared/enabled
  drm/panel: osd-osd101t2587-53ts: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: samsung-atna33xc20: Stop tracking prepared/enabled
  drm/panel: samsung-atna33xc20: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: simple: Stop tracking prepared/enabled
  drm/panel: simple: Add a comment about unprepare+disable at
    shutdown/remove
  drm/panel: tdo-tl070wsh30: Stop tracking prepared
  drm/panel: tdo-tl070wsh30: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: xinpeng-xpp055c272: Stop tracking prepared
  drm/panel: xinpeng-xpp055c272: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: jdi-lt070me05000: Stop tracking prepared/enabled
  drm/panel: jdi-lt070me05000: Don't call disable at shutdown/remove
  drm/panel: panasonic-vvx10f034n00: Stop tracking prepared/enabled
  drm/panel: panasonic-vvx10f034n00: Don't call disable at
    shutdown/remove
  drm/panel: seiko-43wvf1g: Stop tracking prepared/enabled
  drm/panel: seiko-43wvf1g: Don't call disable at shutdown/remove
  drm/panel: sharp-lq101r1sx01: Stop tracking prepared/enabled
  drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove
  drm/panel: sharp-ls043t1le01: Stop tracking prepared
  drm/panel: sharp-ls043t1le01: Don't call disable at shutdown/remove
  drm/panel: sitronix-st7703: Stop tracking prepared
  drm/panel: sitronix-st7703: Don't call disable at shutdown/remove
  drm/panel: raydium-rm67191: Stop tracking enabled
  drm/panel: raydium-rm67191: Don't call unprepare+disable at shutdown
  drm/panel: sony-acx565akm: Don't double-check enabled state in disable
  drm/panel: sony-acx565akm: Don't call disable at remove
  drm/panel: Update TODO list item for cleaning up prepared/enabled
    tracking

 Documentation/gpu/todo.rst                    | 47 +++++++-------
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  | 40 ------------
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 23 -------
 drivers/gpu/drm/panel/panel-edp.c             | 60 +++++++-----------
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 55 ----------------
 .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 35 -----------
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 39 ------------
 .../drm/panel/panel-kingdisplay-kd097d04.c    | 48 --------------
 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 28 ---------
 .../drm/panel/panel-leadtek-ltk500hd1829.c    | 28 ---------
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 29 ---------
 .../drm/panel/panel-olimex-lcd-olinuxino.c    | 44 -------------
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 41 +-----------
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 47 +-------------
 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 26 --------
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 10 ---
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 36 -----------
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   | 49 ---------------
 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   | 63 +------------------
 .../gpu/drm/panel/panel-sharp-ls043t1le01.c   | 24 -------
 drivers/gpu/drm/panel/panel-simple.c          | 60 +++++++-----------
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 35 +++--------
 drivers/gpu/drm/panel/panel-sony-acx565akm.c  |  6 --
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 23 -------
 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 28 ---------
 25 files changed, 83 insertions(+), 841 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


