Return-Path: <linux-kernel+bounces-102914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99E87B851
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770C7282DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01561079D;
	Thu, 14 Mar 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="TocRm+yk"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD78FC09
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400259; cv=none; b=l08IV9piAZHSLPrRt8Gh/6DZ+eMoE9yZ2191fYZRAjlCIgSYl7zUky1z8vw9wkM4jnVlpXNlLNdrcNWNKWedI99jVqgo42pxsq/6ZJcJaJXzAW4y9YLaeAxiKvlyyGggO47SGtEYWLl7uoSJYn+Mbt5eyrUnjGw8ibJw6K45TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400259; c=relaxed/simple;
	bh=lBKWNCjz5XeMeeVLKV0cVIhl8GuROrhj8AxVnzf8uiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vd8ab28qLWGr7wvfiInxGUy5JVw77dOQ+KMwK6GhZL5OEo/DRjmDJ7yn4SDIQiB999A5LGNrOgAlNkQQEehf/5ppmowVNt5JJrYgE6ogpCZdRRbkksttlTlBiqyh3XApGcV5HBqaT0IMUGb+4VRHQwc79IGvFM0FEFsHAQL26xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=TocRm+yk; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BF1111E7BE;
	Thu, 14 Mar 2024 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1710399888; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hLJvt3Qp8v0w1uJwmrYsCccfbrCeUtcFvurCzwm/ryk=;
	b=TocRm+ykLpsCPYqYE3T8hXjKqsA0qwqUm+Ix5gLl6uNOAbZB72Po7n33jRx7zTiORf7ShR
	u3zi4USJSHrPz/Vsf+6hYo+g8TntR1ygN1Sj6KHURB9ecA5X+m73MQcz7RCi+SHIoS28Rr
	+alHsA339XTBGZL8LJ+d2RpMdgibR7WN7pojCMP/UZjOZdrdo87hHVtN/r7iRWQRyXoEHp
	s6K6YueDssjm+SktCobZ5m9J/gX1XyXpC6OVvv7JGWNpjA8GpgdKdlnJ6ihpaXjYTlBEfV
	ffPjWWPMdbND5UbsRSL4Fu7mseRwps4ftLw+3e3Z+5yrPMAGSQKjR+k/DRzHag==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 3/4] soc: amlogic: meson-gx-socinfo: add new definition for Amlogic A113X package
Date: Thu, 14 Mar 2024 09:59:53 +0300
Message-ID: <20240314070433.4151931-4-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314070433.4151931-1-adeep@lexina.in>
References: <20240314070433.4151931-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add new definition for Amlogix A113X soc found in JetHub D1/D1+ devices.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/soc/amlogic/meson-gx-socinfo-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
index 3ebb80972fc7..2028101bb9b2 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo-internal.h
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -78,6 +78,7 @@ static const struct meson_gx_package_id {
 	{ "962X", 0x24, 0x10, 0xf0 },
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113X", 0x25, 0x43, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905Y2", 0x28, 0x30, 0xf0 },
-- 
2.43.2


