Return-Path: <linux-kernel+bounces-107633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F78A87FF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17AE1C22C23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05C81755;
	Tue, 19 Mar 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUsITW26"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906A3BBD4;
	Tue, 19 Mar 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857840; cv=none; b=kYcOu1Cprow5eY57HX2seseg6ou6CqsZB8AZWngCHI2PnhE32MSyLu0mDA1rRp3BW/ZSZicynhLDEZnNcHz4dKgbXatukd4fpgLMfWl/vPk7QbABnc8h8nemjTRY9DBxzGaHJrGZUu+lqxwZ5/dgo+ZUkHPAHR2NVFNTHwlU7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857840; c=relaxed/simple;
	bh=4+lNnFUPCcGtsGoH7RWDmJjjx6N6yWqfnnsWmvRs7cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dbo/qPuXAkp+0CKYaWjZnq4UfQnryswSPa/EweL/ONBZR1F6DZprAbEdfNGCTBX/nj2pAFF1hZkasbYimQlPTd8tf0h5lvwyIM50id54jHnvWv+S2jTyRTM/lOCEU2odKYzh2EsptqTRJ2k5xsCL3ncc7xwS+kNjbI8PsP1Ebhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUsITW26; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4146566659bso5232375e9.3;
        Tue, 19 Mar 2024 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710857837; x=1711462637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4EkBPaev4WA4b0+PhyugvZ3SM0zSNAP+U0AbsiXKCg=;
        b=GUsITW26Kv/mo3DkD+AkN7t+YFxQ3durS1ySQB0vC8xkleQjmT6ZlEP3VOUAD/O7mn
         VMkYIp1UfNHYJOTGFTTbHiCsnDihlr0LzGKGYLlH2AJ7ZUJaWrQCklXc6xaV2XjNBBtW
         5nxYL20wnEnn6U5ncYy66fqGVf1GZHX7XikuSMdkw+01vF3GiJR9ncvovLlA7jYVxf5T
         RfYbggXTK83Kb47sQzNAe3HNeoSoJSynftUHKCbLQCTDnVMp2gDdp5OUm1ACllLNpWkQ
         /fqbH8ofxNPL1Un12huRfXVhrWuN3vtEYcRXpozvmacP5eNYvnBRC2I9+OBAZl3nDcoz
         KgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710857837; x=1711462637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4EkBPaev4WA4b0+PhyugvZ3SM0zSNAP+U0AbsiXKCg=;
        b=IwqkRSLemsRW3mU3aN6drEiieWzKQlRZlk1YkCzsLQWNse5UsunRRyFww5uMRsXf4s
         +w1H1Lq8q3FoOOdEHVfxczVXrMu6K40FRlZ/hvdHzw8Z8eaGqqi6jB010zwCirl4Z1Fh
         DC7Uwt/xkdV5UwlA+RZE8vCVPI7BiD16K3rfeFtgJXLIn/fsQXI+7CpwYM5diVlqF93s
         hPIHHtfLGv8Y56BRSmKbfk6WdqwWxQOoUasbLVVR9OX4CPL597r6Cw+1op9GFVzIpaYc
         YDfxkM4RI/V5LpQ8ULHztIX8lMdD6AbDUMMaa/fW+ptun2RgbYz5BALEo7dOzNVYv0YC
         +cKw==
X-Forwarded-Encrypted: i=1; AJvYcCV/5oQkgmFK2ofTb3Xhmt2VDU4KIcD9+g4Yx0lGLs5CRmu2lFgYLmjNSuKB/JxTTqE/C84Y51fWPF0kp1R/dGeDJ84NunKLwMchN5jAwi8tTkeSy9XLZN2X2TrTgEN02JnvU8L+
X-Gm-Message-State: AOJu0YwyZ0p9sflyFmx1Rse3+JjXGNbze8zfE3b3adBYDiHdJTobM5q4
	rMQ/YJHdipkExicjmn42gc6JomLISREJqmyLi/JxXmCiFQ7tMX3E
X-Google-Smtp-Source: AGHT+IEK8XrtocceWWhBNn+d2cIikTbZWC/WQ87q2BgD41zOpII6MKkVrVIWowkSVZkfbLK83FmmYQ==
X-Received: by 2002:a05:600c:314a:b0:413:ef69:df65 with SMTP id h10-20020a05600c314a00b00413ef69df65mr2325547wmo.20.1710857837111;
        Tue, 19 Mar 2024 07:17:17 -0700 (PDT)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b00414041032casm520189wml.1.2024.03.19.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:17:16 -0700 (PDT)
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
Subject: [PATCH iwl-net] i40e: Report MFS in decimal base instead of hex
Date: Tue, 19 Mar 2024 15:16:55 +0100
Message-ID: <20240319141657.2783609-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the MFS is set below the default (0x2600), a warning message is
reported like the following :

	MFS for port 1 has been set below the default: 600

This message is a bit confusing as the number shown here (600) is in
fact an hexa number: 0x600 = 1536

Without any explicit "0x" prefix, this message is read like the MFS is
set to 600 bytes.

MFS, as per MTUs, are usually expressed in decimal base.

This commit reports both current and default MFS values in decimal
so it's less confusing for end-users.

A typical warning message looks like the following :

	MFS for port 1 (1536) has been set below the default (9728)

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 85ecf2f3de18..9a142562db38 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16106,8 +16106,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
 			rd32(&pf->hw, I40E_PRTGL_SAH));
 	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 pf->hw.port, val);
+		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
+			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
-- 
2.44.0


