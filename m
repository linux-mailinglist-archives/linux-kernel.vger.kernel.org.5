Return-Path: <linux-kernel+bounces-129398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3D896A20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0753A1C22017
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739673183;
	Wed,  3 Apr 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jugfpVLI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350770CB4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135486; cv=none; b=tc3MWqcgiBTq0p2LufWkwr+R022RU9nZ05FQaqcPpjAubdWDGrj2Va6Ffassf2hqS1/8TMjAWsqi7Fs8DC0/uHDBvVM+F+gGGsmng/6JmbBcc1M6/v9njb2Hq2aBF47vrBpebeswaYvFCOUd19S6IvlTeRdsPiqx1CiuyHs6HAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135486; c=relaxed/simple;
	bh=fe4UITYmaUib3AO2xJ32pxkfxq57Nt/QUsCaA65IoaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txrMlHrvb0zy66iNZlhDd+nH3l/7sJs8Ul2mKIjwQmGlCkkh5qdP1l2FUKuE6p0gL0C4NvqCKo9AY68EY94bN+EES1ZP+DLrBYL+9DL8htx71NwbbeHvRoqhiEJQ7bCm1pZ0mQJ5D68IYnm/AcqSUpEALsvlQORdz34QZDSNyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jugfpVLI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4625098a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712135483; x=1712740283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpjQAPGX7DRYeObxhpkzDQOHk6DN4GVEcESJCG1mUPs=;
        b=jugfpVLIJ3UMAjieRXzFBXD6dhvelR3wCISNlluiWcKwuRBV53mLHgitwiUer4mGET
         CtO4GmsmEXfHYPlYjYlI4Nz3R43coL/8s7pn9O+Zx+g+KhmjjPJC1ReLuR0qvWcYzZZs
         V3DYVucGnV0/a9PqYSNkU+XwNtu89mmvqtMOKt3BWV+SCvi9hJDPYnJsJtzi0idRv5Ma
         0fZ/RWHBqQ8mCVOvMwIWtLAb/S6YIKh5Op9jwMci5/2qpjBC5Voga1LvGjDNujkSBILx
         szFRRtBbaG2ewU7swQ9rURBlM608yRBmbsiJSIxfLYkxGZB39Qjys1SsOgnPQu5HEY+i
         ALtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712135483; x=1712740283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpjQAPGX7DRYeObxhpkzDQOHk6DN4GVEcESJCG1mUPs=;
        b=SEcOibKZGKT8hb+GJ++uuePuhwjdFIeZkL2ZwI6JlyPDLj84HwEUiOlfSG6p3xA7fP
         YKgdV+gCRZc4P4q1Ra/+NjyNUvIXF4jRVNHkkiRL7+7pRbfIkaNzhd9Hsn5qeswOJ0Rj
         XFgTBHI0YgksDWmJp6L7MRgKyN3wq2UJRzC6PnnI4/Wclf/W+su/ezGlcbkkpkj9O/6T
         r4mciGAdTZCNzdRiVUBhtJvt8Gc6t8pjz+3IBHnu74d3GPsDgS7PXn52WkIoddHQw36C
         8WfcIETVqt2/6PpBj70BHvd/LXfpHIyY1jvO38M1QYUBEi1lTVzHGLBRRn1ChbGi1Kca
         IDxA==
X-Forwarded-Encrypted: i=1; AJvYcCVaAtxE6Hhm5ReOT3OcaYlfgIEPnwQoD/2xfLvlBAUDEDrfyd8Alw6w2wLjcaT44QvXNDgSaQDa88dp4o30jMZyE+H3UMr8D5dh+B1c
X-Gm-Message-State: AOJu0YxAg95Uwyoml6pZSj8wVP805gMu9vlayV0yzhhzmSheoZGjMIRP
	CPp0RO9xgYZxHZBVZ3EH8Cdf7CA5M26T1EH6hIOlPMEkFgZEMN6U/Qqieb+nzPLlwhU8o/4SGOY
	keW6KaQ==
X-Google-Smtp-Source: AGHT+IHP8Wkk3WqZo2x4m5I0Y9pbkAk5VQE/2rUf71FZT7C/JxIaPYVwnEjbjC99Ufxm9f+YT9UumQ==
X-Received: by 2002:a05:6a21:7898:b0:1a1:6803:69a3 with SMTP id bf24-20020a056a21789800b001a1680369a3mr17535809pzc.0.1712135483394;
        Wed, 03 Apr 2024 02:11:23 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.66])
        by smtp.gmail.com with ESMTPSA id lo14-20020a170903434e00b001e0aded0ca7sm12688087plb.239.2024.04.03.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:11:22 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 03 Apr 2024 17:10:58 +0800
Subject: [PATCH v3 2/6] drm/msm/dsi: set video mode widebus enable bit when
 widebus is enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-msm-drm-dsc-dsi-video-upstream-v1-2-db5036443545@linaro.org>
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
In-Reply-To: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712135460; l=1740;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OZSNyzuYoscDY4/FYsSXzvtJ+R2/AlPvVZDPzdhQNoA=;
 b=JV2mcwgTSj/9QP/9nbeMkSLbKZiuDUzrcHQTKV/HDaoeIOw35XNohHWH854JH04Qap8uPz1qe
 a1wuJWYSr8AD07LuWLw9ySSkW0JSmM3hPE4pifrLGC76X4rSGz0MANz
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
driver is doing in video mode. Fix that by actually enabling widebus for
video mode.

Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
index 2a7d980e12c3..f0b3cdc020a1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
@@ -231,6 +231,7 @@ static inline uint32_t DSI_VID_CFG0_TRAFFIC_MODE(enum dsi_traffic_mode val)
 #define DSI_VID_CFG0_HSA_POWER_STOP				0x00010000
 #define DSI_VID_CFG0_HBP_POWER_STOP				0x00100000
 #define DSI_VID_CFG0_HFP_POWER_STOP				0x01000000
+#define DSI_VID_CFG0_DATABUS_WIDEN				0x02000000
 #define DSI_VID_CFG0_PULSE_MODE_HSA_HE				0x10000000
 
 #define REG_DSI_VID_CFG1					0x0000001c
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 9d86a6aca6f2..2a0422cad6de 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -754,6 +754,8 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
 		data |= DSI_VID_CFG0_TRAFFIC_MODE(dsi_get_traffic_mode(flags));
 		data |= DSI_VID_CFG0_DST_FORMAT(dsi_get_vid_fmt(mipi_fmt));
 		data |= DSI_VID_CFG0_VIRT_CHANNEL(msm_host->channel);
+		if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
+			data |= DSI_VID_CFG0_DATABUS_WIDEN;
 		dsi_write(msm_host, REG_DSI_VID_CFG0, data);
 
 		/* Do not swap RGB colors */

-- 
2.34.1


