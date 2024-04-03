Return-Path: <linux-kernel+bounces-130287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1289766C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC5028B62D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50C156F31;
	Wed,  3 Apr 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1h/M4uu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED3156C7A;
	Wed,  3 Apr 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164646; cv=none; b=TTbs2WngwZmuNXB5XAjoZAyt9hmk3OvW5qXls+D/vFTqc0p8dtbX2wQyF6RjRxK95cNDz4fEtleF53jsPnyI9qnrnipjA00lnIaGEREdOdE+Esmp1agrnkwM+BALl2opm35shwJjuJ0A/LJH8uuYO1l1VEQBSmoq8PPxI15hFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164646; c=relaxed/simple;
	bh=paWaZtmcXgHCCM0Kdr/8NGNi2OLdGEnwir78cGBYVFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3/t2ZncCnWhNO0IrgTFydmP23vNcl31YfiIeWUlR89ygP/6FAq8PxF1C+FITgp4BOPjDAmWtryZlGXobx3UCaARkIcxb0ns6zxPdiPaX7UR0H6NEjTTOJh5C6Zwltumfew0WyCnohcaMB2rGsw5uaxSJZkU8buOJuoji1RTFCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1h/M4uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ED6C433C7;
	Wed,  3 Apr 2024 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164645;
	bh=paWaZtmcXgHCCM0Kdr/8NGNi2OLdGEnwir78cGBYVFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1h/M4uuLvOqT6LAD/i9UgXU3jy7yVS9KYwOyZZVM7FQk1Z8XfaiTLJPycDQIpII8
	 0XjmJw7Co5CFDiB9zXhzMjjMSU0MIGxcH3OeXeIC5e9rRR976RaveSaba92bWexUH3
	 BKJTnciIvlQdXjVq97NBobIR2aCQsGWNZm3J9dWzwT63OMyLENfCffJzP2I+/zbsWO
	 /xpikFYLS6+mmGqNSCOwDlW76OEymbGNVCZdjOLlIVXlW4syiw4gbPlToQtO44uQ5B
	 bWjFyXEkcDzXS9eL2bU7pTIVqgJkCWYkJsErmugB2A2DUP9tU7TyO4bl05xX9Muggm
	 mjxLMClEzFl/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rdbabiera@google.com,
	linux@roeck-us.net,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 13/28] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Wed,  3 Apr 2024 13:16:15 -0400
Message-ID: <20240403171656.335224-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 8774ea7a553e2aec323170d49365b59af0a2b7e0 ]

The driver already support the tcpci binding for the i2c_device_id so
add the support for the of_device_id too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240222210903.208901-3-m.felsch@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 0ee3e6e29bb17..7118551827f6a 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -889,6 +889,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.43.0


