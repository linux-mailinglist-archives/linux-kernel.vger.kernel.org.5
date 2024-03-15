Return-Path: <linux-kernel+bounces-104945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2987D64F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BE1C22136
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD435823D;
	Fri, 15 Mar 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IHBg+r/o"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CC58100
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538670; cv=none; b=YJtxQ2bFDQ89dhL1FBMKCUFpbhAxao31GbCfXJyR13ftVM/HjUOx+EamT73fZC/gx1PbKDeaJd77HHhnoBJ2RQ/6Ck66ggWqk+769Jv2i5/KumKMl3xtPPe5FeKabooPgqqI5VcUHzUEU8xnGkrXdqkMvT5Q3qR24tvdwjQuRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538670; c=relaxed/simple;
	bh=j7l/Wm2Ft+e3LgNffRWN0vGzV11pIV6gqysmAZ2ebYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2lFKLARBNN6k0rpWr6ns1gxn5NnO9JjDsGmCYrbNba+CkatpOdqnW3Tjc59fVKX6jHj82loqWaY4JmDhgjK53ChIN6Pd5obhyY/52WTho178nfWEoWAwPxC4vaoPI9x5J4voP1XBs20wdomDiw2qp8/Ae5YB20C8r6Zsw8Tvz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IHBg+r/o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6ccd69ebcso1647077b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710538666; x=1711143466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz22lebM2rTHwhNkx5aAaX7EA6Wa3wOGuC1PNKA3MCs=;
        b=IHBg+r/oUGxaLys6qlwFNA47SFc2j/1FkFfzxcsEZHFgKJm2+EF7sIiTn98TzGKLrg
         wVMsqkDOPI70Z/bJrVM8zoEYhDnaL3GF1yd53jYxkjebDFwfk5fRcE/uagPTE1p+BRoB
         Bfee85uLs7tByJfW6UQG1/yCiGOW2LaZeQN48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538666; x=1711143466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz22lebM2rTHwhNkx5aAaX7EA6Wa3wOGuC1PNKA3MCs=;
        b=ocN0VAMPTVxfv0ZR0IH0ocCwL1dXvMoVSyy8lRoyx9cyhD1QU79rKp8meW+jWeP5C5
         jkJuEDbK3udtGcjk1WBxqjOsn3esgYTAsZM+4O4ZnaMdRuIBmMTls+5HcIk2E9Cuq00c
         4xaiCe7ls9ewG7FTUlFWIoTiVQ5FEuMSX97lPhO208OsgG/7EfGmuQ3dWP4vTo61BHqR
         uefQQVovQhVFvvfwgMQvPaQuZWOXj8uLPywnbC98fl4UoUbA9bZTeuUlYozqRIW6r1yI
         p+byX6euCAOcbzjHPDqnrIGEk0D35RkfApcJ3P0ZTatAqKn0+VIYpVgPZk6BDm7Gf9JQ
         6QoA==
X-Forwarded-Encrypted: i=1; AJvYcCXLAdoJzVi244hWwFcMjpahBNpMru++NfIMnRDR2YuJMvG57sRQ9agU5K3N8C9BPu69daW9BjeA/HQ+pur/PII65p5g/dlvl+WdnjEf
X-Gm-Message-State: AOJu0YyhoyoGQ2m1lRvb/2A2UHsaebGO3/hPPc0H/xnLsG35toJY+xkG
	cstSKup22hbJHHuNLHQV9gVCOjVxlR2IMjxCi+ojAYhn/W2sG/tpjcC075KoFQ==
X-Google-Smtp-Source: AGHT+IHQFsTaKAjTWRRsrq1ZbLWnGQEVyGRFX2DMyF+SJJVN6Bd0rkX5tleEQkFmHdo17KUR5G1ENw==
X-Received: by 2002:a05:6a00:845:b0:6e6:fb34:2568 with SMTP id q5-20020a056a00084500b006e6fb342568mr3035362pfk.0.1710538666024;
        Fri, 15 Mar 2024 14:37:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b23e:e8dc:3df4:aa2a])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7865a000000b006e6b5e65579sm3837142pfo.106.2024.03.15.14.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:37:44 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	Stephen Boyd <swboyd@chromium.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/msm/dp: Fix typo in static function (ststus => status)
Date: Fri, 15 Mar 2024 14:36:32 -0700
Message-ID: <20240315143621.v2.4.Ia5dd755f81d7cc9a4393c43f77b9be4ed2278ee3@changeid>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240315213717.1411017-1-dianders@chromium.org>
References: <20240315213717.1411017-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a no-op change to just fix a typo in the name of a static function.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Fix typo in static function (ststus => status)") new for v2.

 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b0f3e2ef5a6b..78e702f66ed2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -494,7 +494,7 @@ static void dp_display_handle_video_request(struct dp_display_private *dp)
 	}
 }
 
-static int dp_display_handle_port_ststus_changed(struct dp_display_private *dp)
+static int dp_display_handle_port_status_changed(struct dp_display_private *dp)
 {
 	int rc = 0;
 
@@ -551,7 +551,7 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 		drm_dbg_dp(dp->drm_dev, "hpd_state=%d sink_request=%d\n",
 					dp->hpd_state, sink_request);
 		if (sink_request & DS_PORT_STATUS_CHANGED)
-			rc = dp_display_handle_port_ststus_changed(dp);
+			rc = dp_display_handle_port_status_changed(dp);
 		else
 			rc = dp_display_handle_irq_hpd(dp);
 	}
-- 
2.44.0.291.gc1ea87d7ee-goog


