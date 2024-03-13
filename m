Return-Path: <linux-kernel+bounces-100955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F087A00E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3061C22506
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF133F7;
	Wed, 13 Mar 2024 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/gaq8L0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFA2F30
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710288839; cv=none; b=btf+cTqAwR0UKp3Gtb+4nWC7jiQrgahDqJ+tdexjCG7mE5OC+JnINemJiXhw+4UmDJCNGjxE9hha0248ETAJVu+nPafX0QFFYwhR0tuZ8Vcs03duVYN1KF6XkM1Znk7VQgZTY8Kmq7wfJQ7cbyYAAWcBGduCDi/lTY2857EJ0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710288839; c=relaxed/simple;
	bh=rwYPXCtiTeR6fKvXaEuMTY9ji0JXdvlkZcS1H9kz3t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcYm/wUUZJ9LknJMi5+b6w0vR+45rY7USX8iJ2Nn4TP1sSe2njQRCmzqY5iwbxF4JxCvXg2BEAHEh/MAYcj6J0iV6Wbg7yuHiQH8ekvhdE9Auv+wW9flg5SxRDCTbNSwAuoP567dgfg5FvTx1z+91bsOWWXEFCgwdu2qcS8hNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N/gaq8L0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc5d0162bcso36596805ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710288837; x=1710893637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roioUGnaxY6AvjIUwtL2u9LanxRAGecYCXou90dLIu4=;
        b=N/gaq8L0nEqVztaZuE8HD11lCC8W0BIiRjGFerOI77j/VsotfBRKTJEFc4EqsCcKnD
         T/xSs32IyZNipsKewQQAydMKtf8K/z3cqA0O2wj5MvOraI3DDwsYKwSAc3HDDbtMw/4y
         +zm/tDipykRSMzqOfuI2PikAuVSz3W/MckL7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710288837; x=1710893637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roioUGnaxY6AvjIUwtL2u9LanxRAGecYCXou90dLIu4=;
        b=egyHGxKZ/Jqo0VKRWfOdGeDw9at9BiIvx3W3sD0wWf9+SmwkpXH12I80f3PDmi4Smn
         Z+eCTT5Qjm1Ua1QSjFNGp+W3cR+ahLRyvqW+bKo+sKqhBdh8pg7BvGYFBpbuRFDrwZT2
         QfqflV+jJCuEXxBZIKtGN/lzgGDRX1lNvyGCgLg8iWBWnYXdF9BPGqXPvk8tdL9reLsN
         PROqvl/u+71uxJoAAsOQ71u/6CnaOZPMD+6GOQsB0uATtG8tw+S4wxHCu1l+R8fj2Qbs
         oK4Oc3Qt5AHOf1iLmMzIHV5ahThPqrD1PkAeHelsfbVBaIkSWHMUnHsy11ZVTlYAkXwj
         kQPw==
X-Forwarded-Encrypted: i=1; AJvYcCX5jo6L3uPX5/X7C2CVRqxpL3pxx2o8jYpXPBA5Rh9a/gX6fPw+TkT97NOXSGS+FG20KmFybYUyItJZOuoQc/0IuuUL0ykvldIM3c2H
X-Gm-Message-State: AOJu0YxkFcy8VRR9do1BBSQ78ns8c6EXOmQJ02Di5vSvxzkucBj9ZxLf
	ol/bPprErivtYooHbSHC5QZQl6eGlNEQiOjYLTd8p0Q289nNNlq3Om/9yKeMHA==
X-Google-Smtp-Source: AGHT+IG58PN3ouLt4+V6o22EJ3ezJVOTQSf28+tSjOkyWRU31OXa8iIFliZtabjLxDQCMZq9cqjRsA==
X-Received: by 2002:a17:902:c947:b0:1dd:8daf:99b2 with SMTP id i7-20020a170902c94700b001dd8daf99b2mr9535150pla.13.1710288837058;
        Tue, 12 Mar 2024 17:13:57 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f8dd:895c:e876:6edb])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001dd761faec3sm7432924pla.251.2024.03.12.17.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 17:13:56 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Guenter Roeck <groeck@chromium.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Tanmay Shah <tanmay@codeaurora.org>,
	Vinod Polimera <quic_vpolimer@quicinc.com>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/msm/dp: Improve DP AUX transfer vs. HPD interactions
Date: Tue, 12 Mar 2024 17:13:15 -0700
Message-ID: <20240313001345.2623074-1-dianders@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The main goal of this patch series is to avoid problems running
"fwupd" on Qualcomm devices. Right now several of the plugins used
with fwupd try talking over all DP AUX busses and this results in a
very long timeout on Qualcomm devices.

As part of fixing this, I noticed a case where the MSM DP code wasn't
respecing the timeout properly when asked to wait for HPD. I also
noticed that, now that we've implemented wait_hpd_asserted(), we no
longer need the long hardcoded timeout / special cse for eDP in the
AUX transfer function.

NOTE: I no longer have any hardware setup that uses this driver for
eDP so I've only tested the DP case. The eDP changes are
straightforward so hopefully there are no problems there.


Douglas Anderson (3):
  drm/msm/dp: Avoid a long timeout for AUX transfer if nothing connected
  drm/msm/dp: Account for the timeout in wait_hpd_asserted() callback
  drm/msm/dp: Delete the old 500 ms wait for eDP HPD in aux transfer

 drivers/gpu/drm/msm/dp/dp_aux.c     | 21 ++++++++-------------
 drivers/gpu/drm/msm/dp/dp_catalog.c | 17 ++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_catalog.h |  4 +++-
 3 files changed, 25 insertions(+), 17 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


