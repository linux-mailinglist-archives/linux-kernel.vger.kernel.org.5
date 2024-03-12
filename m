Return-Path: <linux-kernel+bounces-100058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA718879147
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647F9282401
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F2E79B8E;
	Tue, 12 Mar 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj+Zw/g1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A479B6D;
	Tue, 12 Mar 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236595; cv=none; b=tIQdgDQ0+x7BfGUFIlLbtUElcF+z+9aQYfHQboXe9DLmFFsukl3Ybmv5n0DGpvbO+YxWf9vjFko4DFgBhb46reIBSYBWvSGrsjBZQlC5y7qoHwbq5462OaHAvzCn5PlBAwDv0PowYWQnmz4jfHbYXVdWderRlm3gXJ4A8mtgNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236595; c=relaxed/simple;
	bh=OFg+gCBlE1ZCLP+REg//gFqNi/VsWKx1JrATPBH90IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+PgEhAs2ZSD9d4Ngqy8Nb2iq0y7VnYHKFnNJo5a0GncJRBINzd+4s6IdxG50ghr2n365l7UeElWlJjHq8+weh9CjFBFdSU4vXPJ1pdUblYbi4vq4U4g2c8aQOAzbnY1hFtpRSNeSBYemeEmExheKql0+HREKRfYRUSAFHurgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj+Zw/g1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41330d48a29so6371385e9.3;
        Tue, 12 Mar 2024 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710236591; x=1710841391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoqfNTOher8F7aZMvhGDS1s31WUJBL1ec+Cnak2BGb8=;
        b=Zj+Zw/g13VRBlNf4IULwzDoREvsX3xSdzhH1CQqsdPE24JQvNSDpMjhQBEqHtFH1Rq
         UGaU3yLb/9cqZVL0bIwk5Nl6bVLmIDQbppNZLnuHuAnKEBrw3hNfoZRQp5GqryrA5tkz
         L8H4pN7cCwDrNnu7zKbpte+uxrVr7pBV69r0IziEH2varowtB7TD3FtVSbWyuIMzVBWJ
         sUXE/xv/gFJ9j+8UH4OlGunrH37GzEXD3XoKyvDdn8yqfdjh0SGWD0Ke7TZL0F+QfZts
         npk0sjmmke+MYuAu5WBcgEZlrK6ClgPdXXqnoFCP0EZziMJgiDjVWAUywxGz92inOnh7
         gFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236591; x=1710841391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoqfNTOher8F7aZMvhGDS1s31WUJBL1ec+Cnak2BGb8=;
        b=pVFx/tKZXmot26WJCfQ7OY8zlzqq35KiApmmOGhwPOXEVJKi/J/6q6xYk+q37oBF3Y
         pceAr+w7GnyOqCUMzXiPwW0fTfaG9MuuqyjqDwkq3187IOFKuJEojv0YgVFvmSMIBvmY
         iPBtXWI2/6Aph/EjYDAbXlSlvOtEgxfACvj7UaxXZk7pN2bIadU2sSTwyPNoOYhSXR7L
         ck3fbTo+wpXTrwX0G0wLghhGOZ+97l4ry4SOSemTEEccSeTQHk4O9+TFIHAWQINjQyZg
         hgaKSrjKvph5J7FnUlxzglDV6wx1DqpMC5ST+qAU6BBvdh7SEFRNn+Jo+Ewc7+TCd3lO
         Adgw==
X-Forwarded-Encrypted: i=1; AJvYcCXyzM8uz5hb14+UnI0DeFs6n/fRXm/MknvRv2eWCalTkSZwk/P7KBVyKrGN3WYo+VY5CTz+Fz1rU28jumrgxQi135eYKQUkDJ+TaqCDWN/sMQY5IfFmvz5ZUq7vaIPCxPEB+hOk
X-Gm-Message-State: AOJu0YyMpTLeNueTL/4qwMuv+qlBBX/s9cNwbFeroHECNDq/bUFOSEJ9
	mF/yZ9JxusrrA+sXI1xloIB7VMAFF6OnbAfOzEz2+SB4lmBnc6Ye
X-Google-Smtp-Source: AGHT+IECjFuMZy1SfLMIE60ClZtCBQcRzU0eZOk1kmor4I0WnatKXFkXhxVgKRFmtao5WFP3qSOoew==
X-Received: by 2002:a05:600c:4ed4:b0:413:3b75:2b36 with SMTP id g20-20020a05600c4ed400b004133b752b36mr733113wmq.1.1710236591300;
        Tue, 12 Mar 2024 02:43:11 -0700 (PDT)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id o17-20020a05600c4fd100b00413320f795fsm2178049wmq.35.2024.03.12.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:43:10 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] i40e: Prevent setting MTU if greater than MFS
Date: Tue, 12 Mar 2024 10:42:58 +0100
Message-ID: <20240312094259.770554-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
setting the MFS to 0x600 = 1536.

At boot time the i40e driver complains about it with
the following message but continues.

	MFS for port 1 has been set below the default: 600

If the MTU size is increased, the driver accept it but large packets will not
be processed by the firmware generating tx_errors. The issue is pretty
silent for users. i.e doing TCP in such context will generates lots of
retransmissions until the proper window size (below 1500) will be used.

To fix this case, it would have been ideal to increase the MFS,
via i40e_aqc_opc_set_mac_config, incoming patch will take care of it.

At least, this commit prevents setting up an MTU greater than the current MFS.
It will avoid being in the position of having an MTU set to 9000 on the
netdev with a firmware refusing packets larger than 1536.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 89a3401d20ab..225b2fd0449e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2950,7 +2950,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	int frame_size;
+	int frame_size, mfs, max_mtu;
 
 	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
 	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
@@ -2959,6 +2959,14 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
+	mfs = pf->hw.phy.link_info.max_frame_size;
+	max_mtu = mfs - I40E_PACKET_HDR_PAD;
+	if (new_mtu > max_mtu) {
+		netdev_err(netdev, "Error changing mtu to %d, Max is %d. MFS is too small.\n",
+			   new_mtu, max_mtu);
+		return -EINVAL;
+	}
+
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
 	netdev->mtu = new_mtu;
-- 
2.44.0


