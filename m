Return-Path: <linux-kernel+bounces-160789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1468B42E9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AA41F24190
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B913C46B;
	Fri, 26 Apr 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VwUU8pKA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D73BBED
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175947; cv=none; b=KXKVDRFSasvO/gCOsuPcfNKN2p8ilz/5lIQfyK0QEx0DE8vEZMWRjCj1sduPnMoGlo0zURVyTeZ7EutqmxfZv2NGXQTle8IMnwVM70R9R4Ue81QhYQ8XZBAe5WMFNDOLcQYJ+zMRR/eM1dLxnWepMvANVq40KnagHGbRx0M/Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175947; c=relaxed/simple;
	bh=TdQfEZxU4q7uK4gdI9tQ36ZH3K8hlPN5F138d8r2wnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kv6tnkacypxN2b3AHieyr64oWhAoItAKVOp/X+EM7Fl70N8ZcjgiGMe0fOHiokthwl9VdKh8D8xzrL6GEt+sZwjPghaY8etpGTryULcvjbgeT8MGdfq5OySxs1iesp8mQWoQA4zvbRlqxFhZGZQNYDaNUBDce4vvWV6HeCu1JbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VwUU8pKA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a614b0391dso2223230a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714175945; x=1714780745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc634Lsr5zy7OBNgM+b6Aa7FawMZtK0nOD2hPnKDBP4=;
        b=VwUU8pKAClQQao2eI2h+X86KNjFfH00OQLVnrZKbk77CmtwmyEPcLkFSWyDVlnkMjH
         VZeiP4mx7KcaUOufhcCH3RV7iMV2u27/p3bmMemBFkVw1ULftssP5lbREbeke5J/23ki
         Ng/VOb1NuxoDHquaz/n9MclmiP3ftbFZWA0WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175945; x=1714780745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc634Lsr5zy7OBNgM+b6Aa7FawMZtK0nOD2hPnKDBP4=;
        b=DYREunPzxNHwx4lHm7di0MXjHT7w7FTOH4DHnG8yynom9WW1fjtoJP+a3kkHYxODnS
         uOVKOSfsPq/E44B7B3w9B89N2/HbD8vfv6QHXihCrBZCGEeVmfX833SSANWlby9l8JjW
         J1wWljkF6XcwbzqJMYsM23y90rZWbnrpwkhKCMCls4J12UxNa3xH82/vmP1aK7kXvgJT
         +fLQLJMnVQHK/2tw5qQBmbvxeWg8cEJnMoPWfNs2GyU8yOrglCk/tmQYJOhJe23FX9mK
         u9iwS5chWEiTc400bZVjYgSPN9uIrXOJr4NpebckmfJ5yBiprnV5SqR3BGXD7kiQa7WF
         k0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEubaO9ejDE6W+AXsdOS3ruapg1D91o41viH189ET18lxUulBD1+ybN3YG3sLjjP3kB9AT3yXTXavnqSH/+mwLrk7V+NWiWDZ+NFmr
X-Gm-Message-State: AOJu0Yw0Hh6QbxTH1e0yN5hBHKH5nwkACoUcQsWqSpEYAMzNkjtCL6jF
	FRRaU7xUSZYaJJbfcKIUJwI6Iqu3W0pJq56bfolQifJ91YaQpZUrUIwmQ+mQJg==
X-Google-Smtp-Source: AGHT+IHzJzJN3xlTGk8hjnbAWYC94QGCUpvG6+ZlC09viFKBb+fw1JAGzZID/Y8klH2Ko2GN72HH0w==
X-Received: by 2002:a17:90a:de17:b0:2a2:5e65:f434 with SMTP id m23-20020a17090ade1700b002a25e65f434mr3926650pjv.16.1714175944753;
        Fri, 26 Apr 2024 16:59:04 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fca:3ae2:20e6:82bb])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090aab8400b002af41bd563esm5111939pjq.33.2024.04.26.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:59:04 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] drm/mipi-dsi: Reduce bloat and add funcs for cleaner init seqs
Date: Fri, 26 Apr 2024 16:58:33 -0700
Message-ID: <20240426235857.3870424-1-dianders@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consensus of many DRM folks is that we want to move away from DSI
drivers defining tables of init commands. Instead, we want to move to
init functions that can use common DRM functions. The issue thus far
has been that using the macros mipi_dsi_generic_write_seq() and
mipi_dsi_dcs_write_seq() bloats the driver using them.

While trying to solve bloat, we realized that the majority of the it
was easy to solve. This series solves the bloat for existing drivers
by moving the printout outside of the macro.

During discussion of my v1 patch to fix the bloat [1], we also decided
that we really want to change the way that drivers deal with init
sequences to make it clearer. In addition to being cleaner, a side
effect of moving drivers to the new style reduces bloat _even more_.

This series also contains a few minor fixes / cleanups that I found
along the way.

This series converts two drivers over to the new
mipi_dsi_dcs_write_seq_multi() function. I don't have any hardware
that uses the mipi_dsi_generic_write_seq() function to test with, so I
haven't converted anything over to use that. The conversions are
straightforward but I'd appreciate testing.

[1] https://lore.kernel.org/r/20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid

Changes in v2:
- drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
- drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
- Add some comments to the macros about printing and returning.
- Modify commit message now that this is part of a series.
- Change the way err value is handled in prep for next patch.
- Rebased upon patches to avoid theoretical int overflow.
- drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
- drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
- drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
- drm/panel: boe-tv101wum-nl6: Don't use a table for initting commands
- drm/panel: boe-tv101wum-nl6: Convert hex to lowercase

Douglas Anderson (8):
  drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
  drm/mipi-dsi: Fix theoretical int overflow in
    mipi_dsi_generic_write_seq()
  drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
  drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
  drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit
    prints
  drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
  drm/panel: boe-tv101wum-nl6: Don't use a table for initting commands
  drm/panel: boe-tv101wum-nl6: Convert hex to lowercase

 drivers/gpu/drm/drm_mipi_dsi.c                |  112 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 2712 +++++++++--------
 .../gpu/drm/panel/panel-novatek-nt36672e.c    |  524 ++--
 include/drm/drm_mipi_dsi.h                    |   96 +-
 4 files changed, 1818 insertions(+), 1626 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


