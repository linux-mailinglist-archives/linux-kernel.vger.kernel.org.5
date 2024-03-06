Return-Path: <linux-kernel+bounces-94526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5E874112
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2031F24DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F33142635;
	Wed,  6 Mar 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXYGx0l0"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7114262B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755438; cv=none; b=oldb66BRBouA2Ihrtoff1TTfx8zYkB9R/vKCFOYEOSO4Q94W4FTFE95aFMQqYG/jHeaMz3hnKovX6utKRWXMRcDeJf6Cs+vbpKFOlryoj98loSbBdAZQ1b3wpliRAsIFdJhaU3RqoOxsq0Az7XfTr38W6g7GV7WOd5FPTxgyjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755438; c=relaxed/simple;
	bh=/4j/Is0hFqVPH2MaESxjRVKA8hrIc/P7f329q9wmkII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jh/7Dz/BfYVLB49SokJE7SUm18aS1CPAEdC94RItDFnNbL+PFB30Lgd4+wGdBvN46/28LgMMgBN1fePhj1Fpaqzh4CzpBA7Tr1JkpHBY6sk479m7K+Rd5RYRoBaJpfcuNTWmMUKEenvpuyI/D7fwubOHEGH3QKN7tnC0u3PpXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TXYGx0l0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so97269b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755436; x=1710360236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN7e0pJZKOddfIvwqdPKggGVUrxfJ9WHuIjs3oUr49M=;
        b=TXYGx0l0JpFn2nobBAeI9mWx7kQtiIPgISzop3CtZMuLsb5LpbasGxBgBr9JhJaXIV
         QHapCemN+fZFNvPemSHOPezZAOmmzCVtMH3dn64vsP62I0N1F1vG84gY3kD3dCV2XXVk
         vQMz3DTW9p5WPrV90ArAZFQhkGWzdD/BZJO34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755436; x=1710360236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN7e0pJZKOddfIvwqdPKggGVUrxfJ9WHuIjs3oUr49M=;
        b=PVI124M6bNt9WfCd0/RJ/FdKFPf0YFZbOXeD5KRsrvw4NbTGUfi/7uKKrPXfm1icsg
         01IUMgg5DmovSeEExfolKQosEJaJqJGKfhuwQuv7Yccu9Yhpv5puuHVVf0NEfeEI0U8S
         ESGwjVz/Pjz29YT1nKo+6ujlycNOvwZ3vY80V1iE3iO/j7SshtTactbd1B2ZswXpIqKV
         11IzQr4TzlKtubmQ3dx1HaigWdwBe32zsfneKxF3kLE2YsZ+pdZEUCMwfo9XqjNR+qsu
         w9Mu3dSKa/fNRc1gJKN8kM/LZV7LlKAWuDfR3SFqDJWJtmkj1CnM+8VpgPwKX09GMoPv
         YNiw==
X-Forwarded-Encrypted: i=1; AJvYcCUMni+6KALWaaGrtK4lBT1Y6mhIIeJaG6Fkt2ZzOZ3ZadYV1UMlfiqF7HZQv96iPUUUSwCaaHxQf+pim2wKWsNm8RJRkkbdpcQTcvdq
X-Gm-Message-State: AOJu0YyMQoWXp5igFMXMVQNcrLnIlcHsgZBKBU4KbeVbcZ4W04iX2zNL
	Y/2ue8gzdL0pTntRat30MXlS4RDhuGebcKa+NCI8bEvlSBb/zJ+F0R/bCi/InAux28F7Z1mt3rU
	=
X-Google-Smtp-Source: AGHT+IFCRFRPzQaRQxQDBTisRpAscTzqe9et1jiEZnW6JMEM2ocO0K/Vg9EBcJ1GFCqJUu9p8wgQgg==
X-Received: by 2002:a05:6a21:81a6:b0:1a1:4d53:b931 with SMTP id pd38-20020a056a2181a600b001a14d53b931mr4525246pzb.43.1709755436238;
        Wed, 06 Mar 2024 12:03:56 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:03:55 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
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
Subject: [PATCH v5 0/6] Match panel with identity
Date: Wed,  6 Mar 2024 11:55:50 -0800
Message-ID: <20240306200353.1436198-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
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

Match the panel for identity (id and name). If not found, fallback to match
id.

v1: https://lore.kernel.org/lkml/20240223223958.3887423-1-hsinyi@chromium.org
v2: https://lore.kernel.org/lkml/20240228011133.1238439-1-hsinyi@chromium.org
v3: https://lore.kernel.org/lkml/20240304195214.14563-1-hsinyi@chromium.org
v4: https://lore.kernel.org/lkml/20240306004347.974304-1-hsinyi@chromium.org/

Hsin-Yi Wang (6):
  drm_edid: Add a function to get EDID base block
  drm/edid: Clean up drm_edid_get_panel_id()
  drm/edid: Add a function to match EDID with identity
  drm/edid: Match edid quirks with identity
  drm/panel-edp: Match edp_panels with panel identity
  drm/panel-edp: Fix AUO 0x405c panel naming and add a variant

 drivers/gpu/drm/drm_edid.c        | 144 +++++++++++++++++++++++-------
 drivers/gpu/drm/panel/panel-edp.c |  68 +++++++++-----
 include/drm/drm_edid.h            |  11 ++-
 3 files changed, 166 insertions(+), 57 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


