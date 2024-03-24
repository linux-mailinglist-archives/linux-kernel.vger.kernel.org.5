Return-Path: <linux-kernel+bounces-115236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE7888DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764F328E3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A802978E6;
	Mon, 25 Mar 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZOQM20e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467B185218;
	Sun, 24 Mar 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324333; cv=none; b=HsOLDxTCuv7XH3glb2spfR++6oKcHTAVT9vB9lFRScXJnapHQmWnahXKNIOuy+TM+INEsOPyMr3XmRqR0YGPYI1FfS33Lt+TvLNWDFvm6lJenYz1rXLm+Nm2s5sUICoynlZOhc0laxUUbPH+3HmB3NAQicuWqp/fhV/fg1GRB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324333; c=relaxed/simple;
	bh=YCkvSQzEv+R4kiRtPg/vr7zwuz9GHECujORNUOw4sgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R92IL3/L4I5cpsikleFc2/7xdfYF+66M1LX4xZLqIfPQqLR4gsPb1iZG6nYAXYUhdiV63mje4i8yD49I9MNkhgmxs9lKREyX08guhrI8dI944ARb0eLpZfKoqjPben0st9p+mlNZTmgd6ovFCTqzn3Ii5AkvhkhJxnyJai5WxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZOQM20e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF659C43390;
	Sun, 24 Mar 2024 23:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324332;
	bh=YCkvSQzEv+R4kiRtPg/vr7zwuz9GHECujORNUOw4sgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZOQM20eEqJBKzyb8zA97RTNGtp9wRElpJhebDelx5A5f4GzPsf9JvoOgqTm/4mCs
	 bngnZmlRkhNn8oohw7n/UZ840H6Z+7SCll8A4Cb6eFaIZpUgnMCD1D0/KuJXmXtq5o
	 UrBgYp2gyeOip8Jm27JyEDVO67UacHbc3u/XHk6b8eJtad/H/mfK+vlc0k8GVmvbEI
	 WEy28xl4CiiMQi57c/BAYURj0RFJTF+tnm0lz5c+Ga24xgbGwDYmv2M5Vd3X9Oz7JA
	 ohXDf5j18Gp/TECRp9ed+vfyYwen1HARt/E6Ue3GX854jO0CENv2bDZf7NJaNr39ZM
	 brWdMmxWh/lKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Govind Singh <govinds@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Niklas Cassel <niklas.cassel@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/148] firmware: qcom: scm: Add WLAN VMID for Qualcomm SCM interface
Date: Sun, 24 Mar 2024 19:49:27 -0400
Message-ID: <20240324235012.1356413-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Govind Singh <govinds@codeaurora.org>

[ Upstream commit cc53aabcc283c36274d3f3ce9adc4b40c21d4838 ]

Add WLAN related VMID's to support wlan driver to set up
the remote's permissions call via TrustZone.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Stable-dep-of: 117e7dc697c2 ("clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/qcom_scm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 116b81ac442ad..1637385bcc171 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010-2015, 2018, The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -33,6 +33,8 @@ struct qcom_scm_vmperm {
 
 #define QCOM_SCM_VMID_HLOS       0x3
 #define QCOM_SCM_VMID_MSS_MSA    0xF
+#define QCOM_SCM_VMID_WLAN       0x18
+#define QCOM_SCM_VMID_WLAN_CE    0x19
 #define QCOM_SCM_PERM_READ       0x4
 #define QCOM_SCM_PERM_WRITE      0x2
 #define QCOM_SCM_PERM_EXEC       0x1
-- 
2.43.0


