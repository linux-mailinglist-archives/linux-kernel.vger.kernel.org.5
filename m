Return-Path: <linux-kernel+bounces-139777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B658A0794
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53E52874A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154CE13C81D;
	Thu, 11 Apr 2024 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="WjuapCUO"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CB1C0DE7;
	Thu, 11 Apr 2024 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813030; cv=none; b=b1PTsdqVv8aeJiWLF4yWYxyQAQJeCAs1x4KJ31deKnaO8fYB7X1WH8FgRHFTSMJguin0kLBW5kc3mtYBCekaaZP8TlNkzp/dK1WiEBJRPnTKSToBTGttFj6QAgvnAlfWKZc2H1bJl7iI+gZ8JtfH53833Get4K04Wtil2gR6fwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813030; c=relaxed/simple;
	bh=6jjiVUe5YOImZgDXsgqmOEfi4ySQyj03YKG67dWJEeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4MtK7t0tXqlLShVRB44qRjW0zIWgEsoozE4AATJiUymoYQFEsoKBdiAQO7V2DMAH0Ehx/Zkhqo/B+e1obWvJ9fqjPYRuYQ6x7Tx+sUBzQMJRG+vvCnl26FAkNE5O1bq4pnVo69cgKg/53Wz28zELEkvpaXQCxYRN+4JxjpP/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=WjuapCUO; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 3263D6084E;
	Thu, 11 Apr 2024 05:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712813027;
	bh=6jjiVUe5YOImZgDXsgqmOEfi4ySQyj03YKG67dWJEeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjuapCUOaPmI6mMcntHJh0h7Tw3CbxrAK7bFbtSgt11qvgmzL+eIoNUDuYl0KdB6C
	 Yp5+C4OH3F/1EJD60oTzsLmAS1a++DtJZUTwfJKxmqwjbC8J165ItaK0YXtWvGAsxp
	 blYPjJl92F7juHYRbc+47ovz+yhyr64I7BAsuBBdRJBqWgwgtA4Ieea2AUrs9SBSMW
	 6OtsegoXqctpLLdraMgxjk0/aE8y6adiP/UKwhHQ4kHRVHuYDKc9P7zzIyx2wLo2kQ
	 1pjVcf7LgV450oaCF5U/U6VaBE2yNBbLlJyTcyCRCXJNGK9f2HdbimRDAYCNQj4z4I
	 mUFKHEwj+JSxA==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 1/4] reset: Fall back to lookup if no reset node is found
Date: Thu, 11 Apr 2024 08:22:54 +0300
Message-ID: <20240411052257.2113-2-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411052257.2113-1-tony@atomide.com>
References: <20240411052257.2113-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fall back to lookup if the reset node does not exist. When creating and
removing subdevices on an interconnect, the parent device may provide
resets for the children using struct reset_control_lookup instead using
devicetree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/reset/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1141,12 +1141,17 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, bool shared, bool optional,
 					  bool acquired)
 {
+	struct reset_control *rstc;
+
 	if (WARN_ON(shared && acquired))
 		return ERR_PTR(-EINVAL);
 
-	if (dev->of_node)
-		return __of_reset_control_get(dev->of_node, id, index, shared,
+	if (dev->of_node) {
+		rstc = __of_reset_control_get(dev->of_node, id, index, shared,
 					      optional, acquired);
+		if (!(IS_ERR(rstc) && PTR_ERR(rstc) == -ENOENT))
+			return rstc;
+	}
 
 	return __reset_control_get_from_lookup(dev, id, shared, optional,
 					       acquired);
-- 
2.44.0

