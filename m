Return-Path: <linux-kernel+bounces-130360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDE897727
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9061F305F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B75116EC13;
	Wed,  3 Apr 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3YIPSlc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4A16F0C4;
	Wed,  3 Apr 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164830; cv=none; b=hp4HMrAtvkcVzgdzqMjSZ2IT0/kq/MB/ndCI6tftH1srIFZR+AViBZYGfwWDaLZMf6Acjy7MB2fLON5bANedksxtBkrZDyQCsT8vKdQYaJuZSirkysBAEKBXF8aSeXrYVtD6lR53/1eavaBYPx9gjMy7knfbXI1DZK2AMEGRcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164830; c=relaxed/simple;
	bh=o49i2HRpGmENRZOmW5HyumZmH5YGPVN4D+RsSg07KeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqOItg8k+7muzgAATiNFmHy6nTk38yGIAgFbAlg8EfNQsJGi1WhOlhgvvsNcxE3r+Eqz2xDflVsmy0PDlZEqdmqNZdxnOKnZ75N/uKNKIyiH7eRaEcgsc1yrg8E2OHg4Ij1yZE8uB+J0j87hNlokxhz8r3zYiKlBuTufkQhKa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3YIPSlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6AAC433B1;
	Wed,  3 Apr 2024 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164830;
	bh=o49i2HRpGmENRZOmW5HyumZmH5YGPVN4D+RsSg07KeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3YIPSlcc0fs1gb0sTXgsxdSSL8qif0KexYeuPD/wX7DXFbO2lKwgFWkuLilMHnJw
	 V+CWuFA5SaLSdX17/EupzUllxu4GhDz+OpZslgwPWzHP3pdo+7kgNpfPQWwBPqxZzX
	 fxbD5/sks8KMQDfR3FD81L8rMUZFbPDE+JVtVEPer6ksrLC3T1QxbmnsYopcQ5pZ38
	 pyTPWg0kndgoBrMDizN4n9AOHz70+DYqTXQoiXn5JmSmYuRjjfq0mcLUtMvn2yge+v
	 barsMz15Z10zVn0BGFYRLUbeJgTEfl0bqs/oDrCgVtgwFp8wvdIkaJlSdG3iNGQkMC
	 OOCQgbSo+qydw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rdbabiera@google.com,
	festevam@denx.de,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/6] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Wed,  3 Apr 2024 13:20:19 -0400
Message-ID: <20240403172026.353926-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172026.353926-1-sashal@kernel.org>
References: <20240403172026.353926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index ccb72875c8ee5..c11c2f71521ce 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -634,6 +634,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.43.0


