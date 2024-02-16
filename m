Return-Path: <linux-kernel+bounces-68909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A78581CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52E41C21865
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3B12FF6B;
	Fri, 16 Feb 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gdSnkKdC"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9F12F58A;
	Fri, 16 Feb 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098786; cv=none; b=td3FSe5buf/8SrUgkK7f0+++lxHuiF+CTQ6WN9c8EjmutthMXaDNj/pz7Ylc1Y1YFb5gRl8M1KjBrB7uw8Ue6bOmfyPJtvmvHOMXjSyURuN/0atTJho4c1v+a1hfrWj8UYZ7GOpwHKrQlexCp3F6TBwFn9QPtUrVgQvYuvSJkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098786; c=relaxed/simple;
	bh=V4PCxhGFH/jAAOAVBdY7uV5Loj9ZYxch0/IxD1tU438=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H902W9PEHYAnhJu5QcQ89zK7J+lF9n/uPFNrn/lGn3DhykoBsvB2CFjchMWmL5tdz41qxsB4+QJSrV/RXGDBFPCTEsLf6i2nHeHlCKrzBeBkItZZn5043T/kqyyyV+EykzmJVBXv6AJqmAVakSi3NRrptyr7DAYU0UeH9U/scYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gdSnkKdC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED3C3240008;
	Fri, 16 Feb 2024 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04SFsb4YU2FLhX8c3BxjY03HBAIbE1GiOjr4sY7glFo=;
	b=gdSnkKdC8MDHGhmseptmYi7uQcOpt+2+nGF7b176TtpsvoCUMXpH1gQnMYikSsEzZWVgns
	s6wTqDapPaEo7bDjQ8pIeXUJp7N+waY+9YdFtYKy4F4g+7Z3JqpD7sCypPthb1b6JddOrg
	2TMLuPUvAC0OhKrNdCz5r/sdqYF/n3dvXAvH46tuKwAyTC/+4s9fCQn/foh2caMhIanw4t
	uijtVb53YhicB0Ahz64zQEOc5ccwTNslmCsziEPUGViHbZDCmar1YVQniayevymRMUsnhr
	L33Iqr//g5cvesrR0HpNEnxt4R2NRAbpAOCFRs2xmzWPRZniPIGLQCmGMYjscA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 16 Feb 2024 16:52:23 +0100
Subject: [PATCH RFC net-next v8 05/13] net: net_tstamp: Add unspec field to
 hwtstamp_source enumeration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-feature_ptp_netnext-v8-5-510f42f444fb@bootlin.com>
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
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Prepare for future support of saving hwtstamp source in PTP xarray by
introducing HWTSTAMP_SOURCE_UNSPEC to hwtstamp_source enum, setting it
to 0 to match old behavior of no source defined.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/net_tstamp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 3799c79b6c83..662074b08c94 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -14,6 +14,7 @@
 					 SOF_TIMESTAMPING_RAW_HARDWARE)
 
 enum hwtstamp_source {
+	HWTSTAMP_SOURCE_UNSPEC,
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,
 };

-- 
2.25.1


