Return-Path: <linux-kernel+bounces-88752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D034086E61C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE271F21B07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2BF3B799;
	Fri,  1 Mar 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lyZvkbYa"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B479FD;
	Fri,  1 Mar 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311398; cv=none; b=AoeqGHBLpJkRk3tQ+hrlSCEmLcaogvnpB8HVvrhzcZM9Nkj8mBbDJOiZf5K0YNTXi+wd4KQ4HW9k4Jffdn+MxxbA72oc28xWCMXUvv+i7tKPOTZ5MgkT3rfpORmdrjoe5DthYK4N52oZMptTlY5DiuaMDqZy4mkCHNS8OLB+n9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311398; c=relaxed/simple;
	bh=7+yPGbyypKfVMjlezs3o4R5gwncoRyCHS/svquRSpl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/gYCb7ul0g6rwAFyx/4rvreVxFlHgUae09Kn7iuiAaxT4Wi7cqVPgKKhWI/xoEnODHz3J532aszkXAb5afW25jH3YvnuqBOaA0zneNbi1DcrUpAg97JPC8asEM8g29XkwFribtTAZrT4FUaVSZWAGFgJ9uWOkGQNk1W3b0Qe1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lyZvkbYa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EA47240009;
	Fri,  1 Mar 2024 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709311393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/Hp6QCsVR3lVDylsB1ijKVlNWSb0JM4K1x2f3hSJP4=;
	b=lyZvkbYab/ryfg7rK0v4vcwr71SvChQQkG7kVQN9+DsImWVuVuJXR4jm+LK/i3T7GmSM0K
	tfJIvzPgPoPQrglouEeTLrU3eTU38ITPMVQtZUUkwSeAIaCwNXNzdWI0X487pz3uHdpZS3
	o0CZKIQaGkJo1q7rMMV4VKZkKHlln6yr4P6A4ibwd3hxwdhDAxp1aYLpZqNUluSwGICMLt
	FyKC2SuHaQ22bgJXN1p5wuKnDuCVYCZ2ukfFT0pf9RGOT9Zo4xiTRQwbUGNHoVqPsZY8+c
	VSvBTx4n9z9sS6As4csz9iRHnCraOKBFn5KsYjIOpl5XIzUFDtXw7JXngQQUEQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v3 2/2] net: phylink: clean the pcs_get_state documentation
Date: Fri,  1 Mar 2024 17:43:08 +0100
Message-ID: <20240301164309.3643849-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
References: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

commit 4d72c3bb60dd ("net: phylink: strip out pre-March 2020 legacy code")
dropped the mac_pcs_get_state ops in phylink_mac_ops in favor of
dedicated PCS operation pcs_get_state. However, the documentation for
the pcs_get_state ops was incorrectly converted and now self-references.

Drop the extra comment.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes
V2: No changes

 include/linux/phylink.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 6ba411732a0d..9a57deefcb07 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -480,9 +480,6 @@ void pcs_disable(struct phylink_pcs *pcs);
  * negotiation completion state in @state->an_complete, and link up state
  * in @state->link. If possible, @state->lp_advertising should also be
  * populated.
- *
- * When present, this overrides pcs_get_state() in &struct
- * phylink_pcs_ops.
  */
 void pcs_get_state(struct phylink_pcs *pcs,
 		   struct phylink_link_state *state);
-- 
2.43.2


