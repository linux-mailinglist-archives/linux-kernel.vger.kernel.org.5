Return-Path: <linux-kernel+bounces-115153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8B889329
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3111F2F6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0269F3041A9;
	Mon, 25 Mar 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3yV1K59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21C18274C;
	Sun, 24 Mar 2024 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324174; cv=none; b=sOvd43h0acTu58gJn9efhb0E1/1i0Up8O5M2FJoacaAL0DdXFzugWemuHkuwHd8zzA8Y0nG/VKUbxC+lvUKbXUXut0zqqVQlsi1oBA8M7xj7a8t8uM04i1yojd6p5ebmSR9CEyNQIQzmHl7Rm0Y2qGbzwXpbKPTaCYZJfr82rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324174; c=relaxed/simple;
	bh=gTEIx53Lg9NHoGicBRiMsdfaDzGWKuRbLE9XgKQJHp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rje9ByGxV62PIDlfSlCvhiER2YbacqpxDkwtGdJuld2E19E9V+Fee3O8IcdBSrRGX071D6MWIJ94sRl/eRoZAGRH/BHFM+Li1od/GgODNoCGcac+30yc4n4Lnbiu6zHaQ6ZYdsY35akMRR6e2+Ua0sIECcthNx9EYEvMXKDtq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3yV1K59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1E2C43399;
	Sun, 24 Mar 2024 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324174;
	bh=gTEIx53Lg9NHoGicBRiMsdfaDzGWKuRbLE9XgKQJHp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3yV1K59zCf1/KJROa8baMmD0Zz14f65oShiykRjA0Or+fed2x8VZP2tnyyrTojxa
	 vv123Fz8G/JzLwSDeV1kicC7dBcez2a6wwPFIOsx1z0qOObPNnSmjyRUxqOaXlUOgE
	 zqmtx63ypeSF4/wWGo6fi2btMgHqIpOB7vnOXQTnjEG/+2JEOHQC8ps5nkQwTOqA7N
	 akL5RWXFuZi9E1g2iW9d+1vRK+tvwaMApzziEeb/8U8LH0pb2m921Xsatc1cJD9IkY
	 G2kLxWI+HosAnFsZQ2WNlpSEHhUIhRJakRcFVeva/cXX+vIJJPg8fvReUk+dqWv1HZ
	 KALPFCA/rhOhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 166/183] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 19:46:19 -0400
Message-ID: <20240324234638.1355609-167-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 73b5a5c00be39e23b194bad10e1ea8bb73eee176 ]

It seems a copy&paste mistake that suspend callback removes the GPIO
device. There is no counterpart of this action, means once suspended
there is no more GPIO device available untile full unbind-bind cycle
is performed. Remove suspicious GPIO device removal in suspend.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240219150627.2101198-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 93367dea4d8a5..0dfe9ceb032a5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -639,6 +639,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -653,10 +654,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
 		if (priv->line[i] >= 0)
 			serial8250_suspend_port(priv->line[i]);
 
-	/* Ensure that every init quirk is properly torn down */
-	if (priv->board->exit)
-		priv->board->exit(pcidev);
-
 	return 0;
 }
 
-- 
2.43.0


