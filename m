Return-Path: <linux-kernel+bounces-58259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6627484E399
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A761C22FF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF1D7B3E7;
	Thu,  8 Feb 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWe47Jbk"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31076025
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404474; cv=none; b=gY02h8GPgy0+pFnV14oUA/Xy/uv5lhTqTJxcg0nBvN7dbp7eqWzsp889JbTMoR0XaNn8xZeDtoop949HIxi16CLdBtUteb1VxLljJ1knSquK/ph2Pbot5Uivqm8b4wo64uvhUhvCjUnQRCLphFVhtsWdxAALQM9pLVBv2ddHSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404474; c=relaxed/simple;
	bh=MCk8TcMF3O/ehJXQorsy1MIsvwzkk22sxP1KJNAZZKI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWD+HVSgJmTe9DZLFWrqXINu8ceL0X7cfNS6qkT08HXL73ySSxtpvREtIKdNe8bAZb2smMjXnNUin8bIR6UIwkOJhNEwI4EtKJtR4A8LbreMDlVlwORwbjiYMDE0PY1rIIpBFDKnPG55Vmv65vRMaJhTEJYxr69Ki0TCFTaTiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iWe47Jbk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511612e0c57so3251206e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707404470; x=1708009270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTtnfYDI+dbV96lodd3k1eOzoNAGIDmd9/t7DM5xr5U=;
        b=iWe47Jbk7FykTU6AJfSgMJVZRT8CHmKUi4msaHhm1LIxRqmhpQ+Ds/3muIC1hH6/qY
         yoJd3H6K2p8dHIISSB6Xt/0XUGOdYg/6O6l8EJoM/qVVQ9zM7CqrzNB/cMXDUh/FvDF4
         C6UDw4YdXrSZnYdO8BuIJnLNTgnmLfZAVUYiLOU9HhxnjzP98N5VVnrbG/ECbBOtL9Qq
         YnQY0kvG4guNQV959xGphMJjx33tIyVL9IzvhGnakl08WNWoPp/bCYRNES8PldMfS095
         XhFUW16Y5G4pc3i9h1J3ncw/J3VITmofb6vuhjFObFPcyaZfDU2Ouoftm+i+v2NypDme
         xQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404470; x=1708009270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTtnfYDI+dbV96lodd3k1eOzoNAGIDmd9/t7DM5xr5U=;
        b=cwgJMRZ89ZkgXBd7B6jRGJ2dhhdMiwXzA8XisP+f+JEG2Xqz5+2beKL5g5cuXLsIgS
         pfw/YJgP8fCxpgnvxNaxn0s5TvAEXkoHyKNFYeZwRDepuwG60sAe0M52Fc4y/VAG43Da
         QK8xETym5kcZqw/quEact3S9FZx5HohXCMJo6uLO+sEQCMDFNzrUu3aL/xDXVtKn5w3o
         VmFNcGAJ64eQwZ5VV0k7cpDvtBciEPAIEM6As+FleBZExdJMZ3Adp2LxchsJiTnUo2Y2
         3U9d7jrmpAjPSu1ovUqRbQIEKoa/0wYOkdQ4eBEQvyOmGaMnZ4CEEyerWLTcdKA0XzSZ
         2/nQ==
X-Gm-Message-State: AOJu0Yy1sQDrONeu3PbM2mGhqzq9i+Az7hA2/jRfNQqVG9kyiUE0tU6l
	tkMiWsXVUQnpcjD4mZicEdDAi0NyBi8frtonZruDd5e1kPj+o4X+QTHzV+iFmq4=
X-Google-Smtp-Source: AGHT+IEWNqAPAd4/Tx7KBe0TnltU8DpVH4WsddMb++0Dnv69LUnzXOr7UVZvd5UM1ziBkOQpw3KTjA==
X-Received: by 2002:a05:6512:ac5:b0:511:7202:3938 with SMTP id n5-20020a0565120ac500b0051172023938mr965672lfu.63.1707404470455;
        Thu, 08 Feb 2024 07:01:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1+I3+J6AmT9zFJbIKgFnxWT7arsbxY6VugE9g2+q2I3pwlzpC9lBrAqspia5D3K8hWCw2sEb+PJZXTiZhRREga9cAV1p2S+V8sQcfuQ5VwWOIYRPBzzrMnbJBeiO9ySl1MC4X5hsJD3RfrlddGTszd2qPTezP+SgAv5MHoHKRYfyg4Lluh/HLR5o2E2zYuT5pkmYYhrkBbY0r448IDrc+t6O6uCmV5XgSNgP9vz+jFEoOesTyVkG0vjj9XkAsC5arfj6OQJr0E8P895tKRjZb526XeN31K52/VVWNHL/U5TxQvgeQZ22EO0IKzlxNViHcKriA377fCbaqtLzwezl0Gu7Wvhs3ObX3BUyc9qR9R6GSk/FYnCrQdqjVzhDVXeT4F+nVA1oblVxFIqIXIojalvSZxVE60nPKo5rHqzr5Md0HRADAlAmB
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x18-20020a19f612000000b00511498107b8sm22444lfe.65.2024.02.08.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:01:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 0/4] drm/msm: provide migration path from MDP5 to DPU
 driver
Date: Thu, 08 Feb 2024 17:01:07 +0200
Message-Id: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPsxGUC/2XOQQqDMBCF4auUrDsyyagpXfUepYtoog6tRiYil
 eLdq4VCoct/8T7eS6UgHJI6H15KwsyJ47BFfjyounNDG4D91sqgyVFjAY2HnltxU4DejwWUzjh
 X6Ko+UaW21Sih4edHvN62biT2MHUS3NchjVhqImswM7nV1iJo8D1PsmSVkyV19zhfHjw4iVmUd
 mc7TlOU5fNzph3/Xir/Ls0ECOSNLZDsCUv6tW7rur4BtEcZYvYAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Boyd <swboyd@chromium.org>, Carl Vanderlip <quic_carlv@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4293;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MCk8TcMF3O/ehJXQorsy1MIsvwzkk22sxP1KJNAZZKI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlxOy1+2nbSjt69H/MX4GkzpIAjy60yI4a6iXp5
 OrfFQxwtxuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZcTstQAKCRCLPIo+Aiko
 1T58B/9IdoASMAnnqawZzGDLlvyAZBvq4F6oyugJYZXZBb9NNZeXQtjonO30DWh5NvxpWBGIp95
 i05S8aUG46Q7cmlyii1LBCia8bl2nxRGtQYen0PkKgsggl9nA3q442+p/cNji9v7PQvAVsQ2J02
 /NxK81NNp6K3//yeXjLhO3IfZZedlA8RgDiuCNvcAxcFG7TP29HTnVC6PZ1s58Tl1tiZ+NKr2XT
 SSR7lN+/VjXYh3TqKG5e750iANaH3UyHfzj6C2njVAFd6VaENTvPNNUW8/rIDiFeu17w5OnfKfz
 eWHkMJxFMns7Olmw8P+a0h2jUpioBKWHKPtViFRhTSwMKtkI
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Over the last several years the DPU driver has been actively developed,
while the MDP5 is mostly in the maintenance mode. This results in some
features being available only in the DPU driver. For example, bandwidth
scaling, writeback support, properly supported bonded DSI aka dual DSI
support, DSC (display stream compression).

All the pre-SDM845 platforms were originally supported by the MDP5
driver only. However it is possible and easy to support some of the
older SoCs in the DPU driver. For example in the v5.18 it got
support for MSM8998.  This can not be considered as a proper migration,
since there msm8998.dtsi didn't describe the display hardware
beforehand. Instead new bindings were added, making MSM8998 just another
display hardware to be supported by the DPU driver.

This series provides a way to gradually migrate support for several
existing and well-supported SoCs from the MDP5 to the DPU driver without
changing the DT. From the user experience point of view this is
facilitated by the `msm.prefer_mdp5' kernel param. If the parameter is
set to `true' (current default), all `shared' platforms will be handled
by the MDP5 driver. If the switch is flipped to `false' (or if the MDP5
driver is disabled), these platforms will be handled by the DPU driver.
Handling this by the modparam (rather than solely by kernel config)
allows one to easly switch between the drivers, simplifying testing.

This series implements support for two DPU 3.n platforms, SDM660 and
SDM630. The MSM8996 support was a part of the previous iterations of
this patchset, but it was removed in v3. It requires additional
development and testing.

In theory after additional testing we can drop most of migration code
and some parts of MDP5 driver. The proposed boundary is to move all
platforms supporting cursor planes to the DPU driver, while limiting
MDP5 to support only the older platforms which implement cursor as a
part of the LM hardware block (MSM8974, APQ8084, MSM8x26, MSM8x16 and
MSM8x39).

---
Changes in v4:
- Fixed param name for the msm_disp_drv_should_bind() stub (Carl
  Vanderlip)
- Fixed the SoC name for MDP5 version 0x1010 (1.0.16), it is MSM8953
  (Abhinav)
- Rewored commit message for the msm_mdss change to mention possible
  crash on the unclocked HW_REV read (Abhinav)
- Fixed dpu_kms_mmap_mdp5() to call dev_is_platform() on the parent of
  the DPU device (Abhinav)
- Link to v3: https://lore.kernel.org/r/20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org

Changes in v3:
- Rebased on top of linux-next
- After additional consideration dropped MSM8996 patch. It will be
  reiterated later, once the generic migration framework is accepted
  (and after we implement scalers support for that platform).

Changes in v2:
- Dropped accepted patches
- Rebased on top of updated [1]
- Added defines for MDSS hw revisions (Stephen)
- Changed msm_mdss_generate_mdp5_mdss_data() to return const struct
  pointer (Stephen)
- Fixed error handling in msm_ioremap_mdss() (Stephen)

[1] https://patchwork.freedesktop.org/series/119804/

---
Dmitry Baryshkov (4):
      drm/msm/mdss: generate MDSS data for MDP5 platforms
      drm/msm/dpu: support binding to the mdp5 devices
      drm/msm: add a kernel param to select between MDP5 and DPU drivers
      drm/msm/dpu: add support for SDM660 and SDM630 platforms

 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h | 291 +++++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h | 225 ++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 103 ++++++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   3 +
 drivers/gpu/drm/msm/msm_drv.c                      |  33 +++
 drivers/gpu/drm/msm/msm_drv.h                      |   4 +
 drivers/gpu/drm/msm/msm_io_utils.c                 |  13 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  51 ++++
 10 files changed, 706 insertions(+), 21 deletions(-)
---
base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
change-id: 20240105-fd-migrate-mdp5-6a2aa51bc83b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


