Return-Path: <linux-kernel+bounces-84802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C916E86ABC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C5228149E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346D37162;
	Wed, 28 Feb 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WvgoDo1t"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD96364A0;
	Wed, 28 Feb 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114286; cv=none; b=TdivwdPNqdg+10ER5qDNEP3VWwU+9Gj0u8ShmYKwbdJ2KA8EFqzGxTr8UIuILCiEechzKdsHS41Jb9aSyAsRRUckI8+kqMszIW0dgqTW7OkqwC1wa8kUzSIqESyMZip6CL2kA+G7Uo+oY5aHeO2eqdb9lceVnUKHfjQnp3tEAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114286; c=relaxed/simple;
	bh=VLnw7CFtD6tkLMRTwnOleArMwXHH7DdQHAUw3/q5log=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5iqoZhiu0d83/Ji1rdyo19zii5jbstg6j3f3ejI8uwog5cd2n+BhGrcpNMqm5JBF/J4nptp31wr4sqGivSX6dSuzGHi//ZEJEvqkwO/exp9qLYR6wfwnccJviAWG7UFxJpcyi8VSGf5KSRTs4EmbFbautkioDHY/oWRB/sZg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WvgoDo1t; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 710CCFF809;
	Wed, 28 Feb 2024 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709114282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+3QsX0HHeSUD5lWMhESk/zPMXGbCqeoiUeL3QgQygQ=;
	b=WvgoDo1t4zzKfbfna022CiqaJ/MT7QH2lgX24nyvkTfQukuLwPkAWCrRWi0H97DvTv8nA5
	UJJy5h+Q3Zsq34fV4jh72TCEr/JHS/Nnxf0J47m3dXuLU2cxw+qnaE4kA2F7hInf0WHqKs
	NSzQxMQVhhifq8Uk1n7wr7rYbx+ZmFMtjwSEC0ZUeJzVyE61ezUetze8Ts8DVMRGD4oYxG
	L7SyY4WFL6pNYMjtDe1+255Q2468FU6Xx4mCNYBWshU5LFGBc5+g/zdqPhgcN/biu+F322
	uhI1PyhBNzZEOjqUYwZPf4tVPjhYF5yTfvT+oSI7EIpNc0z9YIDVvatczth+mg==
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
Subject: [PATCH net-next v2 2/2] net: phylink: clean the pcs_get_state documentation
Date: Wed, 28 Feb 2024 10:57:54 +0100
Message-ID: <20240228095755.1499577-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228095755.1499577-1-maxime.chevallier@bootlin.com>
References: <20240228095755.1499577-1-maxime.chevallier@bootlin.com>
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


