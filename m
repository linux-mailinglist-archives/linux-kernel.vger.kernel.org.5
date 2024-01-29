Return-Path: <linux-kernel+bounces-42700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98C840545
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF25B20C91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF76167A;
	Mon, 29 Jan 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBw5Ltnu"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94561676
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532362; cv=none; b=GBYwTP2VmSQnHYd8pPS2LGyvjgWLYy12uw5fKXRRL5dm4LsC+c9qCMZSTe/V1d1qtfCIw/qAH8qc7nhYrsFlcQjRYXF4+IOvCFpRzcVDwN+j+F7W0em0UM59bDRhE6zmCHsHT4LQUaIhwzWCcTDmJ+4YgdoMr3poTVt5B4RbBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532362; c=relaxed/simple;
	bh=sFIQeKkY7UHjp1uiNui9XonPgkts0yso8KZNx1EnhXk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i2gop8RVldAB/ozSc0AwGL9ZfF44DOFOtvmnYxPwL+SbTnzbn2s4smKFMRl+FtRQXOpIKCLtTCJweGBiRxtteYo5HjabUJIH4Fz9yuTvZ2RYnHIklMFJ5wapvhwNCP8ucuju+TXEa7C8lWDwPU4Q5bIz5pBByHyzmK7Ha/UsoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lBw5Ltnu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so398441066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706532358; x=1707137158; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RasRu5xBq2HyJa6KoKp78VZG1Uix0kvtLYifA/B9WxQ=;
        b=lBw5LtnutiZuug6Wg4+lkb3xg9pdmzQ4WjIV3dPeC/8nhgamk+lssfhzb8A/sCD+Pw
         WCIE07orOGKWrdIyYbg7UVAns4/IWumje0OEzyxlaC/zpWSs8DM/ONfTxCDk+4qUyEuk
         KFkZyZuyhAfggU5h0qJdXGO7UNPvDPDnnsgizIjuS/+pao0YmvPb1sTRCRyMEI3cYG2U
         H4PNxbI1N5zGFUc8Jx2JvEPo6jh3DQJ1CDHfttJ5iFMGLbZUmhDGmPpztzQ6tBu/sGqb
         gAZ4mk2Tyc/e1iV4ljTzG4uy154ATqq/ZrU+iJLoL3fevmP82WgaJT8dJHR1RpR+R9ag
         0pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532358; x=1707137158;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RasRu5xBq2HyJa6KoKp78VZG1Uix0kvtLYifA/B9WxQ=;
        b=D+UfKPiAeKRfscR4RUkb5jxWB770nHXT+ONrCWKvrRfFGhDEdjrbadwaoCL00+UZgl
         Q6XJeYN7LIGSWpOZKMlxeiLRAlQXGROGIKg83ZU9RqmL4fU94vivz4vSn7kMz7AJ5rnH
         uAyEb10qxmmpx5I81YDklP2qsQX7xP1FM0hwEiRx2nRpZ7qRVr5IUFhWdV+jn2f92Bd8
         hcx7XMfL9u9gEcjOpOmNUExXBd6Vxq6KkOn0bR7QmAcpxaoeIXzGE4OUzj1NOgzIXxXn
         vrEHRud2bEGCA9Lk4v9Ch4E445QthXLyXZpaAx9S793BRipAV/ikUkoHEcvEVNqYGiLs
         D4TQ==
X-Gm-Message-State: AOJu0YwSp/xWoWQ8+Nwn4XJla2JG2GQNn5LAz0OojpKQtxl4vMV7wqe/
	RLNmeKV2RR3CIA1rSZLZans6DB3zzEUMH6ycwuLHb7mPSfdqUzULtBrkCKSecZU=
X-Google-Smtp-Source: AGHT+IHgbD9zDbMQDbh+OqRGdy/EWQ1P157x7YRrgpX27xLvRxSe11+cxgCtyHnsg48sIv+qd7s+Aw==
X-Received: by 2002:a17:906:c093:b0:a2f:d73d:e99c with SMTP id f19-20020a170906c09300b00a2fd73de99cmr4558927ejz.14.1706532358303;
        Mon, 29 Jan 2024 04:45:58 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm3041495ejw.35.2024.01.29.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:45:57 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v6 00/11] arm64: dts: qcom: Add more support to X1E80100
 base dtsi, CRD and QCP boards
Date: Mon, 29 Jan 2024 14:45:32 +0200
Message-Id: <20240129-x1e80100-dts-missing-nodes-v6-0-2c0e691cfa3b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2dt2UC/43O22rDMAwG4Fcpvp43SXHSZFd7j7ELH+TG0NnFD
 qGj5N3ndAc6CmG6+yX08V9E4Ry4iOfdRWSeQwkp1tA97IQddTywDK5mQUANEqA8I/eAANJNRb6
 HUkI8yJgcF6lh8MhuWEdUwOjC0mQd7bgSRj39Pn+dUprklGQZ+XhcH06ZfThf27y+1TyGMqX8c
 S0347r97oG01WNGCRLVntizJQP9yzFEndNjygexujPdWu2mRdVqdcfegnIA9s5q/m811bKKe4d
 9p52nO0v9WAqQmk1LVQv25Cz51mLb3FntrdVtWm21GmP22HlD2g9/rGVZPgGACVDjJgIAAA==
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3865; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=sFIQeKkY7UHjp1uiNui9XonPgkts0yso8KZNx1EnhXk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt53zsrqk0tVOt34BjHqp+Bji9CSHIxGAqKiaV
 uvx/a8NlEKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbed8wAKCRAbX0TJAJUV
 VoY6EACGmpFDlCjyfg35MOF2u0iUxR0VbF6rDkQdFNuca9nxwujnAGcdHUv7Pxzaowhedx0xb5d
 O7HUyVCObWvvp/bOxaC791rPpx4TQ4Pg6ovh5kUTkmLaf2oxLUBU/aQ7Ozmjq+CbVt3qIKCHl6L
 zBlrpNOUZnCKg3/kOFNn1dpEleop72HvLxlPqMHpB+qxeSYkmFEPAC03YKY054trWZC40PYuUk8
 NLOZnW9F3QrJJV0Nbv9a8YwEP4IzjHXA7UYnP0fAMg07eVswpezzPMdEPN3smWuEIjV+Rr0Z+/p
 jZc9ELPFs7N16TZqSZmsk6dY/0d7hvJMmOYQ0l2fZrF+f/a6F55pFIFVAHp9QtT+k5w9kOkV7pa
 JF1sFH6n1NwLhflgyVeHqoBYUJpG6Lhoim0sus2aKM1dzcfp7ig95mTWjgqQCoMLNujFWBUkXz5
 fD6IOV5zYzNXkHX0OSrqadP5Vx0maC/sGsv/mjYtHguW/e4W2G3Hr5rieOTN46Iovjtv6YznUFQ
 PU3rmg4CFhmkb6tpzXeMjvMlmRRFd4IqL4LxVVJHR8vFTGfea0hEwK3xOl0mjxf2vjYANRUySNb
 nkPl6JQGuGXBP3GPjDfaM9X/mPkKneFteTIIsS6nTboT9uhWCu7IGf9ll8Xr1YKszUoE+AjcT6e
 z5J8lbwpnSsrSDg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds every node necessary for both the CRD and QCP to boot
with PCIe, USB and embedded DisplayPort.

This patchset depends on the Disp CC and TCSR CC bindings:
https://lore.kernel.org/all/20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v6:
- reordered the interrupts for all USB1 SSx controllers to fix some
  bindings check
- added all msi interrupts for both pcie controllers
- fixed anoc and cnoc clocks for both pcie controllers
- added link down reset to pcie4
- dropped the fallback compatible for all displayport controllers as
  they are HW-wise incompatible
- Link to v5: https://lore.kernel.org/r/20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org

Changes in v5:
- Added Konrad's R-b tags to patches 1 through 4 and A-b tag to patch 11
- Changed the clock of the usb2 HS PHY to TCSR_USB2_2_CLKREF_EN, the USB1
  SSx HS PHY seem to be sharing the TCSR_USB2_1_CLKREF_EN
- Prefixed DISP_CC_MDSS_CORE_* gdscs with MDSS_* to be more in line with
  SM8[56]50 platforms.
- Added "cpu-cfg" icc path to the mdss node.
- Marked all USB1 SS[1-3] controllers as dma coherent.
- Re-worded the adding TCSR node commit message by just dropping the
  "halt" word as the halt registers are not part of this region. The
  TCSR offers more than just a clock controller and therefore called it
  generically "TCSR register space".
- Link to v4: https://lore.kernel.org/r/20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org

Changes in v4:
- After a discussion off-list, it was suggested by Bjorn to split in separate patches.
- Addressed all of Konrad's comments, except of the clock-names one for the mdss,
  which there is nothing to be done about as all non-v5 do clk_bulk_get_all.
- Added more support to QCP, to be more aligned with CRD (except touchscreen
  and keyboard)
- Added a patch to fix some LDOs supplies on QCP
- Link to v3: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v3-0-c4e8d186adf2@linaro.org

Changes in v3:
- Reword the commit messages
- Link to v2: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v2-0-5a6efc04d00c@linaro.org

Changes in v2:
- Reword both commits to make it more clear nodes that are being added
- Dropped comments from interrupt maps from pcie nodes
- Replace all 0x0 with 0 in all reg properties
- Moved on separate lines reg, reset and clock names
- Dropped the sram and cpucp nodes
- Dropped pmic glink node
- Reordered all new clock controller nodes based on address
- Dropped unnecessary indent from touchpad and keyboard TLMM nodes
- Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org

---
Abel Vesa (7):
      arm64: dts: qcom: x1e80100: Add TCSR node
      arm64: dts: qcom: x1e80100: Add USB nodes
      arm64: dts: qcom: x1e80100: Add PCIe nodes
      arm64: dts: qcom: x1e80100: Add display nodes
      arm64: dts: qcom: x1e80100-crd: Enable more support
      arm64: dts: qcom: x1e80100-qcp: Enable more support
      arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J

Sibi Sankar (4):
      arm64: dts: qcom: x1e80100: Add IPCC node
      arm64: dts: qcom: x1e80100: Add SMP2P nodes
      arm64: dts: qcom: x1e80100: Add QMP AOSS node
      arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  222 +++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts |  175 +++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1396 ++++++++++++++++++++++++++++-
 3 files changed, 1786 insertions(+), 7 deletions(-)
---
base-commit: b5d2c51e6f120c3f06fc8ed5216be7de805b94da
change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


