Return-Path: <linux-kernel+bounces-167510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B838BAA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9BB1C20DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CEF15099A;
	Fri,  3 May 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Y3Y95iir"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B415098C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731525; cv=none; b=gi86c/15WJtT6APfEyvBduGc7ZyMgc6Xkto6sbC5T3JwLF8fmcPh/984kBz7Ctgjz0nWkIuMRxATGo816wI840yhDS28XDbGNVNjft5IkuKibnkArKqLSz1HOnTS+3y25JWV8Xw2gW9trF/o5XNC5YYFn0zlWURH1CP5S10JE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731525; c=relaxed/simple;
	bh=DElX5LUe3OoaRwas6ikDj3cSBM05kNwuPrdkFmiH1nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TisPrSXbSw7cgapoSwPOGpC+mHaXoiL3VutTIIxeB4O0of/x4JMC4fbDKgKSZHgEsHakYf8t991ZnjHrzbcIj4MJkLrNylz25YzeXmjJ/CDLwQ1s3V/BgC7RAr655iueycnESy5iFuYASqTR2WKOB/vEkw1IEqySztocg0/F+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Y3Y95iir; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA74D3FE52
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714731513;
	bh=jjRe6xajUkbmK1YsugK7qDg3PV7FRVVruktd97oIQNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Y3Y95iird4mjhwwpd6dJCrSz1ynbt+14JG2SadbnpAcSxz8V5yIf0Nj9Zn6ZJIr9B
	 CJDpz8iiyqFXBFFPkEYhT8I9Of3ePNrnm3VgMvg4JHCsenv2TmaUoRxXDF+Rom1cpX
	 Xm1ltxis1GU9q95RWQM4lCHc0JKOGeVxnOAkjVcA582+P+AYMPJ6a2whYYGGfPSdIH
	 mC8lRS/uflp8pdKlzyQteDTu4+CY9ywdOeHKv32SFzaPNXOLYjqFBesz8C9NY5eV5r
	 LYZGWlg6I7rIWYzM9QGV1ksB9LPCGxsy4DxzMUwyAI2OAC6c1e4ElDyK8SZLYjInnX
	 5pXj/ioWONETw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so9191125a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 03:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731510; x=1715336310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjRe6xajUkbmK1YsugK7qDg3PV7FRVVruktd97oIQNA=;
        b=eaIzqNX5PK/5E4KDANOAG1c3d/Erc/4vVJIkXN2Nky4OlVlhfaxhMFV/8Az0IM9zjJ
         BkWTPPNIWrbpfHGy5PcK/Ysbt9afAKt4u/w4tbMJVexzVhHh4d88Zx0cUGGxw1fcytoT
         +1pXfutQ/3Nc6dw469fWshZ+uQsevP6g7TWSA0t/A0y8TbZKULTsOS5fw12fHSyD3DVt
         gPNYtx8qKFGT5ROybd5JDjOH30omUsd7+F4P9Arti5E2u17w1aCJhLW2gIenfSqAoMB5
         8QC1R3mNeQ5aGeZC41Dvc3t5iAcOY5PaG4NMoBJ6ZZb1vjMU/03gXkz9uYuohzQCa/2V
         j1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH4pfrinw55ddKhY67uIV7nCkONN0fex9i99SM54MlS02zPd9J2obmjMmdeBt5CBDOoFFvfkAzpv/kBVyWoJWwHGMuCslNkHW4LZ1s
X-Gm-Message-State: AOJu0YwonWkoM7gty24+XFLp2kq89PTH3sDACA0HCC8jdPfTdxE9HYWo
	LUJCOyR/eT4Zr2/jLailelt5HtncE0NaWtvVRtPDmzPgGVUAVD0bK1st1YFQIev4h0gO5QbZmLb
	TowVs0SHrSpH0+96J4DXOa5JZZJZjCs7cs3VxdkGg8/dwLDUKDPRqcb5Gi2EYQw1btKYvN3B43x
	/bOw==
X-Received: by 2002:a05:6a21:33a6:b0:1ac:4272:5f88 with SMTP id yy38-20020a056a2133a600b001ac42725f88mr2589341pzb.17.1714731510167;
        Fri, 03 May 2024 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJIBpRvU4F9VMM0s2VJG699R/KuRERA+E2lxptDmXVTDVYDFnjQPQXw+wlQEB0fPnDSPcQrA==
X-Received: by 2002:a05:6a21:33a6:b0:1ac:4272:5f88 with SMTP id yy38-20020a056a2133a600b001ac42725f88mr2589323pzb.17.1714731509849;
        Fri, 03 May 2024 03:18:29 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (2001-b400-e23f-5745-953d-200f-4ef8-798c.emome-ip6.hinet.net. [2001:b400:e23f:5745:953d:200f:4ef8:798c])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001ec379d8167sm2926259plb.115.2024.05.03.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:18:29 -0700 (PDT)
From: Ricky Wu <en-wei.wu@canonical.com>
To: jesse.brandeburg@intel.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com,
	en-wei.wu@canonical.com
Subject: [PATCH v2 1/2] e1000e: let the sleep codes run every time
Date: Fri,  3 May 2024 18:18:24 +0800
Message-Id: <20240503101824.32717-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, the sleep codes being moved forward only
ran if we met some conditions (e.g. BMSR_LSTATUS bit
not set in phy_status). Moving these sleep codes forward
makes the usec_interval take effect every time.

Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
---

In v2:
* Split the sleep codes into this patch

 drivers/net/ethernet/intel/e1000e/phy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 93544f1cc2a5..4a58d56679c9 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1777,6 +1777,11 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 
 	*success = false;
 	for (i = 0; i < iterations; i++) {
+		if (usec_interval >= 1000)
+			msleep(usec_interval / 1000);
+		else
+			udelay(usec_interval);
+
 		/* Some PHYs require the MII_BMSR register to be read
 		 * twice due to the link bit being sticky.  No harm doing
 		 * it across the board.
@@ -1799,10 +1804,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 			*success = true;
 			break;
 		}
-		if (usec_interval >= 1000)
-			msleep(usec_interval / 1000);
-		else
-			udelay(usec_interval);
 	}
 
 	return ret_val;
-- 
2.40.1


