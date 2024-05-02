Return-Path: <linux-kernel+bounces-166186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE868B974E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F27B1C213E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D2A55C1A;
	Thu,  2 May 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j2KimVi8"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BF55C08
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641144; cv=none; b=lAxv7K+JFMRZ1odJ+9TfubUocdObM8BO4nIRxSd+/A8oLMHdlrtpkRDqCGMS1eo3BBoAbdyNSKINq/WB9Bp8h8RW8VcsMuBGwjFr/4t9drAP7ZHYHo5bnw5bFk/Vk6vr7nhtvfwN9JnrBluNAfYSvjZvdfDhHYpr2BsoTPX4SS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641144; c=relaxed/simple;
	bh=iCsG9zIwH2BrnZHdToN6vszkvwqpcmcTi8Z4M/RCado=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLlUrzAOWNV53euxotzbLJqbYsqf3q7lyy3R/Bcukun+MT+qubt4OvPKb4x3l+9Oq0oAemhR7ScXhBD52sDpBQkQcA2RT8wtJjbpvx91PPTMpP0nX/8/1n9Svxf4Tt1aNT76ZWyZ+nLLL/s6yD7qDTQdoMijNyAq/Z1au40O0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j2KimVi8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D5E0D3FE58
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714641138;
	bh=AgYbELQ6gtIAnsZhwql/Vj7FiSMAsbvYTgHu1HlyF0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=j2KimVi8S8taska1W+0x9oHYugfawfjhqGM+8nVC48X22wMqPfdXM2x40616Sluki
	 A9fZepNwMNC6SZCn1o6P08CCiCz5WeB/MGFxmEogBSRjuDy3Ad/r3gngCyT2rohnqW
	 7osEJqn7Y2c8mVkupznIyb31RDpmqterArtQdqN92PyLzkwcP0Kiyj6NY7+moZLclW
	 922ULOCHboSxcnHhMNvq2n4IiCk4rwgBTWna28Bs7dbcwYfdvkUvoK84eZ4zDe+pF5
	 aFOI0xqZCkXJwzYTyXHB5revwkMgGOvtSilrRinE7L9C4/Ooo2L4D6YAhou8qdS1s9
	 W8tcFdt0dEkRA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e278ebfea1so85618455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714641137; x=1715245937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgYbELQ6gtIAnsZhwql/Vj7FiSMAsbvYTgHu1HlyF0U=;
        b=OxA4cD/AI0tLDL6xkE7Q0RXvJ4TILCdqgeOGQFRbb7+vtXGuS5NSHiPpTJj76RhcYL
         ht9Vs2KHrIQKFuRGMe2bIiLkwNEi9JxLOsdbDeZJm8TBP0eeT2r9CpjPYnAIA2nvN1qY
         XvxSazhSAVCAcy3A//7WYclagnBaN51qtY1k3VJ2KlAaSCBTwZDdACyfBdGn4P8XQPXu
         kc5pDpkkltIXU0yXqhY2HqziBKXIvpG45/PmgFfz22JaRE+MppIk8tHZKcUYAhypF32/
         APv6gr8n0eZyETLYhT0vVtXuCbspXnjPEX1IC6wdE4n1ngHG+5X/q/WpLgPmw+dT+ITx
         qYqw==
X-Forwarded-Encrypted: i=1; AJvYcCVHIfbSlQajbVji7vw/GGhftuXm10xHWsLQMST1lRy+1zGQq4iJEcvvEmrqrGySS7H19GyygAVpW7Q/11hQuvpQqM005P9Z+e9SqIpk
X-Gm-Message-State: AOJu0YwMfqjGUIrXljb+s5MScTb3GX4MKgfNUDJwUK54IApb6vYIaQvB
	svj3qy4r1vsdiyjHUB+EQxVAaKkHq5osEBJx6EbWhi7sRR0/5+GOABxMW7LHJPWSr2PBJqj7TTv
	SDlO3nNBByAoCZxgMViqJLZQHITzAaAWqYGLOPqVfDSLSS7ngMpbHBIWlDQXfR5PeTKWHtc+/lm
	stZQ==
X-Received: by 2002:a17:903:2312:b0:1e3:dfdc:6972 with SMTP id d18-20020a170903231200b001e3dfdc6972mr6747429plh.9.1714641137313;
        Thu, 02 May 2024 02:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw1zAhwq5ZdDzzQKMd8+CBt/+8GW9Y3OXsgWotH06aOH7F9NJd6OIBnq5uXNr+zk5WDR2eEQ==
X-Received: by 2002:a17:903:2312:b0:1e3:dfdc:6972 with SMTP id d18-20020a170903231200b001e3dfdc6972mr6747417plh.9.1714641136990;
        Thu, 02 May 2024 02:12:16 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (2001-b400-e239-aa6a-7bb4-902b-1963-242d.emome-ip6.hinet.net. [2001:b400:e239:aa6a:7bb4:902b:1963:242d])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170902fa8700b001e3e081dea1sm804157plb.0.2024.05.02.02.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:12:16 -0700 (PDT)
From: Ricky Wu <en-wei.wu@canonical.com>
To: jesse.brandeburg@intel.co
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
Subject: [PATCH] e1000e: fix link fluctuations problem
Date: Thu,  2 May 2024 17:12:15 +0800
Message-Id: <20240502091215.13068-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
some e1000e NIC reports link up -> link down -> link up when hog-plugging
the Ethernet cable.

The problem is because the unstable behavior of Link Status bit in
PHY Status Register of some e1000e NIC. When we re-plug the cable,
the e1000e_phy_has_link_generic() (called after the Link-Status-Changed
interrupt) has read this bit with 1->0->1 (1=link up, 0=link down)
and e1000e reports it to net device layer respectively.

This patch solves the problem by passing polling delays on
e1000e_phy_has_link_generic() so that it will not get the unstable
states of Link Status bit.

Also, the sleep codes in e1000e_phy_has_link_generic() only take
effect when error occurs reading the MII register. Moving these codes
forward to the beginning of the loop so that the polling delays passed
into this function can take effect on any situation.

Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  5 ++++-
 drivers/net/ethernet/intel/e1000e/phy.c     | 10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f9e94be36e97..c462aa6e6dee 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1427,8 +1427,11 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
 	 * of the PHY.
+	 * Some PHYs have link fluctuations with the instability of
+	 * Link Status bit (BMSR_LSTATUS) in MII Status Register.
+	 * Increase the iteration times and delay solves the problem.
 	 */
-	ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
+	ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT, 100000, &link);
 	if (ret_val)
 		goto out;
 
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 93544f1cc2a5..ef056363d721 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1776,7 +1776,13 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 	u16 i, phy_status;
 
 	*success = false;
+
 	for (i = 0; i < iterations; i++) {
+		if (usec_interval >= 1000)
+			msleep(usec_interval / 1000);
+		else
+			udelay(usec_interval);
+
 		/* Some PHYs require the MII_BMSR register to be read
 		 * twice due to the link bit being sticky.  No harm doing
 		 * it across the board.
@@ -1799,10 +1805,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
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


