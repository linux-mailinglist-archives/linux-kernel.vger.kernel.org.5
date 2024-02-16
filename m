Return-Path: <linux-kernel+bounces-68912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEAE8581D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964722828D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0FB130E48;
	Fri, 16 Feb 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZbSlHd+0"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71112F5AE;
	Fri, 16 Feb 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098788; cv=none; b=UVqWo4ikJwFwArGq9icAJ8JDXefMbPCZjZU7ki7LvWL+MBdjg5idhKD9mQNDtMfNR7O0SGhwTDDAmrx9iqfBKjL/I8bH8juQqRqcPseCrefLGYgGwAKkuYwKuOZc8kQJwctgyTKVvlw2LPrMdBoQ2fZqDMHSstdd74Po5Up0fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098788; c=relaxed/simple;
	bh=Fbj/2gyrWNa39AIruWxAlw+xq5h9FHnRkUSzy2mwA8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/AeCO7G8cQ0mWY8LNyEX9cjc2lVJPbsXaWTt2urxEaR7H+F9IfyJ8fuho+BhHM3xvwCdnZGfjyqqrBacpdDhdh5XOjz27fNri1up/BDpBYMNfpsxPjc91uxz+JhWcocjfk19cxwlS78kAMU/prulJGYc7D0kIhOhApkEL3/dDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZbSlHd+0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20AC3240005;
	Fri, 16 Feb 2024 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UZnngXwdr0LC2jpI0/oTtXDE8jw/GJHgrZURo6q588=;
	b=ZbSlHd+0aB3h/GrrffTuYcFRaGxCn38xYLNSY/j/NYuJeOlPzViqvkWxzm79QjKHiXk2or
	T17wMlrrgkctata2xwS582yJfd4svlhL1thE44yEfA3za6Y8KpJHeYneILVQI7hMSGs2EZ
	EDoy1UUl+qymthuAoag4LFRHuDvvOoQbMlPZzN7rOtj2dENYLppVraXvTJ8dmdIkNAzwBs
	wJkCuTW52WFBkFsZwpEdqV62QXISuQZNp+ipEQtTkRxevmIDkS9d8/CIHHJEe1dkNw1h9J
	5Y2hnnKGb9XN3Wk3nQM8DWxkGh1VVETL1iwYNHAiQ8bebxRt6uk8a9PrVnXFzQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:19 +0100
Subject: [PATCH RFC net-next v8 01/13] net_tstamp: Add TIMESTAMPING
 SOFTWARE and HARDWARE mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-1-510f42f444fb@bootlin.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Timestamping software or hardware flags are often used as a group,
therefore adding these masks will easier future use.

I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
not use at all.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v7:
- Move the masks out of uapi to include/linux/net_tstamp.h
---
 include/linux/net_tstamp.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index eb01c37e71e0..3799c79b6c83 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -5,6 +5,14 @@
 
 #include <uapi/linux/net_tstamp.h>
 
+#define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
+					 SOF_TIMESTAMPING_TX_SOFTWARE | \
+					 SOF_TIMESTAMPING_SOFTWARE)
+
+#define SOF_TIMESTAMPING_HARDWARE_MASK	(SOF_TIMESTAMPING_RX_HARDWARE | \
+					 SOF_TIMESTAMPING_TX_HARDWARE | \
+					 SOF_TIMESTAMPING_RAW_HARDWARE)
+
 enum hwtstamp_source {
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,

-- 
2.25.1


