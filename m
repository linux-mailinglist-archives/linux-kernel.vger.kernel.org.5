Return-Path: <linux-kernel+bounces-136713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F289D771
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1776C1F21CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208D127B78;
	Tue,  9 Apr 2024 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j40dIMXa"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76E8529C;
	Tue,  9 Apr 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660338; cv=none; b=oIPTJUto+2VSymDTRy4zizLNpcfd5JHwdNq2cEnJGejP6bUEI2SnryuyNEdw/LSDV56Qo6rK3WsrjV24cEmx6JfhcbS1XZY+5g0lm7GOD+peKDh279FMJ7TbaaLoYwJVbzi6WySsn5YlDDXdESYeuKhbWcHM7d6KV6hXy4BMyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660338; c=relaxed/simple;
	bh=/ioZuY2opA9crgD3+O/NIdgBS5tBNlapFgt5HOS9l/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP/P3RpWWGXWqxhiuusk5L0sp0P+lXyqWG+3yxvuSJ3nvis7ZWqyCxEAV2ClQ0mc6cyi1iPLMXjEyPAycQKFeywDpvMMyhxIr3l/QhWz+4R/yvGNsaV+hCPivo+jyi80aj97GfVu4XvesNelEr2gotOesGMGfTwfr2jSHuCe8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j40dIMXa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22ACFC0003;
	Tue,  9 Apr 2024 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712660334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thJ8uvI2UgimyENihTVu33JjOwHGCEHl5NHGiXq0AbU=;
	b=j40dIMXaGwyapL2aYoUuRDx/UYqjbGCLyboxaey5CI570patOpSyU5/gmmo7TmyxXFnLec
	ngsZoB+FGw5Dnt4EOSNpBup6dEduNKkUNutXZDtb0YZp3gTsOJxGA/F/rDqFiTbkSNpksf
	o87T5dlOhOQw6DgT/BFKm+fFuPkMcVy2WUREqt9tALowjdndI4yml5NfYwBsf4GbrPqOQc
	Nb3FWLbRx91/yzIYSdBkxGTJu8qBuri8hCjifQgJA6XCMQqZcyTsKGhVav5p8dSad4HA/D
	hutOrhvFAWm8xE3O46Le824Zu9SyUznwLIro66O/JcAMYyBX72ut8kO7dLjOXQ==
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
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next 1/8] netlink: specs: add phy-index as a header parameter
Date: Tue,  9 Apr 2024 12:58:39 +0200
Message-ID: <20240409105847.465298-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409105847.465298-1-maxime.chevallier@bootlin.com>
References: <20240409105847.465298-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the spec to take the newly introduced phy-index as a generic
request parameter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/netlink/specs/ethtool.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 87ae7b397984..e8bdad790e3d 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -35,6 +35,9 @@ attribute-sets:
         name: flags
         type: u32
         enum: header-flags
+      -
+        name: phy-index
+        type: u32
 
   -
     name: bitset-bit
-- 
2.44.0


