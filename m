Return-Path: <linux-kernel+bounces-167511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA098BAA9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02291F21F26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6851514D0;
	Fri,  3 May 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wXTqLfwB"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD315099B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731527; cv=none; b=iSrLboSvlnXYYZ4iKQga2PZ/nuShZt5pdhTW66ryLE6qGmn1UfIMGua5gAYW75OvrDfkWwkv//VxVGuHW5fEdo5OTEecioN4iAAL9ws4HTUiVaUqv9S9o9UE2RpBkHp0q+FqWC5+LH1skPtHwnc75gt+RBnGz3Gw/XnsBCFOEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731527; c=relaxed/simple;
	bh=0eniuETZ3PFB1rH7cfwDufB76Ze1gz1mvseOjb5IECo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUGYdV5mX96z9fzU7J6FXyqvVNtkXvXy7FOF9J6digmKD3lZLxYUFLaVzs8zMAf70ogVC3DP+j3/G1ly6BBnABsSDaiz3zDWj05TgHuRMfkg9cJT4YCvgPdHCWJ0atOo2zo/6Ke8tlj/lbLWc9fB/z7/JAjk8e24hY3+L54n2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wXTqLfwB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F8DE411AB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714731523;
	bh=iB4OipaIfb/mZuInqSZh9H4ftbRwcDQwJzI2DOUWXIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=wXTqLfwBiP5yhXaY0KU8Ioj5I5QO6xGUjlHPJUlXGSSWM/rfq7i2bfOuocTffG8hA
	 B32JmEraUQw7g+eMFInjTyaa6+rrAGTQwL7zxFLYhr5CFtLHPzQ72Cbd3lsxvcscML
	 HAf3LMIkksD0nA21I6U338NUpblM/wqOX6xLyNkwDq9PqjlblbAUCu5+9ezyPBFEh+
	 8JiY9lwJai9JXxSgCiQC9Na7MNibUb84nBryQGgABbj9uJaHgyyw5EQ+gUbh0v5Pz+
	 Yy87zhwGIfPpaZlFHp/K0Up9e8BvmDBN1+dUm4xkXnq55sG+nZ+SECsVGmmzdtnty0
	 EeU+NnTl2VL9A==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e4b70e0dc9so93668475ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 03:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731522; x=1715336322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB4OipaIfb/mZuInqSZh9H4ftbRwcDQwJzI2DOUWXIY=;
        b=HH9x8u2fFT3p5srZ++a9WdUaqrvXnTWKR3eNg5gNggBin5azpvNnL3vmx1p5fT4NOw
         qLzehUdMJBvjeGVPP/tn/Qja1kn8LBDNOu3NUB/jXWG9aMk1Aw8vRxW1a3bIAW2k6kPx
         4FsCfXZuzg1KNIWvg4/BzvzoXDBCVIUrvTci2AUdrf7gS91XdI9+sp2wTRxx89ulVmeM
         Os9NLbgGSujPxfXpL89QImIJ+hLLidqtc/cJredSDxU3ZQpAvMGxE8Xh5PsDNZKSrkmH
         /NBQ1KElmgvVAMn5Jv3PVQ8gH8I5bXgDW9YOEwFCW5uTggSV8Nn7k9kVjXg+hRAJn7tx
         JN+w==
X-Forwarded-Encrypted: i=1; AJvYcCU49I+d4S9dOPA+MdEwNaNJIMZwQoSa3PEozIibraa8QNmYRctcZiQyiHTRJieKxbulyYkiz3oiOXuXO2q3BL9/fpsv5VKLDR9a+GOJ
X-Gm-Message-State: AOJu0Yx4/gIlkYMn4wn9ohTCmmTmYpC4T7rS9byoNe5d3xEPgHdSZ/DX
	bHw9DZR5xuRKcobhqmB9B5RGyl8DU9GsMLvdVX09WjujtHxlBp6gmhDATaDuzB+2S0AeR10l7WK
	vmUI7vSrfNtUzo+bySZAvn3mlr8wsk+Zj07HiaYUvaWEB9yvmIw5hksPcJ7DcuQ5yrxVNSCMecG
	5tlg==
X-Received: by 2002:a17:902:8649:b0:1ea:cb6f:ee5b with SMTP id y9-20020a170902864900b001eacb6fee5bmr1940321plt.38.1714731521949;
        Fri, 03 May 2024 03:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwyUBeTmPsbqBwABOewqSgA4nrdN7o3IfMvwH8oa6fPK+omPARISGklOcYEFTjimrNDuy6hA==
X-Received: by 2002:a17:902:8649:b0:1ea:cb6f:ee5b with SMTP id y9-20020a170902864900b001eacb6fee5bmr1940302plt.38.1714731521584;
        Fri, 03 May 2024 03:18:41 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (2001-b400-e23f-5745-953d-200f-4ef8-798c.emome-ip6.hinet.net. [2001:b400:e23f:5745:953d:200f:4ef8:798c])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e22e8a859asm2944031pln.108.2024.05.03.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:18:41 -0700 (PDT)
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
Subject: [PATCH v2 2/2] e1000e: fix link fluctuations problem
Date: Fri,  3 May 2024 18:18:36 +0800
Message-Id: <20240503101836.32755-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
Intel I219-LM reports link up -> link down -> link up after hot-plugging
the Ethernet cable.

The problem is because the unstable behavior of Link Status bit in
PHY Status Register of some e1000e NIC. When we re-plug the cable,
the e1000e_phy_has_link_generic() (called after the Link-Status-Changed
interrupt) has read this bit with 1->0->1 (1=link up, 0=link down)
and e1000e reports it to net device layer respectively.

This patch solves the problem by passing polling delays on
e1000e_phy_has_link_generic() so that it will not get the unstable
states of Link Status bit.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218642
Fixes: 7d3cabbcc86 ("e1000e: disable K1 at 1000Mbps for 82577/82578")
Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
---

In v2:
* Split the sleep codes part into PATCHSET [1/2]
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f9e94be36e97..68f5698a22b0 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1428,7 +1428,17 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	 * link.  If so, then we want to get the current speed/duplex
 	 * of the PHY.
 	 */
-	ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
+	/* We've seen that I219-LM sometimes has link fluctuations
+	 * (link up -> link down -> link up) after hot-plugging the cable.
+	 * The problem is caused by the instability of the Link Status bit
+	 * (BMSR_LSTATUS) in MII Status Register. The average time between
+	 * the first link up and link down is between 3~4 ms.
+	 * Increasing the iteration times and setting up the delay to
+	 * 100ms (which is safe) solves the problem.
+	 * This behavior hasn't been seen on other NICs and also not being
+	 * documented in datasheet/errata.
+	 */
+	ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT, 100000, &link);
 	if (ret_val)
 		goto out;
 
-- 
2.40.1


