Return-Path: <linux-kernel+bounces-80408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE21866835
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644DA2818EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F024199B8;
	Mon, 26 Feb 2024 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3vuep3M"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70450171D1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914484; cv=none; b=s2fiXx6+QVsXiZ3qKknPxzZMPNMzxuP09oALI/QscBK40Gw1rrI2FAW0bsz2RZz16ntW0IIJHYbkQxDeWU36OC0d1FHQTxYYmrnLRn4R5wAnetwLqNNB8/wuEJpxQsZPi4+p3r6Y1y0pyDljkoZ/zeJSRWL4bbe3Xa3l0diXSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914484; c=relaxed/simple;
	bh=u8jCfED3AAIM0Dr6uUkSBL8XcOIWg1vYet7ORyo2cy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eFWNezDhTIok08Ayn0qWZRhjEJcgHHAKijMEdrLsAgv/jY2rLTj2CwFeSyo0lE9iv7F48Tmu1MDVMAGwCbN1S2uoiqsBh16LymWh5enD9IqqX2LDU9R7j6o3hrtxLNB5ceVtn7IiqEROaQtG3mk3jbo479mLfAcqH8xFQiIMBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3vuep3M; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27184197cso29923941fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708914480; x=1709519280; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okMwD+HI3Hm1J7uyI3T50cIUeGmA4G9Oagnd36eStaI=;
        b=x3vuep3MxtYTykD2gVl+64Yxz1qwiD9YxoszEr0y6848r9jpufD0VUZeSalbudqt5f
         nT9XbQGvZZFdIbD7xJp5ibjElI7eTEqt4JPEpgX2cTZzEukN4b+o9ZBUZzbsCyGS7RtI
         CyWQI9WDBTr54RkinqRB53cYCXY5DCboJ7FWSSstpuHq7arl4yVIp9A1Q4I3I7YWu0ND
         /g7ADVpxooInb592MUDBEnT7FOwRwJfHGwK+7sY5GFpVwNJAD/nZkJnDLokCQgus70gU
         2EfpOB5SNCDtTKltZUfbJijsKO1lQIElL6hXioi4h7y5rTLlUcdyvv/480uknskSbMjM
         cfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914480; x=1709519280;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okMwD+HI3Hm1J7uyI3T50cIUeGmA4G9Oagnd36eStaI=;
        b=BFDxse4NG6ZR7CeRJXKTut/gkpp0f5OvWkWzAFkFQ8EFNxEgnGilbsoWA++vFxmo+3
         WcOpw43UGuU1r3zVLw5/xypHBLJYjFK51u8WzbJFvEX+cJvCA3AIxsPDlkV7E9c28aDr
         3K6HSWpc3BvtqF7OyFzVwq7f1XMSpsVEJiJiKU5MuWNHdHg7VNl1QLYnC0RfuiOu8YE4
         TgXe3khAhBJnP5K5bUnEgGl3OObkMn1SX8UisEW3Jdl+uxm510JQ8GpuIJkkSolaa2Fj
         2ETKvd1lgExgupbu+0RgF8x5c4IB3BpX4iTfG/NdChAL1tcq8iDRFM9V41nEbfic83Mq
         YAKA==
X-Forwarded-Encrypted: i=1; AJvYcCW6mar6V97MRSMOoQaYoCDt32Ipy69ce3ny/8yYr3Nz5ne35N5zP8I2QPycezOgrXAALW88XRBCHtX2Gg284B/RmxsF3SPmIWykMzXg
X-Gm-Message-State: AOJu0YxV2qNNXzhyqAGziGyd292320hN0Q9AWlHB6iVVYGxcxoWlqLYs
	cj61gkGbY3nGqMcrI02sDgupZbROD6EVF/KKBuRHdnL5r4lMzvV0p5NZSHM0zoI=
X-Google-Smtp-Source: AGHT+IFGLuNRRkqyJ84YiBMteFx/W6fawxgt5SBqlorHTEGoOuvKsKcz8VAynwdAnzKsErvRBTJm4g==
X-Received: by 2002:a2e:8e90:0:b0:2d2:7813:6ca0 with SMTP id z16-20020a2e8e90000000b002d278136ca0mr2918485ljk.7.1708914480645;
        Sun, 25 Feb 2024 18:28:00 -0800 (PST)
Received: from umbar.lan (dzyjmhybhls-s--zn36gy-3.rev.dnainternet.fi. [2001:14ba:a00e:a300:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e8553000000b002d11ef66881sm713092ljj.91.2024.02.25.18.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:28:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 0/3] drm/msm/dpu: debug commit_done timeouts
Date: Mon, 26 Feb 2024 04:27:58 +0200
Message-Id: <20240226-fd-dpu-debug-timeout-v4-0-51eec83dde23@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC7322UC/4XNTQ6CMBCG4auQrh3TDlCKK+9hXEB/oIlS0gLRE
 O5uYaPGEJfvl8wzMwnaWx3IKZmJ15MN1nUxskNCZFt1jQarYhOkmFFGORgFqh9B6XpsYLB37cY
 BdMkKQ2spKE9JPO29NvaxsZdr7NaGwfnn9mVi6/oHnBgw4KosOAqR8Yydb7arvDs635BVnPCtI
 BU7CkalNCUtDKuVEsWPkn4omO8oKVDAHA3WyKSS8ktZluUFfP0DdkUBAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1646;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=u8jCfED3AAIM0Dr6uUkSBL8XcOIWg1vYet7ORyo2cy0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl2/cvswuEB9zryNmyO7i/5aXauDX8QwQLWQAka
 RMUD4mkizCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZdv3LwAKCRCLPIo+Aiko
 1TlDB/43tK/bein7ge2pajmcDIVMZuxTdeAV4isVizetYKrBenH9uItcj3p7VUY5u4Le4CJ3cpC
 4kqF5hevPGzVDS/4TjVU2RAkY2DUAmIi0OFReena7J5OipQJOlRSyA8oxkM3TeO/R4eDcQpr7Vd
 rE4g14bhQtAZLWhJj18qeNmjsVNArxwl4GnTI1AkA6c3zxc7w6n5rd4Cs4ct3ZyBxjimMuiRmz+
 xwyzV5zcU8TVItaS3wEY61WNdDAL4zc55MgwQJ9bXYOjyWhZvMuvrvYpy0Pi48UX04OeN5btAPq
 xPX1K46ZWpznAtBJFSSwBy6qtVd56Xc06jbR3FnFNdwycecb
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In order to debug commit_done timeouts ([1]) display the sticky bits of
the CTL_FLUSH register and capture the devcore dump when the first such
timeout occurs.

[1] https://gitlab.freedesktop.org/drm/msm/-/issues/33

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v4:
- Reworded documentation for new funcsions (Abhinav)
- Link to v3: https://lore.kernel.org/r/20240225-fd-dpu-debug-timeout-v3-0-252f2b21cdcc@linaro.org

Changes in v3:
- Capture the snapshot only on the first comit_done timeout (Abhinav)
- Link to v2: https://lore.kernel.org/r/20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org

Changes in v2:
- Added a call to msm_disp_snapshot_state() to trigger devcore dump
  (Abhinav)
- Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org

---
Dmitry Baryshkov (3):
      drm/msm/dpu: make "vblank timeout" more useful
      drm/msm/dpu: split dpu_encoder_wait_for_event into two functions
      drm/msm/dpu: capture snapshot on the first commit_done timeout

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 79 ++++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        | 22 +-----
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  2 +-
 drivers/gpu/drm/msm/msm_drv.h                      | 10 ---
 5 files changed, 65 insertions(+), 50 deletions(-)
---
base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
change-id: 20240106-fd-dpu-debug-timeout-e917f0bc8063

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


