Return-Path: <linux-kernel+bounces-41331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49283EEE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE931C21410
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2192C85D;
	Sat, 27 Jan 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkXaOlS0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB625742;
	Sat, 27 Jan 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706375077; cv=none; b=V7e98OXYfnAAjOH+m4xr6NHEGZmTEwQ///BNoNJkswXkRmWKv1K5BV7JmhpPvSsv+ak0ZJQ5BT8yKok8COloC7EaTIgBljtK7BDkjoVm/PTH2yYA5XJWZtia5WQZDWNP7Qyj7Rytd2fv83Ddk8JJTrHL7qeEKr5Qa8nzSH3Fw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706375077; c=relaxed/simple;
	bh=Gw/682eVO04GXnsD+K/iof8md1/7vaaXMRGyrjed/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESRGKvT4H021RTZoTSGGOuNVBpGm/oX1fmypOIyEGomOUrofcsHiQ7RCdcEDkQICW/MFG1B5tTSMotBrGLz4tQS7DXCQBUhL6gKy67fiuweM+TCfr8PAamTyZVmc8SNY3LzT6YT+UbHQuh7UlMg31cACr5DJ8lxUNs7f7sganI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkXaOlS0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso1148434b3a.1;
        Sat, 27 Jan 2024 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706375076; x=1706979876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r13Vjhpp1w8wUVvF7CjpGTyopMC4ZZNMQ+oZrZiXUO4=;
        b=LkXaOlS0j3/fYZPtb13aR/MFx3Qb3BHePz56kTYAmz+Hc35Vjv58488cnm1paVuqD6
         SL1MhT0/Kjfeoya+4npHfyApxFUu9YwzCkskJWU92O2lefudAgOmUzv5OmRtP+nQG3aW
         o/beP5U/mLufqFQPGFjG0dN1Vxu/b7kc4CLcJUvVrkHDxHk57+FWq64H0jn59+Ajhome
         8Kbi5rgQFJaDE7Onn9ve7hyHj0phrLshf5synKD1pf2O0FkbIysQXc6HNtcRwob3f9Jj
         Ic0cLN97ALnkls4ZMY/+cuqBrUbc+itpgxDyQ0az+NpIYvLJNuDharcFmgd++GD6m4Op
         +6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706375076; x=1706979876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r13Vjhpp1w8wUVvF7CjpGTyopMC4ZZNMQ+oZrZiXUO4=;
        b=LcXJ69VIZRrT5Od9DEJjK6RhOCGmG3aaVoN6PHZnHxZ6/OtfSBXA4/CEjMWi87mvav
         /bZUoGZrrPmMrO3UbjfRaa17hvrs8hf32Pr3uOZ1gd7OLNAAQFZreN0KTNTsnD5XVcUz
         tS/8dXcq7TP3f3V9QZQ/SRyrlPw9Y1xnTWIXMxGNQhNEtVNI6mqRkSJQiRHM+H2vxUyE
         EmC5NBN/rqmgk9eQ/Vq6WmT9NAO8xCfvYTKp+NUuNsOVlt6X+VsHuFr0n0kt2OF1px+/
         +xCpvfOpLY8yq9eF1f8hzbX6GixfaeI7l3Xu9b0cFNHCCwQiJ/zpyeVLsb8hy9YgtCKW
         zIJg==
X-Gm-Message-State: AOJu0YwgSUpVNJPybvQmfulKDB++/lJqfIZv23LBCVrT2iTZMn0hxy+U
	5tD2W2ZxhgaAdVznJiMfSltEs1HjRDnraH0VKcEYQmlp0GimRgFw
X-Google-Smtp-Source: AGHT+IE+5nHeNioxu7G8Kqsq/+WxVEz/RqtW33uaScGNhyPBfdpbDeCRCclIYUZEk8dRLEWDT+CBRA==
X-Received: by 2002:a05:6a20:a209:b0:19b:2303:88a4 with SMTP id u9-20020a056a20a20900b0019b230388a4mr1529034pzk.105.1706375075733;
        Sat, 27 Jan 2024 09:04:35 -0800 (PST)
Received: from gen-frame.. ([2607:fb90:8763:4b41:e82e:cfdd:7c39:5874])
        by smtp.gmail.com with ESMTPSA id h2-20020aa79f42000000b006ddc2a97806sm2994160pfr.213.2024.01.27.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:04:35 -0800 (PST)
From: Gen Xu <genxu6@gmail.com>
To: lorenzo@kernel.org,
	shayne.chen@mediatek.com
Cc: nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Gen Xu <genxu6@gmail.com>
Subject: [PATCH] wifi: mt76: fix ethtool stat for EHT rate stats
Date: Sat, 27 Jan 2024 09:04:30 -0800
Message-ID: <20240127170430.68427-1-genxu6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch add the missing ethtool stat for EHT rate stats.

The commit 731425f3a940d01be0cab0a5e45382988146aed8 introduced the EHT
rate defined in struct mt76_sta_stats, but missed to add stats string to
mt792x_gstrings_stats, as mt76_ethtool_worker walk through, it prints
out error like this:

[98179.287352] mt7921e 0003:01:00.0: ei: 74  SSTATS_LEN: 73

Signed-off-by: Gen Xu <genxu6@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 502be22dbe36..fb35eff6dc7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -354,6 +354,7 @@ static const char mt792x_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_bw_40",
 	"v_tx_bw_80",
 	"v_tx_bw_160",
+	"v_tx_bw_320",
 	"v_tx_mcs_0",
 	"v_tx_mcs_1",
 	"v_tx_mcs_2",
-- 
2.43.0


